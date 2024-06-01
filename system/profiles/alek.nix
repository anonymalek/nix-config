{ config, pkgs, ... }:
{
	inherit (
	    import ./base_profile.nix { 
            username = "alek";
            realname = "Artificio";
            modules = [
                ./virtualization.nix
                ./anonymous.nix
                ./global.nix
                
                ./desktop.nix
                ./desktop-tools.nix
                
                ./rider.nix
                ./code.nix
                
                ./zerotier.nix
                ./nordvpn.nix
                
                ./steam.nix
            ];

			home-modules = [ ./../../user/alek/home.nix ];
	    }
    );
    
    environment.systemPackages = with pkgs; [
        github-desktop
        brave
    ];
}
