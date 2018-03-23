From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:35:34 +0000
Subject: [Intel-wired-lan] [v4, 03/15] ice: Start hardware initialization
In-Reply-To: <20180320145819.19133-4-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-4-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F0DA@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4,03/15] ice: Start hardware initialization
> 
> This patch implements multiple pieces of the initialization flow as follows:
> 
> 1) A reset is issued to ensure a clean device state, followed
>    by initialization of admin queue interface.
> 
> 2) Once the admin queue interface is up, clear the PF config
>    and transition the device to non-PXE mode.
> 
> 3) Get the NVM configuration stored in the device's non-volatile
>    memory (NVM) using ice_init_nvm.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile         |   3 +-
>  drivers/net/ethernet/intel/ice/ice.h            |   2 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  79 +++++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 405
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |  11 +
>  drivers/net/ethernet/intel/ice/ice_controlq.h   |   3 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  30 ++
>  drivers/net/ethernet/intel/ice/ice_main.c       |  31 ++
>  drivers/net/ethernet/intel/ice/ice_nvm.c        | 250 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_osdep.h      |   1 +
>  drivers/net/ethernet/intel/ice/ice_status.h     |   5 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |  49 +++
>  12 files changed, 868 insertions(+), 1 deletion(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_nvm.c


Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


