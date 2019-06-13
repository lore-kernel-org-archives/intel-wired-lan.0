From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 13 Jun 2019 21:07:26 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/6] xsk: add support for
 need_wakeup flag in AF_XDP rings
In-Reply-To: <20190613120411.35ef3c52@cakuba.netronome.com>
References: <1560411450-29121-1-git-send-email-magnus.karlsson@intel.com>
 <1560411450-29121-3-git-send-email-magnus.karlsson@intel.com>
 <20190613120411.35ef3c52@cakuba.netronome.com>
Message-ID: <CAJ8uoz0jXyVt8OPOq+B8L7gEm8bbd8cE5vdf3-KAhaVK871k8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 13, 2019 at 9:05 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Thu, 13 Jun 2019 09:37:26 +0200, Magnus Karlsson wrote:
> >
> > -     if (!dev->netdev_ops->ndo_bpf ||
> > -         !dev->netdev_ops->ndo_xsk_async_xmit) {
> > +     if (!dev->netdev_ops->ndo_bpf || !dev->netdev_ops->ndo_xsk_wakeup) {
> >               err = -EOPNOTSUPP;
> >               goto err_unreg_umem;
> >       }
>
> > @@ -198,7 +258,8 @@ static int xsk_zc_xmit(struct sock *sk)
> >       struct xdp_sock *xs = xdp_sk(sk);
> >       struct net_device *dev = xs->dev;
> >
> > -     return dev->netdev_ops->ndo_xsk_async_xmit(dev, xs->queue_id);
> > +     return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id,
> > +                                            XDP_WAKEUP_TX);
> >  }
> >
> >  static void xsk_destruct_skb(struct sk_buff *skb)
>
> Those two look like they should be in the previous patch?  Won't it
> break build?

You are correct. That should have been in patch 1. Will fix that in the v2.

Thanks: Magnus
