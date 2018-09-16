From: Kushal Gautam <kushal.gautam@gmail.com>
Date: Sun, 16 Sep 2018 09:55:34 +0200
Subject: [Intel-wired-lan] using XPS on Intel i40e
Message-ID: <CAGv3bDeHUA6vWen50QheqTygyDpLgTzYKLtd82amPZzK-anh_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi:

I am using the Intel i40e driver from kernel source tree of Kernel 4.15.12
My NIC is Intel X710.

I am composing and sending a packet from my custom kernel module as:

...
skb->dev->netdev_ops->ndo_start_xmit(skb, skb->dev);
...

Just like FDIR on the receiving side, is it possible to have a similar
configuration on the sending side?

For instance, I want my packets sent via kernel module to pass through
TX-Queue 5. Right now all my packets are being sent through just Tx-Queue
0. And maybe after that, it would make sense to use XPS(
https://github.com/torvalds/linux/blob/v3.13/Documentation/networking/scaling.txt#L364
)

Regards,
Kushal.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180916/54212e7b/attachment.html>
