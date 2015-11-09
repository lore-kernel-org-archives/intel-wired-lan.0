From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Nov 2015 18:06:02 +0000
Subject: [Intel-wired-lan] [next PATCH S21 03/14] i40evf: remove
 duplicate	string
In-Reply-To: <1446852372-25480-4-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-4-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1808@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 03/14] i40evf: remove duplicate
> string
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> We already print the driver info string in probe, so don't print it again in init.
> No need to repeat. No need to repeat.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ief597997f580a8c54d5950e3a84c29f2075be66b
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
