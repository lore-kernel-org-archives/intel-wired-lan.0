From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:44:55 +0000
Subject: [Intel-wired-lan] [PATCH net-next] iavf: remove unused debug
 function iavf_debug_d
In-Reply-To: <20190702062021.41524-1-yuehaibing@huawei.com>
References: <20190702062021.41524-1-yuehaibing@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD2B4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of YueHaibing
> Sent: Monday, July 1, 2019 11:20 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] iavf: remove unused debug
> function iavf_debug_d
> 
> There is no caller of function iavf_debug_d() in tree since commit
> 75051ce4c5d8 ("iavf: Fix up debug print macro"), so it can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


