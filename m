From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 5 Apr 2022 14:24:33 +0000
Subject: [Intel-wired-lan] [PATCH intel-net] ice: allow creating VFs for
 !CONFIG_NET_SWITCHDEV
In-Reply-To: <20220401125438.292649-1-maciej.fijalkowski@intel.com>
References: <20220401125438.292649-1-maciej.fijalkowski@intel.com>
Message-ID: <DM8PR11MB562144F46E4BFDFEF06A7B57ABE49@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Friday, April 1, 2022 2:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Swiatkowski, Michal <michal.swiatkowski@intel.com>;
> netdev at vger.kernel.org; kuba at kernel.org; davem at davemloft.net;
> Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net] ice: allow creating VFs for
> !CONFIG_NET_SWITCHDEV
> 
> Currently for !CONFIG_NET_SWITCHDEV kernel builds it is not possible to
> create VFs properly as call to ice_eswitch_configure() returns -EOPNOTSUPP
> for us. This is because CONFIG_ICE_SWITCHDEV depends on
> CONFIG_NET_SWITCHDEV.
> 
> Change the ice_eswitch_configure() implementation for
> !CONFIG_ICE_SWITCHDEV to return 0 instead -EOPNOTSUPP and let
> ice_ena_vfs() finish its work properly.
> 
> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h
> b/drivers/net/ethernet/intel/ice/ice_eswitch.h
> index bd58d9d2e565..6a413331572b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
