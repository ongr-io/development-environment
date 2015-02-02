#!/bin/bash
# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=/etc/puppet/
$(which git > /dev/null 2>&1)
FOUND_GIT=$?
cat /vagrant/provision/hello.txt
if [[ ! -d "$PUPPET_DIR" ]]; then
    mkdir -p "$PUPPET_DIR"
    echo "Created directory ~/.puppet"
fi
if [[ ! -f "${PUPPET_DIR}first-update" ]]; then
      echo 'Running first time update..'
      apt-get update > /dev/null
      touch "${PUPPET_DIR}first-update"
      echo 'Finished first time update'
fi
if [ "$FOUND_GIT" -ne '0' ]; then
    echo 'Installing git..'
    apt-get -q -y install git-core >/dev/null
    echo 'Finished installing git'
fi
echo "Copying puppet config files.."
cp -rf "/vagrant/provision/Puppetfile" "$PUPPET_DIR"
cp -rf "/vagrant/provision/Puppetfile.lock" "$PUPPET_DIR"
if [[ ! -f "${PUPPET_DIR}required-packages-installed" ]]; then
    echo 'Installing base packages for librarian..'
    apt-get install -y build-essential ruby-dev >/dev/null
    touch "${PUPPET_DIR}required-packages-installed"
    echo 'Finished installing base packages for librarian'
fi
if [[ ! -f "${PUPPET_DIR}librarian-puppet-installed" ]]; then
    echo 'Installing librarian-puppet'
    gem install librarian-puppet > /dev/null
    gem install bundler > /dev/null
    touch "${PUPPET_DIR}librarian-puppet-installed"
    echo 'Finished installing librarian-puppet'
fi
echo 'Running initial librarian-puppet..'
cd "$PUPPET_DIR" && librarian-puppet install --verbose
echo 'Finished running initial librarian-puppet'
