From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 21:29:50 +0000
Subject: [Intel-wired-lan] [next PATCH S19 12/15] i40e: return the
 number of	enabled queues for ETHTOOL_GRXRINGS
In-Reply-To: <1445471236-35918-13-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3F83@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S19 12/15] i40e: return the number of
> enabled queues for ETHTOOL_GRXRINGS
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch fixes a problem where using ethtool rxnfc command could let RX
> flow hash be set on disabled queues. This patch fixes the problem by
> returning the number of enabled queues before setting rxnfc.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: Idbac86b0b47ddacc8deee7cd257e41de01cbe5c0
> 
> ---
> Testing-hints: 5535691
> Verify that ethtool set rxnfc cannot set the flow hash on queues that are not
> active, on a system that has a non power of two number of cpus.
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, cannot set number of queues to greater than number of processors.

