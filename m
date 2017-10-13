From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 13 Oct 2017 21:31:28 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: only redistribute MSI-X
	vectors	when needed
In-Reply-To: <1507672618-396715-1-git-send-email-shannon.nelson@oracle.com>
References: <1507672618-396715-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC946@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Tuesday, October 10, 2017 2:57 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: only redistribute MSI-X vectors when
> needed
> 
> Whether or not there are vectors_left, we only need to redistribute our
> vectors if we didn't get as many as we requested.  With the current check,
> the code will try to redistribute even if we did in fact get all the vectors we
> requested - this can happen when we have more CPUs than we do vectors.
> This restores an earlier check to be sure we only redistribute if we didn't get
> the full count we requested.
> 
> Fixes: 4ce20abc645f (i40e: fix MSI-X vector redistribution if hw limit is
> reached)
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

