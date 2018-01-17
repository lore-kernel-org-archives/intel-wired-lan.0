From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 17 Jan 2018 20:06:16 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove redundant
 initialization of 'pool'
In-Reply-To: <20180116124809.25790-1-colin.king@canonical.com>
References: <20180116124809.25790-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A92C7A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Tuesday, January 16, 2018 4:48 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: remove redundant initialization of
> 'pool'
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable pool is being assigned zero and then in the following for-loop is it
> being set to zero again. Remove the redundant first assignment.
> 
> Cleans up clang warning:
> drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:61:2: warning: Value stored to
> 'pool' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


