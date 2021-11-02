From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 2 Nov 2021 12:23:06 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix static code analysis
 warning
In-Reply-To: <20210830083801.269798-1-karen.sornek@intel.com>
References: <20210830083801.269798-1-karen.sornek@intel.com>
Message-ID: <DM8PR11MB56217718664F35822EA6FA07AB8B9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: poniedzia?ek, 30 sierpnia 2021 10:38
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix static code analysis warning
> 
> Change min() to min_t() to fix static code analysis warning of possible
> overflow.
> 
> Fixes: 6beb84a73ec5 ("i40e/i40evf: napi_poll must return the work done")
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 3525eab8e..42c9f9dc2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>

