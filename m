From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 15 Mar 2022 13:32:52 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Fix double free in
 iavf_reset_task
In-Reply-To: <20220309153739.22014-1-mateusz.palczewski@intel.com>
References: <20220309153739.22014-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB5621B0843DC145C06808AF1DAB109@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, March 9, 2022 4:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>; Dan Carpenter
> <dan.carpenter@oracle.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Fix double free in
> iavf_reset_task
> 
> From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> 
> Fix double free possibility in iavf_disable_vf, as crit_lock is freed in caller,
> iavf_reset_task. Add kernel-doc for iavf_disable_vf.
> Remove mutex_unlock in iavf_disable_vf.
> Without this patch there is double free scenario, when calling
> iavf_reset_task.
> 
> Fixes: e85ff9c631e1 ("iavf: Fix deadlock in iavf_reset_task")
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  Note: This is targeted to net-next because it fixes a patch  that is not present
> in net.
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 7c4b75a..c11e2ab 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2705,6 +2705,13 @@ static void iavf_watchdog_task(struct work_struct

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
