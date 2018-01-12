From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jan 2018 19:12:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make local function
 i40e_get_link_speed static
In-Reply-To: <1515568431-190497-1-git-send-email-weiyongjun1@huawei.com>
References: <1515568431-190497-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D842F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Wei Yongjun
> Sent: Tuesday, January 9, 2018 11:14 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Wei Yongjun
> <weiyongjun1@huawei.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make local function
> i40e_get_link_speed static
> 
> Fixes the following sparse warning:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:5440:5: warning:
>  symbol 'i40e_get_link_speed' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


