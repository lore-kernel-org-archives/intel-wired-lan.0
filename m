From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 13 Dec 2021 14:20:37 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor VF queue
 requesting
In-Reply-To: <20211109072744.56924-1-karen.sornek@intel.com>
References: <20211109072744.56924-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB5621D1C88E1486D62629CAF2AB749@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: wtorek, 9 listopada 2021 08:28
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor VF queue
> requesting
> 
> Simplify changing number of queues for VF's by moving logic to another
> function, i40e_vf_set_num_queues.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 72 +++++++++++--------
>  1 file changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 5a488ce545..fa881d9b0f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -2669,6 +2669,47 @@ static int i40e_check_enough_queue(struct
> i40e_vf *vf, u16 needed)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
