use strict;
use warnings;
use Test::More;

my $tests = {
  auths => 'CREATE TABLE IF NOT EXISTS auths ( cpan_id VARCHAR(20) NOT NULL, fullname VARCHAR(60) NOT NULL, email TEXT )',
  dists => 'CREATE TABLE IF NOT EXISTS dists ( dist_name VARCHAR(190) NOT NULL, cpan_id VARCHAR(20) NOT NULL, dist_file VARCHAR(400) NOT NULL, dist_vers VARCHAR(20) )',
  mods => 'CREATE TABLE IF NOT EXISTS mods ( mod_name VARCHAR(300) NOT NULL, dist_name VARCHAR(190) NOT NULL, dist_vers VARCHAR(20), cpan_id VARCHAR(20) NOT NULL, mod_vers VARCHAR(30) )',
  timestamp => 'CREATE TABLE IF NOT EXISTS timestamp ( timestamp VARCHAR(30) NOT NULL )',
  tmp_auths => 'CREATE TABLE IF NOT EXISTS tmp_auths ( cpan_id VARCHAR(20) NOT NULL, fullname VARCHAR(60) NOT NULL, email TEXT )',
  tmp_dists => 'CREATE TABLE IF NOT EXISTS tmp_dists ( dist_name VARCHAR(190) NOT NULL, cpan_id VARCHAR(20) NOT NULL, dist_file VARCHAR(400) NOT NULL, dist_vers VARCHAR(20) )',
  tmp_mods => 'CREATE TABLE IF NOT EXISTS tmp_mods ( mod_name VARCHAR(300) NOT NULL, dist_name VARCHAR(190) NOT NULL, dist_vers VARCHAR(20), cpan_id VARCHAR(20) NOT NULL, mod_vers VARCHAR(30) )',
};

plan tests => 2 + ( scalar keys %$tests );

use_ok('App::CPANIDX::Tables');

my @origs = sort keys %$tests;
my @types = sort App::CPANIDX::Tables->tables();

is_deeply( \@origs, \@types, 'We got the right tables back' );

foreach my $table ( sort keys %$tests ) {
  my $sql = App::CPANIDX::Tables->table( $table );
  is( $sql, $tests->{$table}, qq{SQL for '$table' is correct} );
}
