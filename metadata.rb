name 'vra-iaas-cookbook'
maintainer 'JJ Asghar'
maintainer_email 'jj@chef.io'
license 'Apache-2.0'
description 'Installs/Configures vra-iaas-cookbook'
long_description 'Installs/Configures vra-iaas-cookbook'
version '0.1.0' # TODO: make sure your version is correct

chef_version '>= 12'

# TODO: any Dependacies?
# depends 'chefdk', '> 1.0.0'

# TODO: Platform support....
%w(ubuntu debian redhat centos suse opensuse).each do |os|
  supports os
end

issues_url 'https://github.com/jjasghar/vra-iaas-cookbook/issues'
source_url 'https://github.com/jjasghar/vra-iaas-cookbook'
