From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 7 Dec 2016 19:14:21 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct X550 phy ID
In-Reply-To: <1478292376-38601-1-git-send-email-donald.c.skidmore@intel.com>
References: <1478292376-38601-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA397BC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Friday, November 04, 2016 1:46 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct X550 phy ID
> 
> We were using an old Alpha version of the X550 phy ID.  This was leading to
> unnecessary queries of the PHY.  I removed the old ID (which shouldn't be on
> any HW) and add the two that are.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 3 ++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


