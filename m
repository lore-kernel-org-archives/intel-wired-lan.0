Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06984CA5FB1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF4DE4074C;
	Tue, 29 Sep 2026 14:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBFNVVrf8_sL; Tue, 29 Sep 2026 14:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F3F6440742
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790690656;
	b=g0kv3e82EdxidglRwAUr3LGVcgwMIJauQ/3K+MWywM6U86SacAaZUgF4WueVsrdVr0k9
	 4ghTgKMXUCgg+M2zU7bUrYQ52YP29to5+mrW0mDM6RN4czqBQ0k5qGtjyZtJ68fCvYWFf
	 esp0KHFrsfNa1v/2IwIC/E+WJrhW98k9xiyM0Q/LfjwkMhvSqAajCX5yu2PUETspsWiBH
	 sA03h1nU3YGZAZfCUBWzkT8pQHXhorhK8ZZC+cJtaP+0HSDj++6xGdly3IUwt7ef2BHvi
	 ZaE7ofkXQu5ak3RNYPrA3P5Ez5CR3xPucuWxXcvtco0dITyzzskMJDm808AR3yrSVzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790690656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D16o6hKHn7v79Ca/ZAOe4MZM67um+3K6SWmZxwtIw9I=;
	b=LuzKT31JxKFccBgxh2KT5QDzAS7tHV/6BZzBHXfE5AulT+BESihSSdT49fCEK1ZZ6H52
	 Wj2KIVnpmlohfgokdt3zuFhimOAarKNwpZw4R2R90KON2YzTQGZ8T+EAkpJgaCDS7N9d9
	 8JsF0Vu4a+zmEDOReAQkOuCiKYGIdN6uqi3e9NIn7nDV23BX/3onWJNQwzpEMCr3uYb1J
	 uaXx88TGSNYLRfsQV8z+rfHcgsJSak1bySjNrytTWh1O7yEdCUQSpBZfYzL6a2FRYOhSO
	 4RUka7wheCQuLlR3wKKgroNipgFGNJmzz/0SXXLyxJcrvHjx8UJs0qNOsC3Q3MeMWHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790690656;
	bh=D16o6hKHn7v79Ca/ZAOe4MZM67um+3K6SWmZxwtIw9I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cR5ODgUt9bqpT1t3d2JCtCPrB6FR4XGkq5OQF29jG3lwNcs3psYrTmBZW6zSKh3iF
	 G8pqApcYnkDBx0eoaGiKasAmzZkhbpCc0RXHolxxrkU3YYM/lKMdetJKuMqiExRg+A
	 Cj5Og7FFLI8CS6T0aTD0UAWy9Zz5pnwlzNbh8Ix+CDUXNOXv7B5M9r+8/uOssjUPYd
	 oz6qesXsrgIpu4+h8lZXNM6bz6VFO+c0uQN5mKhlsCF8Zt9z88MfRa31U+6dmx/qtH
	 mTG6cpMD/6HKULwAvekEq6fmHk4mGt6gNTATPCZBLlirSMOvXZlwZvO1YNuz5wpy3r
	 5KIOz+n3F7lPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3F6440742;
	Tue, 29 Sep 2026 14:04:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BFA55D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B17FC607A5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oes9sAZfGDnQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 612BE60782
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790690653;
 b=N1IDspUFoYDM/puhygD+z93oEtzv8LpQwCm+MhR1AZlSTtz2nGeZT8Ye5z07qYTrBI95
 RHlu2A6Aj1/rm2sC+pehI4Y2T+bQ+b+u3BqycPVCiDVL1AtQdVjSlF2WqrP4ve8k1wo3P
 Ph+WrBoPxTAZoPCCtImlxc5DOvgCOSN28PY8Ltkjrrm4xDNiUTeVpqKg+NbjmHA+Q8nGx
 M9QNbJU+kKFKcdK0LnvjkrTzRYEaqtECrCS4YS+l2xq3Qcwtgpb1MOCi6yNz5H9S+NOVU
 vMP+ftra29SnF2CkEeiO9pNdl3mSAVYOCw/zaGcBVgRqDHvcjkm8fvvtyG/H4BCoh5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790690653;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=D16o6hKHn7v79Ca/ZAOe4MZM67um+3K6SWmZxwtIw9I=;
 b=gRUn2shzlfoV9DUB8SkjW6OLwE/loJetKhn5IaL61cGIVsNHX+hhGBFo+fF5MG9sW+Q6
 95IQ60vHQVLIFe8V3i6rgmaijIk1BoUH4mN4O/z5sauKqez83Od27Z/jg9L+58XJvszRq
 7/VNn/TIVzHu+GQ5+t8CyQQcv/KyKqE0ZPPwFIFtJ+2E3KphpnoSGKS6nGvgPmWF3TMYm
 LrDZOOr2qMjh5dv5jNzXWrV67bBX+wKDtr8/o+jxJsfvNCacKGWGqgP0AjqMkXF3okBzQ
 ZMSu1B/J0dG7eHCCnoZ7+6jdPu4IY2iZ22GtsUqQfojVoJmf+NHGLlsIfYgxnyn6BDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Z/Gw/s60"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Z/Gw/s60
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 612BE60782
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14B3D60210;
 Tue, 29 Sep 2026 14:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302351F00893;
 Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690651;
 bh=D16o6hKHn7v79Ca/ZAOe4MZM67um+3K6SWmZxwtIw9I=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Z/Gw/s60spPB1rKZzXoQ0NrKoIt8ipbmVnqZc8A081zQud7EbcZqn9IN9X+4jJ5Lf
 rAOWmzUHVyw7LU4pbzcPvloFdl9nEIEqhJSnBfHltaLxcCoFmubiwt1OUCMUasaEc3
 VvXFw8qf/wESgqUuI9GTsMUHZCVqVWctISvlAMTpcWqrE7BtK1xd94fe0k4J4JeuXS
 ZcbUZxeCEkB59iWw6JtPSfMp0ot4TTywuoNb62rx1xR73BuI9xH183bK71OM1rzw03
 qEV4mU+Uy/yJEW5rVMcwuwlKw5yL8oMLctRB5xPapnq48Bh9k/kPfoYwrl7Y7Hx77n
 aCs0BOhLoCNYA==
Subject: Re: [PATCH net v5 6/6] ice: size ring stats arrays from the final
 queue count
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:10 +0000
Message-ID: <179069065074.434549.14633015707889876251@kernel.org>
In-Reply-To: <20260925132636.123300-7-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-7-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says ice_vsi_alloc_stat_arrays() becomes
  "the only authority" on the size of the ring stats arrays.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  ice_vsi_rebuild() calls ice_vsi_resize_stat_arrays() before…
- [Medium] This problem wasn't introduced by this patch, but in
  ice_vsi_cfg_def(), if ice_vsi_alloc_ring_stats() fails after…

--

ice: size ring stats arrays from the final queue count

This patch changes ice_vsi_alloc_stat_arrays() so it no longer returns early
whenever a stats container already exists. It now checks the existing ring
stats arrays against the final vsi->alloc_txq / vsi->alloc_rxq, and grows
them with ice_vsi_install_stat_arrays() when they are too short. This fixes
out-of-bounds accesses in ice_vsi_alloc_ring_stats() that are reachable
through devlink reinit after CPU hotplug and through VF queue count requests.

Closes: https://redhat.atlassian.net/browse/RHEL-164321

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 448d3c7780adf..c393d913d0379 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -634,10 +634,15 @@ static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
>  /**
>   * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
>   * @vsi: VSI pointer
> + *
> + * Runs after ice_vsi_set_num_qs(), so this is the first point where the queue
> + * count is final. Grow the arrays if an earlier sizing guessed too low.
> + *
> + * Return: 0 on success, negative error code otherwise.
>   */

[ ... ]

> @@ -645,16 +650,13 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
>  	if (!pf->vsi_stats)
>  		return -ENOENT;
>  
> -	if (pf->vsi_stats[vsi->idx])
> -	/* realloc will happen in rebuild path */
> +	old_stat = pf->vsi_stats[vsi->idx];
> +	if (old_stat && old_stat->tx_ring_stats_len >= vsi->alloc_txq &&
> +	    old_stat->rx_ring_stats_len >= vsi->alloc_rxq)
>  		return 0;

[Severity: Medium]
The commit message says:

  "Make it the only authority: keep the existing arrays when they are
  already long enough, and otherwise grow them with
  ice_vsi_install_stat_arrays()"

Is ice_vsi_alloc_stat_arrays() really the only authority after this patch?
ice_vsi_rebuild() still sizes the arrays before ice_vsi_decfg():

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_rebuild() {
    ...
	ret = ice_vsi_resize_stat_arrays(vsi);
	if (ret)
		goto unlock;

	ice_vsi_decfg(vsi);
	ret = ice_vsi_cfg_def(vsi);
    ...
}

ice_vsi_resize_stat_arrays() can still grow or shrink the arrays to the
pre-decfg estimate:

	qs = ice_vsi_get_num_qs(vsi, vsi->alloc_txq + vsi->num_xdp_txq,
				vsi->alloc_rxq);

	return ice_vsi_install_stat_arrays(vsi, qs.alloc_txq, qs.alloc_rxq);

So every rebuild still has two sizing points. The order is resize, then
decfg, then cfg_def, then alloc_stat_arrays.

Two comments also still describe the old guarantee. The kernel-doc of
ice_vsi_resize_stat_arrays() says:

 * Call while @vsi still owns its queues and before ice_vsi_decfg() returns them
 * to the PF pool, so that the new size is what ice_vsi_set_num_qs() will compute
 * afterwards.

The comment above ice_vsi_get_num_qs() says:

/* @held_txq, @held_rxq: queues the VSI still owns but is about to return to the
 * PF pool, so that the result matches what it will be once they are back there.
 */

Both conflict with the new kernel-doc here ("an earlier sizing guessed too
low") and with the commit message ("It cannot get the size right"). Should
those comments be updated, or should ice_vsi_resize_stat_arrays() go away?

There may also be a functional side effect. Suppose the estimate is below
the current length. Then ice_vsi_install_stat_arrays() calls
ice_vsi_free_unused_stat_arrays(), which runs kfree_rcu() on the accumulated
ring_stats in [estimate, prev_len).

If ice_vsi_set_num_qs() then computes a larger count, the grow here leaves
the new slots NULL, and ice_vsi_alloc_ring_stats() fills them with zeroed
ring_stats. Doesn't that lose the counters for those rings, which
288ecf491b16 ("ice: Accumulate ring statistics over reset") is meant to
keep?

This needs netif_get_num_default_rss_queues() to change between the two
sizing points, for example CPU hotplug during a rebuild. The sriov_numvfs
race described in the commit message only makes the resize grow too little,
because held_txq already covers the VSI's own queues. The out-of-bounds
access itself does look fixed.

> -	vsi_stat = ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi->alloc_rxq);
> -	if (!vsi_stat)
> -		return -ENOMEM;
> -
> -	pf->vsi_stats[vsi->idx] = vsi_stat;
> -	return 0;
> +	return ice_vsi_install_stat_arrays(vsi, vsi->alloc_txq,
> +					   vsi->alloc_rxq);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the new slots left by this
grow are NULL, so ice_vsi_alloc_ring_stats() has to allocate them. If that
allocation fails in ice_vsi_cfg_def(), the code jumps to unroll_vector_base
after ice_vsi_alloc_rings() has already succeeded:

		ret = ice_vsi_alloc_rings(vsi);
		if (ret)
			goto unroll_vector_base;

		ret = ice_vsi_alloc_ring_stats(vsi);
		if (ret)
			goto unroll_vector_base;

The unwind is:

unroll_vector_base:
	/* reclaim SW interrupts back to the common pool */
unroll_alloc_q_vector:
	ice_vsi_free_q_vectors(vsi);
unroll_vsi_init:
	ice_vsi_delete_from_hw(vsi);
unroll_get_qs:
	ice_vsi_put_qs(vsi);
unroll_vsi_alloc_stat:
	ice_vsi_free_stats(vsi);
unroll_vsi_alloc:
	ice_vsi_free_arrays(vsi);

Nothing in it calls ice_vsi_clear_rings(). ice_free_q_vector() only clears
tx_ring->q_vector / rx_ring->q_vector. ice_vsi_free_arrays() devm_kfree()s
vsi->tx_rings / vsi->rx_rings and sets them to NULL.

Does this leak every ice_tx_ring and ice_rx_ring that ice_vsi_alloc_rings()
allocated?

The VF and LB cases take the same label when ice_vsi_alloc_ring_stats()
fails. The PF case also takes it when the XDP setup fails. This path could
be reached just as easily before this patch, both on first configuration and
after the rebuild-path grow.

[Severity: Medium]
This is a pre-existing issue, but it is on the other install path, the one
through ice_vsi_resize_stat_arrays(). When the estimate is smaller than the
current length, ice_vsi_free_unused_stat_arrays() frees the entries and
clears only the array slot:

	for (int i = new_txq; i < prev_txq; i++) {
		if (vsi_stat->tx_ring_stats[i]) {
			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
		}
	}

vsi->tx_rings[i]->ring_stats and vsi->rx_rings[i]->ring_stats keep pointing
at those objects until ice_vsi_decfg()->ice_vsi_clear_rings() runs. In
ice_vsi_rebuild(), that happens after ice_vsi_resize_stat_arrays(). Doesn't
this mean the objects are handed to kfree_rcu() while they are still
reachable?

Suppose an RCU reader starts after the kfree_rcu() and before
ice_vsi_clear_rings(). Examples are __ice_get_ethtool_stats():

		tx_ring = READ_ONCE(vsi->tx_rings[j]);
		if (!tx_ring || !tx_ring->ring_stats) {

and ice_update_vsi_ring_stats(). Could such a reader see a freed
ice_ring_stats?

In practice these readers look gated:

- by rtnl, for ethtool and for the ethtool -L and mqprio callers of
  ice_vsi_rebuild()
- by netif_device_detach() in ice_prepare_for_reset()
- by the ICE_VSI_DOWN checks in ice_get_stats64() and
  ice_update_vsi_stats()

So only a reader that got past those gates before the rebuild started, and
then stalled across it, could hit the freed entry.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
