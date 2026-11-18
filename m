Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4C606A339
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2WXHs/Dk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zg3v0b7W
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 959F340A28;
	Wed, 18 Nov 2026 14:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xzXjl2jX9tH5; Wed, 18 Nov 2026 14:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94DCD40A33
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795012526;
	b=PgXCcpK0iOcFGcx/LLSGj1MQOp75EV8wQMJhrQdi1OJopFJnSpglDJL9DX928xxzHep9
	 57hutwVie5JuvDDUuv72yADX0awF5HHJPbnGWjWCU/qRlOniVbEh4dSehxmGKk/+WuY8x
	 jBxtYLeH1rG4Wtj7IkhbnJOCoc9rv6W742Q3qBp4vpwGzwD1tjqSEMeiEuEjXytglEFp9
	 36IWVol33wawhmboCP5/PGXWpBZhPVveO+SJEasCdzvhEmTHl0KtnoPqJ7uIH4ljoL53B
	 B6KXHvTES+34YXl3oPi5xHmKJF6JPUBbwQoWarDJbz9OdTJ/5P/YNniGvf9Mre7tASw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795012526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=I14X62NAtlu/hRxG86G+Hf/PgAdLJItadNL5fCZVifM=;
	b=Z2YzZbYxgsN+IV96CxbvkCk0rXOn5DegqWaG/ey6EWy4g5I5w8pLqEVMFCfc/M1gIFx4
	 Ekrv/8juYcxEqbxHPxCr7Nzzb3zuaUxfVJkCeV6Bkaq7Dn2iPCm4smMNvlJ4JoBtmmf3l
	 7thzGCW7+DAcQFZ7EPaaIAbJBTGgmHUICgXmU7POV8ScgvmiH1ahiXKdoPY/46+V4T08U
	 Fod3rbsNXC759imuRKxRE53ceA79YjyvkW5RyikrhLRjv/WQcGyDJ9WHq3dllmDW2CEs/
	 0C2kIo/TL1pN8/hjWo7AeXazOSUt3mGMFZc3/P2oHecjZaOfeXgZ8fmwmCyT8BLNpBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zg3v0b7W;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795012526;
	bh=I14X62NAtlu/hRxG86G+Hf/PgAdLJItadNL5fCZVifM=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=2WXHs/DkMC9MznEcma0poEKgGK6QD0XVncD/naQHGZth0kfWBx18IS5+BAawVrECN
	 19a5Nq0gz2npkPICKviXdV+In/oMSRmH8DqYMddm2FBZr846SUVedrTeO8KqAtn/2w
	 Kk13vMCZGWfRva2+UHON1GdBXt71Est8VGn/5dPuiHON6lCBgktn9f56uJ2deylJj1
	 S4u7CLOa4vUUJGRJal9LeVGwwwAJCvIFKtj8d3+fOcMXJogCrub4DmuwMsxvYQL05M
	 HyrgtvzdaLSJdLJBntyvCgpaRJOL7/cjcpjLm1lFR4iHF6lUVe6pTxjj5BhfYOJKJq
	 jCo3yQuEq9Mgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94DCD40A33;
	Wed, 18 Nov 2026 14:35:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 11CA89F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0413D40A1E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMi9u-kV7OfQ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D53CC40A17
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zg3v0b7W
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D53CC40A17
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:35:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 920136225D;
 Wed, 18 Nov 2026 14:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D26D1F000C4;
 Wed, 18 Nov 2026 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795012521;
 bh=I14X62NAtlu/hRxG86G+Hf/PgAdLJItadNL5fCZVifM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Zg3v0b7WgI0fZDVtty3+e6FtDFo34U6xjdNcVHWDekFDehNAbSvFBgCMqXpAQtdp4
 PvnDBTlICdjwaUewxfmet/lKEkJScsBp8FJ6XQeKzD7mQGnnEB1Ojx6LgCEGBEiJpP
 DpS5qgChq4fySs6hJAQ9WnzDvA1Vufq0XdU/xjmA/FJ46fhf204dQoIz8MWItfPgLp
 iS1x/Qud6v+KZE8ZN18ZghrEqbOfe29HRUqmXEeuc7Pvu7WJR9MdGH17g9LHssgCA6
 +Vf+4gi+DMcXW5h1C8ur6JASYLoThaVE+/lQ2x59G0XIqvvWAzp1Llx0IzWqb5EYQ8
 ODKeEXPWJi5sA==
Message-ID: <sashiko-outbox-221222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] ice: use the queue pair's XDP ring in
 ice_qp_{dis, ena}()
To: "Magnus Karlsson" <magnus.karlsson@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261118135952.1063685-1-magnus.karlsson@intel.com>
References: <20261118135952.1063685-1-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:35:20 +0000
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
- [High] ice: XDP ring QINT_TQCTL interrupt mismatch in ice_qp_dis() and
  ice_qp_ena()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] ice: incorrect XDP queue indexing in
  ice_cfg_txq_interrupt() [1]
--

commit 16196a7c47f74a832fc91f862f75e019be2f6418
Author: Magnus Karlsson <magnus.karlsson@intel.com>

ice: use the queue pair's XDP ring in ice_qp_{dis, ena}()

This commit updates ice_qp_dis(), ice_qp_ena(), ice_qp_clean_rings(), and
ice_qp_reset_stats() to operate on vsi->rx_rings[q_idx]->xdp_ring instead
of vsi->xdp_rings[q_idx].

> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethe=
rnet/intel/ice/ice_base.c
> index 1667f686ff751..aa0ad313a97cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
[ ... ]
> @@ -1460,9 +1480,7 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	err =3D ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
>  	if (!fail)
>  		fail =3D err;
> -	if (vsi->xdp_rings) {
> -		struct ice_tx_ring *xdp_ring =3D vsi->xdp_rings[q_idx];
> -
> +	if (xdp_ring) {
>  		memset(&txq_meta, 0, sizeof(txq_meta));
>  		ice_fill_txq_meta(vsi, xdp_ring, &txq_meta);
>  		err =3D ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, xdp_ring,
> @@ -1497,9 +1515,11 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  		fail =3D err;
> =20
>  	if (ice_is_xdp_ena_vsi(vsi)) {
> -		struct ice_tx_ring *xdp_ring =3D vsi->xdp_rings[q_idx];
> +		DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
> +		struct ice_tx_ring *xdp_ring =3D ice_qp_xdp_ring(vsi, q_idx);
> =20
> -		err =3D ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
> +		qg_buf->num_txqs =3D 1;
> +		err =3D ice_vsi_cfg_txq(vsi, xdp_ring, qg_buf);
>  		if (!fail)
>  			fail =3D err;
>  		ice_set_ring_xdp(xdp_ring);

[Severity: High]
Does ice_qp_ena() leave QINT_TQCTL_CAUSE_ENA_M cleared on xdp_ring after
ice_qp_dis() stops it?

In ice_qp_dis(), ice_vsi_stop_tx_ring() clears QINT_TQCTL_CAUSE_ENA_M in
QINT_TQCTL(xdp_ring->reg_idx).  When ice_qp_ena() re-enables the queue
pair, it configures MSI-X via ice_qvec_cfg_msix() ->
ice_cfg_txq_interrupt(), which still writes to a different queue index:

drivers/net/ethernet/intel/ice/ice_base.c:ice_cfg_txq_interrupt() {
    ...
	wr32(hw, QINT_TQCTL(vsi->txq_map[txq]), val);
	if (ice_is_xdp_ena_vsi(vsi)) {
		u32 xdp_txq =3D txq + vsi->num_xdp_txq;

		wr32(hw, QINT_TQCTL(vsi->txq_map[xdp_txq]),
		     val);
	}
    ...
}

When there are fewer queue vectors than CPUs, vsi->txq_map[q_idx +
vsi->num_xdp_txq] is not xdp_ring->reg_idx.  As a result, xdp_ring's Tx
interrupt remains disabled (breaking AF_XDP zero-copy Tx completions), and
another ring's QINT_TQCTL is overwritten with this queue vector's MSI-X
index.

[Severity: Critical]
This problem wasn't introduced by this patch, but ice_cfg_txq_interrupt()
and ice_vsi_release_msix() also compute the XDP queue offset in
vsi->txq_map as txq + vsi->num_xdp_txq [1], whereas
ice_prepare_xdp_rings() places XDP rings in vsi->txq_map starting at
vsi->alloc_txq.

When the allocated LAN Tx queue count differs from vsi->num_xdp_txq (for
example, after changing the channel count with ethtool), indexing
vsi->txq_map[txq + vsi->num_xdp_txq] can access past the end of
vsi->txq_map or corrupt QINT_TQCTL for the wrong hardware queues.  In
addition, ice_vsi_release_msix() only iterates up to q_vector->num_ring_tx,
which leaves the remaining XDP rings' QINT_TQCTL interrupt mappings active
when there are fewer LAN Tx queues than XDP queues.

[1] https://sashiko.dev/#/bug/linux-0b308224-7107-4d23-9bbc-9ae5c80b362b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118135952.1063=
685-1-magnus.karlsson@intel.com?part=3D1
