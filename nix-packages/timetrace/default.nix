{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "timetrace";
  version = "0.14.3";

  src = fetchFromGitHub {
    owner = "dominikbraun";
    repo = pname;
    rev = "v${version}";
    sha256 = lib.fakeHash;
  };

  # Set vendorSha256 for dependencies
  # Use `nix-prefetch` or `nix build --impure .# -L` to get the hash
  vendorSha256 = lib.fakeHash;

  # Enable this if the package has tests and you want to execute them
  doCheck = false;

  # Install Phase
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r ./timetrace $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "A simple CLI for tracking your working time.";
    homepage = "https://github.com/dominikbraun/timetrace";
    license = licenses.apache20;
    maintainers = [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}

