From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Aug 2017 16:28:44 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V8 01/12] i40e: Fix reporting
 of	supported link modes
In-Reply-To: <20170822105754.29486-2-alice.michael@intel.com>
References: <20170822105754.29486-1-alice.michael@intel.com>
 <20170822105754.29486-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9F277@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 22, 2017 3:58 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S78-V8 01/12] i40e: Fix reporting of
> supported link modes
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch fixes incorrect reporting of supported link modes on some NICs.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 20
> ++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_common.c       | 11 ++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 20
> ++++++++++++++++++--
>  3 files changed, 46 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


