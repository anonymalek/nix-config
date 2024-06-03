{ config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
		discord
    ];
    
    allowedUnfree = [
        "discord"
    ];
}