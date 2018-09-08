// I prefer the search bar distinct from the urlbar
user_pref('browser.search.widget.inNavBar', true);
user_pref('browser.urlbar.suggest.searches', false);
user_pref('browser.urlbar.oneOffSearches', false);
user_pref('keyword.enabled', false);

// No wool, please
user_pref('browser.urlbar.formatting.enabled', false);

// Except here
user_pref('browser.urlbar.decodeURLsOnCopy', true);

// Disable auto-complete and other bullshit from the urlbar
user_pref('browser.fixup.alternate.enabled', false);
user_pref('browser.urlbar.suggest.bookmark', false);
user_pref('browser.urlbar.suggest.history', false);
user_pref('browser.urlbar.suggest.openpage', false);
