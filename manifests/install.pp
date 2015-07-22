# == Class: postfix::install
#
# Installs the specified version of postfix
#
class postfix::install {
  validate_re($::osfamily, '^(Debian|RedHat)$', 'Currently this module works only for Debian and Red-Hat based systems')

  case $::osfamily {
    'Debian': {
      if ($postfix::version and $postfix::ensure != 'absent') {
        package { 'postfix':
          ensure => $postfix::version
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
