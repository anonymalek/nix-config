{ pkgs, ... }:
{
	packages = with pkgs; [
        (retroarch.override {
			cores = with libretro; [
				ppsspp
				mupen64plus
				citra
				desmume
				bsnes
				mgba
			];
		})
    ];
}
