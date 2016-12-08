From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 18:20:00 +0000
Subject: [Intel-wired-lan] [PATCH V3 4/4] ixgbe: Implement support
	for	firmware-controlled PHYs
In-Reply-To: <148115001582.19165.14130485235692814435.stgit@mdrustad-wks.jf.intel.com>
References: <148114991608.19165.8749732086590634860.stgit@mdrustad-wks.jf.intel.com>
 <148115001582.19165.14130485235692814435.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39B49@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Wednesday, December 07, 2016 2:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V3 4/4] ixgbe: Implement support for
> firmware-controlled PHYs
> 
> Implement support for devices that have firmware-controlled PHYs.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Fixed some oversights primarily related to 10M support Changes in V3:
> - Use the correct ops to blink the LED
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |    7
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  156 +++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   45 +++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c     |    3
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |    7
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  387
> ++++++++++++++++++++++
>  7 files changed, 603 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


