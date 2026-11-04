Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A5606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=p7Vi3mFS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THeVuBY3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85C24606A7;
	Wed,  4 Nov 2026 14:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wbTCIKEUlMeN; Wed,  4 Nov 2026 14:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C5F3606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793803236;
	b=M1tdYlEoq/W9Qo5wWupnSMUkyxQ7A979hLwPSg5DTBmGy2SgUI9576bWRugpJz0lx+Jh
	 eACTrPJFxqaQT9rYGK0hhSXu5C4GrsA6blvrRA5AH3m3oZnMU5u3rUcVKz6ivpwOU8AF8
	 +mAJWlE1H3xmSsQiV/x6Cep04gKTWO3gNDTO9mHkxD3yg6A6AP/EZ7F39dQm+rYRL6OXn
	 ZpBJw4mqS2QQFhpdE4gKjhp8Lb9rkKjZoaRc+6brYBYzeEUQwSv19NJs8AbrMFiDZ5p9N
	 dIxFWVfXAxN1h+admmFQcnYRxbYU4laF4YleiBLF0raBFrJu8/sly3tDfUNcleSMNqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793803236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=DR9ZX4c456mObTk38j/dxbwQM9HTeZa3l8QnUy8HBd8=;
	b=Nnamcagw5ZQcUvdm3RJIeQ9H5UtmqqipkRCSNvf+VqbMIq5Muzfy8KS9gBT2Go160MT4
	 w8SeWIQRd/1fMXKDgp2j5h67+0b9c9OfigZ1re8Xa4GJnMJPdP95MjYw9V79u/swFg5Dq
	 A92wmdu7S+RDaSrONnn3VQl8hI5sDQqVDUhGP3pVEN5QdubS9to9PpW3e4jHhGrYsIr3d
	 U1d4RADcBZ6YVLte3VYlzRdHEe10ctEtBbk92yRHp32ifPCd51OxY0B1BJezvyEtYE8zy
	 0AMF2cS1O48rzzdS7roXiLxzUwEBVzwCu2uE1iZPn3FsiQKnuhVERsMjJDb5Qvckymw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THeVuBY3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793803236;
	bh=DR9ZX4c456mObTk38j/dxbwQM9HTeZa3l8QnUy8HBd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=p7Vi3mFSPdfY0o6xjlMr0xlYhgexVh9CxJA81dYlk/KzrIbJSus4tGgu8GYxj1Pok
	 B72KNSsdJGVRc7Thh9Eg2dATwz9b3eoo+8SiWfm02gF3wRiMywCL2XQsHjnhGEcYKH
	 gcUw2ubt/cV89yrkecm4jCL5HpfnRl57/9vEd18w37d6fJ8F1W3c+RVWHZkqha5BvX
	 wp4eAt9bxRoBxbFnGW+4h6optlD2RTEx6FMwsksSeuzKBoJ24FvtXY+wl61qXBYOG3
	 mA54eja8x+UT7FzHnOcFBtC6IBDerU84y/PIi3a6B9nRyacQoPF4vwZ9Vlm0Tr7hf5
	 HC1E8rwyAK1DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C5F3606F7;
	Wed,  4 Nov 2026 14:40:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A8B6E32A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E7D8606D3
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhcXLNiYLc7K for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 14:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1737B6067D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793803231;
 b=ENYJN44zGuRbiLUQo8uG/zzcjK3cIzncqgY6XumtAKadVPfRDwzjrBZOaJOZGpLNSmBg
 ymnwKDCgaXUuW8T8IkBYSEv2LIoZOVjls/Ipu8zzGJLVcO2FPx23jHX23GaRVsdG3xO0I
 TvA2AuUAc+HMnc718Tiwdc1O1QhMtCIuvACXVz3VPFASnaiBRJIaMvJf2HqzNEXq9yGdD
 U05ZMYmric+U7Veqka6asq5si0UwDxcV5HdwMs8hqYg05tiX7OOEb3u40+t9Mc/kABqnb
 n0POOEh9DiHNGFOq81Xskh9Inc3a3r2ikT8H2UPOu9y17QV5WQ5x21g+axVra2+7gBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793803231;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=DR9ZX4c456mObTk38j/dxbwQM9HTeZa3l8QnUy8HBd8=;
 b=Y4gcsy817N3qWo1cHqukkiYUjFKWEuXQDaxgjNk9Xv/nxOzdBVuYwcGskPE2HNjhmd8m
 vSUel7NC0eZaFVGiBIiuE9S8jQEZOU6m5wQGkuwyJLzR6KU5f35AYgKV7YPa8HPT6vFXb
 Cb7YRJM9q3tkuxjsEACdWbyYLWFPXMc/6UEFAkh/RXdkBqbsoT9oKhYQ/RGCOhgJCAVjN
 DAOdh7IDxxSsGTSk3kHnPVFzcYlstQh81BBPuUwNpJbAGhzBYbkk1t3sKL1wPfCyGPm9I
 2kV2iGiTO92SRmtKEllGcqYjNMLUAmjK0UCPpEACVHOp13UcInmQnQtFf2OihygvTZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=THeVuBY3; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=THeVuBY3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1737B6067D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7825460A9D;
 Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1360A1F000C1;
 Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793803229;
 bh=DR9ZX4c456mObTk38j/dxbwQM9HTeZa3l8QnUy8HBd8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=THeVuBY3Jt4oM4bkT+1RqOe7n1f/3EdZPGoTVj9bSboLZABUoqEJnhdIzR+BzjTMl
 b2GHP9iyfbcE2PR9EPUqRXYw+q+LsPtO7voHIRgnPoHaPdtRBJjDJiOt8LoR+wD/TK
 LPVLUfTX5S0tnmdE/ucajVr+H7L0aztVv3NfyEqDDffhoeUO7w3Jfhsw8Op+UlbY5l
 vUF6SRqNykP2CCLE0VIXZMnqpyIdioQPzbReI6x11jzChUw9opPAmKRlVP1UYpS+Qp
 NGi9Dm3/eRH1p/h4dcbdLqJkJTlNwKlfn6WLa2C/u0QiktonFyClef8/R3xs8IsSbk
 +MNJBG5TaUS+w==
Message-ID: <sashiko-outbox-197461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v4 15/15] ice: support up to 256 VF queues
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103141646.303620-16-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-16-przemyslaw.kitszel@intel.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] ice: lock inversion between vfs.table_lock and PF devlink lock in =
ice_init_vf_devlink()
- [Medium] ice: VF devlink RSS LUT changes race with PF reset and VF VSI re=
build
- [Medium] ice: restored PF vsi->rss_size in ice_rebuild_rss_lut_pf() is ov=
erwritten
- [Medium] ice: unlocked vsi->rss_lut_type and rss_size in ice_vsi_cfg_rss_=
lut_key()
- [Medium] ice: u8 ring count overflow in ice_vc_map_q_vector_msg() with 25=
6 queues
- [Medium] ice: uncapped queue offer and dead code in ice_vc_request_qs_msg=
()
- [Medium] ice: VF devlink registered before resources in ice_init_vf_devli=
nk()
- [Low] ice: duplicate ice_get_vf_vsi() lookup in ice_vc_config_rss_lut()
--

commit ad0fafa098b2509023a0c2fdd740574478b1b268
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice: support up to 256 VF queues

This commit adds support for up to 256 queues per VF by allowing global
(512-entry) and PF (2048-entry) RSS LUTs to be assigned to VFs via nested VF
devlink resource instances, deferring VF resets triggered by LUT changes to
the service task, and wiring up the large queue pair virtchnl operations.

> diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.c b/drivers/=
net/ethernet/intel/ice/devlink/resource.c
> index b0b2b1adae0c1..5a0ab267bf8bc 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/resource.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/resource.c

[ ... ]

> @@ -414,6 +465,41 @@ static int ice_rss_lut_pf_occ_set_global(u64 size,
>  				      ICE_ANY_SLOT, extack);
>  }
> =20
> +static int ice_rss_lut_vf_occ_set_pf(u64 size, struct netlink_ext_ack *e=
xtack,
> +				     void *occ_priv)
> +{
> +	struct ice_vf *vf =3D occ_priv;
> +	struct ice_pf *pf =3D vf->pf;
> +	int pf_id;
> +
> +	pf_id =3D ice_devl_pf_id(pf);
> +	scoped_guard(mutex, &vf->cfg_lock) {
> +		if (!ice_vf_is_ready(vf))
> +			return -EBUSY;
> +
> +		scoped_guard(ice_adapter_devl, pf->adapter)
> +			return ice_devl_res_change(size, ICE_RSS_LUT_PF, pf, vf,
> +						   pf_id, extack);
> +	}
> +}
> +
> +static int ice_rss_lut_vf_occ_set_global(u64 size,
> +					 struct netlink_ext_ack *extack,
> +					 void *occ_priv)
> +{
> +	struct ice_vf *vf =3D occ_priv;
> +	struct ice_pf *pf =3D vf->pf;
> +
> +	scoped_guard(mutex, &vf->cfg_lock) {
> +		if (!ice_vf_is_ready(vf))
> +			return -EBUSY;
> +
> +		scoped_guard(ice_adapter_devl, pf->adapter)
> +			return ice_devl_res_change(size, ICE_RSS_LUT_GLOBAL, pf,
> +						   vf, ICE_ANY_SLOT, extack);
> +	}
> +}

[Severity: Medium]
Can ice_rss_lut_vf_occ_set_pf() and ice_rss_lut_vf_occ_set_global() race wi=
th
PF reset recovery or SR-IOV teardown and leave the LUT resource in
pf->adapter->resources out of sync with the VF VSI state?

During a PF reset, ice_prepare_for_reset() calls ice_set_vf_state_dis(), wh=
ich
only clears ICE_VF_STATE_QS_ENA without clearing ICE_VF_STATE_INIT or setti=
ng
ICE_VF_STATE_DIS in vf->vf_states. Later, in ice_do_reset() and
ice_reset_subtask(), the PF reset-in-progress state bits are cleared after
ice_rebuild() finishes and before ice_reset_all_vfs() runs:

drivers/net/ethernet/intel/ice/ice_main.c:ice_do_reset() {
	...
	ice_rebuild(pf, reset_type);
	clear_bit(ICE_PREPARED_FOR_RESET, pf->state);
	clear_bit(ICE_PFR_REQ, pf->state);
	wake_up(&pf->reset_wait_queue);
	ice_reset_all_vfs(pf);
	...
}

In the window before ice_reset_all_vfs() triggers the VF resets (and simila=
rly
in ice_free_vfs() after ICE_VF_DIS is set on pf->state before the per-VF lo=
op
takes vf->cfg_lock), ice_is_reset_in_progress(pf->state) is false while
ice_vf_is_ready(vf) is still true because ice_vf_is_ready() only tests
ICE_VF_STATE_INIT and !ICE_VF_STATE_DIS (ignoring ICE_VF_DIS on pf->state,
unlike ice_is_vf_disabled()).

If a devlink resource change runs in that window, ice_devl_res_change() cla=
ims
the ICE_RSS_LUT_PF or ICE_RSS_LUT_GLOBAL slot for the VF in
pf->adapter->resources, updates vsi->rss_lut_type, and sets
ICE_VF_STATE_NEEDS_RESET. When ice_reset_all_vfs() then acquires vf->cfg_lo=
ck,
it clears ICE_VF_STATE_NEEDS_RESET and calls
ice_vf_rebuild_vsi()->ice_vsi_rebuild(..., ICE_VSI_FLAG_INIT)->
ice_vsi_cfg_def()->ice_vsi_set_dflt_rss_params(), which unconditionally res=
ets
vsi->rss_lut_type to ICE_LUT_VSI and vsi->rss_table_size to ICE_LUT_VSI_SIZE
while the VF remains recorded as the owner of the LUT resource in
pf->adapter->resources.

Should ICE_VF_STATE_DIS (or ICE_VF_DIS on pf->state) be set in
ice_prepare_for_reset() and checked by ice_vf_is_ready() so VF LUT changes =
are
rejected until ice_reset_all_vfs() finishes rebuilding the VFs?

> @@ -527,6 +613,8 @@ static int ice_rebuild_rss_lut_pf(struct ice_pf *pf)
>  		vsi->rss_lut_user =3D NULL;
>  		vsi->rss_table_size =3D ice_lut_type_to_size(ICE_LUT_PF);
>  		vsi->rss_lut_type =3D ICE_LUT_PF;
> +		vsi->rss_size =3D min(vsi->num_rxq,
> +				    ice_lut_type_to_qs_num(ICE_LUT_PF));
>  	}
>  	mutex_unlock(&pf->rss_lut_lock);
>  	err =3D 0;

[Severity: Medium]
Does this vsi->rss_size update in ice_rebuild_rss_lut_pf() get overwritten
immediately afterwards during the PF VSI rebuild?

In ice_rebuild(), ice_rebuild_rss_luts() runs right before
ice_vsi_rebuild_by_type(pf, ICE_VSI_PF):

drivers/net/ethernet/intel/ice/ice_main.c:ice_rebuild() {
	...
	err =3D ice_rebuild_rss_luts(pf);
	if (err) {
		dev_err(dev, "RSS LUT rebuild failed: %d\n", err);
		goto err_vsi_rebuild;
	}

	/* rebuild PF VSI */
	err =3D ice_vsi_rebuild_by_type(pf, ICE_VSI_PF);
	...
}

ice_vsi_rebuild_by_type() calls ice_vsi_rebuild(vsi, ICE_VSI_FLAG_INIT)->
ice_vsi_cfg_def(vsi). Because ICE_VSI_FLAG_INIT is set on vsi->flags,
ice_vsi_cfg_def() calls ice_vsi_set_dflt_rss_params(vsi), which uncondition=
ally
resets vsi->rss_size to min_t(u16, netif_get_num_default_rss_queues(),
max_rss_size). If a PF had more Rx queues configured via ethtool -L than
netif_get_num_default_rss_queues(), switched to a global LUT, and then went
through a PF reset, won't the rebuilt PF RSS LUT stay clamped to
netif_get_num_default_rss_queues() instead of vsi->num_rxq?

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ether=
net/intel/ice/ice_lib.c
> index 215244a1c043b..b83916bf90bb6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -1663,7 +1680,12 @@ int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
>  	    (test_bit(ICE_FLAG_TC_MQPRIO, pf->flags))) {
>  		vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->ch_rss_size);
>  	} else {
> -		vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->num_rxq);
> +		/* VF LUT type could change on reset, don't clamp the old value */
> +		if (vsi->type =3D=3D ICE_VSI_VF)
> +			vsi->rss_size =3D min(vsi->num_rxq,
> +					    ice_lut_type_to_qs_num(vsi->rss_lut_type));
> +		else
> +			vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->num_rxq);
> =20
>  		/* If orig_rss_size is valid and it is less than determined
>  		 * main VSI's rss_size, update main VSI's rss_size to be

[Severity: Medium]
Should the vsi->rss_size calculation and read of vsi->rss_lut_type in
ice_vsi_cfg_rss_lut_key() be inside the pf->rss_lut_lock critical section j=
ust
below?

Callers such as ice_set_channels()->ice_vsi_recfg_qs()->ice_vsi_rebuild() f=
or
the PF and ice_sriov_set_msix_vec_count()->ice_vsi_rebuild() for a VF invoke
ice_vsi_cfg_rss_lut_key() without holding pf->adapter->devlink->lock,
vf->cfg_lock, or pf->rss_lut_lock. If ice_maybe_change_rss_lut() runs
concurrently under pf->rss_lut_lock and switches the VSI to a smaller LUT,
computing vsi->rss_size outside pf->rss_lut_lock can read the old
vsi->rss_lut_type (or old vsi->rss_size) and overwrite the clamped
vsi->rss_size before ice_fill_rss_lut() fills the new LUT.

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/et=
hernet/intel/ice/ice_vf_lib.c
> index 320b393ddaaf0..03c70d62baa7e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c

[ ... ]

> @@ -1450,3 +1471,49 @@ void ice_vf_update_mac_lldp_num(struct ice_vf *vf,=
 struct ice_vsi *vsi,
>  	if (was_ena !=3D is_ena)
>  		ice_vsi_cfg_sw_lldp(vsi, false, is_ena);
>  }
> +
> +void ice_init_vf_devlink(struct ice_vf *vf)
> +{
> +	struct devlink *pf_devlink =3D priv_to_devlink(vf->pf);
> +	static const struct devlink_ops noop =3D {};
> +	struct devlink *devlink;
> +	int err;
> +
> +	lockdep_assert_held(&vf->pf->vfs.table_lock);
> +
> +	/* no VF pci_dev when the VFs were not scanned, e.g. on s390 */
> +	if (!vf->vfdev)
> +		return;
> +
> +	devlink =3D devlink_alloc_drv(&noop, 0, &vf->vfdev->dev,
> +				    ice_pf_to_dev(vf->pf)->driver);
> +	if (!devlink)
> +		return;
> +
> +	scoped_guard(devl, pf_devlink)
> +		err =3D devl_nested_devlink_set(pf_devlink, devlink);

[Severity: High]
Doesn't acquiring devl_lock(pf_devlink) inside ice_init_vf_devlink() while
holding vf->pf->vfs.table_lock introduce an AB-BA lock inversion with
ice_tear_down_devlink_rate_tree()?

When SR-IOV VFs are enabled via ice_ena_vfs()->ice_start_vfs()->
ice_init_vf_devlink(), pf->vfs.table_lock is acquired before
devl_lock(priv_to_devlink(pf)). However, ice_tear_down_devlink_rate_tree()
(called from ice_setup_tc_mqprio_qdisc() and ice_pf_dcb_cfg()) takes those =
two
locks in the opposite order:

drivers/net/ethernet/intel/ice/devlink/devlink.c:ice_tear_down_devlink_rate=
_tree() {
	struct devlink *devlink;

	devlink =3D priv_to_devlink(pf);

	devl_lock(devlink);
	mutex_lock(&pf->vfs.table_lock);
	...
}

Unlike ice_eswitch_attach_vf(), which only runs in switchdev mode,
ice_init_vf_devlink() runs unconditionally in legacy SR-IOV mode where MQPR=
IO
and DCB configurations are allowed.

> +	if (err) {
> +		devlink_free(devlink);
> +		return;
> +	}
> +
> +	vf->devlink =3D devlink;
> +	devlink_register(devlink);
> +
> +	ice_devlink_vf_resources_register(vf);
> +}
> +
> +void ice_deinit_vf_devlink(struct ice_vf *vf)
> +{
> +	struct devlink *devlink =3D vf->devlink;
> +
> +	lockdep_assert_held(&vf->pf->vfs.table_lock);
> +
> +	if (!devlink)
> +		return;
> +
> +	vf->devlink =3D NULL;
> +	devlink_resources_unregister(devlink);
> +	devlink_unregister(devlink);
> +	devlink_free(devlink);
> +}

[Severity: Medium]
In ice_init_vf_devlink() and ice_deinit_vf_devlink(), should the VF devlink
resources be registered before devlink_register() (and unregistered after
devlink_unregister(), or under a single devl_lock(devlink) section using
devl_register() and devl_unregister())?

Calling devlink_register(devlink) first marks the instance registered, sends
the DEVLINK_CMD_NEW notification to userspace, and drops devlink->lock befo=
re
ice_devlink_vf_resources_register() registers rss, lut_512, and lut_2048. A
userspace listener reacting to DEVLINK_CMD_NEW (or querying the VF devlink
instance during teardown between devlink_resources_unregister() and
devlink_unregister()) can observe the registered devlink instance with no
resources attached.

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/e=
thernet/intel/ice/virt/queues.c
> index f87ccf5d370bb..2d0aeacfdf5ba 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -1005,7 +1005,9 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *ms=
g)
>  	struct ice_pf *pf =3D vf->pf;
>  	u16 max_allowed_vf_queues;
>  	u16 tx_rx_queue_left;
> +	struct ice_vsi *vsi;
>  	struct device *dev;
> +	u16 max_lut_queues;
>  	u16 cur_queues;
> =20
>  	dev =3D ice_pf_to_dev(pf);
> @@ -1014,10 +1016,26 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *=
msg)
>  		goto error_param;
>  	}
> =20
> +	vsi =3D ice_get_vf_vsi(vf);
> +	if (!vsi) {
> +		v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> +		goto error_param;
> +	}
> +
>  	cur_queues =3D vf->num_vf_qs;
> +	/* without LARGE_NUM_QPAIRS, VF can only use the v1 queue opcodes */
> +	if (vf->driver_caps & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
> +		max_lut_queues =3D ice_lut_type_to_qs_num(vsi->rss_lut_type);
> +	else
> +		max_lut_queues =3D ICE_MAX_QS_PER_VF_VCV1;
>  	tx_rx_queue_left =3D min_t(u16, ice_get_avail_txq_count(pf),
>  				 ice_get_avail_rxq_count(pf));
>  	max_allowed_vf_queues =3D tx_rx_queue_left + cur_queues;
> +	if (req_queues > max_lut_queues) {
> +		vfres->num_queue_pairs =3D max_lut_queues;
> +		goto error_param;
> +	}
> +
>  	if (!req_queues) {
>  		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
>  			vf->vf_id);

[Severity: Medium]
When req_queues > max_lut_queues in ice_vc_request_qs_msg(), what happens if
max_allowed_vf_queues is smaller than max_lut_queues?

Setting vfres->num_queue_pairs =3D max_lut_queues and jumping to error_param
offers max_lut_queues to the VF without clamping to max_allowed_vf_queues, =
so
the VF's retry with the suggested count will fail again if the PF has fewer
than max_lut_queues available. Also, since max_lut_queues is at most
ICE_MAX_QS_PER_VF (256), the subsequent else if (req_queues > ICE_MAX_QS_PE=
R_VF)
branch in ice_vc_request_qs_msg() becomes unreachable. Should max_lut_queue=
s be
folded into the upper bound alongside ICE_MAX_QS_PER_VF and
max_allowed_vf_queues?

> diff --git a/drivers/net/ethernet/intel/ice/virt/rss.c b/drivers/net/ethe=
rnet/intel/ice/virt/rss.c
> index 960012ca91b53..8bc984c9cf72d 100644
> --- a/drivers/net/ethernet/intel/ice/virt/rss.c
> +++ b/drivers/net/ethernet/intel/ice/virt/rss.c
> @@ -1746,7 +1747,13 @@ int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *m=
sg)
>  		goto error_param;
>  	}
> =20
> -	if (vrl->lut_entries !=3D ICE_LUT_VSI_SIZE) {
> +	vsi =3D ice_get_vf_vsi(vf);
> +	if (!vsi) {
> +		v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> +		goto error_param;
> +	}
> +
> +	if (vrl->lut_entries !=3D vsi->rss_table_size) {
>  		v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
>  		goto error_param;
>  	}
> @@ -1762,7 +1769,7 @@ int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *ms=
g)
>  		goto error_param;
>  	}
> =20
> -	if (ice_set_rss_lut(vsi, vrl->lut, ICE_LUT_VSI_SIZE))
> +	if (ice_set_rss_lut(vsi, vrl->lut, vrl->lut_entries))
>  		v_ret =3D VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
>  error_param:
>  	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_LUT, v_ret,

[Severity: Low]
This isn't a bug, but ice_vc_config_rss_lut() now calls ice_get_vf_vsi(vf) =
and
checks !vsi twice in a row. Can the second lookup just after the
ICE_FLAG_RSS_ENA check be dropped?

> diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net=
/ethernet/intel/ice/virt/virtchnl.c
> index ca8018e3dd428..dc4f7b2b55b2d 100644
> --- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c

[ ... ]

> @@ -2901,6 +2919,20 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, stru=
ct ice_rq_event_info *event,
>  	case VIRTCHNL_OP_GET_QOS_CAPS:
>  		err =3D ops->get_qos_caps(vf);
>  		break;
> +	case VIRTCHNL_OP_GET_MAX_RSS_QREGION:
> +		err =3D ops->get_max_rss_qregion(vf);
> +		break;
> +	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
> +		err =3D ops->ena_qs_v2_msg(vf, msg, msglen);
> +		if (!err)
> +			ice_vc_notify_vf_link_state(vf);
> +		break;
> +	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
> +		err =3D ops->dis_qs_v2_msg(vf, msg, msglen);
> +		break;
> +	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
> +		err =3D ops->map_q_vector_msg(vf, msg, msglen);
> +		break;

[Severity: Medium]
With up to 256 VF queues enabled and VIRTCHNL_OP_MAP_QUEUE_VECTOR wired up =
to
ice_vc_map_q_vector_msg(), can q_vector->num_ring_rx and q_vector->num_ring=
_tx
overflow when a VF maps all 256 queues onto a single interrupt vector?

In struct ice_q_vector, both counters are u8:

drivers/net/ethernet/intel/ice/ice.h:struct ice_q_vector {
	...
	u8 num_ring_rx;			/* total number of Rx rings in vector */
	u8 num_ring_tx;			/* total number of Tx rings in vector */
	...
};

When a VF has 256 queues and maps all 256 Rx or Tx rings to one vector in
ice_vc_map_q_vector_msg() (or during initial mapping in
ice_vsi_map_rings_to_vectors() if the VF has only 1 queue vector), incremen=
ting
num_ring_rx or num_ring_tx 256 times wraps the u8 counter to 0, causing
ice_vsi_release_msix() and ice_cfg_itr() to treat the vector as having no r=
ings
attached. Should num_ring_rx and num_ring_tx in struct ice_q_vector be u16?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103141646.3036=
20-1-przemyslaw.kitszel@intel.com?part=3D15
