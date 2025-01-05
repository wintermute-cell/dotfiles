{ lib, appimageTools }:

appimageTools.wrapType1 rec {
  pname = "pureref";
  version = "2.0.0";

  # Reference the local AppImage file instead of downloading
  src = ./PureRef-2.0.3_x64.Appimage;

  meta = with lib; {
    description = "Reference Image Viewer";
    homepage = "https://www.pureref.com";
    license = licenses.unfree;
    maintainers = with maintainers; [ winterveil ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}

