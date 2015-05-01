From: David Miller <davem@davemloft.net>
Date: Fri, 01 May 2015 11:42:23 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH 0/3] Stop using dev_kfree_skb_any in
	NAPI Tx clean-up
In-Reply-To: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
References: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
Message-ID: <20150501.114223.1837223121502998313.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Thu, 30 Apr 2015 13:58:12 -0700

> This change replaces the call to dev_kfree_skb_any in several NAPI based Tx
> clean-up paths with dev_kfree_skb.  Where I made the replacement the
> function appeared to always be in softirq context so we can avoid the
> unnecessary time spent determining if we are in a hardirq context or not.

It isn't always in softirq context.

We can do a netconsole transmit from any context, and that code
can and will invoke ->poll().

As Francois noted, netpoll_send_skb_on_dev() loops trying to transmit,
and if the TX does nto give NETDEV_TX_OK it will try to execute TX
reclaim by invoking ->poll().

It's hard to trigger this, but if you do... the dev_kfree_skb_any()
really is necessary.
