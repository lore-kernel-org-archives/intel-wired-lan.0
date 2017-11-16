From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:22:08 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 6/9] i40e: Fix FLR reset
 timeout issue
In-Reply-To: <20171114120052.86665-6-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEED8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S82-V4 6/9] i40e: Fix FLR reset timeout
> issue
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch allows detection of upcoming core reset in case NIC gets stuck
> while performing FLR reset. The i40e_pf_reset() function returns
> I40E_ERR_NOT_READY when global reset was detected.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


