From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 13 Jan 2022 11:03:46 +0100
Subject: [Intel-wired-lan] [PATCH net-queue v1] igc: Fix trying to
 register an already registered xdp_rxq
In-Reply-To: <Yd94jSgomz2XhE/s@wantstofly.org>
References: <YdxZr0wMxvsDCpbV@wantstofly.org>
 <20220113004015.449460-1-vinicius.gomes@intel.com>
 <Yd94jSgomz2XhE/s@wantstofly.org>
Message-ID: <Yd/5AiavcQGioQER@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 13, 2022 at 02:55:41AM +0200, Lennert Buytenhek wrote:
> On Wed, Jan 12, 2022 at 04:40:15PM -0800, Vinicius Costa Gomes wrote:
> 
> > When changing the number of RX descriptors, for example, by doing
> > 
> >  $ ethtool -G enp3s0 rx 1024
> > 
> > the XDP RX queue information (xdp_rxq) may be already registered, if
> > it's registered there's no need to do any thing in relation to
> > xdp_rxq, none of it's parameters will change if we change the number
> > of descriptors, for example.
> > 
> > Fixes: 4609ffb9f615 ("igc: Refactor XDP rxq info registration")
> > Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> > Lennert, I added your name and email to the Reported-by tag, please
> > see if you are ok with it.
> 
> This patch seems to work -- thank you!
> 
> Tested-by: Lennert Buytenhek <buytenh@arista.com>
> 
> Could you use the same email address for Reported-by: ?

I'm missing the context in here, fix itself is fine but it would be good
to include in commit message what Lennert actually reported TBH.

> 
> 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index e29aadbc6744..d163139161fc 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c)  2018 Intel Corporation */
> >  
> > +#include "net/xdp.h"
> >  #include <linux/module.h>
> >  #include <linux/types.h>
> >  #include <linux/if_vlan.h>
> > @@ -499,12 +500,14 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
> >  	u8 index = rx_ring->queue_index;
> >  	int size, desc_len, res;
> >  
> > -	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
> > -			       rx_ring->q_vector->napi.napi_id);
> > -	if (res < 0) {
> > -		netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
> > -			   index);
> > -		return res;
> > +	if (!xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
> > +		res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
> > +				       rx_ring->q_vector->napi.napi_id);
> > +		if (res < 0) {
> > +			netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
> > +				   index);
> > +			return res;
> > +		}
> >  	}
> >  
> >  	size = sizeof(struct igc_rx_buffer) * rx_ring->count;
> > -- 
> > 2.34.1
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
