{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
    (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            libGL
            xorg.libX11
            xorg.libXi
            xorg.libXi
            xorg.libXcursor
            xorg.libXrandr
            xorg.libXinerama
            wayland
            libxkbcommon
            gcc
            gdb
            bear
            clang-tools
            reaper
          ];
          shellHook = '''';

          LD_LIBRARY_PATH = with pkgs; "LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [
            libGL
            gtk3
            qt5.full
            zlib
            krb5
            glib
            patchelf
            readline
            stdenv.cc.cc
            libGL
            zlib
            glib # libgthread-2.0.so
            xorg.libX11 # libX11-xcb.so
            xorg.libxcb # libxcb-shm.so
            xorg.xcbutilwm # libxcb-icccm.so
            xorg.xcbutil # libxcb-util.so
            xorg.xcbutilimage # libxcb-image.so
            xorg.xcbutilkeysyms # libxcb-keysyms.so
            xorg.xcbutilrenderutil # libxcb-renderutil.so
            xorg.xcbutilrenderutil # libxcb-renderutil.so
            dbus # libdbus-1.so
            libxkbcommon # libxkbcommon-x11.so
            fontconfig
            freetype
            cairo
          ]}";
        };
      }
    );
}
