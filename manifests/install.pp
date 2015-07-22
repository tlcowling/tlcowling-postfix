# == Class: postfix::install
#
# Installs the specified version of postfix
#
class postfix::install {
  validate_re($::osfamily, '^(Debian|RedHat)$', 'Currently this module works only for Debian and Red-Hat based systems')

  case $::osfamily {
    'Debian': {
      if ($postfix::version and $postfix::ensure != 'absent') {
        file { 'postfix preseed':
          ensure  => present,
          path    => '/tmp/postfix.preseed',
          content => 'postfix postfix/main_mailer_type    select  No configuration',
        }
        package { 'postfix':
          ensure       => $postfix::version,
          responsefile => '/tmp/postfix.preseed',
          require      => File['postfix preseed'],
        }
      } else {
        package { 'postfix':
          ensure => $postfix::ensure
        }
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
