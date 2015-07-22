# == Class: postfix::config
#
# Creates a postfix user
#
class postfix::config {

  include postfix::params

  ensure_resource('user', 'postfix', { 'ensure' => 'present' })
}
