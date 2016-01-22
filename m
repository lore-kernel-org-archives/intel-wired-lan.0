From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Fri, 22 Jan 2016 13:23:51 -0800
Subject: [Intel-wired-lan] [next PATCH v2 08/15] i40e/i40evf: Do not
 write to descriptor unless we complete
In-Reply-To: <20160122002746.18278.34462.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
 <20160122002746.18278.34462.stgit@localhost.localdomain>
Message-ID: <56A29DE7.80707@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/21/2016 4:27 PM, Alexander Duyck wrote:
>   	__be16 frag_off;
>   	u8 l4_proto = 0;
>   
>   	ip.hdr = skb_network_header(skb);
>   	l4.hdr = skb_transport_header(skb);
>   
> +	/* words in MACLEN + dwords in IPLEN + dwords in L4Len */

May be the comment should say words in MACLEN and as the other fields 
get added later, build upon it...

> +	offset = ((ip.hdr - skb->data) / 2) <<
> +		 I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
> +

>   
>   		exthdr = ip.hdr + sizeof(*ip.v6);
>   		l4_proto = ip.v6->nexthdr;
> @@ -2487,34 +2492,33 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
>   	}
>   
>   	/* Now set the td_offset for IP header length */

Comment needs to be fixed

> -	*td_offset = ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
> -	/* words in MACLEN + dwords in IPLEN + dwords in L4Len */
> -	*td_offset |= (skb_network_offset(skb) >> 1) <<
> -		       I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
> +	offset |= ((l4.hdr - ip.hdr) / 4) << I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
>   
>

