{
  description = "Ludum Dare 48 Development Tools";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    lib = pkgs.lib;

    docap = pkgs.writeScriptBin "docap" ''
      mkdir .screencap -p
      while [ 1 ]
      do
        ${pkgs.maim}/bin/maim .screencap/$(date +%Y%m%d_%H%M%S).png
        sleep 15
      done
    '';

    chop = pkgs.writeScriptBin "chop" ''
      mkdir ../.splitcap -p

      for file in ../.screencap/*.png
      do
        filename=$(basename -- "$file")
        filename="${"$"}{filename%.*}"

        convert -crop 3840x2160 $file ../.splitcap/$filename-%d.png
      done
    '';
  in {

    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = with pkgs; [
        gimp
        ardour
        krita
        aseprite
        audacity
        imagemagick
        emscripten
        docap
        chop
        godot
      ];

      shellHook = ''
        ${pkgs.figlet}/bin/figlet "LUDUM DARE 48"
        echo "Scripts:"
        echo "docap - captures screen every 15 seconds"
        echo "chop - splits the images out individual screens"
        echo ""
        echo "Tools:"
        echo "gimp"
        echo "ardour"
        echo "krita"
        echo "aseprite"
        echo "audacity"
        
      '';
    };
  };
}
