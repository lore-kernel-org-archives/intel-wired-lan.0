From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:59:05 +0000
Subject: [Intel-wired-lan] [next PATCH S12 10/15] i40e: Fix for extra
 Flow	Director filter in table after error
In-Reply-To: <1440690163-128213-11-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
 <1440690163-128213-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6478@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, August 27, 2015 8:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S12 10/15] i40e: Fix for extra Flow
> Director filter in table after error
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where the pf's fdir filter table would have an entry
> that the hw was unable to add. This notification happens in the hot path, so
> instead of trying to fix it then, we note the location in the failure case and
> delete it during regular fdir subtask callback. Without this patch, a case can
> occur where an invalid entry gets replayed and a valid one is not.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I67831c183b5d0309876de807cc434809b74c9cb7
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  3 ++-
>  3 files changed, 17 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
