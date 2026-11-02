Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07865606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5a5UARGO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcYoo8CB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAC9F60653;
	Mon,  2 Nov 2026 11:38:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MBh4Ez6poaW7; Mon,  2 Nov 2026 11:38:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B604060661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793619508;
	b=FsNLcg2JIu19xmdpswCpt8+rGIaKNyqKLBux+ZymmX4AXx8ntllx5mTdS6TJ6kbCpjt2
	 OoYTgPge4TMvTC6p1p1sS3tqr9CBTfM4hsaS/jBrQ0xQWMdKAr7r8sf9pLxrmRicnm8xX
	 ha1C9PHRVhuGtgJpGGOOPZbzSIPRnR0PIAp/2hmQouqOQLaE0Zm+Afh7mKWWb7VPGovjT
	 wiWhuXTRpeUtZRdDPEnYmE3HEGtVEQhnQUzQ4iE7+RhM4wHpdmWDihYP3p9vyBtBQ6ZQc
	 S3R4ZAH/lZWtuMNYGOCsdEREBWkWu7BeHax2oMc/QgMcyVtCTiUr6Jl3/1Dpk6pCDGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793619508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=W8qOuB02+8vBUQVeXXeyBwyKGr6/TOOsG+vlGh6oIsU=;
	b=szLQtOr3pM6XjFlk0oPW/+dKsGqtvwyFEAalDkAhsG3gpUnT6pr2ty4e+aeJ/cCb7g6f
	 zRVGe9bojPPHY/KbsTuwlpkqb+K/r+Xfxe8PerBNlYzlGz7FYCEOkoIIeXBRAt7hFAsKB
	 43d9Vxlplca3mwXe7bZwpxNHM47RsvyCNu0S8dxQVRFTdvZIUhTRq5Mz38tbp9ieHfBF/
	 ShPf8S4idpvLQ0T1EtTcF28wM1NP5tJEVuzN/DtCAzYS+GrDCICR6cLqNkKFgEwS5hswq
	 Z+1rdjhJXi5hm8ZPBNfEiO8DtsYy9bPqHJ/BRUpuw9z3TgV6nNsazusQGuzKFQLOmHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793619508;
	bh=W8qOuB02+8vBUQVeXXeyBwyKGr6/TOOsG+vlGh6oIsU=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=5a5UARGOQu9bfbpBzwQhbPtOrGgzePhZqcTjPZz9/fyTSfafXEsSy8G4/YrTtbQn9
	 kRyPznnwxt8lX0MS4CoahpePsStFD5Sm2E75hm+a7Y6dBEFveP8czREDuyV0KHDuVT
	 pg1EpJoXd6R5ka6LUisDN73LHBIk7Cahg56lz76xyeIRyzSjsoHOQHREMMKH7FlYIU
	 WK1SViR0l4b+8XfwBcYg/y07YHi7zbYUzRvGIHmgxGgP2uOKjzBUrXQXG6e8DRZKJO
	 0J2bhZSNZUUuLd1MJ5gDRiXCpFcHyU1DfoKvBXBzUgZ7XrboeB4iRNukr8iBoUdUYb
	 HLh4yi05f1FYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B604060661;
	Mon,  2 Nov 2026 11:38:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2F9B4BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C954F80F30
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3q4devx-t3b for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 11:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9694B80E6B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793619505;
 b=OKCbGm0dumyvpUPud8rVn6Qao95mGPB92ILvACvlYgB0wEAqJG4YS+cz2XPo8PTTd+RH
 1V71IwzoNOffm94ERUHTEgA1jwSCNJkXMLnkbIUC72xHA+t0w+5KYqmatm5apJcT5Lj5T
 PtpPyfRtJpuFPXQRkI+7CfdUFmZ86aB3cS9iDjCl8Dxun5Sv5frkfVLgC67+YR4lVpMzR
 y4Iw2LHlGtBnbndnhGe96tugefvdkJZulMWEr7bb8GhoVXIWWP5O7j/9IkotvoJDaQKPI
 Uf+r2+yw5/ZCdV3pEwXOCH7498l42aXzk+5bMqW3o4wmpwmVt8CLzrhUVqUz9x4lGqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793619505;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=W8qOuB02+8vBUQVeXXeyBwyKGr6/TOOsG+vlGh6oIsU=;
 b=hLswg349RW35pByR7DFyHZ5HiSnK2RAh+fNmh2NqxnENmMmu5mWcTU/KmCWYt45gIk+A
 RT7+6EQzRRbu/+ev0VM0sQgfjj722EFKxGHEuvRqzFsldsWl4LkrsAqnI10MrQgVOJD8f
 IurYe2o5Rq6VFL0D+8xLIwlFNNUcmjSdgD9/ufXbAvDdVfYnXlMnF3LtsNgTbYRHnwBGz
 nA1RzhH8IDi+uSYb5elZ+X4LzZkDE5m/hwbOh1uIZgoF4jp5BEx40VdIconKdFUNmSbQn
 PSG3fbFiLW9UxuGhhPmBcPPnSIeAI1dtX+AeKBX3bSYYQdPkcCKDhxRCPJYZWAQI0BA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IcYoo8CB; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IcYoo8CB
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9694B80E6B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:38:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB093431C1;
 Mon,  2 Nov 2026 11:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FD11F00A1D;
 Mon,  2 Nov 2026 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793619504;
 bh=W8qOuB02+8vBUQVeXXeyBwyKGr6/TOOsG+vlGh6oIsU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=IcYoo8CB6WdT5CVQfAKHHFwiV6ewSKXIpnuzyecaOci/QRokM/vbT2zVi8jUBMiqd
 GMxD/eG68qct9IsMW7Jr6z+hUyMbC4WrCHWpxFItArIM6M2dad2fdfgIMSuwOr4RzO
 1N2iA7J9ewFXQsYdCRayNkCuNiBGi60UVr1UizEBxMXdZOzHqv4M9CrKCah4N4atWg
 AIs9MhTHfqbiY9xt/2C6BFcblxgGBd8+CbYK/5wzOmVpYd93KtZblHdb/juLdaEg4A
 EnwD86aycXMaJV2gvypkHKN7i4QhPAAT8sFsG/R3kUEldQ2PsZYNrXc5PDtixD7W9R
 H9ZA7tHTWFX+w==
Message-ID: <sashiko-outbox-193341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 2/2] idpf: add direct Tx timestamp readout
To: "Przemyslaw Korba" <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261102110717.77800-3-przemyslaw.korba@intel.com>
References: <20261102110717.77800-1-przemyslaw.korba@intel.com>
 <20261102110717.77800-3-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:38:24 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] idpf: leaked latches and race on disable in idpf_ptp_set_timestamp=
_mode()
- [High] idpf: NULL cmd_sync dereference after overwrite in idpf_ptp_get_ca=
ps()
- [Medium] idpf: tx_tstamp_timer not stopped when vport stops in idpf_vport=
_stop()
--

commit dab766921f8ee37b82339faa63fd1af80a2f807b
Author: Przemyslaw Korba <przemyslaw.korba@intel.com>

idpf: add direct Tx timestamp readout

This commit adds direct BAR register access support for reading hardware Tx
timestamps in the idpf driver. In direct mode, a periodic 100 us hrtimer
polls the readiness bitmap and latch registers, reports completed timestamps
to the network stack, and expires unlatched requests after 500 ms.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/eth=
ernet/intel/idpf/idpf_ptp.c
> index a781b3dbe2d62..adb3f31daa5d9 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c

[ ... ]

> @@ -829,35 +888,258 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u=
64 in_tstamp)

[ ... ]

> +static enum hrtimer_restart idpf_ptp_tx_tstamp_timer_cb(struct hrtimer *=
timer)
> +{
> +	struct idpf_vport *vport;
> +
> +	vport =3D container_of(timer, struct idpf_vport, tx_tstamp_timer);
> +
> +	idpf_ptp_get_tx_tstamp_direct(vport);
> +	hrtimer_forward_now(timer, IDPF_PTP_TX_TSTAMP_PERIOD_NS);
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +/**
> + * idpf_ptp_tx_tstamp_timer_init - Set up the Tx timestamp collection ti=
mer
> + * @vport: Virtual port structure
> + */
> +void idpf_ptp_tx_tstamp_timer_init(struct idpf_vport *vport)
> +{
> +	hrtimer_setup(&vport->tx_tstamp_timer, idpf_ptp_tx_tstamp_timer_cb,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +}
> +
> +/**
> + * idpf_ptp_tx_tstamp_timer_set - Arm or disarm the Tx timestamp timer
> + * @vport: Virtual port structure
> + * @enable: whether the Tx timestamps are to be collected
> + *
> + * In the direct mode nothing in the Tx path reads the latches, so the
> + * collection is driven by a timer that runs for as long as the Tx
> + * timestamping is enabled.
> + */
> +static void idpf_ptp_tx_tstamp_timer_set(struct idpf_vport *vport, bool =
enable)
> +{
> +	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
> +	    vport->tx_tstamp_caps->access !=3D IDPF_PTP_DIRECT)
> +		return;
> +
> +	if (enable)
> +		hrtimer_start(&vport->tx_tstamp_timer,
> +			      IDPF_PTP_TX_TSTAMP_PERIOD_NS,
> +			      HRTIMER_MODE_REL_SOFT);
> +	else
> +		hrtimer_cancel(&vport->tx_tstamp_timer);
> +}

[Severity: Medium]
Does vport->tx_tstamp_timer keep running at 10 kHz if the interface is brou=
ght
down while hardware Tx timestamping is enabled?

When HWTSTAMP_TX_ON is active in IDPF_PTP_DIRECT mode and the interface is
stopped via idpf_stop() -> idpf_vport_stop(), the queues are torn down and
vport->link_up is set to false:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_stop() {
    ...
	vport->link_up =3D false;
	idpf_vport_intr_deinit(vport, rsrc);
	idpf_xdp_rxq_info_deinit_all(rsrc);
	idpf_vport_queues_rel(vport, rsrc);
	idpf_vport_intr_rel(rsrc, &adapter->irq);
	clear_bit(IDPF_VPORT_UP, np->state);
    ...
}

However, idpf_vport_stop() does not cancel vport->tx_tstamp_timer or flush
vport->tx_tstamp_caps->latches_in_use, and idpf_ptp_tx_tstamp_timer_cb()
unconditionally rearms the timer with HRTIMER_RESTART. Because
idpf_hwtstamp_set() rejects changes when !vport->link_up with -EPERM,
userspace cannot disable Tx timestamping while the interface is down either.

In addition, any skbs with SKBTX_IN_PROGRESS that were cleaned from the Tx
ring during idpf_vport_stop() remain on latches_in_use for 500 ms until
idpf_ptp_get_tx_tstamp_direct() expires them, logging false-positive warnin=
gs
and counting them as expired rather than flushed.

Should idpf_vport_stop() cancel vport->tx_tstamp_timer and flush
latches_in_use (and idpf_vport_open() restart the timer if
vport->tstamp_config.tx_type =3D=3D HWTSTAMP_TX_ON)?

> @@ -917,12 +1199,18 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport =
*vport,
>  	case HWTSTAMP_TX_ON:
>  		if (!idpf_ptp_is_vport_tx_tstamp_ena(vport))
>  			return -EINVAL;
> +
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> =20
> -	vport->tstamp_config.tx_type =3D config->tx_type;
> +	/* Publish the new mode before the collection is disarmed, so that the
> +	 * Tx path stops handing out latches that nothing would collect.
> +	 */
> +	WRITE_ONCE(vport->tstamp_config.tx_type, config->tx_type);
> +	idpf_ptp_tx_tstamp_timer_set(vport, config->tx_type =3D=3D HWTSTAMP_TX_=
ON);

[Severity: High]
Can disabling Tx timestamping in idpf_ptp_set_timestamp_mode() strand in-use
latches and leak their skb references?

In IDPF_PTP_DIRECT mode, idpf_tx_read_tstamp() is a no-op, so
vport->tx_tstamp_timer running idpf_ptp_get_tx_tstamp_direct() is the only
place that collects or expires entries from tstamp_caps->latches_in_use.

When userspace transitions config->tx_type to HWTSTAMP_TX_OFF via
idpf_hwtstamp_set() -> idpf_ptp_set_timestamp_mode(),
idpf_ptp_tx_tstamp_timer_set(vport, false) immediately cancels
vport->tx_tstamp_timer without draining or flushing entries already queued =
on
tstamp_caps->latches_in_use.

Furthermore, the Tx datapath checks tstamp_config.tx_type outside of
tstamp_caps->latches_lock:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:idpf_tx_tstamp() {
    ...
	if (READ_ONCE(idpf_netdev_to_vport(tx_q->netdev)->tstamp_config.tx_type) !=
=3D
	    HWTSTAMP_TX_ON)
		return -1;
    ...
	err =3D idpf_ptp_request_ts(tx_q, skb, &idx);
}

A concurrent Tx thread can pass the READ_ONCE() check in idpf_tx_tstamp()
just before WRITE_ONCE() sets HWTSTAMP_TX_OFF, and then call
idpf_ptp_request_ts() after hrtimer_cancel() has finished, moving a latch
onto latches_in_use and taking an skb_get(skb) reference after the timer is
already stopped.

Those stranded entries on latches_in_use hold their skb references (with
SKBTX_IN_PROGRESS set) and latch indexes until teardown or until
HWTSTAMP_TX_ON is re-enabled. If HWTSTAMP_TX_ON is later re-enabled after t=
he
32-bit PHC counter wraps, idpf_ptp_get_tx_tstamp_direct() only checks
ptp_tx_tstamp->deadline when !ptp_tx_tstamp->tstamp, so a latch whose
readiness and valid bits were set before the timer stopped will have its old
32-bit timestamp extended against the current PHC time and reported via
skb_tstamp_tx().

Should idpf_ptp_request_ts() verify tx_type under latches_lock, and should
disabling Tx timestamping flush latches_in_use (or let the timer drain
remaining entries before stopping)?

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/driver=
s/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> index 427b15281ad0d..6443ce34a0d92 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> @@ -48,6 +48,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
>  				    VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
>  				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
>  				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
> +				    VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
>  				    VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB)
>  	};

[Severity: High]
In idpf_ptp_get_caps(), can the cross_tstamp block overwrite a valid
ptp->dev_clk_regs.cmd_sync pointer with NULL while leaving
get_dev_clk_time_access and adj_dev_clk_time_access set to IDPF_PTP_DIRECT?

When ptp->get_dev_clk_time_access is IDPF_PTP_DIRECT, idpf_ptp_get_caps()
maps clock_offsets.cmd_sync_trigger into ptp->dev_clk_regs.cmd_sync and
validates it in clk_regs[]:

drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c:idpf_ptp_get_caps() {
    ...
	temp_offset =3D le32_to_cpu(clock_offsets.cmd_sync_trigger);
	ptp->dev_clk_regs.cmd_sync =3D
		libie_pci_get_mmio_addr(mmio, temp_offset);
    ...
	ptp->get_dev_clk_time_access =3D
		idpf_ptp_regs_access(ptp, clk_regs, ARRAY_SIZE(clk_regs),
				     VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB);

cross_tstamp:
	access_type =3D ptp->get_cross_tstamp_access;
	if (access_type !=3D IDPF_PTP_DIRECT)
		goto discipline_clock;

	cross_tstamp_offsets =3D recv_ptp_caps_msg->cross_time_offsets;
    ...
	temp_offset =3D le32_to_cpu(cross_tstamp_offsets.cmd_sync_trigger);
	ptp->dev_clk_regs.cmd_sync =3D
		libie_pci_get_mmio_addr(mmio, temp_offset);
}

If cross_tstamp_offsets.cmd_sync_trigger cannot be mapped,
libie_pci_get_mmio_addr() returns NULL and overwrites
ptp->dev_clk_regs.cmd_sync. Checking cross_regs[] then downgrades
ptp->get_cross_tstamp_access, but ptp->get_dev_clk_time_access,
ptp->adj_dev_clk_time_access (whose adj_regs[] does not include cmd_sync),
and ptp->set_dev_clk_time_access remain IDPF_PTP_DIRECT, causing subsequent
calls to idpf_ptp_tmr_cmd() and idpf_ptp_enable_shtime() to pass a NULL
ptp->dev_clk_regs.cmd_sync pointer to writel().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102110717.7780=
0-1-przemyslaw.korba@intel.com?part=3D2
