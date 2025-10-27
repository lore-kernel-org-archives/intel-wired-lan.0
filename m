Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D472ECCF9EB
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Oct 2025 16:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A975610F5;
	Mon, 27 Oct 2025 16:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbFS9LkPT6fJ; Mon, 27 Oct 2025 16:23:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD329610B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1761582216;
	bh=X90TYSBE7AGRsWY+m1U/phu+RA92bszzd6/whTypGMM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yf0Nw4T+/2LM/5lZ1WeL+nVN+yevlwaoQvcMoM7Rpgdbx+8WyBenCwkpktjvU/Q0g
	 3o6cRYwD/VI7UFe683LN/fI+fo6pJ4DRKem4DtIS/WIrVfND+VYagtrxDUnGUWJQYV
	 MInxCyKxnIQlf/lus+njZplakzlDj3T4X7nsPCpbda8aoKciNbMtJRjFkqU0MSDYea
	 4VpRXwBdN7UtjjM79Ww2NU8WLqoupqqHxCatb4xjGq2bM/1ysw9v4Ozz5A8BktLLY5
	 DMO0Sb0cVqmpKDyWedsyUrGzB41dlpCr6iDXewRaF01K5KOEj3kqppNqcU8ytiU8+T
	 bUk7eo33Z48rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD329610B3;
	Mon, 27 Oct 2025 16:23:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8694F939
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Oct 2025 16:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CD5283E47
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Oct 2025 16:23:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUJtstGfTLPx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Oct 2025 16:23:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9FFBC83D4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FFBC83D4F
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FFBC83D4F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Oct 2025 16:23:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 00405604DD;
 Mon, 27 Oct 2025 16:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF85C4CEF1;
 Mon, 27 Oct 2025 16:23:30 +0000 (UTC)
Date: Mon, 27 Oct 2025 16:23:28 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <aP-cgMiJ-y_PX7Xa@horms.kernel.org>
References: <20251006162053.3550824-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006162053.3550824-1-aleksander.lobakin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1761582212;
 bh=QFbmOufzCSKxHmY0QccnxuCe5JH8xj8PfL6ljCe973Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bg/wY72mo8btLtpDPdTklIw4ZjgyWtIXqEVuIdpNTnxM+wEilrk3HthuXJkQiCKF8
 KgT+GWJ6/wxGh1ouPSxTJY9s17bKffYSux/OM7mQu0s1AiXLHwy2DtZiD2a4j1djak
 1YnIVHgGQB+AP+nyOC2wqdviBd4ZWRZJfCWQPZqwgqS48YaC6xbWl8ilFwUB7kpQni
 qmn+TlmrIaF7umK2/K3H0FBe6C+5a11TpQdDCYQwgpfY2QgbBTqOaluTcNkYYW/Ey5
 m8f4/egrxbUo0/Ta/msccPRkev/U/3FoJYLZB0cQHRxrf4xN4/xmWYyI6CDetLSPg6
 oR+IzG5minzyQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Bg/wY72m
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: implement configurable
 header split for regular Rx
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

On Mon, Oct 06, 2025 at 06:20:53PM +0200, Alexander Lobakin wrote:
> Add second page_pool for header buffers to each Rx queue and ability
> to toggle the header split on/off using Ethtool (default to off to
> match the current behaviour).
> Unlike idpf, all HW backed up by ice doesn't require any W/As and
> correctly splits all types of packets as configured: after L4 headers
> for TCP/UDP/SCTP, after L3 headers for other IPv4/IPv6 frames, after
> the Ethernet header otherwise (in case of tunneling, same as above,
> but after innermost headers).
> This doesn't affect the XSk path as there are no benefits of having
> it there.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> Applies on top of Tony's next-queue, depends on Michał's Page Pool
> conversion series.
> 
> Sending for review and validation purposes.
> 
> Testing hints: traffic testing with and without header split enabled.
> The header split can be turned on/off using Ethtool:
> 
> sudo ethtool -G <iface> tcp-data-split on (or off)

Nice, I'm very pleased to see this feature in the pipeline for the ice driver.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c

...

> @@ -836,6 +858,20 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
>  		 */
>  		rx_desc->read.pkt_addr = cpu_to_le64(addr);
>  
> +		if (!hdr_fq.pp)
> +			goto next;
> +
> +		addr = libeth_rx_alloc(&hdr_fq, ntu);
> +		if (addr == DMA_MAPPING_ERROR) {
> +			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> +
> +			libeth_rx_recycle_slow(fq.fqes[ntu].netmem);
> +			break;
> +		}
> +
> +		rx_desc->read.hdr_addr = cpu_to_le64(addr);
> +
> +next:

Is performance the reason that a goto is used here, rather than, say, putting
the conditional code in an if condition? Likewise in ice_clean_rx_irq?

>  		rx_desc++;
>  		ntu++;
>  		if (unlikely(ntu == rx_ring->count)) {
> @@ -933,14 +969,16 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		unsigned int size;
>  		u16 stat_err_bits;
>  		u16 vlan_tci;
> +		bool rxe;
>  
>  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
>  
> -		/* status_error_len will always be zero for unused descriptors
> -		 * because it's cleared in cleanup, and overlaps with hdr_addr
> -		 * which is always zero because packet split isn't used, if the
> -		 * hardware wrote DD then it will be non-zero
> +		/*
> +		 * The DD bit will always be zero for unused descriptors
> +		 * because it's cleared in cleanup or when setting the DMA
> +		 * address of the header buffer, which never uses the DD bit.
> +		 * If the hardware wrote the descriptor, it will be non-zero.
>  		 */

The update to this comment feels like it could be a separate patch.
(I know, I often say something like that...)

>  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
>  		if (!ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
> @@ -954,12 +992,27 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  
>  		ice_trace(clean_rx_irq, rx_ring, rx_desc);
>  
> +		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_HBO_S) |
> +				BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> +		rxe = ice_test_staterr(rx_desc->wb.status_error0,
> +				       stat_err_bits);
> +
> +		if (!rx_ring->hdr_pp)
> +			goto payload;
> +
> +		size = le16_get_bits(rx_desc->wb.hdr_len_sph_flex_flags1,
> +				     ICE_RX_FLEX_DESC_HDR_LEN_M);
> +		if (unlikely(rxe))
> +			size = 0;
> +
> +		rx_buf = &rx_ring->hdr_fqes[ntc];
> +		libeth_xdp_process_buff(xdp, rx_buf, size);
> +		rx_buf->netmem = 0;
> +
> +payload:
>  		size = le16_to_cpu(rx_desc->wb.pkt_len) &
>  			ICE_RX_FLX_DESC_PKT_LEN_M;
> -
> -		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> -		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> -					      stat_err_bits)))
> +		if (unlikely(rxe))
>  			size = 0;
>  
>  		/* retrieve a buffer from the ring */
> -- 
> 2.51.0
> 
