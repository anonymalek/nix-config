{ config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
		jetbrains-toolbox
		jetbrains.rider
    ];
    
    allowedUnfree = [
    	"jetbrains-toolbox"
        "rider"
    ];
}