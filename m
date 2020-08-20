From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 20 Aug 2020 17:13:16 +0200
Subject: [Intel-wired-lan] [PATCH 0/2] intel/xdp fixes for fliping rx
 buffer
In-Reply-To: <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
 <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
Message-ID: <CAJ+HfNjybUeN9v6N-pnupi32088PL+ZXu8CKWGWmowOaH4nmOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 18 Aug 2020 at 16:04, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> On Fri, 17 Jul 2020 at 08:24, Li RongQing <lirongqing@baidu.com> wrote:
> >
> > This fixes ice/i40e/ixgbe/ixgbevf_rx_buffer_flip in
> > copy mode xdp that can lead to data corruption.
> >
> > I split two patches, since i40e/xgbe/ixgbevf supports xsk
> > receiving from 4.18, put their fixes in a patch
> >
>
> Li, sorry for the looong latency. I took a looong vacation. :-P
>
> Thanks for taking a look at this, but I believe this is not a bug.
>

Ok, dug a bit more into this. I had an offlist discussion with Li, and
there are two places (AFAIK) where Li experience a BUG() in
tcp_collapse():

            BUG_ON(offset < 0);
and
                if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
                    BUG();

(Li, please correct me if I'm wrong.)

I still claim that the page-flipping mechanism is correct, but I found
some weirdness in the build_skb() call.

In drivers/net/ethernet/intel/i40e/i40e_txrx.c, build_skb() is invoked as:
    skb = build_skb(xdp->data_hard_start, truesize);

For the setup Li has truesize is 2048 (half a page), but the
rx_buf_len is 1536. In the driver a packet is layed out as:

| padding 192 | packet data 1536 | skb shared info 320 |

build_skb() assumes that the second argument (frag_size) is max packet
size + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)). In other words,
frag_size should not include the padding (192 above). In build_skb(),
frag_size is used to compute the skb truesize and skb end. i40e passes
a too large buffer, and can therefore potentially corrupt the skb, and
maybe this is the reason for tcp_collapse() splatting.

Li, could you test if you get the splat with this patch:

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 3e5c566ceb01..acfb4ad9b506 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2065,7 +2065,8 @@ static struct sk_buff *i40e_build_skb(struct
i40e_ring *rx_ring,
 {
     unsigned int metasize = xdp->data - xdp->data_meta;
 #if (PAGE_SIZE < 8192)
-    unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
+    unsigned int truesize = rx_ring->rx_buf_len +
+                SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 #else
     unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
                 SKB_DATA_ALIGN(xdp->data_end -

I'll have a look in the other Intel drivers, and see if there are
similar issues. I'll cook a patch.


Bj?rn
