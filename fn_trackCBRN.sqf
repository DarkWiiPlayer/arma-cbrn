/*
Author: DarkWiiPlayer
Description: Scans the subject surroundings for environmental hazard hotspots and applies negative status effects accordingly
License: MIT
Parameters:
	- Subject
	- Scan radius [500 meters]
	- Tick interval [1 second]
Subject Variables:
	- Radiation
*/

params [
	["_subject", player, [objNull]],
	["_radius", 500, [0]],
	["_tick", 1, [0]]
];

if (!canSuspend) exitWith {};

private _hurt = {
	param[0] setDamage (damage param[0] + param[1]);
};

private _protection = {
	params [
		["_type", "chemical", [""]],
		["_player", player, [objNull]]
	];

	private _config = missionConfigFile >> "CfgCBRN";
	private _protection = 0;

	private _distribution = _config >> "Distribution" >> _type;
	if (isClass _distribution) then {
		private _summ = getNumber (_distribution >> "uniform") + getNumber (_distribution >> "goggles") + getNumber (_distribution >> "backpack");
		_distribution = [
			getNumber (_distribution >> "uniform"),
			getNumber (_distribution >> "goggles"),
			getNumber (_distribution >> "backpack")
		] apply { _x / _summ };
	} else {
		_distribution = [1, 1, 1];
	};

	{
		private _itemProtection = _config >> "Protection" >> (_x select 0) >> _type;
		_protection = _protection + (getNumber _itemProtection) * (_x select 1);
	} forEach [
		[uniform  _player, _distribution select 0],
		[goggles  _player, _distribution select 1],
		[backpack _player, _distribution select 2]
	];

	0 max _protection min 1;
};

// "chemical_detector" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];

diag_log format ["[CBRN] Started tracking: %1", _subject];
while { true } do {
	if (!alive _subject) exitWith { diag_log format ["[CBRN] Stopped tracking %1: unit is dead", _subject] };

	private _hotspots = _subject nearObjects [ "logic", _radius ]
		select { !isNil { _x getVariable "cbrn_hotspot_type" } };

	_subject setVariable ["hotspots", _hotspots, true];

	private _exposure_chemical = 0;
	private _exposure_biological = 0;
	private _exposure_radiation = 0;
	private _exposure_fallout = 0;

	{
		private _type = _x getVariable "cbrn_hotspot_type";

		private _strength = _x getVariable "cbrn_hotspot_strength";

		private _distance = (_subject distance _x);

		{ _subject setVariable [_x, 0, true] } forEach ["cbrn_exposure_radiation", "cbrn_exposure_chemical"];

		switch (_type) do {
			case "chemical": {
				private _damage =
					// Linear falloff
					(0 max (_strength * 100 - _distance) / 100)
					* (1 - ([_type, _subject] call _protection));
				[_subject, _damage * _tick] call _hurt;
				_exposure_chemical = _exposure_chemical + _damage;
			};
			//case "biological": {};
			case "radiation": {
				private _dosage = 
					// Inverse-square falloff
					_strength / (_distance max 1) ^ 2
					* (1 - ([_type, _subject] call _protection));
				_exposure_radiation = _exposure_radiation + _dosage;
			};
			//case "fallout": {};
			default { diag_log format ["[CBRN] Hotspot type '%1' not implemented, ignoring", _type]; };
		};
	} forEach _hotspots;

	_subject setVariable ["cbrn_radiation_dosage", (_subject getVariable ["cbrn_radiation_dosage", 0]) + _exposure_radiation * _tick, true];

	_subject setVariable ["cbrn_exposure_chemical", _exposure_chemical, true];
	_subject setVariable ["cbrn_exposure_biological", _exposure_biological, true];
	_subject setVariable ["cbrn_exposure_radiation", _exposure_radiation, true];
	_subject setVariable ["cbrn_exposure_fallout", _exposure_fallout, true];

	// private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
	// private _obj = _ui displayCtrl 101;
	// _obj ctrlAnimateModel ["Threat_strength_Source", (ceil _total / 10) min 9.9, true];

	private _dosage = _subject getVariable ["cbrn_radiation_dosage", 0];
	if (_dosage > 1) then {
		[_subject, (sqrt _dosage / 10) / 100] call _hurt;
	};
	_subject setVariable ["cbrn_radiation_dosage", (_dosage - _tick * 0.0001) max 0, true];

	sleep _tick;
}

/*
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
