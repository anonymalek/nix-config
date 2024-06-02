{ config, pkgs, ... }:
{
	inherit (
	    import ./_profile.nix { 
            username = "alek";
            realname = "Artificio";
            modules = [
                ./core/virtualization.nix
                ./core/desktop-tools.nix
                ./core/desktop.nix
                ./core/global.nix
                
                ./coding/rider.nix
                ./coding/basic.nix
                
                ./network/anonymous.nix
                ./network/zerotier.nix
                ./network/nordvpn.nix
                
                ./games/steam.nix
            ];
	    }
    );
    
    environment.systemPackages = with pkgs; [
        github-desktop
        discord
        brave
        fish
    ];
}