package App::CPANIDX::Tables;

use strict;
use warnings;
use vars qw[$VERSION];

$VERSION = '0.06';

my $tables = {
   mods => [
      'mod_name VARCHAR(300) NOT NULL',
      'dist_name VARCHAR(190) NOT NULL',
      'dist_vers VARCHAR(20)',
      'cpan_id VARCHAR(20) NOT NULL',
      'mod_vers VARCHAR(30)',
    ],
   dists => [
      'dist_name VARCHAR(190) NOT NULL',
      'cpan_id VARCHAR(20) NOT NULL',
      'dist_file VARCHAR(400) NOT NULL',
      'dist_vers VARCHAR(20)',
    ],
   auths => [
      'cpan_id VARCHAR(20) NOT NULL',
      'fullname VARCHAR(60) NOT NULL',
      'email TEXT',
    ],
   timestamp => [
      'timestamp VARCHAR(30) NOT NULL',
   ],
};

sub table {
  return unless @_;
  my $table = shift;
  $table = shift if $table->isa(__PACKAGE__);
  return unless $table;
  return unless exists $tables->{ $table };
  my $sql = 'CREATE TABLE IF NOT EXISTS ' . $table . ' ( ';
  $sql .= join ', ', @{ $tables->{$table} };
  $sql .= ' )';
  return $sql;
}

sub tables {
  return sort keys %{ $tables };
}

1;

__END__

=head1 NAME

App::CPANIDX::Tables - Provide table definitions for App::CPANIDX

=head1 SYNOPSIS

  my @tables = App::CPANIDX::Tables->tables();

  my $sql = App::CPANIDX::Tables->table('dists');

=head1 DESCRIPTION

App::CPANIDX::Tables provides the SQL to create the tables that App::CPANIDX uses.

=head1 FUNCTIONS

=over

=item C<tables>

Returns a list of the available tables.

=item C<table>

Takes one argument, the name of a table to lookup.

Returns a SQL statement that can be used to create the table.

=back

=head1 AUTHOR

Chris C<BinGOs> Williams <chris@bingosnet.co.uk>

=head1 LICENSE

Copyright E<copy> Chris Williams

This module may be used, modified, and distributed under the same terms as Perl itself. Please see the license that came with your Perl distribution for details.

=head1 SEE ALSO

L<App::CPANIDX>

=cut
