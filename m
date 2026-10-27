Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A310606A31F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TZJjSlaB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ncMLtN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2719180D9C;
	Tue, 27 Oct 2026 12:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23XOSGLxLLif; Tue, 27 Oct 2026 12:17:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC36580D9E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103437;
	b=Rh/H5A9IEdVQEAh7rjnFkk0A2vFN1pLfXogTYZa3F90+N/K5RcSOIoy0wM10m847gGIS
	 PZQzPQ9mtkO1ffZWKCoHxu6LHInVE2IRkiPWlttqPxT4IEIVROHSLi08kTfh5hzvy5V/f
	 opGH+X6pzZNFyvaQNaXoJ+xLU4qEoVF/rGV7UopGTNH4N+XFAkRgNyg3o8eWFNMSkhCJz
	 YbOOcKTR++ESgtYxmFGN+EdwR4ZR4uoLYW3FbcDjkifwPgbpKiXp1n7MNWHOk+vTg+ndG
	 3sKkT2Cnjz2nXz0T63bOjW6XkqICneVe9MVihHIdzDf9Rs1cAUtsUGFPoJHm4yKER8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zhLcwSooW/Zl3/4kxoQ1C8DWBsgBlBQ47JW1CBaiEPo=;
	b=jdQgXnvq/c+qiKWqb9L4rlT/doaBwHbi6t4WhvaT0Ko2xCMgPIj6NaRcKi6V+pFHrF9m
	 CfUWO8zRYi6JVq35P7V+KGzEMiHtDbrcNFSjYgaO9oiQd1qH2tPpNUDsYDPpOHo2oqVkr
	 1v0k/QMOMdq8TLdkoldzd7JkO68BYQN1ZVDTbEe1sQ2EmgS18H/WtAgWVFxOrIOZE5KHc
	 NHlHK0U6+4DA7JdhJAAzVMFJLPbHt029EvlhDdQ2/O6yZ77/rt0IgLnm2NVwTRr4KDN9h
	 wKMoaaorriHF9RYHkgfMqBVJz+H3XpdoBS7IfRL8K7Fx/gDzFvwKfCp7rWGvhm/q9XA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ncMLtN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103437;
	bh=zhLcwSooW/Zl3/4kxoQ1C8DWBsgBlBQ47JW1CBaiEPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TZJjSlaBnkMBLvTor/ScgkOjF4wEX8PLVQo1c8RyMMHDdguz8BkcVgyjAzC67KAfP
	 7gy1eJrXAfkciWce3Ig3iHow6334upbqL+XZEPX3qzWwPMqShXpFdvX9SEND6Z5tG+
	 4r2QcfZv66FhuNTJ6nMFLCAfBtsGu3qomTxJrrKkQb5aqB8rLpbsyE1iuCDMVq07hi
	 8tqiX9+588QC70FFmYS3eJs4iyyNwJ/AfWB/Q31eBVCPPMvSus080T11X1sqsxVi2U
	 Ti5I58DIj3DvYJntwQ2Fv3LnrwacJz1RYsKPjI/ZgAA+uG90Phe/jCZbGQSMOakE69
	 b7oA0gtunDGlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC36580D9E;
	Tue, 27 Oct 2026 12:17:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 387A54BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A48B80D8F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 51h01MT1Z_78 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB90680C48
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103433;
 b=g1uwqlVm2V3FWbCvk+8+XPL5LJv/3TJHft7YUsW0sOVh2WsKFoanPX3b12556prS9oZ6
 ZDGrBFxLMdFlGn9FrOFbMzfH1uy+W7cy9lYTdiwfmHLeniT7zJ6rkB4XH1fhfgHUBupGR
 kAVRpF+LXKKvUPkC8XabzbnRgmmAPf0+Af8h5T8ONVm/sN1uGOFH4DX5tu2gWBLq7uTsT
 EhRYMacXsAUFml2aNuH8gtH0Jy866gGXo96xVGeGvX/8EYUpyO1b/AX51hO61gbBhYycM
 uzFeYYDOyW4GjxbZ9cYtAxUV4wzU8Wu4HagDC9SqNe7QP1tOc4xRZFjc3aSUZI4eHcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103433;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=zhLcwSooW/Zl3/4kxoQ1C8DWBsgBlBQ47JW1CBaiEPo=;
 b=mbF+KExUZotcpwSvuCsur7v8ToLB1swQUhzCvB7E2ueYGVGrfXvgO05xqwkuUw3xjcUe
 BCt5AB7fX6IPfQVYfHcFHyBOmb105E5AwG9022VmxjG2QYZTvB+VEiGubV8kzjn6jgEus
 QqYIrDIph4S+YSE6uVr6ERHdhGu/lQ8ToClxt+YJXXxiRNnFoH5AonX5YnZ/mJJFC7iOj
 IaiWFYZQJ/KwlBlbUvkZZo8qaTANOh46/ncjDWiIK0R0d8Ih5zgPzTJO1KJ29zfAdnLBE
 i3Ob3GfLBn2QbFnjXbhk6CEqskbq9rCa8ecV/lMxbxdP5A1WGq9Q+gBmuNot1ScinkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S3ncMLtN; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S3ncMLtN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB90680C48
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A705841AAA;
 Tue, 27 Oct 2026 12:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7A1F031E1;
 Tue, 27 Oct 2026 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793103432;
 bh=zhLcwSooW/Zl3/4kxoQ1C8DWBsgBlBQ47JW1CBaiEPo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=S3ncMLtNu4FMHy2PpFAjdjOCUSrJb2RF3maO6lPfRtSaOva6SVFNNs7XKxenyjyp0
 YeB6odigs4l6WHBhzKULdaiTUSAeUGwV+PTsT8084GG1oOLNVRHoK9cEFWfBXAqXAg
 Ri0kqjOCbZ0uXwBH4hm856pkXOr+182RePhWqNvEHykUzLLQYU1aFFiCj8h21kG9fi
 H6B5b/yfFbdvfcLvHJsrRE0HYlgtTcXc7lvV18GynSnGDtHd0+3xmbrEjI83dqBbJ3
 tPC8zXnO6v1M5RlKUS4UJ3txp515dtBJzFN7jWNfLyi4liejTBtjejQxQK5mv6jv/A
 wU7IzFb1e/pKw==
Subject: Re: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX
 timestamps
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com,
 aduyck@mirantis.com
Date: Tue, 27 Oct 2026 12:17:11 +0000
Message-ID: <179310343105.3134.12907560938189136535@kernel.org>
In-Reply-To: <20261026091549.605810-3-p@1g4.org>
References: <20261026091549.605810-3-p@1g4.org>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] igb_tx_csum() still ignores the return value of
  skb_checksum_help() (igb_main.c:6170, `default:…
- [Low] The commit message says the bug's effect is a dropped packet (TSO
  path) or an incomplete checksum (csum path), because commit…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ixgbe_xmit_frame_ring() has the same ordering bug this series fixes in…
- [Medium] This problem wasn't introduced by this patch, but on the
  igb_tx_map() failure path, cleanup_tx_tstamp in igb_xmit_frame_ring()…
- [Medium] This problem wasn't introduced by this patch, but the
  cleanup_tx_tstamp path in igb_xmit_frame_ring() calls…

--

igb: prepare TSO and checksum offloads before TX timestamps

This patch moves the VLAN flag setup, igb_tso() and igb_tx_csum() in
igb_xmit_frame_ring() ahead of the skb_get() taken for hardware TX
timestamping. Offload preparation therefore no longer runs on a shared skb.
The timestamp flag is then ORed into first->tx_flags so the offload flags
are kept.

> igb_xmit_frame_ring() takes an extra skb reference for TX timestamping
> before transmit preparation. For GSO packets, igb_tso() calls
> skb_cow_head(), which can reach pskb_expand_head() with a shared skb
> when the header is cloned. Commit c7d8bc3dd511 ("net: skbuff: don't BUG()
> on bad arguments to pskb_expand_head()") replaced the BUG_ON() with
> -EINVAL, causing TSO preparation to fail and the packet to be dropped.

[Severity: Low]
Does this description match the tree this patch applies to?

Commit c7d8bc3dd511 doesn't appear to be an ancestor of this patch.
pskb_expand_head() here still has:

net/core/skbuff.c:pskb_expand_head() {
    ...
	BUG_ON(skb_shared(skb));
    ...
}

The same is true for the stable kernels the Fixes: tags point at.

So before this patch, both paths described in the message would hit BUG().
They would not drop the packet or skip the checksum:

igb_xmit_frame_ring() /* skb_get() */
  igb_tso()->skb_cow_head()->__skb_cow()->pskb_expand_head()

igb_xmit_frame_ring() /* skb_get() */
  igb_tx_csum()->skb_checksum_help()->skb_ensure_writable()
    ->pskb_expand_head()

The code change looks right. Could the message say that the effect is a
BUG()? Once hardware TX timestamping is enabled, an SO_TIMESTAMPING sender
can trigger it.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..04c0053dbaae8 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6559,6 +6559,21 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  	first->bytecount = skb->len;
>  	first->gso_segs = 1;
>  
> +	if (skb_vlan_tag_present(skb)) {
> +		tx_flags |= IGB_TX_FLAGS_VLAN;
> +		tx_flags |= (skb_vlan_tag_get(skb) << IGB_TX_FLAGS_VLAN_SHIFT);
> +	}
> +
> +	/* record initial flags and protocol */
> +	first->tx_flags = tx_flags;
> +	first->protocol = protocol;
> +
> +	tso = igb_tso(tx_ring, first, &hdr_len);
> +	if (tso < 0)
> +		goto out_drop;
> +	else if (!tso)
> +		igb_tx_csum(tx_ring, first);

[Severity: Medium]
The commit message says igb_tx_csum() ignores the error from
skb_checksum_help(). This patch removes the shared skb trigger, but can
that ignored error still happen?

igb_tx_csum() still does:

	default:
		skb_checksum_help(skb);
		goto csum_failed;

igb advertises NETIF_F_HW_CSUM. A non-GSO CHECKSUM_PARTIAL skb with an
unusual csum_offset therefore ends up here, for example one sent through
AF_PACKET or tun with a vnet_hdr.

skb_checksum_help() can still return early without writing the checksum or
setting CHECKSUM_NONE:

skb_checksum_help()
  skb_ensure_writable()
    pskb_expand_head(skb, 0, 0, GFP_ATOMIC)  /* -ENOMEM, cloned header */

The other early returns are a __skb_linearize() failure, the -EINVAL
headlen offset checks, and !skb_frags_readable().

On failure igb_tx_csum() jumps to csum_failed. Because igb_tx_csum() returns
void, igb_xmit_frame_ring() cannot drop the packet. igb_tx_map() then sends
a frame whose L4 checksum field holds only the pseudo-header partial sum.

Could igb_tx_csum() return an error so the caller can goto out_drop? That
would match how an igb_tso() failure is handled here, and what
validate_xmit_skb() does when skb_checksum_help() fails.

> +
>  	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
>  
> @@ -6567,6 +6582,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  					   &adapter->state)) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  			tx_flags |= IGB_TX_FLAGS_TSTAMP;
> +			first->tx_flags |= IGB_TX_FLAGS_TSTAMP;
>  
>  			adapter->ptp_tx_skb = skb_get(skb);
>  			adapter->ptp_tx_start = jiffies;

[Severity: High]
This isn't a bug introduced by this patch, but does ixgbe_xmit_frame_ring()
have the same ordering problem that this series fixes in igb and igc?

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_xmit_frame_ring() {
    ...
			adapter->ptp_tx_skb = skb_get(skb);
			adapter->ptp_tx_start = jiffies;
			schedule_work(&adapter->ptp_tx_work);
    ...
			if (skb_cow_head(skb, 0))
				goto out_drop;
    ...
	tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
	if (tso < 0)
		goto out_drop;
	else if (!tso)
		ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
    ...
}

After skb_get(), three paths can call pskb_expand_head() on the now shared
skb when its header is cloned:

  the DCB software VLAN skb_cow_head()
  ixgbe_tso()->skb_cow_head()->__skb_cow()
  ixgbe_tx_csum()->skb_checksum_help()->skb_ensure_writable()

In this tree that hits BUG_ON(skb_shared(skb)) in pskb_expand_head(). Once
c7d8bc3dd511 is applied, it becomes a dropped TSO packet or an ignored
checksum failure instead.

The series doesn't touch ixgbe. Should ixgbe get the same reordering?

[ ... ]

> @@ -6577,21 +6593,6 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,

[ ... ]

>  	if (igb_tx_map(tx_ring, first, hdr_len))
>  		goto cleanup_tx_tstamp;

[Severity: Medium]
This is a pre-existing issue, but on 82576 can the cleanup_tx_tstamp path
race with igb_ptp_tx_work()?

igb_xmit_frame_ring() {
    ...
cleanup_tx_tstamp:
	if (unlikely(tx_flags & IGB_TX_FLAGS_TSTAMP)) {
		...
		dev_kfree_skb_any(adapter->ptp_tx_skb);
		adapter->ptp_tx_skb = NULL;
		if (adapter->hw.mac.type == e1000_82576)
			cancel_work_sync(&adapter->ptp_tx_work);
    ...
}

The skb is freed before the work is synchronized. igb_ptp_tx_work() checks
and uses the same pointer without a lock:

igb_ptp_tx_work() {
	if (!adapter->ptp_tx_skb)
		return;

	if (time_is_before_jiffies(adapter->ptp_tx_start +
				   IGB_PTP_TX_TIMEOUT)) {
		dev_kfree_skb_any(adapter->ptp_tx_skb);
    ...
	tsynctxctl = rd32(E1000_TSYNCTXCTL);
	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
		igb_ptp_tx_hwtstamp(adapter);
    ...
}

igb_ptp_tx_hwtstamp() copies adapter->ptp_tx_skb and later calls
skb_tstamp_tx() and dev_kfree_skb_any() on that copy.

The work can be running on another CPU, either scheduled by
igb_tsync_interrupt() on E1000_TSICR_TXTS or rescheduled by itself. If it
passes the NULL check before the xmit CPU frees the skb, could it use or
free an skb that has already been freed?

To hit this, the worker would need a stale TSYNCTXCTL_VALID bit or a stale
ptp_tx_start, so it may be hard to trigger. The code comes from commit
74344e32fcc0. This patch makes it harder to reach, because igb_tso()
failures now return before IGB_TX_FLAGS_TSTAMP is set.

[Severity: Medium]
This is also pre-existing and not introduced by this patch, but is
cancel_work_sync() safe to call in this path?

igb_xmit_frame_ring() runs as ndo_start_xmit. BH is disabled under
rcu_read_lock_bh(), and the txq _xmit_lock is held. ptp_tx_work is a regular
work item, so __cancel_work_sync() calls might_sleep(). It can also block in
__flush_work() if the work is running.

With CONFIG_DEBUG_ATOMIC_SLEEP, each igb_tx_map() DMA mapping failure on a
timestamped 82576 packet would print a "sleeping function called from
invalid context" splat.

If the work is running at that moment, the xmit path would really sleep in
atomic context. That can happen because igb_ptp_tx_hwtstamp() clears
__IGB_PTP_TX_IN_PROGRESS before it calls skb_tstamp_tx(). A new timestamp
request can then start while the previous worker is still running.

After this patch, only an igb_tx_map() failure reaches this path. This code
also comes from commit 74344e32fcc0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091549.605810-1-p%401g4.org
