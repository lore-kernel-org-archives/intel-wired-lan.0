Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C2606A335
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=NP6ETPBe;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7fB0Ilp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84A7A80DBA;
	Tue, 10 Nov 2026 04:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTRCEA71b0Q4; Tue, 10 Nov 2026 04:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1F4980D87
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794286391;
	b=eeNjGvcQ7oPcvhAU+9kGekGD1UsLFKbReuIdspow0G560xGnJKd92R5rUht+WHgjtLyu
	 ydggpker07O0/R1E4mUk3WzLxW9fnWNbY5P/Qt5N51WrAcdq2ZTnM6ahFXTV6CD2ksTCC
	 nmFoA6fNjN5+5AV75goSZBqJCSxuviAymkK/PLOLOzP53dNOVC0F9UWwk41MTu1uRShbL
	 aVzFVVw9zVzngMClPNFezKx6U4MlGjIDk5m//vsm9PvJ/BOtOE+/4MFcRTFHZ+z0b9n6n
	 W5x94QYVqi4UpxF1c1/e0ZZoIONkAuJtpjftaWcsPearODwq9Fkp3VluD3ndRnb0GNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794286391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kqmjBtXE7ujUmwu/F7BLQZ3+Q+KZAoq8PrY6Vye5p3k=;
	b=GlDNlvkpumy14tIWQgl1fMpjjgvIza2d8n7egmJVHfMl3ajOsW7WtJqyws0L/EXl260/
	 ybIgeJY3hAHGEoo6W+r7OD8vUeVw7y2W1Hp8Ug1W7WZWCYZyBIvvccMlgJQsX7pBaSMeY
	 Leu/fzw+2WtVLdLGZLMQTJaxqqIqPcvlS4wG5v4iPivQLnZKvH0D+MWbmediOhUmMzRvi
	 n5jwvB9DE+PqvuOdDqc7qrHvNcoJurP++PEW8197yKY7855fOnZApXPSZe+hzE2ewP0wL
	 KUhVIY+phhKiY5XtambDPqg7nqBpN+TgiGnSAhe9iRISJorKNEZusedUL5rOBrF740A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7fB0Ilp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794286391;
	bh=kqmjBtXE7ujUmwu/F7BLQZ3+Q+KZAoq8PrY6Vye5p3k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NP6ETPBebU3/OplIyDupznddoub5OG3FsYLMYBBcFw5/xTa7/b3d+HBO1Ikde2Fn5
	 963LtlBvSgcg0mVPTxRFgIZuYOuSA55KPWI5OL5ZS3urX1h0vCO36rZz3Pgq5RwQYY
	 mVBLLzMaoQxUQH5p+b9+979kxZPkfuaWi4P7IuuaYoSYPNJkpHwxx0dv/0XeI2KwLd
	 4D0wZQQ4PD9cBCrL7U29mEZsz/Bpb618I8RzBbXwRdz8iD0djAr+hVzGdr/SBdVp4v
	 2LnquU5+E4Sx5HzBHkfP9oj4wNsLWS4JwCStBzjFVHOKCj6IkBDLgfc2FAl0LwK8nH
	 FoFaKlDqUQshg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1F4980D87;
	Tue, 10 Nov 2026 04:53:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D12B4335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE64A80D83
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lm6MuLRwMBVO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:53:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A626780D1F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d7fB0Ilp
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A626780D1F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:53:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68EED61DAE;
 Tue, 10 Nov 2026 04:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E061F0089F;
 Tue, 10 Nov 2026 04:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794286388;
 bh=kqmjBtXE7ujUmwu/F7BLQZ3+Q+KZAoq8PrY6Vye5p3k=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=d7fB0IlpLWmUwbDnryvM5899pnrNTy5uNETPNZo840EgVLOP5+et3DY1L1Qn+goyY
 jC65QlAsFDaZ8Cg0+U64X87GX9rI5gST4yjS8h1vyOu82+J/UjtCoDDZe7Mx62gDus
 vaOgk9mRXZzvLBC/r3kQf+BvBzLZ/LCCBmJvmvFaZ/WFNN5VqU54YypfozcpAQWFhP
 NZIPFQ+scHgXZXkTxXRYTzYy+NH23fpvr+0/q0LO/CBEpvF2NYAjb9eQVZol7uYg7z
 IQ3x2uwPyORm64Zt4T5y9R+4knhriqmU+dhQiYwyw30sjzyYFfi6teX8lYRPY1WFd+
 lSi9fBytYHlRQ==
Content-Type: multipart/mixed; boundary="===============6053616401328202004=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <7ac9f990a73ce7a3fb3eaca0830962acb0b4ef0585c7429c89b22b7244a2925e@mail.kernel.org>
In-Reply-To: <a37a908598e396446c1a389e3a58a1fe44a514ac.1794281983.git.tianyi@cloudflare.com>
References: <a37a908598e396446c1a389e3a58a1fe44a514ac.1794281983.git.tianyi@cloudflare.com>
Subject: Re: [PATCH bpf-next 15/15] docs: net: document the skb core extension
 area
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
Date: Tue, 10 Nov 2026 04:53:07 +0000 (UTC)
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

--===============6053616401328202004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> docs: net: document the skb core extension area

TL;DR: The docs don't match the code: the "lost metadata" warning may fire
spuriously for BPF_PROG_RUN live frames on native drivers lacking
skb-ext-pass, and may hide a later real warning. Fix the code or the docs?

> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst

[ ... ]

> +The kernel sets the stored values on the ``skb`` in these cases:
> +
> +- When cpumap or veth builds the ``skb`` from an ``xdp_frame`` after
> +  ``XDP_REDIRECT``.
> +- When ``BPF_PROG_RUN`` with ``BPF_F_TEST_XDP_LIVE_FRAMES`` builds the
> +  ``skb`` after ``XDP_PASS``.
> +- On ``XDP_PASS``, in a driver with the ``skb-ext-pass`` XDP feature,
> +  see `Supported Devices`_.
> +
> +On ``XDP_PASS``, the stored values replace the values that the driver
> +sets from the RX descriptor. On a native XDP driver without the feature,
> +the kernel warns once when the program returns ``XDP_PASS`` with stored
> +values.

This isn't a bug in the text itself, but it doesn't match the code.  Can the
warning fire for BPF_PROG_RUN with BPF_F_TEST_XDP_LIVE_FRAMES even though the
kernel does set the stored values there?

xdp_skb_ext_warn_pass() in net/core/xdp.c skips BPF_PROG_RUN only by testing
for the netdev_rx_queue xdp_rxq:

	/* Generic XDP and BPF_PROG_RUN use the netdev_rx_queue xdp_rxq */
	if (rxq->queue_index < dev->num_rx_queues &&
	    rxq == &dev->_rx[rxq->queue_index].xdp_rxq)
		return;
	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
		return;

In live frames mode the buffers use a private rxq instead.
xdp_test_run_setup() in net/bpf/test_run.c does:

	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);

and xdp_test_run_init_page() passes &xdp->rxq to xdp_init_buff().

So with ctx_in.ingress_ifindex set to a native XDP device that lacks
NETDEV_XDP_ACT_SKB_EXT_PASS (any native driver other than ice or veth), a
program that calls bpf_xdp_skb_ext_store_rx_hash() and returns XDP_PASS gets:

  bpf_prog_run_xdp()
    xdp_skb_ext_warn_pass()
      pr_warn_once("... the stored RX metadata is lost")

while xdp_test_run_batch()->xdp_recv_frames()->__xdp_build_skb_from_frame()
->xdp_skb_ext_to_skb() still applies the values to the skb.

Since this is pr_warn_once(), the false report also uses up the one warning,
so a later real loss on a native driver without the feature is not reported.

Should the warning skip the live frames rxq, or should the documentation say
that BPF_PROG_RUN live frames can warn?  The code comes from f5e7dade0555
("xdp: add the skb-ext-pass XDP feature and warn without it"), and no later
commit in the series changes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755842687
--===============6053616401328202004==--
