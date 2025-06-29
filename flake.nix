{
  description = "DWL Custom Build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.dwl =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
        pkgs.stdenv.mkDerivation {
          pname = "dwl";
          version = "0.8-dev+";
          src = self;

          nativeBuildInputs = with pkgs; [
            pkg-config
            clang-tools # for lsp for emacs
          ];

          buildInputs = with pkgs; [
            wayland-scanner
            wayland-protocols
            libinput wayland
            wlroots_0_19
            pixman
            libxkbcommon
          ];

          installFlags = [ "PREFIX=$(out)" ];
       };

    packages.x86_64-linux.default = self.packages.x86_64-linux.dwl;
  };
}
