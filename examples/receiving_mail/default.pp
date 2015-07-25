class { 'postfix::config':
  filepath      => '/tmp/default_receive.cf',
  myorigin      => 'domain.com',
  mydestination => '$myorigin',
}
