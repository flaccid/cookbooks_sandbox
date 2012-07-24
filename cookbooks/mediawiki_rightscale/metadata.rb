maintainer       "Chris Fordham"
maintainer_email "chris@xhost.com.au"
license          "Apache 2.0"
description      "Installs/Configures mediawiki_application on RightScale"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "mediawiki_application"

recipe "mediawiki_rightscale::default", "Installs & configures Mediawiki."

attribute "mediawiki_application/deploy_action",
  :display_name => "MediaWiki Deploy Action",
  :description => "Deploy or force deploy the MediaWiki application.",
  :required => "optional",
  :option => [ 'deploy', 'force_deploy' ],
  :default => "deploy",
  :recipes => [ "mediawiki_application::application" ]

attribute "mediawiki_application/name",
  :display_name => "MediaWiki Application Name",
  :description => "The name of the MediaWiki application.",
  :required => "required",
  :recipes => [ "mediawiki_application::application" ]

attribute "mediawiki_application/path",
  :display_name => "MediaWiki Install Path",
  :description => "The path to install MediaWiki to, e.g. /var/www",
  :default => "/usr/local/www",
  :required => "optional",
  :choice => [ '/usr/local/www', '/var/www' ],
  :recipes => [ "mediawiki_application::application", "mediawiki_application::import_initial_tables" ]
    
attribute "mediawiki_application/system_user",
  :display_name => "MediaWiki System User",
  :description => "The system user (owner) for the application.",
  :default => "www-data",
  :required => "optional",
  :choice => [ 'www-data', 'httpd', 'http', 'www', 'root' ],
  :recipes => [ "mediawiki_application::application" ]
      
attribute "mediawiki_application/system_group",
  :display_name => "MediaWiki System Group",
  :description => "The system group for the application.",
  :default => "www-data",
  :required => "optional",
  :choice => [ 'www-data', 'httpd', 'http', 'www', 'root', 'users' ],
  :recipes => [ "mediawiki_application::application" ]
  
attribute "mediawiki_application/repository_url",
  :display_name => "MediaWiki Repository URL",
  :description => "The URL to the application for checkout/download.",
  :required => "recommended",
  :default => "https://gerrit.wikimedia.org/r/p/mediawiki/core.git",
  :recipes => [ "mediawiki_application::application" ]
    
attribute "mediawiki_application/revision",
  :display_name => "MediaWiki Application Revision",
  :description => "The revision of the application to use (tag/branch/commit).",
  :required => "recommended",
  :default => "master",
  :recipes => [ "mediawiki_application::application" ]

attribute "mediawiki_application/php/packages",
  :display_name => "MediaWiki PHP/PEAR Packages",
  :description => "An array of php/pear packages to install.",
  :required => "optional",
  :default => [ "mysql" ],
  :type => 'array',
  :recipes => [ "mediawiki_application::application" ]

attribute "mediawiki_application/db/host",
  :display_name => "MediaWiki Database Host",
  :description => "The database host name to use with MediaWiki.",
  :required => "recommended",
  :default => "localhost",
  :recipes => [ "mediawiki_application::application", "mediawiki_application::drop_database_user", "mediawiki_application::drop_database", "mediawiki_application::create_database_user", "mediawiki_application::create_database" ]
    
attribute "mediawiki_application/db/adapter",
  :display_name => "MediaWiki Database Adapter",
  :description => "The database adapter to use with PHP.",
  :required => "recommended",
  :default => "mysql",
  :choice => [ "mysql", "postgres", "sqlite" ],
  :recipes => [ "mediawiki_application::application", "mediawiki_application::database" ]

attribute "mediawiki_application/db/schema",
  :display_name => "MediaWiki Database Schema",
  :description => "The database schema or name for MediaWiki.",
  :required => "recommended",
  :default => "mediawiki",
  :recipes => [ "mediawiki_application::application", "mediawiki_application::import_initial_tables", "mediawiki_application::drop_database", "mediawiki_application::create_database_user", "mediawiki_application::create_database" ]

attribute "mediawiki_application/db/username",
  :display_name => "MediaWiki Database User",
  :description => "The database username for MediaWiki.",
  :required => "recommended",
  :default => "mediawiki",
  :recipes => [ "mediawiki_application::drop_database_user", "mediawiki_application::create_database_user" ]

attribute "mediawiki_application/db/password",
  :display_name => "MediaWiki Database Password",
  :description => "The database password for MediaWiki.",
  :required => "required",
  :recipes => [ "mediawiki_application::application", "mediawiki_application::database", "mediawiki_application::create_database_user" ]
  
attribute "mysql/server_root_password",
  :display_name => "MySQL Server Root Password",
  :description => "The root password for the MySQL server.",
  :required => "required",
  :recipes => [ "mediawiki_application::database", "mediawiki_application::import_initial_tables", "mediawiki_application::drop_database_user", "mediawiki_application::drop_database", "mediawiki_application::create_database_user", "mediawiki_application::create_database" ]

attribute "mysql/server_repl_password",
  :display_name => "MySQL Replication Password",
  :description => "The replication password for the MySQL server.",
  :required => "required",
  :recipes => [ "mediawiki_application::database" ]

attribute "mysql/server_debian_password",
  :display_name => "MySQL Debian Password",
  :description => "The debian admin user password for the MySQL server.",
  :required => "required",
  :recipes => [ "mediawiki_application::database" ]

attribute "apache",
  :display_name => "Apache Hash",
  :description => "Hash of Apache attributes",
  :type => "hash"

attribute "apache/dir",
  :display_name => "Apache Directory",
  :description => "Location for Apache configuration",
  :default => "/etc/apache2"

attribute "apache/log_dir",
  :display_name => "Apache Log Directory",
  :description => "Location for Apache logs",
  :default => "/etc/apache2"

attribute "apache/user",
  :display_name => "Apache User",
  :description => "User Apache runs as",
  :default => "www-data"

attribute "apache/binary",
  :display_name => "Apache Binary",
  :description => "Apache server daemon program",
  :default => "/usr/sbin/apache2"

attribute "apache/icondir", 
  :display_name => "Apache Icondir",
  :description => "Directory location for icons",
  :default => "/usr/share/apache2/icons"

attribute "apache/listen_ports",
  :display_name => "Apache Listen Ports",
  :description => "Ports that Apache should listen on",
  :type => "array",
  :default => [ "80", "443" ]

attribute "apache/contact",
  :display_name => "Apache Contact",
  :description => "Email address of webmaster",
  :default => "ops@example.com"

attribute "apache/timeout",
  :display_name => "Apache Timeout",
  :description => "Connection timeout value",
  :default => "300"

attribute "apache/keepalive",
  :display_name => "Apache Keepalive",
  :description => "HTTP persistent connections",
  :default => "On"

attribute "apache/keepaliverequests",
  :display_name => "Apache Keepalive Requests",
  :description => "Number of requests allowed on a persistent connection",
  :default => "100"

attribute "apache/keepalivetimeout",
  :display_name => "Apache Keepalive Timeout",
  :description => "Time to wait for requests on persistent connection",
  :default => "5"

attribute "apache/servertokens",
  :display_name => "Apache Server Tokens",
  :description => "Server response header",
  :default => "Prod"

attribute "apache/serversignature",
  :display_name => "Apache Server Signature",
  :description => "Configure footer on server-generated documents",
  :default => "On"

attribute "apache/traceenable",
  :display_name => "Apache Trace Enable",
  :description => "Determine behavior of TRACE requests",
  :default => "On"

attribute "apache/allowed_openids",
  :display_name => "Apache Allowed OpenIDs",
  :description => "Array of OpenIDs allowed to authenticate",
  :default => ""

attribute "apache/prefork",
  :display_name => "Apache Prefork",
  :description => "Hash of Apache prefork tuning attributes.",
  :type => "hash"

attribute "apache/prefork/startservers",
  :display_name => "Apache Prefork MPM StartServers",
  :description => "Number of MPM servers to start",
  :default => "16"

attribute "apache/prefork/minspareservers",
  :display_name => "Apache Prefork MPM MinSpareServers",
  :description => "Minimum number of spare server processes",
  :default => "16"

attribute "apache/prefork/maxspareservers",
  :display_name => "Apache Prefork MPM MaxSpareServers",
  :description => "Maximum number of spare server processes",
  :default => "32"

attribute "apache/prefork/serverlimit",
  :display_name => "Apache Prefork MPM ServerLimit",
  :description => "Upper limit on configurable server processes",
  :default => "400"

attribute "apache/prefork/maxclients",
  :display_name => "Apache Prefork MPM MaxClients",
  :description => "Maximum number of simultaneous connections",
  :default => "400"

attribute "apache/prefork/maxrequestsperchild",
  :display_name => "Apache Prefork MPM MaxRequestsPerChild",
  :description => "Maximum number of request a child process will handle",
  :default => "10000"

attribute "apache/worker",
  :display_name => "Apache Worker",
  :description => "Hash of Apache prefork tuning attributes.",
  :type => "hash"

attribute "apache/worker/startservers",
  :display_name => "Apache Worker MPM StartServers",
  :description => "Initial number of server processes to start",
  :default => "4"

attribute "apache/worker/maxclients",
  :display_name => "Apache Worker MPM MaxClients",
  :description => "Maximum number of simultaneous connections",
  :default => "1024"

attribute "apache/worker/minsparethreads",
  :display_name => "Apache Worker MPM MinSpareThreads",
  :description => "Minimum number of spare worker threads",
  :default => "64"

attribute "apache/worker/maxsparethreads",
  :display_name => "Apache Worker MPM MaxSpareThreads",
  :description => "Maximum number of spare worker threads",
  :default => "192"

attribute "apache/worker/threadsperchild",
  :display_name => "Apache Worker MPM ThreadsPerChild",
  :description => "Constant number of worker threads in each server process",
  :default => "64"

attribute "apache/worker/maxrequestsperchild",
  :display_name => "Apache Worker MPM MaxRequestsPerChild",
  :description => "Maximum number of request a child process will handle",
  :default => "0"

attribute "apache/default_modules",
  :display_name => "Apache Default Modules",
  :description => "Default modules to enable via recipes",
  :default => [ "status", "alias", "auth_basic", "authn_file", "authz_default", "authz_groupfile", "authz_host", "authz_user", "autoindex", "dir", "env", "mime", "negotiation", "setenvif" ],
  :type => "array"
	
attribute "mysql/server_root_password",
  :display_name => "MySQL Server Root Password",
  :description => "Randomly generated password for the mysqld root user",
  :default => "randomly generated"

attribute "mysql/bind_address",
  :display_name => "MySQL Bind Address",
  :description => "Address that mysqld should listen on",
  :default => "0.0.0.0"

attribute "mysql/data_dir",
  :display_name => "MySQL Data Directory",
  :description => "Location of mysql databases",
  :default => "/var/lib/mysql"

attribute "mysql/conf_dir",
  :display_name => "MySQL Conf Directory",
  :description => "Location of mysql conf files",
  :default => "/etc/mysql"

attribute "mysql/ec2_path",
  :display_name => "MySQL EC2 Path",
  :description => "Location of mysql directory on EC2 instance EBS volumes",
  :default => "/mnt/mysql"

attribute "mysql/tunable",
  :display_name => "MySQL Tunables",
  :description => "Hash of MySQL tunable attributes",
  :type => "hash"

attribute "mysql/tunable/key_buffer",
  :display_name => "MySQL Tuntable Key Buffer",
  :default => "250M"

attribute "mysql/tunable/max_connections",
  :display_name => "MySQL Tunable Max Connections",
  :default => "800"

attribute "mysql/tunable/wait_timeout",
  :display_name => "MySQL Tunable Wait Timeout",
  :default => "180"

attribute "mysql/tunable/net_read_timeout",
  :display_name => "MySQL Tunable Net Read Timeout",
  :default => "30"

attribute "mysql/tunable/net_write_timeout",
  :display_name => "MySQL Tunable Net Write Timeout",
  :default => "30"

attribute "mysql/tunable/back_log",
  :display_name => "MySQL Tunable Back Log",
  :default => "128"

attribute "mysql/tunable/table_cache",
  :display_name => "MySQL Tunable Table Cache for MySQL < 5.1.3",
  :default => "128"

attribute "mysql/tunable/table_open_cache",
  :display_name => "MySQL Tunable Table Cache for MySQL >= 5.1.3",
  :default => "128"

attribute "mysql/tunable/max_heap_table_size",
  :display_name => "MySQL Tunable Max Heap Table Size",
  :default => "32M"

attribute "mysql/tunable/expire_logs_days",
  :display_name => "MySQL Exipre Log Days",
  :default => "10"

attribute "mysql/tunable/max_binlog_size",
  :display_name => "MySQL Max Binlog Size",
  :default => "100M"

attribute "mysql/tunable/innodb_flush_method",
  :display_name => "MySQL Innodb Flush Method",
  :default => "O_DSYNC"

attribute "mysql/client",
  :display_name => "MySQL Connector/C Client",
  :description => "Hash of MySQL client attributes",
  :type => "hash"

attribute "mysql/client/version",
  :display_name => "MySQL Connector/C Version",
  :default => "6.0.2"

attribute "mysql/client/arch",
  :display_name => "MySQL Connector/C Architecture",
  :default => "win32"

attribute "mysql/client/package_file",
  :display_name => "MySQL Connector/C Package File Name",
  :default => "mysql-connector-c-6.0.2-win32.msi"

attribute "mysql/client/url",
  :display_name => "MySQL Connector/C Download URL",
  :default => "http://www.mysql.com/get/Downloads/Connector-C/mysql-connector-c-6.0.2-win32.msi/from/http://mysql.mirrors.pair.com/"

attribute "mysql/client/package_name",
  :display_name => "MySQL Connector/C Registry DisplayName",
  :default => "MySQL Connector C 6.0.2"

attribute "mysql/client/basedir",
  :display_name => "MySQL Connector/C Base Install Directory",
  :default => "C:\\Program Files (x86)\\MySQL\\Connector C 6.0.2"

attribute "mysql/client/lib_dir",
  :display_name => "MySQL Connector/C Library Directory (containing libmysql.dll)",
  :default => "C:\\Program Files (x86)\\MySQL\\Connector C 6.0.2\\lib\\opt"

attribute "mysql/client/bin_dir",
  :display_name => "MySQL Connector/C Executable Directory",
  :default => "C:\\Program Files (x86)\\MySQL\\Connector C 6.0.2\\bin"

attribute "mysql/client/ruby_dir",
  :display_name => "Ruby Executable Directory which should gain MySQL support",
  :default => "system ruby"