From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jun 2020 19:56:13 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: fix error return code in
 iavf_init_get_resources()
In-Reply-To: <20200618141953.29674-1-weiyongjun1@huawei.com>
References: <20200618141953.29674-1-weiyongjun1@huawei.com>
Message-ID: <BN6PR1101MB2145B27B777562A71BBB122D8C970@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wei Yongjun
> Sent: Thursday, June 18, 2020 7:20 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Jakub Kicinski
> <kuba@kernel.org>
> Cc: intel-wired-lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; Wei
> Yongjun <weiyongjun1@huawei.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] iavf: fix error return code in
> iavf_init_get_resources()
> 
> Fix to return negative error code -ENOMEM from the error handling case
> instead of 0, as done elsewhere in this function.
> 
> Fixes: b66c7bc1cd4d ("iavf: Refactor init state machine")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


