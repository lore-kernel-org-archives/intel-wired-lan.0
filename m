Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CECACA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5EC4809C4;
	Tue,  6 Oct 2026 10:56:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQz_5qCgIrhA; Tue,  6 Oct 2026 10:56:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D844D80AD5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791284204;
	b=gOPcky6afj6S/97GNRTAIdxuMnwvxLNxC3UZLe4XvzHNMPOgJPeO/70fFYe/vXI7T1WA
	 CXJr3ODEIxxmVYbj8lHu/qO1H7pKF3uFBllFPjLdHTWZ2B2zInjiE2H7q3p+By6muE2Mx
	 8ZdqeRW4JbSebOpvNpLpcZ12MbbpJoPECVTyveMb+TU0VfCPdrJeemXXkMxQmRWYOMTSm
	 LfYg/fQe6jrp7gtHYnQ1jsUa3ZSE4OiGD8h/lYpImU815yiVYoAMo2RQ1V3CL1T8RBlRf
	 wWuV6cQ+OnTF9wbt80P2ibqg9Kz1iyhJWrqcNjct2O5OndfIuFdjh1bnmn0JI6P2S2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791284204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=tBwwd5i2aJ6ojm9ksvck7iUMdFHiueExb0ZDmM1gV6k=;
	b=d1427umPchhDQ73uIqI7Luukjc/e9JAdGrvuqrR3HeObpX2kXfSDX874hjJ0EyJqazWC
	 /IyTRqLJWVPeVh1SUbhFB/sMdgUHc6B3FjPkz/0K2oMHkvzEHwC9be/kZa6wY8bD7dumA
	 iKY5G1vFR2eCH0lydLEQ6hAphDoVE+PL55+07MSkHvBjgkJXhX61w5F45ehzzt2e2/Ndt
	 FjQD/cktb9Z4sL7KI+OxqtnJJkU7Sra/kTEvJg3ajX8qeY5fbvHCS8nXH178FMuPVFRTO
	 nb2kL87QXrpdyNE68Isj2KgXEsLZNrZ9R11b6u1XBJwT94i0o6dF2rUlWxUB24RtI1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791284204;
	bh=tBwwd5i2aJ6ojm9ksvck7iUMdFHiueExb0ZDmM1gV6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=igJgZZQDy21rhd3d8zoPu5A1viL9Pec6mULleHXu4wuvVL23/nfADCGo5GJFP1KZs
	 lhsPk+AaaDhCCysHFwijdw1bQcmX6H7vbKiX6Uqvaa02zIQWQuVvyhRkO5fb0JVjDJ
	 4K1cep6GR+eZgOH434Frrv4r9iEEd9QFITqBV1INLg61p0XTGm2VoUhu678xOMky+p
	 CYTQwXz/UGnNaI874qcW9r9CIH1VUD2xPILCbjpCE3beDrCGkbokTbXUXnrAzbMfdr
	 8xoTZtBpmsKl0+aKa04XUl/OeEQVWUYYj13xtZ8TNepCP7PIwQzqwS/4enXjbYDcPP
	 8Tvw2c8c0hZ4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D844D80AD5;
	Tue,  6 Oct 2026 10:56:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 333D222B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 10:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24D0460781
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 10:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvrB3XEGImyo for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 10:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3C5A460716
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791283527;
 b=UHcpDWSfF6J+/mTP7NvYTuZkLkt8S4BHEpm91gZw/h6RwhrRLqI6IteMZ3kt6BGNke+a
 qkUf3E7+Vx4Kj/EZ3JOvZhGt/spDUmwkzbuAwAHoSdhj2dgPUc7Llj8z/grnQipXsYdlV
 SYcAEaT94C5TzJh4kYZURvkBpeoNo5OM7tFTUmv8c17bMkfuKtQX022QkVQoS8o0n5K+c
 gaQLzDIeJR5lM1tK4TlGDJJiqe/CHYnfgT8l9plh/DL0bVBE4eXwssotLHASfaDyVH0hE
 TqzWi7iaFh/lwmU7dlDL6CmyTY8+VUcFE6D7UvHbq/Y5t6ERcv7qzDNVEK79xHlbXag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791283527;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=tBwwd5i2aJ6ojm9ksvck7iUMdFHiueExb0ZDmM1gV6k=;
 b=NwAPtEUBPkn+AYHsmy8aa3z9TxhFtF+9qLJzSEQPGKqx1pVU6dcYL3LA/ZYFEz6npkB+
 J8HI4Ye9nIazj0p0ovEXommBb68uAHJtA/DDCaPasTreIsjCjjOiHillHrsCc0d1ADqiL
 ztJKdFzYcYlzxJ6oIjdvIbeDfzBKuU3xY/AMzCb/rKkfWVYJqg/NhWa36dP1eZzatPiVl
 FA5WW1bjC0b0ERLILyG6gUNjBKoJYInVK9xr2ounC5YcQf0eLe1kOXgzPIZ3WdVv6Qkui
 but1pfLe2NnIhM1MQvf8X/tPcd7hmGf/j1wU0X2wEkYjX77rQBLsjzQCIXwGl5kBOlg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O7SDMnYO; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O7SDMnYO
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C5A460716
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 10:45:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16B61411E7;
 Tue,  6 Oct 2026 10:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A791F00893;
 Tue,  6 Oct 2026 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791283526;
 bh=tBwwd5i2aJ6ojm9ksvck7iUMdFHiueExb0ZDmM1gV6k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O7SDMnYOuqSrvrPXspHchkcxTmuUNGF+Jo37PdPvmNwqMNQcGmaVNrw/xLvypJLnL
 b6XLMKC9WVLZW1uSn0n9VGHlgf9DVoNlTEFqPi60m5Pty9pdNlCJwgpLWwSDa9ps9k
 xZ+jNssfFPwn71EWpr/reRQwM659aaAN7oefXJfxr7xYM3sAZUbbEONmknl3nS5ewp
 evd04ZzFnmBiA6RUoAUJZcwY7vgByGZxEh/iv2XNgJ4hqPMZs0Wh27POE7RDeCflJ5
 bnc4Ge7etDvpt4Sjcplw6PZKrXynBIDy7YqksGNq8BZKLLFDPQF1CcHo9ASUS6dKAx
 ng0+WhlF/fDTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2] ice: Skip PTP timestamp processing during
 release
To: "Sergey Temerkhanov" <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261006095435.419128-1-sergey.temerkhanov@intel.com>
References: <20261006095435.419128-1-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 10:45:25 +0000
Message-Id: <20261006104525.C3A791F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: ice: SKB memory leak in PTP Tx tracker when state is not ready
--

commit 20fdb60a0f81d0a78832f24386472d8613b50aea
Author: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

ice: Skip PTP timestamp processing during release

This commit adds early returns to the PTP timestamp processing paths
when the PTP state is not ICE_PTP_READY. It is intended to prevent running
callbacks on unready hardware and hitting uninitialized structures.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index b2de76065f46d..c0c12e28e08fa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2815,6 +2815,9 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct=
 sk_buff *skb)
> =20
>  void ice_ptp_process_ts(struct ice_pf *pf)
>  {
> +	if (pf->ptp.state !=3D ICE_PTP_READY)
> +		return;
> +

[Severity: High]
Does this early return bypass the 2-second SKB timeout cleanup logic in
ice_ptp_process_tx_tstamp()?

If PTP initialization or rebuild fails, setting pf->ptp.state to
ICE_PTP_ERROR (or any non-READY state), but the normal NIC rebuild
continues and succeeds (link_up becomes true, tx->init remains true),
userspace can still send packets with SO_TIMESTAMPING.

In this scenario, ice_ptp_request_ts() accepts the packets and queues the S=
KB
in tx->tstamps[idx].skb because ice_ptp_is_tx_tracker_up() ignores
pf->ptp.state.

Since ice_ptp_process_ts() now returns immediately, the timeout cleanup log=
ic
inside ice_ptp_process_tx_tstamp() is bypassed. Will this permanently leak =
the
queued SKBs until the tracker fills up and drops new requests?

>  	switch (pf->ptp.tx_interrupt_mode) {
>  	case ICE_PTP_TX_INTERRUPT_NONE:
>  		/* This device has the clock owner handle timestamps for it */

[ ... ]

> @@ -2944,6 +2947,9 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
>  		return IRQ_WAKE_THREAD;
>  	case ICE_MAC_E830:
>  		/* E830 can read timestamps in the top half using rd32() */
> +		if (pf->ptp.state !=3D ICE_PTP_READY)
> +			return IRQ_HANDLED;
> +

[Severity: High]
Similarly for the E830 IRQ handler, does this early return bypass the clean=
up
logic in ice_ptp_process_ts() and cause the same SKB memory leak when the P=
TP
state is not ready?

>  		ice_ptp_process_ts(pf);
> =20
>  		if (ice_ptp_tx_tstamps_pending(pf, true)) {
>  			/* Process outstanding Tx timestamps. If there

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006095435.4191=
28-1-sergey.temerkhanov@intel.com?part=3D1
