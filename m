From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:33:10 +0000
Subject: [Intel-wired-lan] [PATCH v4 00/13] Bug fixes for ice
In-Reply-To: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545AC5@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 00/13] Bug fixes for ice
> 
> This patch set fixes multiple bugs for the ice driver.
> 
> Anirudh Venkataramanan (5):
>   ice: Fix multiple static analyser warnings
>   ice: Cleanup magic number
>   ice: Fix bugs in control queue processing
>   ice: Fix a few null pointer dereference issues
>   ice: Trivial formatting fixes
> 
> Brett Creeley (1):
>   ice: Set VLAN flags correctly
> 
> Bruce Allan (3):
>   ice: Remove unncessary node owner check
>   ice: Update to interrupts enabled in OICR
>   ice: Change struct members from bool to u8
> 
> Jacob Keller (2):
>   ice: Report stats for allocated queues via ethtool stats
>   ice: Use order_base_2 to calculate higher power of 2
> 
> Jesse Brandeburg (1):
>   ice: Fix potential return of uninitialized value
> 
> Preethi Banala (1):
>   ice: Clean control queues only when they are initialized
> 
>  drivers/net/ethernet/intel/ice/ice.h          |  15 ++-
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  25 ++--
>  drivers/net/ethernet/intel/ice/ice_common.c   |  30 +++--
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  29 +++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  52 ++++++--
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 --
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 115 ++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |   5 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |   3 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   6 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |  16 +--
>  14 files changed, 185 insertions(+), 126 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


