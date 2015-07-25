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

This module seeks to install postfix via puppet and allow its configuration to be specified using
Hiera data. It aims to include all the available options to configure postfix.

Tested on the following Operating Systems:

Ubuntu 12.04, 14.04
Debian 7
Centos 6, 7

with Puppet 3.1+

and Ruby versions:
1.9.3 - 2.2.2 

## Module Description

Postfix is a for mail server.  Use this module to configure postfix on your
server(s) via puppet.

## Setup

### Beginning with Postfix

This module uses the class postfix. 

For a standard out-of-the-box installation on a stand-alone machine with direct internet access, you can use:

```puppet
include 'postfix'
```

This will install postfix using your facter domain as the domain name.

If you want to get a particular version to install, use the version parameter. By default this will be 'latest', and whatever you choose must be available from your package repository.

```puppet
class { 'postfix':
  version => '2.10.0',
}
```

## Usage

This puppet module is designed to manage your postfix configuration and will affect the following:
  - Configuration files and directories (created and written to)
  - WARNING: Configurations that are not managed by Puppet will be purged.


To start passing some general parameters, for example what port to run postfix on, set
```puppet
class { 'postfix':
}
```


## Reference

postfix::config

## Limitations

Currently tested and working on Debian
RedHat Support to come

## Development

Please feel free to contribute if this is in any way useful to you.
Its a work in progress
