Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42B606A320
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LyiY16bP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bH1l6BqP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41926405F5;
	Sun,  8 Nov 2026 07:18:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wn4pdFREGJW4; Sun,  8 Nov 2026 07:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38CC640598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794122312;
	b=bsMRTxdg6WRiiJXCtLIajQ7Tf5PaV3VBmFkuBcdcWJrLCgZJrbnk8oa8hQGtY6MluVHT
	 HTVwZD6rquhxHPipnilFYpwNl1YAsWjrqYXQfnxJMHypSQkivY96Q7VzPaZzSW1QN06yf
	 K5tkkO0mb3RRoWShOfZAbWegqi9ZbAu9/yYa1Dk2yCfgu36FsxZ/ayvgnJtEsy70ayBcq
	 OnEWkj6J9I2wBf8voDoRUOBn0NEh0/7IpeNfCLNxPUmetob6PtG7OZvvyX4TyKohYmv1D
	 YBJjQOt7hvv0CWPdHgsShwtIfWY1RRyC/Xr1emV5PdtEExzSLgfs2Ckexqkrfk3fIAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rp00DiKSxgo0zNtK24eQEtuDxTngsNsV2eHoN50n1pY=;
	b=lPhFEA+uqby3NFTT3GAROhUlH4e5oOXEPQ+KcMHLRxU9T1Ppf0n5N23Lmvdo7sbmTPZa
	 c7O/agF4m3Nhtj8fBFWjHs0FR4eapUH9Xn5qRq1RtgjaYCiNWw+cG3ockm5GNVwYfwqP5
	 Ga5Mob6gnYvR47TYKUtEw4wV+hACyyPPDmYy2MX2mMOSFRbhRp2Lp19dp4+gDVjT3J2aC
	 LiH28w4maFOdrnfX+W5Rj4R5SUOAljjgAz7yVzQzvNGwV09d7uuUZCuPf3kIj+CNMidx9
	 Bn++7fwh/AY7pEDIDIhTQdEY/Zdp3D9t+Rha8vHWEWPnDh8yYh4K2sm7fK0SdlVBvuw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794122312;
	bh=rp00DiKSxgo0zNtK24eQEtuDxTngsNsV2eHoN50n1pY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LyiY16bPizrFRRbiHsn6TRXDTySe9NFKxLFGGnGrEj8dgRYpeM+hzyxMA9b8KUQB9
	 ldVzQvCL1xG+neO/beYcvLbXYazT7xeA8Qg3FGMeSo9Upc6t38QtEvIJ1WQxruq2YN
	 KGcJ4fWPkZuARkeuPM+t/DU69UHZDt+k2iAmwZ602VB0rbErgcsr586mIxbkodIcBX
	 Vki6awgwH1WHR03aP8iOGZvrpNMs3rhVZfLA/JQQjBHy5SnGGV12CfYzLjaiwvY5oW
	 Lu0xBzhJzivMy1RNgZyTPPS13klDkkQ0U63IwrMTuJ3LrklJqEEbxeGSXhuvO6mjh2
	 Ys8oasZuM368w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38CC640598;
	Sun,  8 Nov 2026 07:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE72D31F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A41B480DD6
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJcIIuXO7UaQ for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 07:18:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92C6480DD2
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bH1l6BqP
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92C6480DD2
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 547F440539;
 Sun,  8 Nov 2026 07:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D111F008A1;
 Sun,  8 Nov 2026 07:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794122308;
 bh=rp00DiKSxgo0zNtK24eQEtuDxTngsNsV2eHoN50n1pY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=bH1l6BqPf0NPLte0hdP1howIC+6VwVqzOWf8WeOFz/Rw0OhK07gIlCHCZH5AnicOF
 kB/NDEfmBHsEl9Mk/d6+2UHpqTziFmT/uhz5Xh/tZjjbSa3AtAe2obdNf8O7gg4wgd
 M4uCrouUoNZ0d5ATNHjihFfg6chwpWVWLxvfzbIiaXYi/D+EtGIqNwxkpMs9q2s6CE
 P3a2rPh21qW/Wr/9TR8loAAAyYn1PNfoLUOMrO41GWqDEpTOrWwkDMHJgDfeDHeyC0
 Ytp9rzwE/av3YJEZt7kxUBmNxQi3+vA9zQe2Ex4ogfGjXbe4LEonZwHqRRnOOEWh++
 CtTaNnMwl1t7w==
Subject: Re: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames over
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
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org,
 piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Sun, 08 Nov 2026 07:18:26 +0000
Message-ID: <179412230633.994134.8603408637757773209@kernel.org>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes igb_setup_srrctl()
  (drivers/net/ethernet/intel/igb/igb_main.c, around line 4842) program…
- [Low] Two new comments in drivers/net/ethernet/intel/igb/igb_xsk.c
  contradict each other.

--

igb: do not split AF_XDP zero-copy frames over several Rx buffers

This patch programs SRRCTL.BSIZEPKT for AF_XDP zero-copy rings with the
same 2 KiB or 3 KiB buffer size as the other rings. Before, it used the
XSK frame size, rounded down to 1 KiB granularity. It also refuses XSK
pools and MTU changes when the frame plus the timestamp header would not
fit the XSK frame.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index cf9911137bd31..b286adedad5df 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4833,9 +4833,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
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
Is a receive length limit always in force here while XDP is attached?
With 2 KiB chunks and the default headroom, the XSK frame is 1792 bytes.
BSIZEPKT is now 2048 or 3072.

With VFs allocated, igb_set_rlpml() leaves the global RLPML at
MAX_JUMBO_FRAME_SIZE. Only the PF pool's VMOLR carries the limit:

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_rlpml() {
    ...
	if (igb_xdp_is_enabled(adapter)) {
		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
		if (!vfn)
			rlpml = min(rlpml, adapter->max_frame_size);
	}
	wr32(E1000_RLPML, rlpml);

	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode() */
	if (hw->mac.type < e1000_82576 || hw->mac.type > e1000_i350)
		return;
    ...
}

e1000_i354 is greater than e1000_i350, so the VMOLR write is skipped
there. igb_probe_vfs() only rules out VFs on i210, i211 and 82580, and
igb_enable_sriov() has no MAC type check.

Take an i354 PF with VFs and XSK zero-copy active. Could a peer that sends
a frame longer than the XSK frame make the NIC write up to 2048 or 3072
bytes, plus the timestamp header, starting at chunk + headroom? That
would run into the next UMEM chunk, or past the end of the last one. It
would be up to 256 bytes with 2 KiB buffers. With 3 KiB buffers it would
be about 1.3 KiB, for example MTU 1600 on 2 KiB chunks, which
igb_xsk_frame_fits() accepts.

The igb_xsk_frame_fits() checks in igb_xsk_pool(), igb_xsk_pool_enable()
and igb_change_mtu() only compare adapter->max_frame_size against the XSK
frame size. They only help if the MAC actually drops frames above
max_frame_size.

igb_clean_rx_irq_zc() passes the descriptor length to xsk_buff_set_size()
without checking it against the XSK frame size. The later patch in the
series, "igb: drop AF_XDP zero-copy frames that span several Rx buffers",
only drops frames without EOP. An over-long frame that fits in one 2 or
3 KiB hardware buffer has EOP set and would still be delivered.

Before this patch, BSIZEPKT was rounded down to at most the XSK frame
size. Frames were split, but the NIC could not write outside the frame.

Two hardware details could not be verified: whether i354 silicon exposes
SR-IOV, and whether the PF pool VMOLR, which is never programmed on i354,
limits the length anyway.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..fb04df82272ac 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -91,7 +91,20 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  	if (!igb_xdp_is_enabled(adapter))
>  		return NULL;
>  
> -	return (pool && pool->dev) ? pool : NULL;
> +	if (!pool || !pool->dev)
> +		return NULL;
> +
> +	/* the MTU check in igb_change_mtu() does not see a pool on a queue
> +	 * that was hidden at the time, for example by SR-IOV
> +	 */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {

[ ... ]

> @@ -110,6 +123,10 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
>  	    qid >= netdev->real_num_tx_queues)
>  		return -EINVAL;
>  
> +	/* igb_change_mtu() keeps this true while the pool is bound */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size))
> +		return -EOPNOTSUPP;

[Severity: Low]
This isn't a bug, but does this comment contradict the one added to
igb_xsk_pool() above? That one says igb_change_mtu() does not see a pool
on a queue that was hidden at the time.

igb_change_mtu() finds pools through xsk_get_pool_from_qid(). That
returns NULL for a queue_id at or above both real_num_rx_queues and
real_num_tx_queues. So a pool bound on a hidden queue is not checked, and
igb_xsk_pool() can later drop it from zero-copy. The commit message
describes the same case.

Could this comment be reworded so it does not claim that igb_change_mtu()
always keeps this true while the pool is bound?

>  	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
>  	if (err)
>  		return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-igb-rx-ts-fix-v5-0-bf4b4367129a%40aweta.nl
