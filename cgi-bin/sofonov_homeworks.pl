#!/usr/bin/perl -w
use DBI;
use lib '.';
require 'io_cgi.pl';
use strict;
use HTML::Template;
use Data::Dumper;
use CGI;

# создаем объект класса и парсим все параметры 
my $io_cgi = 'io_cgi'->new;

$io_cgi->get_params();
# получаем значение id группы
my $id = $io_cgi->param('id');

# Подключение к БД
my $attr = {PrintError => 0, RaiseError => 0};
my $data_source = "DBI:mysql:webprog5_sofonovtgbot:localhost";
my $username = "webprog5_sofonov";
my $password = 'tr@Ns1tt';
my $dbh = DBI->connect($data_source, $username, $password, $attr);
my $CGI = CGI->new();

if (!$dbh) { die $DBI::errstr; }
$dbh->do('SET NAMES cp1251');

my $sth = $dbh->prepare("SELECT homework, user_name, webprog5_sofonov_student.group_list_id AS grou_id, point, on_time 
                  FROM `webprog5_sofonov_order_homeworks`, `webprog5_sofonov_student` 
                  WHERE webprog5_sofonov_order_homeworks.student_id = webprog5_sofonov_student.id
                  AND webprog5_sofonov_student.group_list_id = ?
                  ORDER BY homework, webprog5_sofonov_student.user_name ") 
          or die "prepare statement failed: $dbh->errstr()";

$sth->execute($id) or die "execution failed: $dbh->errstr()";

# prepare a data structure for HTML::Template
my $rows = [];

push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();

# instantiate the template and substitute the values
my $template = HTML::Template->new(filename => 'sofonov_homeworks.html', die_on_bad_params => 0);

$template->param(ROWS => $rows);

print $CGI->header();
print $template->output();
$sth->finish();
$dbh->disconnect();