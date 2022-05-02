From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 2 May 2022 13:49:27 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix module_param
 allow_unsupported_sfp type
In-Reply-To: <20220414202104.900-1-jeffd@silicom-usa.com>
References: <20220414202104.900-1-jeffd@silicom-usa.com>
Message-ID: <BYAPR11MB336747967A2B4F98B0B3BC73FCC19@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Daly
> Sent: Friday, April 15, 2022 1:51 AM
> To: intel-wired-lan at osuosl.org
> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open list
> <linux-kernel@vger.kernel.org>; moderated list:INTEL ETHERNET DRIVERS
> <intel-wired-lan@lists.osuosl.org>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix module_param
> allow_unsupported_sfp type
> 
> The module_param allow_unsupported_sfp should be a boolean to match
> the type in the ixgbe_hw struct.
> 
> Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
