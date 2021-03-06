# == Class: postfix::config
#
# This class manages the main.cf postfix file
#
# Parameters
#  [*soft_bounce*]
#    The soft_bounce parameter provides a limited safety net for
#    testing.  When soft_bounce is enabled, mail will remain queued that
#    would otherwise bounce. This parameter disables locally-generated
#    bounces, and prevents the SMTP server from rejecting mail permanently
#    (by changing 5xx replies into 4xx replies). However, soft_bounce
#    is no cure for address rewriting mistakes or mail routing mistakes.
#    default: no
#
#  [*queue_directory*]
#    The queue_directory specifies the location of the Postfix queue.
#    This is also the root directory of Postfix daemons that run chrooted.
#    See the files in examples/chroot-setup for setting up Postfix chroot
#    environments on different UNIX systems.
#    default: /var/spool/postfix
#
#  [*command_directory*]
#    The command_directory parameter specifies the location of all
#    postXXX commands.
#    default: /usr/sbin
#
#  [*daemon_directory*]
#    The daemon_directory parameter specifies the location of all Postfix
#    daemon programs (i.e. programs listed in the master.cf file). This
#    directory must be owned by root.
#    default: /usr/lib/postfix
#
#  [*data_directory*]
#    The data_directory parameter specifies the location of Postfix-writable
#    data files (caches, random numbers). This directory must be owned
#    by the mail_owner account (see below).
#    default: /usr/lib/postfix
#
#  [*mail_owner*]
#    The mail_owner parameter specifies the owner of the Postfix queue
#    and of most Postfix daemon processes.  Specify the name of a user
#    account THAT DOES NOT SHARE ITS USER OR GROUP ID WITH OTHER ACCOUNTS
#    AND THAT OWNS NO OTHER FILES OR PROCESSES ON THE SYSTEM.  In
#    particular, don't specify nobody or daemon. PLEASE USE A DEDICATED
#    USER.
#    default: postfix
#
#  [*default_privs*]
#    The default_privs parameter specifies the default rights used by
#    the local delivery agent for delivery to external file or command.
#    These rights are used in the absence of a recipient user context.
#    DO NOT SPECIFY A PRIVILEGED USER OR THE POSTFIX OWNER.
#   default: nobody
#
#  [*myhostname*]
#    The myhostname parameter specifies the internet hostname of this
#    mail system. The default is to use the fully-qualified domain name
#    from gethostname(). $myhostname is used as a default value for many
#    other configuration parameters.
#
#  [*mydomain*]
#    The mydomain parameter specifies the local internet domain name.
#    The default is to use $myhostname minus the first component.
#    $mydomain is used as a default value for many other configuration
#    parameters.
#
#  [*myorigin*]
#    The myorigin parameter specifies the domain that locally-posted
#    mail appears to come from. The default is to append $myhostname,
#    which is fine for small sites.  If you run a domain with multiple
#    machines, you should (1) change this to $mydomain and (2) set up
#    a domain-wide alias database that aliases each user to
#    user@that.users.mailhost.
#   
#    For the sake of consistency between sender and recipient addresses,
#    myorigin also specifies the default domain name that is appended
#    to recipient addresses that have no @domain part.
#
#  [*inet_interfaces*]
#    The inet_interfaces parameter specifies the network interface
#    addresses that this mail system receives mail on.  By default,
#    the software claims all active interfaces on the machine. The
#    parameter also controls delivery of mail to user@[ip.address].
#
#    See also the proxy_interfaces parameter, for network addresses that
#    are forwarded to us via a proxy or network address translator.
#
#    Note: you need to stop/start Postfix when this parameter changes.
#
#  [*proxy_interfaces*]
#    The proxy_interfaces parameter specifies the network interface
#    addresses that this mail system receives mail on by way of a
#    proxy or network address translation unit. This setting extends
#    the address list specified with the inet_interfaces parameter.
#
#    You must specify your proxy/NAT addresses when your system is a
#    backup MX host for other domains, otherwise mail delivery loops
#    will happen when the primary MX host is down.
#
#  [*mydestination*]
#    The mydestination parameter specifies the list of domains that this
#    machine considers itself the final destination for.
#    
#    These domains are routed to the delivery agent specified with the
#    local_transport parameter setting. By default, that is the UNIX
#    compatible delivery agent that lookups all recipients in /etc/passwd
#    and /etc/aliases or their equivalent.
#    
#    The default is $myhostname + localhost.$mydomain.  On a mail domain
#    gateway, you should also include $mydomain.
#    
#    Do not specify the names of domains that this machine is backup MX
#    host for. Specify those names via the relay_domains settings for
#    the SMTP server, or use permit_mx_backup if you are lazy (see
#    STANDARD_CONFIGURATION_README).
#    
#    The local machine is always the final destination for mail addressed
#    to user@[the.net.work.address] of an interface that the mail system
#    receives mail on (see the inet_interfaces parameter).
#    
#    Specify a list of host or domain names, /file/name or type:table
#    patterns, separated by commas and/or whitespace. A /file/name
#    pattern is replaced by its contents; a type:table is matched when
#    a name matches a lookup key (the right-hand side is ignored).
#    Continue long lines by starting the next line with whitespace.
#    
#  [*local_recipient_maps*]
#    The local_recipient_maps parameter specifies optional lookup tables
#    with all names or addresses of users that are local with respect
#    to $mydestination, $inet_interfaces or $proxy_interfaces.
#
#    If this parameter is defined, then the SMTP server will reject
#    mail for unknown local users. This parameter is defined by default.
#
#    To turn off local recipient checking in the SMTP server, specify
#    local_recipient_maps = (i.e. empty).
#
#    The default setting assumes that you use the default Postfix local
#    delivery agent for local delivery. You need to update the
#    local_recipient_maps setting if:
#
#    - You define $mydestination domain recipients in files other than
#      /etc/passwd, /etc/aliases, or the $virtual_alias_maps files.
#      For example, you define $mydestination domain recipients in
#      the $virtual_mailbox_maps files.
#
#    - You redefine the local delivery agent in master.cf.
#
#    - You redefine the "local_transport" setting in main.cf.
#
#    - You use the "luser_relay", "mailbox_transport", or "fallback_transport"
#      feature of the Postfix local delivery agent (see local(8)).
#
#    Details are described in the LOCAL_RECIPIENT_README file.
#
#    Beware: if the Postfix SMTP server runs chrooted, you probably have
#    to access the passwd file via the proxymap service, in order to
#    overcome chroot restrictions. The alternative, having a copy of
#    the system passwd file in the chroot jail is just not practical.
#
#    The right-hand side of the lookup tables is conveniently ignored.
#    In the left-hand side, specify a bare username, an @domain.tld
#    wild-card, or specify a user@domain.tld address.
#
#  [*unknown_local_recipient_reject_code*]
#    The unknown_local_recipient_reject_code specifies the SMTP server
#    response code when a recipient domain matches $mydestination or
#    ${proxy,inet}_interfaces, while $local_recipient_maps is non-empty
#    and the recipient address or address local-part is not found.
#
#    The default setting is 550 (reject mail) but it is safer to start
#    with 450 (try again later) until you are certain that your
#    local_recipient_maps settings are OK.
#    default: 550
#
#  [*mynetworks_style*]
#    The mynetworks parameter specifies the list of "trusted" SMTP
#    clients that have more privileges than "strangers".
#
#    In particular, "trusted" SMTP clients are allowed to relay mail
#    through Postfix.  See the smtpd_recipient_restrictions parameter
#    in postconf(5).
#
#    You can specify the list of "trusted" network addresses by hand
#    or you can let Postfix do it for you (which is the default).
#
#    By default (mynetworks_style = subnet), Postfix "trusts" SMTP
#    clients in the same IP subnetworks as the local machine.
#    On Linux, this does works correctly only with interfaces specified
#    with the "ifconfig" command.
#
#    Specify "mynetworks_style = class" when Postfix should "trust" SMTP
#    clients in the same IP class A/B/C networks as the local machine.
#    Don't do this with a dialup site - it would cause Postfix to "trust"
#    your entire provider's network.  Instead, specify an explicit
#    mynetworks list by hand, as described below.
#
#    Specify "mynetworks_style = host" when Postfix should "trust"
#    only the local machine.
#
#  [*mynetworks*]
#    Alternatively, you can specify the mynetworks list by hand, in
#    which case Postfix ignores the mynetworks_style setting.
#
#    Specify an explicit list of network/netmask patterns, where the
#    mask specifies the number of bits in the network part of a host
#    address.
#
#    You can also specify the absolute pathname of a pattern file instead
#    of listing the patterns here. Specify type:table for table-based lookups
#    (the value on the table right-hand side is not used).
#    default: 127.0.0.0/8
#
#  [*relay_domains*]
#     The relay_domains parameter restricts what destinations this system will
#     relay mail to.  See the smtpd_recipient_restrictions description in
#     postconf(5) for detailed information.
#    
#     By default, Postfix relays mail
#     - from "trusted" clients (IP address matches $mynetworks) to any destination,
#     - from "untrusted" clients to destinations that match $relay_domains or
#       subdomains thereof, except addresses with sender-specified routing.
#     The default relay_domains value is $mydestination.
#    
#     In addition to the above, the Postfix SMTP server by default accepts mail
#     that Postfix is final destination for:
#     - destinations that match $inet_interfaces or $proxy_interfaces,
#     - destinations that match $mydestination
#     - destinations that match $virtual_alias_domains,
#     - destinations that match $virtual_mailbox_domains.
#     These destinations do not need to be listed in $relay_domains.
#    
#     Specify a list of hosts or domains, /file/name patterns or type:name
#     lookup tables, separated by commas and/or whitespace.  Continue
#     long lines by starting the next line with whitespace. A file name
#     is replaced by its contents; a type:name table is matched when a
#     (parent) domain appears as lookup key.
#    
#     NOTE: Postfix will not automatically forward mail for domains that
#     list this system as their primary or backup MX host. See the
#     permit_mx_backup restriction description in postconf(5).
#     default: $mydestination
#
#  [*relayhost*]
#    The relayhost parameter specifies the default host to send mail to
#    when no entry is matched in the optional transport(5) table. When
#    no relayhost is given, mail is routed directly to the destination.
#   
#    On an intranet, specify the organizational domain name. If your
#    internal DNS uses no MX records, specify the name of the intranet
#    gateway host instead.
#   
#    In the case of SMTP, specify a domain, host, host:port, [host]:port,
#    [address] or [address]:port; the form [host] turns off MX lookups.
#   
#    If you're connected via UUCP, see also the default_transport parameter.
#
#  [*relay_recipient_map*]
#    The relay_recipient_maps parameter specifies optional lookup tables
#    with all addresses in the domains that match $relay_domains.
#
#    If this parameter is defined, then the SMTP server will reject
#    mail for unknown relay users. This feature is off by default.
#
#    The right-hand side of the lookup tables is conveniently ignored.
#    In the left-hand side, specify an @domain.tld wild-card, or specify
#    a user@domain.tld address.
#    default: hash:/etc/postfix/relay_recipients
#
#  [*in_flow_delay*]
#    The in_flow_delay configuration parameter implements mail input
#    flow control. This feature is turned on by default, although it
#    still needs further development (it's disabled on SCO UNIX due
#    to an SCO bug).
#
#    A Postfix process will pause for $in_flow_delay seconds before
#    accepting a new message, when the message arrival rate exceeds the
#    message delivery rate. With the default 100 SMTP server process
#    limit, this limits the mail inflow to 100 messages a second more
#    than the number of messages delivered per second.
#
#    Specify 0 to disable the feature. Valid delays are 0..10.
#    default: 1s
#
#  [*alias_maps*]
#    The alias_maps parameter specifies the list of alias databases used
#    by the local delivery agent. The default list is system dependent.
#
#    On systems with NIS, the default is to search the local alias
#    database, then the NIS alias database. See aliases(5) for syntax
#    details.
#
#    If you change the alias database, run "postalias /etc/aliases" (or
#    wherever your system stores the mail alias file), or simply run
#    "newaliases" to build the necessary DBM or DB file.
#
#    It will take a minute or so before changes become visible.  Use
#    "postfix reload" to eliminate the delay.
#
#  [*alias_database*]
#    The alias_database parameter specifies the alias database(s) that
#    are built with "newaliases" or "sendmail -bi".  This is a separate
#    configuration parameter, because alias_maps (see above) may specify
#    tables that are not necessarily all under control by Postfix.
#
#  [*home_mailbox*]
#    The home_mailbox parameter specifies the optional pathname of a
#    mailbox file relative to a user's home directory. The default
#    mailbox file is /var/spool/mail/user or /var/mail/user.  Specify
#    "Maildir/" for qmail-style delivery (the / is required).
#
#  [*mail_spool_directory*]
#    The mail_spool_directory parameter specifies the directory where
#    UNIX-style mailboxes are kept. The default setting depends on the
#    system type.
#
#  [*mailbox_command*]
#    The mailbox_command parameter specifies the optional external
#    command to use instead of mailbox delivery. The command is run as
#    the recipient with proper HOME, SHELL and LOGNAME environment settings.
#    Exception:  delivery for root is done as $default_user.
#   
#    Other environment variables of interest: USER (recipient username),
#    EXTENSION (address extension), DOMAIN (domain part of address),
#    and LOCAL (the address localpart).
#   
#    Unlike other Postfix configuration parameters, the mailbox_command
#    parameter is not subjected to $parameter substitutions. This is to
#    make it easier to specify shell syntax (see example below).
#   
#    Avoid shell meta characters because they will force Postfix to run
#    an expensive shell process. Procmail alone is expensive enough.
#   
#    IF YOU USE THIS TO DELIVER MAIL SYSTEM-WIDE, YOU MUST SET UP AN
#    ALIAS THAT FORWARDS MAIL FOR ROOT TO A REAL USER.
#
#  [*mailbox_transport*]
#    The mailbox_transport specifies the optional transport in master.cf
#    to use after processing aliases and .forward files. This parameter
#    has precedence over the mailbox_command, fallback_transport and
#    luser_relay parameters.
#
#    Specify a string of the form transport:nexthop, where transport is
#    the name of a mail delivery transport defined in master.cf.  The
#    :nexthop part is optional. For more details see the sample transport
#    configuration file.
#
#    NOTE: if you use this feature for accounts not in the UNIX password
#    file, then you must update the "local_recipient_maps" setting in
#    the main.cf file, otherwise the SMTP server will reject mail for
#    non-UNIX accounts with "User unknown in local recipient table".
#
#  [*fallback_transport*]
#    The fallback_transport specifies the optional transport in master.cf
#    to use for recipients that are not found in the UNIX passwd database.
#    This parameter has precedence over the luser_relay parameter.
#   
#    Specify a string of the form transport:nexthop, where transport is
#    the name of a mail delivery transport defined in master.cf.  The
#    :nexthop part is optional. For more details see the sample transport
#    configuration file.
#   
#    NOTE: if you use this feature for accounts not in the UNIX password
#    file, then you must update the "local_recipient_maps" setting in
#    the main.cf file, otherwise the SMTP server will reject mail for
#    non-UNIX accounts with "User unknown in local recipient table".
#
#  [*luser_relay*]
#    The luser_relay parameter specifies an optional destination address
#    for unknown recipients.  By default, mail for unknown@$mydestination,
#    unknown@[$inet_interfaces] or unknown@[$proxy_interfaces] is returned
#    as undeliverable.
#   
#    The following expansions are done on luser_relay: $user (recipient
#    username), $shell (recipient shell), $home (recipient home directory),
#    $recipient (full recipient address), $extension (recipient address
#    extension), $domain (recipient domain), $local (entire recipient
#    localpart), $recipient_delimiter. Specify ${name?value} or
#    ${name:value} to expand value only when $name does (does not) exist.
#   
#    luser_relay works only for the default Postfix local delivery agent.
#   
#    NOTE: if you use this feature for accounts not in the UNIX password
#    file, then you must specify "local_recipient_maps =" (i.e. empty) in
#    the main.cf file, otherwise the SMTP server will reject mail for
#    non-UNIX accounts with "User unknown in local recipient table".
#
#  [*header_checks*]
#    The controls listed here are only a very small subset. The file
#    SMTPD_ACCESS_README provides an overview.
#   
#    The header_checks parameter specifies an optional table with patterns
#    that each logical message header is matched against, including
#    headers that span multiple physical lines.
#   
#    By default, these patterns also apply to MIME headers and to the
#    headers of attached messages. With older Postfix versions, MIME and
#    attached message headers were treated as body text.
#   
#    For details, see "man header_checks".
#
#  [*fast_flush_domains*]
#    Postfix maintains per-destination logfiles with information about
#    deferred mail, so that mail can be flushed quickly with the SMTP
#    "ETRN domain.tld" command, or by executing "sendmail -qRdomain.tld".
#    See the ETRN_README document for a detailed description.
#    
#    The fast_flush_domains parameter controls what destinations are
#    eligible for this service. By default, they are all domains that
#    this server is willing to relay mail to.
#
#  [*smtpd_banner*]
#    The smtpd_banner parameter specifies the text that follows the 220
#    code in the SMTP server's greeting banner. Some people like to see
#    the mail version advertised. By default, Postfix shows no version.
#
#    You MUST specify $myhostname at the start of the text. That is an
#    RFC requirement. Postfix itself does not care.
#
#  [*local_destination_concurrency_limit*]
#    How many parallel deliveries to the same user or domain? With local
#    delivery, it does not make sense to do massively parallel delivery
#    to the same user, because mailbox updates must happen sequentially,
#    and expensive pipelines in .forward files can cause disasters when
#    too many are run at the same time. With SMTP deliveries, 10
#    simultaneous connections to the same domain could be sufficient to
#    raise eyebrows.
#   
#    Each message delivery transport has its XXX_destination_concurrency_limit
#    parameter.  The default is $default_destination_concurrency_limit for
#    most delivery transports. For the local delivery agent the default is 2.
#    default: 2
#
#  [*default_destination_concurrency_limit*]
#    default: 20
#
#  [*debug_peer_level*]
#    The debug_peer_level parameter specifies the increment in verbose
#    logging level when an SMTP client or server host name or address
#    matches a pattern in the debug_peer_list parameter.
#
#  [*debug_peer_list*]
#    The debug_peer_list parameter specifies an optional list of domain
#    or network patterns, /file/name patterns or type:name tables. When
#    an SMTP client or server host name or address matches a pattern,
#    increase the verbose logging level by the amount specified in the
#    debug_peer_level parameter.
class postfix::config (
  $myorigin                            = $domain,
  $mydestination                       = undef,
  $filepath                            = '/etc/postfix/main.cf',
  $soft_bounce                         = 'no',
  $queue_directory                     = '/var/spool/postfix',
  $command_directory                   = '/usr/sbin',
  $daemon_directory                    = '/usr/lib/postfix',
  $data_directory                      = '/var/lib/postfix',
  $mail_owner                          = 'postfix',
  $default_privs                       = 'nobody',
  $myhostname                          = $hostname,
  $mydomain                            = $domain,
  $inet_interfaces                     = 'all',
  $proxy_interfaces                    = undef,
  $local_recipient_maps                = undef,
  $local_destination_concurrency_limit = 2,
  $default_destination_concurrency_limit = 20,
  $unknown_local_recipient_reject_code = 550,
  $mynetworks_style                    = 'host',
  $mynetworks                          = undef,
  $relay_domains                       = $mydestination,
  $relayhost                           = $mydomain,
  $relay_recipient_maps                = undef,
  $in_flow_delay                       = '1s',
  $alias_maps                          = undef,
  $alias_database                      = undef,
  $recipient_delimeter                 = '+',
  $home_mailbox                        = 'Mailbox',
  $mail_spool_directory                = '/var/spool/mail',
  $mailbox_command                     = undef,
  $mailbox_transport                   = undef,
  $fallback_transport                  = undef,
  $luser_relay                         = undef,
  $header_checks                       = 'regexp:/etc/postfix/header_checks',
  $fast_flush_domains                  = undef,
  $smtpd_banner                        = "$myhostname ESMPT $mail_name ${osfamily}"
) {

  # needs to have postfix
  include 'postfix'

  # allow user pass in array of data
  if ($mydestination == undef) {
    $mydestinations = []
  } else {
    $mydestinations = any2array($mydestination)
  }

  $relay_domains_array  = any2array($relay_domains)

  if ($myorigin == undef) {
    notice("WARNING: By default, the $myorigin parameter tries to use the domain name of the server, but this machine does not have a domain as accesible via facter ($domain) so we will use the machine hostname") 
    $myorigin = $hostname
  }

#  if ($smtpd_banner) {
#    #validate_re($smtpd_banner, '^($myhostname)', "The smtpd_banner: ${smtpd_banner} is missing the RFC required hostname")
#  }

  validate_re($soft_bounce, '^(yes|no)$',
    "${soft_bounce} is not supported for soft_bounce. Allowed values are 'yes' and 'no'.")
  # conditional on non definition of mynetworks
  if($mynetworks_style) {
    validate_re($mynetworks_style, '^(class|subnet|host)$',
    "${mynetworks_style} is not supported for mynetworks_style. Allowed values are 'class', 'subnet' and 'host'")
  } 

  if ($mynetworks_style and $mynetworks) {
     notice("You have specified both $mynetworks_style and $mynetworks so postfix will ignore $mynetworks_style and only use $mynetworks which is ${mynetworks}")
  } 
  
  validate_absolute_path($filepath)
  validate_absolute_path($queue_directory)
  validate_absolute_path($command_directory)
  validate_absolute_path($daemon_directory)
  validate_absolute_path($data_directory)

  validate_string($mail_owner)
  validate_string($default_privs)

  validate_string($myhostname)
  validate_string($mydomain)

  concat { $filepath:
    ensure  => present,
    mode    => '0644',
    notify  => Class['Postfix::Service'],
    require => Class['postfix'],
  }   

  concat::fragment { 'postfix config header':
    ensure  => present,
    content => template('postfix/header.erb'),
    target  => $filepath,
    order   => '00',
  }

  concat::fragment { 'postfix_soft_bounce':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/soft_bounce.erb'),
  }

  concat::fragment { 'postfix_local_path_information':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/local_path_information.erb'),
  }

  concat::fragment { 'postfix_queue_and_process_ownership':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/queue_and_process_ownership.erb'),
  }

  concat::fragment { 'postfix_internet_host_and_domain_names':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/internet_host_and_domain_names.erb'),
    order   => '01',
  }

  concat::fragment { 'postfix_sending_mail':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/sending_mail.erb'),
    order   => '02',
  }

  concat::fragment { 'postfix_receiving_mail':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/receiving_mail.erb'),
    order   => '03',
  }

  concat::fragment { 'postfix_rejecting_mail_for_unknown_local_users':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/rejecting_mail_for_unknown_local_users.erb'),
    order   => '05',
  }

  concat::fragment { 'postfix_trust_and_relay_control':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/trust_and_relay_control.erb'),
    order   => '04',
  }

  concat::fragment { 'postfix_internet_or_intranet':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/internet_or_intranet.erb'),
  }

  concat::fragment { 'postfix_rejecting_unknown_relay_users':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/rejecting_unknown_relay_users.erb'),
  }

  concat::fragment { 'postfix_input_rate_control':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/input_rate_control.erb'),
  }

  concat::fragment { 'postfix_alias_database':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/alias_database.erb'),
  }

  concat::fragment { 'postfix_delivery_to_mailbox':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/delivery_to_mailbox.erb'),
  }

  concat::fragment { 'postfix_junk_mail_controls':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/junk_mail_controls.erb'),
  }

  concat::fragment { 'postfix_fast_etrn_service':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/fast_etrn_service.erb'),
  }

  concat::fragment { 'postfix_show_software_version_or_not':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/show_software_version_or_not.erb'),
  }

  concat::fragment { 'postfix_parallel_delivery_to_the_same_destination':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/parallel_delivery_to_the_same_destination.erb'),
  }

  concat::fragment { 'postfix_debugging_control':
    ensure  => present,
    target  => $filepath,
    content => template('postfix/debugging_control.erb'),
  }
}
