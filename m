From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 21:13:49 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: cleanup crosstalk fix
In-Reply-To: <1468971808-39023-1-git-send-email-donald.c.skidmore@intel.com>
References: <1468971808-39023-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF74@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Tuesday, July 19, 2016 4:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: cleanup crosstalk fix
> 
> This patch address a few issues with the initial crosstalk fix.  Most important
> of which is the SDP that indicates the presents of a SFP+ module changes
> between HW types.  With this change that is taken in to consideration
> 
> It also moves the check closer to the base code that checks link.  This makes it
> so we only need to do the check in one spot.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h        |  2 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 71
> +++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 39 --------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |  1 +
>  4 files changed, 72 insertions(+), 41 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
