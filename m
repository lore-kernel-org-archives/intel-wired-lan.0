Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61327606A326
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6rmYmkyQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8yvilQ6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E70A80FB9;
	Sat,  7 Nov 2026 11:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7cvpV7Pm5b9; Sat,  7 Nov 2026 11:15:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6866F81113
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794050150;
	b=AjVK4ZAIIdzkcnF73FhQY7Td2kpftriJTQwYzN7RGfnqtd8YnV2uG7QYa76D219SON5i
	 il/Sqm79WKCIOmdTfUhXEQjqVkYJpWOaBxScDHlCL3D6SVyzEoUw1iHHFVOFBIDEI8B5F
	 7Y3pRWW+akRN8+IEI7rFJwSIKwinxewASnl8IXQDX7GAN0TxSlSvWz8OPz2aO64MgKcOG
	 63nifoP1XG4B0ccooyfDIRh5no8K0u1Ultv18yf6c8VG2g7itXZkECqIK/R1o0VWSJF4f
	 a8WYJ+e3Xf94QkVubutCa1tSzrmyZ+Eiglc9s7DVv4pYJy8N2RwnoaA2XJ6w2M3Fk5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794050150;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HlLkPFRA47iYpBWPfJSKGrVGd9XNqqaIsaN822UA81k=;
	b=VsozD+/HoRi+r6zSrN7ffg4DokeAZDSL60Sg1xrg4en2qnhihlY5RT/yFjQod6GCq56A
	 vBPjee2/kcoovtxiOp804WMZZDaJ5FsVVnviqgb4wXzhGXnYAXtSDkxqJOnEru+gR6UMY
	 4olpGBnja4VWZtaB/eZWN3Vaf+Ppsoo35HGPOhlMY1Y+KVBytpP754MAl1Lsld/VFPowI
	 c+/iSyxto9qWe3rfcfhP1beCZR3TKmoWxdY8ExcSadWv2WlbPSKmV7fIfNgBXdbkvBK7v
	 F8FdY7HyNeV6c/KvgVAaWRUZ2s+xSRCtBpNrhKFdlviEn0Ah+PXV/BNCd8AXYy2CgpQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794050150;
	bh=HlLkPFRA47iYpBWPfJSKGrVGd9XNqqaIsaN822UA81k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6rmYmkyQ2DDL9Q0c3tbqqHmh9e/5Aw8u9NOLMgQQAgXv8gSmZwbWH6xu/B622WkJO
	 CKIumHk6vDmtriaPpsSFuw7srUw5ODiLKxl1/kkBOqgTqO39AvK5mHy4OSs0KFgaZm
	 jPVyCth0gL0uIfdKIh0GJfTI7/QOjSI/cC9UXnF5NmOP9fK3xRdKp5/rBMV5WjDWYz
	 jcFsJmm4hxvchLdshQPOhEwsk114h7JRp/df9vChzPg4owx7X+dMwIfNp/qYu5sGHT
	 h8gx0xhWQsBEf1T+49oYmE1A/2LVQzTvKzIXci/3DYNrFWYgERipME3V9u0LU87mbr
	 QIBYLXCAAVdlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6866F81113;
	Sat,  7 Nov 2026 11:15:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 295372FE
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 11:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F783606CF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 11:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wjbrf-AnieW for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 11:15:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E739605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=E8yvilQ6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E739605C9
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 11:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9ED743DDF;
 Sat,  7 Nov 2026 11:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FAF1F0089F;
 Sat,  7 Nov 2026 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794050146;
 bh=HlLkPFRA47iYpBWPfJSKGrVGd9XNqqaIsaN822UA81k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=E8yvilQ6bM1/ZFCRN2Aupy3mdGtXi1d07S7K3DERfQLlQTetUnJxAsoMfuMGva9Hl
 /yNdTK8FcqGwgtPsgIqT/j4OV1sSE/x/EADkVCS40ef4G/qpkCYRKa4/Uaa84EgnQb
 gVC6t6dvVQnIqBcHvl/bOQ4Mt8Ax7M2duIE8iepjKZQnapKpm1d+m3Zq0fMU0Zubvi
 FLWppSRyV+URd9AtlXGKBDedzLWfRLk4oAKWLTTrmbMmq8DIju889NrGuFj56uc9aW
 yMeHS6w7DP0bMzez+Q3sWtM7/iBGPHPDGHgBm0sJUvs16+kS0OnlQ9pTZ5hAjMIjmU
 1GKxqKehFqeyA==
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:15:45 +0000
Message-ID: <179405014554.994134.10719290719575125531@kernel.org>
In-Reply-To: <20261103100534.1310039-1-vulab@iscas.ac.cn>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fixes the SA reference leak in only one of the two
  copies of this Rx code.

Pre-existing issues:
- [High] ixgbe_ipsec_del_sa() unlinks the rx_sa from the RCU hash table
  with hash_del_rcu(&rsa->hlist) (line 783) and then zeroes the same…
- [High] ixgbe_ipsec_find_rx_state() finds rsa->xs only under
  rcu_read_lock() and takes its reference with xfrm_state_hold(), which…

--

net: ixgbe: drop the SA reference if secpath_set() fails

ixgbe_ipsec_find_rx_state() takes a reference on an xfrm_state. With this
patch, ixgbe_ipsec_rx() releases that reference when secpath_set() fails
to allocate the skb extension. Before this patch the reference was leaked
on that error path.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index bd397b3d7deab..e44d5eed9ab59 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -1197,8 +1197,10 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>  		return;
>  
>  	sp = secpath_set(skb);
> -	if (unlikely(!sp))
> +	if (unlikely(!sp)) {
> +		xfrm_state_put(xs);
>  		return;
> +	}

[Severity: Medium]
Does ixgbevf need the same fix? The VF driver has a copy of this Rx code
in drivers/net/ethernet/intel/ixgbevf/ipsec.c. After this patch,
ixgbevf_ipsec_rx() still returns without dropping the reference:

drivers/net/ethernet/intel/ixgbevf/ipsec.c:ixgbevf_ipsec_rx() {
    ...
	sp = secpath_set(skb);
	if (unlikely(!sp))
		return;
    ...
}

ixgbevf_ipsec_find_rx_state() takes the reference the same way the PF
helper does:

			ret = rsa->xs;
			xfrm_state_hold(ret);
			break;

secpath_set()->skb_ext_add() is a GFP_ATOMIC allocation. Suppose a VF gets
inline-offloaded ESP/AH traffic while memory is tight. Would one
xfrm_state reference leak each time the allocation fails? If so, the state
would never be freed after the SA is deleted.

Could ixgbevf get a matching fix with its own Fixes: tag?

>  
>  	sp->xvec[sp->len++] = xs;
>  	sp->olen++;

[Severity: High]
This isn't a bug introduced by this patch, but is the rx_sa entry walked
by ixgbe_ipsec_find_rx_state() safe against ixgbe_ipsec_del_sa()?

ixgbe_ipsec_del_sa() unlinks the entry and zeroes it straight away. There
is no grace period in between:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:ixgbe_ipsec_del_sa() {
    ...
		hash_del_rcu(&rsa->hlist);
    ...
		memset(rsa, 0, sizeof(struct rx_sa));
		ipsec->num_rx_sa--;
    ...
}

The NAPI reader runs under rcu_read_lock() and loads rsa->mode and
rsa->xs with plain loads:

ixgbe_ipsec_find_rx_state() {
    ...
		if (rsa->mode & IXGBE_RXTXMOD_VF)
			continue;
		if (spi == rsa->xs->id.spi &&
		    ((ip4 && *daddr == rsa->xs->id.daddr.a4) ||
    ...
}

Suppose a reader picked up rsa from the bucket before hash_del_rcu(). Can
it then see rsa->mode == 0, pass the VF check, and dereference
rsa->xs == NULL in softirq? If ixgbe_ipsec_add_sa() reuses the slot, the
reader could also see a mix of old and new SA fields.

The trigger would be an SA deletion (XFRM_MSG_DELSA, IKE rekey or
lifetime expiry) racing with Rx traffic whose SPI hashes to the same
bucket.

ixgbevf_ipsec_del_sa() has the same pattern:

		hash_del_rcu(&ipsec->rx_tbl[sa_idx].hlist);
		memset(&ipsec->rx_tbl[sa_idx], 0, sizeof(struct rx_sa));

[Severity: High]
This is a pre-existing issue, but is xfrm_state_hold() safe on an
xfrm_state that was found only under rcu_read_lock()?

ixgbe_ipsec_find_rx_state() does this:

			ret = rsa->xs;
			xfrm_state_hold(ret);

xfrm_state_hold() is an unconditional refcount_inc(). The rx_sa entry
holds no reference of its own on xs. __xfrm_state_delete() calls
xfrm_dev_state_delete() and then drops the reference right away:

net/xfrm/xfrm_state.c:__xfrm_state_delete() {
    ...
		xfrm_dev_state_delete(x);

		xfrm_state_delete_tunnel(x);
		...
		xfrm_state_put(x);
    ...
}

Can the refcount reach zero while a NAPI reader that has already loaded
rsa->xs is still in its RCU section? If so, refcount_inc() would run on 0.
That warns and saturates, but the pointer still ends up in sp->xvec[]
above.

xfrm_state_gc_task() frees the state after synchronize_rcu(). That waits
for RCU readers, but not for skbs that hold the secpath.

Suppose the skb outlives the grace period, for example when RPS queues it
to another CPU's backlog. Would xfrm_input() and
secpath_put()->xfrm_state_put() then touch freed memory?

The xfrm core handles this case with xfrm_state_hold_rcu(), which uses
refcount_inc_not_zero(). Should the driver take its reference with an
inc-not-zero as well? ixgbevf_ipsec_find_rx_state() has the same pattern.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100534.1310039-1-vulab%40iscas.ac.cn
