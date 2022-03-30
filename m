From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 30 Mar 2022 17:28:15 +0000
Subject: [Intel-wired-lan] [PATCH net v1] Revert "iavf: Fix deadlock
 occurrence during resetting VF interface"
In-Reply-To: <20220324131915.13929-1-mateusz.palczewski@intel.com>
References: <20220324131915.13929-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB562180FA88B783E20A485284AB1F9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Thursday, March 24, 2022 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] Revert "iavf: Fix deadlock
> occurrence during resetting VF interface"
> 
> This change caused a regression with resetting while changing network
> namespaces. By clearing the IFF_UP flag, the kernel now thinks it has fully
> closed the device.
> 
> This reverts commit 0cc318d2e8408bc0ffb4662a0c3e5e57005ac6ff.
> 
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 0e178a0a..310fd57 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2706,7 +2706,6 @@ static void iavf_reset_task(struct work_struct


Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
