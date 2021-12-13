From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 13 Dec 2021 13:27:54 +0000
Subject: [Intel-wired-lan] [PATCH net] iavf: do not override the adapter
 state in the watchdog task (again)
In-Reply-To: <20211201081434.3977672-1-sassmann@kpanic.de>
References: <20211201081434.3977672-1-sassmann@kpanic.de>
Message-ID: <DM8PR11MB562126C8EE3AC17F4CDF0763AB749@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Stefan Assmann
> Sent: ?roda, 1 grudnia 2021 09:15
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; sassmann at kpanic.de; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] iavf: do not override the adapter state
> in the watchdog task (again)
> 
> The watchdog task incorrectly changes the state to __IAVF_RESETTING,
> instead of letting the reset task take care of that. This was already resolved
> by
> 22c8fd71d3a5 iavf: do not override the adapter state in the watchdog task
> but the problem was reintroduced by the recent code refactoring in
> 45eebd62999d.
> 
> Fixes: 45eebd62999d ("iavf: Refactor iavf state machine tracking")
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 14934a7a13ef..360dfb7594cb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2085,7 +2085,6 @@ static void iavf_watchdog_task(struct work_struct

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
