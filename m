From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 29 May 2018 21:37:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: introduce a helper to
 simplify code
In-Reply-To: <20180523120813.14800-1-yuehaibing@huawei.com>
References: <20180523120813.14800-1-yuehaibing@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C5ACC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of YueHaibing
> Sent: Wednesday, May 23, 2018 5:08 AM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: introduce a helper to
> simplify code
> 
> ixgbe_dbg_reg_ops_read and ixgbe_dbg_netdev_ops_read copy-pasting
> the same code except for
> ixgbe_dbg_netdev_ops_buf/ixgbe_dbg_reg_ops_buf,
> so introduce a helper ixgbe_dbg_common_ops_read to remove redundant
> code.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c | 57 +++++++++-----------
> ----
>  1 file changed, 21 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


