{ pkgs, ... }:
{
    packages = with pkgs; [
		vscode
    ];
    
    allowedUnfree = [
        "vscode"
    ];
}

