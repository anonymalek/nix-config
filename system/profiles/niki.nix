{ config, pkgs, ... }:
{
	inherit (
	    import ./base_profile.nix { 
            username = "niki";
            realname = "Niki";
            modules = [
                ./global.nix
                ./anonymous.nix
                
                ./desktop.nix
                ./desktop-tools.nix
                
                ./code.nix
                
                ./zerotier.nix
                
                ./steam.nix
            ];

			home-modules = [ ./../../user/niki/home.nix ];
	    }
    );
    
    environment.systemPackages = with pkgs; [
        github-desktop
        brave
    ];
}
