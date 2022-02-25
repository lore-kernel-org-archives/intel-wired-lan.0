From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:17:14 +0000
Subject: [Intel-wired-lan] [PATCH net v1 4/8] iavf: Fix locking for
 VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
In-Reply-To: <20220223123750.30266-1-mateusz.palczewski@intel.com>
References: <20220223123750.30266-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB5629B190BD992A4B37ABA4EEAB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, February 23, 2022 1:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>; Burra, Phani R
> <phani.r.burra@intel.com>; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1 4/8] iavf: Fix locking for
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> iavf_virtchnl_completion is called under crit_lock but when the code for
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS is called, this lock is released
> in order to obtain rtnl_lock to avoid ABBA deadlock with unregister_netdev.
> 
> Along with the new way iavf_remove behaves, there exist many risks related
> to the lock release and attmepts to regrab it. The driver faces crashes related
> to races between unregister_netdev and netdev_update_features. Yet
> another risk is that the driver could already obtain the crit_lock in order to
> destroy it and iavf_virtchnl_completion could crash or block forever.
> 
> Make iavf_virtchnl_completion never relock crit_lock in it's call paths.
> 
> Extract rtnl_lock locking logic to the driver for unregister_netdev in order to
> set the netdev_registered flag inside the lock.
> 
> Introduce a new flag that will inform adminq_task to perform the code from
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS right after it finishes
> processing messages. Guard this code with remove flags so it's never called
> when the driver is in remove state.
> 
> Fixes: 5951a2b9812d ("iavf: Fix VLAN feature flags after VFR")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 22 ++++++++++++++++-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 24 +------------------
>  3 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index f259fd5..8942394 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -287,6 +287,7 @@ struct iavf_adapter {
>  #define IAVF_FLAG_LEGACY_RX			BIT(15)
>  #define IAVF_FLAG_REINIT_ITR_NEEDED		BIT(16)
>  #define IAVF_FLAG_QUEUES_DISABLED		BIT(17)
> +#define IAVF_FLAG_SETUP_NETDEV_FEATURES		BIT(18)
>  /* duplicates for common code */
>  #define IAVF_FLAG_DCB_ENABLED			0
>  	/* flags for admin queue service task */ diff --git
> a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index be51da9..67349d2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2879,6 +2879,24 @@ static void iavf_adminq_task(struct work_struct

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
