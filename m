From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Nov 2017 22:46:54 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix
 reporting incorrect error codes
In-Reply-To: <151096175699.30716.6788678147370883532.stgit@anamdev.jf.intel.com>
References: <151096175699.30716.6788678147370883532.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAF8D3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, November 17, 2017 3:36 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix reporting
> incorrect error codes
> 
> Adding cloud filters could fail for a number of reasons, unsupported filter
> fields for example, which fails during validation of fields itself. This will not
> result in admin command errors and converting the admin queue status to
> posix error code using i40e_aq_rc_to_posix would result in incorrect error
> values. If the failure was due to AQ error itself, reporting that correclty is
> handled in the inner function.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


