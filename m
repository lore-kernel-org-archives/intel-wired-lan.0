Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BC606A31D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=P5qe/Pty;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R05gLblW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76D49605D0;
	Thu, 29 Oct 2026 23:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UrCKekeAW0r; Thu, 29 Oct 2026 23:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E03160A7F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793317046;
	b=qTe02MPM0qOBJrZKSkvDFnF8quWoBqYscO17tqjLVjaZUnbnD4w86Peb26I0twb5Xi0S
	 uieFpa2QijYHPL1KJqBHKrY9GvacG/AA5Aa5o5cZlrfNhlm/COv61QyQ8vS3HxuZkb9Dw
	 IJUYNOQQMM9tObmL89iUMDVhDFHNuwuwGC7YF2yQ7jhHNoJovhinQWXqPTOZsWDobs4Vp
	 eYaPv2GGna30PcIxljkS09EL8Jry/Vn3Ybtxy55ul7VMaXvDEZ/Ym3sJjY8WL6zophJ1t
	 06T3kuYrBJzjfXdy5YJUxd0Zywh0NsaSZw4XTtk0n1IsyfIDhkz3gICueRWEllDb1Jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793317046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/wR/f/jzNnM9IMnZQSLQFeKmskM7rJOSKrq8cFGbuJU=;
	b=Rn/YIq0CQxXv/xnAwSBpfhnf4TWXh6I+fexweqeoga0pcaTXKnbJ8Xhiqsv8G/uJw2gt
	 hxL9+UHR1un1kW9JLbJdVAOxU4BFNmx8kc4UFG90AdvJbvHNJA8HUCCtCDRvdFLB0KSzT
	 qdl3KqloIFRdHwFxHZNqeQfoAA1Tcxx7GW20XveEs2rtR09d8gGfzVnx9sjDmEfvV/MYQ
	 6PYuhw6v8vc8y9ruAKAGva7HFwfD4ZU+jE4BKfu6ZcRfhwhH1qKMSrcQgCPk+yXaylmBy
	 ZLJVb8M6eZe6eYLieq0GG9Ko+zpcubUWysnqLnaL/rAe15oKFi0bOoEZ3RViAhR7Jpg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793317046;
	bh=/wR/f/jzNnM9IMnZQSLQFeKmskM7rJOSKrq8cFGbuJU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5qe/PtyO3PIUFyF2HqDC2Pp6g9oR5HCiderTedW5mEwhRX1hCWO46adAZSjGkYsu
	 43HLeCWjMxbBwN7wVScCRTf60Kfc6gibG5/3nP3YOtpo5lWwH+ETks+ps+L4+C0RQ5
	 SqN4FuDLW01s/Fef5Eh/4i4ydDF0c4TG1ECDTJTYnYBtmE8yWxU/AVGnyODCgsd2AH
	 4MClc9HUv36C7Y7C1xAIuJfvOMEPnYUh97I6ctXd+HKMWqLNqQZPsFg4LT8vhCpT2c
	 McvgGu0y0JGe+Cw2P1sGMWMrU6zAZkFQ8bRdQvpC3/civGzq+LqyqbZRZeeK9I0De2
	 uUn5r1H/4KJlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E03160A7F;
	Thu, 29 Oct 2026 23:37:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FFFE712
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 23:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91D1740276
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 23:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wywxFypD_XBJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 23:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 85AD240176
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793317044;
 b=elAYbuV+7xrTR0gjktx2NVkg06F4gbP50u7yy+YX4uJ0/RxwmwWDuF6fm224FbPPoj+Y
 YoFcq7+ka6+lXOZzOGZBiIwvJxo6yD/9QLlLr6dWaUTPA+ccKGQoqpi2KPIGeVPEuVRyU
 IFFhYSf2T6OU9KeSkNOw6Rj/W1VoggCy69IUNjSNTYwx+UVimmI0sKOa9cpEmsMthiPvr
 kAJ2jY/TCCS0mgdfiSpIZ6OAofDcQqn7qT+TF3eGlenjAFYn82E/6P54VF7ka3mNdt5XR
 yLMgMxuHHdSEvrPL9LIdfSC/uoGKCJDDCWBT898Vj6VLZrtkZt/0yB+daCmTYwd2r0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793317044;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=/wR/f/jzNnM9IMnZQSLQFeKmskM7rJOSKrq8cFGbuJU=;
 b=RWHT6MWX5Jcroe29CSf4lnXJACcaYdXuGGj2OlLPH0k5X6bX7YZpx/xUc1UK38AMHkZN
 nGs588l7LlKeJJ8cNKw1y0am8/ilj17ozkGZUqem8YMCzDBu15VLlF4CU9j1gonCUlb0o
 S3Y/YboyFsOPqYGc9QYnKwE8lQQVhMtsVacQcq+Ysv7VE3qACApl1H+yPQIjxMuNLcTKt
 D3qQpGj6ikTZWOoVIuE94MER4S9G7WxoUI1L0nGNBpy2W11FFB1sclzL3kLEGYUJNjEuO
 j/+dEoU2aAs70lA+1TZjVB1lT00YfiIdai7/QlJg41onsQl2u4BLcL42kegF8/U30Gw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R05gLblW; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R05gLblW
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85AD240176
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 23:37:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39C21600C8;
 Thu, 29 Oct 2026 23:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0F41F000C1;
 Thu, 29 Oct 2026 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793317041;
 bh=/wR/f/jzNnM9IMnZQSLQFeKmskM7rJOSKrq8cFGbuJU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=R05gLblWTTN824zu82pI3l2ENb3x0UJOC2wCnnFXkei5l9JntgziiPL8ezIF4Mt5P
 +GarUUsN4gosKnKJjeHjcU2z85IFjIoTdqFY6iS8Mi4t2pXW1r2oJLpYKqtJeVsSWy
 ANNh8H2cs7eB7GGM/yncFyPqQXSQswnxNhQmQqxHUm7C/UzfBbSZWzEfCD1PsavHZ1
 LTkboY5WWkDMdeztFiiP8A16Q+aHX5cYaewmA/Hs+iRxBCboWHqtCTtUbaYCfxOmLZ
 8+7cVlSEgKnq5HsUo1MlKFdIt7k0xXJubn+o6mCBA5jTP2w7EsdfwajLbZ3SP4p1/2
 REq73ohMTC4aw==
Subject: Re: [PATCH net v3 1/2] igc: only strip RX timestamp header from first
 buffer
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 vedang.patel@intel.com, jithu.joseph@intel.com, maciej.fijalkowski@intel.com, 
 andre.guedes@intel.com, aleksandr.loktionov@intel.com,
 avigailx.dahan@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 29 Oct 2026 23:37:20 +0000
Message-ID: <179331704005.3134.12545545223659652020@kernel.org>
In-Reply-To: <20261028083344.3047350-2-p@1g4.org>
References: <20261028083344.3047350-2-p@1g4.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit by itself, the new first-buffer test `!skb &&
  igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)` in igc_clean_rx_irq()…

--

igc: only strip RX timestamp header from first buffer

igc_clean_rx_irq() used to subtract IGC_TS_HDR_LEN from every descriptor
with TSIP set, which truncated multi-buffer packets. With this patch the
timestamp header is only stripped when skb is NULL, which the commit treats
as marking the first buffer of a new packet.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..41b293dc10c3a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;

[Severity: High]

Is skb == NULL a reliable first-buffer marker when an XDP program is
attached? The commit message says:

    Only consume the timestamp header when skb is NULL, which identifies the
    first buffer of a new packet.

Suppose igc_xdp_run_prog() returns IGC_XDP_CONSUMED, IGC_XDP_TX or
IGC_XDP_REDIRECT for the first, non-EOP buffer of a multi-descriptor frame.
Then no skb is built, and igc_clean_rx_irq() moves on to the continuation
descriptor with skb still NULL:

		/* fetch next buffer in frame if non-eop */
		if (igc_is_non_eop(rx_ring, rx_desc))
			continue;

The continuation descriptor still has TSIP set, so this check strips
IGC_TS_HDR_LEN a second time. If that descriptor holds fewer than 16 bytes,
can the unsigned size wrap here?

The continuation buffer then goes through the new-frame path:

		if (!skb) {
			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
					 igc_rx_offset(rx_ring) + pkt_offset,
					 size, true);

In that case the XDP program would see a data_end about 4 GiB past data.
On XDP_PASS, the same size would reach igc_build_skb() or
igc_construct_skb(), and the __skb_put() there does not check it.

At this commit, XDP with multi-descriptor frames looks possible on kernels
with PAGE_SIZE >= 8192. igc_set_rx_mode() only clamps RLPML under the
small-page #if:

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
		rlpml = IGC_MAX_FRAME_BUILD_SKB;
#endif
	wr32(IGC_RLPML, rlpml);

On large-page kernels, RLPML therefore stays at MAX_JUMBO_FRAME_SIZE while
igc_rx_bufsz() returns IGC_RXBUFFER_2048. igc_xdp_set_prog() only checks
dev->mtu > ETH_DATA_LEN, not the hardware receive length limit.

This needs RX hardware timestamping enabled, an XDP program that returns a
non-PASS verdict for a first buffer, and a peer that sends frames larger
than about 2032 bytes.

The next patch in this series, "igc: fix AF_XDP receive buffer size for 2K
UMEM chunks", adds igc_set_rlpml(). It caps RLPML at 1526 bytes whenever
XDP is enabled, whatever PAGE_SIZE is. It is called from igc_setup_rctl()
and igc_xdp_set_prog(). With that change, XDP frames always fit in a single
descriptor, and skb == NULL becomes a correct first-buffer marker.

This patch is tagged Cc: stable and could be backported on its own. Should
it depend on that follow-up change, or should the two patches be swapped in
the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028083344.3047350-1-p%401g4.org
