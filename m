From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:19:19 +0000
Subject: [Intel-wired-lan] [PATCH net v1 1/8] iavf: Rework mutexes for
 better synchronisation
In-Reply-To: <20220223123549.29391-1-mateusz.palczewski@intel.com>
References: <20220223123549.29391-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB56291FF8D8F7782F07179E54AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, February 23, 2022 1:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>; Burra, Phani R
> <phani.r.burra@intel.com>; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1 1/8] iavf: Rework mutexes for
> better synchronisation
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> The driver used to crash in multiple spots when put to stress testing of the
> init, reset and remove paths.
> 
> The user would experience call traces or hangs when creating, resetting,
> removing VFs. Depending on the machines, the call traces are happening in
> random spots, like reset restoring resources racing with driver remove.
> 
> Make adapter->crit_lock mutex a mandatory lock for guarding the operations
> performed on all workqueues and functions dealing with resource allocation
> and disposal.
> 
> Make __IAVF_REMOVE a final state of the driver respected by workqueues
> that shall not requeue, when they fail to obtain the crit_lock.
> 
> Make the IRQ handler not to queue the new work for adminq_task when the
> __IAVF_REMOVE state is set.
> 
> Fixes: 5ac49f3c2702 ("iavf: use mutexes for locking of critical sections")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  1 -
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 66 +++++++++++----------
>  2 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 59806d1..44f83e0 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -246,7 +246,6 @@ struct iavf_adapter {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
