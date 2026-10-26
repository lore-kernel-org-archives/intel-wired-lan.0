Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FF606A31B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mNCzfP0u;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=dYr19qWL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6F2580D73;
	Mon, 26 Oct 2026 07:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2Ia4jqHZXHg; Mon, 26 Oct 2026 07:54:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8871480C97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793001242;
	b=OSbAc5+9AvdP3t0AHvRolYXQzdx1Symr1W3J5bbFuEsA2YEPAq4V2TlXjwUl6gYzPPGw
	 sewYF+5OLth4Efnt+eaGYKiPpEyq7or83RJXveaWubYm36dZk/Q7xVMao2+nNMQ4VwPv9
	 ErTU8g72QbvaMyG9ytbqAU16y+k1HYJGrxdBhpLGBaGwA/mjbxENWXtN1HXZ9tTU6r/Vr
	 VVWtKSS67v0nQDlr4+8Pw5lsfZV4QQZGxHnyvMe/trLUA5F55GVID+nPIuTOAKvid8cTE
	 3mZOCaJNqRuEKdeGail5ZxLtZ04lWNs+57WunX6ItKazRif5EWe7WkdyMayrWCPyJCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793001242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l0YvXY1ZXOO/2zz78iKHOZrlkKi+Hmc7P2K347btTPE=;
	b=pH7zMBU8rQZCzwXv2r2VXkfOoZ87pezSJ8dl/DcLI5PX4J84ZijV496HusIQkMbZyCuC
	 VwCi4OvizTf0HReZWB2OhE98pTw6rCeiHvBAkJiC72bxb9PyNrtdJmH4ryaRNmjP4HiXi
	 ajbc38MoNIomFrGKNZudP7cB1zVxOvNMCrMwLCl9VZrTcl8moGeRmERRs47zuKpbhCRYV
	 Gu9F9mYxmH+AZlsy9t2vbr4XKynV5WAgMeOvunUdsczaqA9ewH7H1krkFYGSbL8g+jqsq
	 JBlnBE2r7QNYuIFgsyN2bOwL6tP0SW/c+eDl4Xd7hJ4a/jPw816DpWPy+AkYemRW0Pg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793001242;
	bh=l0YvXY1ZXOO/2zz78iKHOZrlkKi+Hmc7P2K347btTPE=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mNCzfP0uq2b9S63iceJS7DDf0y0nXbFzH8tPAuqwyZD7MNTAt/KIKXIdx1bWjTwqk
	 UARqRSts9SKXzpo4YUXgAaAy8FS2SkoGYJyq1a9biYot/TXFWxJ+fDAH+8R1jigwd2
	 8AP1w0U+OiYlham1wcUM0FTnq7zaFL8VQPlS9Y64+U+ZLL/MGojfBKXke1f4vfG7Vg
	 UQ+rWXyEQNuTN4lZMn5WfSvgS/c/AyCjD/nK2qfqn53e8y8FzqTLFMge4dbnf+iiMv
	 OPWST+pxMe4lbxNW8qQLTghekAM41OrqYstvY10clTgFwK6xoCnmJKWpvlZPIlSKEr
	 vIu56LH63j5kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8871480C97;
	Mon, 26 Oct 2026 07:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4908334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 07:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A627E405D7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 07:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGGJsxHbkNTm for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 07:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A974D405B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793001238;
 b=llVPoxlfvkA6F/YGQBulxK9GKywO20akra4CiXOyBm0XLKm146aYtOXzRov+ENPxByzZ
 Fk0V7frXp3hw1W0QKpa/ryX+IR5V1hWk22smDM8A/pQdZ1TLYVA/f8gQmpZ1/cnoXmxNm
 h/ijOwYI6wLXLczj7NWTiOT5rJtXzmlDNiN1QctsvrDV/mJzeWeHzdG+Rahbzv6tNG15o
 moJ6rJejW4a8e25BLnMwFHM0gyW5osoPsl/bMwwAw0nh2oL5rEvmDwmkz7fHFdrQKa7t0
 z36ejPV2XRB47KUNhchK4bhnfbZbCkHZ9ojnitxEkUaEwoiP/9Ftn371zmmiIYFBJhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793001238;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=l0YvXY1ZXOO/2zz78iKHOZrlkKi+Hmc7P2K347btTPE=;
 b=JINmvMxPhCff0TSbkkR0I0BKJ6QItJYfl/k3Gbe61LOBDYe3O2GS79+Lmhi8HCgatZq/
 BGJBTHIjfZAlfXQMu+X7AydipEF4e1eKzfq7KAzz1/uia7V+86hku98nSUoiBYFzqnwe/
 IeEgQFkhbig2TXKxJQCB0l/OQ0x7/Z+6QDR3Q+dBTRwlZPqTgUhg9OENoZrKCn7yLOfBa
 rHgEYSzCiFSqBY6KLIgjVwp90ORrcDf0vPnc2MNXx57BzMZeotz4MzfyS9n2/hJGpI8L0
 0F5Zb7T3EkA4eCzB0qlN74UmRN7ELBrmCoxsGe4MO7oZ2g+PQdaPf6soXmDW7FgY7Tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=dYr19qWL; 
 arc=none smtp.remote-ip=109.224.244.119
X-Greylist: delayed 90100 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 26 Oct 2026 07:53:57 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=dYr19qWL
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.119;
 helo=mail-244119.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A974D405B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793001233; x=1793260433;
 bh=l0YvXY1ZXOO/2zz78iKHOZrlkKi+Hmc7P2K347btTPE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dYr19qWLgNxaI6kjQtsrquIulqivtOAvVzDWRfdROAIHuStkIGvXwAXqZIW50JF5x
 OQclzbLDmLn1a8IaUyIFAfnHNzbvh8YjBM7a5PG63sLjVrdhKVSQEfPzYyx9Is3VES
 AJ6KWcjVyLqPyikmNd3dLYdNldP5DbGMcmQDrsJXYLmWokCtkC9qNU6vfEjLvmy9pH
 8xCD0ZPAYqm7bSRoSd6pw8IW/ywlIufTr/glWjFwHrWXs6tDzE6GdhgI+nd/2AEcW3
 CKLw5VW/u6MKimAIp+GCt+LXfXGDocjpigmzsDSusw3gGZSfzTN2+baO+Z3qlv7dGO
 +CbU4XHcT2t0A==
Date: Mon, 26 Oct 2026 07:53:49 +0000
To: sashiko-reviews@lists.linux.dev
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <RWzBrfsuLy54ULo85bs7EUhLPBOhR88jVUxVW1TsP7bhhEDQM2T-b9R6X3F9D62O3nN9GVNqK2S9NQG-sqqOIba8bP0oHv0rOUJdn_p1QUo=@1g4.org>
In-Reply-To: <sashiko-outbox-184616@kernel.org>
References: <20261025065154.2037149-1-p@1g4.org>
 <sashiko-outbox-184616@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 88968fa72f3d1b8507b05439ff909c5cb132e4e1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1





On Monday, October 26th, 2026 at 1:52 AM, sashiko-bot@kernel.org <sashiko-b=
ot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] igc: off-by-one in TSIP length check in igc_clean_rx_irq() and z=
c variant
> --
>=20
> commit 7b71c87cde8117fd4a451a2a079f34aaf64bd069
> Author: Paul Moses <p@1g4.org>
>=20
> igc: track rx frame boundaries independent of skbs
>=20
> This commit tracks RX frame boundaries per ring via rx_in_frame so that
> inline RX timestamps are stripped only from the first descriptor buffer.
> It also rejects unsupported split frames before XDP, drains continuation
> descriptors, and updates NAPI budget accounting in both standard and
> AF_XDP zero-copy RX paths.
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..9ca5558c762c9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>=20
> [ ... ]
>=20
> > @@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector=
 *q_vector, const int budget)
> >  =09=09dma_rmb();
> >
> >  =09=09rx_buffer =3D igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt)=
;
> > +=09=09tsip =3D first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP=
);
> > +
> > +=09=09if ((!first && !skb) ||
> > +=09=09    (first && igc_xdp_is_enabled(adapter) &&
> > +=09=09     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
> > +=09=09    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> > +=09=09=09if (first)
> > +=09=09=09=09dev_core_stats_rx_dropped_inc(rx_ring->netdev);
> > +=09=09=09xdp_res =3D IGC_XDP_CONSUMED;
> > +=09=09=09goto xdp_done;
> > +=09=09}
> > +
> >  =09=09truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> >
> >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offse=
t;
> >
> > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (tsip) {
> >  =09=09=09ctx.rx_ts =3D pktbuf;
> >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> >  =09=09=09size -=3D IGC_TS_HDR_LEN;
> >  =09=09}
>=20
> [Severity: High]
> Should the length check in igc_clean_rx_irq() be size <=3D IGC_TS_HDR_LEN
> instead of size < IGC_TS_HDR_LEN?
>=20
> When a first descriptor has IGC_RXDADV_STAT_TSIP set and size =3D=3D
> IGC_TS_HDR_LEN, the buffer contains only the 16-byte inline timestamp
> header and no packet payload. With size < IGC_TS_HDR_LEN, the check passe=
s
> and size -=3D IGC_TS_HDR_LEN leaves size as 0.
>=20
> If XDP is disabled and this is a non-EOP descriptor followed by a
> continuation descriptor of at least 60 bytes (ETH_ZLEN),
> igc_construct_skb() or igc_build_skb() creates an skb with zero linear
> headlen, and igc_add_rx_frag() attaches the continuation buffer as a page=
d
> fragment where skb->len =3D=3D skb->data_len >=3D 60. Because skb->len >=
=3D
> ETH_ZLEN, igc_cleanup_headers() -> eth_skb_pad() does nothing, and
> igc_process_skb_fields() -> eth_type_trans() -> __skb_pull(skb, ETH_HLEN)
> then triggers BUG() because skb->len drops below skb->data_len.
>=20
> If EOP is set on the 16-byte descriptor, size =3D=3D 0 runs XDP on an emp=
ty
> buffer where XDP_TX calls igc_xdp_xmit_back() ->
> igc_xdp_init_tx_descriptor() with a 0-byte length, and normal RX or
> XDP_PASS allocates a 0-byte skb that eth_skb_pad() zero-pads to 60 bytes
> and hands to napi_gro_receive().
>=20
> [ ... ]
>=20
> > @@ -2829,11 +2855,20 @@ static int igc_clean_rx_irq_zc(struct igc_q_vec=
tor *q_vector, const int budget)
> >  =09=09dma_rmb();
> >
> >  =09=09bi =3D &ring->rx_buffer_info[ntc];
> > +=09=09tsip =3D first && igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP);
> > +=09=09eop =3D igc_test_staterr(desc, IGC_RXD_STAT_EOP);
> > +
> > +=09=09if (!first || !eop || unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> > +=09=09=09if (first)
> > +=09=09=09=09dev_core_stats_rx_dropped_inc(ring->netdev);
> > +=09=09=09res =3D IGC_XDP_CONSUMED;
> > +=09=09=09goto xdp_done;
> > +=09=09}
> >
> >  =09=09ctx =3D xsk_buff_to_igc_ctx(bi->xdp);
> >  =09=09ctx->rx_desc =3D desc;
> >
> > -=09=09if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (tsip) {
> >  =09=09=09ctx->rx_ts =3D bi->xdp->data;
> >
> >  =09=09=09bi->xdp->data +=3D IGC_TS_HDR_LEN;
>=20
> [Severity: High]
> Similarly, in igc_clean_rx_irq_zc(), should the check be size <=3D
> IGC_TS_HDR_LEN so a 16-byte TSIP descriptor does not result in size =3D=
=3D 0
> after subtracting IGC_TS_HDR_LEN, which would pass a 0-byte xdp_buff to
> __igc_xdp_run_prog() and igc_dispatch_skb_zc()?
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025065154.20=
37149-1-p@1g4.org?part=3D1
>=20

I'm assuming the hardware works as documented, if someone wants
to followup on hypothetical defensive scenarios, go for it.

Even if I did change these, where does it end? 
