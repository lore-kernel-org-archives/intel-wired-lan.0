From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 18:38:54 +0000
Subject: [Intel-wired-lan] [PATCH V5 08/11] ixgbe: Add support for SFPs
 with	retimer
In-Reply-To: <20160401191835.120975.5265.stgit@mdrustad-wks.jf.intel.com>
References: <20160401191701.120975.34684.stgit@mdrustad-wks.jf.intel.com>
 <20160401191835.120975.5265.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACFA1@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, April 01, 2016 12:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V5 08/11] ixgbe: Add support for SFPs with
> retimer
> 
> Add support for SFPs with an external retimer.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |    6 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  133
> +++++++++++++++++++++++++
>  4 files changed, 144 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch applied and compiles cleanly, SFP module correctly identified and configured
