From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:16:16 +0000
Subject: [Intel-wired-lan] [PATCH net v1 6/8] iavf: Fix deadlock in
 iavf_reset_task
In-Reply-To: <20220223123831.30608-1-mateusz.palczewski@intel.com>
References: <20220223123831.30608-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB56291622C59EBB94594B19B1AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net v1 6/8] iavf: Fix deadlock in
> iavf_reset_task
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> There exists a missing mutex_unlock call on crit_lock in iavf_reset_task call
> path.
> 
> Unlock the crit_lock before returning from reset task.
> 
> Fixes: 5ac49f3c2702 ("iavf: use mutexes for locking of critical sections")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 36433d6..da50ea3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

