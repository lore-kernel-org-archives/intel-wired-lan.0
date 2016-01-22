From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Fri, 22 Jan 2016 13:25:53 -0800
Subject: [Intel-wired-lan] [next PATCH v2 09/15] i40e/i40evf: Add
 exception handling for Tx checksum
In-Reply-To: <20160122002752.18278.51171.stgit@localhost.localdomain>
References: <20160122002407.18278.95721.stgit@localhost.localdomain>
 <20160122002752.18278.51171.stgit@localhost.localdomain>
Message-ID: <56A29E61.8060503@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/21/2016 4:27 PM, Alexander Duyck wrote:
>   /**
> @@ -2152,10 +2162,12 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
>   
>   	/* Always offload the checksum, since it's in the data descriptor */
>   	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> -		tx_flags |= I40E_TX_FLAGS_CSUM;
> -
> -		i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
> -				    tx_ring, &cd_tunneling);
> +		tso = i40e_tx_enable_csum(skb, &tx_flags, &td_cmd, &td_offset,
> +					  tx_ring, &cd_tunneling);
> +		if (tso < 0)
> +			goto out_drop;
> +		else if (tso)
> +			tx_flags |= I40E_TX_FLAGS_CSUM;

Flag is not used

>   	}
>   
>   	i40e_create_tx_ctx(tx_ring, cd_type_cmd_tso_mss,
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

