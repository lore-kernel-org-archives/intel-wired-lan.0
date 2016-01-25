From: Patil, Kiran <kiran.patil@intel.com>
Date: Mon, 25 Jan 2016 11:27:48 -0800
Subject: [Intel-wired-lan] [next PATCH v3 12/15] i40e: Fix ATR in
 relation to tunnels
In-Reply-To: <20160125051736.12004.13420.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051736.12004.13420.stgit@localhost.localdomain>
Message-ID: <56A67734.7050007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Thanks Alex for fixing it. Please see in-line comments/suggestion.

-- Kiran P.

On 1/24/2016 9:17 PM, Alexander Duyck wrote:
> This patch contains a number of fixes to make certain that we are using
> the correct protocols when parsing both the inner and outer headers of a
> frame that is mixed between IPv4 and IPv6 for inner and outer.
>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c |   28 +++++++++++----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 6a76c169c07e..ed8d13637c15 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2030,10 +2030,9 @@ tx_only:
>    * @tx_ring:  ring to add programming descriptor to
>    * @skb:      send buffer
>    * @tx_flags: send tx flags
> - * @protocol: wire protocol
>    **/
>   static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
> -		     u32 tx_flags, __be16 protocol)
> +		     u32 tx_flags)
>   {
>   	struct i40e_filter_program_desc *fdir_desc;
>   	struct i40e_pf *pf = tx_ring->vsi->back;
> @@ -2045,6 +2044,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>   	struct tcphdr *th;
>   	unsigned int hlen;
>   	u32 flex_ptype, dtype_cmd;
> +	u8 l4_proto;
>   	u16 i;
>   	/* make sure ATR is enabled */
> @@ -2058,6 +2058,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>   	if (!tx_ring->atr_sample_rate)
>   		return;
>   
> +	/* Currently only IPv4/IPv6 with TCP is supported */
>   	if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
>   		return;
>   
> @@ -2068,26 +2069,19 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
                       union {
                               unsigned char *transport;
                               struct tcphdr *th; /* if needed */
                               struct udphdr *uh; /* if needed */
                      } l4_hdr;

                     /* Obtain start of transport */
                      if ((tx_flags & I40E_TX_FLAGS_TUNNEL))
                                 l4_hdr.transport = 
skb_inner_transport_header(skb);
                     else
                                 l4_hdr.transport = 
skb_transport_header(skb);
>   		/* snag network header to get L4 type and address */
>   		hdr.network = skb_network_header(skb);
>   
> -		/* Currently only IPv4/IPv6 with TCP is supported
> -		 * access ihl as u8 to avoid unaligned access on ia64
> -		 */
> +		/* access ihl as u8 to avoid unaligned access on ia64 */
>   		if (tx_flags & I40E_TX_FLAGS_IPV4)
>   			hlen = (hdr.network[0] & 0x0F) << 2;
> -		else if (protocol == htons(ETH_P_IPV6))
> -			hlen = sizeof(struct ipv6hdr);
>   		else
> -			return;
> +			hlen = sizeof(struct ipv6hdr);
>   	}
>   
> -	/* Currently only IPv4/IPv6 with TCP is supported
> -	 * Note: tx_flags gets modified to reflect inner protocols in
> +	/* Note: tx_flags gets modified to reflect inner protocols in
>   	 * tx_enable_csum function if encap is enabled.
>   	 */
> -	if ((tx_flags & I40E_TX_FLAGS_IPV4) &&
> -	    (hdr.ipv4->protocol != IPPROTO_TCP))
> -		return;
> -	else if ((tx_flags & I40E_TX_FLAGS_IPV6) &&
> -		 (hdr.ipv6->nexthdr != IPPROTO_TCP))
> +	l4_proto = (tx_flags & I40E_TX_FLAGS_IPV4) ? hdr.ipv4->protocol :
> +						     hdr.ipv6->nexthdr;
                     We need to skip extended IPV6 header as well and 
obtain correct value for
                     l4_proto & hlen (may be something like this):

                     {
                             __be16 frag_off;
                             u8 next_hdr;
                             l4_proto = hdr.ipv6->nexthdr;
                             if (unlikely((l4_hdr.transport - 
hdr.network) == sizeof(struct ipv6hdr))) {
                                     off = ipv6_skip_exthdr(skb, 
hdr.network - skb->data + sizeof(struct ipv6hdr),
&l4_proto,&frag_off);
                                     if (unlikely(off < 0))
                                                     return; /* 
Unexpected */
                                     if (unlikely(frag_off))
                                             l4_proto= NEXTHDR_FRAGMENT;

                                     /* Update 'hlen' for the code below 
to work properly */
                                     hlen = l4_hdr.transport - hdr.network;
                             }
                     }
> +	if (l4_proto != IPPROTO_TCP)
>   		return;
>   
>   	th = (struct tcphdr *)(hdr.network + hlen);
> @@ -2124,7 +2118,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>   
>   	flex_ptype = (tx_ring->queue_index << I40E_TXD_FLTR_QW0_QINDEX_SHIFT) &
>   		      I40E_TXD_FLTR_QW0_QINDEX_MASK;
> -	flex_ptype |= (protocol == htons(ETH_P_IP)) ?
> +	flex_ptype |= (tx_flags & I40E_TX_FLAGS_IPV4) ?
>   		      (I40E_FILTER_PCTYPE_NONF_IPV4_TCP <<
>   		       I40E_TXD_FLTR_QW0_PCTYPE_SHIFT) :
>   		      (I40E_FILTER_PCTYPE_NONF_IPV6_TCP <<
> @@ -2992,7 +2986,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
>   	 *
>   	 * NOTE: this must always be directly before the data descriptor.
>   	 */
> -	i40e_atr(tx_ring, skb, tx_flags, protocol);
> +	i40e_atr(tx_ring, skb, tx_flags);
>   
>   	i40e_tx_map(tx_ring, skb, first, tx_flags, hdr_len,
>   		    td_cmd, td_offset);
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

