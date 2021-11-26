From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 26 Nov 2021 14:10:17 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix VF failed to init
 adminq: -53
In-Reply-To: <20211027120447.28075-1-mateusz.palczewski@intel.com>
References: <20211027120447.28075-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB5621BDE495A583BFCEB00363AB639@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: ?roda, 27 pa?dziernika 2021 14:05
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Zulinski,
> NorbertX <norbertx.zulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix VF failed to init adminq: -53
> 
> From: Norbert Zulinski <norbertx.zulinski@intel.com>
> 
> Fix the problem with init adminq in VF reset handler.
> When the PF finished reinitialize VF resource set VFR_VFACTIVE bit in VF
> Reset Status register. It is sign for VF driver among others to shut down and
> reinitialize the admin queue. VF handle reset procedure is sampling this
> register to check every 10ms. PF driver give up to 20ms to VF reset
> procedure. For a single VF reset it is enoungh time to do it but in case request
> VF reset twice, the first VF reset can be not completely finished when PF
> requests it one more time.
> Fixed by adding additional time for VF to finish reset procedure before
> sending next VF reset request by PF.
> 
> Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++++
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 5a488ce..ec0e52c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
