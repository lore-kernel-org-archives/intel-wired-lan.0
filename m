From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:43:51 +0000
Subject: [Intel-wired-lan] [PATCH 8/8] ice: fix changing of ring
 descriptor size (ethtool -G)
In-Reply-To: <20180920002311.10891-9-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
 <20180920002311.10891-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC40A@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 8/8] ice: fix changing of ring descriptor size
> (ethtool -G)
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> rx_mini_pending was set to an incorrect value. This was causing EINVAL to
> always be returned to 'ethtool -G'. The driver does not support mini or
> jumbo rings so the respective settings should be zero.
> 
> Also, change the valid range of the number of descriptors in the rings to
> make the code simpler and easier for users to understand (this removes the
> valid settings of 8 and 16). Add a system log message indicating when the
> number is rounded-up from what the user specifies with the 'ethtool -G'
> command (i.e. when it is not a multiple of 32), and update the log message
> when a user-provided value is out of range to also indicate the stride.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 17 ++++++++++++++---
>  2 files changed, 16 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


