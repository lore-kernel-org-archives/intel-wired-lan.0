From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Feb 2018 22:38:16 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant
 initialization of variable 'dma'.
In-Reply-To: <20180201183539.24776-1-colin.king@canonical.com>
References: <20180201183539.24776-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949991@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Thursday, February 1, 2018 10:36 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: remove redundant initialization of
> variable 'dma'.
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable dma is initialized with a value that is never read, later on it is re-
> assigned a new value, hence the initialization is redundant and can be
> removed.
> 
> Cleans up clang warning:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:584:13: warning: Value
> stored to 'dma' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


