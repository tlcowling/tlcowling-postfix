class { 'postfix::config':
  filepath      => '/tmp/domain_wide.cf',
  myorigin      => 'domain.com',
  mydestination => ['$myhostname', 'localhost.$mydomain', 'localhost', '$mydomain'],
}
