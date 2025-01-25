{ config, pkgs, ... }: {
  networking.localHostName = "xarpus";

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      "nano"
      "git"
      "npm"
      "go"
      "python3"
      "gnupg"
      "git"
      "pinentry-mac"
    ];
    casks = [
      "firefox"
      "visual-studio-code"
      "discord"
      "ghostty"
      "spotify"
      "tailscale"
      "docker"
    ];
    masApps = {
      "Magnet" = 441258766;
      "Amphetamine" = 937984704;
    };
  };
}