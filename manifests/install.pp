# == Class: postfix::install
#
# Installs the specified version of postfix
#
class postfix::install (
  $version
) {
  validate_re($::osfamily, '^(Debian|RedHat)$', 'Currently this module works only for Debian and Red-Hat based systems')

  case $::osfamily {
    'Debian': {
        file { 'postfix preseed':
          ensure  => present,
          path    => '/tmp/postfix.preseed',
          content => 'postfix postfix/main_mailer_type    select  No configuration',
        }
        package { 'postfix':
          ensure       => $version,
          responsefile => '/tmp/postfix.preseed',
          require      => File['postfix preseed'],
        }
      }
    'RedHat': {
      package {'postfix':
        ensure => $postfix::version
      }
    }
    default: {
      fail('OS not supported')
    }
  }
}
