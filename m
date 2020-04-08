From: David Miller <davem@davemloft.net>
Date: Wed, 08 Apr 2020 14:48:45 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH RFC v2 26/33] i40e: add XDP frame size
 to driver
In-Reply-To: <158634676645.707275.7536684877295305696.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
 <158634676645.707275.7536684877295305696.stgit@firesoul>
Message-ID: <20200408.144845.783523592365109446.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 08 Apr 2020 13:52:46 +0200

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index b8496037ef7f..1fb6b1004dcb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1507,6 +1507,23 @@ static inline unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
>  	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
>  }
>  
> +static inline unsigned int i40e_rx_frame_truesize(struct i40e_ring *rx_ring,
> +						  unsigned int size)

Please don't use inline in foo.c files.  I noticed you properly elided this in
the ice changes so I wonder why it showed up here :-)
