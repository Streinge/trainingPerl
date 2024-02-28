#!/usr/bin/perl -w
use DBI;
use lib '.';
require 'io_cgi.pl';
use strict;
use HTML::Template;
use Data::Dumper;
use CGI;
use Exporter;
use sofonov_group_list;

# создаем объект класса и парсим все параметры 
my $io_cgi = 'io_cgi'->new;

$io_cgi->get_params();
# получаем значение конкретного параметра
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

my $sth = $dbh->prepare("DELETE FROM `webprog5_sofonov_group_list` WHERE id = ?") 
          or die "prepare statement failed: $dbh->errstr()";

$sth->execute($id) or die "execution failed: $dbh->errstr()";
$sth->finish();

$dbh->disconnect();

# вызов процедуры обновления списка групп из sofonov_group_list
group_list;
