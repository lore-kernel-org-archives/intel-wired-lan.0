From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Jun 2016 08:23:01 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 02/17] net: Combine GENEVE
 and VXLAN port notifiers into single functions
In-Reply-To: <CAEh+42i8y70XsuuXs1+LYVxRomvJZUEWg6KhonoxvNqaYe9dtQ@mail.gmail.com>
References: <20160615220449.15575.17031.stgit@localhost.localdomain>
 <20160615220728.15575.62132.stgit@localhost.localdomain>
 <CAEh+42i8y70XsuuXs1+LYVxRomvJZUEWg6KhonoxvNqaYe9dtQ@mail.gmail.com>
Message-ID: <CAKgT0Ues0jX2u8+2pf4Sc0+7=ES5OhLg_=to6Nr_X4+Vt9OnBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 15, 2016 at 4:50 PM, Jesse Gross <jesse@kernel.org> wrote:
> On Wed, Jun 15, 2016 at 3:07 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>> index e5e33cd01082..d12ee3a92fb5 100644
>> --- a/drivers/net/geneve.c
>> +++ b/drivers/net/geneve.c
>>  static void geneve_notify_del_rx_port(struct geneve_sock *gs)
>>  {
>> -       struct net_device *dev;
>> -       struct sock *sk = gs->sock->sk;
>> -       struct net *net = sock_net(sk);
>> -       sa_family_t sa_family = geneve_get_sk_family(gs);
>> -       __be16 port = inet_sk(sk)->inet_sport;
>> -
>> -       rcu_read_lock();
>> -       for_each_netdev_rcu(net, dev) {
>> -               if (dev->netdev_ops->ndo_del_geneve_port)
>> -                       dev->netdev_ops->ndo_del_geneve_port(dev, sa_family,
>> -                                                            port);
>> -       }
>> -
>> -       rcu_read_unlock();
>> +       udp_tunnel_notify_add_rx_port(gs->sock, UDP_TUNNEL_TYPE_GENEVE);
>>  }
>
> Looks like a typo here - calling add instead of delete.

Yeah.  I had a few other spots that occurred.  I thought I had caught
them all before submitting but I guess not.  I will fix that for v3.

Thanks.

- Alex
