From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 15:56:21 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for new X557 device
In-Reply-To: <1471480480-26483-1-git-send-email-donald.c.skidmore@intel.com>
References: <1471480480-26483-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F932D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, August 17, 2016 5:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for new X557 device
> 
> This patch adds support for the new copper device X557.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 8 ++++++++
>  4 files changed, 11 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


