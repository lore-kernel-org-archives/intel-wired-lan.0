Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1E606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HjpCszc+;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=Khusp+FG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEFD6605EC;
	Mon, 26 Oct 2026 22:18:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3xlbqG9kbQz; Mon, 26 Oct 2026 22:18:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8455A606F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793053092;
	b=QMZD4xY8EtnpD8QeSvOKMMEf7vX+8MNLm9e1MsXpCFUQ0zSPpm1/Ohx755RpC82f8dfH
	 aKWj1sNbHMUFSgl8D8AyRIMRNbxHwCJ4AROO8bm8U+n8ZaTeiUzMEwANGdaM5fe0p1LZ+
	 8QZ8Q/OqS+qAn1M+UpIH+iFMSxQeCk0h1yRXqzApNhWFqapkKxaMkK/0MEQZI7vvblTVk
	 MDtIqO4BhT0Qeh7smGHcx8iHkIfCpRaG23rp++N0YW1nf8R8hUFLCEYZavdlqWnp4o7XZ
	 KkTGNL9ow0GJCH7lrXLEWAsSScAWUQCTMKUoJex1c2aka5wZmcZbXE2puoq6evxC1sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793053092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j7+Wt+6fz4ZskekKzx7aEXbq6GLlj+ejwaiGk0UsRoA=;
	b=E0FamfsHQlH7UcgJwyI/+JWEXkgWvj2MH3TzlX4Q1FrOsHIlc+QoWTxsY1rU2rDssiTX
	 YHsvCdR4kJK3t99aD+OMKStoO6TR578mfFlOHOGZGwHWZ931ZGwvcSwRdnauhddMwKb/X
	 yEjiHUalUMM9qbE0VIyLpxEUyH9jI2Vlmt8iVK0xyOfPY2vzO8hHBKVwBzCIV0xVjR5BI
	 M8dqAMBiHjfVOi4GOk+BhZAYAZywlTr7ohJaSQFo29Dziqn4/JvSLedIacsDWI3TGBmdR
	 61715Xs10y0rERZppE11OhTTIRh86vyhutCOlDDtvxM1ROJN6h6TIoAMlMhKSeWCeUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793053092;
	bh=j7+Wt+6fz4ZskekKzx7aEXbq6GLlj+ejwaiGk0UsRoA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HjpCszc+LJmN5k4qJrdp+HVetVWkEcCc5UaGL4X6CPLmLFkwCOCZkBXyIsGcrhYXY
	 gMBApoJhMQaiuG2+vQlesZGt5y9LF6Ix58+d9lD0F2Lumn2dcDxu8dLh+6lpRe2BOl
	 5CGnIQ3ZybUbCg/1HrBMwnvxkyaL8FC7Nf31/BqJK05gWYy3HFl0/yVMxZyvVf9EIv
	 Zca8/Pi8IuQagmt+NL6dsfhC/YRY4J/+mbhEES70jdrmd4/OCq85XaqfP2Vuvma+iF
	 l01wcb8VjhKYZdL8JfWLTRt2PRCVyLmaSPpN7+3WylkrPpPJzuqwid+OFKAgX8xkM1
	 g4QFzXDrGAbNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8455A606F3;
	Mon, 26 Oct 2026 22:18:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB445120
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B140D80CCC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZXb4FFuLTJO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E19C580C9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793053091;
 b=GMkWvsCh0HuAeT79PBLQKbDzVw8TC3qF9sIXQ9sg2BhOSaedfoZHhkohhipoe7/9014D
 QeD4X64XOGds2SbY9uqTkaNNNCNifNZln/QHaqaGVKX4ZQqC1qhmtV8yzeWUyeNOxx9Mm
 FrBio8o9yXTMMlyoT6XzT7shnVvi2eH5TlOrtjipwPlmgzsFfk0B39AYRRgv37o/MkgH9
 /b0KmT4/iTJr+/f7N7jtjT05UN6ZYzq/xKAPSnJOIzYLZG7iSaDCGn0cHR3SDyWiulUOf
 5LSQRh+/5RPyU6d0kKq+jS731zVqdS4p3DvqJzWISXaUWeOlQvpZDIfIZFL1Y6izyyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793053091;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=j7+Wt+6fz4ZskekKzx7aEXbq6GLlj+ejwaiGk0UsRoA=;
 b=CiQipastkSva9fNyJmR0Bo2OJChOv6DFr96i9YucV7FyzkC1O7hlSgk7rKNVHaOKKKi1
 SYXQDwjSTzcZ2y5t7/UUcSjcunypFQFagqNqBimc2buJecu8AY9EGmSVWiAQYN9VRTrpA
 Bmyn/tUuCrqQMZlMuvXWE8aUrq74VTe4chCm+H4paOhqiIcBsFif1o5Swg306T6UpiYBf
 r0qcqFHbt0of6wUvWb2j1BH6aBvfLBQyjZmu796D/9IIi9xcWm9pTWzoI4qsyIIiwBz2g
 iv3Ibmug4Zp6qd9RkruZZAcirJFuFeXJty4Vna2nPs15LgnhR9GsSEOpRTehcKMd5Jw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=Khusp+FG; 
 arc=none smtp.remote-ip=109.224.244.119
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.119;
 helo=mail-244119.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=Khusp+FG
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E19C580C9C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793053086; x=1793312286;
 bh=j7+Wt+6fz4ZskekKzx7aEXbq6GLlj+ejwaiGk0UsRoA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Khusp+FGEK0eE82NLaoHg57wLMIgQor91mCHO5TVPujRbYqnyRGmBhwAsaRVbSx2e
 Mj3Jf7ZLpCv+2R9lnPG71OgDtmOp+5OQ5oErxk2gLsLKVIKX0XHuE2Hp4v/wMSHXQZ
 wkX3ZVl7Lsm6OY80JBy4r4M4gLtveY4YJA/Pp1tLPesjkGXSDKUlAmj7Brnq7qjOq8
 9AVSGq5vmvzuV3n8H0ga7wgNQdXTAwntFD0Z1qmeJNZUmsE3m02B+GqzYvYAGxc1TP
 932kUEEsXrHliKCRg1tcJvWLBwe1lTWhZcVzxHNH50C9X4/AAHz+ga9avpzx1l5dqm
 /Qm7M6DJQOh0w==
Date: Mon, 26 Oct 2026 22:18:03 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
In-Reply-To: <at+yluh1NVm78gn6@boxer>
References: <20261023141317.3904442-1-p@1g4.org> <at+yluh1NVm78gn6@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e0cc8acc5183641e5ff64bc4b80c7d5a4a7e0b5a
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fijalk=
owski@intel.com> wrote:

> On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > Converting an XSK buffer to an XDP frame allocates a page and returns
> > the original buffer to its pool. If the TX ring is full or DMA mapping
> > fails, igc_xdp_xmit_back() returns an error without freeing the copy.
> > The RX cleaner cannot release it, so the page leaks.
> >
> > Return the copied frame on TX failure. Save the RX memory type before
> > conversion so native frames remain RX-owned on failure.
> >
> > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> > ---
> > Tested on Intel I225-V with baseline and patched kernels. Physical
> > pause-frame backpressure caused 46 leaked copies on the baseline.
> > With the fix, all 72 rejected copies were returned once and freed,
> > and all 192 copies were accounted for.
> >
> >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c..39263fd04aa9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapt=
er *adapter, int cpu)
> >
> >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_b=
uff *xdp)
> >  {
> > +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
>=20
> small nit is we require a concept called RCT (reverse christmas tree)
> which makes you to order variable declarations from longest line to
> shortest.
>=20
> >  =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> >  =09int cpu =3D smp_processor_id();
> >  =09struct netdev_queue *nq;
> > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter =
*adapter, struct xdp_buff *xdp)
> >  =09txq_trans_cond_update(nq);
> >  =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
> >  =09__netif_tx_unlock(nq);
> > +
> > +=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
> > +=09=09xdp_return_frame(xdpf);
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>=20
> > +
> >  =09return res;
> >  }
> >
> > --
> > 2.56.GIT
> >
> >
> >
>=20

Never know what to do in these cases, order matters here, so
do I touch more lines to move the assignment down below?
