Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B07606A32A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EzLdj0VZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFWUrWkv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC766067D;
	Wed, 18 Nov 2026 00:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CAJo2cvrCK8a; Wed, 18 Nov 2026 00:45:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 249C460730
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794962700;
	b=GBNTxL9/evrRWQOp3HqKVPRFf4iVZB3vLSIrGypfED+b9bpvs5Dl7Jvep/oa+gfDD4iB
	 jLCgAFuZEdpxuCxVua6usT4T/vCHpTbulFLsLYT4f3SdF08mcZTNN27t6OomiIzJLsgbU
	 H8CS9saidzmZV+JGEtSgach9Pqu1/yd15nnhidJgyVijgdA8nElxIgZQnE62K7vMuN0X6
	 gBnA01G2dnyk/ElboZomgcXP2YnqVe2FlIJtl69SuoRStifNKoiR0S3t+jqYP6Ud4LPpB
	 233XwJJcQtvVPGqThV07G9h3Gj7ZnKjZQDPOuObOq1Bs+z2vftR8q7uGHYSG5+PUkow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794962700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qeM8aQhnr2W+eAXVLBOwjgQWvqFMdyvMXMDBQ7FPGEs=;
	b=XRBhs2CDsdemm5y60Jwr5+81v+H7hIzrEfu7Eyr0POfhDXDei1jEakEo8M3UOcXWxyM2
	 6FH87VJcUNZPTCN5Df4svcQXDjOf510Uxsx2kUMVeXpl2ni0ySSiJvJCKq3EueiICjPQF
	 EiPdAzWybJ+M+RixQN3xkT409Lfe7+uhhb2LzcUWHyVIKuvIOJFcf+a3B2D1dIyNbIkZJ
	 KSMoM89wiC9A3BQ/wTOxZ+vHg3iiqWeQ3ZqQX205unbTZ3/8IaofC7H/Uo9TTCx8DgPC7
	 UThwRmln2E/Q526O+5c2Y+H41JGK63eFjRWwNGCmCVSqRVDuOyh4fx4rmzL4WE9xtbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794962700;
	bh=qeM8aQhnr2W+eAXVLBOwjgQWvqFMdyvMXMDBQ7FPGEs=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=EzLdj0VZlMmIFmQs78OpkByGPfdeccrOX+b9c26sXegNxjviU64auDjZueFi7yKwI
	 6ZyFfi5Xf7qjDmhYBm0O9PAK2TlYo5679Igf3QpnE/I0Fz0aj5Yp38HFBX6Y+1I8zg
	 t3bxb3XK4l0CYklTB41uMWY72gXCgMpWXkLCogIFllkSVTJ+iINSB8m3Q8QYw2H2bt
	 zUHB1vFtvoYLO0NtZylbbTFwrqW8b54pXS3g6BjGyYHjjO6ZQSC6UMkOQh7gpIfOOx
	 qP926s7JHga0hQoslvUs7w9le8XRo7kapaJ6sgI9Zwj6MUYFAOk/kbuNjNcOToTzmz
	 q6lgW/aI8VrBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 249C460730;
	Wed, 18 Nov 2026 00:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D0D549B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EE974005F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G39e8k3kbjD0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 397724005D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FFWUrWkv
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 397724005D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1186D446B9;
 Wed, 18 Nov 2026 00:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBD81F000C7;
 Wed, 18 Nov 2026 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794962697;
 bh=qeM8aQhnr2W+eAXVLBOwjgQWvqFMdyvMXMDBQ7FPGEs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FFWUrWkvofvCn5QQfkck2MDBJ4OcOF6YRtMu06GKUacxnapncW5uEgTBC2GNPUNhW
 o0yLuVKScZBnjVPbBGCcKlwm/aObx7puAUR9x83B+6NkFqibYFPczrzVR4c2ta8BdJ
 /Us5wja5ZZTeeNXLqgCHm3lD7I0MuerVPCslCKAMXDEaqHMX+67m4xjE4SlTI/6ZxW
 iG3P4ZYDlPX0ni0LCBdMOXgCRU5YF+nB2I7KUNWymlLq8r1U0CXWE16Xx3pvXcjps/
 hAufYTqEeQ6ocSzf8gieyI+YUOFQ7+0xnF2mFlvIQnBCAOQ2dfl+IZXfIhsBRNQj8W
 2N3VU143WU3fA==
Message-ID: <sashiko-outbox-219870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v3 3/4] ice: store cached PHC time in ice_adapter
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <20261117-jk-e825-e830-timecounter-v3-3-87ea4c86a249@intel.com>
References: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
 <20261117-jk-e825-e830-timecounter-v3-3-87ea4c86a249@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 00:44:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] ice: 32-bit build failure in ice_ptp_extend_32b_ts() on 64-bit
  update_time
--

commit a94f5b039e979b49b6aea8ea8e4275f20187401e
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: store cached PHC time in ice_adapter

This commit moves the cached PHC time and its update timestamp from
per-PF and per-Rx-ring fields into a shared struct ice_phc embedded in
struct ice_adapter, updated by the clock-owning PF under a mutex and read
locklessly during timestamp extension.

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/e=
thernet/intel/ice/ice_adapter.h
> index ce1fe08462652..ade829c05000a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -35,6 +35,25 @@ struct ice_port_list {
>  	struct srcu_struct srcu;
>  };
> =20
> +/**
> + * struct ice_phc - PTP Hardware Clock fields
> + * @cached_time: Cached copy of the PHC time for timestamp extension
> + * @update_time: Monotonic time when PHC was laste updated
> + * @lock: For protecting updates to the PHC fields.
> + *
> + * Readers are lockless and rely on READ_ONCE/WRITE_ONCE for the cached_=
time
> + * and smp_acquire/smp_release for the update_time field.
> + *
> + * Writers must acquire the lock mutex to ensure that the periodic task =
cannot
> + * write back an out-of-date cached value after a clock adjustment.
> + */
> +struct ice_phc {
> +	u64 cached_time;
> +	ktime_t update_time;
> +	/* Serialize updates to cached_time */
> +	struct mutex lock;
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index bf37c2a7ff863..d07dcf619bb18 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -309,13 +310,26 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
>   * This is prevented by (a) periodically updating the cached PHC time on=
ce
>   * a second, and (b) discarding any Tx timestamp packet if it has waited=
 for
>   * a timestamp for more than one second.
> + *
> + * Return: the extended timestamp value, or 0 if phc->update_time is sta=
le.
>   */
> -static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
> +static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc,
> +				 u32 in_tstamp, bool trace_rx)
>  {
> +	u64 ns, cached_phc_time;
>  	u32 delta, phc_time_lo;
> -	u64 ns;
> +	ktime_t update_time;
> =20
> -	/* Extract the lower 32 bits of the PHC time */
> +	/* Discard the timestamp if update_time hasn't been initialized */
> +	update_time =3D smp_load_acquire(&phc->update_time);
> +	if (!update_time)
> +		return 0;
> +
> +	/* Discard the hardware timestamp if the cached PHC time is too old */
> +	if (ktime_ms_delta(ktime_get_coarse(), update_time) > 2000)
> +		return 0;
> +
> +	cached_phc_time =3D READ_ONCE(phc->cached_time);

[Severity: High]
Does calling smp_load_acquire() and smp_store_release() (in
ice_ptp_update_cached_phctime()) on phc->update_time break 32-bit builds?

ktime_t is a 64-bit s64 on all architectures, whereas smp_load_acquire()
and smp_store_release() enforce compiletime_assert_atomic_type(), which
requires a native word size up to sizeof(long).  On 32-bit builds with
CONFIG_ICE and CONFIG_PTP_1588_CLOCK enabled, compilation fails with
"Need native word sized stores/loads for atomicity".

In addition, lockless READ_ONCE() and WRITE_ONCE() accesses on 64-bit
phc->cached_time and phc->update_time are not atomic on 32-bit
architectures and can tear when ice_ptp_extend_32b_ts() runs concurrently
with ice_ptp_update_cached_phctime().  The follow-up commit "ice: use
struct timecounter for E825 and E830" keeps these smp_load_acquire() and
smp_store_release() calls on phc->update_time.  Protecting the fields
with a seqcount_t or u64_stats_sync (or storing a word-sized jiffies
timestamp when a 64-bit read isn't needed) would avoid both the build
failure and 64-bit tearing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-jk-e825-e8=
30-timecounter-v3-0-87ea4c86a249@intel.com?part=3D3
