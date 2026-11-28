Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FF606A690
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sbe4Fnln;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjORHsWA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38A0740669;
	Sat, 28 Nov 2026 09:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VbGtQXFKsOQO; Sat, 28 Nov 2026 09:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49D3C405FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795858218;
	b=o/aYTPLRvePmpARgoddigWO8sslMm5FlQm/ium5aJRAJsT1Jfcm6BSTa+/wFt3PzVOoM
	 xWuye3CnYF2bzSMThuGmCeaQ/aPUakxz4D5hmq3gmVzxMghC+YlfP4/QMlxYUTTTdSA3J
	 SGM141CoqfA4LliniPD7Q1TGELo4CMGUb5BpsTFzeOTxMdIanmCzzLizPuZXHgt6eoNYp
	 uxwmr12ISZT6WbOD02EvpirFqtPkPAiM1C00mRi/3t/kWw6f7FMHKk2YhaYpAUKE8mDxA
	 SvTWWKKdpxgjE4N104H2JtPc1LQZB/VnpVJEUWJ9spyfu+uhu+TVxDDSRKD3byBTDng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795858218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YlUSTqlDLSiYnKXcQwkZ7xCXG+D4DiBqjnIkYe6WzA8=;
	b=hYlAKKm1emLRUBYTnGUNEKhax7fqHk3dWDC/ZsfrtpjoZMAkjp9O1T0KUGWqFv3edSTO
	 Fz2CgHhZYchuWmB/ywEqV1GbyKevuituHXUXP+GC8+A8wSo0jxs3qadT/2DM5kOKcE4t3
	 LF351UJdg1xLBHeGVNh8yY7NO19ZzcuqrDuVlkJ46X4FPDhzePFtJadWCO2IlZGVZOPWN
	 5pHR9fd8yroyKfPd96wqa1fbyLr2RsXOV4Qc3LNMEy01rwdHBoMmWBXztV2x+9KBuAA5f
	 e9a2U9hO66ItafWBLIKAVXgK9MzyUQoEt37FQ56RodtlSUbrIYcMzzaXkp9+C2Vg7qg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjORHsWA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795858218;
	bh=YlUSTqlDLSiYnKXcQwkZ7xCXG+D4DiBqjnIkYe6WzA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sbe4FnlnJENyXcOGizZFaKtp/7agsP7pSiMe+pQB/0S5LSvbBC7Qdx0pGi2y2UuiE
	 S2d4bVKSS92dgU/LRAAEo/qM/mlAC18KeE6U750rtQEoIqwkM11Shyu4BX+qIz0c0J
	 IDAGN7valbxKLVQcI9UZdeJdnkLVhFyX1XqSGEw5FnE2NLw6SGxA+o7bnWgGPuBNVa
	 HxVM17fEjNRs3tgq2kfwCWdpBpdK3XpFqmhAL9H1chxQdBpAd/od5mBfc5H4rOyEnQ
	 5jonRcL3R6vBG1oagp5x3ikxsgQt+gzwlERzKicduBjMA1O/dIhRoBczBwF/NKeZwe
	 hpQYvpnDxPSsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49D3C405FF;
	Sat, 28 Nov 2026 09:30:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 804AC3C0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7256540541
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5AT4g2tF3kt for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 09:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 442F6405FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SjORHsWA
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 442F6405FF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFDC660CF9;
 Sat, 28 Nov 2026 09:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDA01F0089A;
 Sat, 28 Nov 2026 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795858214;
 bh=YlUSTqlDLSiYnKXcQwkZ7xCXG+D4DiBqjnIkYe6WzA8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=SjORHsWAO9yz/Mt5R6NvoEtQfbJgdaJpkD4VjFddJYzw3KwVI4attRiCksHVhYvMs
 dY2M5BWX09WPPlzgx0ORURCZTK0RYkA/l6v2xZrhckHNOK3RMJZl9C+x8OckCUa22X
 kjk1ovdm6hQ1dGa/HJcBiMuPWCqw0JTL9AHNJQsgM2SLLVAM82YEMIZfUc4hH1qvip
 mRfW+FPP3+eFhQ9odyavFx8Y0DpSzWRAzuiJn+53YOJQCTof3imkJXjBzVy+Sr50jr
 ey7WgwpjQMwzc/C0h3kVqX11ekw/DYQx7crPEjzVwkSFd+MZ+rzMs97Dxdk+qzl3Pr
 5nfGBZytQgJhg==
Subject: Re: [PATCH net v5 4/4] ice: use a VLAN agnostic multicast promisc
 rule pair for PF VSIs
From: netdev-bot+sashiko@kernel.org
To: poros@redhat.com
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, grzegorz.nitka@intel.com,
 pmenzel@molgen.mpg.de, wojciech.drewek@intel.com,
 marcin.szycik@linux.intel.com, martyna.szapar-mudlaw@linux.intel.com,
 ivecera@redhat.com, alice.michael@intel.com, jacob.e.keller@intel.com,
 jbrandeb@kernel.org, patryk.holda@intel.com, sx.rinitha@intel.com,
 aaron.ma@canonical.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Sat, 28 Nov 2026 09:30:12 +0000
Message-ID: <179585821237.3135.7178956472467266393@kernel.org>
In-Reply-To: <20261127085714.1207361-5-poros@redhat.com>
References: <20261127085714.1207361-5-poros@redhat.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ice_vsi_sync_fltr()
  (drivers/net/ethernet/intel/ice/ice_main.c), the error paths rewritten…

--

ice: use a VLAN agnostic multicast promisc rule pair for PF VSIs

On PF VSIs, this patch replaces the per-VID ICE_SW_LKUP_PROMISC_VLAN
multicast promisc rule pairs with one VLAN agnostic ICE_SW_LKUP_PROMISC
pair, so the switch lookup table no longer runs out. It removes the
per-VID handling from ice_vlan_rx_add_vid() and ice_vlan_rx_kill_vid().
The multicast subscription is now reconciled from IFF_PROMISC and
IFF_ALLMULTI in one place in ice_vsi_sync_fltr().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 2ce2b7138f668..ea6da46bf7955 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -399,91 +408,65 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  		goto exit;
>  
>  	/* check for changes in promiscuous modes */

[ ... ]

> +	promisc_changed = test_and_clear_bit(ICE_VSI_PROMISC_CHANGED,
> +					     vsi->state);
> +	if ((changed_flags & IFF_PROMISC) || promisc_forced_on)
> +		promisc_changed = true;
> +
> +	if (promisc_changed && (vsi->current_netdev_flags & IFF_PROMISC)) {
> +		/* Apply Rx filter rule to get traffic from wire */
> +		if (!ice_is_dflt_vsi_in_use(vsi->port_info)) {
> +			err = ice_set_dflt_vsi(vsi);
> +			if (err && err != -EEXIST) {
> +				netdev_err(netdev, "Error %d setting default VSI %i Rx rule\n",
> +					   err, vsi->vsi_num);
> +				vsi->current_netdev_flags &= ~IFF_PROMISC;
> +				set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
> +				dflt_err = true;

[ ... ]

> +	/* promiscuous mode implies allmulticast */
> +	if (promisc_changed || (changed_flags & IFF_ALLMULTI)) {
> +		int mc_err = 0;
> +
> +		/* a failed DFLT install leaves the netdev promiscuous */
> +		if (ice_vsi_wants_mc_promisc(vsi))
> +			mc_err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
> +		else if (!dflt_err)
> +			mc_err = ice_clear_promisc(vsi, ICE_MCAST_PROMISC_BITS);
> +		if (mc_err) {
> +			netdev_err(netdev, "Error %d syncing multicast promiscuous on VSI %i\n",
> +				   mc_err, vsi->vsi_num);
> +			/* retried by the next sync, with the allmulti change */
> +			vsi->current_netdev_flags ^=
> +				changed_flags & IFF_ALLMULTI;
> +			set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
> +			if (!err)
> +				err = mc_err;
>  		}
>  	}
>  	goto exit;

[Severity: Medium]
Does this retry actually happen? Both the comment above and the commit
message ("a failed DFLT install does not remove it before the retry")
expect a later sync.

Three error paths are involved: the failed DFLT install (dflt_err), the
failed DFLT clear and this mc_err path. Each one only sets
ICE_VSI_PROMISC_CHANGED, returns an error and leaves through exit.

ice_sync_fltr_subtask() calls ice_vsi_sync_fltr() only when
ice_vsi_fltr_changed() is true:

ice_sync_fltr_subtask() {
    ...
	ice_for_each_vsi(pf, v)
		if (pf->vsi[v] && ice_vsi_fltr_changed(pf->vsi[v]) &&
		    ice_vsi_sync_fltr(pf->vsi[v])) {
			/* come back and try again later */
			set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
			break;
		}
}

ice_vsi_fltr_changed() looks only at the UMAC and MMAC bits:

	return test_bit(ICE_VSI_UMAC_FLTR_CHANGED, vsi->state) ||
	       test_bit(ICE_VSI_MMAC_FLTR_CHANGED, vsi->state);

ice_vsi_sync_fltr() clears both bits near its start. Only the out label
sets them again, and these paths skip it. So ICE_FLAG_FLTR_SYNC is set
again after the error, but on the next service task pass the VSI is
skipped and the flag is cleared.

The admin queue can fail transiently, for example in the FW ENOSPC ->
-EIO case from the commit message. Could the VSI then stay with
IFF_PROMISC set but no DFLT Rx rule? Could it also stay with IFF_ALLMULTI
or IFF_PROMISC set and missing or stale multicast promisc rules?

Removing VLANs to free FLU entries would not trigger a resync, because
ice_vlan_rx_kill_vid() sets no sync bits. The state seems to last until
an unrelated ice_set_rx_mode() call or an eswitch resync.

The old out_promisc label had the same gating, but this patch adds new
retry state and depends on it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127085714.1207361-1-poros%40redhat.com
