# = Class: sensu
#
# Base Sensu class
#
# == Parameters
#
# [*version*]
#   String.  Version of sensu to install
#   Default: latest
#   Valid values: absent, installed, latest, present, [\d\.\-]+
#
# [*install_repo*]
#   Boolean.  Whether or not to install the sensu repo
#   Default: true
#   Valid values: true, false
#
# [*repo*]
#   String.  Which sensu repo to install
#   Default: main
#   Valid values: main, unstable
#
# [*repo_source*]
#   String.  Location of the yum/apt repo.  Overrides the default location
#   Default: undef

# [*repo_key_id*]
#   String.  The apt GPG key id
#   Default: 7580C77F
#
# [*repo_key_source*]
#   String.  URL of the apt GPG key
#   Default: http://repos.sensuapp.org/apt/pubkey.gpg
#
# [*client*]
#   Boolean.  Include the sensu client
#   Default: true
#   Valid values: true, false
#
# [*server*]
#   Boolean.  Include the sensu server
#   Default: false
#   Valid values: true, false
#
# [*api*]
#   Boolean.  Include the sensu api service
#   Default: false
#   Valid values: true, false
#
# [*dashboard*]
#   Boolean.  Include the sensu dashboard service
#   Default: false
#   Valid values: true, false
#
# [*manage_services*]
#   Boolean.  Manage the sensu services with puppet
#   Default: true
#   Valid values: true, false
#
# [*manage_user*]
#   Boolean.  Manage the sensu user with puppet
#   Default: true
#   Valid values: true, false
#
# [*rabbitmq_port*]
#   Integer.  Rabbitmq port to be used by sensu
#   Default: 5672
#
# [*rabbitmq_host*]
#   String.  Host running rabbitmq for sensu
#   Default: 'localhost'
#
# [*rabbitmq_user*]
#   String.  Username to connect to rabbitmq with for sensu
#   Default: 'sensu'
#
# [*rabbitmq_password*]
#   String.  Password to connect to rabbitmq with for sensu
#   Default: ''
#
# [*rabbitmq_vhost*]
#   String.  Rabbitmq vhost to be used by sensu
#   Default: 'sensu'
#
# [*rabbitmq_ssl_private_key*]
#   String.  Private key to be used by sensu to connect to rabbitmq
#     If the value starts with 'puppet://' the file will be copied and used.  Absolute paths will just be used
#   Default: undef
#
# [*rabbitmq_ssl_cert_chain*]
#   String.  Private SSL cert chain to be used by sensu to connect to rabbitmq
#     If the value starts with 'puppet://' the file will be copied and used.  Absolute paths will just be used
#   Default: undef
#
# [*redis_host*]
#   String.  Hostname of redis to be used by sensu
#   Default: localhost
#
# [*redis_port*]
#   Integer.  Redis port to be used by sensu
#   Default: 6379
#
# [*api_bind*]
#   String.  IP to bind api service
#   Default: 0.0.0.0
# [*api_host*]
#   String.  Hostname of the sensu api service
#   Default: localhost
#
# [*api_port*]
#   Integer. Port of the sensu api service
#   Default: 4567
#
# [*api_user*]
#   String.  Password of the sensu api service
#   Default: undef
#
# [*api_password*]
#   Integer. Password of the sensu api service
#   Default: undef
#
# [*dashboard_host*]
#   String.  Hostname of the dahsboard host
#   Default: $::ipaddress
#
# [*dashboard_port*]
#   Integer.  Port for the sensu dashboard
#   Default: 8080
#
# [*dashboard_user*]
#   String.  Username to access the dashboard service
#   Default: admin
#
# [*dashboard_password*]
#   String.  Password for dashboard_user
#   Default: secret
#
# [*subscriptions*]
#   Array of strings.  Default suscriptions used by the client
#   Default: []
#
# [*client_address*]
#   String.  Address of the client to report with checks
#   Default: $::ipaddress
#
# [*client_name*]
#   String.  Name of the client to report with checks
#   Default: $::fqdn
#
# [*client_custom*]
#   Hash.  Custom client variables
#   Default: {}
#
# [*safe_mode*]
#   Boolean.  Force safe mode for checks
#   Default: false
#   Valid values: true, false
#
# [*plugins*]
#   String, Array of Strings.  Plugins to install on the node
#   Default: []
#
# [*purge_config*]
#   Boolean.  If unused configs should be removed from the system
#   Default: false
#   Valid values: true, false
#
# [*use_embedded_ruby*]
#   Boolean.  If the embedded ruby should be used
#   Default: false
#   Valid values: true, false
#
# [*rubyopt*]
#   String.  Ruby opts to be passed to the sensu services
#   Default: ''
#
# [*log_level*]
#   String.  Sensu log level to be used
#   Default: 'info'
#   Valid values: debug, info, warn, error, fatal
#
class sensu (
  $version                  = 'latest',
  $install_repo             = true,
  $repo                     = 'main',
  $repo_source              = undef,
  $repo_key_id              = '7580C77F',
  $repo_key_source          = 'http://repos.sensuapp.org/apt/pubkey.gpg',
  $client                   = true,
  $server                   = false,
  $api                      = false,
  $dashboard                = false,
  $manage_services          = true,
  $manage_user              = true,
  $rabbitmq_port            = 5672,
  $rabbitmq_host            = 'localhost',
  $rabbitmq_user            = 'sensu',
  $rabbitmq_password        = '',
  $rabbitmq_vhost           = '/sensu',
  $rabbitmq_ssl_private_key = undef,
  $rabbitmq_ssl_cert_chain  = undef,
  $redis_host               = 'localhost',
  $redis_port               = 6379,
  $api_bind                 = '0.0.0.0',
  $api_host                 = 'localhost',
  $api_port                 = 4567,
  $api_user                 = undef,
  $api_password             = undef,
  $dashboard_bind           = '0.0.0.0',
  $dashboard_host           = $::ipaddress,
  $dashboard_port           = 8080,
  $dashboard_user           = 'admin',
  $dashboard_password       = 'secret',
  $subscriptions            = [],
  $client_bind              = '127.0.0.1',
  $client_address           = $::ipaddress,
  $client_name              = $::fqdn,
  $client_custom            = {},
  $safe_mode                = false,
  $plugins                  = [],
  $purge_config             = false,
  $use_embedded_ruby        = false,
  $rubyopt                  = '',
  $log_level                = 'info',
){

  validate_bool($client, $server, $api, $dashboard, $install_repo, $purge_config, $safe_mode, $manage_services)

  validate_re($repo, ['^main$', '^unstable$'], "Repo must be 'main' or 'unstable'.  Found: ${repo}")
  validate_re($version, ['^absent$', '^installed$', '^latest$', '^present$', '^[\d\.\-]+$'], "Invalid package version: ${version}")
  validate_re($log_level, ['^debug$', '^info$', '^warn$', '^error$', '^fatal$'] )
  if !is_integer($rabbitmq_port) { fail('rabbitmq_port must be an integer') }
  if !is_integer($redis_port) { fail('redis_port must be an integer') }
  if !is_integer($api_port) { fail('api_port must be an integer') }
  if !is_integer($dashboard_port) { fail('dashboard_port must be an integer') }

  # Ugly hack for notifications, better way?
  # Put here to avoid computing the conditionals for every check
  if $client and $server and $api {
    $check_notify = [ Class['sensu::client::service'], Class['sensu::server::service'], Class['sensu::api::service'] ]
  } elsif $client and $server {
    $check_notify = [ Class['sensu::client::service'], Class['sensu::server::service'] ]
  } elsif $client and $api {
    $check_notify = [ Class['sensu::client::service'], Class['sensu::api::service'] ]
  } elsif $server and $api {
    $check_notify = [ Class['sensu::server::service'], Class['sensu::api::service'] ]
  } elsif $server {
    $check_notify = Class['sensu::server::service']
  } elsif $client {
    $check_notify = Class['sensu::client::service']
  } elsif $api {
    $check_notify = Class['sensu::api::service']
  } else {
    $check_notify = []
  }


  # Include everything and let each module determine its state.  This allows
  # transitioning to purged config and stopping/disabling services
  anchor { 'sensu::begin': } ->
  class { 'sensu::package': } ->
  class { 'sensu::rabbitmq::config': } ->
  class { 'sensu::api::config': } ->
  class { 'sensu::redis::config': } ->
  class { 'sensu::client::config': } ->
  class { 'sensu::dashboard::config': } ->
  class { 'sensu::client::service': } ->
  class { 'sensu::api::service': } ->
  class { 'sensu::server::service': } ->
  class { 'sensu::dashboard::service': } ->
  anchor {'sensu::end': }

  sensu::plugin { $plugins: install_path => '/etc/sensu/plugins'}

}
