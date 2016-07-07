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

  case $::lsbdistcodename {
    'precise': {
      ::apt::ppa { 'ppa:forger/phantomjs': } ->
      ::apt::pin { 'forger-phantomjs':
        originator => "LP-PPA-forger-phantomjs",
        priority   => 600,
        before     => Package['phantomjs'],
      }
    }
    'trusty': {
      ::apt::ppa { 'ppa:beezly/phantomjs': } ->
      ::apt::pin { 'beezly-phantomjs':
        originator => "LP-PPA-beezly-phantomjs",
        priority   => 600,
        before     => Package['phantomjs'],
      }
    }
  }

  package { 'phantomjs':
    ensure  => $ensure,
    require => Class['apt::update'],
  }
}
