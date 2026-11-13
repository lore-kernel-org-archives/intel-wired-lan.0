Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AB606A335
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1XPY29Zu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4mbdfi4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2465660665;
	Fri, 13 Nov 2026 23:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJ5VvR9u9goa; Fri, 13 Nov 2026 23:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B01C60679
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794613576;
	b=L449IGTQAaki4mAEnkNUJfR96I9VxZ19IrJjddn+AippCGMZRv+41noUmADwZKlxIKqJ
	 Mg/U8SLMdP6X73c0GhGYJLw7gwn0g05NGTnAXeJOJRAWQXsGljd3/7Hfs5ZvSTddqjHDy
	 ArW0LWtQBlDNZNA/nng36DWnc5Mvf5BQ0FmMlY8pNat1457g7njUhbNT5AuWCX0bzCddR
	 SRtJxByWNlfQvNM9/flRAKuxTtuPR7fA9ga2UeugYasyWj2XTtMz8MK/MFxDoxMavK9sJ
	 LhQOSImzYkZKzHGLAAHq8sp6wjzXWgCOw7CrDyguLXA4weggmsTAnTxwmUMziDePqeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794613576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=AeHILAyVcKpr9GNF5d4ydzcQq6JUIxrj7kPI6Vs66hQ=;
	b=Yp+eK7te8QlCr0YT3to290nFl1BWuuR2nph4pXDzAoDUnKXnfkTXI66+vAP4NKOBfM83
	 7nOG3czcLIjH01stpmF0vJTRU0dJ2+Pzx2sm66H8lYurJfJZlHRT16JoxrbXnOsRtXr1i
	 KZ0NNGoMNAA6TOE50JOCM+nfqbLqzdTag5EbDyaBmBMMasUomuBdSLuFzjo4P9hVP0kY0
	 E5GJYDCjejmP7jpHHQOxzYABticF+Re7II1xzIYzXra9CSD3rNXW4/7IauiCqiUjhB/yP
	 PO6NkU+J3xQE6/Zl94Rr2M+FyWW7tuKjygqhwaM9mEbyLlVyOEBfSgdvHC08AA/TMWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794613576;
	bh=AeHILAyVcKpr9GNF5d4ydzcQq6JUIxrj7kPI6Vs66hQ=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=1XPY29ZuIAQ7q6Ct9BEwpviIci3iPHnGPBPFavX9uQT/oAOqBbYuRoO4w9CblEHRP
	 gj46l4mxeMVzlEe0oFK9qUDf55yn/3uhALYJ6Kb4HubcFBMC1lhhcaoyz93Iw8p2FK
	 MP5cCogBW9+uDtyIUnA32OE2Iie5wan1u2gMVMM64TktuSAar8vU27BMw6pVK43tck
	 sPm4WU7m2WgCxfj5LAKjWbDt85O6Ay+qShzk8Rh2DNGqvLEnjUnwlcSqFziVi+W4NN
	 1Ym114/IfbA0Cg7AtQh5GxW2r9I4/z1T5wQuJsaEsXXUsFNujUt6ke4tz9M6zwuRxs
	 rircGGJK2R9xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B01C60679;
	Fri, 13 Nov 2026 23:46:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64CD92FB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5934781463
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hroXlBhCDvnm for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 23:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2121B811E4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B4mbdfi4
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2121B811E4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC9B561274;
 Fri, 13 Nov 2026 23:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465F81F000C4;
 Fri, 13 Nov 2026 23:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794613571;
 bh=AeHILAyVcKpr9GNF5d4ydzcQq6JUIxrj7kPI6Vs66hQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=B4mbdfi4FeGRBlxun1IE7ovpgsv1HERzIYofcaPs8lCDBqu+nNA6Siq1USpSl03qc
 NkZUf85F0di38F5spvSpTSN12Qk+tf2WnYGimE3m3MGoo2M8afdmZxRr+kdf8lFDNw
 gtm5Ff6cPnP9wov97LX5RedXQOfTZEcJ+8A84D1J8X33Rap1hM0S4d0/2GyQWeaJiQ
 AgNNDeZvMrhrmPT4uD2MWQ6uSWHqdCmIfnatBAUcFf+E17mBsbsPtVkFa2JnFwTgnX
 VFKcb+ug64BjclTVuBrGOdZ8WH0qBp9NP8K+7oKun1tYzIzILq9WnpDJt/pcb1Dp2b
 3cB3JcfZI1mwg==
Message-ID: <sashiko-outbox-213873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v2 4/4] ice: use struct timecounter for E825
 and E830
To: "Jacob Keller" <jacob.e.keller@intel.com>,
 "Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
In-Reply-To: <20261113-jk-e825-e830-timecounter-v2-4-9c357a7ed349@intel.com>
References: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
 <20261113-jk-e825-e830-timecounter-v2-4-9c357a7ed349@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:46:10 +0000
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
- [Medium] ice: perout_rqs updated outside phc.lock in
  ice_ptp_gpio_enable()
- [Medium] ice: premature update_jiffies store in ice_ptp_read_cycles()
--

commit 2dbce654e6813d30b319e71f8e68ca2b82a4b244
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: use struct timecounter for E825 and E830

This commit switches E825 and E830 devices from direct hardware PHC time
adjustments and legacy 32-bit timestamp extension to a latched
timecounter/cyclecounter stored in struct ice_phc.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index a0451c1083a41..b48d1bf3bbf59 100644
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
> +		smp_store_release(&phc->update_jiffies, jiffies | 1);
> +		return time;
> +	}
> +}

[ ... ]

> +static void ice_phc_refresh(struct ice_phc *phc)
> +{
> +	lockdep_assert_held(&phc->lock);
> +
> +	write_seqcount_latch_begin(&phc->seq);
> +	(void)timecounter_read(&phc->tc[0]);
> +	write_seqcount_latch(&phc->seq);
> +	/* Update the secondary copy */
> +	phc->tc[1].cycle_last =3D phc->tc[0].cycle_last;
> +	phc->tc[1].nsec =3D phc->tc[0].nsec;
> +	write_seqcount_latch_end(&phc->seq);
> +}
> +
> +/**
> + * ice_phc_init - Initialize PHC timecounter to new start value
> + * @phc: pointer to the PHC structure
> + * @init_tstamp: New initial value for the timecounter
> + *
> + * Initialize the PHC timecounter to a new offset. The latched sequence
> + * counter is used to ensure readers get a consistent view of the timeco=
unter
> + * phase. We always pass the same cyclecounter structure, so the mask, f=
rac,
> + * and cc fields always remain the same, and only the cycle_last and nsec
> + * fields must be propagated to the secondary structure.
> + */
> +static void ice_phc_init(struct ice_phc *phc, u64 init_tstamp)
> +{
> +	lockdep_assert_held(&phc->lock);
> +
> +	write_seqcount_latch_begin(&phc->seq);
> +	timecounter_init(&phc->tc[0], &phc->cc, init_tstamp);
> +	write_seqcount_latch(&phc->seq);
> +	/* Update the secondary copy */
> +	phc->tc[1].cycle_last =3D phc->tc[0].cycle_last;
> +	phc->tc[1].nsec =3D phc->tc[0].nsec;
> +	write_seqcount_latch_end(&phc->seq);
> +}

[Severity: Medium]
Does storing phc->update_jiffies inside ice_ptp_read_cycles() publish
the timestamp before either phc->tc[] copy is updated?

timecounter_init() and timecounter_read() invoke cc->read() before
writing tc[0].cycle_last and tc[0].nsec, while phc->seq is odd and
directing readers to phc->tc[1]:

CPU0                                  CPU1
ice_phc_init()
  write_seqcount_latch_begin(&phc->seq)
  timecounter_init(&phc->tc[0], ...)
    ice_ptp_read_cycles()
      smp_store_release(&phc->update_jiffies, ...)
                                      ice_ptp_extend_32b_ts()
                                        smp_load_acquire(&phc->update_jiffi=
es)
                                        ice_phc_cyc2time_with_trace()
                                          seq =3D read_seqcount_latch(&phc-=
>seq)
                                          /* idx =3D=3D 1 */
                                          timecounter_cyc2time(&phc->tc[1],=
 ...)
                                            <-- uses uninitialized or stale=
 tc[1]
    tc[0].cycle_last =3D ...
    tc[0].nsec =3D ...
  write_seqcount_latch(&phc->seq)
  phc->tc[1] =3D phc->tc[0]
  write_seqcount_latch_end(&phc->seq)

During initial bringup or after a reset or delayed refresh (>2s), CPU1
sees a fresh update_jiffies and extends a packet's 32-bit hardware
timestamp against an uninitialized (zero) or stale phc->tc[1] snapshot
instead of discarding it or using the updated timecounter.  Recording the
new jiffies value and calling smp_store_release(&phc->update_jiffies, ...)
after write_seqcount_latch(&phc->seq) (or write_seqcount_latch_end()) when
cc->read() succeeded would ensure readers only see the fresh timestamp
once an updated timecounter copy is active.

[ ... ]

> @@ -1974,7 +2202,10 @@ static int ice_ptp_gpio_enable(struct ptp_clock_in=
fo *info,
>  		if (on && pf->ptp.state !=3D ICE_PTP_READY)
>  			return -EIO;
> =20
> +		/* Serialize against concurrent timecounter updates */
> +		mutex_lock(&pf->adapter->phc.lock);
>  		err =3D ice_ptp_cfg_perout(pf, &rq->perout, on);
> +		mutex_unlock(&pf->adapter->phc.lock);
>  		if (!err) {
>  			*cached =3D rq->perout;
>  		} else {

[ ... ]

> @@ -2086,6 +2319,43 @@ ice_ptp_settime64(struct ptp_clock_info *info, con=
st struct timespec64 *ts)
> +static int ice_ptp_settime64_tc(struct ptp_clock_info *info,
> +				const struct timespec64 *ts)
> +{
> +	struct ice_pf *pf =3D ptp_info_to_pf(info);
> +	struct ice_phc *phc =3D &pf->adapter->phc;
> +	u64 ns;
> +
> +	if (pf->ptp.state !=3D ICE_PTP_READY)
> +		return -EIO;
> +
> +	ns =3D timespec64_to_ns(ts);
> +
> +	mutex_lock(&phc->lock);
> +
> +	ice_ptp_disable_all_perout(pf);
> +
> +	ice_phc_init(phc, ns);
> +
> +	ice_ptp_mark_all_tx_tracker_stale(pf);\n+
> +	/* Reenable periodic outputs */
> +	ice_ptp_enable_all_perout(pf);
> +
> +	mutex_unlock(&phc->lock);
> +
> +	return 0;
> +}

[Severity: Medium]
Can releasing pf->adapter->phc.lock before updating *cached
(pf->ptp.perout_rqs[rq->perout.index]) in ice_ptp_gpio_enable() race with
ice_ptp_settime64_tc() or ice_ptp_adjtime_tc()?

The POSIX clock layer only holds down_read(&clk->rwsem) across ioctl,
clock_settime, and clock_adjtime calls, so ice_ptp_gpio_enable() and
ice_ptp_settime64_tc() can run concurrently:

CPU0                                  CPU1
ice_ptp_gpio_enable()
  mutex_lock(&pf->adapter->phc.lock)
  ice_ptp_cfg_perout(pf, &rq->perout, 1)
  mutex_unlock(&pf->adapter->phc.lock)
                                      ice_ptp_settime64_tc()
                                        mutex_lock(&phc->lock)
                                        ice_ptp_disable_all_perout(pf)
                                        ice_phc_init(phc, ns)
                                        ice_ptp_enable_all_perout(pf)
                                          /* cached->period is still 0 */
                                        mutex_unlock(&phc->lock)
  *cached =3D rq->perout;                 <-- HW keeps pre-settime phase

When enabling an output, ice_ptp_enable_all_perout() sees a zero period in
perout_rqs[] and skips reprogramming GLTSYN_TGT for the new timecounter
phase; when disabling an output, it sees the old non-zero period and
re-enables the output in hardware right before *cached is cleared.
Writing *cached without holding phc.lock also races with
ice_ptp_disable_all_perout() and ice_ptp_enable_all_perout() reading the
struct under phc.lock.  Holding pf->adapter->phc.lock across the *cached
update in ice_ptp_gpio_enable() avoids the race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-jk-e825-e8=
30-timecounter-v2-0-9c357a7ed349@intel.com?part=3D4
