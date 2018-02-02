From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Feb 2018 22:30:39 +0000
Subject: [Intel-wired-lan] [PATCH] net: ethernet: i40e: remove i40e_fcoe
 files
In-Reply-To: <1517170950-26470-1-git-send-email-clabbe@baylibre.com>
References: <1517170950-26470-1-git-send-email-clabbe@baylibre.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A9494DC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Corentin Labbe
> Sent: Sunday, January 28, 2018 12:23 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Corentin Labbe <clabbe@baylibre.com>
> Subject: [Intel-wired-lan] [PATCH] net: ethernet: i40e: remove i40e_fcoe
> files
> 
> i40e_fcoe support was removed via commit 9eed69a9147c ("i40e: Drop FCoE
> code from core driver files")
> But this left files in place but uncompilable.
> Let's finish the cleaning.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c | 1571 ---------------------------
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.h |  127 ---
>  2 files changed, 1698 deletions(-)
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_fcoe.c
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_fcoe.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

