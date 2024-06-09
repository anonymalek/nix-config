{ config, pkgs, musnix, ... }:
{
	imports = [ ./pipewire.nix ];
	
	services.pipewire = {
		jack.enable = true;
	};
	
	environment.systemPackages = with pkgs; [ libjack2 jack2 qjackctl pavucontrol libjack2 jack2 qjackctl jack2Full jack_capture ];
	
	musnix = {
		enable = true;
		alsaSeq.enable = false;
		
		# Find this value with `lspci | grep -i audio` (per the musnix readme).
		# PITFALL: This is the id of the built-in soundcard.
		#   When I start using the external one, change it.
		soundcardPciId = "00:1f.3";
		
		# magic to me
		rtirq = {
			# highList = "snd_hrtimer";
			resetAll = 1;
			prioLow = 0;
			enable = true;
			nameList = "rtc0 snd";
		};
	};
}