Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B5CCA9EDC
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 13:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 659F260607;
	Mon, 12 Oct 2026 13:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYCPpPR51a-v; Mon, 12 Oct 2026 13:50:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9545360664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813038;
	b=KLhprhWwnVfKKujOCmeQyNewY7o9B9WZeSJDXRkjHYHrQHvLtbifC3k48wrST8JObmHA
	 z2ZqrLO99k9Y3h53ETS+ElG0eeoaxYZt803y8dG5caU7KeeuaTLpKvzDChzOi6TMNbJFs
	 tRK0AYc6GJ71hBxtdsToPL8fRqJztl0sf7r1dV9jB5KLNfB3xsc+BMqs7/Fe1GOqoMl2o
	 S3X1AoubvF51U5KogQm5dCGvmuRiEBuZSIHkpUqGt41NqXrMXQuixKOalDKm39VLMWoTm
	 c+XUm4ootnjzoNHwrao9CcEjnEEQ5SErYp+G7BiNgOQhx5yLsK3KbXsWSeXIyTHS6Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=hFs/SXt24zlK/+sB8Zj0xSiblsAd+3hA81VJFjNd/Xs=;
	b=fGQrmwytEJv3qBGu9I6JEtUPYMn6iJCUjhCjk/ZsTG/zhYGoCGsk/pSN083zakDRBEaZ
	 zMyJof5mY+Ed35dqLTBcRjlP4L9sxgmWBD4G1U/1BNoFyGMa7v23iXP8nKH5ib+psbLuW
	 g1nQA+TwXZvsmevD3vchh6Gd5rHSaJxlfJZ1rf4KVgYijMDxrnb/j3qV+az7/ZlVEUyZj
	 0oSCiz1JRIx/BDXH9fUEFMSWJ2c0oQz4Frk0apWww/4PBDBDNy1yu7hscNY3CY4XB7EZG
	 ese/9lmxr5dJIM2J6oAgnycdeLC+RUSlplc7Ck/xk9kAGoobiOhi24EYn4pvdILBFSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlqvqqHO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791813038;
	bh=hFs/SXt24zlK/+sB8Zj0xSiblsAd+3hA81VJFjNd/Xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fX7r6bTPgbraW6tf+DhlMYTwTDKk5FYPAOv2/ExXZYeINpbgjeHUyXcBdyKIMAGTd
	 pCcqvTUhsvvowalohfcjPq1kgtxon9K6k0Z4Y69trgrAN4XZy4W7t1bbpS8QMVE9b9
	 WoNjpuKifXJl0uGIjgBOztLLng3QXkqP0H35U5aEuOUaOkp+WKlNqt+NQEa5kbwz9R
	 YAQ0eQBILLInGGMT91NlUG4QpVisTo/7bMAfsll7BR3aUNXLFKp/1wAofk/6y7uBOz
	 RrYMy24CbC1BTyNGsGZOBWDCiA0r4bJyYFy5vKGwREjR+mSh1Y6hUsZm4L9QwjrGaM
	 BMS7vxZwoZHrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9545360664;
	Mon, 12 Oct 2026 13:50:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA79E2E0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 909A760607
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpfblhqWGtkV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 13:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3C19605ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813035;
 b=r0CdMs+8ZMfn0jsvznaD2OwvdDFDeSrKdYllggqFRyrf2vhZqdCG2i9ufX/WLqC+Lwbj
 PfeuqaV+byGO2T5Ei/A/yWkKxj0QHZbHk+GOkFibwU/89gu2cPLi/lCLHhFCp9wFbue1t
 i4CZVzIUDvj6bAMQX7i/v8dHbC+gn0GbuCN1FTOtxVybQNGaFeb66S+N/kgrHDM1Y7YSG
 LquO1XX4yWbqzSmV3vwMUX4eot9lktt7ztPcjoRdkHJhlmbFL71sYe6qwCx/kF7pl//xO
 WtmtWF2e6BODwwj2N7X5QlOo9ktasPnuLCzKqE9f005tgY53pDCuJESuAU+aaitRkZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813035;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=hFs/SXt24zlK/+sB8Zj0xSiblsAd+3hA81VJFjNd/Xs=;
 b=CMrEyX3Zxw6chAWHI/Z1E/YrLLNo7K4YZTAtDVZKPcLCTQM+G4uHAKxwcAEEYb0gELrG
 Po4vlUFhOtPjgw+EZh5t1z2syl4dtjlbsGw0zA+i5d+A415eP4rQqccj9qeaKFHRHzYYd
 afRE0EHwqcrUb5v98QXwktJ39dxiWDyYEHlOW79qdY1q7nmrmu7tUf+iQ+ik+J3ExuUbc
 QBS9tLowTek0BCzHEvPkYlQowJdqJpSPBh+NF3ipyiUVOaiGcnlOyl1TYGa6L7BajBqeb
 0wLDt1g3SFR8NUjShJJDn304aw1POzYuxi3/fr1O+4qVH5WY60Ahp9vHFijc0Q+tTVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jlqvqqHO; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jlqvqqHO
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3C19605ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:50:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9148260AA2;
 Mon, 12 Oct 2026 13:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF7B1F0089B;
 Mon, 12 Oct 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791813033;
 bh=hFs/SXt24zlK/+sB8Zj0xSiblsAd+3hA81VJFjNd/Xs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jlqvqqHO8xxu9mC3VI2YgCYddhYFdEM9Ro0txOLZ3R4LPMU1ZnDp5uM9vhkQ0XpJB
 lTQjEAJ+of1Ppw69N7z9dnY2qxPdah9YgvWx3CkHQ+IvwPYsGYzZAGtty9ZdbfSxuV
 80WaFUINdQMtbenVgTZCja5vVrNQsLvulzdyYoB4RJ8iZqmdZatsE3S+tM/tWuWoZN
 KO0dVGQ3Vrv9xXN6wjFSjWn0ckcrlcXrF5GcJ5bPvkqkEkw2wxL0H/HGVRCrl/d1nW
 N02CUnj1zdNsx6eBzp1oE8uX+DGp6OAyYTVidaMHPnHze/nvKqSTbfUlBtodTh5qAs
 czZpxA5dmlpOA==
Message-ID: <sashiko-outbox-168217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v6 1/2] i40e: move ATR sample rate from ring to
 PF level
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261011134952.54887-2-mheib@redhat.com>
References: <20261011134952.54887-1-mheib@redhat.com>
 <20261011134952.54887-2-mheib@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:50:32 +0000
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
- [Medium] i40e: combined reset flags downgrade reset level to weaker PF_RE=
SET
--

commit 6e65935fd380dc5da870cee78bd93449fc30b74c
Author: Mohammad Heib <mheib@redhat.com>

i40e: move ATR sample rate from ring to PF level

This commit moves the ATR sample rate from the per-ring struct to the
PF struct, initializing it once during software initialization. It also
triggers a PF reset when re-enabling ATR so that the TX queue HW context
is appropriately reprogrammed.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net=
/ethernet/intel/i40e/i40e_ethtool.c
> index 0ae50d7f34651..bc9b4a2bc23b2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
[ ... ]
>  	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
>  		reset_needed =3D I40E_PF_RESET_AND_REBUILD_FLAG;
> =20
>  	if (test_bit(I40E_FLAG_VEB_STATS_ENA, changed_flags) ||
>  	    test_bit(I40E_FLAG_LEGACY_RX_ENA, changed_flags) ||
>  	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
>  		reset_needed =3D BIT(__I40E_PF_RESET_REQUESTED);

[Severity: Medium]
This problem wasn't introduced by this patch, but does this unconditionally
overwrite reset_needed? If I40E_FLAG_FW_LLDP_DIS is also in changed_flags,
it looks like the I40E_PF_RESET_AND_REBUILD_FLAG will be silently dropped.

> =20
> +	/* Re-enabling ATR requires a reset to reprogram fd_ena in the
> +	 * TX queue HW context. Skip when FD_SB (ntuple) is already
> +	 * enabled, since i40e_configure_tx_ring() sets fd_ena when
> +	 * either FD flag is active.
> +	 */
> +	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> +	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags) &&
> +	    !test_bit(I40E_FLAG_FD_SB_ENA, new_flags))
> +		reset_needed |=3D BIT(__I40E_PF_RESET_REQUESTED);

[Severity: Medium]
If changed_flags contains multiple flags (for instance FW_LLDP_DIS and
FD_ATR_ENA simultaneously via ethtool), this bitwise OR operation can cause
reset_needed to contain both I40E_PF_RESET_AND_REBUILD_FLAG and
BIT(__I40E_PF_RESET_REQUESTED).

When both flags are set, does this cause the weaker reset to be executed?
Looking at i40e_do_reset() in i40e_main.c, there is a cascade that checks
the weaker flag before I40E_PF_RESET_AND_REBUILD_FLAG:

    } else if (reset_flags & I40E_PF_RESET_FLAG) {
        ...
        dev_dbg(&pf->pdev->dev, "PFR requested\n");
        i40e_handle_reset_warning(pf, lock_acquired);

    } else if (reset_flags & I40E_PF_RESET_AND_REBUILD_FLAG) {

This means the requested rebuild from I40E_PF_RESET_AND_REBUILD_FLAG would
be skipped.

Also, looking at i40e_handle_reset_warning(), it appears to synchronously c=
all
i40e_reset_and_rebuild() with reinit set to false, instead of deferring it =
via
__I40E_RESET_INTR_RECEIVED:

static void i40e_handle_reset_warning(struct i40e_pf *pf, bool lock_acquire=
d)
{
        i40e_prep_for_reset(pf);
        i40e_reset_and_rebuild(pf, false, lock_acquired);
}

Can this lead to the VSI reinitialization being incorrectly skipped when
both flags are present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011134952.5488=
7-1-mheib@redhat.com?part=3D1
