<?php

$name = 'FetchAutocomplete';
if (!isset($app['modules'][strtolower($name)])) {
    // display a warning on top of admin ui
    $app->on('app.layout.contentbefore', function() use ($name) {
        echo '<p><span class="uk-badge uk-badge-warning"><i class="uk-margin-small-right uk-icon-warning"></i>' . $name . '</span> You have to rename the addon folder <code>' . basename(__DIR__) . '</code> to <code>' . $name . '</code>.</p>';
    });
    return;
}

// ADMIN
if (COCKPIT_ADMIN && !COCKPIT_API_REQUEST) {
  include_once(__DIR__ . '/admin.php');
}