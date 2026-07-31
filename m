Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F103C54F54
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 15:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A624E4105D;
	Fri, 31 Jul 2026 15:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2LKPcfTrJ5l; Fri, 31 Jul 2026 15:22:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0B91410F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785511359;
	bh=jfQPKQUvEhVM07DV/Ae6sTs9WmmayzZHa3H3lJ+JhOc=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oA0vSk/uxo2zTwp1+x9Esj1u3Ssa0PWFHBf4w3i9GDV2R4f157/5r08pmLR35kjG5
	 9mllsLxm6cYcV1FuEA67ZNrNN3LX8ZcT2ajV5luVGYwqqOc7M5xF6ZQJcbFeepPQYd
	 vYi5hdLXz//hGYBb9nOnIYrjSudswgKzolXx9TQCTO31okUyUzb9lsJ1jcxNx4Pa+d
	 eKA+ZnVxYH6xdE+rWbNG2fzh4LwpcN64vz/T/ZAXnuwpsOByOSVNT1ijMc5WDfuc7O
	 UEeaKJz2dHOz7gIB30ZY1chi+bSH9QSEwjrJCbjUzYfYgUfCsFeSqPGqdtBtGlczFj
	 BxCCz0wSz6jwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B91410F8;
	Fri, 31 Jul 2026 15:22:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D4592E9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 15:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2389360816
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 15:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOaD1zDKSP9c for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 15:22:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=mohsin.bashr@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1AE26607C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AE26607C5
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AE26607C5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 15:22:36 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1137917a91.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 08:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511356; x=1786116156;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfQPKQUvEhVM07DV/Ae6sTs9WmmayzZHa3H3lJ+JhOc=;
 b=QsVqRovwM3bpoc0E3DrESp+MHoDiWozhsx6o+nwuINbU3C1uHiddKsXPdQ8Oq83Fj1
 IQuh6oCZ2URex3Jq/uY7W4sPep27hVMfhbnnlnDMvASvU5VJinhMVB56KNc2IYibqRZ7
 r3pJ3P+s/fsGJppuvvK97NREjbyxRpVQs8hORpDOfcEy/TZXULsxbtXlHMYHnUhdk5uX
 1IKvf2eRa3l+6ZIKjwiRVRUtZCO5QYW5keU5+Ej61iru9tyuSlJeS7gLOt7ln7aMu0pE
 HvVagbk6wib3ShLaymg1ovj/oM4GBscaaDGGbfdOTek2M+SYHV3nou/+5EWFF6bTLhhc
 ASsA==
X-Gm-Message-State: AOJu0Yxplh+xQfEoOj4+4NwmR54u9RwoqvhT95vO9v1PqJWnBbQIh6ow
 QHhF5A+6Np47Lw6NulOsmWBJAMB/ocOhZgCn2UFduNrt8SFUxzJJjPS50PV+Kg2h
X-Gm-Gg: AR+sD13va1x6pnYtfdGcGNaPPiXoeCBzdbsG50+Weq3bZukZyMnsvEJoAAn2KchimqR
 tjX+vqIXnO3O2yjscLyXeIwBfFtDs1NckOfLNKk2bB6JadUYJFE5ODuuM4f2yaGxliEGx2Y7cfZ
 1/ImOMxoaSoxxbCgcJJGMJMMVRJSNV92YQLYpfRIsBGJ2Sr7o7zq9OA1wrDa6mg+/shiYENVsSm
 OMHpfXKmMT1E6tniE+7gFSQjx57Dl3YjuvcEoFzSxMtN/hY9htWYn1fivB8hcQc7c9snpD+gD44
 KcO+jUG2UA3+455uiZ/pmX9GakT2zsIa7/u5TjVy03v9H2Qv3RGygfmdDHLAZFm6tUOuHq/egLw
 AfR0drmfgC4Iz9vEwZeNV0F83mSI3jwFgkyzIZ2K5yq4ipE78mXFHUuIr8hmLcE4Z7P4zKhQQIe
 M6Z7gFA/6VjMILvrY6AC8DQPOomnrjqguzPYQ2XCcQPZoMPcH1lDRs/Ke9gl8y8rNhVrhL+9gX6
 TVYnMZKiSaEpjp8D+jCI0LkpeTUdtOFwFwYrWGcy1xEm2LebrZr7Y3JZxk=
X-Received: by 2002:a17:90b:5648:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38fbc55256bmr286165a91.31.1785511356037; 
 Fri, 31 Jul 2026 08:22:36 -0700 (PDT)
Received: from ?IPV6:2601:646:8f02:5350:ce4:701d:f6e3:3a6b?
 ([2601:646:8f02:5350:ce4:701d:f6e3:3a6b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e044912sm8250572eec.15.2026.07.31.08.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 08:22:35 -0700 (PDT)
Message-ID: <34c8d95f-3897-498a-921c-df7c6868af61@gmail.com>
Date: Fri, 31 Jul 2026 08:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chenguang Zhao <chenguang.zhao@linux.dev>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kerneljasonxing@gmail.com, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260731020736.170485-1-chenguang.zhao@linux.dev>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260731020736.170485-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785511356; x=1786116156; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jfQPKQUvEhVM07DV/Ae6sTs9WmmayzZHa3H3lJ+JhOc=;
 b=snUXTJflOisQuU2vTd05RpbrdzZVH8S59yzg7IHt96bBIY9whh8IjylpOtnrxmsmbv
 V7bmub1+u6xt2NS4752dODez5moi/oETFa0WoAtQioyOy3nGpb0cKWmeP7USyOlgKjGh
 nT4GGfTkwzK2i3tI33W6muVo7NKz9gL1J4o0RhmbNeAlt322k1IRSsnTd3Ms7xio3oxY
 uJFOPUX4d89SBBeN8PFY77IrvfoDUaIH3+OOO20GU+2IzF7ZpBsr8nn8hTZwYLAGJlxc
 D/P/wd5LU6lGwUik/FG4+RSxG6vQAMK6895mIa2LxslkrXq0yTwR2QGKYNUI7Kp0vBYx
 nUpQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=snUXTJfl
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] i40e: xsk: use
 xdp_build_skb_from_zc() for XDP_PASS
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 7/30/26 7:07 PM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Replace the driver-local i40e_construct_skb_zc() with the common
> helper xdp_build_skb_from_zc(). On failure, free the xdp buff in
> the caller.
> 
> xdp_build_skb_from_zc() already calls skb_record_rx_queue() and
> eth_type_trans(), so pull the remaining descriptor field setup into
> __i40e_process_skb_fields() and use that on the XDP_PASS path.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> v3:
>   As suggested by Larysa:
>   - Drop eth_skb_pad() on the XDP_PASS path, along with the
>     temporary __skb_push()/__skb_pull() around it. The stack
>     handles short skbs and other vendors do not pad on Rx.
> 
> v2:
>   - https://lore.kernel.org/all/20260729054916.720750-1-chenguang.zhao@linux.dev/
> 
> v1:
>   - https://lore.kernel.org/all/20260724020125.246333-1-chenguang.zhao@linux.dev/
> ---
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++--
>   .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 79 ++-----------------
>   3 files changed, 33 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..87553b14d34a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1833,17 +1833,17 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
>   }
>   
>   /**
> - * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
> + * __i40e_process_skb_fields - Populate skb fields from Rx descriptor
>    * @rx_ring: rx descriptor ring packet is being transacted on
>    * @rx_desc: pointer to the EOP Rx descriptor
>    * @skb: pointer to current skb being populated
>    *
> - * This function checks the ring, descriptor, and packet information in
> - * order to populate the hash, checksum, VLAN, protocol, and
> - * other fields within the skb.
> + * Populate hash, checksum, PTP timestamp and VLAN from @rx_desc. Does not
> + * call skb_record_rx_queue() or eth_type_trans(); callers that already got
> + * those from xdp_build_skb_from_zc() should use this helper.
>    **/
> -void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> -			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
> +void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			       union i40e_rx_desc *rx_desc, struct sk_buff *skb)
>   {
>   	u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
>   	u32 rx_status = FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
> @@ -1858,14 +1858,30 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>   
>   	i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
>   
> -	skb_record_rx_queue(skb, rx_ring->queue_index);
> -
>   	if (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
>   		__le16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
>   
>   		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
>   				       le16_to_cpu(vlan_tag));
>   	}
> +}
> +
> +/**
> + * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
> + * @rx_ring: rx descriptor ring packet is being transacted on
> + * @rx_desc: pointer to the EOP Rx descriptor
> + * @skb: pointer to current skb being populated
> + *
> + * This function checks the ring, descriptor, and packet information in
> + * order to populate the hash, checksum, VLAN, protocol, and
> + * other fields within the skb.
> + **/
> +void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)
> +{
> +	__i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +	skb_record_rx_queue(skb, rx_ring->queue_index);
>   
>   	/* modifies the skb - consumes the enet header */
>   	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> index e26807fd2123..3c52e0e60487 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> @@ -9,6 +9,8 @@
>   int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
>   void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
>   				   u64 qword1);
> +void __i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +			       union i40e_rx_desc *rx_desc, struct sk_buff *skb);
>   void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>   			     union i40e_rx_desc *rx_desc, struct sk_buff *skb);
>   void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..dfa519c30a0d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -3,6 +3,7 @@
>   
>   #include <linux/bpf_trace.h>
>   #include <linux/unroll.h>
> +#include <net/xdp.h>
>   #include <net/xdp_sock_drv.h>
>   #include "i40e_txrx_common.h"
>   #include "i40e_xsk.h"
> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
>   	return count == nb_buffs;
>   }
>   
> -/**
> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> - * @rx_ring: Rx ring
> - * @xdp: xdp_buff
> - *
> - * This functions allocates a new skb from a zero-copy Rx buffer.
> - *
> - * Returns the skb, or NULL on failure.
> - **/
> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> -					     struct xdp_buff *xdp)
> -{
> -	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> -	unsigned int metasize = xdp->data - xdp->data_meta;
> -	struct skb_shared_info *sinfo = NULL;
> -	struct sk_buff *skb;
> -	u32 nr_frags = 0;
> -
> -	if (unlikely(xdp_buff_has_frags(xdp))) {
> -		sinfo = xdp_get_shared_info_from_buff(xdp);
> -		nr_frags = sinfo->nr_frags;
> -	}
> -	net_prefetch(xdp->data_meta);
> -
> -	/* allocate a skb to store the frags */
> -	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> -	if (unlikely(!skb))
> -		goto out;
> -
> -	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> -	       ALIGN(totalsize, sizeof(long)));
> -
> -	if (metasize) {
> -		skb_metadata_set(skb, metasize);
> -		__skb_pull(skb, metasize);
> -	}
> -
> -	if (likely(!xdp_buff_has_frags(xdp)))
> -		goto out;
> -
> -	for (int i = 0; i < nr_frags; i++) {
> -		struct skb_shared_info *skinfo = skb_shinfo(skb);
> -		skb_frag_t *frag = &sinfo->frags[i];
> -		struct page *page;
> -		void *addr;
> -
> -		page = dev_alloc_page();
> -		if (!page) {
> -			dev_kfree_skb(skb);
> -			return NULL;
> -		}
> -		addr = page_to_virt(page);
> -
> -		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -					   addr, 0, skb_frag_size(frag));
> -	}
> -
> -out:
> -	xsk_buff_free(xdp);
> -	return skb;
> -}
> -
>   static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>   				      struct xdp_buff *xdp_buff,
>   				      union i40e_rx_desc *rx_desc,
> @@ -372,21 +309,19 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>   		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>   		 * SBP is *not* set in PRT_SBPVSI (default not set).
>   		 */
> -		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
> +		skb = xdp_build_skb_from_zc(xdp_buff);
>   		if (!skb) {
> +			xsk_buff_free(xdp_buff);
>   			rx_ring->rx_stats.alloc_buff_failed++;
>   			*rx_packets = 0;
>   			*rx_bytes = 0;
>   			return;
>   		}
>   
> -		if (eth_skb_pad(skb)) {
> -			*rx_packets = 0;
> -			*rx_bytes = 0;
> -			return;
> -		}
> -
> -		i40e_process_skb_fields(rx_ring, rx_desc, skb);
> +		/* xdp_build_skb_from_zc() already ran eth_type_trans() and
> +		 * skb_record_rx_queue().
> +		 */
> +		__i40e_process_skb_fields(rx_ring, rx_desc, skb);
>   		napi_gro_receive(&rx_ring->q_vector->napi, skb);
>   		return;
>   	}

The cleanup makes sense. I think you would also need to update kconfig. 
xdp_build_skb_from_zc() verifies page pool support and if 
CONFIG_PAGE_POOL=n, it would return NULL. In that case, we would end-up 
dropping packets in XDP_PASS.

With that addressed:
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
