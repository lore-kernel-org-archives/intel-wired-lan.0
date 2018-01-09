From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 9 Jan 2018 22:35:40 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use ARRAY_SIZE for array
 sizing calculation on array buf
In-Reply-To: <20180107231751.7847-1-colin.king@canonical.com>
References: <20180107231751.7847-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7FCC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Sunday, January 7, 2018 3:18 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: use ARRAY_SIZE for array sizing
> calculation on array buf
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Use the ARRAY_SIZE macro on array buf to determine size of the array.
> Improvement suggested by coccinelle.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


