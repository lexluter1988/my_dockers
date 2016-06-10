# Folder 'Include'
Contain site.pp, place it in your /etc/puppet/manifests/
And fire 'puppet apply /etc/puppet/manifests/site.pp'

# Folder 'Src'
Contain 'httpd' and 'mysqld' forks with my backup and upload scripts.
Both can be build-ed simply from directory.
