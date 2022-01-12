From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 12 Jan 2022 11:00:24 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix for failed to init
 adminq while VF reset
In-Reply-To: <20211202115201.1304422-1-karen.sornek@intel.com>
References: <20211202115201.1304422-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB562121D9958B6947BF97EECFAB529@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sornek, Karen
> Sent: czwartek, 2 grudnia 2021 12:52
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix for failed to init adminq
> while VF reset
> 
> From: Karen Sornek <karen.sornek@intel.com>
> 
> Fix for failed to init adminq: -53 while VF is resetting via MAC address
> changing procedure.
> Added sync module to avoid reading deadbeef value in reinit adminq during
> software reset.
> Without this patch it is possible to trigger VF reset procedure during reinit
> adminq. This resulted in an incorrect reading of value from the AQP registers
> and generated the -53 error.
> 
> Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
> v2: Added "Fixes" tag
> ---
>  .../net/ethernet/intel/i40e/i40e_register.h   |  3 ++
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 44 ++++++++++++++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h
> b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index 8d0588a27a05..1908eed4fa5e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -413,6 +413,9 @@

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
