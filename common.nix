{ pkgs, nix-homebrew, inputs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "evan";
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
  };

  fonts.packages = [
    pkgs.ibm-plex
    pkgs.nerd-fonts.jetbrains-mono
  ];

  users.users.evan.home = "/Users/evan";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.evan = {
      home.stateVersion = "25.05";

      home.file.".hushlogin".text = "";
      home.file."Library/Application\ Support/com.mitchellh.ghostty/config".text = ''
        background = 1d1d1d
        scrollback-limit = 1048576
        font-family = "IBM Plex Mono SmBld"
        font-family = "JetBrainsMonoNL NFM Medium"
        font-size = 13
        font-thicken = true 
        shell-integration-features = no-cursor
        cursor-style = "block"
        window-width = 130 
        window-height = 30
        macos-titlebar-style = "transparent"
        palette = 0=000000
        palette = 1=f6645e
        palette = 2=00c58c
        palette = 3=eae70e
        palette = 4=67adde
        palette = 5=e08ade
        palette = 6=2bc4e2
        palette = 7=eaeaea
        palette = 8=666666
        palette = 9=f7645e
        palette = 10=00c58c
        palette = 11=e9e70d
        palette = 12=67adde
        palette = 13=e08ade
        palette = 14=2bc4e2
        palette = 15=eaeaea
      '';

      home.file.".gitconfig".text = ''
        [user]
                email = 41494790+evaan@users.noreply.github.com
                signingkey = 55CF6BE093240731
        [commit]
                gpgsign = true
        [tag]
                gpgSign = true
      '';

      home.file.".gnupg/gpg-agent.conf".text = "pinentry-program /opt/homebrew/bin/pinentry-mac";
      home.file.".gnupg/gpg.conf".text = "use-agent";
    };
  };

  programs.zsh = {
    enable = true;
    promptInit = ''
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
      bindkey '^H' backward-kill-word
      bindkey '^[[3;5~' kill-word
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word
      bindkey "^[[3;3~" delete-word
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };

  system = {
    startup.chime = false;
    defaults = {
      dock = {
        tilesize = 64;
        show-recents = false;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
      WindowManager = {
        EnableStandardClickToShowDesktop = false;
      };
      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadThreeFingerTapGesture = 0;
      };
      menuExtraClock.Show24Hour = true;
      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = false;
        "com.apple.trackpad.forceClick" = false;
        AppleICUForce24HourTime = true;
      };
    };
  };

  system.activationScripts.Wallpaper.text = ''
    osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png
    defaults write com.apple.Dock position-immutable -bool true; killall Dock
  '';
}