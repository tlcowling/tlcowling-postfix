# Example configuration for postfix
#
# Standard installation as a domain-wide mail server
# will install postfix and the configuration will use the following standards:
# 
#  myhostname       = The facter fqdn
#  mydomain         = the facter domain name
#  myorigin         = $mydomain    (the user will be: "user@$mydomain")
#  mydestination    = $myhostname localhost.$mydomain localhost $mydomain
#  mynetworks       = 127.0.0.0/8  (Only local to start with)
#  inet_interfaces  = all
#  relay_domains    = undef        (Safe: NEVER forward mail from strangers)
#  relay_host       = $mydomain    (Deliver via local mailhub for the domain)
#  proxy_interfaces = undef        (Proxy_interface not configured)

include 'postfix'
