From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 4 May 2021 10:28:27 +0200
Subject: [Intel-wired-lan] [PATCH net v4] igb: Fix XDP with PTP enabled
In-Reply-To: <20210503072800.79936-1-kurt@linutronix.de>
References: <20210503072800.79936-1-kurt@linutronix.de>
Message-ID: <20210504102827.342f6302@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon,  3 May 2021 09:28:00 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

> When using native XDP with the igb driver, the XDP frame data doesn't point to
> the beginning of the packet. It's off by 16 bytes. Everything works as expected
> with XDP skb mode.
> 
> Actually these 16 bytes are used to store the packet timestamps. Therefore, pull
> the timestamp before executing any XDP operations and adjust all other code
> accordingly. The igc driver does it like that as well.
> 
> Tested with Intel i210 card and AF_XDP sockets.
> 
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Thanks for fixing this!

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I expect that we/I will (soon) play with getting this area that is
stored in front of the packet (the XDP data_meta area) described via
BTF.  This way both xdp_frame and AF_XDP can get structured access (e.g.
to the PTP timestamp in this case).

I'll be adding my notes on this project here:
 https://github.com/xdp-project/xdp-project/blob/master/areas/tsn/

Looking forward to collaborate on this with you :-)
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

