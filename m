From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 29 Mar 2018 22:02:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code
 in ice_init_hw()
In-Reply-To: <1522241445-77090-1-git-send-email-weiyongjun1@huawei.com>
References: <1522241445-77090-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26194A4C58@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Wei Yongjun
> Sent: Wednesday, March 28, 2018 5:51 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; Wei
> Yongjun <weiyongjun1@huawei.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error return code in
> ice_init_hw()
> 
> Fix to return error code ICE_ERR_NO_MEMORY from the alloc error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: dc49c7723676 ("ice: Get MAC/PHY/link info and scheduler topology")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


