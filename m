From: Li,Rongqing <lirongqing@baidu.com>
Date: Tue, 21 Jul 2020 01:42:39 +0000
Subject: [Intel-wired-lan] =?utf-8?b?562U5aSNOiAgW1BBVENIIDEvMl0geGRwOiBp?=
 =?utf-8?q?40e=3A_ixgbe=3A_ixgbevf=3A_not_flip_rx_buffer_for_copy_mode_xdp?=
In-Reply-To: <CAJ8uoz2hdemss9S5vuF=Ttapkfb8U4YJy41oVjpMUVLiCOJTkw@mail.gmail.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
 <1594967062-20674-2-git-send-email-lirongqing@baidu.com>
 <CAJ8uoz2hdemss9S5vuF=Ttapkfb8U4YJy41oVjpMUVLiCOJTkw@mail.gmail.com>
Message-ID: <7b87919a454c4c7ba3d431783069e686@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----????-----
> ???: Magnus Karlsson [mailto:magnus.karlsson at gmail.com]
> ????: 2020?7?20? 15:21
> ???: Li,Rongqing <lirongqing@baidu.com>
> ??: Network Development <netdev@vger.kernel.org>; intel-wired-lan
> <intel-wired-lan@lists.osuosl.org>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Bj?rn T?pel <bjorn.topel@intel.com>
> ??: Re: [Intel-wired-lan] [PATCH 1/2] xdp: i40e: ixgbe: ixgbevf: not flip rx
> buffer for copy mode xdp
> 
> On Fri, Jul 17, 2020 at 8:24 AM Li RongQing <lirongqing@baidu.com> wrote:
> >
> > i40e/ixgbe/ixgbevf_rx_buffer_flip in copy mode xdp can lead to data
> > corruption, like the following flow:
> >
> >    1. first skb is not for xsk, and forwarded to another device
> >       or socket queue
> >    2. seconds skb is for xsk, copy data to xsk memory, and page
> >       of skb->data is released
> >    3. rx_buff is reusable since only first skb is in it, but
> >       *_rx_buffer_flip will make that page_offset is set to
> >       first skb data
> >    4. then reuse rx buffer, first skb which still is living
> >       will be corrupted.
e, but known size type */
> >         u32 id;
> > @@ -73,6 +75,7 @@ struct xdp_buff {
> >         struct xdp_rxq_info *rxq;
> >         struct xdp_txq_info *txq;
> >         u32 frame_sz; /* frame size to deduce data_hard_end/reserved
> > tailroom*/
> > +       u32 flags;
> 
> RongQing,
> 
> Sorry that I was not clear enough. Could you please submit the simple patch
> you had, the one that only tests for the memory type.
> 
> if (xdp->rxq->mem.type != MEM_TYPE_XSK_BUFF_POOL)
>       i40e_rx_buffer_flip(rx_ring, rx_buffer, size);
> 
> I do not think that adding a flags field in the xdp_mem_info to fix an Intel driver
> problem will be hugely popular. The struct is also meant to contain long lived
> information, not things that will frequently change.
> 


Thank you Magnus

My original suggestion is wrong , it should be following

if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
       i40e_rx_buffer_flip(rx_ring, rx_buffer, size);


but I feel it is not enough to only check mem.type, it must ensure that map_type is BPF_MAP_TYPE_XSKMAP ? but it is not expose. 

other maptype, like BPF_MAP_TYPE_DEVMAP,  and if mem.type is MEM_TYPE_PAGE_SHARED, not flip the rx buffer, will cause data corruption.


-Li 



