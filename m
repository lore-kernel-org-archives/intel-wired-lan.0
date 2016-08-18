From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Aug 2016 21:11:04 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix led interface for X557
 devices.
In-Reply-To: <1471457517-28904-1-git-send-email-donald.c.skidmore@intel.com>
References: <1471457517-28904-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9231@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, August 17, 2016 11:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix led interface for X557 devices.
> 
> The X557 devices use a different interface to the LED for the port.
> This patch reflect that change.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  3 ++
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 52
> +++++++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
