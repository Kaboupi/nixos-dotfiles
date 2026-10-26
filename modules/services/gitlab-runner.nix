{ ... }:

{
  services.gitlab-runner = {
    enable = false;
    settings.concurrent = 4;

    services = {
      default = {
        authenticationTokenConfigFile = "/etc/gitlab-runner/default.env";
        executor = "docker";
        dockerImage = "debian:stable";
      };

      shell = {
        authenticationTokenConfigFile = "/etc/gitlab-runner/shell.env";
        executor = "shell";
      };
    };
  };
}
