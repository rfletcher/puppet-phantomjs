# == Class: phantomjs
#
# Installs (or removes) PhantomJS
#
# === Parameters
#
# [*ensure*]
#   Any value $ensure value for a Package resource (present, absent, etc.)
#
# === Examples
#
#  class { 'phantomjs':
#    ensure => present,
#  }
#
# === Authors
#
# Rick Fletcher <fletch@pobox.com>
#
# === Copyright
#
# Copyright 2014 Rick Fletcher
#
class phantomjs (
  $ensure = 'present',
) {
  include ::apt

  ::apt::ppa { 'ppa:forger/phantomjs': } ->
  ::apt::pin { 'forger-phantomjs':
    originator => "LP-PPA-forger-phantomjs",
    priority   => 600,
  } ->

  package { 'phantomjs':
    ensure  => $ensure,
    require => Class['apt::update'],
  }
}
