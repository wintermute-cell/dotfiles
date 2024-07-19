{ lib, buildGoModule, fetchFromGitHub, go, glibc, pkgs }:

buildGoModule rec {
  pname = "timetrace";
  version = "0.14.3";

  src = fetchFromGitHub {
    owner = "dominikbraun";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-qrAel/ls2EKJSnKXjVC9RNsFaaqGr0R8ScHvqEiOHEI=";
  };

  # Set vendorSha256 for dependencies
  # Use `nix-prefetch` or `nix build --impure .# -L` to get the hash
  vendorHash = "sha256-bcOH/CLCQBIG5d9XUtgIswJd+g5F2imaY6LdqKdvfHo=";

  buildInputs = [ go glibc pkgs.patchelf ];

  #nativeBuildInputs = [ ];

  # Enable this if the package has tests and you want to execute them
  doCheck = false;

  preBuild = ''
    export CGO_ENABLED=0
  '';

  dontPatchELF = true;
  dontStrip = true;

  # Install Phase
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r ./${pname} $out/bin
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/timetrace
    runHook postInstall
  '';

  modRoot = ".";
  
  postInstall = ''
  '';

  postFixup = ''
    mkdir -p $out/share/zsh/site-functions
    # this hack is needed, otherwise the program tries to create $HOME which
    # nix points to the nonexisting /homeless-shelter and crashes because of
    # permission issues. See: https://github.com/NixOS/nixpkgs/issues/62495
    export HOME=$TEMPDIR
    $out/bin/${pname} completion zsh > $out/share/zsh/site-functions/_${pname}
  '';

  meta = with lib; {
    description = "A simple CLI for tracking your working time.";
    homepage = "https://github.com/dominikbraun/timetrace";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}

