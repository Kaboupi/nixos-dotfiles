{ cfg, ... }:

{
  time.timeZone = cfg.timezone;
  i18n.defaultLocale = cfg.locale;
}
