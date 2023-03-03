<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '$MARIADB_DATABASE' );

/** MySQL database username */
define( 'DB_USER', '$MARIADB_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', '$MARIADB_USER_PASSWORD' );

/** MySQL hostname */
define( 'DB_HOST', '$MARIADB_CONTAINER' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'b`kYZ=<,ce%sq)jDhQ>6[Ef%PYo%9k4%1q&XC_vFswt1-U)iGQIke+69bN_{q@bP');
define('SECURE_AUTH_KEY',  'CIAmo!Jv?}rD]TQlwE1>+M2Fa.P xQF t~-3/]ZP<<s4:R*Fzd|g,liJ!oS5On:D');
define('LOGGED_IN_KEY',    '5J%fQkV/ka=GHRCz3j{S&T5<de|?$hx_+.vU=J|AER@E~1I1OO+i61x!Ss.|OKI7');
define('NONCE_KEY',        '*rk)>|f8?ZM*[lce*fyV@?zj%mh?X|cx=HO+1t@G;@8^WTu]cxoF.-]Zh>&):,&3');
define('AUTH_SALT',        'Q_[}h_aO+^cQ-Bp8W!`xFp|Te5b@&@iFpPW8*Z>q+O1B.(P&@fjWNNW*/)dwMF?;');
define('SECURE_AUTH_SALT', '!vI#g2K:+boa`ZOdwN?~hws37({8C|.-Ik6h@,_~`Nn/o:x)38421_(E|=tXQ1+>');
define('LOGGED_IN_SALT',   'r~uvNIpp9l^66`8+SZT+?Sq%uu+vMa4s1a~og/>]@&]Ou/b(-g/cC+bZTfsGrIft');
define('NONCE_SALT',       'lvJ}r>G:hd:-_MT@Rp7RfLc^)#@?S UBy-;[RSpKN7lZ-:dUcxPVo.Il+$%IvOx&');


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
