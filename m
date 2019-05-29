From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2019 09:00:54 -0700
Subject: [Intel-wired-lan] Driver has suspect GRO implementation,
 TCP performance may be compromised.
In-Reply-To: <eb730f01-0c6d-0589-36cc-7193d64c1ee8@molgen.mpg.de>
References: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
 <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com>
 <eb730f01-0c6d-0589-36cc-7193d64c1ee8@molgen.mpg.de>
Message-ID: <CANn89i+VvwMaHy2Br-0CcC3gPQ+PmG3Urpn4KpqL0P7XBykmcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 29, 2019 at 7:49 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Eric,
>
>
> Thank you for the quick reply.
>
> On 05/28/19 19:18, Eric Dumazet wrote:
> > On 5/28/19 8:42 AM, Paul Menzel wrote:
>
> >> Occasionally, Linux outputs the message below on the workstation Dell
> >> OptiPlex 5040 MT.
> >>
> >>     TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised.
> >>
> >> Linux 4.14.55 and Linux 5.2-rc2 show the message, and the WWW also
> >> gives some hits [1][2].
> >>
> >> ```
> >> $ sudo ethtool -i net00
> >> driver: e1000e
> >> version: 3.2.6-k
> >> firmware-version: 0.8-4
> >> expansion-rom-version:
> >> bus-info: 0000:00:1f.6
> >> supports-statistics: yes
> >> supports-test: yes
> >> supports-eeprom-access: yes
> >> supports-register-dump: yes
> >> supports-priv-flags: no
> >> ```
> >>
> >> Can the driver e1000e be improved?
> >>
> >> Any idea, what triggers this, as I do not see it every boot? Download
> >> of big files?
> >>
> > Maybe the driver/NIC can receive frames bigger than MTU, although this would be strange.
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index c61edd023b352123e2a77465782e0d32689e96b0..cb0194f66125bcba427e6e7e3cacf0c93040ef61 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -150,8 +150,10 @@ static void tcp_gro_dev_warn(struct sock *sk, const struct sk_buff *skb,
> >                 rcu_read_lock();
> >                 dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
> >                 if (!dev || len >= dev->mtu)
> > -                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised.\n",
> > -                               dev ? dev->name : "Unknown driver");
> > +                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised."
> > +                               " len %u mtu %u\n",
> > +                               dev ? dev->name : "Unknown driver",
> > +                               len, dev ? dev->mtu : 0);
> >                 rcu_read_unlock();
> >         }
> >  }
>
> I applied your patch on commit 9fb67d643 (Merge tag 'pinctrl-v5.2-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl):
>
>      [ 5507.291769] TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised. len 1856 mtu 1500


The 'GRO' in the warning can be probably ignored, since this NIC does
not implement its own GRO.

You can confirm this with this debug patch:

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
b/drivers/net/ethernet/intel/e1000e/netdev.c
index 0e09bede42a2bd2c912366a68863a52a22def8ee..014a43ce77e09664bda0568dd118064b006acd67
100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -561,6 +561,9 @@ static void e1000_receive_skb(struct e1000_adapter *adapter,
        if (staterr & E1000_RXD_STAT_VP)
                __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tag);

+       if (skb->len > netdev->mtu)
+               pr_err_ratelimited("received packet bigger (%u) than
MTU (%u)\n",
+                                  skb->len, netdev->mtu);
        napi_gro_receive(&adapter->napi, skb);
 }
