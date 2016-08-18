From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Aug 2016 21:10:47 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add device to MDIO speed
 setting
In-Reply-To: <1471469647-39487-1-git-send-email-donald.c.skidmore@intel.com>
References: <1471469647-39487-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9225@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, August 17, 2016 2:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add device to MDIO speed setting
> 
> This shouldn't matter as nothing should be attached still to be consisted
> control MDIO speed for these devices as well.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
