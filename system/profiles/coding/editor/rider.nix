{ config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
		jetbrains.rider
    ];
    
    allowedUnfree = [
        "rider"
    ];
}