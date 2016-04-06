From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 16:33:21 +0000
Subject: [Intel-wired-lan] [PATCH V5 03/11] ixgbe: Add support for
 x550em_a	10G MAC type
In-Reply-To: <20160401191809.120975.53450.stgit@mdrustad-wks.jf.intel.com>
References: <20160401191701.120975.34684.stgit@mdrustad-wks.jf.intel.com>
 <20160401191809.120975.53450.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACEDA@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, April 01, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V5 03/11] ixgbe: Add support for x550em_a
> 10G MAC type
> 
> Add support for x550em_a 10G MAC type to the ixgbe driver. The new MAC
> includes new firmware commands that need to be used to control PHY and
> IOSF access, so that support is also added. The interface supported is a native
> SFP+ interface.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Correct endianness of firmware interface for iosf read/write data Changes
> in V5:
> - Change endiannes back due to firmware changes in iosf read/write/data
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    3
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    1
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |    1
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c     |    6 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    9 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |    3
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   43 ++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c     |    2
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     |    6 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   38 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |  208
> ++++++++++++++++++++++
>  11 files changed, 311 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
X550em_a device passes traffic
