From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:17:42 +0000
Subject: [Intel-wired-lan] [PATCH net v1 3/8] iavf: Fix init state
 closure on remove
In-Reply-To: <20220223123710.29979-1-mateusz.palczewski@intel.com>
References: <20220223123710.29979-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB56294189E9E945D7EAEE21D0AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, February 23, 2022 1:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>; Burra, Phani R
> <phani.r.burra@intel.com>; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1 3/8] iavf: Fix init state closure on
> remove
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> When init states of the adapter work, the errors like lack of communication
> with the PF might hop in. If such events occur the driver restores previous
> states in order to retry initialization in a proper way. When remove task kicks
> in, this situation could lead to races with unregistering the netdevice as well
> as resources cleanup. With the commit introducing the waiting in remove for
> init to complete, this problem turns into an endless waiting if init never
> recovers from errors.
> 
> Introduce __IAVF_IN_REMOVE_TASK bit to indicate that the remove thread
> has started.
> 
> Make __IAVF_COMM_FAILED adapter state respect the
> __IAVF_IN_REMOVE_TASK bit and set the __IAVF_INIT_FAILED state and
> return without any action instead of trying to recover.
> 
> Make __IAVF_INIT_FAILED adapter state respect the
> __IAVF_IN_REMOVE_TASK bit and return without any further actions.
> 
> Make the loop in the remove handler break when adapter has
> __IAVF_INIT_FAILED state set.
> 
> Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  4 ++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 24 ++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 44f83e0..f259fd5 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -201,6 +201,10 @@ enum iavf_state_t {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
