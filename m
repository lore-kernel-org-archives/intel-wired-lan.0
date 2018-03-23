From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 23:25:46 +0000
Subject: [Intel-wired-lan] [v4, 15/15] ice: Implement filter sync,
 NDO operations and bump version
In-Reply-To: <20180320145819.19133-16-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-16-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F206@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4, 15/15] ice: Implement filter sync, NDO operations and bump
> version
> 
> This patch implements multiple pieces of functionality:
> 
> 1. Added ice_vsi_sync_filters, which is called through the service task
>    to push filter updates to the hardware.
> 
> 2. Add support to enable/disable promiscuous mode on an interface.
>    Enabling/disabling promiscuous mode on an interface results in
>    addition/removal of a promisc filter rule through ice_vsi_sync_filters.
> 
> 3. Implement handlers for ndo_set_mac_address, ndo_change_mtu,
>    ndo_poll_controller and ndo_set_rx_mode.
> 
> This patch also marks the end of the driver addition by bumping up the driver
> version.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |  14 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  21 +
>  drivers/net/ethernet/intel/ice/ice_common.c     |  28 ++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  12 +
>  drivers/net/ethernet/intel/ice/ice_main.c       | 567
> +++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c     |  77 ++++
>  drivers/net/ethernet/intel/ice/ice_switch.h     |   2 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |   5 +
>  9 files changed, 728 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


