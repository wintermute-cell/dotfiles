{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule {
  pname = "barster";
  version = "custom";
  
  src = fetchFromGitHub {
    owner = "wintermute-cell";
    repo = "barster";
    rev = "f41edfdd12ba3ea3452161d82bfc6e9b3376963a";
    sha256 = "sha256-MRHIbZaTL6sp51UienYhNfKJKwZlcin2QrxdZGiQYtQ=";
  };
  
  vendorHash = "sha256-LL+Ao6zvHnhYyU8fNkM9z/30PDpKSF6wwCk1m7+t+NA=";
  
  meta = with lib; {
    description = "A content provider for simple, string based status-bars like dwm's bar.";
    homepage = "https://github.com/wintermute-cell/barster";
    license = licenses.mit;
    maintainers = with maintainers; [ winterveil ];
    mainProgram = "barster";
    platforms = platforms.all;
  };
}
