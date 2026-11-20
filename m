Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174660A382E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=aESNuh1b;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK5qZwSp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 422796066C;
	Fri, 20 Nov 2026 15:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7XlNwESdlCu; Fri, 20 Nov 2026 15:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7322D606CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795187637;
	b=e+bi5AVjsng1OpWaVlksWlcA53k+mngixNJRZRX2bojmlmdFJ69ZFuQjaxIIRdV/noSX
	 /aDKAt0Kj1gVl3EQT5wUM9xm7WJWmV8cmx/l8zcn8r/JlKw/BPfyyJxDwxqg03XKft1YM
	 BSC2TEuW4ukv+helyI0USpzGLVrHuppJjLXpKSvOHiGuJOFMf4GY5xLBOlbwRdliOnpZM
	 yLuSZDE9Q6G+D8mw24o9vxQnrHr/ekDsPdNQ+j7E3qXBtHnq9lq3kUnleK9tKual/FKSZ
	 /c0IM3XOl7+tKEdX+aZR1wp3cKCynf9pd/4hXURTiUhFTCgyzK66LWGTTe3DNINmthQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795187637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=uR92nwhz4nZ+WiyBDnj/UdM8+GDOmj77b0H6bZXVnaM=;
	b=E3G9g0zMY1T7Yh5UEe6/eZz04QitZRWYzs7mbB5Qecj09JmOZkfnxmR9by0o5njMK/+1
	 miRbFqAM1luNo2OHSc4i3NUm2s42IMgWUrXqaWbs6lwPPV34qyeTorC2FgDtWBXC+imeY
	 VZREDw+ToxzV56MgN18rVS3TyGq0nH27Mc/TsS3gET/yd/L9yu5ZrxSl9TScnStG7L2/M
	 rocgEDSogbe/Pcy+5U7rU9lHtJlGjOWS4IdqrmRnt3utiVGv7JCGGE3gb9YHoNNjGwWJ7
	 1jhyhWTdDgS0Ne4y37+/vm7Z8bGuTEbHF+n0d5S7A525uIUJZR1/sud8PZBruamnCqA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK5qZwSp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795187637;
	bh=uR92nwhz4nZ+WiyBDnj/UdM8+GDOmj77b0H6bZXVnaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aESNuh1bmCQgtCoPm8G62qSMmKpHuNdk+iIHQacXFpqOt7mDnvuQ+uc6X5slPC2rD
	 +BoN5unv31LHTZcnKwL4K6ikjzxWu21dO41Slm7/IKHCRqis3FNC6mpTlRLONoUOyc
	 9S3cDVrB91feqCohtipYQsua99kUMdZSvPzVrWuvuBTKXcM2kRuT6GmGxWTjrwDkuh
	 i3HYvuR+kbJjn6AhveP7og3F9F6QKvR+I3U50j+YkK2asCySVWl88DAOakLBKcUnWB
	 eD/WHllU5jKMw4hzh5t38+UV5dg5Q0MlIA/OndFXF+CNGB0Qxf/UwpOoJQbIXDATkD
	 qKv8KDDxxRqjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7322D606CE;
	Fri, 20 Nov 2026 15:13:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A452E52
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76C6A6066C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQAUjBcfBSRU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 15:13:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0031606D5
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AK5qZwSp
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0031606D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:13:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45CF240BA1;
 Fri, 20 Nov 2026 15:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5B61F000CF;
 Fri, 20 Nov 2026 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795187633;
 bh=uR92nwhz4nZ+WiyBDnj/UdM8+GDOmj77b0H6bZXVnaM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AK5qZwSpMsjpCTfSF6X4xa6mWzV9SZEcM/Vxdr3tK7cY5Z2wnPXf4WR6OBRgBXPxC
 vhl19+TgpWiUOilKsR9pRQmJS8nXbEo+73oADpudLdnfYqGvuNQEOzyBYUZc1KAu9A
 wtDUXuLlTqu3+64SkPtlcimdTPF0p0Nqn3ogCrJS7MyvUk1+qwrQ31R5hAJ0dgykVV
 nrp+1ppwYjElJoyOBTsUCDQm9+rfMwHKkhedtC34AWggabtYOK20RdwKPNxZ15So2R
 bKIFmBtqPTv0wQ/Gt0vmF/byt2JjvkkU3k+zYRhi0AbAjEdQcVaoC9g2BsofByMgmS
 yS3AKT0EObOJA==
Message-ID: <sashiko-outbox-225443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 2/2] ice: wait for one RCU grace period when
 destroying XDP rings
To: "Shitalkumar Gandhi" <shital.gandhi45@gmail.com>,
 intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20261120150527.14649-3-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
 <20261120150527.14649-3-shital.gandhi45@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:13:53 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] ice: use-after-free in ice_vsi_clear_rings() [1]
--

commit 43d9078a23fe9ac7d73bcbe7267574a26a1906b4
Author: Shitalkumar Gandhi <shital.gandhi45@gmail.com>

ice: wait for one RCU grace period when destroying XDP rings

This commit replaces the per-ring synchronize_rcu() in
ice_destroy_xdp_rings() with a single synchronize_net() call before the
ring teardown loop.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 0d823e7f4cdcd..254668d4e3963 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2891,12 +2891,16 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, en=
um ice_xdp_cfg cfg_type)
>  	}
>  	mutex_unlock(&pf->avail_q_mutex);
> =20
> +	/* Let in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls finish before
> +	 * the rings they may be using are freed. The VSI is down at this
> +	 * point, so one grace period is enough for all rings.
> +	 */
> +	synchronize_net();
> +
>  	ice_for_each_xdp_txq(vsi, i)
>  		if (vsi->xdp_rings[i]) {
> -			if (vsi->xdp_rings[i]->desc) {
> -				synchronize_rcu();
> +			if (vsi->xdp_rings[i]->desc)
>  				ice_free_tx_ring(vsi->xdp_rings[i]);
> -			}
>  			kfree_rcu(vsi->xdp_rings[i]->ring_stats, rcu);
>  			vsi->xdp_rings[i]->ring_stats =3D NULL;
>  			kfree_rcu(vsi->xdp_rings[i], rcu);

[Severity: Critical]
This problem wasn't introduced by this patch, but can calling kfree_rcu()
on vsi->xdp_rings[i]->ring_stats and vsi->xdp_rings[i] before clearing
those pointers cause a use-after-free [1]?

An RCU reader entering between kfree_rcu() and the NULL assignment can
still observe the pointer after the grace period for reclaiming it has
already started, so the object can be freed while the reader is using it
(the same ordering also exists in ice_vsi_clear_rings() for vsi->tx_rings
and vsi->rx_rings).

[1] https://sashiko.dev/#/bug/linux-8bb69a7d-5d05-41df-ae26-5fe9622f437d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120150527.1464=
9-1-shital.gandhi45@gmail.com?part=3D2
