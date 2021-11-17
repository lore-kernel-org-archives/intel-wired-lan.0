From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 17 Nov 2021 00:35:09 -0500
Subject: [Intel-wired-lan] [PATCH net] ice: fix choosing udp header type
In-Reply-To: <20211116093615.10740-1-michal.swiatkowski@intel.com>
References: <20211116093615.10740-1-michal.swiatkowski@intel.com>
Message-ID: <YZSUjeTxXbNta3lm@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 16, 2021 at 10:36:15AM +0100, Michal Swiatkowski wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> In tunnels packet there can be two UDP headers:
> - outer which for hw should be mark as ICE_UDP_OF
> - inner which for hw should be mark as ICE_UDP_ILOS or as ICE_TCP_IL if
>   inner header is of TCP type
> 
> In none tunnels packet header can be:
> - UDP, which for hw should be mark as ICE_UDP_ILOS
> - TCP, which for hw should be mark as ICE_TCP_IL
> 
> Change incorrect ICE_UDP_OF for none tunnel packets to ICE_UDP_ILOS.
> ICE_UDP_OF is incorrect for none tunnel packets and setting it leads to
> error from hw while adding this kind of recipe.
> 
> In summary, for tunnel outer port type should always be set to
> ICE_UDP_OF, for none tunnel outer and tunnel inner it should always be
> set to ICE_UDP_ILOS.
> 
> Fixes: 9e300987d4a81 ("ice: VXLAN and Geneve TC support")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 26 ++++++++-------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 4e1dac813339..29fe359a5598 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -78,20 +78,13 @@ ice_proto_type_from_ipv6(bool inner)
>  }
>  
>  static enum ice_protocol_type
> -ice_proto_type_from_l4_port(bool inner, u16 ip_proto)
> +ice_proto_type_from_l4_port(u16 ip_proto)
>  {
> -	if (inner) {
> -		switch (ip_proto) {
> -		case IPPROTO_UDP:
> -			return ICE_UDP_ILOS;
> -		}
> -	} else {
> -		switch (ip_proto) {
> -		case IPPROTO_TCP:
> -			return ICE_TCP_IL;
> -		case IPPROTO_UDP:
> -			return ICE_UDP_OF;
> -		}
> +	switch (ip_proto) {
> +	case IPPROTO_TCP:
> +		return ICE_TCP_IL;
> +	case IPPROTO_UDP:
> +		return ICE_UDP_ILOS;
>  	}
>  
>  	return 0;
> @@ -194,8 +187,9 @@ ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
>  		i++;
>  	}
>  
> -	if (flags & ICE_TC_FLWR_FIELD_ENC_DEST_L4_PORT) {
> -		list[i].type = ice_proto_type_from_l4_port(false, hdr->l3_key.ip_proto);
> +	if ((flags & ICE_TC_FLWR_FIELD_ENC_DEST_L4_PORT) &&
> +	    hdr->l3_key.ip_proto == IPPROTO_UDP) {
> +		list[i].type = ICE_UDP_OF;
>  		list[i].h_u.l4_hdr.dst_port = hdr->l4_key.dst_port;
>  		list[i].m_u.l4_hdr.dst_port = hdr->l4_mask.dst_port;
>  		i++;
> @@ -320,7 +314,7 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>  		     ICE_TC_FLWR_FIELD_SRC_L4_PORT)) {
>  		struct ice_tc_l4_hdr *l4_key, *l4_mask;
>  
> -		list[i].type = ice_proto_type_from_l4_port(inner, headers->l3_key.ip_proto);
> +		list[i].type = ice_proto_type_from_l4_port(headers->l3_key.ip_proto);
>  		l4_key = &headers->l4_key;
>  		l4_mask = &headers->l4_mask;
>  
> -- 
> 2.31.1
> 

Please ignore it, I sent it from wrong mail, sorry.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
