Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE12C9832A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCBFE80DFA;
	Tue, 29 Sep 2026 14:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mMtuxfEX3zf; Tue, 29 Sep 2026 14:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD63180E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790690654;
	b=cwvAzlTbguvW6Liwr/MFZyHcAehc2Y+xWNHc1VOOgRRHhIUIQSsXpDVKVnvBM21AwQkH
	 cyqf7KCBzgJDlFc3PWOci3Njk/zvUUtvJnd5252mo8PHJQd3g2zP5f+t7KmYPvrql2IIX
	 7ExCUPxHAz8fbWO2CB2uMyjTUB1w6P1GiLzLnykLiUAoC48cifY7hitN8zh/GHaU8AMJH
	 e04ZWzdDBOYdcoNQ1bXrABN3+benE7M2e1iM9rBjDQP1F5Z0/hEh1sS2DyW6I1lwtzlZA
	 WVNMfMh6CyupdFgxoxACjGqI2Qln3EPu4Owl63OmE/unZU86tXlHhLlHYDdA17zo3rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790690654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=35AAv+FkqITaLLADKCC5ArCsZyfbV2fgDUs0T5V4AGs=;
	b=WQyD5kqrCs3FKfrQqdp7WwJA/kd6Y1aC1evSRhnzZK46ILOqkiHOe8nWj/aOCl7UHaPs
	 5LBvvGgZZ4pWnW8WXIoOdW2kHmDhVihE5DGJtV+cVv+P0r7elaRy+C6iUU0Cxg/zB4NOD
	 fTaBOGmEoMLcTBujeepByBzFU6r1n1iICuOKmuCvrzA3ygbRn5WZ5/0bf8P7gqYnqpHdr
	 sJxjZ7tazeKsnGoocmyvx7ryu3ACy2Qd4aj2gkmFRp5XwLM6EN2OucWy11+HQv8qG22Nk
	 mMWOxjKkZiPorEL/3hhbQ7omfYNWK3CruBagS9z0CYXnmQ+Mlt7ttM6UtEknaEWGbOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8dTPjQd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790690654;
	bh=35AAv+FkqITaLLADKCC5ArCsZyfbV2fgDUs0T5V4AGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LzuyF/2NRH9nbBtyASuHXk1kK6JsN+bUgiNoFb/F3VlJl30AMc7ZsVeybHHTG2bdq
	 E9IPz/DSyyHj0AO4L8aW10fDITw2n3LECch5lK25nVEjswU+nx11ndiHvjV0SuJ+n1
	 oS3NLED+K8O4G1JCT8pd6jp8vSDYO7lRgf1HP8d6HR6aW/583PbRPYMBhRiOITUzRB
	 Ww6I81NYj5ccs+gkkxK0HG8elASNQLe7rviouW4339NDwqDgfQwSYsqrzOfNppeEtc
	 AU9xgM73aaJQtecc1wJ7PW/mJGNh+MKogctwVV7Eo4SjTSt2aigAYldMvFuhULX8/d
	 +PytnuFpvPiuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD63180E9C;
	Tue, 29 Sep 2026 14:04:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEFA734E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 948EA80E9C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OCM6c0sRLO-f for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 14:04:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 35A5E80DFA
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790690652;
 b=sOESQ57V72G1vYCWx/DIC4yDAHKN4mVQIhVbfrpMKDbdpzfq08tH1+TBWC+YFO5GjjEV
 4bEJbehDVsqwBfqCrD24r4pL9hw62L02fHOBrZTtatPfQKHSvZ4kw76V41V89KWd7Ig06
 lgi5KV5nsTxYT03dWPPAV1svwIuFUYG0s8c6KcAqTXz4Iw8XOC/H0GNJcgJyxFpkzaidA
 YwLeg+2ON+LzZuZ1MDHVdrnRTsP0VKLsY003zlHUy5Eb8htveQeVB19mzObK0gUTPv5oV
 nb7WyZ2faq6cmDW/zGxBZ9ZhAwY6eVZqSqsLG6n8a7YXFC8TL62oDjPhQwy+1zHVmJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790690652;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=35AAv+FkqITaLLADKCC5ArCsZyfbV2fgDUs0T5V4AGs=;
 b=PW22pNKt2H8dUJkpRoFpiAKvvAL5kInvdi7Q/F9BBZBREgVW1Hi6Wh7ImRDLfPBdrDoj
 Hkn9qhubQFYLIZsOBFf0kIqTsdIDyGUuoeLIb/ruvmjW4Ue4+0H/qk6IubtjcSdl+wCj7
 OMlUYSwr/7xsi9ZLSIAzU7mdVO5mWMyDSb4xZRyjYSGN/Q5ES1nihbUCh6iSx3Bk+ICn0
 SQjN6cuDNOGyGk02zzA0wqSgxa3UfEwG/Lch9lYqVOrpWZOcQeIFEHeZWqUHJfxqH1uOb
 5qiUvt4JT2DC3WVTCjmUg9n+EYCWJtxjBs5ZvYKJvljp71LjX62MM7j1sA7q8wjOJxQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R8dTPjQd; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R8dTPjQd
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35A5E80DFA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6285601FB;
 Tue, 29 Sep 2026 14:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30281F000FF;
 Tue, 29 Sep 2026 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690650;
 bh=35AAv+FkqITaLLADKCC5ArCsZyfbV2fgDUs0T5V4AGs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=R8dTPjQdibza4SWPOAJBbFfK5YxaDa3mu474MWK7MKvnrMDttt99JVKwrIZtoBZrT
 Qz9OBIVRJVFS2FKm7RFrBF0fzS8tZbCx0ABlBeZS84RBvxWUH9asy9R/pzZpRZDMxa
 luMu6vkmClj+Ygr71Z36RN1+QI45gswLHLLJ0aUIcBNXRxoHtriWhZaDEOB8IaT+GW
 LShDtdxISp0unfo66pWVZgFrD2ty4Ag/y7+7JRrT5pO+O51D9plif0yDvZxTtmGtFC
 hJqALpE7Q8S1N56Oxqhlc9nmKvrVP6aCqLq7sbF1SBgnyc4oTwstEH9410RJ7NScZi
 cqiWmszBVuV9g==
Subject: Re: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:09 +0000
Message-ID: <179069064954.434549.8538944205290269009@kernel.org>
In-Reply-To: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] ice_vsi_resize_stat_arrays() sizes the arrays from a
  snapshot taken before ice_vsi_decfg(): the PF pool,…
- [Medium] ice_vsi_set_stat_arrays() publishes the new container with a
  plain store (`pf->vsi_stats[vsi->idx] = new_vsi_stat;`, ice_lib.c:592)…
- [Low] This patch fixes a real heap out-of-bounds access but has no
  Fixes: tag, and the Fixes-tagged fix later in the series cannot be…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a fallback
  rebuild dereferences NULL queue maps.
- [Medium] ice_vsi_free_unused_stat_arrays() calls kfree_rcu() on surplus
  ice_ring_stats entries while vsi->tx_rings[i]->ring_stats and…

--

ice: rebuild ring stats arrays instead of reallocating them in place

This patch replaces ice_vsi_realloc_stat_arrays() with
ice_vsi_resize_stat_arrays(). The new function allocates a fresh struct
ice_vsi_stats before ice_vsi_decfg() runs, sized with
ice_vsi_get_num_qs(). Surviving ring stats entries are copied into the new
container, surplus entries go to kfree_rcu(), and the old container is
freed without its entries, using a new helper,
ice_vsi_install_stat_arrays().

> ice_vsi_realloc_stat_arrays() resized the ring stats arrays in place
> with krealloc_array(), sizing them from vsi->req_txq/req_rxq. That is
> not what ice_vsi_set_num_qs() computes later in ice_vsi_cfg_def(), so
> after a rebuild the arrays could end up shorter than vsi->alloc_txq /
> vsi->alloc_rxq, and ice_vsi_alloc_ring_stats() then walked past their
> end.

[ ... ]

> this removes some tech debt, but it is not independently backportable,
> as it sits on three preceding refactors; the NULL dereference and the
> sizing mismatch are fixed by their own patches, which carry Fixes: tags

[Severity: Low]
The commit message leads with a heap out-of-bounds access. An admin
reaches it by writing sriov_vf_msix_count after a guest has raised
vf->num_req_qs through VIRTCHNL_OP_REQUEST_QUEUES:

ice_sriov_set_msix_vec_count()
  vsi->req_txq = queues;
  ice_vsi_rebuild()

The switch to ice_vsi_get_num_qs() in ice_vsi_resize_stat_arrays() is what
fixes that. Should this patch carry a Fixes: tag, instead of being
described below the cut as tech debt removal?

The later patch "ice: size ring stats arrays from the final queue count"
carries Fixes: 288ecf491b16 and calls ice_vsi_install_stat_arrays(),
which this patch adds. A stable backport of that fix would also need this
patch and the three refactors before it (__ice_vsi_free_stats(),
ice_vsi_new_stat_arrays(), ice_vsi_get_num_qs()).

Could these be marked as stable dependencies so a backporter knows?

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 134984077d5da..448d3c7780adf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -557,6 +557,80 @@ static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
>  	return vsi_stat;
>  }
>  
> +static void ice_vsi_free_unused_stat_arrays(struct ice_vsi_stats *vsi_stat,
> +					    struct ice_vsi_stats *new_vsi_stat)
> +{
> +	int new_txq = new_vsi_stat->tx_ring_stats_len;
> +	int new_rxq = new_vsi_stat->rx_ring_stats_len;
> +	int prev_txq = vsi_stat->tx_ring_stats_len;
> +	int prev_rxq = vsi_stat->rx_ring_stats_len;
> +
> +	for (int i = new_txq; i < prev_txq; i++) {
> +		if (vsi_stat->tx_ring_stats[i]) {
> +			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> +		}
> +	}

[Severity: Medium]
This is a pre-existing issue, and the old krealloc_array() code used the
same order. Are these entries still reachable when kfree_rcu() is called?

At this point vsi->tx_rings[i]->ring_stats and vsi->rx_rings[i]->ring_stats
still point at the surplus entries. The rings are only unpublished later:

ice_vsi_rebuild()
  ice_vsi_resize_stat_arrays()
    ice_vsi_install_stat_arrays()
      ice_vsi_free_unused_stat_arrays()
        kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
  ice_vsi_decfg()
    ice_vsi_clear_rings(vsi);

That grace period does not cover an RCU reader that starts after the
kfree_rcu() and reaches the entry through a ring, such as
__ice_get_ethtool_stats():

	tx_ring = READ_ONCE(vsi->tx_rings[j]);
	if (!tx_ring || !tx_ring->ring_stats) {

The reader paths that were checked look serialized by rtnl,
ICE_VSI_DOWN/ICE_CFG_BUSY, or netif_device_detach(), so the remaining
window looks narrow.

Now that the free is in its own function, could the surplus entries be
freed after ice_vsi_decfg() instead?

> +	for (int i = new_rxq; i < prev_rxq; i++) {

[ ... ]

> +static void ice_vsi_set_stat_arrays(struct ice_vsi *vsi,
> +				    struct ice_vsi_stats *new_vsi_stat)
> +{
> +	u16 new_txq, new_rxq, prev_txq, prev_rxq;
> +	struct ice_vsi_stats *vsi_stat;
> +	struct ice_pf *pf = vsi->back;
> +
> +	new_txq = new_vsi_stat->tx_ring_stats_len;
> +	new_rxq = new_vsi_stat->rx_ring_stats_len;
> +	vsi_stat = pf->vsi_stats[vsi->idx];
> +	pf->vsi_stats[vsi->idx] = new_vsi_stat;
> +	if (!vsi_stat)
> +		return; /* don't copy if there is no source */
> +
> +	prev_txq = vsi_stat->tx_ring_stats_len;
> +	prev_rxq = vsi_stat->rx_ring_stats_len;
> +
> +	memcpy(new_vsi_stat->tx_ring_stats, vsi_stat->tx_ring_stats,
> +	       sizeof(*vsi_stat->tx_ring_stats) * min(prev_txq, new_txq));
> +	memcpy(new_vsi_stat->rx_ring_stats, vsi_stat->rx_ring_stats,
> +	       sizeof(*vsi_stat->rx_ring_stats) * min(prev_rxq, new_rxq));
> +}

[ ... ]

> +static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
> +{
> +	struct ice_vsi_stats *old_stat, *new_stat;
> +
> +	new_stat = ice_vsi_new_stat_arrays(txq, rxq);
> +	if (!new_stat)
> +		return -ENOMEM;
> +
> +	old_stat = vsi->back->vsi_stats[vsi->idx];
> +	ice_vsi_set_stat_arrays(vsi, new_stat);
> +	if (old_stat) {
> +		ice_vsi_free_unused_stat_arrays(old_stat, new_stat);
> +		__ice_vsi_free_stats(old_stat, false);
> +	}

[Severity: Medium]
Can a lockless reader see the new container before the entries are copied
into it? ice_vsi_set_stat_arrays() publishes pf->vsi_stats[vsi->idx] with
a plain store, and only then memcpy()s in the surviving entry pointers.

ice_qp_reset_stats() dereferences an entry without a NULL check:

	vsi_stat = pf->vsi_stats[vsi->idx];
	if (!vsi_stat)
		return;

	memset(&vsi_stat->rx_ring_stats[q_idx]->stats, 0,

It is reached through ice_cfg_txtime() -> ice_qp_dis(), which holds only
rtnl and the ICE_CFG_BUSY bit. The reset path ice_rebuild() ->
ice_vsi_rebuild_by_type(pf, ICE_VSI_PF) -> ice_vsi_rebuild() takes
neither.

A related question: __ice_vsi_free_stats(old_stat, false) kfree()s the
old container and its arrays straight away, with no grace period. Could
ice_qp_reset_stats() still hold the old vsi_stat pointer at that point?

The ETF-vs-reset concurrency itself predates this patch, and the old
krealloc_array() also freed the old arrays synchronously. What is new is
publishing before the copy and freeing the whole container synchronously.

Would doing the memcpy() before the store to pf->vsi_stats[vsi->idx] close
the first window?

[ ... ]

> @@ -3040,69 +3114,27 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,

[ ... ]

> -static int
> -ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
> +static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
>  {

[ ... ]

> +	struct ice_vsi_alloc_queues_params qs;
>  
>  	/* channel VSIs have no entry in pf->vsi_stats[] */
>  	if (vsi->type == ICE_VSI_CHNL)
>  		return 0;
>  

[ ... ]

> +	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
> +				vsi->alloc_rxq);

[Severity: Critical]
Can the count computed here differ from the one ice_vsi_set_num_qs()
computes after ice_vsi_decfg()?

This snapshot depends on the PF pool, netif_get_num_default_rss_queues()
and vf->num_req_qs. ice_vsi_set_num_qs() later recomputes from the current
state:

	vsi->alloc_txq_rxq = ice_vsi_get_num_qs(vsi, 0, 0);

Nothing serializes the two calls. At this revision
ice_vsi_alloc_stat_arrays() keeps the installed arrays without checking
their length:

	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;

ice_vsi_alloc_ring_stats() then walks ice_for_each_alloc_txq() over
tx_ring_stats[]. Could it write past the end of tx_ring_stats[] or
rx_ring_stats[] if the second count is larger? One example is a PF rebuild
with req_txq == 0 while pool queues are freed, or CPUs come online, in
between.

The commit message acknowledges this ("barring a concurrent change of the
PF pool; the next patch stops relying on that"), and the baseline had the
same class of problem.

The later patch "ice: size ring stats arrays from the final queue count"
closes it. There, ice_vsi_alloc_stat_arrays() grows the arrays whenever
the stored lengths are below the final alloc_txq/alloc_rxq. This
intermediate revision is still exposed.

>  
> -	if (req_rxq < prev_rxq) {

[ ... ]

> -	return 0;
> +	return ice_vsi_install_stat_arrays(vsi, qs.alloc_txq, qs.alloc_rxq);
>  }
>  
>  /**
> @@ -3132,7 +3164,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  
>  	mutex_lock(&vsi->xdp_state_lock);
>  
> -	ret = ice_vsi_realloc_stat_arrays(vsi);
> +	ret = ice_vsi_resize_stat_arrays(vsi);
>  	if (ret)
>  		goto unlock;
>  

[Severity: High]
This isn't a bug introduced by this patch, but what happens when
ice_vsi_rebuild() is retried after a failure that already ran
ice_vsi_decfg()?

Both ice_setup_tc_mqprio_qdisc() and ice_sriov_set_msix_vec_count() call
ice_vsi_rebuild() again as a fallback:

	if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {
		dev_err(dev, "Rebuild of main VSI failed again\n");

The first attempt can fail late. One case is the coalesce allocation in
ice_vsi_rebuild():

	coalesce = kzalloc_objs(struct ice_coalesce_stored, vsi->num_q_vectors);
	if (!coalesce) {
		ret = -ENOMEM;
		goto decfg;
	}

The other is ice_vsi_cfg_def() unrolling. Either way,
ice_vsi_free_arrays() has set vsi->txq_map = NULL, but alloc_txq and
alloc_rxq keep their values.

The retry now gets past ice_vsi_resize_stat_arrays(), which handles a NULL
old container, and calls ice_vsi_decfg() unconditionally:

ice_vsi_rebuild()
  ice_vsi_decfg()
    ice_vsi_put_qs()
      clear_bit(vsi->txq_map[i], pf->avail_txqs);

Does this dereference the NULL txq_map? After a cfg_def unroll,
num_q_vectors is also still non-zero. Can ice_vsi_free_q_vectors() index
the NULL q_vectors before that?

In the baseline the retry crashed earlier, in
ice_vsi_realloc_stat_arrays(). This patch moves the crash point but does
not add a guard.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
