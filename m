From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 14 Dec 2021 14:16:59 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix limit of total
 number of queues to active queues of VF
In-Reply-To: <20210901072146.71558-1-karen.sornek@intel.com>
References: <20210901072146.71558-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB5621E06A56D7FB893A7E47C8AB759@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: ?roda, 1 wrze?nia 2021 09:22
> To: intel-wired-lan at lists.osuosl.org
> Cc: Ashwin Vijayavel <ashwin.vijayavel@intel.com>; Sornek, Karen
> <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix limit of total number of
> queues to active queues of VF
> 
> In the absence of this validation, if the user requests to configure queues
> more than the enabled queues, it results in sending the requested number
> of queues to the kernel stack (due to the asynchronous nature of VF
> response), in which case the stack might pick a queue to transmit that is not
> enabled and result in Tx hang. Fix this bug by limiting the total number of
> queues allocated for VF to active queues of VF.
> 
> Fixes: d5b33d024496 ("i40evf: add ndo_setup_tc callback to i40evf")
> Signed-off-by: Ashwin Vijayavel <ashwin.vijayavel@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 80437ef26..c215ca503 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2647,8 +2647,11 @@ static int iavf_validate_ch_config(struct

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
