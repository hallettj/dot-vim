include gcc
include git
include nodejs

class { 'apt': }

$vimruntime = "${home}/.vim"

ensure_packages([
  'vim-gnome',
  'puppet-lint',
  'cmake',
  'python-dev',
  'silversearcher-ag'
])

git::repo { 'neobundle':
  path   => "${vimruntime}/bundle/neobundle.vim",
  source => 'https://github.com/Shougo/neobundle.vim.git',
  branch => 'master',
  owner  => $user
}

exec { 'install-plugins':
  command     => "${vimruntime}/bundle/neobundle.vim/bin/neoinstall",
  cwd         => $home,
  user        => $user,
  provider    => shell,
  timeout     => 0,
  environment => [ "HOME=${home}" ]
}

# TODO: The 'npm' provider is not working at the moment.

#package { 'jshint':
#  ensure   => latest,
#  provider => 'npm'
#}

#package { 'jsctags':
#  ensure   => latest,
#  provider => 'npm'
#}

exec { 'install-jshint':
  command     => "npm install -g jshint",
  provider    => shell,
  creates     => '/usr/local/bin/jshint',
  environment => [ "HOME=${home}" ]
}

exec { 'install-jsctags':
  command     => "npm install -g jsctags",
  provider    => shell,
  creates     => '/usr/local/bin/jsctags',
  environment => [ "HOME=${home}" ]
}

exec { 'install-tern':
  command     => "npm install",
  cwd         => "${vimruntime}/bundle/tern_for_vim/",
  user        => $user,
  provider    => shell,
  environment => [ "HOME=${home}" ]
}

exec { 'YouCompleteMe-submodules':
  command     => "git submodule update --init",
  cwd         => "${vimruntime}/bundle/YouCompleteMe/",
  user        => $user,
  provider    => shell,
  timeout     => 1800,
  environment => [ "HOME=${home}" ]
}

exec { 'compile-YouCompleteMe':
  command     => "bash install.sh",
  cwd         => "${vimruntime}/bundle/YouCompleteMe/",
  user        => $user,
  provider    => shell,
  timeout     => 1800,
  environment => [ "HOME=${home}" ]
}

Package['vim-gnome']   -> Exec['install-plugins']
Git::Repo['neobundle'] -> Exec['install-plugins']

Exec['install-plugins'] -> Exec['install-tern']
Exec['install-plugins'] -> Exec['YouCompleteMe-submodules']
Exec['install-plugins'] -> Exec['compile-YouCompleteMe']

Class['nodejs'] -> Exec['install-tern']
Class['nodejs'] -> Exec['install-jsctags']
Class['nodejs'] -> Exec['install-jshint']

Class['git']                     -> Exec['YouCompleteMe-submodules']
Exec['YouCompleteMe-submodules'] -> Exec['compile-YouCompleteMe']
Class['gcc']                     -> Exec['compile-YouCompleteMe']
Package['cmake']                 -> Exec['compile-YouCompleteMe']
Package['python-dev']            -> Exec['compile-YouCompleteMe']
