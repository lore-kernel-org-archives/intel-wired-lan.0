From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Mar 2018 17:14:00 +0000
Subject: [Intel-wired-lan] [PATCH][next] ixgbevf: ensure xdp_ring
 resources are free'd on error exit
In-Reply-To: <20180327142148.13603-1-colin.king@canonical.com>
References: <20180327142148.13603-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A95815B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Tuesday, March 27, 2018 7:22 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] ixgbevf: ensure xdp_ring resources
> are free'd on error exit
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current error handling for failed resource setup for xdp_ring data is a
> break out of the loop and returning 0 indicated everying was OK, when in fact
> it is not.  Fix this by exiting via the error exit label err_setup_tx that will clean
> up the resources correctly and return and error status.
> 
> Detected by CoverityScan, CID#1466879 ("Logically dead code")
> 
> Fixes: 21092e9ce8b1 ("ixgbevf: Add support for XDP_TX action")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


