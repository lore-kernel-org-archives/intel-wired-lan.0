From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:31:53 +0000
Subject: [Intel-wired-lan] [next PATCH S93 06/11] i40e: Write access
 protected registers through AQC
In-Reply-To: <20180731104148.11896-6-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB35F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Azarewicz, Piotr <piotr.azarewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S93 06/11] i40e: Write access
> protected registers through AQC
> 
> From: Piotr Azarewicz <piotr.azarewicz@intel.com>
> 
> Write access protected registers (GLGEN_RTRIG and GLGEN_RSTCTL)
> through AQC.
> 
> Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 4 ++++
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 4 ++++
>  2 files changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


