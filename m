From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Jul 2020 20:43:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/4] i40e,
 xsk: remove HW descriptor prefetch in AF_XDP path
In-Reply-To: <20200702153730.575738-2-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
 <20200702153730.575738-2-bjorn.topel@gmail.com>
Message-ID: <BN6PR1101MB214588623481B1F71061D8A68C670@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 1/4] i40e, xsk: remove HW
> descriptor prefetch in AF_XDP path
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The software prefetching of HW descriptors has a negative impact on the
> performance. Therefore, it is now removed.
> 
> Performance for the rx_drop benchmark increased with 2%.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 13 +++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx_common.h | 13 -------------
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c         | 12 ++++++++++++
>  3 files changed, 25 insertions(+), 13 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


