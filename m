From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 24 Nov 2021 13:01:59 +0000
Subject: [Intel-wired-lan] [PATCH] igb: remove never changed variable
 `ret_val'
In-Reply-To: <20211114060222.231075-1-wangborong@cdjrlc.com>
References: <20211114060222.231075-1-wangborong@cdjrlc.com>
Message-ID: <BYAPR11MB33678E55E77438B1B16B990EFC619@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jason Wang
> Sent: Sunday, November 14, 2021 11:32 AM
> To: kuba at kernel.org
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Jason Wang
> <wangborong@cdjrlc.com>; intel-wired-lan at lists.osuosl.org;
> davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH] igb: remove never changed variable `ret_val'
> 
> The variable used for return status in `igb_write_xmdio_reg' function is never
> changed  and this function is just need return 0. Thus, the `ret_val' can be
> removed and return 0 at the end of the `igb_write_xmdio_reg' function.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_i210.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
