From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 27 Apr 2020 21:51:50 +0200
Subject: [Intel-wired-lan] [PATCH net-next 23/33] ixgbe: add XDP frame
 size to driver
In-Reply-To: <158757175790.1370371.16071055208561239272.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul>
 <158757175790.1370371.16071055208561239272.stgit@firesoul>
Message-ID: <69e05693-c3df-8f48-7a08-03bf4d58cb07@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/22/20 6:09 PM, Jesper Dangaard Brouer wrote:
> This driver uses different memory models depending on PAGE_SIZE at
> compile time. For PAGE_SIZE 4K it uses page splitting, meaning for
> normal MTU frame size is 2048 bytes (and headroom 192 bytes). For
> larger MTUs the driver still use page splitting, by allocating
> order-1 pages (8192 bytes) for RX frames. For PAGE_SIZE larger than
> 4K, driver instead advance its rx_buffer->page_offset with the frame
> size "truesize".
> 
> For XDP frame size calculations, this mean that in PAGE_SIZE larger
> than 4K mode the frame_sz change on a per packet basis. For the page
> split 4K PAGE_SIZE mode, xdp.frame_sz is more constant and can be
> updated once outside the main NAPI loop.
> 
> The default setting in the driver uses build_skb(), which provides
> the necessary headroom and tailroom for XDP-redirect in RX-frame
> (in both modes).
> 
> There is one complication, which is legacy-rx mode (configurable via
> ethtool priv-flags). There are zero headroom in this mode, which is a
> requirement for XDP-redirect to work. The conversion to xdp_frame
> (convert_to_xdp_frame) will detect this insufficient space, and
> xdp_do_redirect() call will fail. This is deemed acceptable, as it
> allows other XDP actions to still work in legacy-mode. In
> legacy-mode + larger PAGE_SIZE due to lacking tailroom, we also
> accept that xdp_adjust_tail shrink doesn't work.
> 
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Alexander/Jeff, in case the ixgbe/i40e/ice changes look good to you,
please ack.

Thanks,
Daniel
