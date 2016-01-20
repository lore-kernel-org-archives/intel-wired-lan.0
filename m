From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 19:28:04 +0000
Subject: [Intel-wired-lan] [next PATCH S28 01/15] i40e: get rid of
	magic	number
In-Reply-To: <1452897202-15204-2-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-2-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F988BBD@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S28 01/15] i40e: get rid of magic
> number
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> We have a define for this, use it. No functional change.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ic0e3ea4f562e46de63b2a8de07f291ccc10205fd
> ---
> Testing Hints: No functional change. Just make sure it compiles.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, compiles correctly
