From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 15 Dec 2021 11:59:57 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add placeholder for
 ndo set VLANs
In-Reply-To: <20211109072331.56673-1-karen.sornek@intel.com>
References: <20211109072331.56673-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB5621831FCFE2ACA1CFA9BD25AB769@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: wtorek, 9 listopada 2021 08:24
> To: intel-wired-lan at lists.osuosl.org
> Cc: Patynowski, PrzemyslawX <przemyslawx.patynowski@intel.com>;
> Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add placeholder for ndo
> set VLANs
> 
> VLANs set by ndo, were not accounted.
> Implement placeholder, by which driver can account VLANs set by ndo.
> Ensure that once PF changes trunk, every guest filter is removed from the list
> 'vm_vlan_list'.
> Implement logic for deletion/addition of guest(from VM) filters.
> 
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 102 ++++++++++++++++--
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  10 ++
>  2 files changed, 102 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 5a488ce545..cf19e118ee 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -986,6 +986,81 @@ static void i40e_disable_vf_mappings(struct i40e_vf

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
