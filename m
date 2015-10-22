From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Thu, 22 Oct 2015 00:18:23 +0000
Subject: [Intel-wired-lan] [next PATCH S19 06/15] i40e: Workaround fix
 for	mss < 256 issue
Message-ID: <253CF818969A9240AB2054BF91F2C2BC3024500C@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Subject: [Intel-wired-lan] [next PATCH S19 06/15] i40e: Workaround fix for
> mss < 256 issue
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> HW/NVM sets a limit of no less than 256 bytes for MSS. Stack can send as
> low as 76 bytes MSS. This patch lowers the HW limit to 64 bytes to avoid
> MDDs from firing and causing a reset when the MSS is lower than 256.

This patch should also be backported to net, and sent to -stable.

