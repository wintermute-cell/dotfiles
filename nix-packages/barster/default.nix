{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule {
  pname = "barster";
  version = "custom";
  
  src = fetchFromGitHub {
    owner = "wintermute-cell";
    repo = "barster";
    rev = "7c4ae2ef34e82841dbba7f34230402170a76d6f7";
    sha256 = "sha256-pIgiLIbNdM0COwmVC7cAIbZeNcEoHGHzNhJ7IH64i/M=";
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
