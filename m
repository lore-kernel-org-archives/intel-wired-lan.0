From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 19 Nov 2021 13:23:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Remove unnecessary casts
In-Reply-To: <20211110075023.GC5176@kili>
References: <20211110075023.GC5176@kili>
Message-ID: <BYAPR11MB3367577A68B15DB1FBCC2B9EFC9C9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Dan
> Carpenter
> Sent: Wednesday, November 10, 2021 1:20 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next] ice: Remove unnecessary casts
> 
> The "bitmap" variable is already an unsigned long so there is no need for this
> cast.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
