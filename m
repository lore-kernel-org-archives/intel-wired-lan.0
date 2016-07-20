From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 21:17:06 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove redundant check on
 ret_val
In-Reply-To: <1468496829-18912-1-git-send-email-colin.king@canonical.com>
References: <1468496829-18912-1-git-send-email-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF9B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Thursday, July 14, 2016 4:47 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: remove redundant check on ret_val
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The last check on ret_val is redundant since ret_val has not changed since
> the previous check, so remove it as it is extraneous.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
