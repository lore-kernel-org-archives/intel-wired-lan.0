From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 17:43:01 +0000
Subject: [Intel-wired-lan] [PATCH V3 2/4] ixgbe: Remove unused firmware
 version functions and method
In-Reply-To: <148115000557.19165.7238944461091717770.stgit@mdrustad-wks.jf.intel.com>
References: <148114991608.19165.8749732086590634860.stgit@mdrustad-wks.jf.intel.com>
 <148115000557.19165.7238944461091717770.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39AEC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Wednesday, December 07, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V3 2/4] ixgbe: Remove unused firmware
> version functions and method
> 
> The firmware version method and functions are not used anywhere, so
> remove them all.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |    2 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |    2 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c   |   34 ------------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h   |    4 ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |    1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |    3 +-
>  7 files changed, 1 insertion(+), 46 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
