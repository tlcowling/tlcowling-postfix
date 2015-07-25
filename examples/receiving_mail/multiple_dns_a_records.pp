class { 'postfix::config':
  mydestination => ['$myhostname', 'localhost.$mydomain', 'localhost', 'www.$mydomain', 'ftp.$mydomain'],
}
