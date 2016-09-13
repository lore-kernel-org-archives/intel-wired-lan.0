From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 18:27:25 +0000
Subject: [Intel-wired-lan] [next PATCH S46 7/8] i40e: don't
	configure	zero-size RSS table
In-Reply-To: <1473715124-31296-8-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FD0FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, September 12, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S46 7/8] i40e: don't configure zero-
> size RSS table
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some rare cases, we might get a VSI with no queues. In this case, we
> cannot configure RSS on this VSI as it will try to divide by zero when
> configuring the lookup table.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I6ae173a7dd3481a081e079eb10eb80275de2adb0
> ---
> Testing Hints : This bug showed up at Red Hat while testing a DUP. It looks
> like you need Purley and need to enable 32 VFs on all PFs. I haven't
> reproduced the bug; this was found via code inspection.
> 
> HSD-number: 10020370
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com


