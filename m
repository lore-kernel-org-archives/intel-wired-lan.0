Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CF3CA5FB1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE836405E9;
	Tue, 29 Sep 2026 14:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcB2fMhLZ2ri; Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF2A9406D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790690653;
	b=FimZJVIcbXMqo5Rt2YYIyZV0jq4pu1BR8Hg2oiZWW00uyqhNirVM/0454WNYVFNTeEcv
	 JU+Ul1Zcod+Sa1KBFzIKQFKuf6Xluc3ZyRSZiXJ4iNY2ZzVwJjyUpHb1aFFoVBAezewFk
	 05X1op3rML/CGbaaRRprCpHNIh93P49QljvYwJ5e9YqDzQyzpZ26/pdenSDAhYBI30HtL
	 wZHHVfgUrg5XJzaU6XktVnNlNkw1ZglJN/DVJBZk6DSfexJMLbDspaxRa6bisBphC/f7U
	 YT0I45DXnkwvs12ZUIKsiCfcQFXPrn6xu1rBf07BFX/l1mld+5yXWTsWPHe+6fmXpyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790690653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EGsrXk7mGPt8OvlDTwMjjbzt9XQbBGa8qMAsdFFi09g=;
	b=BrlSGd2aymkwtdfNWBnhCRW4HLHZw6YtgyqKe3DRRwf1EtwPspxfVy1moXoVqIwIOL/9
	 uIHVVfXulCJlS1Q0SufY4DEgZora3Ry6a2k+YXAcRBTeSUfQaTyLuHYBamxdBUJhUDqW7
	 2oT0z1TNMKtw/lOGSI7zZ1wuCrAYa9Aivzdkzz5FKT0/PxfkiIVf0q2W/kSAveNkWYj10
	 gb9s071n8R2IdbRidmK8wqE/3Da7qK+MIzpBqylI1bM0kF28kVM2MrgOQE5n8NBDfa+o4
	 D95k36TUu39F0QUOcnGY3pNRN7fVowkqVBO/8Y8oubTO7dtXHXUfbk16YAGiMRYlnGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790690653;
	bh=EGsrXk7mGPt8OvlDTwMjjbzt9XQbBGa8qMAsdFFi09g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=752g+cBesnqzld0d3Hxr5YCBZTdhybrFsSPx+vIx67651xShWqH4auGymb72cshyx
	 Sp/iFY03svTa48MB47BCJ0QfCmWoPE/e9R+dqenTaQb40r8L/8I26yjQSy9AD3xy3N
	 MnptaihsXitTTbjSiO66d1n3yRAxOVCluBQVuGmXdEUYGgB6eBpc3T5Tz4bgBFMEIu
	 NWIx70LZBbUXW/oheKmVTbm1W1i4poKKoQN8DYGpxCyQgjZu08jHHAPpMQdDnC5vMq
	 uxLtO63DI+QcMS3SYhIwLVT+kkjZ8Q41AWeyEVpOynd5/Iv1PpVbUrSbNF5KceX1iN
	 MHkJQGIuFDl+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF2A9406D9;
	Tue, 29 Sep 2026 14:04:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF30ED1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4F6C402E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G44ccRUYboOl for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 14:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A493A402EB
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790690650;
 b=GmBg7dU9A2MngzJrB4a8VtRw5qY+uawhfzIW4n14ADOTWjyq4zqjx09TEf5IpMTff1iz
 yM589J6XrmTEYML/ZcHqlWjnZYPuKdNtnNx07kvt8X++RD96Abzz2imByTJPLEtJX2/OU
 1qSJ046IknREcv3/FESF/3cVUHyg3q8GP9Va7bKR4YD3DvV/YZ29ufk1qAwdd11KW0DaP
 qLcd62fvbGTDBcER9OpRMHtxXfTYEWq5JEKC1GU0DMPGWWRCnyT+uHYbaA/coxI5MkBBI
 X2bhPAY8gDtUWLeUQIgoHqhJ3Tw/Kz+0khPUkHCldsMayeI1cfsipG3apP3mVWKtjRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790690650;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=EGsrXk7mGPt8OvlDTwMjjbzt9XQbBGa8qMAsdFFi09g=;
 b=hYNYGOdqjj4vQYtzubkc9rBgED8Qmp4zAm78lHQu4ly/1Dt9L1Lkw2J6BqhV9FogOxos
 XXuMwqC9WzsxViSIiDfr/Sxf15lPOpMP3NweM3Fz9p6vvibKqor14b8MPOkOSbStjEQHh
 5M5gTHzKd/Kb6FLJ2GzXjbsmMvWQIHrLUMyJPQ6XsxGMbpVArKJDEYrDi+0KzpwDUWLXA
 TO9hTFDVQkXjhWJF1fyrF8iiyUPkpCzf8hS6Q0Mc12MThNVsoq7tmqe3mAE10HaNNteiz
 i6E4Nck+VMUycza9Zb9HqCznapT+ACzty9UyFqV/l76BnjE/SDkrrnwJq/YlYeALiCg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WkG7wXTK; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=WkG7wXTK
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A493A402EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 14:04:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 896C560136;
 Tue, 29 Sep 2026 14:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B109C1F000FF;
 Tue, 29 Sep 2026 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690648;
 bh=EGsrXk7mGPt8OvlDTwMjjbzt9XQbBGa8qMAsdFFi09g=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=WkG7wXTK163jlAeBufXNohj0lTB6edtdoRmw3w66jXjNsFE/zY6X4NMLs4k/eXd8I
 BOmXSO6he1e9HLrl/c/1hVxzOeXPOJ4cXAV4aol14L3LdauHFjx/aDBKJSE7p3ofGi
 FkXTEcIQJmsWstJexRXvXoOH0S0lSw4VOuNwSneyK6aJdDs207JnSUZto1c9n/B5vY
 /qlB3K/42o8eH+4IsnCl1/sm/Lt5nBFeu6yYt/Q5WDMpuuJTo1qX/MFdIUY1dmCmmk
 5pwVEBSuYARfR4MtY0zibnAEsGiU2TkA6PBWm9t+QyACVtkjyR5WDw2EGCf1Vgw2Ul
 LHe7V9l26B8KA==
Subject: Re: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on
 rebuild
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:07 +0000
Message-ID: <179069064725.434549.10623558636835220604@kernel.org>
In-Reply-To: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ice_vsi_realloc_stat_arrays()
  (drivers/net/ethernet/intel/ice/ice_lib.c), the new guard skips only…

--

ice: skip stats handling for channel VSIs on rebuild

This patch makes ice_vsi_realloc_stat_arrays() return early for
ICE_VSI_CHNL VSIs. Those VSIs never get an entry in pf->vsi_stats[], so
this avoids a NULL dereference when a PF reset rebuilds channel VSIs
while an mqprio hardware offload is active.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d0..31af378aa0e7a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3031,6 +3031,10 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  	u16 prev_rxq = vsi->alloc_rxq;
>  	int i;
>  
> +	/* channel VSIs have no entry in pf->vsi_stats[] */
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;
> +
>  	vsi_stat = pf->vsi_stats[vsi->idx];
>  
>  	if (req_txq < prev_txq) {

[Severity: Medium]

This guard only checks the VSI type. Can pf->vsi_stats[vsi->idx] also be
NULL here for a PF, VF or other non-channel VSI?

If an earlier ice_vsi_rebuild() failed inside ice_vsi_cfg_def(), the
unroll path frees the entry:

ice_vsi_cfg_def() {
    ...
unroll_vsi_alloc_stat:
	ice_vsi_free_stats(vsi);
    ...
}

and ice_vsi_free_stats() ends with:

	pf->vsi_stats[vsi->idx] = NULL;

ice_vsi_alloc_ring_stats() does the same on its err_out path.
ice_vsi_rebuild() then returns through goto unlock without restoring the
entry, and the VSI stays in pf->vsi[].

Some callers then call ice_vsi_rebuild() on the same VSI again. One
example is the fallback in ice_setup_tc_mqprio_qdisc():

	ret = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
	if (ret) {
		...
		if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {

The same thing can happen through the unroll path in
ice_sriov_set_msix_vec_count(), when userspace retries ethtool -L or -G
through ice_vsi_recfg_qs(), or on a later PF or VF reset.

On that second call vsi_stat is NULL and the type check does not catch
it. If req_txq < prev_txq, the oops happens at
vsi_stat->tx_ring_stats[i]. Otherwise it happens at:

	tx_ring_stats = vsi_stat->tx_ring_stats;

ice_vsi_free_stats() and ice_qp_reset_stats() already handle a NULL
entry. Would a !vsi_stat check here cover both the channel VSI case and
this one?

The new comment, "channel VSIs have no entry in pf->vsi_stats[]", also
implies that only channel VSIs can be missing an entry.

A later patch in this series, "ice: rebuild ring stats arrays instead of
reallocating them in place", appears to fix this. It replaces the
function with ice_vsi_resize_stat_arrays() -> ice_vsi_install_stat_arrays(),
and ice_vsi_set_stat_arrays() handles a NULL entry with:

	if (!vsi_stat)
		return;

Should this patch check for a NULL vsi_stat as well, so that it is a
complete fix on its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
