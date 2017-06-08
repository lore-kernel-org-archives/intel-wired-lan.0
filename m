From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Jun 2017 18:03:42 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf: remove redundant null check
 on key
In-Reply-To: <20170606235407.6478-1-colin.king@canonical.com>
References: <20170606235407.6478-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA899@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Tuesday, June 6, 2017 4:54 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40evf: remove redundant null check on
> key
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> key has previously been null checked so the subsequent null check is
> redundant as key can never be null at that point, so remove it.
> 
> Detected by CoverityScan, CID#1357164 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


