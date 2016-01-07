From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 18:31:15 +0000
Subject: [Intel-wired-lan] [next PATCH S26 04/12] i40e: do TSO only
	if	CHECKSUM_PARTIAL is set
In-Reply-To: <1451932392-15538-5-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-5-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E453@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 04/12] i40e: do TSO only if
> CHECKSUM_PARTIAL is set
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Don't bother trying to set up a TSO if the skb->ip_summed is not set to
> CHECKSUM_PARTIAL.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I6495b3568e404907a2965b48cf3e2effa7c9ab55
> ---
> Testing-Hints:
> I'm sure there's a better test available, but I found this by inspection and
> then adding a debug printk to see what was happening.
> For now, just verify that the code is inserted and compiles.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 +++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 +++
>  2 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
