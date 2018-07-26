From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 26 Jul 2018 18:11:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgb: use
 dma_zalloc_coherent instead of allocator/memset
In-Reply-To: <20180719140407.15388-1-yuehaibing@huawei.com>
References: <20180719140407.15388-1-yuehaibing@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DA96B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of YueHaibing
> Sent: Thursday, July 19, 2018 7:04 AM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ixgb: use dma_zalloc_coherent
> instead of allocator/memset
> 
> Use dma_zalloc_coherent instead of dma_alloc_coherent followed by
> memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


