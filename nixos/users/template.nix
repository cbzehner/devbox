{ username, fullName, email, access ? "none", secrets ? "none", publicKeys ? [ ]
, overrides ? { } }: {
  users = {
    users."${username}" = {
      isNormalUser = true;
      description = "${fullName} <${email}>";
      extraGroups = if access == "admin" then [
        "wheel" # passwordless sudo
        "systemd-journal" # access system-wide logs via journalctl
        "networkmanager"
      ] else
        [ ];
      openssh.authorizedKeys.keys = publicKeys;
    } // overrides;
  };
}
