From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Mon, 27 Apr 2015 12:41:29 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Specify rx hash type wrt
 rx desc RSS type
In-Reply-To: <1429774270-21344-2-git-send-email-fan.du@intel.com>
References: <1429774270-21344-1-git-send-email-fan.du@intel.com>
 <1429774270-21344-2-git-send-email-fan.du@intel.com>
Message-ID: <553E90E9.2050709@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 04/23/2015 12:31 AM, Fan Du wrote:
> RSS could be leveraged by taking account L4 src/dst ports
> as ingredients, thus ingress skb rx hash type should honor
> such the real configuration.
>
> Signed-off-by: Fan Du <fan.du@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   25 +++++++++++++++++++++----
>   1 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index d3f4b0c..5df896b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -1357,14 +1357,31 @@ static int __ixgbe_notify_dca(struct device *dev, void *data)
>   }
>   
>   #endif /* CONFIG_IXGBE_DCA */
> +
> +#define IXGBE_RSS_L4_TYPES_MASK \
> +	((1ul << IXGBE_RXDADV_RSSTYPE_IPV4_TCP) | \
> +	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV4_UDP) | \
> +	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV6_TCP) | \
> +	 (1ul << IXGBE_RXDADV_RSSTYPE_IPV6_UDP))
> +
>   static inline void ixgbe_rx_hash(struct ixgbe_ring *ring,
>   				 union ixgbe_adv_rx_desc *rx_desc,
>   				 struct sk_buff *skb)
>   {
> -	if (ring->netdev->features & NETIF_F_RXHASH)
> -		skb_set_hash(skb,
> -			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
> -			     PKT_HASH_TYPE_L3);
> +	u16 rss_type;
> +
> +	if (!(ring->netdev->features & NETIF_F_RXHASH))
> +		return;
> +
> +	rss_type = le16_to_cpu(rx_desc->wb.lower.lo_dword.hs_rss.pkt_info) &
> +		   IXGBE_RXDADV_RSSTYPE_MASK;
> +
> +	if (!rss_type)
> +		return;
> +
> +	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
> +		     (IXGBE_RSS_L4_TYPES_MASK & (1ul << rss_type)) ?
> +		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
>   }
>   
>   #ifdef IXGBE_FCOE

The patch itself here is fine, however there is a complication in that 
with the current configuration ntuple filters will cause the RSS hash to 
be overwritten with the signature and bucket hash values.  In order to 
resolve that you need to update ixgbe_init_fdir_perfect_82599 so that it 
doesn't set the IXGBE_FDIRCTRL_REPORT_STATUS bit.  Otherwise there is 
the potential for an IPv4 rule to be defined that would set the same 
hash value for multiple flows.

- Alex
