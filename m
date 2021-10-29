From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:56:07 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix failed opcode
 appearing if handling messages from VF
In-Reply-To: <20210514094313.133485-1-karen.sornek@intel.com>
References: <20210514094313.133485-1-karen.sornek@intel.com>
Message-ID: <MN2PR11MB42248C45E41DFCB5FDF3F2B982879@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sornek, Karen
> Sent: Friday, May 14, 2021 2:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix failed opcode appearing if
> handling messages from VF
> 
> Fix failed operation code appearing if handling messages from VF.
> Implemented by waiting for VF appropriate state if request starts handle
> while VF reset.
> Without this patch the message handling request while VF is in a reset state
> ends with error -5 (I40E_ERR_PARAM).
> 
> Fixes: 6322e63c35d6 ("i40e: properly spell I40E_VF_STATE_* flags")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 70 +++++++++++++------
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  2 +
>  2 files changed, 50 insertions(+), 22 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


