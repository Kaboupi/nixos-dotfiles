{ cfg, ... }:

{
  environment.variables = {
    EDITOR = cfg.defaultEditor;
  };
}
