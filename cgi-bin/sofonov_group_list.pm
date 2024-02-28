#!/usr/bin/perl -w
use DBI;
use strict;
use warnings;
use 5.010;
use HTML::Template;
use Data::Dumper;
use CGI;
use Exporter;
our @ISA= qw( Exporter );
our @EXPORT_OK = qw( group_list );
# these are exported by default.
our @EXPORT = qw( group_list  );

sub group_list
{
  # Подключение к БД
  my $attr = {PrintError => 0, RaiseError => 0};
  my $data_source = "DBI:mysql:webprog5_sofonovtgbot:localhost";
  my $username = "webprog5_sofonov";
  my $password = 'tr@Ns1tt';
  my $dbh = DBI->connect($data_source, $username, $password, $attr);
  my $CGI = CGI->new();

  if (!$dbh) { die $DBI::errstr; }
  $dbh->do('SET NAMES cp1251');

  my $sth;

  $sth = $dbh->prepare("SELECT id, group_name FROM `webprog5_sofonov_group_list`") 
         or die "prepare statement failed: $dbh->errstr()";
  $sth->execute() or die "execution failed: $dbh->errstr()";

  # prepare a data structure for HTML::Template
  my $rows;

  while ($_ = $sth->fetchrow_hashref())
  {
    push @{$rows}, $_;
  }

  my $i = 0;
  my $group_id;
  my $length = @{$rows};
  my $href_str = '<a href="http://webprogsofonov.trudogolik.ru/cgi-bin/';

  for ($i = 0; $i <= $length - 1; $i++)
  {
    $group_id = $rows->[$i]->{'id'};
    $rows->[$i]->{'students'}  = $href_str . 'sofonov_student.pl?id=' . $group_id . '">Students</a>';
    $rows->[$i]->{'homeworks'} = $href_str . 'sofonov_homeworks.pl?id=' . $group_id . '">Homeworks</a>';
    $rows->[$i]->{'results'}   = $href_str . 'sofonov_results.pl?id=' . $group_id . '">Results</a>';
    $rows->[$i]->{'delete'}    = $href_str . 'sofonov_delete.pl?id=' . $group_id . '">Delete</a>';  
  }

  # instantiate the template and substitute the values
  my $template = HTML::Template->new(filename => 'sofonov_group_list.html');

  $template->param(ROWS => $rows);
  print $CGI->header();
  print $template->output();
  $dbh->disconnect();
}

1;