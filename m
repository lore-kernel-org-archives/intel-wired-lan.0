From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Sep 2020 02:58:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] i40e,
 xsk: remove HW descriptor prefetch in AF_XDP path
In-Reply-To: <20200825113556.18342-2-bjorn.topel@gmail.com>
References: <20200825113556.18342-1-bjorn.topel@gmail.com>
 <20200825113556.18342-2-bjorn.topel@gmail.com>
Message-ID: <DM6PR11MB2890634F51624FE7FCE50A60BC2A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bj?rn T?pel
> Sent: Tuesday, August 25, 2020 4:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; Topel, Bjorn
> <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>;
> kuba at kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] i40e, xsk: remove HW
> descriptor prefetch in AF_XDP path
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The software prefetching of HW descriptors has a negative impact on
> the performance. Therefore, it is now removed.
> 
> Performance for the rx_drop benchmark increased with 2%.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 13 +++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx_common.h | 13 -------------
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c         | 12 ++++++++++++
>  3 files changed, 25 insertions(+), 13 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
