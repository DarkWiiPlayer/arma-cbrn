class Distribution {
	class chemical {
		goggles = 1;
	};
	class biological {
		goggles = 2;
		uniform = 1;
		backpack = 2;
	};
	class radiation {
		goggles = 1;
		uniform = 6;
		backpack = 0;
	};
	class fallout {
		goggles = 2;
		uniform = 3;
		backpack = 2;
	};
};

class Protection {
	class U_B_CBRN_Suit_01_MTP_F    { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class U_B_CBRN_Suit_01_Tropic_F { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class U_B_CBRN_Suit_01_Wdl_F    { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class U_I_CBRN_Suit_01_AAF_F    { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class U_I_E_CBRN_Suit_01_EAF_F  { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class U_C_CBRN_Suit_01_Blue_F   { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class U_C_CBRN_Suit_01_White_F  { chemical = 1; biological = 1; radiation = 0; fallout = 1; };

	class G_Respirator_white_F  { chemical = .8; biological = 1; fallout = 1; };
	class G_Respirator_yellow_F { chemical = .8; biological = 1; fallout = 1; };
	class G_Respirator_blue_F   { chemical = .8; biological = 1; fallout = 1; };

	class G_AirPurifyingRespirator_01_F       { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class G_AirPurifyingRespirator_02_black_F { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class G_AirPurifyingRespirator_02_olive_F { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class G_AirPurifyingRespirator_02_sand_F  { chemical = 1; biological = 1; radiation = 0; fallout = 1; };

	class B_CombinationUnitRespirator_01_F { chemical = 1; biological = 1; radiation = 0; fallout = 1; };
	class B_SCBA_01_F                      { chemical = 1; biological = 1; radiation = 0; fallout = 1; };

	// Helmets aren't considered by the script, but in case that ever changes:
	class H_Shemag_olive    { chemical = .2; biological = .3; fallout = .4; };
	class H_Shemag_olive_hs { chemical = .2; biological = .3; fallout = .4; };
	class H_ShemagOpen_khk  { chemical = .2; biological = .3; fallout = .4; };
	class H_ShemagOpen_tan  { chemical = .2; biological = .3; fallout = .4; };
	class H_HelmetO_ViperSP_hex_F  { chemical = 1; biological = .4; radiation = 0; fallout = 1; };
	class H_HelmetO_ViperSP_ghex_F { chemical = 1; biological = .4; radiation = 0; fallout = 1; };

	class H_Hat_Tinfoil_F { brainwave = 1; };
};
