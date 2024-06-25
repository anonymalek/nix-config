{ pkgs, ...}:
{
    packages = with pkgs; [
		discord
    ];
    
    allowedUnfree = [
        "discord"
    ];
}
