From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 21:00:03 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: return error on upsupported
 SFP module when resetting
In-Reply-To: <20180420000657.2316.31792.stgit@localhost6.localdomain6>
References: <20180420000657.2316.31792.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A9769B9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, April 19, 2018 5:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: return error on upsupported SFP
> module when resetting
> 
> Add check for unsupported module and return the error code.
> This fixes a Coverity hit due to unused return status from setup_sfp.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


