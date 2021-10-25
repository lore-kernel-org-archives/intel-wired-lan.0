From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 25 Oct 2021 18:37:02 +0000
Subject: [Intel-wired-lan] [PATCH -next] intel: Simplify bool conversion
In-Reply-To: <1632898586-96655-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1632898586-96655-1-git-send-email-yang.lee@linux.alibaba.com>
Message-ID: <MN2PR11MB422476A7898C84BAA9840A0D82839@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Yang Li <yang.lee@linux.alibaba.com>
> Sent: Tuesday, September 28, 2021 11:56 PM
> To: kuba at kernel.org
> Cc: davem at davemloft.net; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Yang Li
> <yang.lee@linux.alibaba.com>
> Subject: [PATCH -next] intel: Simplify bool conversion
> 
> Fix the following coccicheck warning:
> ./drivers/net/ethernet/intel/i40e/i40e_xsk.c:229:35-40: WARNING:
> conversion to bool not needed here
> ./drivers/net/ethernet/intel/ice/ice_xsk.c:399:35-40: WARNING:
> conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


