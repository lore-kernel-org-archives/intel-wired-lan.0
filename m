From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 1 Oct 2021 15:28:59 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Make use of the helper function
 devm_add_action_or_reset()
In-Reply-To: <20210922125947.480-1-caihuoqing@baidu.com>
References: <20210922125947.480-1-caihuoqing@baidu.com>
Message-ID: <BYAPR11MB3367C4843DB61D410B095341FCAB9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Cai Huoqing
> Sent: Wednesday, September 22, 2021 6:30 PM
> To: caihuoqing at baidu.com
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] ice: Make use of the helper function
> devm_add_action_or_reset()
> 
> The helper function devm_add_action_or_reset() will internally call
> devm_add_action(), and if devm_add_action() fails then it will execute the
> action mentioned and return the error code. So use
> devm_add_action_or_reset() instead of devm_add_action() to simplify the
> error handling, reduce the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
