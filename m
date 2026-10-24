Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9ED606A31B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZzRSher7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jqeh8v5r
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 492C8815C3;
	Sat, 24 Oct 2026 01:46:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFO0pq8Bnknm; Sat, 24 Oct 2026 01:46:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42F8B81670
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792806370;
	b=YOsyvyDbl2mfIjMe2pvijb1SQVjSKUSp7CLW3DpA9hdTSzaVaXW0qqXtDWTb8O3sT9ta
	 mQcnyIa/QGDoZj2Yq+J2H5W7brmqWtU7HNCNhyk2e8nyLfAFRfpJCkK1PN1xHe09K/FXX
	 ofUU6rCwncmbjGg+UiGAKEIlEkzNTrOz+zhYStQT1318oFA0SGqQJaJ8Xh4uGWoMb/kZH
	 kLp6I2Bz5GLlbVLyc7z9Pxrtx5DNMk1ObUbmOA5n2SAbbxOfzkykPptR0vJAjASYHaoQ8
	 qlRw1PdC0oH0hYHb8g6OwrQhDMQZcEnDmefyq31LApKgtGltRbElKHjfyWvPxnpVjrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792806370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=67nt2V9T9b7i3n6o+SNpKU/A0QwgmwBNIenDDt1itYY=;
	b=SOCrUpATMUCFMh9ddr2B6X/b5+kK/NT2XKMKQGcUmd0y7LdV4XL+AFciQQLJHaTxG/YW
	 OejoZRRu+5u3I764TaQw4MOmbqkGoFVWO+8qo+M/k9+LdJ3/xymzzzjvgoOJJkW0wZ+SQ
	 9A6DknHbf5NzH5uEEc57nGdnbm4AilEgseiDn2jr1ENkSRgmwukx9WlKfZ4nUm8+zUK3d
	 kXUqb0/04inWET28askgXiYm/4eMMAYSw0P5kMnfv0d76OTKp8+NKwGceY7feBwZOcknG
	 RUSwRfUjSI2BNlZxlInzK8wrnoTRvbLlpEGLPQqHPMjGzb9Gtl2+BZmaQ7j7VVy80Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792806370;
	bh=67nt2V9T9b7i3n6o+SNpKU/A0QwgmwBNIenDDt1itYY=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZzRSher765QCrDruGVooVZIiBbo3D/GXpL6TtvZhblMGNVhUv3XOrGQqdsdnNZRop
	 LPkHxDvt3ilcEO52gILqZry12YEzSH5Pc+7umVIwI5ivzo3MAln745uhYdMBceNGK8
	 C1mU+0alJBJCsKjKJ/Uar20ga2geLno37xXk1Wma0jGPpB9F9Z73fxSfKl9CPS6Meu
	 0y6Bv3wpj0eLNIX/0Ue0qKHfNgIGQJOl8zAzgky6PvB/847jF1iEryhCPvHAEUKYVr
	 odzaGHqMrBFBVZcZ1WP6q1D+nOt3BlQfxMpJXCihVMjadUixMO2+mtXlXg0kR/Ke07
	 17LpXIrDNEsKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42F8B81670;
	Sat, 24 Oct 2026 01:46:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09D4343
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC86160A5A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdgQBIWAxHpU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 01:46:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B72A860A59
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792806368;
 b=iHJOrkjvPnt1p4lzVLCO2dyQnWUQl1JjDByyUgUsW5/fjrr//HP8lSXUs1ZbMX5w4+v9
 5XJ3XfQW4Ncf8/fXB9cGUsHxV+vZkR+bZY/iSsTgV1jov4JzssKdpJ9UwIBbOb95mnzjS
 gs4pa8yWOJxGVnLt3NDitz4+bd6uZf6u7Y+H3NfkrgrIL1WJzWM5/CSTW0IQTN8yQKCnj
 hvTlVpEME81Htk4+YKHEyIZO/pY9Sgf0vH2t9CfdFVJ/5i3dCivU6RgSMG0y+GJFeMZTD
 459bXITTCBQAV4Mu/qYHOeGVnCz2dluFtH27mUoS66egXiSz5XoTlbqw+Gre2aE4mKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792806368;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=67nt2V9T9b7i3n6o+SNpKU/A0QwgmwBNIenDDt1itYY=;
 b=ZfBEHWafexUXNeisvu7Q/twimO5gX8AqRf7WS+ZaPMx7Vy5nw04BnCIBlpeoPAMt1DUY
 GuGBFDA+02SclO/LB7ntAj3s0HxcKNuLKIO1EoEQ8NhwVIXJFtJln4ZzlutuZMB1mnNaR
 XvudKAZPX0sJzuD0/AefwEMERHAlAEQx5Sf1f/NIqT9gpNC8NfEsFQZeu4QFuRDybfgm/
 UPlXEE+nSuyDERD9VZxRHuiWG6XGRvclCv52XQEwTIbECig6v6YHbmO5WHM3iKAbBb8Pb
 Z2Cg05o3+6QMxNdoObYirLB9/ulluCb3DBPV8FDjSLEHe+KOYj5juDljpNzS5yGEWrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Jqeh8v5r; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Jqeh8v5r
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B72A860A59
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87A2E6022A;
 Sat, 24 Oct 2026 01:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0091F01825;
 Sat, 24 Oct 2026 01:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792806365;
 bh=67nt2V9T9b7i3n6o+SNpKU/A0QwgmwBNIenDDt1itYY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Jqeh8v5rH+auSskzNFPEf/IiDJv94uRhMSepsmavlWrISC5XhTBVUKhH+OV7KdSqe
 kSRGZExRdwR3X7PCnsPNO4WSNpBVtRpvUUTrtwXO5wmFRDNUxxswktIQLfY2xBQKrG
 HQjIJL+FLBH3ViKkMBrohrSyvLjAGVdjJGUttqvKH3E2w+SN564zjahOK0S7I77B0l
 9fj5ZMIclJTJKHRc/rVyUO4l/wMjHojP5xxHdhcohyWcP5AJLOkAEfi+lrvogxI5Fu
 E82BE60Rt0KP8CEh93FYpZMNa1kw+3fQazAOp+G14XFMDpdZt1EnmOjoC9ysGqMZ7e
 5GCeWoU3goggQ==
Message-ID: <sashiko-outbox-183491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 1/2] ice: store cached PHC time in ice_adapter
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <20261023-jk-e825-e830-timecounter-v1-1-e932602f0d16@intel.com>
References: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
 <20261023-jk-e825-e830-timecounter-v1-1-e932602f0d16@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:46:04 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ice: stale shared phc.cached_time when clock-owning PF stops or =
unbinds
--

commit 866055ac7173935e690af3f73268e559a0698a8d
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: store cached PHC time in ice_adapter

This commit moves the cached PHC time from per-PF and per-Rx-ring fields
into a shared struct ice_phc embedded in struct ice_adapter, and updates
only the clock-owning PF to refresh that shared value in its periodic
work.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index ec24c09280785..4b4a00beadd2c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -987,35 +992,26 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struc=
t ice_ptp_tx *tx, u8 port)
>  }
> =20
>  /**
> - * ice_ptp_update_cached_phctime - Update the cached PHC time values
> + * ice_ptp_update_cached_phctime - Update the cached PHC time value
>   * @pf: Board specific private structure
>   *
> - * This function updates the system time values which are cached in the =
PF
> - * structure and the Rx rings.
> - *
> - * This function must be called periodically to ensure that the cached v=
alue
> - * is never more than 2 seconds old.
> + * Update the PTP hardware clock time values which are cached in the PHC
> + * structure.
>   *
> - * Note that the cached copy in the PF PTP structure is always updated, =
even
> - * if we can't update the copy in the Rx rings.
> - *
> - * Return:
> - * * 0 - OK, successfully updated
> - * * -EAGAIN - PF was busy, need to reschedule the update
> - * * -ENODEV - no control PF owns the source clock register space
> - * * -EOPNOTSUPP - PTP support is not compiled in
> + * This function must be called periodically by the clock owner to ensur=
e that
> + * the cached value is never more than 2 seconds old.
>   */
> -static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
> +static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
>  {
> +	struct ice_phc *phc =3D &pf->adapter->phc;
>  	struct device *dev =3D ice_pf_to_dev(pf);
>  	unsigned long update_before;
>  	u64 systime;
> -	int err, i;
> +	int err;
> =20
> -	update_before =3D pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
> -	if (pf->ptp.cached_phc_time &&
> -	    time_is_before_jiffies(update_before)) {
> -		unsigned long time_taken =3D jiffies - pf->ptp.cached_phc_jiffies;
> +	update_before =3D phc->update_jiffies + msecs_to_jiffies(2000);
> +	if (phc->cached_time && time_is_before_jiffies(update_before)) {
> +		unsigned long time_taken =3D jiffies - phc->update_jiffies;
> =20
>  		dev_warn(dev, "%u msecs passed between update to cached PHC time\n",
>  			 jiffies_to_msecs(time_taken));
> @@ -1032,36 +1028,12 @@ static int ice_ptp_update_cached_phctime(struct i=
ce_pf *pf)
>  		 * longer tracks the PHC, and both treat a zero cache as
>  		 * "no timestamp".
>  		 */
> -		systime =3D 0;
> -		WRITE_ONCE(pf->ptp.cached_phc_time, 0);
> +		WRITE_ONCE(phc->cached_time, 0);
>  	} else {
> -		/* Update the cached PHC time stored in the PF structure */
> -		WRITE_ONCE(pf->ptp.cached_phc_time, systime);
> -		WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
> +		/* Update the cached PHC time stored in the PHC structure */
> +		WRITE_ONCE(phc->cached_time, systime);
> +		WRITE_ONCE(phc->update_jiffies, jiffies);
>  	}

[ ... ]

> @@ -3078,24 +3025,20 @@ static void ice_ptp_periodic_work(struct kthread_=
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

[Severity: Medium]
What happens to pf->adapter->phc.cached_time on remaining PFs if the
clock-owning PF is unbound, reset, or fails PTP rebuild?

Previously, commit dcc2c9108e65 ("ice: Reject PTP access without a control
PF") handled control PF removal by having each PF run
ice_ptp_update_cached_phctime() from ice_ptp_periodic_work(). When the
control PF went away, ice_ptp_read_src_clk_reg() returned -ENODEV on the
secondary PFs, which cleared cached_phc_time and the Rx ring cached_phctime
copies to 0.

With this change, ice_ptp_periodic_work() in
drivers/net/ethernet/intel/ice/ice_ptp.c only calls
ice_ptp_update_cached_phctime() when ice_pf_src_tmr_owned(pf) is true
(and the only other callers are ice_ptp_settime64() and ice_ptp_adjtime()
via ice_ptp_reset_cached_phctime(), which also only run on the clock
owner). Because ice_pf_src_tmr_owned(pf) guarantees ice_is_primary(&pf->hw)
is true, ice_ptp_read_src_clk_reg() never returns -ENODEV here, making the
error branch in ice_ptp_update_cached_phctime() that zeroes
phc->cached_time unreachable.

Meanwhile, when the clock-owning PF stops its periodic worker in
ice_ptp_prepare_for_reset() or is unbound via
ice_ptp_release() -> ice_ptp_cleanup_adapter():

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_cleanup_adapter() {
    ...
	if (ice_get_ctrl_pf(pf) =3D=3D pf) {
		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
		synchronize =3D true;
	}
    ...
}

nothing zeroes pf->adapter->phc.cached_time.

Because the Rx path in ice_ptp_get_rx_hwts() -> ice_ptp_extend_32b_ts()
only checks whether phc->cached_time is non-zero and does not check
phc->update_jiffies, won't active sibling or secondary PFs continue
extending 32-bit hardware Rx timestamps against the frozen
phc->cached_time indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-jk-e825-e8=
30-timecounter-v1-0-e932602f0d16@intel.com?part=3D1
