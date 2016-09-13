From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 15:34:24 +0000
Subject: [Intel-wired-lan] [next PATCH S46 1/8] i40e: Increase
	minimum	number of allocated VSI
In-Reply-To: <1473715124-31296-2-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCFD7@ORSMSX104.amr.corp.intel.com>
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
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S46 1/8] i40e: Increase minimum
> number of allocated VSI
> 
> From: Akeem Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch increases minimum number of allocated VSIs, so as to resolve
> failure adding VSI for VF when 64-VFs assigned to a PF. The driver supports
> up to 128 VFs per device, users can decide to enable up to 64-VFs on a single
> PF, especially 2 X 40 devices. In that scenario, with VMDq co-existence, there
> would be starvation of VSIs - with this patch, supported features would have
> enough VSIs for configuration now.
> 
> Signed-off-by: Akeem Abodunrin <akeem.g.abodunrin@intel.com>
> Change-ID: If084f4cd823667af8fe7fdc11489c705b32039d5
> ---
> HSD-number: 7660915
> 
>  drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Able to add VSI with max VFs allocated


