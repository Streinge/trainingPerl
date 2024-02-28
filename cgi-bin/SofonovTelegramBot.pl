use strict;
use warnings;
use 5.010;
use utf8;
use open qw(:std :utf8);
use FindBin qw( $Bin );
use lib $Bin;
use WebProgTelegramClient;

my $token = '5579939015:AAFJq9Sz0TSZp-NFxRr9_K8QE9Z7dsshymY';
my $tg = WebProgTelegramClient->new(token => $token);
# получаем массив с сообщениями
my @new_messages = @{$tg->read_chat(chat_id => -877082195)};
# массив новых членов группы
my @new_users = ();
# массив юзеров, покинувших группу
my @left_users =();

# перебираем элементы входящего массива для поиска юзеров,
# которые вступили в группу и которые покинули группу
foreach my $update_messages (@new_messages)
{
  # перебираем ключи в хеше 'message'
  my @message_keys = keys %{ $update_messages->{'message'} };
  
  # проверяем есть ли среди ключей ключ 'new_chat_member' или 'left_chat_member'
  # и записываем в соответствующие массивы
  foreach (@message_keys)
  {
    if ($_ eq 'new_chat_member')
    {
      my $connected_user = $update_messages->{'message'}->{'new_chat_member'}->{'first_name'};

      push @new_users, $connected_user;
    }
    elsif($_ eq 'left_chat_member')
    {
      my $departed_user = $update_messages->{'message'}->{'left_chat_member'}->{'first_name'};

      push @left_users, $departed_user;
    }
  }
}

# ищем юзеров, которые написали текстовое сообщение
foreach my $update_messages (@new_messages)
{
  my @message_keys = keys %{ $update_messages->{'message'} };

  # ищем сообщения в которых есть ключ 'text'
  foreach (@message_keys)
  {
    if ($_ eq 'text')
    {
      foreach my $name (@new_users)
      {
        # проверка условия, что юзер, написал сообщение и он является новым членом группы
        # есил да, то отправляем сообщение в тестовую группу
        if ( $name eq $update_messages->{'message'}->{'from'}->{'first_name'} )
        {
          my $result = $tg->call( 'sendMessage', {chat_id => -877082195, text => "Привет,  $name !"} );
        }
      }
      foreach my $name_left (@left_users)
      {
        # проверка условия, что юзер, написал сообщение и покинулгруппу
        # есил да, то отправляем сообщение в тестовую группу
        if ( $name_left eq $update_messages->{'message'}->{'from'}->{'first_name'} )
        {
          my $result = $tg->call( 'sendMessage', {chat_id => -877082195, text => "Желаем удачи,  $name_left !"} );
        }
      }  
    } 
  }
}
