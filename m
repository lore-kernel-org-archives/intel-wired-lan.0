Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F9CCDB46F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jun 2026 16:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC0580F33;
	Mon, 22 Jun 2026 16:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4p3xNh9bwU1; Mon, 22 Jun 2026 16:00:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C4D280F30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782144036;
	bh=GL3oeBCRrbpCjjh6sxmq5ekOO6xnhDFz9CL6H1DCMAY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UeMrLaDH628A76ij+IDzv0hw03G80DGkor0qQ51JisR2+GEWvJc0P2Y/ZB4YQ3Gy+
	 SWF1TvUe+vqhoqd8NS8y4VH/VYYdYJIzjxIXcedFaFO0gQv+IrEpFRlanufvEiiEfi
	 LpJ79Uobj8iYAQWDrzBTvuYD/S32DsdhIJKYf7oi2GEaQfcRgKWesCsXvDho3gx1kd
	 4p93dGQPMzjPpEggBlidYe9/HTTMQrUeP7hdYNBqnWDFRUQ7AO/jgR5oSNugNcvnBJ
	 zKEvNLhZehQ86vqgFqU8I7GfvAri288H3+yat2oqE1Kl0X0JvK6lUVDAvrSGHsWKp9
	 lx1t7OujPvQcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C4D280F30;
	Mon, 22 Jun 2026 16:00:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60105367
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 16:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DD326066B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 16:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HEQsCuAuhNzZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jun 2026 16:00:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3C2FB6066A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C2FB6066A
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C2FB6066A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 16:00:31 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2FF704C28871AA;
 Mon, 22 Jun 2026 17:59:55 +0200 (CEST)
Message-ID: <40abd0b5-7f3f-4cd4-9975-9db4498d15d3@molgen.mpg.de>
Date: Mon, 22 Jun 2026 17:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ding Meng <meng.ding@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jan.kiszka@siemens.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, wq.wang@siemens.com
References: <20260622041718.6106-1-meng.ding@siemens.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260622041718.6106-1-meng.ding@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp
 reporting when NET_RX_BUSY_POLL is disabled
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

Dear Ding,


Thank you for your patch.

Am 22.06.26 um 06:13 schrieb Ding Meng via Intel-wired-lan:
> When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> from the NIC no longer works as expected.

Maybe paste some logs/errors, so it can be easier found by people with 
the same issue.

> This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> fails to perform its driver lookup, and the igc driver's struct
> net_device_ops::ndo_get_tstamp is never invoked.
> 
> Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> a field that the driver has not populated.
> 
> Fix this by populating the hwtstamp field with the correct timestamp
> in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.

Maybe detail, why the adapter needs to be passed now.

Also, please describe a test case to check the change.

> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
> Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Ding Meng <meng.ding@siemens.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 38 ++++++++++++++++-------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8ac16808023..1da8d7aa76d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>   	return skb;
>   }
>   
> -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> +					 struct sk_buff *skb,
> +					 struct igc_xdp_buff *ctx)
> +{
> +	if (!ctx->rx_ts)
> +		return;
> +#ifdef CONFIG_NET_RX_BUSY_POLL

Is there a way to do this in C instead of the pre-processor. That way 
all the code gets build tested. (Is there a config with disabled 
NET_RX_BUSY_POLL?)

> +	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> +	skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
> +#else
> +	struct igc_inline_rx_tstamps *tstamps;
> +
> +	tstamps = ctx->rx_ts;
> +	skb_hwtstamps(skb)->hwtstamp = igc_ptp_rx_pktstamp(adapter,
> +							   tstamps->timer0);
> +#endif
> +}
> +
> +static struct sk_buff *igc_construct_skb(struct igc_adapter *adapter,
> +					 struct igc_ring *rx_ring,
>   					 struct igc_rx_buffer *rx_buffer,
>   					 struct igc_xdp_buff *ctx)
>   {
> @@ -2013,10 +2032,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
>   	if (unlikely(!skb))
>   		return NULL;
>   
> -	if (ctx->rx_ts) {
> -		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> -		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
> -	}
> +	igc_construct_skb_timestamps(adapter, skb, ctx);
>   
>   	/* Determine available headroom for copy */
>   	headlen = size;
> @@ -2686,7 +2702,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>   		else if (ring_uses_build_skb(rx_ring))
>   			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
>   		else
> -			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
> +			skb = igc_construct_skb(adapter, rx_ring, rx_buffer, &ctx);
>   
>   		/* exit if we failed to retrieve a buffer */
>   		if (!xdp_res && !skb) {
> @@ -2738,7 +2754,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>   	return total_packets;
>   }
>   
> -static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
> +static struct sk_buff *igc_construct_skb_zc(struct igc_adapter *adapter,
> +					    struct igc_ring *ring,
>   					    struct igc_xdp_buff *ctx)
>   {
>   	struct xdp_buff *xdp = &ctx->xdp;
> @@ -2760,10 +2777,7 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
>   		__skb_pull(skb, metasize);
>   	}
>   
> -	if (ctx->rx_ts) {
> -		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> -		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
> -	}
> +	igc_construct_skb_timestamps(adapter, skb, ctx);
>   
>   	return skb;
>   }
> @@ -2775,7 +2789,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
>   	struct igc_ring *ring = q_vector->rx.ring;
>   	struct sk_buff *skb;
>   
> -	skb = igc_construct_skb_zc(ring, ctx);
> +	skb = igc_construct_skb_zc(q_vector->adapter, ring, ctx);
>   	if (!skb) {
>   		ring->rx_stats.alloc_failed++;
>   		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);

Otherwise this looks good.


Kind regards,

Paul
