# Puppet Postfix [![Build Status](https://travis-ci.org/tlcowling/tlcowling-postfix.svg?branch=master)](https://travis-ci.org/tlcowling/tlcowling-postfix)

# NOT YET READY FOR USE, BUT SOON IT WILL BE :)

Puppet module to manage Postfix on various UNIXes

#### Table of Contents

1. [Overview - What is the postfix module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with postfix](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with module](#beginning-with-module)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module seeks to install postfix via puppet and allow its configuration to be specified using hiera data. It aims to include all the available options to configure postfix for the following operating systems:

- Ubuntu 12.04
- Ubuntu 14.04
- Debian 7
- Centos 5
- Centos 6
- Centos 7

## Module Description

Postfix is a mail server.  Use this module to configure postfix on your
server(s) via puppet.

## Setup

### Beginning with Postfix

This module uses the class postfix. 

For a standard out-of-the-box installation on a stand-alone machine with direct internet access, you can use:

```puppet
include 'postfix'
```

This will install postfix using your facter domain as the mail sending address.

If you want to install a particular version, use the version parameter. By default this will be 'latest', and whatever you choose must be available from your package repository.

```puppet
class { 'postfix':
  version => '2.10.0',
}
```

### Configuration
Configuration can be specified by direct declaration using puppet code or through hiera. 

#### Outbound mail domain name
```puppet
class { 'postfix::config':
  myorigin      => 'domain.name.of.your.choice',
}
```

You can specify the full literal string, or the variable name convention as used in the main.cf file, i.e. '$variablename'

Parameters such as $mydestination which can take multiple values can be specified as single values or using an array.

If using hiera, you just need to include a file like this:
```yaml
---
  postfix:
    config:
      myorigin: 'domain.name.of.your.choice'
```

#### Domains to receive mail for
##### Example 1: Default Setting
```puppet
class { 'postfix::config':
  myorigin      => 'domain.com',
  mydestination => '$myorigin'
}
```

##### Example 2: Domain-wide mail server
```puppet
class { 'postfix::config':
  mydestination => ['$myhostname', 'localhost.$mydomain', 'localhost', '$mydomain'],  
}
```

##### Example 3: Host with multiple DNS A Records (hiera)
```yaml
---
  postfix:
    config:
      myorigin: 'domain.com'
      mydestination:
        - $myhostname
        - localhost.$myhostname
        - localhost
        - $mydomain
        - www.$mydomain
        - ftp.$mydomain 
```

### What clients to relay mail from:
Either specify mynetworks_style and let postfix manage the list for you, or explicitly define with mynetworks

class { 'postfix::config':
  mynetworks_style => 'subnet',
}

class { 'postfix::config':
  mynetworks => ['127.0.0.0/8', '168.100.189.2/32'],
}

#### Proxy/NAT external network addresses
If you run a Postfix server behind a proxy or NAT, you need to configure the proxy_interfaces parameter and specify all the external proxy or NAT addresses that Postfix receives mail on. You may specify symbolic hostnames instead of network addresses.

IMPORTANT: You must specify your proxy/NAT external addresses when your system is a backup MX host for other domains, otherwise mail delivery loops will happen when the primary MX host is down.

##### Host behind NAT box running a backup MX host
class { 'postfix::config':
  ...
  proxy_interfaces = '1.2.3.4'
  ...
}


### SASL Authentication

### TLS Encryption

### Warning!

This puppet module is designed to manage your postfix configuration and will affect the following:
  - Configuration files and directories (created and written to)
  - WARNING: Configurations that are not managed by Puppet will be purged.

## Reference

postfix
postfix::config

## Limitations

Currently tested and working on Debian, Ubuntu
RedHat Support to come
Freebsd
Archlinux (etc)
Solaris?!

## Development

Please feel free to contribute if this is in any way useful to you.
Its a work in progress
