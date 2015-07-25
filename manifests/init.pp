# == Class: Postfix
#
# Installs and configures the Postfix email server by Wietse Venema
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#  Used as the standard parameter for package, e.g. present, absent, installed
#  Passed to the postfix package, default: present
# [*version*]
#  The version of postfix to install, default: latest
# [*port*]
#  Specify the TCP port to run your server on, default: 25
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'postfix':
#    version => '2.9.6-2',
#    port    => 2225,
#  }
#
# === Authors
#
# Tom Cowling <tom.cowling@gmail.com>
#
# === Copyright
#
# Copyright 2015 Tom Cowling, unless otherwise noted.
#
class postfix (
) inherits postfix::params {

  $config = hiera('postfix')
  validate_hash($config)
  notice($config)
  create_resources('class', $config)
}
