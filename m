From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:56:47 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix warning message and
 call stack during rmmod i40e driver
In-Reply-To: <20210428081941.4765-1-karen.sornek@intel.com>
References: <20210428081941.4765-1-karen.sornek@intel.com>
Message-ID: <MN2PR11MB42244257802EA7A80EF5F9E382879@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sornek, Karen
> Sent: Wednesday, April 28, 2021 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix warning message and call
> stack during rmmod i40e driver
> 
> Restore part of reset functionality used when reset is called from the VF to
> reset itself. Without this fix warning message is displayed when vf is being
> removed via sysfs.
> 
> Fix the crash of the VF  during reset by ensuring that that PF receives the
> reset message successfully.
> Refactor code to use one function instead of two.
> 
> Fixes: eeeddbb80640 ("i40e: drop i40e_pf *pf from i40e_vc_disable_vf()")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 53 ++++++++-----------
>  1 file changed, 21 insertions(+), 32 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


