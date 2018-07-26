From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 26 Jul 2018 18:23:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e/i40evf: remove
 redundant functions i40evf_aq_{set/get}_phy_register
In-Reply-To: <20180726063736.10404-1-yuehaibing@huawei.com>
References: <20180726063736.10404-1-yuehaibing@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DA98A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of YueHaibing
> Sent: Wednesday, July 25, 2018 11:38 PM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40e/i40evf: remove redundant
> functions i40evf_aq_{set/get}_phy_register
> 
> There are no in-tree callers.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 69 -------------------------
>  1 file changed, 69 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


