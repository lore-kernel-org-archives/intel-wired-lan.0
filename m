Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED08CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5D4D406F2;
	Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZRQ-kVeBBEy; Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C8B50404F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790690652;
	b=KrSLlq2U+Q2yp/WeBcDxCN1NmD/fIuAHnDhBai6y4MFVmzNB13n/KUkvcRiitl+axOhA
	 EibievsOh/7DxwZregVhRPDdVnCwu/K/PKahk62Hpg5mBRWU4qnud7b8VJJRTqUAUc9h2
	 XR/iu4PCbM98NxdJGU151WNaS7/zKQZzSEBb0Bo0sMpIupZz13NxG6gZvPH47GaXwIgUr
	 VzN5xDKJee558aMO33SdHb6eS2/RTFu+gUhChYnSshP2Mm+V0CdZzbpbYn+ONkLjNWSIj
	 qTGK4t67BIR1aaWnbhjbuXBkGbSqS49EyCQxbXsPUxAwHzYgJYYzgQlc72dHkNIfHaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790690652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J0U2ZuPppH2NjwbCIrXn37RZhk/7ihyg4JkkDJeReJA=;
	b=JOaNQH8JqaGct0MxgFm3JyiQ8mNn6ZvVJTPqkSvECiz7nWXGIvbMYPWqoNjkdVrQV2oP
	 OG/qRdBWZKxD9kGvivUlqY4L5GTk2HEmbErqw6g1Om7UqFJrw4NdJ9s8uhr4gB5MPta3u
	 0+he566lTNJZid6kE/6KYPs1kCAMPb2EVQMwmYqjT/BLpCAGx6Xd52oAGhs1rtJSQWvka
	 s2sH7FDAGe1RKeah+ZL3OM506SxUlYKHpQ5/x8EbRNDB2yeP2USi35BjQ2GkZY89SWha0
	 tuqUkWyDPX8pVU3u8+zcBZ6iwT+H4wyT2AhmcXgx/vi4buELhBMV4L50gCBKfsvx+mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790690652;
	bh=J0U2ZuPppH2NjwbCIrXn37RZhk/7ihyg4JkkDJeReJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1yjfcrV5XjE6kKgf9LZFyJp714Vzxc6PsdCjjyEZrhUE8VwyTMwtTd4Y0dL3+vDPm
	 miZ9S3lSpl2oMdVyAot42o1zU/cacZmDtBY3hX37FZ+3NWw7Bygygm9yzQCFAN465z
	 uvX7U3FCiKEILRmr4Qfrin+pDdSMyyRWIxCh23HgNMkbLdiz7Ng7+4VzZNgcJugZhR
	 Q8xhRN7mh0pi5nr3dZ583zLLj4fHqiwRNqI23IgzlVxI0GCmpipFliJ5oZKnOcZaxc
	 3+8w0Mf2B+diL08qfx0PEXZ/EPPAKUkIYLBDWqwjl4D0DkJqtxgPrcpVrXk7jNnqpp
	 kmPq+g+sHqhfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8B50404F4;
	Tue, 29 Sep 2026 14:04:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78EF734E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AB6D40304
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZAqVLVX3YSCN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 14:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 59008402E6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790690650;
 b=PZRXbShCOL0ohbQRJiqtKbhSIK1H77B1sIfORC0E7vqgN0FsFvc5tYiOoPtpNKKvMxZm
 VPEC+OSqC6wCxr9PH2SP+m/9cU+RAlKWvl3paAO4H33/AnLkid+Ku4TCw1dMBsZfzDgDq
 adwi4PNoneJG6XUjDjKuYWGTeIRekl3EUusfymTYxUceYZvIHer6yzEPg6hhYy+OD2Pt+
 ypAkLHb4FHVldqE+IsFt3TfaKjoDFPEwcT7pwXf7Z16VUP5NsYU+XpCk7GLSbZ4zSy9Hk
 pKi0AcBJu/OsKhcWOKtu1G9G2OdHaYEj+PoFTo0QHJU4pGbHSwnaKrMv+B46bxl2ioQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790690650;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=J0U2ZuPppH2NjwbCIrXn37RZhk/7ihyg4JkkDJeReJA=;
 b=n3BajuCHRg2oy93fSLuqdpCw4TBPBTdnJCsmeKE8qAPOT8c1DFrNyA3xAu7dcgRWtWkM
 LoI2IDLLCusF7rHzh78+7GITuwDnPDu/UTbwhA4BWNosja5Gc8s/seLvI4eI02mWsziJk
 XdAodcoGfxtOE+ATkJGYNmFPlSjZ+l6t+7ZAsiL+0hQM0WkMoMDBfBJbZ/+dupJTH/WTv
 o5AGpF2EBbqjt6aL4Fb18qrDvlMiPwphaDwZ6FUNXtiJfgNb//q7Vq1yDWPY2LvjIzeSc
 UPDHVYDwU6W8Gbkqhkc4RWu4Lmp30XKrCwV0f8I+pEvDTvzkd05oPoKJRqeLgLBootA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OuBSky+q; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OuBSky+q
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59008402E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79141436F6;
 Tue, 29 Sep 2026 14:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE91D1F00893;
 Tue, 29 Sep 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690649;
 bh=J0U2ZuPppH2NjwbCIrXn37RZhk/7ihyg4JkkDJeReJA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OuBSky+qok/H9Ha6B6ps/9C1pxy8XJmntR7w+IlGRHZ4JmdxXdQCs6OOaPoSLctCI
 bLSe0JwAla99ICfXUNolYiRUj7qQNqbmb5+QETwA/HRRwo77pgpk9wwFaxgT0Ye5kK
 gUj6M6PygOvOYaCK5PODVpQmr1SJPHwFiERuoxLLziEAb4mN5ZEoqFSTBlN3tDl1fc
 5ohH7rsqEcXH/lrWYRwkfcwuLlWl2djQPLLPvaclZxBF+/9JXDUH4lFhlmA0ZRcPHm
 tAkjs8Oa2DjlvSOpS9H5iniMytnNjBQqZ56hEaLUCO8r84E4irM5+ToKBsKCKKXMPu
 y0buMK0gk20MA==
Subject: Re: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:08 +0000
Message-ID: <179069064842.434549.3321384376885392964@kernel.org>
In-Reply-To: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates what the change does and the patch
  has no Fixes: tag.

Pre-existing issues:
- [Critical] Heap out-of-bounds write in ice_vsi_alloc_ring_stats()
  (drivers/net/ethernet/intel/ice/ice_lib.c).
- [Medium] The shrink loops in ice_vsi_realloc_stat_arrays()
  (drivers/net/ethernet/intel/ice/ice_lib.c) still use…

--

ice: extract __ice_vsi_free_stats()

This commit records the length of each ring stats array in struct
ice_vsi_stats and moves the VSI-independent body of ice_vsi_free_stats()
into __ice_vsi_free_stats(). The loops that free the entries now stop at
the recorded length instead of vsi->alloc_txq/alloc_rxq.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 31af378aa0e7a..1414127d32cd8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -330,6 +330,32 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
>  	vsi->rxq_map = NULL;
>  }
>  
> +/* free single stats memory */
> +static void __ice_vsi_free_stats(struct ice_vsi_stats *vsi_stat, bool free_entries)
> +{
> +	if (!vsi_stat)
> +		return;
> +
> +	if (free_entries) {
> +		for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {

[Severity: Low]

The old loop in ice_vsi_free_stats() used ice_for_each_alloc_txq(), so it
stopped at vsi->alloc_txq. This one stops at the recorded array length.
Could the old mismatch actually happen?

It looks reachable through ethtool -L with fewer Tx and more Rx queues:

ice_vsi_recfg_qs()
  ice_vsi_rebuild()
    ice_vsi_realloc_stat_arrays()
      krealloc_array(tx_ring_stats, req_txq, ...)   /* shrink succeeds */
      krealloc_array(rx_ring_stats, req_rxq, ...)   /* grow fails */
      return -ENOMEM;
    goto unlock;                                    /* skips ice_vsi_cfg_def() */

After that, vsi->alloc_txq still has the old, larger value. Later,
ice_vsi_free()->ice_vsi_free_stats() walked tx_ring_stats[] past the end of
the shrunken kmalloc object. Any non-NULL word it found there, for example
SLUB redzone poison under slub_debug, was passed to kfree_rcu().

So this patch appears to fix a heap out-of-bounds read and an invalid
kfree_rcu(). The commit message only says:

  The free path now stops at the recorded length instead of the VSI queue
  count, so it follows the real allocation rather than a number that can
  disagree with it.

Could the message describe the memory-safety effect? Should the patch also
carry a Fixes: tag?

The last patch in the series, "ice: size ring stats arrays from the final
queue count", has Fixes: 288ecf491b16 for the same class of bug and depends
on this one. A stable backport would probably pull this patch in anyway.

> +			if (vsi_stat->tx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> +			}
> +		}

[ ... ]

> @@ -539,11 +545,13 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
>  		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
>  	if (!vsi_stat->tx_ring_stats)
>  		goto err_alloc_tx;
> +	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;

[Severity: Critical]

This is a pre-existing issue, not introduced by this patch. The length is
only set when the container is new. Earlier in ice_vsi_alloc_stat_arrays()
there is an early return:

	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;

ice_vsi_alloc_ring_stats() fills the arrays up to the queue count and never
checks the recorded length:

	ice_for_each_alloc_txq(vsi, i) {
		...
		ring_stats = tx_ring_stats[i];
		if (!ring_stats) {
			...
			WRITE_ONCE(tx_ring_stats[i], ring_stats);
		}
		...
	}

On the VF reset path a guest can raise the queue count while the arrays
keep their old length:

ice_vc_request_qs_msg()
  ice_reset_vf()
    ice_vf_reconfig_vsi()
      ice_vsi_decfg()
      ice_vsi_cfg()
        ice_vsi_cfg_def()
          ice_vsi_alloc_def()
            ice_vsi_set_num_qs()      /* raises alloc_txq/alloc_rxq */
          ice_vsi_alloc_stat_arrays() /* early return, arrays not resized */
          ice_vsi_alloc_ring_stats()  /* reads/writes past tx_ring_stats[] */

The PF rebuild path has the same mismatch. ice_vsi_realloc_stat_arrays()
sizes the arrays from req_txq or the old alloc_txq before the count is
recomputed.

Can this write kernel pointers past the kmalloc object? After this patch
those pointers would also leak, because __ice_vsi_free_stats() stops at
tx_ring_stats_len.

The commit message says sizing is not authoritative yet. The last patch in
the series, "ice: size ring stats arrays from the final queue count", fixes
this: ice_vsi_alloc_stat_arrays() compares the recorded lengths with
vsi->alloc_txq/alloc_rxq and grows the arrays before
ice_vsi_alloc_ring_stats() runs.

>  
>  	vsi_stat->rx_ring_stats =
>  		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
>  	if (!vsi_stat->rx_ring_stats)
>  		goto err_alloc_rx;
> +	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
>  
>  	pf->vsi_stats[vsi->idx] = vsi_stat;
>  
> @@ -3055,6 +3063,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  		vsi_stat->tx_ring_stats = tx_ring_stats;
>  		return -ENOMEM;
>  	}
> +	vsi_stat->tx_ring_stats_len = req_txq;

[Severity: Medium]

This isn't a bug introduced by this patch. The shrink loops earlier in
ice_vsi_realloc_stat_arrays() still take their upper bound from the queue
count, not from the new length:

	u16 prev_txq = vsi->alloc_txq;
	...
	if (req_txq < prev_txq) {
		for (i = req_txq; i < prev_txq; i++) {
			if (vsi_stat->tx_ring_stats[i]) {
				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);

Tx is committed here, before the Rx krealloc_array(). If that allocation
fails, ice_vsi_rebuild() exits through "goto unlock" before ice_vsi_cfg_def()
runs, so vsi->alloc_txq stays larger than tx_ring_stats_len.

On the next rebuild, does this loop read tx_ring_stats[] past the end of the
array? It would also call kfree_rcu() on whatever it finds there.

In the opposite case, len larger than alloc_txq, krealloc_array() seems to
drop the entries in [alloc_txq, len) without freeing them.

Later in the series, "ice: rebuild ring stats arrays instead of reallocating
them in place" removes ice_vsi_realloc_stat_arrays(). Its replacement,
ice_vsi_free_unused_stat_arrays(), frees surplus entries only up to
tx_ring_stats_len/rx_ring_stats_len. It also allocates a fresh container up
front, so the partial-failure state can no longer happen.

>  
>  	if (req_rxq < prev_rxq) {
>  		for (i = req_rxq; i < prev_rxq; i++) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
