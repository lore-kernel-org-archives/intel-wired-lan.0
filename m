From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 23 Mar 2018 22:37:25 +0000
Subject: [Intel-wired-lan] [v4,
 05/15] ice: Get MAC/PHY/link info and scheduler topology
In-Reply-To: <20180320145819.19133-6-anirudh.venkataramanan@intel.com>
References: <20180320145819.19133-6-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261789F100@ORSMSX109.amr.corp.intel.com>
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
> Subject: [v4,05/15] ice: Get MAC/PHY/link info and scheduler topology
> 
> This patch adds code to continue the initialization flow as follows:
> 
> 1) Get PHY/link information and store it
> 2) Get default scheduler tree topology and store it
> 3) Get the MAC address associated with the port and store it
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h            |   1 +
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 261
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.c     | 264
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_sched.c      | 328
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sched.h      |   6 +
>  drivers/net/ethernet/intel/ice/ice_status.h     |   1 +
>  drivers/net/ethernet/intel/ice/ice_type.h       |  65 +++++
>  8 files changed, 929 insertions(+)


Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


