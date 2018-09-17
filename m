From: Kushal Gautam <kushal.gautam@gmail.com>
Date: Mon, 17 Sep 2018 23:24:58 +0200
Subject: [Intel-wired-lan] using XPS on Intel i40e
In-Reply-To: <CAKgT0UfpOgiTF_kNL55=quF4C9cT2noZhBciWTiQCx65oqi7hg@mail.gmail.com>
References: <CAGv3bDeHUA6vWen50QheqTygyDpLgTzYKLtd82amPZzK-anh_Q@mail.gmail.com>
 <CAKgT0Ufnpxp0MDXkiZ9T1jafYj_ebiTY49JOGhFwC4D+uy3YOw@mail.gmail.com>
 <CAGv3bDepXm5qxZKRBG5vyJekFmHRGu8KOVpHBy8nktKbkeLK2w@mail.gmail.com>
 <CAKgT0UfpOgiTF_kNL55=quF4C9cT2noZhBciWTiQCx65oqi7hg@mail.gmail.com>
Message-ID: <CAGv3bDc2M+cUCnxqdGvmmvyn3ZQYEDVjokU_EZAcwByx2GZQBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi:

Thank you very much for your inputs.

I again went through the relevant source files and pktgen as well.
Following two lines did the trick:

skb_set_queue_mapping(skb, 7);
txq = skb_get_tx_queue(dev, skb);

Thank you again for your valuable inputs.

Regards,
Kushal.


On Mon, Sep 17, 2018 at 5:43 PM Alexander Duyck <alexander.duyck@gmail.com>
wrote:

> Did you ever try setting the queue mapping? I assumed that is what you
> were wanting to do.
> https://elixir.bootlin.com/linux/v4.19-rc3/ident/skb_set_queue_mapping
>
> Your code is bypassing all of the code for selecting a queue. Normally
> this is all done in netdev_pick_tx. You could probably just code up
> your own version to do what you want it to do.
> https://elixir.bootlin.com/linux/v4.19-rc3/ident/netdev_pick_tx
>
> - Alex
>
> On Mon, Sep 17, 2018 at 2:50 AM Kushal Gautam <kushal.gautam@gmail.com>
> wrote:
> >
> > Hi:
> >
> > Thank you for your inputs and pointing me to pktgen code.
> >
> > I have tried a few things here( I have tried to borrow this logic/code
> from pktgen code)
> >
> > ...
> > // I was doing
> > // txq = skb_get_tx_queue(skb->dev, skb);
> > // but it seemed that I will not be allowed to choose my desired queue
> in this case.
> >
> > // thus, I tried to hardcode it for the time being.
> > txq =  &dev->_tx[7];
> > local_bh_disable();
> >
> > HARD_TX_LOCK(skb->dev, txq, 7);
> >
> > if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
> >     ret = NETDEV_TX_BUSY;
> >     goto unlock;
> > }
> > // prior to this approach, I was using ndo_start_xmit directly as
> > // skb->dev->netdev_ops->ndo_start_xmit(skb, skb->dev);
> > // but, with this I was not able to use XPS, thus I was trying
> netdev_start_xmit() [which ultimately invokes ndo_start_xmit]
> >
> > ret = netdev_start_xmit(skb, skb->dev, txq, 0);
> >
> > unlock:
> > HARD_TX_UNLOCK(skb->dev, txq);
> >
> > local_bh_enable();
> >
> > ...
> >
> >
> > But, my packets are still flowing through the default Tx Queue 0. The
> queue settings don't seem to have an effect here. Or, I could be mistaken
> here.
> >
> > I would appreciate any inputs on this.
> >
> > Regards,
> > Kushal.
> >
> > On Sun, Sep 16, 2018 at 10:04 PM Alexander Duyck <
> alexander.duyck at gmail.com> wrote:
> >>
> >> On Sun, Sep 16, 2018 at 12:55 AM Kushal Gautam <kushal.gautam@gmail.com>
> wrote:
> >> >
> >> > Hi:
> >> >
> >> > I am using the Intel i40e driver from kernel source tree of Kernel
> 4.15.12
> >> > My NIC is Intel X710.
> >> >
> >> > I am composing and sending a packet from my custom kernel module as:
> >> >
> >> > ...
> >> > skb->dev->netdev_ops->ndo_start_xmit(skb, skb->dev);
> >> > ...
> >> >
> >> > Just like FDIR on the receiving side, is it possible to have a
> similar configuration on the sending side?
> >> >
> >> > For instance, I want my packets sent via kernel module to pass
> through TX-Queue 5. Right now all my packets are being sent through just
> Tx-Queue 0. And maybe after that, it would make sense to use XPS(
> https://github.com/torvalds/linux/blob/v3.13/Documentation/networking/scaling.txt#L364
> )
> >> >
> >> > Regards,
> >> > Kushal.
> >>
> >> Right now you are bypassing XPS entirely if you are using
> >> ndo_start_xmit to send you frames.
> >>
> >> You might take a look at the pktgen code in the kernel as I believe
> >> that has examples where they use specific queues to send packets. All
> >> that is really involved is updating a field in the sk_buff data
> >> structure before you call ndo_start_xmit.
> >>
> >> Hope that helps.
> >>
> >> - Alex
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180917/fceb3f4c/attachment-0001.html>
