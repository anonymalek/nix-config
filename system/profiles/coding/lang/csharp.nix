{ pkgs, ... }:
{
	packages = with pkgs; [
		dotnet-sdk_8 nuget
	];
}
