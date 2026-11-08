Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C9606A338
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mloa3CZF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHzBZAJa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 198AD40598;
	Sun,  8 Nov 2026 07:18:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJpaeh-q5Fkf; Sun,  8 Nov 2026 07:18:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A42D40602
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794122314;
	b=MxQ3dxQCT/b8eSb6y93MmIt+6i7OIuA7IwJqh/OcMMHhImiPKQGHdsTs6gTuNgSkU+M5
	 98rbTq+iakV09XpIb7AeqICCBCBxgg1l9qoHKmuCTjb+bxLOYUknu8YSYPPMCYPAHiDuy
	 Bepi7hNWRruwvYMnoq/IsxGxEBm8W4uVbJa//b43a53oS2F50x6aKG9k2LjLz17HiRsMO
	 MJbc/wphNr4d8RhVqJ5IwsUsADkEMtvIaaWL1JX14iaPxTtqGbdQe6xC1iI65a6u+2s8O
	 9SMaib7V6p8h+0V/9G2zVeI4f4uyowHQgLRq6/WaHMkPtkLrKYCn9vVNIkmQ9jodr0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LX432zGEh+m8MJzD+N0chjubKRkHI47xVg0SEDNcbSc=;
	b=TOnJnwp9uLcsUBXJwBB+gTr5JhxYVgDrBRtkkn55jDqcYi5UwlTeMpfn6Cz5BARreF1d
	 V+PUSldF/DRcBoy9NhQmxdo5fgZtGHs3FEJrMLOK+kBabJBOZj2WmEq804aGLm5wZYecV
	 9l2j5ERmsuIKLOBGVxe6yWJVU5JXF4eynsJ3yNLsQyqjoeont5IGQiHB8wQeDmEn0OJIe
	 mioOc6iEFtku4LZo4P3agTfKGyfLpOQ1gqMl5lNdNKtOIn5/6rCHkhDiTSAihDj65vFfr
	 8X1EScsS/wRMPfM54RhqnsJ9SRruOLkJ4eOoUtjtZVbT5PahfCEpw6JaHn0KtDG6vvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHzBZAJa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794122314;
	bh=LX432zGEh+m8MJzD+N0chjubKRkHI47xVg0SEDNcbSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mloa3CZFcv++NuQgjyxfLQ+2J9f2fQwugE1y2g4SRQ3jhZ+rWTIVYAVgWzsBroCcs
	 Xh1QHhE+S/1K+SB2Fpf/N8rJvRrJZc++FA09tOARmiqrAlwqKe+D7wFTWVW7Q4jKIg
	 XLOqnN61Sd4nEo4Cb7rBwL1PJUiKWPJ2BQNVY+8TwmofCvkPCkm62IiRqTZ/GjwuZh
	 VI/n+FWHdGGUVt+2SSZvdxaEEJ9Q0eHMZA2PLE2iLHDO3XQtVRXDPbzqZZ9GEGeCqp
	 034/EAAQTLFibxJuYR8wQ81XMCxMQ2h/hIGnHW3bsBGi5xvfxQ2NFaOKVcTR1/vGZS
	 l4f8A5WBAFr9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A42D40602;
	Sun,  8 Nov 2026 07:18:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 636033AD
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54ECC40602
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4kXRGSUcdpa for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 07:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D98C405F4
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OHzBZAJa
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D98C405F4
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 407F740707;
 Sun,  8 Nov 2026 07:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98871F0089F;
 Sun,  8 Nov 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794122310;
 bh=LX432zGEh+m8MJzD+N0chjubKRkHI47xVg0SEDNcbSc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OHzBZAJa+luHdoFy3xzfBgZN2yqZjgaPoMX4qfS42DRzbE6C2rkTGRLUorzbUsLWi
 O3UdQV/qWReI8tM+x0apTxu70IOoELJH5VGk6t0V9sO3sSN05TFQyjR3KRIs5gkkaL
 I305NvQmn2sdo1VJ8hm143mNnlrChCbo6p1jeIORtxgIunGnOQe9IJTPfrNPU08G/H
 WttLuJ6n53WQKZ+ueCP870Shv0LfkNG7CjKu6igpWAbv3h5WhuUkRg3fsQWwTr3iiY
 T5u1EAUERPllCBZ1Jn6nPEbzV9lJJ9wzMjp/3pm45WoZlmhMrCJluULluAubn8tjes
 uabLNy14FLiXA==
Subject: Re: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
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
Date: Sun, 08 Nov 2026 07:18:28 +0000
Message-ID: <179412230839.994134.10647400317567695303@kernel.org>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl>
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On i354 with VFs allocated, nothing in the driver applies the
  receive length limit that the zero-copy buffer layout now relies on.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  discard path depends on it.

--

igb: drop AF_XDP zero-copy frames that span several Rx buffers

This patch makes igb_clean_rx_irq_zc() drop AF_XDP zero-copy frames that
span more than one Rx descriptor. It frees every non-EOP buffer and the EOP
buffer that ends such a frame. A new ring flag,
IGB_RING_FLAG_RX_XSK_DISCARD, keeps the discard state so that a split
frame can be dropped across NAPI polls.

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index fb04df82272ac..7b098069fff29 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c

[ ... ]

> @@ -390,6 +392,27 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>  		dma_rmb();
>  
>  		xdp = rx_ring->rx_buffer_info_zc[ntc];
> +
> +		/* A frame should never span several buffers here, see
> +		 * igb_xsk_frame_fits(). If one does, drop all its buffers.
> +		 */
> +		if (unlikely(!igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP) ||
> +			     test_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
> +				      &rx_ring->flags))) {

[Severity: Medium]
Is the receive length limit that this comment relies on applied on i354
when VFs are allocated?

After the series, igb_setup_srrctl() gives XSK rings a 2048 or 3072 byte
hardware buffer. It relies on the length limit to keep frames inside the
XSK frame, which is 1792 bytes with a 2 KiB chunk pool.

When vfn != 0, igb_set_rlpml() leaves the global RLPML large:

	if (igb_xdp_is_enabled(adapter)) {
		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
		if (!vfn)
			rlpml = min(rlpml, adapter->max_frame_size);
	}
	wr32(E1000_RLPML, rlpml);

On i354 it then returns before it writes the PF pool's VMOLR, because
e1000_i354 comes after e1000_i350:

	if (hw->mac.type < e1000_82576 || hw->mac.type > e1000_i350)
		return;

igb_set_rx_mode() also skips VMOLR on i354, and igb_probe_vfs() does not
exclude i354. An earlier commit in this series (bfd45cda) notes that the
PF pool's VMOLR is still not written on i354. The ZC path does not seem to
account for that.

igb_xsk_pool() and igb_xsk_pool_enable() only check that XDP is enabled
and that igb_xsk_frame_fits() passes:

	return max_frame + IGB_TS_HDR_LEN <= xsk_pool_get_rx_frame_size(pool);

This check assumes the MAC enforces max_frame_size.

Suppose the i354 PF pool accepts long frames by default. Can a peer frame
of 1793 to 2048 bytes then land in a single descriptor with EOP set, pass
this check, and reach xsk_buff_set_size(xdp, size) with a size larger than
the XSK frame? By then the NIC would already have written into the next
UMEM chunk or past the end of the UMEM page.

Longer frames are dropped here, but only after each of their buffers has
been filled up to the hardware buffer size. The commit message of "igb: do
not split AF_XDP zero-copy frames over several Rx buffers" says: "Without
it, the hardware can write past the XSK frame."

The i354 reset default of the PF pool's VMOLR.LPE/RLPML could not be
confirmed, since the driver never writes that register on this MAC.

Before the series, ZC rings used the XSK frame size rounded down to 1 KiB,
so the hardware could not write past the frame.

> +			if (igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP))
> +				clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
> +					  &rx_ring->flags);
> +			else
> +				set_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
> +					&rx_ring->flags);
> +
> +			xsk_buff_free(xdp);
> +			ntc++;
> +			if (ntc == rx_ring->count)
> +				ntc = 0;
> +			continue;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but the new discard path
depends on a length == 0 sentinel that igb_alloc_rx_buffers_zc() does not
always set.

A refill can wrap around the end of the ring and get fewer buffers from
xsk_buff_alloc_batch() than it asked for (but at least one). In that case
the early exit skips clearing the length of the new next_to_use
descriptor:

	if (ntu + count >= rx_ring->count) {
		nb_buffs_extra = igb_fill_rx_descs(xsk_pool, xdp, rx_desc,
						   rx_ring->count - ntu);
		if (nb_buffs_extra != rx_ring->count - ntu) {
			ntu += nb_buffs_extra;
			goto exit;
		}
	...
	/* clear the length for the next_to_use descriptor */
	rx_desc = IGB_RX_DESC(rx_ring, ntu);
	rx_desc->wb.upper.length = 0;

exit:

That descriptor is in the region software has already processed.
igb_clean_rx_irq_zc() never clears the length after use, so after the
first lap the descriptor still holds an old write-back with a non-zero
length.

Once the hardware has completed every posted descriptor,
igb_clean_rx_irq_zc() reaches ntc == next_to_use and only checks:

	size = le16_to_cpu(rx_desc->wb.upper.length);
	if (!size)
		break;

rx_buffer_info_zc[ntc] is never set to NULL after use (ixgbe does
bi->xdp = NULL). It can still point to an xdp_buff that was already freed,
given to the socket, or reposted on another descriptor.

Can this deliver the same UMEM chunk to user space twice, or return it to
the pool while hardware or user space still owns it? In unaligned mode,
xp_release() would push the same xskb onto free_heads[] a second time.

Every descriptor in the unused region is stale, so the loop can run until
the budget is used up. That leaves next_to_clean past next_to_use, which
breaks igb_desc_unused() and later refills.

With this patch, a stale non-EOP descriptor also takes the new branch.
xsk_buff_free() is called on the stale pointer and
IGB_RING_FLAG_RX_XSK_DISCARD is set, so the next valid frame is dropped.

The branch also continues without counting against the budget. That
leaves the missing length sentinel as the only thing that ends the loop.

igc_alloc_rx_buffers_zc() clears the next descriptor's length after every
fill, including partial ones. Would doing the same here close this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-igb-rx-ts-fix-v5-0-bf4b4367129a%40aweta.nl
