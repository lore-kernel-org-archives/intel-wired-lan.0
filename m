From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Sep 2016 18:28:54 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use MDIO_PRTAD_NONE
 consistently
In-Reply-To: <147276353170.65625.9520381365094159590.stgit@mdrustad-wks.jf.intel.com>
References: <147276353170.65625.9520381365094159590.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC5AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Thursday, September 01, 2016 1:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Use MDIO_PRTAD_NONE
> consistently
> 
> The value MDIO_PRTAD_NONE should be used to indicate no PHY address.
> Not 0, not 0xFFFF. Use the MDIO_PRTAD_NONE value consistently.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


