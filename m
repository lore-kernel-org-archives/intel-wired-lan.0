Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF6606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ca+wk6m3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgiBO076
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65F2A606BB;
	Wed, 18 Nov 2026 00:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0h_eJvk-TSE; Wed, 18 Nov 2026 00:50:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7224660729
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794963030;
	b=fjEoHzute9YMcQZ8uuYF412SWKRAysZd78WZ2HlZAku5WvNjEjDfh1Qik3N1GlgPgw20
	 slZmvHCfC0tD1kuDIxgeodaITK1rxL4mTqd9yWxSYZk3CrU5cBe7P/IXzrz0cKhuvldQ1
	 8nFX+OlzIA7lSEtiaCxfvxjwF7+74+zXUtELy2QXdMNpj0kSs7B7K6uQv0gWyVZfKWJw1
	 aK33ESoB88i0KOhtR2GN2GYMOMPz2wjfXsU8M1pj3H8BM9/RVtMMMLcEDlToP1py0JJvY
	 gNe3Vh8DColaox8W5w8G28CXl2uWTA+XI3yWDiiYoX+JyL80CEKm5kNUrKIgXY978UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794963030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=KM8/ZosvPtQRm1P6/2KuFO/1HYH4BDRoJr0+QhWGVco=;
	b=leGOFViCeq/RLrxtFn7OABnyy2hWZOWwH8t4C6q5hV3B5SIEatZntMc4lUfqzel1FQz/
	 DoSN6zXebPGx4pwFxxzqEL/vSs0bACKBaPKHT13suV2MstkxsWAwZLV7Ekt+HoxXd5bvQ
	 TN9zUcWMW11fnqe3fWAOSAWB62nltHC2L99S0tFJONXRssNY2RNeTbKspkFdL5Tl4pryi
	 qoDB2pDWr/RLV9tMqTJj2sJaMy6ST74Eh7oPBEACuS0RyIO0S64lNK6LGCpnwIuqbo4c1
	 WbgtbYGMtS8n/vdkQ56LXxFN5yxfticQCxBpkSixYgzIx91vo/niQQoJXtuU9qDrmtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794963030;
	bh=KM8/ZosvPtQRm1P6/2KuFO/1HYH4BDRoJr0+QhWGVco=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ca+wk6m3/w3h3mz3LOizfUBruO/Vi2Gk2vhoyOyUy4r2fcsbYzAopML5j9ljwOshL
	 0pAwuEpmK7BR0U2K9CWOGwQsrBj4YW6vRieu9100cCgKugFRemuaiOBQ2RvW/ehVXc
	 tdca30LZPG1o+6DYO8OgwF5Fbp/dApnD8OBi7kqrYTXKrWNIKQR36W8SXQhe6GsJIf
	 DvqLAMEQFn89UFqPqEMXu20wVBvV2Wm/uKvRYYVwFBEyO6s+u4ZAct9dmIaujsO8U8
	 5r+Koe89TSYv2W/5qQTcPigcdUwBDAMcEDo+1Tz0HnnrokQfEhBvHe3kd0zoDqSNMN
	 CyhvetuiozA7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7224660729;
	Wed, 18 Nov 2026 00:50:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D45AD49B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C59BB8108C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_EtaCpjgmcH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:50:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2FFC80F6D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MgiBO076
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2FFC80F6D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:50:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E59B444693;
 Wed, 18 Nov 2026 00:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D58B1F000C4;
 Wed, 18 Nov 2026 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794963027;
 bh=KM8/ZosvPtQRm1P6/2KuFO/1HYH4BDRoJr0+QhWGVco=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=MgiBO076HaJ0sNO9MuOKQTfKoyBYrra7LdqsZBOveg9nZ6GZ0SroMaAeSJUpVvq95
 Ny6sCseLN9VKAnWy0KqriizEHqS/TnYlkO9gD+gcvnRmYJ2J+X3my8IyI19I16eRTY
 DLC5GRzCVG+YbOiVLu7bT2wMil+1QMUnZAdaG1XXkE9yI0e/dSOIM5PbxTfG4l5rM1
 KmiSPGxGYCJfcPAs+6OXP6DFMXBjSqvVWIGYJ0HZxYDBiBmiKQ8uSpAGD3GgFABoJM
 UI/eoo/+adLsXPG/rbu/f/MgMJ6byv58Udevv0N0SfuN7VryTtfQ8zTw0MKoV5mgx3
 48knemMncNqJw==
Message-ID: <sashiko-outbox-219882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v3 4/4] ice: use struct timecounter for E825
 and E830
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <20261117-jk-e825-e830-timecounter-v3-4-87ea4c86a249@intel.com>
References: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
 <20261117-jk-e825-e830-timecounter-v3-4-87ea4c86a249@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 00:50:27 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ice: unreleased phc->lock on error path in
  ice_ptp_rebuild_owner()
- [Medium] ice: premature phc->update_time store in
  ice_ptp_read_cycles()
--

commit b8fa2e5442cd684f10151ff2ab484f07d9521f1c
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: use struct timecounter for E825 and E830

This commit switches E825 and E830 devices to use a seqcount_latch-protected
timecounter and cyclecounter in struct ice_phc instead of directly adjusting
the hardware PHC timers and using the legacy timestamp extension logic.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index d07dcf619bb18..a74a2075e5f53 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -272,6 +272,202 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
>  	return 0;
>  }
> =20
> +/**
> + * ice_ptp_read_cycles - cyclecounter read() callback function
> + * @cc: the hardware cycle counter structure
> + *
> + * Read the PHC time via ice_ptp_read_src_clk_reg() and report it for use
> + * within timecounter_read() and timecounter_init().
> + *
> + * Although the cycle counter is masked to 32-bits for timestamp extensi=
on,
> + * this still reports the full 64-bit time to enable determining the pha=
se
> + * difference between the PHC hardware value and the timecounter properl=
y.
> + *
> + * Return: The current PHC timer value from the hardware on success.
> + *         Since failure cannot be meaningfully reported, return the pre=
vious
> + *         cycle_last value when unable to access the device.
> + */
> +u64 ice_ptp_read_cycles(struct cyclecounter *cc)
> +{
> +	struct ice_adapter *adapter;
> +	struct ice_phc *phc;
> +	struct ice_pf *pf;
> +	u64 time;
> +	int err;
> +
> +	phc =3D container_of(cc, struct ice_phc, cc);
> +	adapter =3D container_of(phc, struct ice_adapter, phc);
> +
> +	scoped_guard(rcu) {
> +		pf =3D rcu_dereference(adapter->ctrl_pf);
> +		if (!pf)
> +			return phc->tc[0].cycle_last;
> +
> +		err =3D ice_ptp_read_src_clk_reg(pf, NULL, &time);
> +		if (err)
> +			return phc->tc[0].cycle_last;
> +
> +		/* Paired with smp_load_acquire in ice_ptp_extend_32b_ts */
> +		smp_store_release(&phc->update_time, ktime_get());
> +		return time;
> +	}
> +}

[Severity: Medium]
Can publishing phc->update_time inside ice_ptp_read_cycles() allow
ice_ptp_extend_32b_ts() to extend a timestamp against an uninitialized or
stale phc->tc[1]?

In ice_phc_init() and ice_phc_refresh(), write_seqcount_latch_begin() sets
phc->seq to an odd value (directing readers to phc->tc[1]) before calling
timecounter_init() or timecounter_read() on phc->tc[0]:

CPU0                                  CPU1
ice_phc_init()
  write_seqcount_latch_begin(&phc->seq)
  timecounter_init(&phc->tc[0], ...)
    ice_ptp_read_cycles()
      smp_store_release(&phc->update_time, ...)
                                      ice_ptp_extend_32b_ts()
                                        smp_load_acquire(&phc->update_time)
                                        ice_phc_cyc2time_with_trace()
                                          seq =3D read_seqcount_latch(&phc-=
>seq)
                                          /* idx =3D=3D 1 */
                                          timecounter_cyc2time(&phc->tc[1],=
 ...)
                                          <-- reads uninitialized/stale tc[=
1]
    phc->tc[0].cycle_last =3D ...
    phc->tc[0].nsec =3D ...
  write_seqcount_latch(&phc->seq)
  phc->tc[1].cycle_last =3D ...
  phc->tc[1].nsec =3D ...
  write_seqcount_latch_end(&phc->seq)

Because read_seqcount_latch_retry() succeeds while phc->seq remains at the
same odd value, the reader converts the hardware timestamp using the old
phc->tc[1] instead of discarding it or using the updated timecounter.
Updating phc->update_time after write_seqcount_latch_end() (or after
write_seqcount_latch() once phc->tc[0] is populated and latched) would avoid
exposing update_time before a valid timecounter snapshot is visible.

[ ... ]

> @@ -3207,14 +3519,24 @@ static int ice_ptp_rebuild_owner(struct ice_pf *p=
f)
>  	if (phc->update_time) {
>  		s64 delta =3D ktime_sub(ktime_get(), phc->update_time);
> =20
> -		ts =3D ns_to_timespec64(phc->cached_time + delta);
> +		if (phc->use_timecounter)
> +			ns =3D phc->tc[0].nsec + delta;
> +		else
> +			ns =3D phc->cached_time + delta;
>  	} else {
> -		ts =3D ktime_to_timespec64(ktime_get_real());
> +		ns =3D ktime_get_real_ns();
> +	}
> +
> +	if (phc->use_timecounter) {
> +		ice_phc_init(phc, ns);
> +	} else {
> +		struct timespec64 ts =3D ns_to_timespec64(ns);
> +
> +		err =3D ice_ptp_write_init(pf, &ts);
> +		if (err)
> +			goto err_unlock;
>  	}
>  	mutex_unlock(&phc->lock);
> -	err =3D ice_ptp_write_init(pf, &ts);
> -	if (err)
> -		goto err_unlock;

[Severity: Medium]
Does jumping to err_unlock when ice_ptp_write_init() fails leave phc->lock
held?  The err_unlock path only calls ice_ptp_unlock(hw), so any subsequent
attempt to acquire phc->lock on a non-timecounter device will deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-jk-e825-e8=
30-timecounter-v3-0-87ea4c86a249@intel.com?part=3D4
