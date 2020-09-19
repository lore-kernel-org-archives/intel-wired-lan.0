From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 19 Sep 2020 07:04:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 5/7] i40e: convert to new
 udp_tunnel infrastructure
In-Reply-To: <20200722012716.2814777-6-kuba@kernel.org>
References: <20200722012716.2814777-1-kuba@kernel.org>
 <20200722012716.2814777-6-kuba@kernel.org>
Message-ID: <SN6PR11MB28969A31367ECAB8B0452FACBC3C0@SN6PR11MB2896.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jakub
> Kicinski
> Sent: Tuesday, July 21, 2020 6:27 PM
> To: davem at davemloft.net
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Jakub Kicinski
> <kuba@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net-next v1 5/7] i40e: convert to new
> udp_tunnel infrastructure
> 
> Make use of the "shared port table" to convert i40e to the new
> infra.
> 
> i40e did not have any reference tracking, locking is also dodgy
> because rtnl gets released while talking to FW, so port may get
> removed from the table while it's getting added etc.
> 
> On the good side i40e does not seem to be using the ports for
> TX so we can remove the table from the driver state completely.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 264 ++++----------------
>  2 files changed, 51 insertions(+), 219 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
