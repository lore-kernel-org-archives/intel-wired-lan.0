Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FC606A881
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1+oT5mHV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn7y3kyR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E9B2606EA;
	Fri, 13 Nov 2026 23:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Slq9GYL7U7zU; Fri, 13 Nov 2026 23:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CEC7C6063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794613968;
	b=eEYTkp55N5f2uGUtQsagVFiSQ1gTJucHLt0REC/q9MuaFfFKhaBAtjlSLR1Exro40l8Z
	 /PbSCCRjNuWPAG8S7WfKrKUhex0/SoQ1iiFvoTL1tiSRoJwO7+KCKYmvSvGtjez6qx7My
	 VROmFZuSeZDXK2xLtFnd3+0l3SOoKF0a+xF2Q106y3cIm8BkA0wQY6tRgSFNMtUhwfpm+
	 0ua1EoxTNLx2iPZEZGtJz0/xmR2Xrkbit2783ttFAsaiokbYsPn+Rpl2+9MzFY69Xr6ai
	 TGd9YhGbgJN6gvTSKv3V9RRwEK/2ee2CyRfjTSSL70L40TAA/a2Z3ug/h2MuzZodsMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794613968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Ff/BmaL7scNp3we2xZphkAit9jmnRbr78KsxLzfOp8A=;
	b=P94DEfBhnKFX6aJB/sDrFPKBzMz+TC+0QkYGnVBtLjcKSJBdfzpGQw9+BKDUquRdeaEw
	 LRyD6omz047n451nz3RvI2kf7KylhBvM/khllg5WFJ4s0KnHjYPhbTPPiBZ/yyU/ddDzq
	 R5Xg4SXi2Uz56oiXLXbJWKXWa0RQjH3bv7dB0Pz5QRtZ+zpyM245QLxT2bn+cXMkvFspP
	 QsV+o4f32svwKeghY41hO1C4+g/MzjpRA1XslwMf3/gbO9pvvzAP437Ej2ayPNMiZnIb5
	 iN9i/BiUGTigkVm7iNVRN7gwWdCoPwiFViVQ4wo0TeUl4t4CPaM0OuL8AciWP+tBqJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794613968;
	bh=Ff/BmaL7scNp3we2xZphkAit9jmnRbr78KsxLzfOp8A=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=1+oT5mHVLTJon3ZTA6U3oi8eD4nP81Tn+tMxVfK1KbVIvjPr8gu/V9pt3R8E+uuqM
	 /8m+63BGChCegCMvTAvbPDB/aQ1/IH8hmYjFxBdLWtmnbvixAEYx3TcoJdTIB1NioM
	 BXmKLjCt8seIQciDERkVk5dqdYIDhzQ5McGSsLfU3qmgNAGPmoHAYf7u/xTIuvK3lh
	 1tE+orTK+2E8dUFot/WGqKinnLWP+BR82OL/n9UNEdoLOiywg1XjuQvNx8cQck0ZaE
	 m0hwK5d4Zr1DbYuS+5iR7H3az5rQJDH6YMRSuDHv+LKAUBJx7FG5heoKBOKeDW9oht
	 cLSvAKxE9U4aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEC7C6063E;
	Fri, 13 Nov 2026 23:52:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9637A28C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87A4740921
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Na1kYAGucKef for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 23:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68F684091F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Bn7y3kyR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68F684091F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:52:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 744A462664;
 Fri, 13 Nov 2026 23:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE081F000C4;
 Fri, 13 Nov 2026 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794613965;
 bh=Ff/BmaL7scNp3we2xZphkAit9jmnRbr78KsxLzfOp8A=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Bn7y3kyRnWi4EyG6HQYEZbjlrl54VSjp0ojA+i9l1Ie2SpNwOPd/iSoqjsspDkl6g
 TqiZHZTS4aGm00EOXoJA7NC3j1MqSBTUgfoKaxIdDAeQJ3WbJCGXpVhLBEbDemUg/k
 tcgXdD8GIa9TrguJzP814Qo3oeF+J8GfZLfW7DhSEPLTOqjz40hyIE+34XS7pBJ7pO
 JQYmbziFeULA5xnmXphaBxwZ/qCx4lkIwxg4BUqws5dNRdDxVSSVeeoILVniE6bqoc
 sDM1/jrCd1efqbARJwZ1DkBz4rA5PUqmpCW6bxuDJHsWf20CRhGTPgTkdmWBTX6TRG
 pD5JRFyXM/Lcw==
Message-ID: <sashiko-outbox-213880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v2 3/4] ice: store cached PHC time in ice_adapter
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <20261113-jk-e825-e830-timecounter-v2-3-9c357a7ed349@intel.com>
References: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
 <20261113-jk-e825-e830-timecounter-v2-3-9c357a7ed349@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:52:44 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] ice: stale adapter->phc cache across reset in
  ice_ptp_rebuild_owner()
--

commit 3e2553cade32eeca4938b383704866bc53bd38ea
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: store cached PHC time in ice_adapter

This commit moves the cached PHC time and its update timestamp from the
per-PF ice_ptp and Rx ring structures into a shared struct ice_phc embedded
in ice_adapter, updated only by the clock owner PF.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index bf37c2a7ff863..a0451c1083a41 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
[ ... ]
> @@ -3099,24 +3056,20 @@ static void ice_ptp_periodic_work(struct kthread_=
work *work)
>  {
>  	struct ice_ptp *ptp =3D container_of(work, struct ice_ptp, work.work);
>  	struct ice_pf *pf =3D container_of(ptp, struct ice_pf, ptp);
> -	int err;
> =20
>  	if (pf->ptp.state !=3D ICE_PTP_READY)
>  		return;
> =20
>  	ice_ptp_tspll_monitor(pf);
> =20
> -	err =3D ice_ptp_update_cached_phctime(pf);
> +	if (ice_pf_src_tmr_owned(pf))
> +		ice_ptp_update_cached_phctime(pf);
> =20
>  	ice_ptp_maybe_trigger_tx_interrupt(pf);
> =20
> -	/* Run twice a second, or retry soon if another thread was busy
> -	 * updating the Rx rings. Other errors, such as a missing control PF,
> -	 * do not clear up on their own and must not turn the periodic worker
> -	 * into a busy loop.
> -	 */
> +	/* Run twice a second */
>  	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
> -				   msecs_to_jiffies(err =3D=3D -EAGAIN ? 10 : 500));
> +				   msecs_to_jiffies(500));
>  }
> =20
>  /**
> @@ -3211,6 +3164,8 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, e=
num ice_reset_req reset_type)
> =20
>  	/* Acquire PHC and system timer to restore after reset */
>  	ptp->reset_time =3D ktime_get_real_ns();
> +	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
> +		ptp->phc_reset_time =3D 0;
>  }
> =20
>  /**
> @@ -3250,13 +3205,13 @@ static int ice_ptp_rebuild_owner(struct ice_pf *p=
f)
>  	if (err)
>  		goto err_unlock;
> =20
> -	/* Write the initial Time value to PHY and LAN using the cached PHC
> -	 * time before the reset and time difference between stopping and
> -	 * starting the clock.
> +	/* Write the initial Time value to PHY and LAN using the PHC time
> +	 * before the reset and time difference between stopping and starting
> +	 * the clock.
>  	 */
> -	if (ptp->cached_phc_time) {
> +	if (ptp->phc_reset_time) {
>  		time_diff =3D ktime_get_real_ns() - ptp->reset_time;
> -		ts =3D ns_to_timespec64(ptp->cached_phc_time + time_diff);
> +		ts =3D ns_to_timespec64(ptp->phc_reset_time + time_diff);
>  	} else {
>  		ts =3D ktime_to_timespec64(ktime_get_real());
>  	}

[Severity: Medium]
Does ice_ptp_rebuild_owner() leave a stale cached_time in pf->adapter->phc
across a non-PFR reset?

When a reset such as EMPR zeroes GLTSYN_TIME before
ice_ptp_prepare_for_reset() reads it, ptp->phc_reset_time is 0 and
ice_ptp_rebuild_owner() reinitializes the hardware clock to
ktime_get_real() (UTC) via ice_ptp_write_init(), which can differ from a
pre-reset TAI PHC by 37 seconds.  Neither ice_ptp_prepare_for_reset() nor
ice_ptp_rebuild_owner() invalidates or refreshes pf->adapter->phc after
writing the new time, and non-owner PFs no longer update the cache in
ice_ptp_periodic_work().

If the reset and rebuild finish within 2000 ms of the last pre-reset
update, ice_ptp_extend_32b_ts() still sees a fresh phc->update_jiffies and
extends post-reset Rx and Tx hardware timestamps against the pre-reset
phc->cached_time until the owner PF's kworker runs
ice_ptp_periodic_work().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-jk-e825-e8=
30-timecounter-v2-0-9c357a7ed349@intel.com?part=3D3
