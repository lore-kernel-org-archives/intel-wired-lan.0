From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Sep 2015 18:48:12 +0000
Subject: [Intel-wired-lan] [next PATCH S11 09/15] i40e: Fix for
 truncated	interrupt name
In-Reply-To: <1440616461-110869-10-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5AB8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 09/15] i40e: Fix for truncated
> interrupt name
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch extends the size of the text available for the interrupt names.
> Without this patch, all the descriptive data available for the Flow Director
> interrupts is truncated.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I2ac458f23ac3b4ea8f1edf73edc283b1d3704c7f
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
code changes present in tree, "cat /proc/interrupts" shows untruncated interrupt names for i40e.
