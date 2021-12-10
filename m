From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 10 Dec 2021 21:05:29 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 2/5] ice: xsk: allocate
 separate memory for XDP SW ring
In-Reply-To: <20211210145941.5865-3-maciej.fijalkowski@intel.com>
References: <20211210145941.5865-1-maciej.fijalkowski@intel.com>
 <20211210145941.5865-3-maciej.fijalkowski@intel.com>
Message-ID: <b7ccf744f0fc8959991e5f4071953b260ae55f7a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-12-10 at 15:59 +0100, Maciej Fijalkowski wrote:
> @@ -425,9 +430,8 @@ static void ice_bump_ntc(struct ice_rx_ring
> *rx_ring)
> ? * Returns the skb on success, NULL on failure.
> ? */
> ?static struct sk_buff *
> -ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff
> **xdp_arr)
> +ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff
> *xdp)

There's a kdoc issue here.

drivers/net/ethernet/intel/ice/ice_xsk.c:436: warning: Function
parameter or member 'xdp' not described in 'ice_construct_skb_zc'
drivers/net/ethernet/intel/ice/ice_xsk.c:436: warning: Excess function
parameter 'xdp_arr' description in 'ice_construct_skb_zc'

Thanks,
Tony

