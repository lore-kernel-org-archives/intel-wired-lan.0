From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 27 Sep 2018 16:24:27 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix crash with VFs and flow
 director on interface flap
In-Reply-To: <1537773860-42997-1-git-send-email-radoslawx.tyl@intel.com>
References: <1537773860-42997-1-git-send-email-radoslawx.tyl@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC8B2@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Radoslaw Tyl
> Sent: Monday, September 24, 2018 12:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tyl, RadoslawX <radoslawx.tyl@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix crash with VFs and flow director
> on interface flap
> 
> This patch fix crash when we have restore flow director filters after reset
> adapter. In ixgbe_fdir_filter_restore() filter->action is outside of the rx_ring
> array, as it has a VF identifier in the upper 32 bits.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


