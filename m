From: Nagaraju, Shwetha <shwetha.nagaraju@intel.com>
Date: Thu, 31 Mar 2022 13:01:49 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 1/3] ice: synchronize_rcu()
 when terminating rings
In-Reply-To: <20220317183629.340350-2-maciej.fijalkowski@intel.com>
References: <20220317183629.340350-1-maciej.fijalkowski@intel.com>
 <20220317183629.340350-2-maciej.fijalkowski@intel.com>
Message-ID: <MW4PR11MB58223B3518AB85AE56ABEA8E90E19@MW4PR11MB5822.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Friday, March 18, 2022 12:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net 1/3] ice: synchronize_rcu() when
> terminating rings
> 
> Unfortunately, the ice driver doesn't respect the RCU critical section that XSK
> wakeup is surrounded with. To fix this, add synchronize_rcu() calls to paths
> that destroy resources that might be in use.
> 
> This was addressed in other AF_XDP ZC enabled drivers, for reference see
> for example commit b3873a5be757 ("net/i40e: Fix concurrency issues
> between config flow and XSK")
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 +++-
> drivers/net/ethernet/intel/ice/ice_xsk.c  | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
Tested-by: Shwetha Nagaraju <Shwetha.nagaraju@intel.com>

