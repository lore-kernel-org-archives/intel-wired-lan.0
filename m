Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71066CC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 12:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19E376079F;
	Wed, 14 Oct 2026 12:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4vFtapEZXfI; Wed, 14 Oct 2026 12:13:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1BE20607CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791979991;
	b=BAzZ6zaxbm8s369sMmru7wR4/IBzvCRO8nS5AYc5QuxZMX4b6l/mwNzR9j47FZN95mdL
	 GIkyTN4iJPZwt4Qv98tJgiXgE8updWLYbh1UaxgXuXblQPculxBiN89CvSQM4++4iv8sF
	 EN93QED1iMkzA2wsTlc+HNoMK7ilnbZuv2LJVXVidRx+ilBwMOSMgIIjJvL1DI2N6zkbr
	 UXDdvaHlTkfpD/zGZ0PX1sOSv/iN8zQHGYo62wm0H7os1MGlIHYJvO0lYhQJ81Q60iNfh
	 hnfduX92tdTzXpkBD/PfGoyz4mUyUARRfvJHIn7n/0zJCmrMwhr0r11RYrwvjSq/AHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791979991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=yMbFCNRQX0FE+5jxY4xEm6arUlX5TFsAZ1DLjXtS0Bk=;
	b=PZlft6nLhKqzpjPrTdKYwKBJeDz+F6qmNCDniZavbBTh4q4w+V6wT7A4u2OcngtES8iX
	 IzYBKHV5bnt5wXepgsYTEjXWYk+C4gZKHRBS2vFlrIXFNcQnaoW5rKn7kDXSIFC7Mhk1H
	 T1UfLbKDS4RWRM7qpWBp5s9a40b4s/51VXnK9eqtfgue6qeAqsFv5XoR59vSHaHdf9VVS
	 v50S2RvHdncMK4tJ9YM8/3XQiFFwQ6IpWnLpP/kkTvr6n/IKsbVQQaI4Lx3Mm+ZXyhbnT
	 /UHBfWZ/FSElyoFkqUaI/QfU28CtkyA9lkfgGQ1dyQIaS5r0DkkYu/9cfrh07nGVp3g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791979991;
	bh=yMbFCNRQX0FE+5jxY4xEm6arUlX5TFsAZ1DLjXtS0Bk=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=a6ZDmMr9/Q+ZbGU2LdX47xXxIP3kKMKgLER0pY+/Ot0MEFw6rItg8f4iQv15Hku15
	 5JFtT3myJY1PQ8IvzNVS986/JfjaPw9wuhL9oU3BTlddJT5DdLyge/D/+OJ27HAkhM
	 DIeUOIdNc/ComBYgSH5cqs/cU7ZELZ31Ax0jLu8l9q+cP3iz5uANLgxGURlTZhA52o
	 9v8KONPDHgAjwIoqeeVmtGfktyTJ6kEZ7X4fpAXAy8LLyTSTvIeXU8Tx4ltBfzJe3S
	 RWg/5P14nNZJk2zjha/6o5E6xbFEHPwF3V1jsOtPMpvuJd5ygX79oysulBajsIocm6
	 kkdLzEpNtaJsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BE20607CA;
	Wed, 14 Oct 2026 12:13:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD3512E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 12:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 937FF80D4A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 12:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kqu5-AshsBuP for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 12:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9697B806A1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791979988;
 b=G3hPCKfIniFMJJKoJzP+/T2ec8gnXtgu8rSvvsX/0Cag9B0hGjpeL9Tnatdc8BVUTH7C
 EJuhO6urG64PuNeKTg2FNDh8W+jslJQiebs8AiN4guhQg9rsQUiPiN/3/aA+NSZUgX1T+
 YtDimeAVurCGoDjcBqa15mn5E8HJIFHJ5kCFmJTQ7B3z6l64ADNn6MWPjCPJPi7Nfr8xm
 MLX6ylgukLPRZtWv6092fjF5uzXOw63sDQQPQTITajWxFBOsFsp7ZybdKK4uE9txmFDdn
 zKQru0ho1fxugrJkKqteE7YGferHGyIghLBWHv2nxwbeqTSpQt0gd57ypvtqWb7B/QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791979988;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=yMbFCNRQX0FE+5jxY4xEm6arUlX5TFsAZ1DLjXtS0Bk=;
 b=RkXxqdv2rWl8vOFriDHwU82A7lJsjTTgBIRxz1b1MPdcvHXgGqO+l8PZuEoaHL+W5SPJ
 d6FQXK2cw6FUx1AJE5pUzDYIcSY6X7T8yQHZ8XSKX+ZH4j1vMHfWzoZRLu4Q91uP+TJrQ
 7PIaWxA/HIkn1rb2lmdf3MZmdFTpODfScl7xIRXbVSZE07qZr+t9+FNJNMaxkHguvbSOc
 8kGGA4EMN2hQDozTepJ/5+vBahYszYPxUnCTkOguTTOzQX3m/F9j2+duZxdTTW/RH08YD
 SERdMp3JDBSMTWlUfLbvLH7b/rB5mPrwMvU2r5sQo6AD1LQmj9ypDxRPdR/soLPbgiQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CKoQOKij; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CKoQOKij
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9697B806A1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 12:13:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66055423C5;
 Wed, 14 Oct 2026 12:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E11F000FF;
 Wed, 14 Oct 2026 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791979987;
 bh=yMbFCNRQX0FE+5jxY4xEm6arUlX5TFsAZ1DLjXtS0Bk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=CKoQOKijilD8Z3Vr0UyGUOBVRzKwQ1WxRqPmNsWTvUS8qWumcAtBJuWRw/RvU63Bn
 gTOp05DwoKUfUEgeoTR4+0Xo0KPWjRJ5jldsMHdTIrD1tbgidHFpiPdPHFFN0leF7q
 aLQv3VVmOaSRvCPU699PDf1KjK1Ykcm7sASxEeCC927IXKmBGuBJeomF97hsPyqQ47
 m4x/Z2g1oTwt6WRW4gXPnIk3J8+WXBH2W4jLVvdaW+MpYORTxsqggTScGgE5UremVm
 TZ3OZxSGEnK2qby+3/w91BodJAWgFhGggMf4DsuGKzWlXWMjQddFO1XvjH/XSqDENM
 bloRCjgqXwXDg==
Message-ID: <sashiko-outbox-171247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing
 down vports on shutdown
To: "Tian Xun Ng" <luckilystar08@gmail.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261013121224.84482-4-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-4-luckilystar08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:13:06 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] idpf: NULL pointer dereference in idpf_tx_start during shutdown
- [High] idpf: SW marker consumption race causes cascading timeouts
- [High] idpf: DMA memory corruption on slow CP during shutdown
--

commit 0b30345598a4b0c67b0f2410c2aaf6bf5c4a2f30
Author: Tian Xun Ng <tianxun.ng@bytedance.com>

idpf: keep the mailbox up while tearing down vports on shutdown

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
before idpf_deinit_task() tears the vports down.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/et=
hernet/intel/idpf/idpf_main.c
> index 129bccaa6baa8..21be83dc82b1b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
>  {
>  	struct idpf_adapter *adapter =3D pci_get_drvdata(pdev);
> =20
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>  	cancel_delayed_work_sync(&adapter->serv_task);
>  	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Bound the teardown transactions started from here on, so that an
> +	 * unresponsive control plane costs a single timeout. A reset or a
> +	 * transaction that is already running keeps its own timeouts.
> +	 */
> +	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
>  	idpf_vc_core_deinit(adapter);

[Severity: High]
If a hardware reset is in progress (IDPF_HR_RESET_IN_PROG is set),
idpf_vport_dealloc() skips calling idpf_vport_stop() and idpf_decfg_netdev(=
).

This leaves the netdev fully registered with active transmit queues, while =
the
underlying vport is freed and np->vport is set to NULL:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_dealloc() {
    if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags)) {
        idpf_vport_stop(vport, true);
        idpf_decfg_netdev(vport);
    }
    ...
    if (adapter->netdevs[i]) {
        struct idpf_netdev_priv *np =3D netdev_priv(adapter->netdevs[i]);
        np->vport =3D NULL;
    }
    idpf_vport_rel(vport);
}

Unlike idpf_remove(), the idpf_shutdown() function lacks a fallback loop to
unregister stale netdevs or detach the device.

If the networking stack transmits a packet before the system finishes halti=
ng,
idpf_tx_start() will dereference the NULL vport:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:idpf_tx_start() {
    const struct idpf_vport *vport =3D idpf_netdev_to_vport(netdev);
    ...
    if (unlikely(skb_get_queue_mapping(skb) >=3D
                 vport->num_txq - vport->num_xdp_txq)) {

Can this lead to a NULL pointer dereference kernel panic during shutdown?

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 2cfd216ae92b1..331d56faee253 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

[ ... ]

> @@ -218,10 +230,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
>  	xn_params->xnm =3D adapter->xnm;
>  	xn_params->ctlq =3D xn_params->ctlq ? xn_params->ctlq : adapter->asq;
>  	xn_params->rel_tx_buf =3D kfree;
> +	xn_params->timeout_ms =3D min_t(u64, xn_params->timeout_ms, timeout_ms);
> =20
>  	idpf_mb_clean(xn_params->ctlq, false);
> =20
> -	return libie_ctlq_xn_send(xn_params);
> +	err =3D libie_ctlq_xn_send(xn_params);
> +	if (err =3D=3D -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MS=
EC)
> +		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
> +
> +	return err;
>  }

[Severity: High]
If a teardown transaction times out on a slow control plane,
adapter->vc_xn_timeout_ms is set to 0.

This causes subsequent teardown messages (like VIRTCHNL2_OP_DEL_QUEUES) to
fail immediately without being sent.

However, idpf_vport_stop() ignores these failures and unconditionally
frees the descriptor rings' DMA memory via idpf_vport_queues_rel():

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_stop() {
    if (test_and_clear_bit(IDPF_VPORT_DEL_QUEUES, vport->flags))
        idpf_send_delete_queues_msg(adapter, chunks, vport_id);
    ...
    idpf_vport_queues_rel(vport, rsrc);
}

If the hardware is still active and eventually processes the delayed
disable queues command, it could write SW_MARKER to the unmapped DMA memory.

Could this lead to DMA memory corruption or an IOMMU fault during shutdown?

[ ... ]

> @@ -380,7 +402,8 @@ static int idpf_wait_for_marker_event_set(const struc=
t idpf_queue_set *qs)
>  			netdev =3D txq->netdev;
> =20
>  			idpf_queue_set(SW_MARKER, txq);
> -			idpf_wait_for_sw_marker_completion(txq);
> +			if (markers_rcvd || wait_all)
> +				idpf_wait_for_sw_marker_completion(txq);
>  			markers_rcvd &=3D !idpf_queue_has(SW_MARKER, txq);
>  			break;

[Severity: High]
When multiple Tx queues share a completion queue,
idpf_wait_for_sw_marker_completion() polls the ring and consumes any
SW markers it encounters, clearing their SW_MARKER flags:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:idpf_wait_for_sw_marker_complet=
ion() {
    ...
    target =3D complq->txq_grp->txqs[id];
    idpf_queue_clear(SW_MARKER, target);
    ...
}

Because idpf_queue_set(SW_MARKER, txq) is set sequentially for each queue
right before waiting, won't the polling loop for an earlier queue consume
the markers for subsequent queues?

Since the subsequent queues haven't had their SW_MARKER flag set yet by
the outer loop, clearing them is a no-op, and their markers are permanently
lost.

Could this amplify a single delayed or out-of-order marker into a massive
timeout cascade for the remaining queues? Would hoisting the
idpf_queue_set(SW_MARKER, ...) calls to a separate loop before the wait
loop prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013121224.8448=
2-1-luckilystar08@gmail.com?part=3D3
