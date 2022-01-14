From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 14 Jan 2022 04:07:11 +0000
Subject: [Intel-wired-lan] [next-queue,
 v2] i40e: Remove unused RX realloc stat
In-Reply-To: <1641397753-121138-1-git-send-email-jdamato@fastly.com>
References: <1641397753-121138-1-git-send-email-jdamato@fastly.com>
Message-ID: <BYAPR11MB3367C4AD131796BE21D1FF2EFC549@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Wednesday, January 5, 2022 9:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Joe Damato <jdamato@fastly.com>
> Subject: [next-queue,v2] i40e: Remove unused RX realloc stat
> 
> After commit 1a557afc4dd5 ("i40e: Refactor receive routine"),
> rx_stats.realloc_count is no longer being incremented, so remove it.
> 
> The debugfs string was left, but hardcoded to 0. This is intended to prevent
> breaking any existing code / scripts that are parsing debugfs for i40e.
> 
> Fixes: 1a557afc4dd5 ("i40e: Refactor receive routine")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> ---
> v1 -> v2: Fix commit message to include one-line SHA summary. Patch is now
>           based on next-queue.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
