From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Fri, 22 Jan 2016 13:17:31 -0800
Subject: [Intel-wired-lan] [next PATCH v2 12/15] i40e: Fix ATR in
 relation to tunnels
In-Reply-To: <20160122002811.18278.62265.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
 <20160122002811.18278.62265.stgit@localhost.localdomain>
Message-ID: <56A29C6B.10409@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/21/2016 4:28 PM, Alexander Duyck wrote:
>   	th = (struct tcphdr *)(hdr.network + hlen);
> @@ -2124,7 +2119,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>   
>   	flex_ptype = (tx_ring->queue_index << I40E_TXD_FLTR_QW0_QINDEX_SHIFT) &
>   		      I40E_TXD_FLTR_QW0_QINDEX_MASK;
> -	flex_ptype |= (protocol == htons(ETH_P_IP)) ?

Protocol, incoming parameter is no longer needed should be dropped from 
the function parameters.

> +	flex_ptype |= (tx_flags & I40E_TX_FLAGS_IPV4) ?
>   		      (I40E_FILTER_PCTYPE_NONF_IPV4_TCP <<
>   		       I40E_TXD_FLTR_QW0_PCTYPE_SHIFT) :
>   		      (I40E_FILTER_PCTYPE_NONF_IPV6_TCP <<
>
>

