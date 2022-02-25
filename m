From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 25 Feb 2022 16:15:48 +0000
Subject: [Intel-wired-lan] [PATCH net v1 7/8] iavf: Fix missing check
 for running netdev
In-Reply-To: <20220223123843.30728-1-mateusz.palczewski@intel.com>
References: <20220223123843.30728-1-mateusz.palczewski@intel.com>
Message-ID: <SJ0PR11MB56293A7F398696099FE72299AB3E9@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net v1 7/8] iavf: Fix missing check for
> running netdev
> 
> From: SlawomirX Laba <slawomirx.laba@intel.com>
> 
> The driver was queueing reset_task regardless of the netdev state.
> 
> Do not queue the reset task in iavf_change_mtu if netdev is not running.
> 
> Fixes: fdd4044ffdc8 ("iavf: Remove timer for work triggering, use delaying
> work instead")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index da50ea3..be97ac2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3905,8 +3905,11 @@ static int iavf_change_mtu(struct net_device

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
