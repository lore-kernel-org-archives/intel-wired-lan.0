Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DC606A320
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CsNyORiT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX90sMAQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55408605FD;
	Sun,  8 Nov 2026 07:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZkrvES3csk6; Sun,  8 Nov 2026 07:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69F0D6061D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794122311;
	b=RfqpBxDJ1NaDmi7Ba45/yrLjJuXC3oq7fntBlS8jx/JzbjFgrxI8nLbZXb6S0Fe4lZ7D
	 +4kKPXLZyvIPhiagQA8iG1mxy/PQHDL5/uAYEaHAS+Bn2WGAAstwgZesa+u1d4/kAX3nX
	 22+9edez1+HPfgfRilSoVfHvp2lbGTuF5+rwre651a7tVMzPEntTZNbNocp2NQTJRASyE
	 thpXcMa70cWRusz106zUFmJ5VuzOH/5go5zMpvfrnx+dYIn7YP/OvJygX2TrQWEJU7b29
	 pHmfmgK5i9eP7SHm6E0C+uG2h4iEs0Sk2PPN/bhJ6oM/yn9mJxkc7blDy0qIqU+EyQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V2g5gJoLJ/ti0qBR40G1KW7UssJ842zGOylJ9bRHcPU=;
	b=gY5i15f4inyye6lio+6cW/qzHaDfKKl1+149QIV6yUcKVq7LBuMyO6ctC82gvfbxWS/P
	 udTNWl/kiq0Idz9OWOR/y1wYvos3danrlZDevdEosNxIduNlexhoS1Xp8lF//Gw9cWyxT
	 d/cGOCqpMqjcrlKEsgZRpqQkkRCewJEOLC5gyII4dT7j0IMHL0kRalJ0ak2TIPx4ofjp3
	 e2nmUwkdXZ/l1jouVhimNTaTemizI73m44W8iv3ZtI1XVsKZYhws5Afv1NqVZxZ6+zXfV
	 V4Vg9wPX5+SJJDfyX1hqupdNDnCa0f344TKspfC5cSSwGASYmPDqk6O0XqcTWPWPUNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794122311;
	bh=V2g5gJoLJ/ti0qBR40G1KW7UssJ842zGOylJ9bRHcPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CsNyORiTtAeXj0W+fhJRKtEWvp6igVD9kV0lax5tv+phfJ6DsyeEjhJ8ajOzveyy7
	 5OzxfRX1fHn/HNjSr9YL5eMbc5hQbfr+baSL+iCZAhBM2H5noIm1epsa5kilgcz+Nt
	 BSTOS+jYHx5cldoJ48r6eO0dIJK7IYfVQh6NITZYMxq9fK8/OFmH6dRbaUZ2YIi3Em
	 WUczUcsXjOuyBlyeJi1AFx8lLQoxl3BYCEVvIpiLNrz+Hoo/GHgAktwkYJ/cooM9ol
	 iIVZnxb5jJdwE6x/7tEPfmiwnbJBwN05PVgjJjQGmmWP9Z0alJvl2rJAeIm9I1ak+j
	 waeHNu2Y9jHeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69F0D6061D;
	Sun,  8 Nov 2026 07:18:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 462B03AD
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 379F1400AC
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eb5HZ4j4qR5g for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 07:18:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D793D40093
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IX90sMAQ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D793D40093
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 07:18:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7457E612B6;
 Sun,  8 Nov 2026 07:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D01F0089F;
 Sun,  8 Nov 2026 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794122306;
 bh=V2g5gJoLJ/ti0qBR40G1KW7UssJ842zGOylJ9bRHcPU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=IX90sMAQt0TiYvZM0q/AZaA7gD5JmvYqQU3Uu+aOXjRRHXFuDc2XuYQ6GdiXeVwik
 Pizw2Fojya5jzei1CN6CAP1k3cUiyfb/+8UMsdZSZhYuEWuyGceS1SHdJbczmimyBX
 eka29b3zeHBDae2rxygpv3ZzVsEf9Ic8+ER/se7adkSL4ORsMlSCe7b6zS+pIn17oh
 D1Sp0SuVihs6wwd+O+ByOWNAa6olqbiP21HQ4L7/mWGUfRkKb2aDVyF6hNVcAWwMOB
 NzwpBafMzW3R00n+X1hN/kFTwv5B+h+3TxXtImCkam5OhLusA24spBGcmIZLleGo1Q
 fNfI1c1OJo6Cw==
Subject: Re: [PATCH net v5 1/4] igb: do not let XDP frames span more than one
 Rx buffer
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
Date: Sun, 08 Nov 2026 07:18:24 +0000
Message-ID: <179412230443.994134.1015628730237451247@kernel.org>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-1-bf4b4367129a@aweta.nl>
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

- [High] On i354 with VFs allocated, igb_set_rlpml()
  (drivers/net/ethernet/intel/igb/igb_main.c) programs no receive-length…

--

igb: do not let XDP frames span more than one Rx buffer

While XDP is attached, this patch limits the receive length to the
configured maximum frame size. It uses RLPML when no VFs are allocated
and the PF pool's VMOLR otherwise. It also tightens the XDP frame size
check, refuses XDP with rx-all, blocks legacy-rx changes while XDP is
attached, and moves the limit programming into a new igb_set_rlpml()
called from igb_configure().

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..8abdd4e58550d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1964,6 +1964,54 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)

[ ... ]

> +static void igb_set_rlpml(struct igb_adapter *adapter)
> +{
> +	u32 rlpml = MAX_JUMBO_FRAME_SIZE, pool_rlpml = MAX_JUMBO_FRAME_SIZE;
> +	unsigned int vfn = adapter->vfs_allocated_count;
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 vmolr;
> +

[ ... ]

> +	/* XDP does not support frames that span more than one Rx buffer.
> +	 * With VFs the global limit stays large and the PF pool is limited
> +	 * through VMOLR.
> +	 */
> +	if (igb_xdp_is_enabled(adapter)) {
> +		pool_rlpml = min(pool_rlpml, adapter->max_frame_size);
> +		if (!vfn)
> +			rlpml = min(rlpml, adapter->max_frame_size);
> +	}
> +	wr32(E1000_RLPML, rlpml);
> +
> +	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode() */
> +	if (hw->mac.type < e1000_82576 || hw->mac.type > e1000_i350)
> +		return;

[Severity: High]
What happens on i354 when VFs are allocated and an XDP program is attached?

With vfn != 0, RLPML is written as MAX_JUMBO_FRAME_SIZE. In enum
e1000_mac_type, e1000_i354 comes right after e1000_i350:

	e1000_i350,
	e1000_i354,
	e1000_i210,

So on i354 this early return is taken and pool_rlpml is never written
to VMOLR(vfn). No receive length limit is programmed in that setup, and
the comment above ("the PF pool is limited through VMOLR") does not hold.

igb_probe_vfs() only rules out SR-IOV on i210, i211 and 82580, so VFs
can be allocated on i354:

	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
	    (hw->mac.type == e1000_82580))
		return;

igb_xdp_setup() and igb_xdp_frame_fits() do not refuse XDP in this
setup either.

Could frames up to 9728 bytes still reach the PF rings over several
descriptors in that case? igb_clean_rx_irq() would then run the XDP
program on a continuation buffer as if it were a new frame. That is the
failure the commit message says this patch fixes.

The skip does not look like a hardware limit. igb_set_vf_rlpml() writes
the RLPML field of VMOLR(n) with no MAC type check:

	vmolr = rd32(E1000_VMOLR(vfn));
	vmolr &= ~E1000_VMOLR_RLPML_MASK;
	vmolr |= size | E1000_VMOLR_LPE;

The > e1000_i350 check seems to come from the unrelated early return in
igb_set_rx_mode().

Should the PF pool VMOLR limit also be written on i354? Or should XDP be
refused on i354 while VFs are allocated? The commit message only says:

  As before, the PF pool's VMOLR is not written on i354.

It does not mention that this setup stays unprotected.

This also matters for a later patch in the series, "igb: do not split
AF_XDP zero-copy frames over several Rx buffers". That patch programs
2 KiB and 3 KiB SRRCTL buffers for XSK rings whose XSK frame can be as
small as 1792 bytes. It relies on this receive length limit, as its
commit message says: "Without it, the hardware can write past the XSK
frame".

On i354 with VFs, could the NIC then DMA past the end of the XSK frame?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-igb-rx-ts-fix-v5-0-bf4b4367129a%40aweta.nl
