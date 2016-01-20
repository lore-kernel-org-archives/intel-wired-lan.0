From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 19:47:15 +0000
Subject: [Intel-wired-lan] [next PATCH S28 04/15] i40e: trivial: cleanup
 use	of pf->hw
In-Reply-To: <1452897202-15204-5-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-5-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F988BF2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 04/15] i40e: trivial: cleanup use of
> pf->hw
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This patch makes use of a pointer called hw consistent in the i40e_remove
> function.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Idacc7ff0a09a68289c57457a78618bf5497de077
> ---
> Testing Hints: check remove works via rmmod, mostly just a compile change.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, rmmod works correctly
