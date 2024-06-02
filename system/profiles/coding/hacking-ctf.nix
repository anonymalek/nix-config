{ config, lib, pkgs, ... }:
{
	imports = [ ./tor.nix ];

	environment.systemPackages = with pkgs; [
		# utils
		util-linux
		busybox
		libllvm
		exploitdb
		clang-tools
		libclang
		binwalk
		openvpn
		python3
		cryptsetup
		qemu
		gcc
		gnumake
		i2c-tools
		fping
		openssl
		gnupg
		git
		spooftooph
		macchanger
		exifprobe
		ssldump
		mongodb-tools
		mariadb
		fuse3
		gnuradio
		hashdeep
		powershell
		netcat
		pwnat
		pwncat
		ventoy

		p7zip
		fcrackzip
		unar

		openssh
		sshfs
		inetutils
		atftp
		curlftpfs

		# recon
		dig
		whois
		nmap
		rustscan
		dirb
		dirbuster
		gobuster
		sqlmap
		smbmap
		ike-scan
		arping
		arp-scan
		cewl

		# reverse engineering
		gdb
		dex2jar
		ghidra-bin
		apktool
		
		# action
		evil-winrm
		ubertooth
		hashcat
		thc-hydra
		steghide
		john
		armitage
		asleap
		radare2
		wireshark
		aircrack-ng
	];
}
