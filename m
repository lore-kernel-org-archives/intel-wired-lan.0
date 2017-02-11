From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 11 Feb 2017 00:57:31 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove unused define
In-Reply-To: <1486064326-43511-1-git-send-email-donald.c.skidmore@intel.com>
References: <1486064326-43511-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5E554@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Thursday, February 02, 2017 11:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove unused define
> 
> Remove the Marvell 1145 PHY define as we have never had a device that
> supports it and have no plan to in the future.  The existence of this define
> has caused confusing on whether or not this PHY was supported by ixgbe.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
