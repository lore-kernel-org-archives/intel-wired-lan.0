From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Jun 2016 16:25:30 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Change register variable
	to	unsigned
In-Reply-To: <1465928788-29757-1-git-send-email-donald.c.skidmore@intel.com>
References: <1465928788-29757-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E75D4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Tuesday, June 14, 2016 11:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Change register variable to
> unsigned
> 
> I noticed this variable used for register reads wasn't an unsigned so this patch
> corrects that.  I don't believe this was causing any issue as is but this is more
> consistent with the rest of the driver.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver builds, compiles, and passes traffic.
