{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
    		element-desktop
    		gomuks
    
    		weechat
    		irssi
    
    		profanity
    
    		mumble
    	];	
}
