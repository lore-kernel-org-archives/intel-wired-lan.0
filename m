From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:48:46 +0000
Subject: [Intel-wired-lan] [v4,09/15] ice: Configure VSIs for Tx/Rx
In-Reply-To: <20180320145819.19133-10-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-10-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F16B@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4,09/15] ice: Configure VSIs for Tx/Rx
> 
> This patch configures the VSIs to be able to send and receive
> packets by doing the following:
> 
> 1) Initialize flexible parser to extract and include certain
>    fields in the Rx descriptor.
> 
> 2) Add Tx queues by programming the Tx queue context (implemented in
>    ice_vsi_cfg_txqs). Note that adding the queues also enables (starts)
>    the queues.
> 
> 3) Add Rx queues by programming Rx queue context (implemented in
>    ice_vsi_cfg_rxqs). Note that this only adds queues but doesn't start
>    them. The rings will be started by calling ice_vsi_start_rx_rings on
>    interface up.
> 
> 4) Configure interrupts for VSI queues.
> 
> 5) Implement ice_open and ice_stop.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile         |    3 +-
>  drivers/net/ethernet/intel/ice/ice.h            |   36 +-
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   86 ++
>  drivers/net/ethernet/intel/ice/ice_common.c     |  602 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   13 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |   59 ++
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  260 ++++++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 1140
> ++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_sched.c      |  105 +++
>  drivers/net/ethernet/intel/ice/ice_sched.h      |    5 +
>  drivers/net/ethernet/intel/ice/ice_status.h     |    2 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c       |  375 ++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.h       |   75 ++
>  drivers/net/ethernet/intel/ice/ice_type.h       |    2 +
>  14 files changed, 2757 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx.c

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


