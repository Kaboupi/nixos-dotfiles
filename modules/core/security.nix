{ cfg, pkgs, ... }:

{
  security.polkit = {
    enable = true;

    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.freedesktop.login1.chvt" ||
            action.id == "org.freedesktop.login1.manage") &&
            subject.isInGroup("video")) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}
