Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F578EB3625
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 17:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D61D83544;
	Mon,  2 Mar 2026 17:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKL7-8jSZ5Tk; Mon,  2 Mar 2026 17:32:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66641834F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772472765;
	bh=ThOLX4zusnaZqrrwqYjCDyeTo/0wT+qgsmkju2pTEFI=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xuER0sEmIZFwAuFHpEN9aFyrCXkXDPV/dUMa+RjPs5Fj/1+muB1VEBLlL+jafbdk3
	 JmRyBgVv5f2iJiELNfKWZi+/EFfhbZbghostQG1ymv1Y/PG9Ur+poRcge4BPhCp2il
	 0qWita132J/tLkg+f5rObq6l7CaJlgtOVwIJEjMeem4bJ1vMY1+KsCrTsk01601EeJ
	 t13i9dc/vRDpVTryNO7gNVGtkjOaGA84j3TbhtfSaMsIOshM9xChNk9t1x8jtFoYix
	 QlwO20GcRbNASTFENl/aIBVo7hZqNt6A4wIfLsljI0sMJj6usTPlSSBiXLzSidCyk5
	 rUtedbUkXCQOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66641834F1;
	Mon,  2 Mar 2026 17:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7524A231
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 17:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66F49834F1
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 17:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHy-CTOn9BQT for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 17:32:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8FF68834BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FF68834BA
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FF68834BA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 17:32:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CFBB5402E1;
 Mon,  2 Mar 2026 17:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05836C19423;
 Mon,  2 Mar 2026 17:32:41 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============7315119925973411465=="
MIME-Version: 1.0
Message-Id: <392614bc3c9c3a8b2c42e263181431dd0484f5cc41b0b9831e53d1bcdcb4b6ed@mail.kernel.org>
In-Reply-To: <20260302161723.858616-7-larysa.zaremba@intel.com>
References: <20260302161723.858616-7-larysa.zaremba@intel.com>
From: bot+bpf-ci@kernel.org
To: larysa.zaremba@intel.com,bpf@vger.kernel.org
Cc: larysa.zaremba@intel.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com,
 bastien.curutchet@bootlin.com, tushar.vyavahare@intel.com,
 kernelxing@tencent.com, rbm@suse.com, echaudro@redhat.com, lorenzo@kernel.org,
 toke@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, aleksandr.loktionov@intel.com,
 dtatulea@nvidia.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin
 .lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 17:32:41 +0000 (UTC)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772472761;
 bh=tnpn0LaJUMgqytRuDhKqOEYHDYHlXW9Sposq8jF6yqc=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=iOCI1e9j41WFatME/LLVC5T1+T/WcxsPTAnOYO9sprUHt1kELdT+C2dRHK4rFRust
 x+epksgA5XRcUa7gGWVY1MzYB8CPLAXW8KSCqSKlzgRlBw4D8icLQQuNcNNnLp8V6e
 +zKAVEaS5gK5BgGkBZ6OfWM6cZAhnkeqaNvkI1Ip0pRwugn9T0W0jJxILMq+QELrxn
 hcYnbvH3SPn+vWTxasUExKSAfkQlWAj0jl8rPu7QS7u96cKFuJIxCMJdHjOjirfa4L
 L0jicTT98m6eZAlrsniOazXvil57Ovsu1Bf9RdQCQM7BFSb58lKO0zAHdB+hAnRD7M
 PylBsJsJjSyVg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key)
 header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iOCI1e9j
Subject: Re: [Intel-wired-lan] [PATCH bpf v4 6/9] i40e: use xdp.frame_sz as
 XDP RxQ info frag_size
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

--===============7315119925973411465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3567,6 +3567,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>  	struct i40e_vsi *vsi = ring->vsi;
>  	u32 chain_len = vsi->back->hw.func_caps.rx_buf_chain_len;
>  	u16 pf_q = vsi->base_queue + ring->queue_index;
> +	u32 xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
>  	struct i40e_hw *hw = &vsi->back->hw;

On PAGE_SIZE < 8192 systems, i40e_rx_pg_size() calls
i40e_rx_pg_order() which checks ring->rx_buf_len:

i40e_txrx.h:i40e_rx_pg_order() {
    #if (PAGE_SIZE < 8192)
        if (ring->rx_buf_len > (PAGE_SIZE / 2))
            return 1;
    #endif
        return 0;
}

At this point in the function, ring->rx_buf_len still holds the
value from the previous configuration. It is not updated until
later in the function body:

i40e_main.c:i40e_configure_rx_ring() {
    ...
    u32 xdp_frame_sz = i40e_rx_pg_size(ring) / 2;  // stale rx_buf_len
    ...
    ring->rx_buf_len = vsi->rx_buf_len;  // updated here, after init
    ...
}

Could this lead to a wrong xdp_frame_sz on 4K page systems when
ring->rx_buf_len changes across the PAGE_SIZE/2 (2048) boundary
between configurations?

For example, after AF_XDP ZC teardown on a standard MTU interface,
the previous rx_buf_len from XSK (~3840 with default 4K chunks) is
above 2048, giving pg_order=1 and xdp_frame_sz=4096. But the new
vsi->rx_buf_len for standard MTU is 1534, which would give
pg_order=0 and the correct xdp_frame_sz=2048.

With frag_size set to 4096 but actual buffers only 2048 bytes,
bpf_xdp_frags_increase_tail() would see frag_size > frame_sz and
return -EOPNOTSUPP.

The previous code computed i40e_rx_pg_size(ring) / 2 at the skip
label, after ring->rx_buf_len was already updated, so this ordering
issue did not exist before.

Would it work to move the computation after the rx_buf_len
assignment, for example:

    ring->rx_buf_len = vsi->rx_buf_len;

    xdp_frame_sz = i40e_rx_pg_size(ring) / 2;

    if (ring->vsi->type != I40E_VSI_MAIN)
        goto skip;

> [ ... ]

> @@ -3616,7 +3618,7 @@
>  	}
>
>  skip:
> -	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
> +	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);

> [ ... ]



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22586694870

AI-authorship-score: low
AI-authorship-explanation: The commit shows domain-specific driver knowledge, targeted fix with minimal changes, and a natural commit message style consistent with human kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Variable initialization order causes wrong xdp_frame_sz on 4K page systems when rx_buf_len crosses the PAGE_SIZE/2 boundary between reconfigurations, leading to bpf_xdp_adjust_tail returning -EOPNOTSUPP incorrectly but no memory corruption.

--===============7315119925973411465==--
