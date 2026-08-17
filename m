Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B14AC5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 20:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C86860733;
	Mon, 17 Aug 2026 20:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ia41gDkbljK9; Mon, 17 Aug 2026 20:50:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C73C60604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786999852;
	bh=7tnNg7RnLQQHJOOsDmIUNL3BOwFvIu2KqN4IU1Ml3YM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YqhVDIjpoYoAr0y1QZ78T4cRfS1+qfjxmrNhYNBPYe5jlrjEA2gQ2CJoaB4iOwPv4
	 xLQklXeesBN6qvCn9EnolJM+0F8Mq3wQbIzLOniGmYgyHGqu/QMr8l1T4fyC2kwPwD
	 RpkdKUh9aHu7DfW0JhU/kai5N0Ju7e/DoS5FpLPrlg+JpeEzAVg7mzOcv1lVnwtAV0
	 PGebBEKTMFa8I0sxcWy6ZtwcyvH537Tjvh5730dyRp8I9flfPM7YS9jUrR0IXw2wAo
	 ooW4n087oYRmQr12OxHm07aoP05zNR4KuiY5+XktlVGwQ8u/Btl257R1r/ctemZltB
	 Pjj1asoX9zEgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C73C60604;
	Mon, 17 Aug 2026 20:50:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B4DC6337
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 20:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A9EE4009A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 20:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j2DpD3AK14kt for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Aug 2026 20:50:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B73D540063
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B73D540063
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Pnvct3Pp
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B73D540063
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Aug 2026 20:50:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AD36601DE;
 Mon, 17 Aug 2026 20:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59931F000E9;
 Mon, 17 Aug 2026 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786999849;
 bh=7tnNg7RnLQQHJOOsDmIUNL3BOwFvIu2KqN4IU1Ml3YM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pnvct3PpkJPYwFSsTXFdBRkKhw3eOGeZ/Tc5/97CBLzkX1BDoxcvInGn7YLyEZN+N
 jtiuzw7s+oW+R1KLJ4tKIEglO6af27TBq6e4WU9NUzVg7Y8kwr/WHYf5utAWZjYwF+
 cA7jlfjSvmJbaM6LGqBmbFbEsXWoEa9umJrA8ClFnA1710VaCzLO/xGb94PAsD1Opg
 D6AVNTKb9DaKa50RdSDK4tRexGEEeDnCXYBNHSIsrFru0iyZMAlg9DIpLOx0RGrWe/
 dje8rSjEKy87IbHzcinyFHPE+F0LcFpwBUzKPXmfMqoQlv1vNp/iDoxkEG6CZB7QTc
 CDicC0FAes8MA==
From: Jakub Kicinski <kuba@kernel.org>
To: przemyslaw.kitszel@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 rafal.romanowski@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com, marcin.szycik@linux.intel.com,
 anthony.l.nguyen@intel.com, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Date: Mon, 17 Aug 2026 13:50:47 -0700
Message-ID: <20260817205047.3612990-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
References: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ice: fix stats array
 overflow via proper realloc
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    ice: fix stats array overflow via proper realloc

This patch removes ice_vsi_alloc_stat_arrays() and makes
ice_vsi_realloc_stat_arrays() handle the initial (no vsi_stat) case, tracking
the array sizes in the new tx_ring_stats_len / rx_ring_stats_len fields.  The
single remaining call site is in ice_vsi_cfg_def(), and the call in
ice_vsi_rebuild() is dropped.

Closes: https://redhat.atlassian.net/browse/RHEL-164321

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index e48ee5940f17..420e72df7f5e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -2379,7 +2353,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>  		return ret;
>  
>  	/* allocate memory for Tx/Rx ring stat pointers */
> -	ret = ice_vsi_alloc_stat_arrays(vsi);
> +	ret = ice_vsi_realloc_stat_arrays(vsi);
>  	if (ret)
>  		goto unroll_vsi_alloc;
>  
> @@ -3097,10 +3071,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>  
>  	mutex_lock(&vsi->xdp_state_lock);
>  
> -	ret = ice_vsi_realloc_stat_arrays(vsi);
> -	if (ret)
> -		goto unlock;
> -
>  	ice_vsi_decfg(vsi);
>  	ret = ice_vsi_cfg_def(vsi);
>  	if (ret)

[Severity: Low]
Does moving the ice_vsi_realloc_stat_arrays() call change what happens when
the stat array allocation fails during a rebuild?

Before this patch, ice_vsi_rebuild() did the realloc before
ice_vsi_decfg(), so a krealloc_array() failure returned -ENOMEM with the VSI
still fully configured:

	ret = ice_vsi_realloc_stat_arrays(vsi);
	if (ret)
		goto unlock;

	ice_vsi_decfg(vsi);

Now the only call site is inside ice_vsi_cfg_def(), which runs after
ice_vsi_decfg(), so an -ENOMEM there unwinds via unroll_vsi_alloc and is
propagated out of ice_vsi_rebuild() with the queues, vectors and rings
already released.

For the ethtool -L path that leaves ice_vsi_recfg_qs() in ice_main.c with
only this recovery:

	rebuild_err:
		dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n",
			err);

The same outcome was already reachable pre-patch through the other
allocations in ice_vsi_cfg_def() (ice_vsi_alloc_def(),
ice_vsi_alloc_q_vectors(), ice_vsi_alloc_rings(),
ice_vsi_alloc_ring_stats()), so this adds one more allocation to an
already-destructive region rather than a new failure mode.

The commit message describes the move only as:

    Also drop one callsite to avoid some duplication.

Could it also mention that the previously non-destructive failure path for
this allocation is gone?
-- 
pw-bot: cr
