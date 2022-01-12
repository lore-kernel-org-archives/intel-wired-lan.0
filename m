From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 12 Jan 2022 14:29:37 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix issue when maximum
 queues is exceeded
In-Reply-To: <20211105111700.204333-1-jedrzej.jagielski@intel.com>
References: <20211105111700.204333-1-jedrzej.jagielski@intel.com>
Message-ID: <DM8PR11MB5621A8A0E2CFBE711F66B441AB529@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: pi?tek, 5 listopada 2021 12:17
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gawin, JaroslawX <jaroslawx.gawin@intel.com>; Laba, SlawomirX
> <slawomirx.laba@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix issue when maximum
> queues is exceeded
> 
> Before this patch VF interface vanished when maximum queue number was
> exceeded. Driver tried to add next queues even if there was not enough
> space. PF sent incorrect number of queues to the VF when there were not
> enough of them.
> 
> Add an additional condition introduced to check available space in 'qp_pile'
> before proceeding.
> This condition makes it impossible to  add queues if they number is greater
> than the number resulting from available space.
> Also add the search for free space in PF queue pair piles.
> 
> Without this patch VF interfaces are not seen when available space for
> queues has been exceeded and following logs appears permanently in
> dmesg:
> "Unable to get VF config (-32)".
> "VF 62 failed opcode 3, retval: -5"
> "Unable to get VF config due to PF error condition, not retrying"
> 
> ---
> V2: little tweaks in commit msg and changes in the code including:
> change from u16 type to unsigned int,
> comments change and line reduction
> ---
> Fixes: 7daa6bf3294e ("i40e: driver core headers")
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 46 +++++++++++----
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 59 +++++++++++++++++++
>  3 files changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index d7db443abeaf..88883724c575 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
