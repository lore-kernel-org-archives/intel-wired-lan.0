From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 May 2018 19:14:00 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix memory leak on ipsec
 allocation
In-Reply-To: <20180509135848.20530-1-colin.king@canonical.com>
References: <20180509135848.20530-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B763F19@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Wednesday, May 9, 2018 6:59 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix memory leak on ipsec allocation
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error clean up path kfree's adapter->ipsec and should be instead
> kfree'ing ipsec. Fix this.  Also, the err1 error exit path does not need to kfree
> ipsec because this failure path was for the failed allocation of ipsec.
> 
> Detected by CoverityScan, CID#146424 ("Resource Leak")
> 
> Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


