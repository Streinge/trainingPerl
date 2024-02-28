#!/usr/bin/perl -w
use DBI;
use lib '.';
require 'io_cgi.pl';
use strict;
use HTML::Template;
use Data::Dumper;
use CGI;
use sofonov_group_list;

# создаем объект класса и парсим все параметры 
my $io_cgi = 'io_cgi'->new;

$io_cgi->get_params();
# получаем значение конкретного параметра
my $id_chat = $io_cgi->param('id_chat');
my $group_name = $io_cgi->param('group_name');

# Подключение к БД
my $attr = {PrintError => 0, RaiseError => 0};
my $data_source = "DBI:mysql:webprog5_sofonovtgbot:localhost";
my $username = "webprog5_sofonov";
my $password = 'tr@Ns1tt';
my $dbh = DBI->connect($data_source, $username, $password, $attr);
my $CGI = CGI->new();

if (!$dbh) { die $DBI::errstr; }
$dbh->do('SET NAMES cp1251');

my $sth = $dbh->prepare("INSERT INTO `webprog5_sofonov_group_list` SET group_name = ?, chat_number = ?") 
          or die "prepare statement failed: $dbh->errstr()";

$sth->execute($group_name, $id_chat) or die "execution failed: $dbh->errstr()";
$sth->finish();

$dbh->disconnect();

# вызов процедуры обновления списка групп из sofonov_group_list
group_list;
