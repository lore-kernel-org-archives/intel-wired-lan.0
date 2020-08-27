From: Li,Rongqing <lirongqing@baidu.com>
Date: Thu, 27 Aug 2020 08:53:09 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: use kvzalloc instead of kzalloc
 for rx/tx_bi buffer
In-Reply-To: <6d89955c-78a2-fa00-9f39-78648d3558a0@gmail.com>
References: <1598514788-31039-1-git-send-email-lirongqing@baidu.com>
 <6d89955c-78a2-fa00-9f39-78648d3558a0@gmail.com>
Message-ID: <4557d3ad541b4272bc1286480af5e562@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Eric Dumazet [mailto:eric.dumazet at gmail.com]
> Sent: Thursday, August 27, 2020 4:26 PM
> To: Li,Rongqing <lirongqing@baidu.com>; netdev at vger.kernel.org;
> intel-wired-lan at lists.osuosl.org
> Subject: Re: [PATCH] iavf: use kvzalloc instead of kzalloc for rx/tx_bi buffer
> 
> 
> 
> On 8/27/20 12:53 AM, Li RongQing wrote:
> > when changes the rx/tx ring to 4096, kzalloc may fail due to a
> > temporary shortage on slab entries.
> >
> > kvmalloc is used to allocate this memory as there is no need to have
> > this memory area physical continuously.
> >
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> 
> 
> Well, fallback to vmalloc() overhead because order-1 pages are not readily
> available when the NIC is setup (usually one time per boot) is adding TLB cost
> at run time, for billions of packets to come, maybe for months.
> 
> Surely trying a bit harder to get order-1 pages is desirable.
> 
>  __GFP_RETRY_MAYFAIL is supposed to help here.

Could we add __GFP_RETRY_MAYFAIL to kvmalloc, to ensure the allocation success ?

> 

I see that lots of drivers are using vmalloc for this buffer, should we change it kmalloc?  

grep "buffer_info =" drivers/net/ethernet/intel/ -rI|grep alloc

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:      tx_ring->tx_buffer_info = vmalloc(size);
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:      rx_ring->rx_buffer_info = vmalloc(size);
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:  tx_ring->tx_buffer_info = vmalloc_node(size, ring_node);
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:          tx_ring->tx_buffer_info = vmalloc(size);
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:  rx_ring->rx_buffer_info = vmalloc_node(size, ring_node);
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:          rx_ring->rx_buffer_info = vmalloc(size);
drivers/net/ethernet/intel/ixgb/ixgb_main.c:    txdr->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/ixgb/ixgb_main.c:    rxdr->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/e1000e/ethtool.c:    tx_ring->buffer_info = kcalloc(tx_ring->count,
drivers/net/ethernet/intel/e1000e/ethtool.c:    rx_ring->buffer_info = kcalloc(rx_ring->count,
drivers/net/ethernet/intel/e1000e/netdev.c:     tx_ring->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/e1000e/netdev.c:     rx_ring->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/igb/igb_main.c:      tx_ring->tx_buffer_info = vmalloc(size);
drivers/net/ethernet/intel/igb/igb_main.c:      rx_ring->rx_buffer_info = vmalloc(size);
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:       txdr->buffer_info = kcalloc(txdr->count, sizeof(struct e1000_tx_buffer),
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:       rxdr->buffer_info = kcalloc(rxdr->count, sizeof(struct e1000_rx_buffer),
drivers/net/ethernet/intel/e1000/e1000_main.c:  txdr->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/e1000/e1000_main.c:  rxdr->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/igc/igc_main.c:      tx_ring->tx_buffer_info = vzalloc(size);
drivers/net/ethernet/intel/igc/igc_main.c:      rx_ring->rx_buffer_info = vzalloc(size);
drivers/net/ethernet/intel/igbvf/netdev.c:      tx_ring->buffer_info = vzalloc(size);
drivers/net/ethernet/intel/igbvf/netdev.c:      rx_ring->buffer_info = vzalloc(size);


-Li
