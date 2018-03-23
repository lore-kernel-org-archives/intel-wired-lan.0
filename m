From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:50:21 +0000
Subject: [Intel-wired-lan] [v4,
 10/15] ice: Implement transmit and NAPI support
In-Reply-To: <20180320145819.19133-11-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-11-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F183@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Anirudh Venkataramanan
> [mailto:anirudh.venkataramanan at intel.com]
> Sent: Tuesday, March 20, 2018 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [v4,10/15] ice: Implement transmit and NAPI support
> 
> This patch implements ice_start_xmit (the handler for ndo_start_xmit) and
> related functions. ice_start_xmit ultimately calls ice_tx_map, where the Tx
> descriptor is built and posted to the hardware by bumping the ring tail.
> 
> This patch also implements ice_napi_poll, which is invoked when there's an
> interrupt on the VSI's queues. The interrupt can be due to either a
> completed Tx or an Rx event. In case of a completed Tx/Rx event, resources
> are reclaimed. Additionally, in case of an Rx event, the skb is fetched and
> passed up to the network stack.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h           |    1 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h |   46 ++
>  drivers/net/ethernet/intel/ice/ice_main.c      |   55 ++
>  drivers/net/ethernet/intel/ice/ice_txrx.c      | 1026
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h      |   45 ++
>  5 files changed, 1171 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


