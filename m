From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Oct 2019 23:15:50 +0000
Subject: [Intel-wired-lan] [PATCH S30 6/9] ice: introduce legacy rx flag
In-Reply-To: <20191009140925.13997-6-anthony.l.nguyen@intel.com>
References: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
 <20191009140925.13997-6-anthony.l.nguyen@intel.com>
Message-ID: <a8b26464c5834d3ca7b77c0c9716b2b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 6/9] ice: introduce legacy rx flag
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Add an ethtool "legacy-rx" priv flag for toggling the Rx path. This control knob
> will be mainly used for build_skb usage as well as buffer size/MTU
> manipulation.
> 
> In preparation for adding build_skb support in a way that it takes care of how
> we set the values of max_frame and rx_buf_len fields of struct ice_vsi.
> Specifically, in this patch mentioned fields are set to values that will allow us
> to provide headroom and tailroom in-place.
> 
> This can be mostly broken down onto following:
> - for legacy-rx "on" ethtool control knob, old behaviour is kept;
> - for standard 1500 mtu size configure the buffer of size 1536, as
>   network stack is expecting the NET_SKB_PAD to be provided and
>   NET_IP_ALIGN can have a non-zero value (these can be typically equal
>   to 32 and 2, respectively);
> - for larger mtus go with max_frame set to 9k and configure the 3k
>   buffer in case when PAGE_SIZE of underlying arch is less than 8k; 3k
>   buffer is implying the need for order 1 page, so that our page
>   recycling scheme can still be applied;
> 
> With that said, substitute the hardcoded ICE_RXBUF_2048 and PAGE_SIZE
> values in DMA API that we're making use of with rx_ring->rx_buf_len and
> ice_rx_pg_size(rx_ring). The latter is an introduced helper for determining
> the page size based on its order (which was figured out via ice_rx_pg_order).
> Last but not least, take care of truesize calculation.
> 
> In the followup patch the headroom/tailroom computation logic will be
> introduced.
> 
> This change aligns the buffer and frame configuration with other Intel
> drivers, most importantly with iavf.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +++
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 22 +++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 46 ++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_txrx.h    | 13 ++++++
>  5 files changed, 63 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


