Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9C8CA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 12:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B87E440967;
	Sat, 10 Oct 2026 12:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ck4uHcf3nKGG; Sat, 10 Oct 2026 12:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A518340964
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634574;
	b=Bo7fzyNsXeIqT1UVgmhrLlKYAQ77KZ5D07Ul2LvbHuyeIfUN5QrUXoyXXsOXOHWVdmbw
	 dSovQBVVuvwo1p/U1zCRUAWVwjJX1HAIOE96wzyUW43XD67sE2tBUuxJsRwARsUixfeWo
	 3BChugM+vwgCuETNggvESMpc8DDwDDMYB7ICILBKmP84MWh+8Xn4Mon6bdXP1Uh6wOsuy
	 m/NNpAfKYd+ZbZZzqTn9plRtie7HtVkwDBKrE6CBZNrHZEvF+kJVVk4yPw9w403B9ZjAa
	 tR/V63cCgRRmssuRxJ/RJMm9sOneqeQglBBBXrYZPoi3UPjO/vObHecluTY6BIVu1AQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=TP2iuKzEb7h12YTtioWB7wATy5hy/hHtK2EMwMW4uvo=;
	b=hwXv8V6smo+HCXuEo/4knSSlZav33VDfNx5UMl8TwY5yuQZZgx7gWXegwNFbGX4dHKW+
	 AOPYKkpVkQbHzrSM+Alck/+Ope4Fai3otqsPJqgGr8qlHASIRQ1S192l9ZqTDVYETGeL1
	 OCgHxQdtQDuU47619dU1yGKqIMw/jZRBtEnRPQJumlnslYqkdl/4CGRfR0Q4me7UEqMIF
	 yPVp5vQJsuwBy+y3GuRZCDK9SKJci49BGsktBNeKJK3WOSOiILnMtosWeQ+wbrVKsHGCm
	 iBZD7NAo+5iL10aV0BW553h704G44ptlfTtQNo0vQfzi4MZGEr56sJ/9AqUKjSWHIiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791634574;
	bh=TP2iuKzEb7h12YTtioWB7wATy5hy/hHtK2EMwMW4uvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=G5ycElufGGmgeKe70C5qbnaKh+NYrVrc5t6SxzTzjgX+oTHNn2ur1/icX143ax1/Z
	 b5FknCLyk5knZrQ8lGMzwKy49lTAP4t+iScLsKKYtsXjTNRXNCoxbcwRg/yDJMPMbt
	 2kiZFXpwvC1HX3V+z6syAf5UeZrr0Fn2BXnjO14vvpiAvWEakCJv4+fl0qYr1wr1EX
	 q9LpDF5eTMzI5Md683DCD4XbEzbPsudyoqy15MuKPC+T8vhA28Mgzq8E2zUUk0uzcu
	 KAafQM8V8ZJDiinWB2tgYvP/j8qx3jPpnqFsi88aiQkxdG4l8wgatJGC3+UnLR8MRm
	 OMkyhAHRKdV9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A518340964;
	Sat, 10 Oct 2026 12:16:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23520156
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 215494010A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOBcnXVrNQSz for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 265F340061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634570;
 b=oAFyY8kb2+/kWcDr5Wic9lrFvbypiR0DbKSNJknkHIYFpMgaP1y+htHH8fDRG4gva0vs
 NMJYM36WZzSDaKTBGJG0BiQqLv+cmmJlW2ISMM/TjglcF3iBD9sK01yd5fJh1YYcux+Ry
 jG7QN6xJU8AhY3Mr9wyzoPVWnH5o30B2RxhlKNI+k7mVOFuJzlbdtNRi34OnjQXSXW530
 jOJ2kOb1ZkTbkle0Pqh+g3J8w+w2BnZg5qD0O193ZVC5DI1yxLExDibwex3hsBqUYqO8P
 YqSY5H6kbqLKk/vQ9bNONRw4DOT8uIuJECSPgPpZRn439Dl2hIqFZkdXpq0ULbe2N/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634570;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=TP2iuKzEb7h12YTtioWB7wATy5hy/hHtK2EMwMW4uvo=;
 b=NyUlRXhXUbQu6QKE42Hk7DH3OAT/l5nSfkb+1M2wBOwRyMPPKkwAn072SqhNmUT4Jp7R
 JqBOF/ORTEkgcLBzt678KuDywf0Kii13GgcqhVyateX4Lc0fHeGaUB1NjCgjgEI4IAGLY
 1TYjJKECABzgcetWNalhN4Jytt41wXyYwL6y0Yf3Blnjl25ck+1wJ6ndEaNaBIeqNoJ0J
 zCZi30zLCtv50+1A0Pwg+3CGFv1egoZGAmTztG6XHeytxDCqLpncpMSjEv2lBoAO3uo3l
 PkKGs+H6waCFjyI1PUAH5JkdY/WXA4Duf6lhT6M4NyRpsPyXPqyrrMI3otDaG9Ti6yw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NCtesvGw; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NCtesvGw
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 265F340061
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A76F401C2;
 Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E91F000FF;
 Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634569;
 bh=TP2iuKzEb7h12YTtioWB7wATy5hy/hHtK2EMwMW4uvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NCtesvGwQQRozFHPfNyUpLkuhjYErTrfCVRHqrEc98EUOjoRlH4cC486l58Vv8BI4
 ec0NKXoECHb0ecphvmE/Q+BhZ6IajiIXafIws5095620M1ujxOGFdUL7D7F8opDLz2
 VAJe0HiepJnOCKcas0Ujn7BpV5XKqwt77rJ/l2n92mQHQXc+q1xCpJsVoSBKYxGQuC
 nIjQCsvQj6CuFSvQrUIUtRNczhyeuC4vkEmA+xkPaEJcbECdfrOuAfIffcuDV2k3NS
 Oae6n/g4qTMmT7MKJJ8imDUEv5FR/MJ/Eb3y6rz+T3l3RBxG2WGsb/VFfWeq1baUW8
 e3S3v+z4BzMhg==
Message-ID: <sashiko-outbox-166509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 14/14] ice: support up to 256 VF queues
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009121433.30347-15-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-15-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:16:08 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] ice: AB-BA deadlock between PF devlink lock and vfs.table_lock
- [High] ice: Hardware out-of-bounds queue programming due to bypassed VF r=
ss_size clamping
- [Medium] ice: Devlink resource wipe on PF VSI rebuild breaks VF isolation
- [Medium] ice: Indefinite deferral of VF resets due to missing service tas=
k wakeup
--

commit f0498e5b28b0f370443f9612e9323e5875839c0d
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: ice: support up to 256 VF queues

This commit adds support for configuring up to 256 VF queues by allowing the
devlink assignment of GLOBAL or PF RSS LUTs to VFs. It introduces a devlink
instance for VFs to track RSS LUT resources under the PF devlink instance.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ether=
net/intel/ice/ice_lib.c
> index ad43d52ea83cb..43c8bfedbea23 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c

[ ... ]

> @@ -1663,7 +1680,9 @@ int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
>  	    (test_bit(ICE_FLAG_TC_MQPRIO, pf->flags))) {
>  		vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->ch_rss_size);
>  	} else {
> -		vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->num_rxq);
> +		/* VF rss_size is the queue capacity of its LUT, keep it */
> +		if (vsi->type !=3D ICE_VSI_VF)
> +			vsi->rss_size =3D min_t(u16, vsi->rss_size, vsi->num_rxq);

[Severity: High]
Could bypassing this clamp cause hardware out-of-bounds queue programming?

When a GLOBAL LUT or PF LUT is assigned to a VF via devlink, vsi->rss_size
is updated to the maximum capacity of the LUT (such as 64 or 256), and a
deferred VF reset is scheduled. During the VF rebuild, this change
intentionally bypasses clamping vsi->rss_size to vsi->num_rxq for VFs.

If the VF only has its default number of queues allocated (for instance, 4)
but the hardware RSS LUT is populated with queue indices up to 63 or 255,
will the hardware steer incoming packets to unallocated queues? This seems
likely to trigger fatal Malicious Driver Detection (MDD) events or silent
packet blackholing.

[ ... ]

> @@ -2697,11 +2716,11 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
>  	if (vsi->flags & ICE_VSI_FLAG_INIT) {
>  		if (vsi->type =3D=3D ICE_VSI_PF) {
>  			ice_free_rss_lut_flr(pf);

[Severity: Medium]
Does this unintentionally wipe the devlink resource tracking for VFs without
reprogramming the hardware?

When a PF VSI is rebuilt (for example, during an MTU change or via
ethtool -L), ice_vsi_decfg() calls ice_free_rss_lut_flr(). That function
clears the software devlink owner state for all GLOBAL LUTs assigned to
VFs of this PF.

However, it does not reprogram the VF hardware or issue a VF reset. The
VFs will continue to use the LUTs in hardware while the devlink manager
believes they are free. If devlink assigns the freed LUT to a different
VF, could this result in shared queue mappings that break VM network
isolation and corrupt traffic routing?

> -			/* reset restores PF LUT, user LUT has wrong size */
> -			if (vsi->rss_lut_type !=3D ICE_LUT_PF) {
> -				devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);
> -				vsi->rss_lut_user =3D NULL;
> -			}
> +		} else if (vsi->type =3D=3D ICE_VSI_VF) {
> +			struct ice_vf *vf =3D vsi->vf;
> +
> +			vf->num_req_qs =3D 0;
> +			vf->num_vf_qs =3D min(vf->num_vf_qs, pf->vfs.num_qps_per);
>  		}
>  	}
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/et=
hernet/intel/ice/ice_vf_lib.c
> index 320b393ddaaf0..6bc71cdc624c7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c

[ ... ]

> @@ -1010,6 +1011,18 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
>  	return err;
>  }
> =20
> +/**
> + * ice_schedule_vf_reset - reset VF, deferred to next service_task conte=
xt
> + * @vf: VF to reset
> + */
> +void ice_schedule_vf_reset(struct ice_vf *vf)
> +{
> +	set_bit(ICE_VF_STATE_NEEDS_RESET, vf->vf_states);
> +	/* pairs with test_and_clear_bit() in ice_handle_deferred_vf_reset() */
> +	smp_mb__after_atomic();
> +	set_bit(ICE_VF_RESET_PENDING, vf->pf->state);
> +}

[Severity: Medium]
Is there a missing explicit wakeup for the service task here?

The ICE_VF_RESET_PENDING bit is set to schedule a deferred reset. However,
the service task loop in ice_service_task() does not include
ICE_VF_RESET_PENDING in the list of flags that keeps its timer active.

If the system is otherwise idle, wouldn't this delay the reset indefinitely
until an unrelated event triggers the service task? This could create a race
condition where subsequent user configuration commands fail because the VF
has not yet applied the prior devlink resource changes.

[ ... ]

> @@ -1450,3 +1466,44 @@ void ice_vf_update_mac_lldp_num(struct ice_vf *vf,=
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
> +	devlink =3D devlink_alloc(&noop, 0, &vf->vfdev->dev);
> +	if (!devlink)
> +		return;
> +
> +	scoped_guard(devl, pf_devlink)

[Severity: High]
Does this locking sequence create an AB-BA deadlock with devlink callbacks?

Here, pf->vfs.table_lock is already held (as asserted above), and we acquire
the PF devlink instance lock via scoped_guard(devl, pf_devlink).

However, in devlink callbacks like ice_tear_down_devlink_rate_tree(), the
PF devlink instance lock is acquired first, followed by
mutex_lock(&pf->vfs.table_lock).

If SR-IOV configuration runs concurrently with a devlink rate tree teardown,
could this inverted locking order cause a deadlock?

> +		err =3D devl_nested_devlink_set(pf_devlink, devlink);
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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121433.3034=
7-1-przemyslaw.kitszel@intel.com?part=3D14
