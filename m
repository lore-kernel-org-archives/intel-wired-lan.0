From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:15:21 +0000
Subject: [Intel-wired-lan] [PATCH net v1 8/8] iavf: Fix __IAVF_RESETTING
 state usage
In-Reply-To: <20220223123855.30862-1-mateusz.palczewski@intel.com>
References: <20220223123855.30862-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB56299AEBBCB76DF56C864F07AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, February 23, 2022 1:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>; Burra, Phani R
> <phani.r.burra@intel.com>; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1 8/8] iavf: Fix __IAVF_RESETTING
> state usage
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> The setup of __IAVF_RESETTING state in watchdog task had no effect and
> could lead to slow resets in the driver as the task for __IAVF_RESETTING
> state only requeues watchdog.
> Till now the __IAVF_RESETTING was interpreted by reset task as running
> state which could lead to errors with allocating and resources disposal.
> 
> Make watchdog_task queue the reset task when it's necessary.
> Do not update the state to __IAVF_RESETTING so the reset task knows
> exactly what is the current state of the adapter.
> 
> Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index be97ac2..dcf2426 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1137,8 +1137,7 @@ void iavf_down(struct iavf_adapter *adapter)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
