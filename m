From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 11 Sep 2018 21:56:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: remove redundant
 function ixgbe_fw_recovery_mode()
In-Reply-To: <20180907033844.4876-1-yuehaibing@huawei.com>
References: <20180907033844.4876-1-yuehaibing@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2ECE3E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of YueHaibing
> Sent: Thursday, September 6, 2018 8:39 PM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: remove redundant
> function ixgbe_fw_recovery_mode()
> 
> There are no in-tree callers.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 11 -----------
>  1 file changed, 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


