Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3F606A31A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ReUWJ4nc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORTkL6HV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 937FB60A4B;
	Sat, 24 Oct 2026 01:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id faHpjkPrUeVj; Sat, 24 Oct 2026 01:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C5F860A5A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792806933;
	b=bPTYPN7iViv9aFKVrajDVy8JGbbXlR34nYzEGJAmQ808a2aNB9eyUwBzdXpjCJKXC6zK
	 8wnEcPMUnN5f79d/8ClgG5Wl1aKNxy90+FyO8HhML+RPVPtT+IbLCUbomqCwClKxivOJd
	 vIRT0YBPMK7u/h1TtcahxCuZ2CJA6JJTKXRE/YWZ1VaKMuvU6x7OvGqcObd+wRy6VC67s
	 SfZjDTqTgZBNesz0Hxkq6BBJb3rFb/hfDLnKpq/ZABiP1M2QliGZfidAWctA6UwySrlKL
	 PntzRO30XfwUSOJAgqATkPfKJ3Mhcb0iPFqnQ/PmY0UcTzj7DPCMo2/SyftqQP4gr8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792806933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=JIX4wD0wrmm8VtiwkY5Wp9nS0kNdWZ4MB3FS40akN50=;
	b=aD4WvtDUvgeG/nGNLwRGOgo0QiZXsgZAGxsdLW74mJvlVLmO7QiqTmq74Er6ZOceMmzc
	 EUM7GcmjbALx8CRRJsvQYLbAl8NHj74A0mXMLeQgB0TK/vp9InsOgqnc+2Kn4MULctzqI
	 x0tTAwyOaEJlZv9Ey9el4DQHGuxYfa0wA7vFmMrTmiI8/NU0GdxXSEc0sGNMeD4Ue5fbs
	 rCcwemLDnwxJI4oxdhkp81WxYPMMksy9ZjRnXee2s8XSbO3TIN926M48awY+rtoDXV3J5
	 squbhRkNz1X0sqh+mIb/3aeE8ds2X4LvvDFhljwjolv2qzkZduMfY52yt59MtCLTN4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792806933;
	bh=JIX4wD0wrmm8VtiwkY5Wp9nS0kNdWZ4MB3FS40akN50=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ReUWJ4nctt/rK2S2lYspDA6i8Ffm3YGtmKT6dP5dBeGQz6VQGdE6iZQ4yRm8yLRcf
	 s91fggPgcTa/+r/C8iq1c3L/N7Y4RdkWTJS1xnsiRz9M6+K0lxaw+dlPa3EnS8Tmyv
	 1DmYkLmm5q+24J2fWKA5Z2++L4rH2xRP9npemlK3CGmG96mfaJ2uBvrePMZrhuDjQx
	 Rf52NW69Uie4feT7oYY5DCPWK0lyVg5F/ZB7D9tLchLqt9OvxY4B6dSvWN2fsA66vq
	 QYryVW866rk5sI6A/fynVCwAN6Q3nHy86tTu29uMYNUwfz3EcjJXXoAmOr36tAWsJ5
	 lOclFlMAkoDmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C5F860A5A;
	Sat, 24 Oct 2026 01:55:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9451356
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AAC0812CE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nUrCiF3hiyFV for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 01:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00800811A5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792806930;
 b=q1mCZJCo3bE8mV8rBBNDGp0VafxX4NkAvhfmHY1VjyCHgiChVL1EQmzGqxKEmjz6m6/0
 slcGZd64Af+BcEiVPRRFUjcqz2BDElazbJNKw9HR8QWDzVsIPKsn+tsDKP4yHSPsGFRER
 gDIUXXN7cZ+m+iIim1apE8jMDOA9w9Eab4j9dKvLYvzrnardT7jDoZ1177D0U5YKfKymj
 jStqU5C4HQ84w/lF1D3r4kx8maCYBaNmTaXk2ezqmF6JrDENyje+NtOmY7SDWxrDOebL+
 1zMfCnjG3OBRkyYWMYFyn6PqFJRarSa/ejjQQ1bdwjRrpiftnGsx77e1PKt6j3l/kOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792806930;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=JIX4wD0wrmm8VtiwkY5Wp9nS0kNdWZ4MB3FS40akN50=;
 b=Gypb8/9+b9CRla9krXpOOGFUvUgXd7X5003I41GAetY+Mt7K2zXtBW8GrctA0h7qnu3y
 vbqjFM5DC2EorBTCt/HJ8Cy2IMo2a3ZjU4qjV/n7Rn8tRHVcTw3D9zLbyM1UKDE+Amc8n
 2BkTZH7a76sdh8wuILX3Pxqar2yxhTDCTDZ1TV9vQV1VJZoz0EON+UMRD/zzPJ4so+VzI
 rnL9Z9TdlG6FSo5wCsPX1/zqX+/x6RBzBwPpw9xzU0V8KNaeY++E6aWpMFnHP+/UvYQIg
 RmC5Ii5tBJemKwHQGdbM46GXIoEEceMzWAvDovhQc280zVSWKIeCoBFiM99dms9j6yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ORTkL6HV; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ORTkL6HV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00800811A5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:55:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9AB26022A;
 Sat, 24 Oct 2026 01:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411EA1F01825;
 Sat, 24 Oct 2026 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792806928;
 bh=JIX4wD0wrmm8VtiwkY5Wp9nS0kNdWZ4MB3FS40akN50=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ORTkL6HVMCfFZ9Vq/EvSdgY5Xb6qoZ6+Hu/blWpU4O+hENa60Jye35J58ubjDu+N7
 nAk37sH6O+rTUmHqtJCjGr4JWRsfntMHUFg6MarxewCYNgqIPFRvgSS0XlWggMF+tF
 tCW2hPq8sbidsdUNXM4orpusbqht9a53OPBwoFR9ueHaeWOfaSEPgL20kTlUqv6BQn
 gHM4u/M+e3acJM3wvwlccTHckAyuJQUKffuobTjVw2q48ui8G1eKYktesppZh6eNEn
 8/oERF5lYuWZMD1D1gWBhBvJMFw5eN9or1rQv+2FeNl82QKe/OS+SkLBzIloPRo2wS
 5D4xGEKRbAnvw==
Message-ID: <sashiko-outbox-183498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 2/2] ice: use struct timecounter for E825 and E830
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <20261023-jk-e825-e830-timecounter-v1-2-e932602f0d16@intel.com>
References: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
 <20261023-jk-e825-e830-timecounter-v1-2-e932602f0d16@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:55:27 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] ice: 500ms offset before ice_phc_cyc2time() in ice_ptp_cfg_perout(=
) wraps
- [High] ice: uncompensated timecounter offset for E830 TxTime in ice_tx_ma=
p()
- [Medium] ice: late PHC update check broken in ice_ptp_update_cached_phcti=
me()
- [Medium] ice: missing timecounter conversion in ice_vc_get_phc_time()
- [Medium] ice: missing timecounter staleness and validity handling in ice_=
phc
- [Medium] ice: ice_ptp_prepare_for_reset() converts zero GLTSYN_TIME via t=
imecounter
--

commit 348b48a49347fa2790d183338857035e4d8f1fa4
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: use struct timecounter for E825 and E830

This commit switches E825 and E830 PTP hardware clock management from direct
hardware timer adjustments to a software struct timecounter and cyclecounter
embedded in struct ice_phc. This avoids PCS timer synchronization stalls on
E825 caused by manual PHY timer adjustments and converts timestamp extensio=
n,
clock reads, cross-timestamping, and periodic output configuration to accou=
nt
for the timecounter phase offset.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index 4b4a00beadd2c..488db8298059a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -210,6 +210,38 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *p=
f)
>  	ice_flush(hw);
>  }
> =20
> +u64 ice_ptp_read_cycles(struct cyclecounter *cc)
> +{
> +	struct ice_adapter *adapter;
> +	struct ice_phc *phc;
> +	struct ice_pf *pf;
> +	struct ice_hw *hw;
> +	u8 tmr_idx;
> +
> +	phc =3D container_of(cc, struct ice_phc, cc);
> +	adapter =3D container_of(phc, struct ice_adapter, phc);
> +
> +	scoped_guard(rcu) {
> +		pf =3D rcu_dereference(adapter->ctrl_pf);
> +		if (!pf)
> +			return 0;

[ ... ]

> @@ -995,19 +1046,17 @@ static int ice_ptp_init_tx(struct ice_pf *pf, stru=
ct ice_ptp_tx *tx, u8 port)
>   * ice_ptp_update_cached_phctime - Update the cached PHC time value
>   * @pf: Board specific private structure
>   *
> - * Update the PTP hardware clock time values which are cached in the PHC
> - * structure.
> + * For devices that use a timecounter structure, update the timecounter.
> + * Ohterwise, update the cached PHC time used for timestamp extension.
>   *
>   * This function must be called periodically by the clock owner to ensur=
e that
> - * the cached value is never more than 2 seconds old.
> + * the timecounter or cached value is never more than 2 seconds old.
>   */
>  static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
>  {
>  	struct ice_phc *phc =3D &pf->adapter->phc;
>  	struct device *dev =3D ice_pf_to_dev(pf);
>  	unsigned long update_before;
> -	u64 systime;
> -	int err;
> =20
>  	update_before =3D phc->update_jiffies + msecs_to_jiffies(2000);
>  	if (phc->cached_time && time_is_before_jiffies(update_before)) {
> @@ -1018,21 +1067,33 @@ static void ice_ptp_update_cached_phctime(struct =
ice_pf *pf)
>  		pf->ptp.late_cached_phc_updates++;
>  	}
> =20
> -	/* Read the current PHC time */
> -	err =3D ice_ptp_read_src_clk_reg(pf, NULL, &systime);
> -	if (err) {
> -		/* The source clock is gone, so the cache can no longer be
> -		 * refreshed. Publish zero instead of leaving the last good
> -		 * value behind: neither ice_ptp_get_rx_hwts() nor
> -		 * ice_ptp_extend_40b_ts() may extend against a value that no
> -		 * longer tracks the PHC, and both treat a zero cache as
> -		 * "no timestamp".
> -		 */
> -		WRITE_ONCE(phc->cached_time, 0);
> +	WRITE_ONCE(phc->update_jiffies, jiffies);
> +
> +	if (phc->use_timecounter) {
> +		unsigned long flags;
> +
> +		write_seqlock_irqsave(&phc->tc_lock, flags);
> +		timecounter_read(&phc->tc);
> +		write_sequnlock_irqrestore(&phc->tc_lock, flags);
>  	} else {
> -		/* Update the cached PHC time stored in the PHC structure */
> +		u64 systime;
> +		int err;
> +
> +		err =3D ice_ptp_read_src_clk_reg(pf, NULL, &systime);
> +		if (err) {
> +			/* The source clock is gone, so the cache can no
> +			 * longer be refreshed. Publish zero instead of
> +			 * leaving the last good value behind: neither
> +			 * ice_ptp_get_rx_hwts() nor ice_ptp_extend_40b_ts()
> +			 * may extend against a value that no longer tracks
> +			 * the PHC, and both treat a zero cache as "no
> +			 * timestamp".
> +			 */
> +			systime =3D 0;
> +		}
> +
> +		/* Update the cached PHC time stored in the PF structure */
>  		WRITE_ONCE(phc->cached_time, systime);
> -		WRITE_ONCE(phc->update_jiffies, jiffies);
>  	}
>  }

[Severity: Medium]
In ice_ptp_update_cached_phctime(), the check for late updates still tests
phc->cached_time:

	update_before =3D phc->update_jiffies + msecs_to_jiffies(2000);
	if (phc->cached_time && time_is_before_jiffies(update_before)) {
		unsigned long time_taken =3D jiffies - phc->update_jiffies;

		dev_warn(dev, "%u msecs passed between update to cached PHC time\n",
			 jiffies_to_msecs(time_taken));
		pf->ptp.late_cached_phc_updates++;
	}

When phc->use_timecounter is true on E825 and E830 devices, phc->cached_time
is initialized to 0 in ice_adapter_new() and is never written. Won't this
cause the condition to always evaluate to false in timecounter mode,
preventing late timecounter updates from ever emitting the warning or
incrementing pf->ptp.late_cached_phc_updates?

Also, by moving WRITE_ONCE(phc->update_jiffies, jiffies) above the
if (phc->use_timecounter) branch, phc->update_jiffies is now updated on
legacy devices even when ice_ptp_read_src_clk_reg() fails and systime is set
to 0. Should phc->update_jiffies only be updated when the clock read
succeeds, and should the late-update check also cover timecounter mode?

[ ... ]

> @@ -1793,8 +1859,9 @@ static int ice_ptp_write_perout(struct ice_hw *hw, =
unsigned int chan,
>  static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_reque=
st *rq,
>  			      int on)
>  {
> +	struct ice_phc *phc =3D &pf->adapter->phc;
> +	u64 clk, period, start, phase, cycles;
>  	unsigned int gpio_pin, prop_delay_ns;
> -	u64 clk, period, start, phase;
>  	struct ice_hw *hw =3D &pf->hw;
>  	int pin_desc_idx;
>  	int err;
> @@ -1840,12 +1907,21 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, =
struct ptp_perout_request *rq,
>  	if (err)
>  		return err;
>  	clk +=3D NSEC_PER_MSEC * 500;
> +	if (phc->use_timecounter) {
> +		cycles =3D clk;
> +		clk =3D ice_phc_cyc2time(phc, cycles);
> +	}
> +
>  	if (rq->flags & PTP_PEROUT_PHASE || start <=3D clk - prop_delay_ns)
>  		start =3D div64_u64(clk + period - 1, period) * period + phase;
> =20
>  	/* Compensate for propagation delay from the generator to the pin. */
>  	start -=3D prop_delay_ns;
> =20
> +	/* Compensate for timecounter phase offset, if necessary */
> +	if (phc->use_timecounter)
> +		start -=3D (clk - cycles);
> +
>  	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
>  }

[Severity: High]
In ice_ptp_cfg_perout(), 500 ms (NSEC_PER_MSEC * 500) is added to the raw
hardware clock value before passing cycles to ice_phc_cyc2time():

	err =3D ice_ptp_read_src_clk_reg(pf, NULL, &clk);
	if (err)
		return err;
	clk +=3D NSEC_PER_MSEC * 500;
	if (phc->use_timecounter) {
		cycles =3D clk;
		clk =3D ice_phc_cyc2time(phc, cycles);
	}

Since phc->cc uses CYCLECOUNTER_MASK(32), timecounter_cyc2time() treats any
cycle value where (cycles - tc->cycle_last) & 0xffffffff exceeds
cc->mask / 2 (~2.147 seconds) as having occurred in the past, subtracting t=
he
delta from tc->nsec instead of adding it.

Because cycles is already 0.5 seconds ahead of the current hardware counter,
doesn't this shrink the forward window before wraparound from ~2.147 seconds
to ~1.647 seconds? If tc->cycle_last was updated between 1.648 and 2.0
seconds ago (within the normal periodic update window, or during
ice_ptp_adjtime_tc() -> ice_ptp_enable_all_perout() where tc->cycle_last is
not refreshed), ice_phc_cyc2time() will wrap backwards by 2^32 ns, making
(clk - cycles) and the resulting GLTSYN_TGT_L/H start time off by 2^32 ns
(and shifting the periodic output phase by 2^32 mod period).

Should ice_phc_cyc2time() be called on the raw clk value before adding
NSEC_PER_MSEC * 500?

[ ... ]

> @@ -2414,15 +2546,9 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_fle=
x_desc *rx_desc,
>  		return 0;
> =20
>  	cached_time =3D READ_ONCE(pkt_ctx->phc->cached_time);
> -	if (!cached_time)
> +	if (!pkt_ctx->phc->use_timecounter && !cached_time)
>  		return 0;
> =20
> -	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
> -	 * PHC value, rather than accessing the PF. This also allows us to
> -	 * simply pass the upper 32bits of nanoseconds directly. Calling
> -	 * ice_ptp_extend_40b_ts is unnecessary as it would just discard these
> -	 * bits itself.
> -	 */
>  	ts_high =3D le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
>  	ts_ns =3D ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high);

[Severity: Medium]
When pkt_ctx->phc->use_timecounter is true, ice_ptp_get_rx_hwts() bypasses
the cached_time check and does not check phc->update_jiffies (unlike
ice_ptp_extend_40b_ts()) or whether the clock owner is active.

Because timecounter_cyc2time() with a 32-bit cyclecounter is only valid
within +/- 2.14 seconds of tc->cycle_last, what happens if the periodic work
is delayed past 2 seconds, or if the clock owner PF on a multi-PF adapter is
unbound in ice_ptp_release(), fails ice_ptp_rebuild(), or fails
ice_ptp_init_owner() after setting phc->use_timecounter =3D 1? Won't sibling
PFs continue extending Rx timestamps against a frozen or uninitialized
phc->tc instead of returning 0?

Relatedly, in ice_ptp_release(), ice_ptp_cleanup_adapter() clears
adapter->ctrl_pf before cancelling pf->ptp.work and unregistering the PTP
clock, which allows ice_ptp_read_cycles() to observe a NULL ctrl_pf and
return 0 as a valid cycle count into timecounter_read() or
timecounter_init(). Also, ice_ptp_init_owner(), ice_ptp_rebuild_owner(), and
ice_ptp_settime64_tc() call timecounter_init() without refreshing
phc->update_jiffies, which can leave phc->update_jiffies stale across a res=
et
until the periodic work runs and cause ice_ptp_extend_40b_ts() to discard
valid Tx timestamps right after ice_ptp_restore_timestamp_mode().

[ ... ]

> @@ -3133,8 +3266,11 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, =
enum ice_reset_req reset_type)
> =20
>  	/* Acquire PHC and system timer to restore after reset */
>  	ptp->reset_time =3D ktime_get_real_ns();
> -	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
> -		ptp->phc_reset_time =3D 0;
> +	if (ice_ptp_read_src_clk_reg(pf, NULL, &ns))
> +		ns =3D 0;
> +	else if (pf->adapter->phc.use_timecounter)
> +		ns =3D ice_phc_cyc2time(&pf->adapter->phc, ns);
> +	ptp->phc_reset_time =3D ns;
>  }

[Severity: Medium]
When a hardware reset (such as CORER, GLOBR, or EMPR) has already cleared t=
he
GLTSYN_TIME registers to 0 before ice_ptp_prepare_for_reset() runs,
ice_ptp_read_src_clk_reg() on the clock owner PF returns 0 with ns =3D 0.

Previously, ns =3D 0 resulted in ptp->phc_reset_time =3D 0, causing
ice_ptp_rebuild_owner() to fall back to ktime_get_real_ns():

	if (ptp->phc_reset_time) {
		time_diff =3D ktime_get_real_ns() - ptp->reset_time;
		ns =3D ptp->phc_reset_time + time_diff;
	} else {
		ns =3D ktime_get_real_ns();
	}

With phc.use_timecounter enabled, the else-if branch passes ns =3D 0 to
ice_phc_cyc2time(&pf->adapter->phc, 0), which computes a 32-bit delta betwe=
en
cycle 0 and the pre-reset tc->cycle_last. Doesn't this turn a zeroed hardwa=
re
register into a non-zero ptp->phc_reset_time shifted by up to +/- 2.147
seconds, bypassing the ktime_get_real_ns() fallback in
ice_ptp_rebuild_owner()?

[ ... ]

> @@ -3375,10 +3522,21 @@ int ice_ptp_clock_index(struct ice_pf *pf)
>   */
>  static int ice_ptp_init_owner(struct ice_pf *pf)
>  {
> +	struct ice_phc *phc =3D &pf->adapter->phc;
>  	struct ice_hw *hw =3D &pf->hw;
> -	struct timespec64 ts;
>  	int err;
> =20
> +	switch (hw->mac_type) {
> +	case ICE_MAC_GENERIC_3K_E825:
> +	case ICE_MAC_E830:
> +		/* Use struct timecounter for E825 and E830 devices */
> +		dev_dbg(ice_pf_to_dev(pf), "PTP 1588 enabling timecounter mode\n");
> +		phc->use_timecounter =3D 1;
> +		break;
> +	default:
> +		break;
> +	}

[Severity: High]
Enabling phc->use_timecounter on ICE_MAC_E830 means the hardware
E830_GLTSYN_TIME registers are no longer initialized in ice_ptp_init_owner()
or ice_ptp_rebuild_owner(), nor adjusted in ice_ptp_settime64_tc() and
ice_ptp_adjtime_tc().

However, E830 supports ICE_F_TXTIME hardware offload:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_init_feature_support() {
	if (pf->hw.mac_type =3D=3D ICE_MAC_E830) {
		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
		ice_set_feature_support(pf, ICE_F_GCS);
		ice_set_feature_support(pf, ICE_F_TXTIME);
	}
}

And in ice_tx_map(), the TxTime descriptor timestamp is populated directly
from first->skb->tstamp without compensating for the timecounter phase
offset:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tx_map() {
		ts =3D ktime_to_timespec64(first->skb->tstamp);
		tstamp =3D ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;

		ts_desc =3D ICE_TS_DESC(tstamp_ring, j);
		ts_desc->tx_desc_idx_tstamp =3D ice_build_tstamp_desc(i, tstamp);
}

How does ICE_F_TXTIME work on E830 when the PHC time is maintained in the
software timecounter while the hardware TxTime queue compares descriptor
timestamps against the unadjusted hardware clock?

[Severity: Medium]
Similarly, when an SR-IOV VF requests the PHC time via
VIRTCHNL_OP_1588_PTP_GET_TIME, ice_vc_get_phc_time() in
drivers/net/ethernet/intel/ice/virt/virtchnl.c still reads the raw hardware
register without converting through ice_phc_cyc2time():

drivers/net/ethernet/intel/ice/virt/virtchnl.c:ice_vc_get_phc_time() {
	if (ice_ptp_read_src_clk_reg(pf, NULL, &phc_time->time)) {
		v_ret =3D VIRTCHNL_STATUS_ERR_NOT_SUPPORTED;
		len =3D 0;
	}
}

Furthermore, in the VF driver, iavf_ptp_extend_32b_timestamp() in
drivers/net/ethernet/intel/iavf/iavf_ptp.c computes:

	u32 low =3D lower_32_bits(cached_phc_time);
	u32 delta =3D in_tstamp - low;

which assumes the lower 32 bits of the PHC time returned by the PF match the
raw 32-bit hardware timestamp domain in the Rx descriptor. Won't enabling
phc->use_timecounter on E825 and E830 break both VF PTP clock reads and VF =
Rx
hardware timestamp extension?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-jk-e825-e8=
30-timecounter-v1-0-e932602f0d16@intel.com?part=3D2
