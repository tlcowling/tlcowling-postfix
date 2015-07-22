# Puppet Postfix
Puppet module to manage Postfix on various UNIXes

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with module](#setup)
    * [What module affects](#what-module-affects)
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

Postfix is the de facto standard for mail servers.  Use this module to configure postfix on your
servers via puppet.

## Setup

### What module affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with module

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

This puppet module affects the following!  
  - configuration files and directories (created and written to)
  - WARNING: Configurations that are not managed by Puppet will be purged.


### Beginning with Postfix
This module uses the class postfix.  For a standard installation

```puppet
include 'postfix'
```

Specify a version of postfix to install, by default this will be 'latest'.  This uses the standard
puppet 
```puppet
class { 'postfix':
  version => '1.4',
}
```

To start passing some general parameters, for example what port to run postfix on, set
```puppet
class { 'postfix':
  port => '25',
}
```


## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
