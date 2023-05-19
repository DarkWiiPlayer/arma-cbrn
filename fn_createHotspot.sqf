/*
Author: DarkWiiPlayer
Description: Sets the required variables to a hotspot for the contamination script
License: Unlicense
Parameters:
	- Object or position
	- Type ("biological", "chemical", "radiation", "fallout")
*/

private _target = param[0, objNull, [objNull, []]];
private _type = param[1, "radiation", [""]];
private _strength = param[2, 1, [0]];

private "_hotspot";

if (_target isEqualType []) then {
	_hotspot = createGroup SideLogic createUnit ["Logic", _target, [], 0, "NONE"];
} else {
	if (isNull _target) exitWith {};
	if (_target isKindOf "Logic") then {
		_hotspot = _target;
	} else {
		_hotspot = createGroup SideLogic createUnit ["Logic", _target, [], 0, "NONE"];
		_hotspot setPosATL (getPosATL _target);
	};
};

_hotspot setVariable ["cbrn_hotspot_type", _type, true];
_hotspot setVariable ["cbrn_hotspot_strength", _strength, true];

_hotspot

/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
