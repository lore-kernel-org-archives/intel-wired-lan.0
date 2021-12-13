From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 13 Dec 2021 13:34:32 +0000
Subject: [Intel-wired-lan] [PATCH net] iavf: missing unlocks in
 iavf_watchdog_task()
In-Reply-To: <20211110081350.GI5176@kili>
References: <20211110081350.GI5176@kili>
Message-ID: <DM8PR11MB562120FE054D26F5E43475ECAB749@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dan Carpenter
> Sent: ?roda, 10 listopada 2021 09:14
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Cc: Pawlak, Jakub <jakub.pawlak@intel.com>; netdev at vger.kernel.org;
> kernel-janitors at vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; intel-
> wired-lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] iavf: missing unlocks in
> iavf_watchdog_task()
> 
> This code was re-organized and there some unlocks missing now.
> 
> Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 847d67e32a54..b97f685a5cf8 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2012,6 +2012,7 @@ static void iavf_watchdog_task(struct work_struct
> *work)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
