//
// Custom user.js configuration file for Firefox.
// It contains a variety of settings to enhance privacy, security,
// and the user experience, while maintaining a minimalist approach.
//

// Normandy and Shield settings
user_pref("app.normandy.first_run", false);
user_pref("app.shield.optoutstudies.enabled", false);

// Accessibility settings
user_pref("accessibility.typeaheadfind.flashBar", 0);

// Bookmarks settings
user_pref("browser.bookmarks.showMobileBookmarks", false);
user_pref("browser.bookmarks.restore_default_bookmarks", false);

// Form autofill and content blocking settings
user_pref("browser.formfill.enable", false);
user_pref("browser.contentblocking.category", "standard");

// Download settings
user_pref("browser.download.folderList", 1);
user_pref("browser.download.manager.retention", 0);
user_pref("browser.download.useDownloadDir", true);

// New tab settings
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.enabled", false);

// Search and translations settings
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.translations.panelShown", true);

// Toolbar settings
user_pref("browser.toolbars.bookmarks.visibility", "always");

// URL bar settings
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.urlbar.placeholderName", "Google");
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);

// Quit warning settings
user_pref("browser.warnOnQuitShortcut", false);

// Security settings
user_pref("dom.security.https_only_mode", true);

// Extensions settings
user_pref("extensions.ui.locale.hidden", false);
user_pref("extensions.ui.dictionary.hidden", true);
user_pref("extensions.ui.sitepermission.hidden", true);
user_pref("extensions.pictureinpicture.enable_picture_in_picture_overrides", true);

// General settings
user_pref("general.smoothScroll", false);

// Media settings
user_pref("media.eme.enabled", true);
user_pref("media.hardwaremediakeys.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);

// Privacy settings
user_pref("places.history.enabled", false);
user_pref("privacy.clearOnShutdown.history", false);
user_pref("privacy.clearOnShutdown.sessions", false);
user_pref("privacy.clearOnShutdown.formdata", false);
user_pref("privacy.clearOnShutdown.downloads", false);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false);
user_pref("privacy.history.custom", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", true);

// Signon settings
user_pref("signon.autofillForms", false);
user_pref("signon.rememberSignons", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);

// Widget settings
user_pref("widget.gtk.overlay-scrollbars.enabled", false);

// Geolocation settings
user_pref("geo.enabled", false);

// Telemetry and crash reports settings
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);

user_pref("browser.tabs.crashReporting.enabled", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);

// Animations settings
user_pref("toolkit.cosmeticAnimations.enabled", false);

// Disable Pocket extension
user_pref("extensions.pocket.enabled", false);

// Homepage settings
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.startup.homepage_override.buildID", "");
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("browser.startup.firstrunSkipsHomepage", true);
user_pref("browser.aboutwelcome.enabled", false);

// Disable default browser check
user_pref("browser.shell.checkDefaultBrowser", false);

// Enable sanitize on shutdown
user_pref("privacy.sanitize.sanitizeOnShutdown", true);

// Disable spellcheck by default
user_pref("layout.spellcheckDefault", 0);

// Disable translation features
user_pref("browser.translations.enable", false);
user_pref("browser.translations.panelShown", true);

// Set CSS pixel density
user_pref("layout.css.devPixelsPerPx", "1.2");

// Remember zoom level for each site individually
user_pref("browser.zoom.siteSpecific", true);
