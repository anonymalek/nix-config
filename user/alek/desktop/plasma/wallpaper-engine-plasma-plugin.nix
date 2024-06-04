{ mkDerivation
, fetchurl
, cmake
, extra-cmake-modules
, plasma-framework
, gst-libav
, mpv
, websockets
, qtwebsockets
, qtwebchannel
, qtdeclarative
, qtx11extras
, vulkan-headers
, vulkan-loader
, vulkan-tools
, pkg-config
, lz4
}:
mkDerivation rec
{
	name = "wallpaper-engine-kde-plugin";
	version = "v0.5.5-nixos";
	cmakeFlags = [ "-DUSE_PLASMAPKG=OFF" ];
	nativeBuildInputs = [ cmake extra-cmake-modules pkg-config ];
	buildInputs = [ 
		plasma-framework mpv qtwebsockets websockets qtwebchannel
		qtdeclarative qtx11extras lz4
		vulkan-headers vulkan-tools vulkan-loader
	];

	src = fetchurl {
		url = "https://longc.top/wallpaper-engine-kde-plugin.tar.gz";
		sha256 = "8mb9ro4OH1VpwmryvZjsld2xt5k5tUMJrf0RY4psCBg=";
	};
}