From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Oct 2015 16:34:52 +0000
Subject: [Intel-wired-lan] [next-queue v2 1/6] i40evf: add
	missing	kernel-doc argument
In-Reply-To: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1169@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jean Sacren
> Sent: Tuesday, October 13, 2015 12:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v2 1/6] i40evf: add missing kernel-doc
> argument
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> @flush has been missing since the inception of i40evf_irq_enable(). Add it
> for the kernel doc.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: For the whole series, drop the first two due to the simple mistake.
> 
>     For this patch, no changes except for the serial number.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
