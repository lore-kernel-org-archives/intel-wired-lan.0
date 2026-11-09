Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5A606A323
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=C9/bPJ5W;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOf7gr3N
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63E7E80E3A;
	Mon,  9 Nov 2026 11:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mjnrt_Q1jfXe; Mon,  9 Nov 2026 11:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44D1680E9C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794223839;
	b=p2e9Yw+yvv2BDXnd7CFqNn9iGXMzDM2xTWQi11C8FDTRC0+kyAPisRb7LP7obqEERPBq
	 T8NUxjOnx6RAa2auJsBfjVph+33XeBGV3P5lKamIlBtf1GNsRU/+xxM15XFWrrSYwMtyO
	 jr4h0nY1tXyTjnsqTjgzkqXpzwfaivC43+6io5tAlWwuGuB3011mzZN9FvaMJFIPBEUke
	 QLYkVaiJS0fhEnG9s+jE3WOUIx0vv1GzCuGpjqvdXrYqzm9bNLlMrhC1rRY4RZg2qFuoY
	 ZjpDIBo7nBZUC3YtU/QBANWxit7PkpJV4KRAXHDCob1xX3o5hY8btLZxCa/qcbwmYZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794223839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=oxpmu8R+sqJCgw4Gftw1Depv82FAicZqr6QGDSwTjUc=;
	b=J2UW04ipSYsI5zXqb5UkVrOSKTtczHDN0ng8FxoAz2i+iAyt1Ydz8H5fsaZbEYgF7Oxo
	 ndzDLPF1UqPXavG+b994vS35NZlEV+jJLRLW0DBmqD/DkBY9edGBO0elk8L/OLQJAPxPl
	 xCCkMeYlm+JNJ5sKwUz3NlkunrfSwFLRxfs4lJN+eu1xSYo5sqbq06RjBddehmDWF+Xgk
	 OJ8WxcW63cy1GIZaoaFpCFYpJyB8Q8T9K20zLLdPsMiLzKOf5EMdGxO1SdqTCAHv7gAPL
	 2Zsbs/xq948Hf4hC35neZ00r8MC09G2DQFeEmIblKnR2Ytt3CR/VnrvuVyM9sAa+B9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794223839;
	bh=oxpmu8R+sqJCgw4Gftw1Depv82FAicZqr6QGDSwTjUc=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=C9/bPJ5WJGuPNU4Ng29WJaFGyTv5iOWD58ba11q9Ic4Bnr2h0+Fsavxhlqry/BD8e
	 9hi6uaorYZ+CYCWMo7dg48Lp6csNA8xEQe0bqal4Xqo0q1ut+M07JSG27FMSKylf/t
	 ExpphQCaF8m1s/jZvs0upuNqlSlBA4/uFDJh0eBpK9gciF4PaXh/f1OEeAPGccJyW7
	 BgyPeS67n/SO8bQkMxHCF0hGOyerMwSqJFIWuTtF6Yf09rjuwoe7RWouji7EriMfbA
	 DE8Yb3ZoSrzrCSawV+nd8GboGpY7ZFipVT+woPkXtZBxJkQxHGV4xG8m9aVQ4+mEjw
	 X2cLDg0CnGoUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44D1680E9C;
	Mon,  9 Nov 2026 11:30:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A3C7932
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07ACF606E3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cmH6mmK8TQF for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 11:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBE27605CB
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iOf7gr3N
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBE27605CB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:30:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EBA9415C6;
 Mon,  9 Nov 2026 11:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143541F0089F;
 Mon,  9 Nov 2026 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794223835;
 bh=oxpmu8R+sqJCgw4Gftw1Depv82FAicZqr6QGDSwTjUc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=iOf7gr3NzgauArtwSeIpTcmpd5v8sCsHPjXtmZQoLc5XWSkMveoJ+SPuLcXSa49E0
 zo8upVPyjrOkTy9qlUapvcXU2y6+zLbWXrri7e1NCHCz7cBHIn5WPHyrZoOBN0HliD
 MTUleh3seymiPT5wAqW4SAImW7RCfS4WapHiklBzM7zj4SScK4uOMZ7uzAMwkp2wt9
 SMVamIvERibqUQ4QniATVlkJCq28ioXqaETKKlKm8rgzUY3Y8VfjyBMTDqDMGq5f8n
 kOAKGC7FWYIcysZzJOaFvTwzbasvDoF0j9BaTiC0P2qZs/vzyhCr5Gx/ms3rNTsdG8
 G06AGJ3MzyiVg==
Message-ID: <sashiko-outbox-204874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v2 2/2] idpf: add direct Tx timestamp readout
To: "Przemyslaw Korba" <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261109105433.133056-5-przemyslaw.korba@intel.com>
References: <20261109105433.133056-1-przemyslaw.korba@intel.com>
 <20261109105433.133056-5-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:30:34 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] idpf: hrtimer_start() race with hrtimer_forward_now() in
  tx_tstamp_timer
- [Medium] idpf: stale W1C readiness bits left set after latch timeout
  or flush
- [Medium] idpf: premature readiness clear when
  idpf_ptp_read_tx_tstamp() returns 0
- [Medium] idpf: missing IDPF_VPORT_UP check in
  idpf_ptp_tx_tstamp_start() and mode set
--

commit 6ef55bc62ac37c13a04d2106837cebcae6373e12
Author: Przemyslaw Korba <przemyslaw.korba@intel.com>

idpf: add direct Tx timestamp readout

This commit adds direct BAR register readout for Tx timestamps using a
periodic 100 us hrtimer to poll a 64-bit hardware readiness bitmap and
reclaim expired latch requests after 500 ms.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/eth=
ernet/intel/idpf/idpf_ptp.c
> index df2da430ff28f..f66ba6fb4ea09 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c

[ ... ]

> @@ -851,19 +925,287 @@ int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q=
, struct sk_buff *skb,
>  	return 0;
>  }
> =20
> +/**
> + * idpf_ptp_read_tx_tstamp - Read and extract timestamp from latch regis=
ters
> + * @tstamp_caps: Tx timestamp capabilities of the vport
> + * @tx_tstamp: Tx timestamp structure with latch register addresses
> + *
> + * Read the timestamp from the latch registers, whose layout the IDPF
> + * specification defines as:
> + *   low  bit[0]   : valid flag
> + *   low  bit[31:1]: timestamp bits [30:0]
> + *   high bit[7:0] : timestamp bits [38:31]
> + * Together they form a 39-bit timestamp, which is then shifted right by
> + * tstamp_ns_lo_bit to remove sub-nanosecond precision bits.
> + *
> + * The caller has already found the latch index set in the readiness bit=
map,
> + * which is preferred over the per-latch valid flag because it covers ev=
ery
> + * latch in a single pair of reads. The valid flag is still checked here=
, as
> + * the hardware may overwrite a latch whose readiness bit has been left =
set.
> + *
> + * @latches_lock must be held across the readiness check, this call and =
the
> + * subsequent clearing of the readiness bit, to keep the index from being
> + * recycled in between.
> + *
> + * Return: extracted timestamp value in nanoseconds, 0 if the latch does=
 not
> + * hold a valid timestamp.
> + */
> +static u64
> +idpf_ptp_read_tx_tstamp(struct idpf_ptp_vport_tx_tstamp_caps *tstamp_cap=
s,
> +			struct idpf_ptp_tx_tstamp *tx_tstamp)
> +{
> +	u32 tstamp_l, tstamp_h;
> +	u64 tstamp;
> +
> +	lockdep_assert_held(&tstamp_caps->latches_lock);
> +
> +	tstamp_l =3D readl(tx_tstamp->tx_latch_reg_addr_l);
> +	tstamp_h =3D readl(tx_tstamp->tx_latch_reg_addr_h);
> +
> +	if (unlikely(!(tstamp_l & IDPF_PTP_TX_TSTAMP_L_VALID_M)))
> +		return 0;
> +
> +	tstamp =3D FIELD_GET(IDPF_PTP_TX_TSTAMP_L_TSTAMP_M, tstamp_l);
> +	tstamp |=3D FIELD_PREP(IDPF_PTP_TX_TSTAMP_H_POS_M,
> +			     FIELD_GET(IDPF_PTP_TX_TSTAMP_H_TSTAMP_M, tstamp_h));
> +
> +	return tstamp >> tstamp_caps->tstamp_ns_lo_bit;
> +}

[ ... ]

> +static void idpf_ptp_get_tx_tstamp_direct(struct idpf_vport *vport)
> +{
> +	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
> +	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
> +	u64 readiness_bitmap, clear_map =3D 0;
> +	LIST_HEAD(done);
> +
> +	tstamp_caps =3D vport->tx_tstamp_caps;
> +
> +	spin_lock(&tstamp_caps->latches_lock);
> +
> +	if (list_empty(&tstamp_caps->latches_in_use)) {
> +		spin_unlock(&tstamp_caps->latches_lock);
> +		return;
> +	}
> +
> +	readiness_bitmap =3D idpf_ptp_read_tx_tstamp_readiness(tstamp_caps);
> +
> +	list_for_each_entry_safe(ptp_tx_tstamp, tmp,
> +				 &tstamp_caps->latches_in_use, list_member) {
> +		u32 idx =3D ptp_tx_tstamp->idx;
> +
> +		ptp_tx_tstamp->tstamp =3D 0;
> +
> +		if (readiness_bitmap & BIT_ULL(idx)) {
> +			ptp_tx_tstamp->tstamp =3D
> +				idpf_ptp_read_tx_tstamp(tstamp_caps,
> +							ptp_tx_tstamp);
> +			clear_map |=3D BIT_ULL(idx);
> +		}
> +
> +		/* A latch with no timestamp is kept in use until its deadline
> +		 * passes, as the hardware may still be about to report it.
> +		 * Once it does, drop its readiness bit as well, so that the
> +		 * next user of the index is not given a stale timestamp if
> +		 * the hardware reports one after the latch has been reclaimed.
> +		 */
> +		if (!ptp_tx_tstamp->tstamp) {
> +			if (time_is_after_jiffies(ptp_tx_tstamp->deadline))
> +				continue;
> +
> +			clear_map |=3D BIT_ULL(idx);
> +		}
> +
> +		list_move(&ptp_tx_tstamp->list_member, &done);
> +	}
> +
> +	/* The indexes are not recycled before the splice below, so the bits
> +	 * of every latch read above can be dropped in a single write.
> +	 */
> +	idpf_ptp_clear_tx_tstamp_ready(tstamp_caps, clear_map);

[Severity: Medium]
Does setting clear_map |=3D BIT_ULL(idx) before checking
!ptp_tx_tstamp->tstamp strand the latch when idpf_ptp_read_tx_tstamp()
returns 0?

If readiness_bitmap has BIT_ULL(idx) set but idpf_ptp_read_tx_tstamp()
returns 0 (either because IDPF_PTP_TX_TSTAMP_L_VALID_M is not set or
because the shifted timestamp is legitimately 0), the loop continues and
keeps ptp_tx_tstamp on latches_in_use, while
idpf_ptp_clear_tx_tstamp_ready() clears BIT_ULL(idx) in the hardware
readiness register.  Subsequent timer ticks will never see BIT_ULL(idx) set
again, so the latch stalls until its 500 ms deadline expires and the skb is
dropped.

[ ... ]

> +void idpf_ptp_tx_tstamp_start(struct idpf_vport *vport)
> +{
> +	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
> +	    vport->tx_tstamp_caps->access !=3D IDPF_PTP_DIRECT)
> +		return;
> +
> +	if (READ_ONCE(vport->tstamp_config.tx_type) =3D=3D HWTSTAMP_TX_ON)
> +		hrtimer_start(&vport->tx_tstamp_timer,
> +			      IDPF_PTP_TX_TSTAMP_PERIOD_NS,
> +			      HRTIMER_MODE_REL_SOFT);
> +}

[Severity: Medium]
Can idpf_hwtstamp_set() -> idpf_ptp_set_timestamp_mode() start
vport->tx_tstamp_timer and dereference a NULL rsrc->rxq_grps while the
vport is down?

idpf_hwtstamp_set() only checks vport->link_up, which
idpf_handle_event_link() sets before checking test_bit(IDPF_VPORT_UP,
np->state) (and which idpf_vport_open() also leaves true if
idpf_config_rss() fails and unwinds queue allocation).  If hardware
timestamping is configured while the vport is in that state,
idpf_ptp_tx_tstamp_start() starts tx_tstamp_timer while the vport is down
and idpf_ptp_set_rx_tstamp() then dereferences NULL
vport->dflt_qv_rsrc.rxq_grps.

> +/**
> + * idpf_ptp_tx_tstamp_stop - Stop collecting the Tx timestamps
> + * @vport: Virtual port structure
> + *
> + * Stop the collection timer and flush the latches that are still waitin=
g for
> + * a timestamp, as nothing would collect them anymore. No new latch is h=
anded
> + * out afterwards, either because the Tx timestamping has been disabled,=
 which
> + * idpf_ptp_request_ts() checks under the latches lock, or because the T=
x path
> + * is stopped.
> + */
> +void idpf_ptp_tx_tstamp_stop(struct idpf_vport *vport)
> +{
> +	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
> +	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
> +	u64 clear_map =3D 0;
> +
> +	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
> +	    vport->tx_tstamp_caps->access !=3D IDPF_PTP_DIRECT)
> +		return;
> +
> +	tstamp_caps =3D vport->tx_tstamp_caps;
> +
> +	hrtimer_cancel(&vport->tx_tstamp_timer);
> +
> +	spin_lock_bh(&tstamp_caps->latches_lock);
> +
> +	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
> +	list_for_each_entry_safe(ptp_tx_tstamp, tmp,
> +				 &tstamp_caps->latches_in_use, list_member) {
> +		u64_stats_inc(&vport->tstamp_stats.flushed);
> +
> +		clear_map |=3D BIT_ULL(ptp_tx_tstamp->idx);
> +
> +		if (ptp_tx_tstamp->skb)
> +			consume_skb(ptp_tx_tstamp->skb);
> +
> +		ptp_tx_tstamp->skb =3D NULL;
> +		list_move(&ptp_tx_tstamp->list_member,
> +			  &tstamp_caps->latches_free);
> +	}
> +	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
> +
> +	idpf_ptp_clear_tx_tstamp_ready(tstamp_caps, clear_map);
> +
> +	spin_unlock_bh(&tstamp_caps->latches_lock);
> +}

[Severity: Medium]
Can an in-flight packet set the write-1-to-clear readiness bit after its
latch has already been cleared and returned to latches_free?

When a latch is flushed here by idpf_ptp_set_timestamp_mode() while the
vport is still transmitting, or when its 500 ms deadline expires in
idpf_ptp_get_tx_tstamp_direct(), idpf_ptp_clear_tx_tstamp_ready() writes 1
while the hardware readiness bit is still 0 (a no-op on W1C registers) and
moves the latch to latches_free.  If the packet carrying that latch index in
its TSYN context descriptor is still queued in the hardware Tx ring and
transmits afterwards, hardware sets both the readiness bit and
IDPF_PTP_TX_TSTAMP_L_VALID_M while the latch sits on latches_free, so the
next packet to reuse that index will report the previous packet's stale
timestamp.

[ ... ]

> @@ -923,12 +1265,21 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport =
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
> +	/* Publish the new mode first, so that the Tx path stops handing out
> +	 * latches, then flush the ones that are still waiting.
> +	 */
> +	WRITE_ONCE(vport->tstamp_config.tx_type, config->tx_type);
> +	if (config->tx_type =3D=3D HWTSTAMP_TX_ON)
> +		idpf_ptp_tx_tstamp_start(vport);
> +	else
> +		idpf_ptp_tx_tstamp_stop(vport);

[Severity: Medium]
Can idpf_ptp_set_timestamp_mode() call hrtimer_start() on
vport->tx_tstamp_timer while idpf_ptp_tx_tstamp_timer_cb() is running?

When Tx timestamping is already HWTSTAMP_TX_ON and user space issues another
SIOCSHWTSTAMP or ETHTOOL_MSG_TSCONFIG_SET with HWTSTAMP_TX_ON (for example,
to change rx_filter or when restarting ptp4l), idpf_ptp_tx_tstamp_start()
calls hrtimer_start() without cancelling the running timer first:

CPU0                                  CPU1
<softirq>
idpf_ptp_tx_tstamp_timer_cb()
  idpf_ptp_get_tx_tstamp_direct()
                                      idpf_hwtstamp_set()
                                        idpf_ptp_set_timestamp_mode()
                                          idpf_ptp_tx_tstamp_start()
                                            hrtimer_start(&tx_tstamp_timer)
                                              /* enqueues timer */
  hrtimer_forward_now(timer, ...)
    WARN_ON(timer->is_queued)  <-- modifies expires while queued in rbtree
  return HRTIMER_RESTART;

hrtimer_forward_now() runs without cpu_base->lock held and requires the
timer not to be concurrently enqueued, so this triggers WARN_ON(timer->is_q=
ueued)
in hrtimer_forward() and modifies timer->node.expires while the node is in
the active timer rbtree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109105433.1330=
56-1-przemyslaw.korba@intel.com?part=3D2
