From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 18 Aug 2020 16:04:43 +0200
Subject: [Intel-wired-lan] [PATCH 0/2] intel/xdp fixes for fliping rx
 buffer
In-Reply-To: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
Message-ID: <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 17 Jul 2020 at 08:24, Li RongQing <lirongqing@baidu.com> wrote:
>
> This fixes ice/i40e/ixgbe/ixgbevf_rx_buffer_flip in
> copy mode xdp that can lead to data corruption.
>
> I split two patches, since i40e/xgbe/ixgbevf supports xsk
> receiving from 4.18, put their fixes in a patch
>

Li, sorry for the looong latency. I took a looong vacation. :-P

Thanks for taking a look at this, but I believe this is not a bug.

The Intel Ethernet drivers (obviously non-zerocopy AF_XDP -- "good ol'
XDP") use a page reuse algorithm.

Basic idea is that a page is allocated from the page allocator
(i40e_alloc_mapped_page()). The refcount is increased to
USHRT_MAX. The page is split into two chunks (simplified). If there's
one user of the page, the page can be reused (flipped). If not, a new
page needs to be allocated (with the large refcount).

So, the idea is that usually the page can be reused (flipped), and the
page only needs to be "put" not "get" since the refcount was initally
bumped to a large value.

All frames (except XDP_DROP which can be reused directly) "die" via
page_frag_free() which decreases the page refcount, and frees the page
if the refcount is zero.

Let's take some scenarios as examples:

1. A frame is received in "vanilla" XDP (MEM_TYPE_PAGE_SHARED), and
   the XDP program verdict is XDP_TX. The frame will be placed on the
   HW Tx ring, and freed* (async) in i40e_clean_tx_irq:
        /* free the skb/XDP data */
        if (ring_is_xdp(tx_ring))
            xdp_return_frame(tx_buf->xdpf); // calls page_frag_free()

2. A frame is passed to the stack, eventually it's freed* via
   skb_free_frag().

3. A frame is passed to an AF_XDP socket. The data is copied to the
   socket data area, and the frame is directly freed*.

Not the * by the freed. Actually freeing here means calling
page_frag_free(), which means decreasing the refcount. The page reuse
algorithm makes sure that the buffers are not stale.

The only difference from XDP_TX and XDP_DIRECT to dev/cpumaps,
compared to AF_XDP sockets is that the latter calls page_frag_free()
directly, whereas the other does it asynchronous from the Tx clean up
phase.

Let me know if it's still not clear, but the bottom line is that none
of these patches are needed.


Thanks!
Bj?rn


> Li RongQing (2):
>   xdp: i40e: ixgbe: ixgbevf: not flip rx buffer for copy mode xdp
>   ice/xdp: not adjust rx buffer for copy mode xdp
>
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 5 ++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.c         | 5 ++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 5 ++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 5 ++++-
>  include/net/xdp.h                                 | 3 +++
>  net/xdp/xsk.c                                     | 4 +++-
>  6 files changed, 22 insertions(+), 5 deletions(-)
>
> --
> 2.16.2
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
