From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Sep 2020 03:03:46 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 3/3] i40e,
 xsk: move buffer allocation out of the Rx processing loop
In-Reply-To: <20200825113556.18342-4-bjorn.topel@gmail.com>
References: <20200825113556.18342-1-bjorn.topel@gmail.com>
 <20200825113556.18342-4-bjorn.topel@gmail.com>
Message-ID: <DM6PR11MB2890BF5A351C1D7B016E5E12BC2A0@DM6PR11MB2890.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v2 3/3] i40e, xsk: move buffer
> allocation out of the Rx processing loop
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Instead of checking in each iteration of the Rx packet processing
> loop, move the allocation out of the loop and do it once for each napi
> activation.
> 
> For AF_XDP the rx_drop benchmark was improved by 6%.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
