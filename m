Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801160A2631
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xcohbR9u;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlLMsskF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFA8180931;
	Tue, 20 Oct 2026 13:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qRbmtQZ-6nxJ; Tue, 20 Oct 2026 13:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED5FF80D56
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792501863;
	b=f96ezEkBJa15NGmPy3FS+0G5KU2f7QXdJAMaGYh1DaYbAfUpzXLdnmmhbnOeerYgmSlQ
	 1W2Tw2VydgiyX/mf2wPFQ20t+Ks1agfrJciiFSjX1ivVy2jVnl5uFPF2ih2e/m+Abxa/Y
	 G6nG6PHKjVvKdil8A+SjsTdiTkamj80WdJMYIYrwyKDb/3VU5vHevTElsLYA0/372G0ZY
	 dardMyqC/scU0Vw9sfX30khh3v5oiTmNmOOkIjMWz9Pznf+ntAlbhfHZzcgyTEyHSr8f1
	 3We5jgRMNHtjKLSn1dh0PiQiig7WuwF5P93q/zB3JBATVvpfhScgrn7dBhABsRx2FZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792501863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BgtBHnxdOVXZopSmsnS/chjAyd2c5e1oaSz23YMKP0A=;
	b=daDXmHC4m6Wy2ang+/S70bJFchJsCsAXhecKC6SK+Q3uKQJOrMvLOVtwmAIFT4jLXYnv
	 7fQGoB65mS3O/Jc0baKLJwneowa356poWXD3EblOqrSmMaDpai4OXDBw1C83NRvLM+v3y
	 cSM2118RpOcVVeJfZzBbrE/gcEkPMTO7Vd261lu2upQ/ohca2hlS4H8Ju3jL3z1sC2V8p
	 W+jV6THFJafB2CDzXvCV30YvcU1pNOCpNFXFXFmcFSToh66ibdw3PGQNwWbcMIdmxlv67
	 C5cTB5Axl0hBPlUiE/fVuEiQvzo3GRPqVuffdcdcpNrtFxVTcp5AsjsTm02wtEO2C2w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792501863;
	bh=BgtBHnxdOVXZopSmsnS/chjAyd2c5e1oaSz23YMKP0A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xcohbR9u9xp3rrvH9vSPe9DEULD+rMDywW0ledRX2cj+m3bSoQb7yK29PYdJMCPZc
	 48fUa4jzBiCpNW06XGSri758vE68iIZraBm5H+ASP8YevB/aScsxUvKeZWytLoMpa9
	 uqj/5B2nAnHCtNtNRAe9rAv9mw/7226mWdm9T2/Ug+zQCrGVLj5IFMHrd/aImHyMk9
	 /WRcDTcSeuRyQRuospflPAm2/uqUQoZZ7dbjivADFld5SmHKBx4eubrb1FU7z/jDyF
	 JvCY7oZVnOvmBiGPblMqveKQikzUiSkqqtU1uaj0K5oXGCn681R6SFyEYp4uBui6rm
	 XFhqj0siOZ9KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED5FF80D56;
	Tue, 20 Oct 2026 13:11:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 944163A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 13:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85DD760826
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 13:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RO1I1cJnC7aM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 13:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79A29605D2
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792501861;
 b=DmWQholMSvU7BZORmYlmxHQOaDWaI5ThcK6ugdmiKfmsfcTIueggc8JvK9Wa0DwhE45l
 sXBDGQ89VhqdhfFySRD2PMiM6gMXwvBZ6OHM/eZrh4tBZdiucV2mzIcj/xqsE2RUG+fJ9
 zusu1jlt1ZmX1qKuZ9a37mHADZKt+lUN+tc97v9ofYFL8XxcaEWVfTLSEs2a7cyuM13jp
 tqCkv2cjRTybn8JvJUCPTaeHj/SyXE5acy9DDKQxJWVZPrkZNdm7/4RB9P7E3TgXowaZS
 9s7ojkfrvDG7Xg1lwwSVUxiVP/EGOG+bTgK9mBXgpSCYq1luiRdD21RspuLvP6ZeJcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792501861;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=BgtBHnxdOVXZopSmsnS/chjAyd2c5e1oaSz23YMKP0A=;
 b=JqFRLWL5o7/a3SmEqeY/LtI3f09KkVmH4vlfuiaXV7aIGlEfu5/luUVsGjAHNBMetz9h
 GDZcBVNCHpf65lv2SUXLhs64U9AKOZech6BFJkPuPo2x7xoAHS2AG0rTaQJABpDRnjaoc
 tfObBP/Jkj75fVIba7+OYU1IrDToyNWdB2X1rnl3eMu59eIzNAG4Bx5eyKyhgVeYtBD3M
 VoevOztrEQ34vusyXHtmPgkKWuzXCfq9D7NlYYEa6hYJfeehwcHQ0/VDLNBs93jGIA1J6
 Pbdfee9HbysJ9VLamK2OtaadPaFZld6NKuZ+oTCZWryTKFWPiD7rj3CfwZ+KbYf1lFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OlLMsskF; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OlLMsskF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79A29605D2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 13:11:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 103564145A;
 Tue, 20 Oct 2026 13:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0051F000C5;
 Tue, 20 Oct 2026 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792501859;
 bh=BgtBHnxdOVXZopSmsnS/chjAyd2c5e1oaSz23YMKP0A=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OlLMsskFsoFxLF+IvX8Llhosc1jUFdCZttH/kXyszE6omWbJJ4shiJEy/D95AhcBt
 karqWrU9lA9umLHRJaznYWE7sbbD3lUM+8ZgnNaID971IUK73aAFjAiYEUdiuW6/p5
 Yf/vMXBPSx8hNbTapMpLiGYncoBrWFWJm0zGK9TZ3zZTQEkvr71iKS/CRgkG9gK73A
 ooH4NndEVtfDdo1j1zVDv/ABnSEktffo49qlYTnDKa2dawZXdNNm9Yt1eBLmjr48EP
 soIMzog+8n+h/yh8s5jbKjjmpH3xqSOZnMzhoW5Ib4jbzGHUyisK6nwl1143sNkDpf
 HQ+Z00FCEUtFw==
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
From: netdev-bot+sashiko@kernel.org
To: choiniere.vincent@hydroquebec.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, aleksandr.loktionov@intel.com,
 michal.kubiak@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 20 Oct 2026 13:10:58 +0000
Message-ID: <179250185873.3135.10101707471960530546@kernel.org>
In-Reply-To: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `tx_buf->type == ICE_TX_BUF_SKB` guard in
  ice_tx_hang_reporter_dump()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  keeps it and adds another access to the same storage.

--

ice: fix Tx hang dump using stale tx_buf[0].skb

This commit changes ice_tx_hang_reporter_dump() so it reads the Tx buffer
at event->next_to_clean instead of always reading tx_buf[0]. It uses that
buffer's skb only when the buffer type is ICE_TX_BUF_SKB, and skips the skb
dump otherwise.

Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a8178d48..059859c36dfb2 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,

[ ... ]

> -	skb = event->tx_ring->tx_buf->skb;
> +	tx_buf = &event->tx_ring->tx_buf[event->next_to_clean];
> +	if (tx_buf->type == ICE_TX_BUF_SKB)
> +		skb = tx_buf->skb;

[Severity: High]
Is this type check enough to stop devlink_fmsg_dump_skb() from reading a
freed skb when Tx cleanup runs at the same time?

The dump runs from the service task:

ice_service_task()
  ice_report_tx_hang()
    devlink_health_report()
      devlink_health_do_dump()
        ice_tx_hang_reporter_dump()

The only lock held on that path is reporter->dump_lock. Nothing disables
NAPI, takes the Tx queue lock or takes a reference on the skb.

ice_service_task() calls ice_report_tx_hang() before ice_reset_subtask(),
so the ring's NAPI and queue IRQ are still live while the dump runs:

	if (pf->health_reporters.tx_hang_buf.tx_ring) {
		ice_report_tx_hang(pf);
		pf->health_reporters.tx_hang_buf.tx_ring = NULL;
	}

	ice_reset_subtask(pf);

In ice_clean_tx_irq(), the skb is freed before the type is changed, and
tx_buf->skb is never cleared:

		/* free the skb */
		napi_consume_skb(tx_buf->skb, napi_budget);

		/* unmap skb header data */
		dma_unmap_single(tx_ring->dev,
		...
		/* clear tx_buf data */
		tx_buf->type = ICE_TX_BUF_EMPTY;

This means the reporter can see ICE_TX_BUF_SKB for an skb that has already
been freed.

The index is racy as well. ice_report_tx_hang() copies
tx_ring->next_to_clean with a plain read of a field that NAPI updates, so
it can name the slot NAPI is reclaiming at that moment.

After this check and before devlink_fmsg_dump_skb(), the dump makes many
devlink_fmsg_put() calls that allocate with GFP_KERNEL. It also copies the
whole descriptor ring. That is a long window in which the task can be
preempted.

The scenario in the commit message seems to set up exactly this case. The
descriptors have completed and only the queue IRQ is delayed. NAPI can run
on another CPU, as the RT IRQ thread preempting the kworker, or because Rx
traffic on the shared q_vector kicks it. Whenever it runs, it frees the
skb at next_to_clean. devlink_fmsg_dump_skb() would then read skb->len,
skb_shinfo(skb) and skb->sk from freed memory.

Could that cause the same page fault this patch is meant to fix, or copy
freed memory into the dump? The notes below the commit message already say
"the skb lifetime against concurrent Tx cleanup still needs review".

Would it work to call napi_disable() and napi_enable() on
tx_ring->q_vector->napi around reading and dumping the skb? Two other
options are to capture the skb fields while cleanup is excluded, or to
dump only the skb pointer and not the skb contents.

> @@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>  	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
>  	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>  				     event->tx_ring->count * sizeof(struct ice_tx_desc));

[Severity: Medium]
This isn't a bug introduced by this patch, but the patch keeps it and adds
one more access through the same saved ring pointer. Is event->tx_ring
guaranteed to still be valid when this dump runs?

ice_prep_tx_hang_report() saves a raw ring pointer from watchdog context:

	buf->tx_ring = tx_ring;

ice_service_task() uses it later with no lock and no reference. It holds
neither rtnl nor ICE_CFG_BUSY, and ring teardown never clears the saved
pointer.

ice_set_ringparam() runs under rtnl and does not check
ice_is_reset_in_progress(). It calls ice_down(), which runs
ice_clean_tx_ring(). That frees every skb, clears tx_buf and resets
next_to_clean to 0. Then ice_set_ringparam() does:

			ice_for_each_txq(vsi, i) {
				ice_free_tx_ring(vsi->tx_rings[i]);
				*vsi->tx_rings[i] = tx_rings[i];
			}

ice_free_tx_ring() frees tx_buf and desc and sets both to NULL.

If ethtool -G runs while the service task is dumping, can
ice_tx_hang_reporter_dump() do any of the following?

- Index freed or NULL tx_buf memory using the old next_to_clean.
- Dump count * sizeof(struct ice_tx_desc) bytes from a freed or NULL desc.
  The count and desc values may also come from different ring
  generations.
- Dereference q_vector->name.

On VSI rebuild, ice_vsi_clear_rings() frees the ring structs themselves
with kfree_rcu(). That would leave the saved pointer completely stale.

ice_stop() is mostly blocked here. ice_tx_timeout() sets ICE_PFR_REQ, and
ice_stop() returns -EBUSY while a reset is in progress.

The tx_hang_buf fields are also written and read with plain accesses.
Because ice_service_task() clears tx_ring after reporting, it can drop a
newer timeout record. The head and intr values may also come from a
different event than tx_ring.

The old code had the same exposure through
event->tx_ring->tx_buf->skb.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-ice-tx-hang-dump-v1-1-3df0f5979a51%40hydroquebec.com
