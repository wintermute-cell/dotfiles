{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "markdown-flashcards";
  version = "2.0.0";
  
  src = fetchFromGitHub {
    owner = "bttger";
    repo = "markdown-flashcards";
    rev = "v${version}";
    sha256 = "sha256-7fTsup/D9xCpB+Zu2geHhejD2qM5C65kzsVxPq8e0vo=";
  };
  
  vendorHash = "sha256-eEhD93+BAiz6wtEbNhQ3GgMf5bn5YAMcoHfjHjZVS7M=";

  modVendorFlags = ["-mod=mod"];

  
  subPackages = [ "cmd" ];
  
  postInstall = ''
    mv $out/bin/cmd $out/bin/mdfc
  '';
  
  meta = with lib; {
    description = "Small CLI app to learn with flashcards and spaced repetition using markdown files";
    homepage = "https://github.com/bttger/markdown-flashcards";
    license = licenses.gpl3;
    maintainers = with maintainers; [ winterveil ];
    mainProgram = "mdfc";
    platforms = platforms.all;
  };
}
