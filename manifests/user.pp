# == Class: postfix::user
#
# Creates the postfix user
#
class postfix::user {
  ensure_resource('user', 'postfix', { 'ensure' => 'present' })
}
