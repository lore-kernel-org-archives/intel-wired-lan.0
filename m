From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:27:38 +0000
Subject: [Intel-wired-lan] [PATCH v3 00/15] Feature updates for ice
In-Reply-To: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195459EC@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 00/15] Feature updates for ice
> 
> This patch series includes new features and implementation updates for the
> ice driver.
> 
> Akeem G Abodunrin (1):
>   ice: Introduce SERVICE_DIS flag and service routine functions
> 
> Anirudh Venkataramanan (7):
>   ice: Rework flex descriptor programming
>   ice: Updates to Tx scheduler code
>   ice: Prevent control queue operations during reset
>   ice: Refactor switch rule management structures and functions
>   ice: Refactor VSI allocation, deletion and rebuild flow
>   ice: Clean up register file
>   ice: Fix and update driver version string
> 
> Brett Creeley (1):
>   ice: Enable VSI Rx/Tx pruning only when VLAN 0 is active
> 
> Chinh Cao (1):
>   ice: Implement handlers for ethtool PHY/link operations
> 
> Dan Nowlin (1):
>   ice: Update request resource command to latest specification
> 
> Hieu Tran (1):
>   ice: Enable firmware logging during device initialization.
> 
> Md Fahad Iqbal Polash (1):
>   ice: Implement ice_bridge_getlink and ice_bridge_setlink
> 
> Sudheer Mogilappagari (1):
>   ice: Add support for Tx hang, Tx timeout and malicious driver
>     detection
> 
> Zhenning Xiao (1):
>   ice: Code optimization for ice_fill_sw_rule()
> 
>  drivers/net/ethernet/intel/ice/ice.h          |    7 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   99 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   |  525 ++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   17 +-
>  drivers/net/ethernet/intel/ice/ice_controlq.c |    3 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  802 +++++++++-
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  456 +++---
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   24 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  964 ++++++++++--
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |    2 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  161 +-
>  drivers/net/ethernet/intel/ice/ice_status.h   |    1 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 1362 ++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   50 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |    1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |    1 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   52 +-
>  17 files changed, 3328 insertions(+), 1199 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


