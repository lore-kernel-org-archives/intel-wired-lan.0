Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=lctNxoHg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tww19XHu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FE8A40D8A;
	Thu, 12 Nov 2026 13:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtgM0R-Jc77t; Thu, 12 Nov 2026 13:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BF5440D7B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794489786;
	b=VUzph5WP9XUiRTCjsACUjTtoF+z//p4LV1CN9O62H8VC3H/IftVtMmHMeLThs3yXHmgn
	 SgAhmaG7FKUbkKZEm1l/ZIUpNJw+GMOVA+SFkvq6K8FI1PRU7DAxoGolJN56QLSQApGDf
	 Ydijg/KeOXM02RcT4a+vTTZ4s4C6MKgPoY4F6iB3N2vE+0AZMSVi9pmT8x2v6Aftdo776
	 syfAbP5az/vJdJIUd7g1QWBYuqZl9uZwVjJREQSTrQkW64otom0QxfaKrHBIbxkCLNer4
	 iWQIhRntmdaN4GG040FdVHR6gjV/dNsUwpRsCMnL4EOj5y7XG+tilSm1FrxzWTzo8JQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794489786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=PgvNAX60AsNfHFQ8g0A1cpwnOLMIGgvouPOMdghTQuc=;
	b=YsxuEB+Sy/29JKE5AwPr+YswIK/TNbK7k2TlB9NOKSuy+QHD5ecq7hO3LTXdBhEh0LAT
	 EBndKiPaVX2Wzkp6dTmdtH0TkBdnGwDOmeW/6frU3nkFEih4Kf0pEBr8k40FBVsCji7nn
	 LFoUO6RXs1JypARv2+FrIpIih7Q47kvTn5qpfXfrptWw0WhcDQf2/jgjRbik76og1k5RO
	 XXuopDOKvncdMqQ1v/Pj4C+mWsOWaQG8PDGcMVbQdZ/Prlnl5wrkVNU5MqYi0pGTw/7dI
	 oPnbrqUrnBa/q3bB7gf+ex1+BUePSqSHAivI+VNLCyLC6dIjdEIV1Rre4JdldquG63A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tww19XHu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794489786;
	bh=PgvNAX60AsNfHFQ8g0A1cpwnOLMIGgvouPOMdghTQuc=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=lctNxoHgocExUjgkCo++oRWL2E9sZCFtIrySgLuzhVXRExwFEULlo3Fr53R0OgilV
	 U6CR+HpWjvInD54CkN4CapU302OTjAtXzf/SU7aWUTp8L0cKnjZ8zbBRv0U7FayUTW
	 u1ZahgPagsYEEBZzRp0STGGeCBvqiDMECvz4PAR9DgdDYhtpC+rDiP+yDaa49LQe/F
	 tf/kKeCk2sCv/0lAGtwxZfqw5eceZ5YmUh+yq7Q/rKf1iHfkxkbYId7JO8PcWaza0y
	 v5Z9CamUml2J3s6wSTQgGWr23IOpE7Fe5vSbWQAkLcb5H2/+/oh54MyBs1zpcuxoQM
	 Fh6yhUFothutg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BF5440D7B;
	Thu, 12 Nov 2026 13:23:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03A3A235
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 13:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 924A740D18
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 13:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJP-S5IYIY5o for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 13:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6217C40A32
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Tww19XHu
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6217C40A32
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 13:23:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43604605E9;
 Thu, 12 Nov 2026 13:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADC31F00A05;
 Thu, 12 Nov 2026 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794489781;
 bh=PgvNAX60AsNfHFQ8g0A1cpwnOLMIGgvouPOMdghTQuc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Tww19XHuSf6ViZdrnNUrkD/Hm7CIYpcaugQnJrIsDJzwgqYjXtSbrIqVLNIyv+UcR
 8L1Jv+jAFseSBW6+gYodzQSS5lBAFp7tRomffhiioAZ4tZ9oU0DZUB8CxGCW2xIUia
 0fVdB2qZJsIxAkFeC+S5qBTTsJwdmuAeUExblPT4YL6Y6Gsk5utYjyXcHmybDxVNI3
 Hp1A/oEenCKYjRm9nA6fCaHAeSVW58umeXI5Z6rGyiXFuz5fH8jxxD9sBDF4bzWf8I
 /dwKBzFbeESD0kGhZ8tPyqFI94m4aCwkI6a7Nnla01HCNavVfzN/WWJ3H/gOHky919
 R5AMRzXuXCowQ==
Message-ID: <sashiko-outbox-211168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v3 2/2] idpf: add direct Tx timestamp readout
To: "Przemyslaw Korba" <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261112123503.234508-5-przemyslaw.korba@intel.com>
References: <20261112123503.234508-1-przemyslaw.korba@intel.com>
 <20261112123503.234508-5-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:23:00 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] idpf: premature idpf_ptp_release() before vport stop in
  idpf_vc_core_deinit()
- [Medium] idpf: stale W1C readiness bits left set after latch timeout
  or flush
- [Medium] idpf: missing IDPF_VPORT_UP check in
  idpf_ptp_tx_tstamp_start() and mode set
--

commit 4103e67711694e72d8e2828d99514ccf51cd2f07
Author: Przemyslaw Korba <przemyslaw.korba@intel.com>

idpf: add direct Tx timestamp readout

This commit adds direct BAR register access for reading Tx timestamps via a
periodic 100 us hrtimer, along with write-1-to-clear readiness bitmap
handling and a 500 ms expiration timeout for unlatched requests.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/eth=
ernet/intel/idpf/idpf_ptp.c
> index df2da430ff28f..5d745a53d6865 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c

[ ... ]

> @@ -851,19 +925,296 @@ int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q=
, struct sk_buff *skb,

[ ... ]

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
Can a packet that latches in hardware after its deadline expires (or after
idpf_ptp_tx_tstamp_stop() flushes latches_in_use) leave its write-1-to-clear
readiness bit set while the latch sits on latches_free?

Because readiness_addr_l and readiness_addr_h are write-1-to-clear, calling
idpf_ptp_clear_tx_tstamp_ready() when the deadline expires (or when
HWTSTAMP_TX_OFF flushes latches_in_use on a live vport) is a no-op for any
in-flight packet whose readiness bit is still 0 in hardware.  If that queued
packet finishes transmission afterwards (for example, after SO_TXTIME pacing
or flow control), the hardware sets both the readiness bit and
IDPF_PTP_TX_TSTAMP_L_VALID_M while the latch is on latches_free, so the next
packet allocated that index will report the previous packet's stale
timestamp.

Clearing stale readiness bits in idpf_ptp_get_tx_tstamp_direct() for bits
not currently in latches_in_use (and in idpf_ptp_tx_tstamp_start()) would
avoid handing out a latch with a pending hardware timestamp.

[ ... ]

> +void idpf_ptp_tx_tstamp_start(struct idpf_vport *vport)
> +{
> +	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) ||
> +	    vport->tx_tstamp_caps->access !=3D IDPF_PTP_DIRECT)
> +		return;
> +
> +	/* The callback re-arms itself, so it must be finished before the timer
> +	 * is started again, e.g. when only the Rx filter is being changed.
> +	 */
> +	if (READ_ONCE(vport->tstamp_config.tx_type) =3D=3D HWTSTAMP_TX_ON) {
> +		hrtimer_cancel(&vport->tx_tstamp_timer);
> +		hrtimer_start(&vport->tx_tstamp_timer,
> +			      IDPF_PTP_TX_TSTAMP_PERIOD_NS,
> +			      HRTIMER_MODE_REL_SOFT);
> +	}
> +}

[ ... ]

> @@ -923,12 +1274,21 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport =
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
> +
>  	idpf_ptp_set_rx_tstamp(vport, config->rx_filter);
>  	*config =3D vport->tstamp_config;

[Severity: Medium]
Can idpf_hwtstamp_set() -> idpf_ptp_set_timestamp_mode() start
vport->tx_tstamp_timer and dereference a NULL rsrc->rxq_grps when the vport
is down?

idpf_hwtstamp_set() only checks vport->link_up, which
idpf_handle_event_link() sets even while IDPF_VPORT_UP is clear and queues
are not allocated.  Calling idpf_ptp_set_timestamp_mode() in that state arms
tx_tstamp_timer on a stopped vport and then crashes in
idpf_ptp_set_rx_tstamp() when indexing rsrc->rxq_grps.

Also, when a vport is reopened, idpf_vport_open() calls
idpf_ptp_tx_tstamp_start(vport) before idpf_up_complete() sets IDPF_VPORT_U=
P,
and never calls idpf_ptp_set_rx_tstamp() to restore the PTP flag on the
newly allocated Rx queues.

> @@ -1035,8 +1395,19 @@ static void idpf_ptp_release_vport_tstamp(struct i=
dpf_vport *vport)
>  {
>  	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp, *tmp;
>  	struct list_head *head;
> +	u64 clear_map =3D 0;
> =20
> -	cancel_work_sync(&vport->tstamp_task);
> +	switch (vport->tx_tstamp_caps->access) {
> +	case IDPF_PTP_MAILBOX:
> +		cancel_work_sync(&vport->tstamp_task);
> +		break;
> +	case IDPF_PTP_DIRECT:
> +		hrtimer_cancel(&vport->tx_tstamp_timer);
> +		break;
> +	case IDPF_PTP_NONE:
> +	default:
> +		break;
> +	}
> =20
>  	/* Remove list with free latches */
>  	spin_lock_bh(&vport->tx_tstamp_caps->latches_lock);

[ ... ]

> @@ -1061,6 +1436,10 @@ static void idpf_ptp_release_vport_tstamp(struct i=
dpf_vport *vport)
>  	}
>  	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
> =20
> +	if (vport->tx_tstamp_caps->access =3D=3D IDPF_PTP_DIRECT)
> +		idpf_ptp_clear_tx_tstamp_ready(vport->tx_tstamp_caps,
> +					       clear_map);
> +
>  	spin_unlock_bh(&vport->tx_tstamp_caps->latches_lock);
> =20
>  	kfree(vport->tx_tstamp_caps);

[Severity: High]
Can idpf_vc_core_deinit() free vport->tx_tstamp_caps while Tx queues and
ndo_hwtstamp_set are still active?

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_vc_core_deinit() {
    ...
	idpf_ptp_release(adapter);
	idpf_deinit_task(adapter);
    ...
}

During idpf_remove() and idpf_shutdown(), idpf_ptp_release() runs before
idpf_deinit_task() stops the vports and unregisters the netdevs, and without
holding vport_ctrl_lock:

CPU0                                  CPU1
idpf_vc_core_deinit()
  idpf_ptp_release()
    idpf_ptp_release_vport_tstamp()
      hrtimer_cancel(&tx_tstamp_timer)
                                      idpf_hwtstamp_set()
                                        ...
                                          idpf_ptp_tx_tstamp_start()
                                            hrtimer_start(&tx_tstamp_timer)
      kfree(vport->tx_tstamp_caps)
      vport->tx_tstamp_caps =3D NULL
                                      <softirq>
                                        idpf_ptp_tx_tstamp_timer_cb()
                                          idpf_ptp_get_tx_tstamp_direct()
                                            spin_lock(&tstamp_caps->...)
                                            <-- NULL pointer dereference

In addition, because vport->tstamp_config.tx_type remains HWTSTAMP_TX_ON and
each queue's tx_q->cached_tstamp_caps still points to the freed structure
until idpf_deinit_task() -> idpf_vport_stop() disables Tx, any packet
transmitted or completed in the meantime dereferences freed
tx_q->cached_tstamp_caps in idpf_ptp_request_ts() or idpf_tx_read_tstamp().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112123503.2345=
08-1-przemyslaw.korba@intel.com?part=3D2
