From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 17:01:02 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add missing \n to end of
 dev_err	message
In-Reply-To: <20161004112016.12011-1-colin.king@canonical.com>
References: <20161004112016.12011-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FC33@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Tuesday, October 04, 2016 4:20 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Add missing \n to end of dev_err
> message
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_err message is missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


