From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Jul 2020 20:45:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next 4/4] i40e,
 xsk: move buffer allocation out of the Rx processing loop
In-Reply-To: <20200702153730.575738-5-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
 <20200702153730.575738-5-bjorn.topel@gmail.com>
Message-ID: <BN6PR1101MB214588230CD9820C8AAF3C298C670@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bj?rn T?pel
> Sent: Thursday, July 2, 2020 8:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; Topel, Bjorn
> <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next 4/4] i40e, xsk: move buffer
> allocation out of the Rx processing loop
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Instead of checking in each iteration of the Rx packet processing loop, move
> the allocation out of the loop and do it once for each napi activation.
> 
> For AF_XDP the rx_drop benchmark was improved by 6%.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


