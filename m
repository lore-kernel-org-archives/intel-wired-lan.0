From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jan 2018 19:17:54 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40evf: use GFP_ATOMIC under
 spin lock
In-Reply-To: <1515724033-110604-1-git-send-email-weiyongjun1@huawei.com>
References: <1515724033-110604-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D8465@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Wei Yongjun
> Sent: Thursday, January 11, 2018 6:27 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; Wei
> Yongjun <weiyongjun1@huawei.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40evf: use GFP_ATOMIC under
> spin lock
> 
> A spin lock is taken here so we should use GFP_ATOMIC.
> 
> Fixes: 504398f0a78e ("i40evf: use spinlock to protect (mac|vlan)_filter_list")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


