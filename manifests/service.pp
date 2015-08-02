# == Class: postfix::service
#
# Manage the postfix service daemon
#
# === Parameters
#
class postfix::service (
  $service_name   = $postfix::service_name,
  $enable         = $postfix::service_enable,
  $service_state  = $postfix::service_state
) {

  include postfix::user

  case $::osfamily {
    'Debian': {
      $hasstatus  = true
      $hasrestart = true
    }
    default: {
      fail('Currently your OS is not supported by this module!')
    }
  }

  $provider    = undef

  service { 'postfix':
    ensure     => $service_state,
    name       => $service_name,
    enable     => $enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    provider   => $provider,
    require    => Class['postfix::user']
  }
}
