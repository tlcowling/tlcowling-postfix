# == Class: postfix::service
#
# Manage the postfix service daemon
#
# === Parameters
#
class postfix::service (
  $service_name   = $postfix::service_name,
  $service_enable = $postfix::service_enable,
  $service_state  = $postfix::service_state
) {
  case $::osfamily {
    'Debian': {
      $hasstatus  = true
      $hasrestart = true
    }
    default: {
      fail('Unsupported OS')
    }
  }

  file { "/etc/default/${service_name}":
    ensure  => present,
    force   => true,
    content => 'test',
    notify  => Service['postfix']
  }

  $provider    = undef

  service { 'postfix':
    ensure     => $service_state,
    name       => $service_name,
    enable     => $service_enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    provider   => $provider
  }
}
