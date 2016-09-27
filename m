From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Sep 2016 22:40:39 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add X552 iXFI configuration
 helper	function
In-Reply-To: <1474503712-1901-1-git-send-email-donald.c.skidmore@intel.com>
References: <1474503712-1901-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0ECDD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, September 21, 2016 5:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add X552 iXFI configuration helper
> function
> 
> X553 doesn't need all the initialization that X552 did for iXFI. This patch will
> allow native SPI SFP+ to work with X553 devices.  Future patches will add
> additional configuration as needed.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 86 ++++++++++++++++----
> -------
>  1 file changed, 52 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


