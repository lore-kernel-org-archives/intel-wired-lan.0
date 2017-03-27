From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 27 Mar 2017 23:44:30 +0000
Subject: [Intel-wired-lan] [next PATCH S65 08/13] i40e: remove
	I40E_FLAG_NEED_LINK_UPDATE
In-Reply-To: <20170327094759.58321-9-alice.michael@intel.com>
References: <20170327094759.58321-1-alice.michael@intel.com>
 <20170327094759.58321-9-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DE7B06@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reword description to be more accurate with upstream:

The I40E_FLAG_NEED_LINK_UPDATE definition was never used. Remove it.

> -----Original Message-----
> From: Michael, Alice
> Sent: Monday, March 27, 2017 2:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S65 08/13] i40e: remove I40E_FLAG_NEED_LINK_UPDATE
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In a previous commit the last use of I40E_FLAG_NEED_LINK_UPDATE
> was removed, but the flag definitions stayed around. Remove them.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: If59d0c6b4af85ca27281f3183c54b055adb439a4
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  drivers/net/ethernet/intel/i40evf/i40evf.h  | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 686327c..fc91ffd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -389,7 +389,6 @@ struct i40e_pf {
>  #define I40E_FLAG_MSIX_ENABLED			BIT_ULL(3)
>  #define I40E_FLAG_RSS_ENABLED			BIT_ULL(6)
>  #define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(7)
> -#define I40E_FLAG_NEED_LINK_UPDATE		BIT_ULL(9)
>  #define I40E_FLAG_IWARP_ENABLED			BIT_ULL(10)
>  #define I40E_FLAG_CLEAN_ADMINQ			BIT_ULL(14)
>  #define I40E_FLAG_FILTER_SYNC			BIT_ULL(15)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index cecbb5d..f5f5bbe 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11125,7 +11125,6 @@ static int i40e_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
> 
>  	INIT_WORK(&pf->service_task, i40e_service_task);
>  	clear_bit(__I40E_SERVICE_SCHED, &pf->state);
> -	pf->flags |= I40E_FLAG_NEED_LINK_UPDATE;
> 
>  	/* NVM bit on means WoL disabled for the port */
>  	i40e_read_nvm_word(hw, I40E_SR_NVM_WAKE_ON_LAN,
> &wol_nvm_bits);
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h
> b/drivers/net/ethernet/intel/i40evf/i40evf.h
> index d61ecf6..35ded19 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
> @@ -205,7 +205,6 @@ struct i40evf_adapter {
>  #define I40EVF_FLAG_IN_NETPOLL			BIT(4)
>  #define I40EVF_FLAG_IMIR_ENABLED		BIT(5)
>  #define I40EVF_FLAG_MQ_CAPABLE			BIT(6)
> -#define I40EVF_FLAG_NEED_LINK_UPDATE		BIT(7)
>  #define I40EVF_FLAG_PF_COMMS_FAILED		BIT(8)
>  #define I40EVF_FLAG_RESET_PENDING		BIT(9)
>  #define I40EVF_FLAG_RESET_NEEDED		BIT(10)
> --
> 2.9.3

