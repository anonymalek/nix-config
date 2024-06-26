{ pkgs, ... }:
{
    packages = with pkgs; [
		jetbrains.rider
		jetbrains-toolbox
    ];
    
    allowedUnfree = [
    	"jetbrains-toolbox"
        "rider"
    ];
}

