From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 16 Jan 2016 07:53:33 -0800
Subject: [Intel-wired-lan] [next PATCH 1/3] i40e: Refactor TSO to
	resolve unwanted behaviors
In-Reply-To: <20160115182014.00000764@unknown>
References: <20160115043921.24270.62791.stgit@localhost.localdomain>
 <20160115044156.24270.72533.stgit@localhost.localdomain>
 <20160115182014.00000764@unknown>
Message-ID: <F5954798-8FC8-47B4-A5A8-E02FA39D040B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'll probably submit a v2 with the cheksum adjustment bits split out into a separate function since there are multiple drivers that need to make similar adjustments to checksums.  That way I only have to have one function doing all the casting between bitwise types.

-Alex

Sent from my iPad

> On Jan 15, 2016, at 6:20 PM, Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
> 
> First, thanks Alex!
> 
> Series looks pretty good, I'm applying it and doing some testing and our
> testers will get to it soon.
> 
> One issue I noted below.
> 
> On Thu, 14 Jan 2016 20:41:56 -0800
> Alexander Duyck <aduyck@mirantis.com> wrote:
> 
>> This patch is meant to be a general clean-up of tso.  There were a number
>> of spots where redundant actions were being taken in regards to the TSO
>> function and the checksum function, or in some cases frames were
>> technically being corrupted with checksums that were never requested.
>> 
>> So first of this patch goes through and takes all the spots that were
>> writing the outer IP header checksum to zero and moves them all into the
>> TSO function.  (This includes the spot in IPv6 where this was occurring).
>> 
>> The second big change I made was to rework the outer checksum functionality
>> so that it would be used when requested via GSO instead of just inserting
>> it on all of the headers.  This way we should be able to control if it is
>> enabled or not via the "udpcsum" flag when creating a VXLANn tunnel.  The
>> functionality will likely not be needed for non-segmented frames as we will
>> be able to just compute the checksum via local checksum offload.
>> 
>> I also dropped some useless flags from the hw_enc_features.  Specifically
>> SCTP offload and RX_CSUM don't have any impact on the actual offloads
>> provided.  Specifically a tunnel doesn't advertise SCTP support, mainly
>> because it is a CRC offload and there is no support for doing it via a
>> software offload.  The RX_CSUM feature doesn't provide any value add due to
>> the fact that it doesn't really do anything for the tunnel.  It either
>> receives checksum offloaded frames or not.  If it chooses to ignore them is
>> entirely up to it.
>> 
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> ---
>> drivers/net/ethernet/intel/i40e/i40e_main.c |   16 ++---
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c |   93 ++++++++++++++++-----------
>> drivers/net/ethernet/intel/i40e/i40e_txrx.h |    1 
>> 3 files changed, 62 insertions(+), 48 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 2cfdd85f50fb..c21ad853d72f 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -7473,8 +7473,6 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
>>        tx_ring->dcb_tc = 0;
>>        if (vsi->back->flags & I40E_FLAG_WB_ON_ITR_CAPABLE)
>>            tx_ring->flags = I40E_TXR_FLAGS_WB_ON_ITR;
>> -        if (vsi->back->flags & I40E_FLAG_OUTER_UDP_CSUM_CAPABLE)
>> -            tx_ring->flags |= I40E_TXR_FLAGS_OUTER_UDP_CSUM;
>>        vsi->tx_rings[i] = tx_ring;
>> 
>>        rx_ring = &tx_ring[1];
>> @@ -9018,12 +9016,12 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>>    np = netdev_priv(netdev);
>>    np->vsi = vsi;
>> 
>> -    netdev->hw_enc_features |= NETIF_F_IP_CSUM      |
>> -                   NETIF_F_RXCSUM      |
>> -                   NETIF_F_SCTP_CRC      |
>> -                   NETIF_F_GSO_UDP_TUNNEL |
>> -                   NETIF_F_GSO_GRE      |
>> -                   NETIF_F_TSO          |
>> +    netdev->hw_enc_features |= NETIF_F_IP_CSUM           |
>> +                   NETIF_F_TSO               |
>> +                   NETIF_F_TSO_ECN           |
>> +                   NETIF_F_GSO_GRE           |
>> +                   NETIF_F_GSO_UDP_TUNNEL      |
>> +                   NETIF_F_GSO_UDP_TUNNEL_CSUM |
>>                   0;
>> 
>>    netdev->features = NETIF_F_SG               |
>> @@ -9045,6 +9043,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
>> 
>>    if (!(pf->flags & I40E_FLAG_MFP_ENABLED))
>>        netdev->features |= NETIF_F_NTUPLE;
>> +    if (pf->flags & I40E_FLAG_OUTER_UDP_CSUM_CAPABLE)
>> +        netdev->features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
>> 
>>    /* copy netdev features into list of user selectable features */
>>    netdev->hw_features |= netdev->features;
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> index ca5f0881a5bf..ac2fa7b02e94 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> @@ -2214,11 +2214,18 @@ out:
>> static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
>>            u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
>> {
>> -    u32 cd_cmd, cd_tso_len, cd_mss;
>> -    struct ipv6hdr *ipv6h;
>> -    struct tcphdr *tcph;
>> -    struct iphdr *iph;
>> -    u32 l4len;
>> +    u64 cd_cmd, cd_tso_len, cd_mss;
>> +    union {
>> +        struct iphdr *v4;
>> +        struct ipv6hdr *v6;
>> +        unsigned char *hdr;
>> +    } ip;
>> +    union {
>> +        struct tcphdr *tcp;
>> +        struct udphdr *udp;
>> +        unsigned char *hdr;
>> +    } l4;
>> +    u32 paylen, l4_offset;
>>    int err;
>> 
>>    if (skb->ip_summed != CHECKSUM_PARTIAL)
>> @@ -2231,35 +2238,51 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
>>    if (err < 0)
>>        return err;
>> 
>> -    iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
>> -    ipv6h = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
>> -
>> -    if (iph->version == 4) {
>> -        tcph = skb->encapsulation ? inner_tcp_hdr(skb) : tcp_hdr(skb);
>> -        iph->tot_len = 0;
>> -        iph->check = 0;
>> -        tcph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
>> -                         0, IPPROTO_TCP, 0);
>> -    } else if (ipv6h->version == 6) {
>> -        tcph = skb->encapsulation ? inner_tcp_hdr(skb) : tcp_hdr(skb);
>> -        ipv6h->payload_len = 0;
>> -        tcph->check = ~csum_ipv6_magic(&ipv6h->saddr, &ipv6h->daddr,
>> -                           0, IPPROTO_TCP, 0);
>> +    ip.hdr = skb_network_header(skb);
>> +    l4.hdr = skb_transport_header(skb);
>> +
>> +    if (skb->encapsulation) {
>> +        if (ip.v4->version == 4) {
>> +            ip.v4->check = 0;
>> +            ip.v4->tot_len = 0;
>> +        } else {
>> +            ip.v6->payload_len = 0;
>> +        }
>> +
>> +        /* if we end up needing to do any changes such as update
>> +         * the pseudo header checksum on the outer header we
>> +         * should do it here.
>> +         */
>> +
>> +        ip.hdr = skb_inner_network_header(skb);
>> +        l4.hdr = skb_inner_transport_header(skb);
>>    }
>> 
>> -    l4len = skb->encapsulation ? inner_tcp_hdrlen(skb) : tcp_hdrlen(skb);
>> -    *hdr_len = (skb->encapsulation
>> -            ? (skb_inner_transport_header(skb) - skb->data)
>> -            : skb_transport_offset(skb)) + l4len;
>> +    /* initialize IP header fields */
>> +    if (ip.v4->version == 4) {
>> +        ip.v4->check = 0;
>> +        ip.v4->tot_len = 0;
>> +    } else {
>> +        ip.v6->payload_len = 0;
>> +    }
>> +
>> +    /* determine offset of transport header */
>> +    l4_offset = l4.hdr - skb->data;
>> +
>> +    /* remove payload length from checksum */
>> +    paylen = ntohs(1) * (u16)~(skb->len - l4_offset);
>> +    l4.tcp->check = ~csum_fold((__force __wsum)paylen + l4.tcp->check);
> 
> introduces sparse errors
>  CHECK   /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2520:18: warning: cast to restricted __be16
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2520:18: warning: cast to restricted __be16
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2520:18: warning: cast to restricted __be16
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2520:18: warning: cast to restricted __be16
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2521:37: warning: restricted __wsum degrades to integer
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2521:67: warning: restricted __sum16 degrades to integer
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2521:59: warning: incorrect type in argument 1 (different base types)
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2521:59:    expected restricted __wsum [usertype] sum
> /home/jbrandeb/git/lad/i40e_linux_master/src/i40e/i40e_txrx.c:2521:59:    got unsigned int
> 
> 
>> +
>> +    /* compute length of segmentation header */
>> +    *hdr_len = (l4.tcp->doff * 4) + l4_offset;
>> 
>>    /* find the field values */
>>    cd_cmd = I40E_TX_CTX_DESC_TSO;
>>    cd_tso_len = skb->len - *hdr_len;
>>    cd_mss = skb_shinfo(skb)->gso_size;
>> -    *cd_type_cmd_tso_mss |= ((u64)cd_cmd << I40E_TXD_CTX_QW1_CMD_SHIFT) |
>> -                ((u64)cd_tso_len <<
>> -                 I40E_TXD_CTX_QW1_TSO_LEN_SHIFT) |
>> -                ((u64)cd_mss << I40E_TXD_CTX_QW1_MSS_SHIFT);
>> +    *cd_type_cmd_tso_mss |= (cd_cmd << I40E_TXD_CTX_QW1_CMD_SHIFT) |
>> +                (cd_tso_len << I40E_TXD_CTX_QW1_TSO_LEN_SHIFT) |
>> +                (cd_mss << I40E_TXD_CTX_QW1_MSS_SHIFT);
>>    return 1;
>> }
>> 
>> @@ -2351,15 +2374,12 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
>>        if (*tx_flags & I40E_TX_FLAGS_IPV4) {
>>            if (*tx_flags & I40E_TX_FLAGS_TSO) {
>>                *cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV4;
>> -                ip_hdr(skb)->check = 0;
>>            } else {
>>                *cd_tunneling |=
>>                     I40E_TX_CTX_EXT_IP_IPV4_NO_CSUM;
>>            }
>>        } else if (*tx_flags & I40E_TX_FLAGS_IPV6) {
>>            *cd_tunneling |= I40E_TX_CTX_EXT_IP_IPV6;
>> -            if (*tx_flags & I40E_TX_FLAGS_TSO)
>> -                ip_hdr(skb)->check = 0;
>>        }
>> 
>>        /* Now set the ctx descriptor fields */
>> @@ -2373,15 +2393,11 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
>>            *tx_flags &= ~I40E_TX_FLAGS_IPV4;
>>            *tx_flags |= I40E_TX_FLAGS_IPV6;
>>        }
>> -        if ((tx_ring->flags & I40E_TXR_FLAGS_OUTER_UDP_CSUM) &&
>> -            (l4_tunnel == I40E_TXD_CTX_UDP_TUNNELING)        &&
>> -            (*cd_tunneling & I40E_TXD_CTX_QW0_EXT_IP_MASK)) {
>> -            oudph->check = ~csum_tcpudp_magic(oiph->saddr,
>> -                    oiph->daddr,
>> -                    (skb->len - skb_transport_offset(skb)),
>> -                    IPPROTO_UDP, 0);
>> +        /* indicate if we need to offload outer UDP header */
>> +        if ((*tx_flags & I40E_TX_FLAGS_TSO) &&
>> +            (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM))
>>            *cd_tunneling |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
>> -        }
>> +
>>    } else {
>>        network_hdr_len = skb_network_header_len(skb);
>>        this_ip_hdr = ip_hdr(skb);
>> @@ -2397,7 +2413,6 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
>>         */
>>        if (*tx_flags & I40E_TX_FLAGS_TSO) {
>>            *td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
>> -            this_ip_hdr->check = 0;
>>        } else {
>>            *td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
>>        }
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> index 1d167b646193..fc77a271aba8 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> @@ -275,7 +275,6 @@ struct i40e_ring {
>> 
>>    u16 flags;
>> #define I40E_TXR_FLAGS_WB_ON_ITR    BIT(0)
>> -#define I40E_TXR_FLAGS_OUTER_UDP_CSUM    BIT(1)
>> #define I40E_TXR_FLAGS_LAST_XMIT_MORE_SET BIT(2)
>> 
>>    /* stats structs */
>> 
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at lists.osuosl.org
>> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
