{ user, ... }:

{
  nix.enable = false;  				# Determinate already manages the Nix daemon, so nix-darwin shouldn't
  nixpkgs.config.allowUnfree = true;  		# allow packages that aren't free 
  nixpkgs.hostPlatform = "aarch64-darwin";  	# Apple Silicon

  system.primaryUser = user;  
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;			

  # macOS defaults
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";	
      KeyRepeat = 2;          			# key repeat time interval in 15 ms units
      InitialKeyRepeat = 15;  			# time delay until key repeat in 15 ms units
      _HIHideMenuBar = true;  			# hides menu bar
      AppleShowAllExtensions = true;  		# show file extensions in Finder
    };
    dock.autohide = true;			# hides dock
    finder.FXPreferredViewStyle = "Nlsv";  	# list view in Finder by default
    finder.CreateDesktop = false;          	# clean desktop
    trackpad.Clicking = true;              	# tap to click
  };

  # Install homebrew
  nix-homebrew = {  
    enable = true;
    inherit user;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";  		# rm all pkgs that aren't listed in this config
    onActivation.autoUpdate = true;		# update each rebuild
    onActivation.extraFlags = [ "--force" ];    # force zap cleanup without confirmation
    brews = [];
    casks = [
      "1password-cli"
      "aerospace"
      "obsidian"
      "dbeaver-community"
      "ghostty"
      "maccy"
      "opensuperwhisper"
      "claude-code"
    ];
  };
}
