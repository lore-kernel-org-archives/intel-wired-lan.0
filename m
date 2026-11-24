Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C6606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pdHyFkQp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQlFSDZY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 057AE607EB;
	Tue, 24 Nov 2026 11:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C9uqRLp1GFGW; Tue, 24 Nov 2026 11:29:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C3CB60815
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795519743;
	b=s5lHOU74XoLJF209V9OIq0m5iRnybvWAC60yZjgwlKDaUwVhK6CyVNiO7w4rrNdYl9HV
	 wG1/50Bd8a+K1QWnkCTSucTXXS5UxfPK1xXa3uupQQvIb7OTrVgaxxw9WTuTAg0gcg7mj
	 9FI2ox1vFXd2I83+b8Pv5+CImQ52k3rNudqr0wUfHiWrNnROyUl6lg9JvR1STDgaWJWz5
	 /9wiuSM2hDTaglzkoZaJetrzgRac+6zYaN6qYMWujaRgla5/EqSgNnCMQXlAynaFJc6Ri
	 2mUrnPsx9MgMPayL1Pqa7pFrlK+CERCqHMz6s+0xgPXxqegqjqdw61idLIlabbJ1vtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795519743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tLnWd5jhubOeFNRkHGC8qqDZ8N8UGLt+6HY9hXZev7c=;
	b=lhBryR75eWDV/XJl3gJQwpET3JxOwJZTOfwZO2zizAWqGHZwaRjZKJEngVnsKpwOV45A
	 8oG0zpuvgt7W2Y0xWHgP46AWFq5KMA7jrEwjriNprOVZjHzUM3pW2wZ3gUrRZsV3FdpUb
	 Ah61R+ddC5DkJJbtCqYSd3Zn9WdDyD7HJV6lP8tbPXzYTDrQGyMp7iADduW6HEGNpywSR
	 5mt5ifXdAR3FvYTt1FbbHqGWAvPCvCOcsDo4TJ0jUdbhXCBZ3QY6PiSx8AXoLpigH9F18
	 2EaUiuFnNyy+rD12SOloaY8Qi4vsyCe4HynrTheSE7U43x3+xrSSzbdETg88Z0Zm90A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795519743;
	bh=tLnWd5jhubOeFNRkHGC8qqDZ8N8UGLt+6HY9hXZev7c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdHyFkQpF1zv5u9BLKF3DQdhtFlvhxN+xJpKuC+mIyuS7MUUSSJ93swvfUzGhxznC
	 y1jgePYSMaYiODT8mePRG0e6FGQZumlsrLptdm/dNinjGXvbfm6+Nk3YguAXHXCZgh
	 9v2DKxt4joyUZYMc+Lf2fFoqo1zSLbWg0bXNPpQxx3p9B9bWbx31j0hRSR17AYrLzz
	 /xhg9SH5pqf76y2m0PdQUxFAey689GBmod3z6Gs+fJ43NFtj2f5/Yrxkd1vkRsOz7e
	 6wHWw8310cZfepaGp0vgbKgkt9m2TmUTEcG4RdWIdtK7qStydI4lwqVmWuRM9FW32q
	 hWVgM8q/QA28A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C3CB60815;
	Tue, 24 Nov 2026 11:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EA221AB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2076280CB0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0ibQamThQxv for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 11:29:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2919180C87
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AQlFSDZY
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2919180C87
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:28:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B47441ABB;
 Tue, 24 Nov 2026 11:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46201F000CF;
 Tue, 24 Nov 2026 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795519739;
 bh=tLnWd5jhubOeFNRkHGC8qqDZ8N8UGLt+6HY9hXZev7c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=AQlFSDZYR64armauKEVSNe6Wu9SaNzuS+A7VVAn/pvdYyNRgjnGn0la5OcsEBZcb5
 Xa7er29p3u4mj4KAs3APV3EPmQbgbqbV+mMSfCm312q79v3rJf/ag7zM8k86aLT7yQ
 cdfCSf1KMEEZsfPcBBddzIhmoVcVt3lCYQHi8hfc8bsKsu3clKtVzr9DGqiiVDLQVm
 MbK9MLQIrldXLOrKDIFHiOkkDGqdL88rWzQYyygVcf6lTtG2QjtH6PiNZiPIKzE5Ll
 v0pw5FBByM8yj6Z1dEe2ZTE9dI096b9ZpZPFnzkdXyMaLyBJQJF6HXzXQqHRE2oupI
 Dde9sjK5u1R3A==
Subject: Re: [PATCH net v7 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
From: netdev-bot+sashiko@kernel.org
To: tkusters@aweta.nl
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 sven.auhagen@voleatech.de, richardcochran@gmail.com, kurt@linutronix.de,
 sriram.yagnaraman@ericsson.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 11:28:57 +0000
Message-ID: <179551973728.3135.7219099542453397459@kernel.org>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-3-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-3-63b03045978e@aweta.nl>
X-sashiko-severity: Medium
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This is a hardware-dependent DMA bound.

--

igb: do not split AF_XDP zero-copy frames over several Rx buffers

The patch programs SRRCTL.BSIZEPKT for AF_XDP zero-copy rings with the
same 2 KiB or 3 KiB buffer size as the other rings. Before, it used the
XSK frame size rounded down to 1 KiB. To keep DMA inside the XSK frame,
it relies on the receive length limit and adds checks on pool bind, MTU
change, ring setup and VF enable, so that the frame plus the timestamp
header fits.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a59ee6575c560..d3165ae97b00d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c

[ ... ]

> @@ -4846,9 +4882,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	u32 srrctl = 0;
>  	u32 buf_size;
>  
> -	if (ring->xsk_pool)
> -		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> -	else if (ring_uses_large_buffer(ring))
> +	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
> +	 * frame size would round it down and split frames over several
> +	 * buffers. XSK rings use the same buffer size as the other rings.
> +	 * While XDP is attached, the receive length limit keeps frames
> +	 * within the XSK frame, see igb_xsk_frame_fits().
> +	 */
> +	if (ring_uses_large_buffer(ring))
>  		buf_size = IGB_RXBUFFER_3072;
>  	else
>  		buf_size = IGB_RXBUFFER_2048;

[Severity: Medium]
After this change, BSIZEPKT can be larger than the XSK frame. With 2 KiB
aligned chunks and the default headroom, the XSK frame is 1792 bytes, but
BSIZEPKT is now 2048 (or 3072 with the 3K buffer flag). Before, BSIZEPKT
was never larger than the XSK frame, so the MAC could not DMA past it,
whatever the packet length.

The commit message says the receive length limit is now the only thing
that keeps the MAC inside the frame. Does that limit cover every ingress
path once VFs are enabled?

With VFs, igb_set_rlpml() leaves the global RLPML at MAX_JUMBO_FRAME_SIZE
and limits the PF only through its pool's VMOLR:

	if (igb_xdp_is_enabled(adapter)) {
		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
		if (!vfn)
			rlpml = min(rlpml, adapter->max_frame_size);
	}
	wr32(E1000_RLPML, rlpml);

igb_vmm_control() turns on loopback and replication whenever VFs exist:

	if (adapter->vfs_allocated_count) {
		igb_vmdq_set_loopback_pf(hw, true);
		igb_vmdq_set_replication_pf(hw, true);

A VF can also raise its own pool limit to 9728 with the
E1000_VF_SET_LPE mailbox message, which igb_set_vf_rlpml() handles.

The patch explicitly allows VFs to be enabled while a zero-copy socket
is bound to PF queue 0. So this setup can be reached: XDP and a 2 KiB
chunk XSK pool on PF queue 0, plus VFs assigned to guests.

Suppose the 82576/i350 internal switch does not apply the destination
pool's VMOLR.RLPML to VF-to-PF loopback frames. Could a VF then send a
jumbo frame to the PF MAC address and make the MAC write up to BSIZEPKT
bytes from the DMA start of the XSK frame?

For the second 2 KiB chunk of a 4 KiB page, the frame ends exactly at
the page boundary. That would mean writing 256 bytes past the page, or
1280 bytes with 3K buffers. Aligned-mode UMEM pages are DMA-mapped one
at a time, so those bytes would go into unrelated memory, or cause a
fault when an IOMMU is present.

The tests in the commit message only used wire frames from a peer. Was
the loopback path tested? One example would be a VF with MTU 9000
sending to the PF while a 2 KiB chunk zero-copy socket is bound to PF
queue 0.

igb_xsk_frame_fits() compares max_frame + IGB_TS_HDR_LEN with the XSK
frame size. It never compares the XSK frame size with the programmed
BSIZEPKT, so it would not catch an ingress path that skips the per-pool
length check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-igb-rx-ts-fix-v7-0-63b03045978e%40aweta.nl
