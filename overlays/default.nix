# cobbled together from
# - https://github.com/SamueleFacenda/nixos-config/blob/1ce12fbbcc0b4969452069d3b24872f3a8e19af0/modules/utils.nix
# - https://github.com/SamueleFacenda/nixos-config/blob/1ce12fbbcc0b4969452069d3b24872f3a8e19af0/overlays/default.nix
# imports all other files in this directory.
{ lib, ... }:
let
  inherit (lib) mapAttrsToList filterAttrs all;
  inherit (builtins) readDir;
  not_contains = (element: list: all (x: x != element) list);
  listDirPathsExcluding = (exclude: path:
  mapAttrsToList
    (n: v: path + "/${n}")
    (filterAttrs
      (n: v: n != "default.nix" && (not_contains n exclude))
      (readDir path)));
in
{
  nixpkgs.overlays = builtins.map import (listDirPathsExcluding [ "README.md" ] ./.);
}

