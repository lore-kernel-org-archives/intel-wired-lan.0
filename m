From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 31 May 2022 08:49:15 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix issue with MAC
 address of VF shown as zero
In-Reply-To: <20220520111927.52384-1-michal.wilczynski@intel.com>
References: <20220520111927.52384-1-michal.wilczynski@intel.com>
Message-ID: <DM8PR11MB56213B809A91F0EBE2B6D80AABDC9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Wilczynski
> Sent: Friday, May 20, 2022 1:19 PM
> To: intel-wired-lan at osuosl.org
> Cc: Wilczynski, Michal <michal.wilczynski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix issue with MAC address of
> VF shown as zero
> 
> After reinitialization of iavf, ice driver gets VIRTCHNL_OP_ADD_ETH_ADDR
> message with incorrectly set type of mac address. Hardware address should
> have is_primary flag set as true. This way ice driver knows what it has to set
> as a mac address.
> 
> Check if the address is primary in iavf_add_filter function and set flag
> accordingly.
> 
> To test set all-zero mac on a VF. This triggers iavf re-initialization and
> VIRTCHNL_OP_ADD_ETH_ADDR message gets sent to PF.
> For example:
> 
> ip link set dev ens785 vf 0 mac 00:00:00:00:00:00
> 
> This triggers re-initialization of iavf. New mac should be assigned.
> Now check if mac is non-zero:
> 
> ip link show dev ens785
> 
> Fixes: a3e839d539e0 ("iavf: Add usage of new virtchnl format to set default
> MAC")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 7dfcf78b57fb..f3ecb3bca33d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -984,7 +984,7 @@ struct iavf_mac_filter *iavf_add_filter(struct
> iavf_adapter *adapter,

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
