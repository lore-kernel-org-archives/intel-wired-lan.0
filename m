From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 1 Dec 2020 16:15:24 +0100
Subject: [Intel-wired-lan] [net 1/6] ice: fix FDir IPv6 flexbyte
In-Reply-To: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
References: <20201121003835.48424-1-anthony.l.nguyen@intel.com>
Message-ID: <3c992278-b907-29f0-6679-8174df2250fa@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Henry,


Am 21.11.20 um 01:38 schrieb Tony Nguyen:
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> The packet classifier would occasionally misrecognize an IPv6 training
> packet when the next protocol field was 0. The correct value for
> unspecified protocol is IPPROTO_NONE.
> 
> Fixes: 165d80d6adab ("ice: Support IPv6 Flow Director filters")
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index 2d27f66ac853..192729546bbf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -1576,7 +1576,13 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
>   		       sizeof(struct in6_addr));
>   		input->ip.v6.l4_header = fsp->h_u.usr_ip6_spec.l4_4_bytes;
>   		input->ip.v6.tc = fsp->h_u.usr_ip6_spec.tclass;
> -		input->ip.v6.proto = fsp->h_u.usr_ip6_spec.l4_proto;
> +
> +		/* if no protocol requested, use IPPROTO_NONE */
> +		if (!fsp->m_u.usr_ip6_spec.l4_proto)
> +			input->ip.v6.proto = IPPROTO_NONE;
> +		else
> +			input->ip.v6.proto = fsp->h_u.usr_ip6_spec.l4_proto;
> +

I prefer non-negation and the ternary operator, but it?s subjective.

     input->ip.v6.proto = fsp->h_u.usr_ip6_spec.l4_proto ? 
fsp->h_u.usr_ip6_spec.l4_proto : IPPROTO_NONE;

(GCC even has the extension `a ?: b`.)

>   		memcpy(input->mask.v6.dst_ip, fsp->m_u.usr_ip6_spec.ip6dst,
>   		       sizeof(struct in6_addr));
>   		memcpy(input->mask.v6.src_ip, fsp->m_u.usr_ip6_spec.ip6src,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
