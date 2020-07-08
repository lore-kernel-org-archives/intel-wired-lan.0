From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Jul 2020 20:44:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/4] i40e,
 xsk: increase budget for AF_XDP path
In-Reply-To: <20200702153730.575738-4-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
 <20200702153730.575738-4-bjorn.topel@gmail.com>
Message-ID: <BN6PR1101MB2145C84FFB906F0FA2692D488C670@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bj?rn T?pel
> Sent: Thursday, July 2, 2020 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; Topel, Bjorn
> <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next 3/4] i40e, xsk: increase budget for
> AF_XDP path
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The napi_budget, meaning the number of received packets that are allowed
> to be processed for each napi invocation, takes into consideration that each
> received packet is aimed for the kernel networking stack.
> 
> That is not the case for the AF_XDP receive path, where the cost of each
> packet is significantly less. Therefore, this commit disregards the napi budget
> and increases it to 256. Processing 256 packets targeted for AF_XDP is still less
> work than 64 (napi budget) packets going to the kernel networking stack.
> 
> The performance for the rx_drop scenario is up 7%.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


