From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Dec 2016 18:00:56 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Add PF support for
	VF	promiscuous mode
In-Reply-To: <1481854712-29454-2-git-send-email-donald.c.skidmore@intel.com>
References: <1481854712-29454-1-git-send-email-donald.c.skidmore@intel.com>
 <1481854712-29454-2-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA4C885@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Thursday, December 15, 2016 6:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Add PF support for VF
> promiscuous mode
> 
> This patch extends the xcast mailbox message to include support for unicast
> promiscuous mode.  To allow a VF to enter this mode the PF must be in
> promiscuous mode.
> 
> A later patch will add the support needed in the VF driver (ixgbevf)
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 47
> ++++++++++++++++++++++----
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |  2 ++
>  4 files changed, 45 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


