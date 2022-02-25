From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:18:08 +0000
Subject: [Intel-wired-lan] [PATCH net v1 2/8] iavf: Add waiting so the
 port is initialized in remove
In-Reply-To: <20220223123656.29846-1-mateusz.palczewski@intel.com>
References: <20220223123656.29846-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB5629B7270EE1BC6D8A4BA6AAAB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net v1 2/8] iavf: Add waiting so the port is
> initialized in remove
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> There exist races when port is being configured and remove is triggered.
> 
> unregister_netdev is not and can't be called under crit_lock mutex since it is
> calling ndo_stop -> iavf_close which requires this lock. Depending on init
> state the netdev could be still unregistered so unregister_netdev never
> cleans up, when shortly after that the device could become registered.
> 
> Make iavf_remove wait until port finishes initialization.
> All critical state changes are atomic (under crit_lock).
> Crashes that come from iavf_reset_interrupt_capability and
> iavf_free_traffic_irqs should now be solved in a graceful manner.
> 
> Fixes: 605ca7c5c6707 ("iavf: Fix kernel BUG in free_msi_irqs")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 27 ++++++++++++---------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 84ae96e..5e71b38e 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -4558,7 +4558,6 @@ static int __maybe_unused iavf_resume(struct

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
