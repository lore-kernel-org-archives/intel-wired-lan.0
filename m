Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3C606A326
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MJwE36/e;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS8QK0uX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58DCD80D91;
	Tue, 10 Nov 2026 04:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgLe8ewQ9NId; Tue, 10 Nov 2026 04:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D63E80D87
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794286393;
	b=Zo5mr5/vSVkkaBHplAfPeWkSjCbPqNA8+C85pzNabHu/6t0e7sOgeUl8F3oYiyBLQDk2
	 3jHMU8eF7tWmI0aK+pIp6GOxlnOrx0WlKKPlwSMnVQSgEf+TsBi7WtOM2/xk6jzTUvQKv
	 oQTUtAg5zLJvVuQuMh7YtNFV9lZ021OpRjx3m+glHe3CRuTbZppP8sVSICvpwMCkXb+cg
	 vtZmJ7Ta9u7uZ539Xb0CTfN/sxg3egqpvBtEatnbUkxPWXatpSoJDLlMBb+LzNuRUJRXQ
	 FObbBsuB2nnqx/ETfKmCI5QrLCu51SfH78KBoLAedEvD44Hgyx8D6L+SR+OQ2vgC5/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794286393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=USevh6myHxF9emjydPOskkqmK7kqM8+0knzfuWzYf2E=;
	b=sPJY60/m6vStrl0XJb4RwYiepaUJJF3iiRzUH1xu6CVOgaKlaDETOZSBgL/weOFMm2cX
	 ZPh7Jb2r6eRbUxIuWFIEZxS8jyEaG32Sma6ISYhI/1X5BYXH+TVzFnce5yx4b1vgWXz3i
	 kQoXZ8hTi1w7tIsKcMKYHAvAtSV+DGGMWZtWS5ItyyIwTam5kFaLDzxtZqGwINKCe8XJS
	 T1zQPouECJ8jVN6iWTFs5W90dRn/YtLn4er8yBmgeI0TIrUWMKdtV5G0aZ1Fn+EabZfYT
	 hYC23Tlaz2s/j2RbDhZfpMOjidYwz24bUZypNICLkUfd/9yzp+CQJCcKGtcW3weLNTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS8QK0uX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794286393;
	bh=USevh6myHxF9emjydPOskkqmK7kqM8+0knzfuWzYf2E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MJwE36/eWlHhi9mHsTSaLyOA3Qukhb1j74AMocTFzTikxBqxpKVO/x9/fo4EQIf27
	 DofapwA94JT/kO6Pw4m2LqqgUdFnmyMw8HabkGFzTxSDqVi/U6X9oBOWalvS2DoLgh
	 EgmNCnG4lF/GFm2Ibkk8rPCCbwI/T7wlWA8XTnVyDE1ensztRniRRY+u6EdzLclNfI
	 ou44XWWchCP5wGsfm7nUOZ41os7uAGF1iXA1hlcwGKaCJYOwhfYWlu/oLnSoEBTj2H
	 Lm35opPLQyLK5beW5/6rnkxLt49twlbXodkrFfU4abENMd5diIYuEbiuTD6PwBkpER
	 p+3Fb9JtQF3UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D63E80D87;
	Tue, 10 Nov 2026 04:53:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B00164B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1C7F80D30
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hv5kiYBnqHPj for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFC8580D83
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key)
 header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bS8QK0uX
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFC8580D83
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:53:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D757C42AE3;
 Tue, 10 Nov 2026 04:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1361F008A5;
 Tue, 10 Nov 2026 04:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794286390;
 bh=USevh6myHxF9emjydPOskkqmK7kqM8+0knzfuWzYf2E=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=bS8QK0uXH4CiE/pecLjA47r/58HoMdCcVoCr2Aj5ZbqYX8FUfQZw+zR3zouV2mNmK
 P0Ggop74FtzZ/noDXpDOmBsU8LuIgDwsRcOwIQBKYfTvnSFlvYyQp6mhCsrJj19i4E
 8AtFDqwQo6XuCCnMThbj3A/mquKdc778AaGUdSGFxFPfR9Cu+cvr37erupKdTLZRUZ
 slkziQBQN18Ol9bonmpQusu/LLhK4gYdx+hgOYyYs6truDVcFXoA9KNDzIfFgeEexk
 mh+SsRfu9Yhsgls4oSul1YEhpSfuBnkutavrJtXalAsKNTjUPk5VxJ5Nr9VxAgQYoD
 qETaCtYdWvXGA==
Content-Type: multipart/mixed; boundary="===============6368028081372406392=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <debeafe053a315dc6c0634d019ea48075d9f9f0c68b4395deed84a9630dc77ab@mail.kernel.org>
In-Reply-To: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
References: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values
 when XDP runs on an skb
From: bot+bpf-ci@kernel.org
To: tianyi@cloudflare.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 kuba@kernel.org, hawk@kernel.org
Cc: john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
 deliran@verdict.gg, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com,
 aleksander.lobakin@intel.com, magnus.karlsson@intel.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, razor@blackwall.org,
 madalin.bucur@nxp.com, ioana.ciornei@nxp.com, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, rdunlap@infradead.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, carges@cloudflare.com, jakub@cloudflare.com,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev,
 kernel-team@cloudflare.com, tianyi@cloudflare.com, ast@kernel.org,
 andrii@kernel.org, d
 aniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:53:09 +0000 (UTC)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6368028081372406392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xdp: warn on XDP_PASS with stored values when XDP runs on an skb

TL;DR: Comment nit in xdp_skb_ext_warn_pass(): the new
generic-XDP/BPF_PROG_RUN comment is inaccurate for BPF_F_TEST_XDP_LIVE_FRAMES,
which uses a separate rxq, and the next comment is now stale. Not a bug.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c

[ ... ]

> @@ -1124,12 +1125,17 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
>  void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
>  			   const struct xdp_buff *xdp)
>  {
> -	const struct net_device *dev = xdp->rxq->dev;
> +	const struct xdp_rxq_info *rxq = xdp->rxq;
> +	const struct net_device *dev = rxq->dev;
>  
>  	/* The skb is built later from the xdp_frame */
>  	if (prog->expected_attach_type == BPF_XDP_CPUMAP ||
>  	    prog->expected_attach_type == BPF_XDP_DEVMAP)
>  		return;
> +	/* Generic XDP and BPF_PROG_RUN use the netdev_rx_queue xdp_rxq */
> +	if (rxq->queue_index < dev->num_rx_queues &&
> +	    rxq == &dev->_rx[rxq->queue_index].xdp_rxq)
> +		return;
>  	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
>  	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
>  		return;

This isn't a bug, but is the new comment accurate for BPF_PROG_RUN?

With BPF_F_TEST_XDP_LIVE_FRAMES, xdp_test_run_setup() registers a separate
rxq embedded in struct xdp_test_data:

    xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0)

and xdp_test_run_init_page() then does:

    xdp_init_buff(new_ctx, TEST_XDP_FRAME_SIZE, &xdp->rxq);

so in live-frames mode rxq != &dev->_rx[rxq->queue_index].xdp_rxq and the
early return is not taken.

That also makes the following comment stale: generic XDP and non-live
BPF_PROG_RUN now return at the new check, so only the live-frames
BPF_PROG_RUN can reach the NETDEV_XDP_ACT_BASIC test.

Would something like "Generic XDP and BPF_PROG_RUN without
BPF_F_TEST_XDP_LIVE_FRAMES use the netdev_rx_queue xdp_rxq" match the code
better?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755842687
--===============6368028081372406392==--
