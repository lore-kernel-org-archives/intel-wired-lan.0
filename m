From: Tyler S <tylerjstachecki@gmail.com>
Date: Tue, 27 Apr 2021 19:11:32 -0400
Subject: [Intel-wired-lan] [PATCH net v2] igb: Fix XDP with PTP enabled
In-Reply-To: <871rax9loz.fsf@kurt>
References: <CAMfj=-YEh1ZnLB8zye7i-5Y2S015n0qat+FQ6JW7bFKwBUHBPg@mail.gmail.com>
 <871rax9loz.fsf@kurt>
Message-ID: <CAMfj=-ZzOLog6NQvgpThSOy_5od_dY4KHd0uojxRxaWQA9kKJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Apr 26, 2021 at 10:15 AM Kurt Kanzenbach <kurt@linutronix.de> wrote:
>
> On Sun Apr 25 2021, Tyler S wrote:
> > Thanks for this work; I was having trouble using XDP on my I354 NIC until this.
> >
> > Hopefully I have not err'd backporting it to 5.10 -- but I'm seeing
> > jumbo frames dropped after applying this (though as previously
> > mentioned, non-skb/full driver XDP programs do now work).
> >
> > Looking at the code, I'm not sure why that is.
>
> I'm also not sure, yet.
>
> Can you try with version 3 of this patch [1] and see if there are still
> issues with jumbo frames? Can you also share the backported patch for
> v5.10?
>
> Thanks,
> Kurt
>
> [1] - https://lkml.kernel.org/netdev/20210422052617.17267-1-kurt at linutronix.de/

Sorry, I didn't see v3.  I can confirm that v3 fixes the issue I was
seeing with jumbo frames.

The only part of the patch that differs for 5.10 is the hunk I'll
include inline.  Thanks again for your work!

Cheers,
Tyler
@@ -8720,11 +8716,22 @@ static int igb_clean_rx_irq(struct
igb_q_vector *q_vector, const int budget)
                dma_rmb();

                rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
+               pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
+
+               /* pull rx packet timestamp if available and valid */
+               if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+                       timestamp = igb_ptp_rx_pktstamp(rx_ring->q_vector,
+                                                       pktbuf);
+
+                       if (timestamp) {
+                               pkt_offset += IGB_TS_HDR_LEN;
+                               size -= IGB_TS_HDR_LEN;
+                       }
+               }

                /* retrieve a buffer from the ring */
                if (!skb) {
-                       xdp.data = page_address(rx_buffer->page) +
-                                  rx_buffer->page_offset;
+                       xdp.data = pktbuf + pkt_offset;
                        xdp.data_meta = xdp.data;
                        xdp.data_hard_start = xdp.data -
                                              igb_rx_offset(rx_ring);
