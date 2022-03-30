From: Drewek, Wojciech <wojciech.drewek@intel.com>
Date: Wed, 30 Mar 2022 09:35:02 +0000
Subject: [Intel-wired-lan] [PATCH intel-next] ice: switch: fix a braino
 in the new dummy packet match definitions
In-Reply-To: <20220330092046.2727362-1-alexandr.lobakin@intel.com>
References: <20220330092046.2727362-1-alexandr.lobakin@intel.com>
Message-ID: <MW4PR11MB5776E0CED116112C8B92199EFD1F9@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks for the fix Alex!

> -----Original Message-----
> From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> Sent: ?roda, 30 marca 2022 11:21
> To: intel-wired-lan at lists.osuosl.org
> Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Drewek, Wojciech <wojciech.drewek@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH intel-next] ice: switch: fix a braino in the new dummy packet match definitions
> 
> There's a trivial mistake[0] in @ice_dummy_pkt_profile due to which
> it incorrectly states that "plain" TCP IPv6 packets should match on
> the flag 'inner IPv6', not the 'outer' one.
> 
> [0] https://lore.kernel.org/netdev/PH0PR11MB5782637EA9771D3ED4E56012FD1E9 at PH0PR11MB5782.namprd11.prod.outlook.com
> 
> Fixes: b5c7ae81ff90 ("ice: switch: convert packet template match code to rodata")
> Reported-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
> Tony, please squash it with the mentioned commit on applying.
> Thanks.
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index ed7130b7abfe..496250f9f8fc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -1276,8 +1276,8 @@ static const struct ice_dummy_pkt_profile ice_dummy_pkt_profiles[] = {
>  	ICE_PKT_PROFILE(udp_ipv6, ICE_PKT_OUTER_IPV6 | ICE_PKT_INNER_UDP),
>  	ICE_PKT_PROFILE(vlan_udp, ICE_PKT_INNER_UDP | ICE_PKT_VLAN),
>  	ICE_PKT_PROFILE(udp, ICE_PKT_INNER_UDP),
> -	ICE_PKT_PROFILE(vlan_tcp_ipv6, ICE_PKT_INNER_IPV6 | ICE_PKT_VLAN),
> -	ICE_PKT_PROFILE(tcp_ipv6, ICE_PKT_INNER_IPV6),
> +	ICE_PKT_PROFILE(vlan_tcp_ipv6, ICE_PKT_OUTER_IPV6 | ICE_PKT_VLAN),
> +	ICE_PKT_PROFILE(tcp_ipv6, ICE_PKT_OUTER_IPV6),
>  	ICE_PKT_PROFILE(vlan_tcp, ICE_PKT_VLAN),
>  	ICE_PKT_PROFILE(tcp, 0),
>  };
> --
> 2.35.1

