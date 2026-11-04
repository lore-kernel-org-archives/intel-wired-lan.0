Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471AF606A32F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nhqoEgTW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z73iQ9/x
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 271FE405E9;
	Wed,  4 Nov 2026 14:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCoEfmSSHqbE; Wed,  4 Nov 2026 14:40:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16397405F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793803235;
	b=ICrXvHST0IsxLBaHSeCVHvClHYkbPM9uI0ATEpON66IErXkCb1470rUreyYgJ1jVxAPG
	 A2pAmCqaHh1w700oNLGwt4g3VUNhyqCws7a6MWWmIRIWIdkf8Uwg4EGuh5Gr/gMRdcp6d
	 Y3KBwYBjrMRlHdzAj+7M1yC6BL1NPPIhdj0yv8kiXGbKZgKOQIMNNPZe6/Nwbv4o7yd+l
	 DehDt7OrPBdSVGshVhO7nzfXd+37TbCWJEICMpdG76BiyzIHcTtMADf39uoJy4xoiRtpw
	 QiCmF9+5e//e7KPw9OcSar3dpwV+9ApKzu57tYIAyKze1i3QrUn6z7YcLKQ4dwAEsXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793803235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=3QImI++ZJXqNAMd93IEa3mat3HgHd23dyYPVoEYhrbk=;
	b=HHPKKnKN/brfOlYk8q6MJbPJqxUXHRuRy5gjZ8lDOOqtSy4oirguGq9D68kIk45lp+lD
	 ey6jEKbzfL4VK4HUF+OUIxRrz//IJreDcFWD1Q1MUfSyFwfpn49gZxvQUOFHuHNwpJSTl
	 Hx9IWPMo0OYKc67uWzucsH1a6wHZL1qH67Oixk68BMfRl0pfDpG5bS4w66hORmTNYjvNA
	 YT20V84i+9HzShPhW4iqY9V7gnQRWWZbvKFqpJIW9kDTMTDWQK6TIKJVhQt5ejUHsbvpc
	 M+tosxK6A2OYvB/MKZV3WsO5m2Njaw+huPxnGntICxZVO0uAhsx3JwDf4MrtESFelrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793803235;
	bh=3QImI++ZJXqNAMd93IEa3mat3HgHd23dyYPVoEYhrbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nhqoEgTWwrDd662lv4U87uxiMpRN0+ZshtAfADQCqErM6PHXDu98togk2b3zmYEU6
	 46oe7x5TH87n2W/HcCl8ReY5t1jb6qifJqjbw/ej/YgQVU+iWa0qGaHzHzs/EkYvla
	 Ge7Q45u0pl1kV6jsYyuRpSKbOmsAeruoEEEUE9M+8tU1lETb0L2H0Qymul7Yo8kC09
	 iZ0GydV6zCr13LdecwO8X7+KqEP5hvRdufVw/gi4hZju8PtzQ9dUN1AHLA9zDtve6D
	 RRAudJs+J5bvbJTHpAoHbH0xIYEVH/5kFrf+481dGU0phLKTkWNPZbTQMK0xaxOXzO
	 J5ebkmpuGpLng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16397405F4;
	Wed,  4 Nov 2026 14:40:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9D6E32A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B034540062
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rmlHtx6opM1g for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 14:40:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9188540068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793803230;
 b=fIK6hD8Bs18SDLirJeAMRMyRQy/u1CytF3UcAX2dCNhPmmEQmXRGocZF8YbBZV7aU73r
 BQ3WU8brT+PW+3gJ98FVo3yhOAWDLwPS704S9GBNxI5jjFAGYJE0JwbF5+xg8aFw5edVk
 zDEaQLHh3w8mqRlXOmX155mUjaPMxNj4gWvEKB7SZ1hhKHRIVADr0rd/lMmZpxuy9XeZB
 HkCSTxZlLTWTjjLtUkZgbuc+qLtmMgUyu/c+zaKBHlECy9GtGX07HymKjlWDSgjO2pdGo
 NM8hsy/DFCSozGC76OAAkFvbDz0gwHFgYSWzJ8/JZdDkz/ued5fskhCDF4oghN3P6HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793803230;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=3QImI++ZJXqNAMd93IEa3mat3HgHd23dyYPVoEYhrbk=;
 b=kLRFThGj9TWE25JwIMH69Ws350+6dcAm9/zMFlvkxV2x1//OCSXJNEJP2hDEmnkg0Fib
 Q5ed+/adJU93urE6OYSqHvNk7WA/7wS5TDXYcIivsnTWQTkXrN6Cem3m8dJyLkHNrVYH8
 tPgOswQc5ru+IDuYpgLbCbXsAPM36YKpPDk2SgBF8YKRQXLArsOLU6uZkepmcB9t8Okmt
 hZoqVYx9xM43wnj+UMZ5QJq/HSH5/otl/1QcPcz8LVDWirBCCZjhdadHFp1HuP01HrARC
 PogFl8QNaAJewWsRrBAbc8AyaBSdlL4It44d5Igs+zFAvTjo0huFGVXgL8fpNbpN3BQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Z73iQ9/x"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Z73iQ9/x
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9188540068
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D586960A9B;
 Wed,  4 Nov 2026 14:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A311F000C1;
 Wed,  4 Nov 2026 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793803228;
 bh=3QImI++ZJXqNAMd93IEa3mat3HgHd23dyYPVoEYhrbk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z73iQ9/xTSzbNYYx0i2SLSEZ0W60JIOp/XTS/eyh18ln7lIS0+XiW519zL0eETOtr
 kxI7U90nc21YE1kJwMZxXmKFgpdkFvWDoiZDEEVM4IiftwGRajtZetBnQ++fCGgSEa
 A50HzQJg8PhUHSlziLBGImQuCX5amFWpNJuxHsu0k36IVrvtzlpWLivGbZCqxBdO2b
 U+DlGq0RB/IWrJBSUkh3hI2cnosehIkUh4yThPsTa1e5M2J6agNxiLniaJ99DuMDiJ
 RozgfbrIpR4X5UfLjPkVhRtqTngxBjm2hdQFfl7w7qHsyVPuhFlYnJsy3gWkNlqCFy
 ufbY3A6c21pQA==
Message-ID: <sashiko-outbox-197459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v4 13/15] ice: represent RSS LUTs as devlink
 resources
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103141646.303620-14-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-14-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:40:28 +0000
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ice: incorrect vsi->rss_size in ice_vsi_cfg_def() on rebuild and=
 ADQ
- [Medium] ice: dual-NAC secondary PFs collide on RSS LUTs and fail probe i=
n Safe Mode
--

commit 299cfc2cd70e5919800a3878f9f0873adb6b516d
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice: represent RSS LUTs as devlink resources

This commit exposes the PF and global RSS lookup tables of E800 devices as
devlink resources on both the per-PF and whole-device devlink instances,
allowing a PF to switch between its 2048-entry PF LUT and a 512-entry global
LUT.

> diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.c b/drivers/=
net/ethernet/intel/ice/devlink/resource.c
> new file mode 100644
> index 0000000000000..b0b2b1adae0c1
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/devlink/resource.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026, Intel Corporation. */
> +
> +#include "resource.h"
> +#include "ice_adapter.h"
> +#include "ice.h"
> +#include "ice_lib.h"
> +
> +#define ICE_NUM_GLOBAL_LUTS	16
> +#define ICE_ANY_SLOT		-1
> +
> +/* each NAC numbers its PFs from 0, secondary NAC ones go after primary =
ones */
> +static int ice_devl_pf_id(struct ice_pf *pf)
> +{
> +	struct ice_hw *hw =3D &pf->hw;
> +
> +	if (ice_is_primary(hw))
> +		return hw->logical_pf_id;
> +
> +	return hw->logical_pf_id + ICE_PORTS_PER_QUAD;
> +}

[Severity: Medium]
Can secondary-NAC PFs on dual-NAC E825C devices collide with primary-NAC PFs
and fail probe when entering Safe Mode?

In ice_probe(), ice_init_dev_hw() runs before ice_adapter_get() and
ice_init(). When DDP package loading fails or leaves the PF in Safe Mode,
ice_init_dev_hw() calls ice_set_safe_mode_caps():

drivers/net/ethernet/intel/ice/ice_common.c:ice_set_safe_mode_caps() {
	...
	/* unset dev capabilities */
	memset(dev_caps, 0, sizeof(*dev_caps));
	...
}

Because dev_caps->nac_topo.mode is zeroed and not restored by
ice_set_safe_mode_caps(), ice_is_dual(hw) returns false and
ice_is_primary(hw) returns true even on secondary-NAC PFs.

All E825C PFs share a single ice_adapter via ICE_ADAPTER_INDEX_E825C. If the
first PF probes in Safe Mode, ice_adapter_get() -> ice_adapter_init() ->
ice_devl_whole_dev_resources_register() sees ice_is_dual(hw) as false and
sizes the whole-device LUT resources for a single NAC.

Furthermore, during ice_init() -> ice_init_pf_sw() -> ice_pf_vsi_setup() ->
ice_vsi_cfg_def(), ice_take_rss_lut_pf() runs even in Safe Mode. For a
secondary-NAC PF in Safe Mode, ice_devl_pf_id() returns hw->logical_pf_id
instead of hw->logical_pf_id + ICE_PORTS_PER_QUAD, colliding with the
primary-NAC PF's slot in adapter->resources[ICE_RSS_LUT_PF].owner[] and
failing with -ENOSPC.

During the resulting error unwind in ice_init() -> ice_deinit_pf() ->
ice_free_rss_lut_flr() -> ice_free_rss_lut_flr_locked(), the secondary-NAC
PF then clears resources[ICE_RSS_LUT_PF].owner[pf_id] and any global LUTs
matching pf_id, wiping out the primary-NAC PF's LUT resource ownership.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ether=
net/intel/ice/ice_lib.c
> index f81b310a98c3e..215244a1c043b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -986,10 +988,10 @@ static void ice_rss_clean(struct ice_vsi *vsi)
>  }
> =20
>  /**
> - * ice_vsi_set_rss_params - Setup RSS capabilities per VSI type
> + * ice_vsi_set_dflt_rss_params - Setup default RSS capabilities per VSI =
type
>   * @vsi: the VSI being configured
>   */
> -static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
> +static void ice_vsi_set_dflt_rss_params(struct ice_vsi *vsi)
>  {
>  	struct ice_hw_common_caps *cap;
>  	struct ice_pf *pf =3D vsi->back;
> @@ -1004,6 +1006,9 @@ static void ice_vsi_set_rss_params(struct ice_vsi *=
vsi)
>  	max_rss_size =3D BIT(cap->rss_table_entry_width);
>  	switch (vsi->type) {
>  	case ICE_VSI_CHNL:
> +		if (!vsi->num_rxq)
> +			vsi->num_rxq =3D 1;
> +		fallthrough;
>  	case ICE_VSI_PF:

[ ... ]

> @@ -2427,6 +2464,18 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
> =20
>  	vsi->vsw =3D pf->first_sw;
> =20
> +	if (vsi->flags & ICE_VSI_FLAG_INIT) {
> +		scoped_guard(mutex, &pf->rss_lut_lock) {
> +			u16 lut_size =3D vsi->rss_table_size;
> +
> +			ice_vsi_set_dflt_rss_params(vsi);
> +			if (vsi->rss_table_size !=3D lut_size) {
> +				devm_kfree(dev, vsi->rss_lut_user);
> +				vsi->rss_lut_user =3D NULL;
> +			}
> +		}
> +	}
> +
>  	ret =3D ice_vsi_alloc_def(vsi, vsi->ch);
>  	if (ret)
>  		return ret;
> @@ -2446,15 +2495,23 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>  	}
> =20
>  	/* set RSS capabilities */
> -	ice_vsi_set_rss_params(vsi);

[Severity: Medium]
Does moving ice_vsi_set_dflt_rss_params() before ice_vsi_alloc_def() and
gating it on ICE_VSI_FLAG_INIT cause vsi->rss_size to remain clamped at a
smaller queue count on ICE_VSI_CHNL creation and ICE_VSI_FLAG_NO_INIT
rebuilds?

Previously, ice_vsi_cfg_def() called ice_vsi_alloc_def(vsi, vsi->ch) first
and then unconditionally called ice_vsi_set_rss_params(vsi) on both
ICE_VSI_FLAG_INIT and ICE_VSI_FLAG_NO_INIT paths, resetting vsi->rss_size to
its default ceiling before ice_vsi_cfg_rss_lut_key() clamped it via:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_cfg_rss_lut_key() {
	...
		vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->num_rxq);
	...
}

With this change:

1. When a new ICE_VSI_CHNL VSI is created via ice_chnl_vsi_setup() ->
ice_vsi_setup() -> ice_vsi_cfg_def(), ice_vsi_set_dflt_rss_params() now runs
before ice_vsi_alloc_def() assigns vsi->num_rxq =3D ch->num_rxq. Because
vsi->num_rxq is still 0 at that point, the new fallback sets vsi->num_rxq =
=3D 1
and vsi->rss_size =3D 1. After ice_vsi_alloc_def() sets the actual channel
vsi->num_rxq, ice_vsi_cfg_rss_lut_key() computes min_t(u16, 1, vsi->num_rxq=
),
leaving the channel VSI's rss_size stuck at 1.

2. When ADQ is configured in ice_setup_tc_mqprio_qdisc(), main_vsi->orig_rs=
s_size
saves the pre-ADQ rss_size and main_vsi->rss_size is clamped to
main_vsi->ch_rss_size. If a PF reset (ICE_RESET_PFR) occurs while ADQ is
active, ice_prepare_for_reset() clears vsi->orig_rss_size =3D 0 (relying on=
 the
normal rebuild flow to recompute rss_size) while ADQ stays active and
ice_rebuild_channels() clamps main_vsi->rss_size back to ch_rss_size. When
the ADQ qdisc is later deleted, ice_setup_tc_mqprio_qdisc() restores
vsi->req_rxq and calls ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT). Because
ICE_VSI_FLAG_INIT is not set, ice_vsi_set_dflt_rss_params() is skipped,
vsi->orig_rss_size is 0, and ice_vsi_cfg_rss_lut_key() clamps vsi->rss_size
with min_t(u16, vsi->rss_size, vsi->num_rxq), leaving the PF VSI's rss_size
permanently clamped to the smaller ch_rss_size.

3. Similarly, in this commit ice_sriov_set_msix_vec_count() rebuilds
ICE_VSI_VF with ICE_VSI_FLAG_NO_INIT, leaving VF vsi->rss_size clamped if
VF queues are lowered and then raised (though a later patch in the series,
"ice: support up to 256 VF queues", updates ice_vsi_cfg_rss_lut_key() for
ICE_VSI_VF).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103141646.3036=
20-1-przemyslaw.kitszel@intel.com?part=3D13
