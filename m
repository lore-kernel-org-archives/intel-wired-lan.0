Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D858CC6B1D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 01:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93F4A406F5;
	Wed, 14 Oct 2026 01:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DJpf_ZUUI9O; Wed, 14 Oct 2026 01:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50E96406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791942938;
	b=PbqSePFAdW4McZSdKIPRjEhan41FeQo/0d193IzjWO2iu2BMNBb+fo3ZCIfwhXGhNl/r
	 d4WXcdgP9x57dtvny4GSBMyXj62aXnbUcDkZQLWdonD+93kXuyCn6fHVczdhqn2NNyI9d
	 k4y4t0mC2sy5OY62q9H/ZvKGAvW/h6ZpOLziO43KMl56l+DoYnDBGVdR7cVAP8jEE20Fn
	 ycmSa7uxdB3ufStfvuIc4eNgFmP2sbOkujC2BbU5dlP3QYiyv8oCkaP1OlxU7i/ysMYKe
	 ozcp/js/5HiACgwJ/1Gv68BARXg+Jdrc8Fr52sArNEktfU2P5NlY44c517fnrRGm5JQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791942938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=01YwOi2/uAS3It/Bh1ofAJQhIgThbCg9B7XKECik9p4=;
	b=GYr6PgQC346h573GB81TJ4Oysldh0rRbYWs8gxX4WBc8KD0EjeMMQAuOPlBJmsM90YDB
	 g2oZlGIyCpQUjH2FCCQIBZniTG6bpd6bqMZExUsRbM1oyFc0TvlBXtbApJxPMA9kldiuQ
	 mR9VW7PJ/W4aP3i4aLmcN9AFw2mLdykSVehmKz8GVtTPJW/nWqAVJWi+4WvztrHpjJ0bD
	 xKUXUbqmk0FMCUYtlP/epnaiIvX/eCNdAitHxWIjZ65vBnqR5M0OS2ZPUpXugRWqFxS1W
	 ZqABBK/OcltEqjvHWHp0MsJnX04wEwQcidld+eIETEtqkiCB9VjEa6nrXzdKmwL5CjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791942938;
	bh=01YwOi2/uAS3It/Bh1ofAJQhIgThbCg9B7XKECik9p4=;
	h=Date:To:From:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ltOAXZODq5LO+waIDkD5voX1PfS4ov6Rb6HtrA40dR3oYfcaJ1YFN5jmdPu+l2A9l
	 69qUoU17oABY5hosOSKfN4EmOQ60f2ZRc4p5tiWkpo7YMF0dLjRdkSDzQ9WpALCicP
	 npDj2G4T1cjIGEl3Dm3mo+BGf0YqBgfjTkdZpAODSgVQDD8+XyddSvJBQg+Co3r1E1
	 W4hBOsnv50OYiUlwBIVneIWZ6zcGRwluWwiiQL+/QeF+wzE5ruYP33DyJBbpvJSnHQ
	 owYc3Q3+ip7BH51ugu5N81jy0SriDQZVjMJ3J5Q/vfoqLvaob8ZdElw/oQtfuGVZhR
	 wCi2LnQpNVbSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50E96406CF;
	Wed, 14 Oct 2026 01:55:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B4992AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48F0260881
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZfyW_z39iWS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 01:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AB8D60857
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.99
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791942933;
 b=E4fVJpyE72E/tyaE/Y5JTnYiKv8asIqdRXDdttyLLKIr2CJleUG2Px89BaLLWupNp15T
 iakzaQwi4Rjf+Z5nNw5wurBQwcGQPKv3O9NrlYFVKgPREI4heO9teqPDVysktmS+eEQa1
 GXkEyP4TvydX2UgfH33wUrHeQm9Db+wDICSD1twwVR6sXIHttsSi2FND6ICAVwCg5Plkj
 oFrkUQIAgQxHPtSWiBjRIsqBl6DNeW56Ncw5GDwGUtSwPI1A0ANGNBRt4GRM6uVYSfIGQ
 WGEEUF69wfr3gdPe1H7A4QxjIDzr/qVDAD2KMg9Es7SDdtxu5a12foDUNEza+5U2fdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791942933;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=01YwOi2/uAS3It/Bh1ofAJQhIgThbCg9B7XKECik9p4=;
 b=ZcTwUMyWrDWkuIzNzfa/MsAe6qK1Lbc6WnaiJreObJpsWexkjE/RwtMJYqcVQQ2Yuo5g
 rhN/eaE2Mc6eReg9TCU7sEe0nKr7xCZCeAFleiZwsxW11naDbcOswdsSLo/MAko5l2iFr
 3Vlo2UJcB7vyV2WZ8dFdMNVjBNQ5xNRt/cFlz7RVPTJ8TkNgJGWjBxut+ha1LlVhEe+p/
 71yFvAYs6uMtg77dXg5qcRTIO4ldoXGhBCrrS9TckY0RIBdVWzyk+sN5/GuX71HKnXSj5
 hPS5zjgfGVY6aK36Loc5b5uu1tBJBrCY4oVhU7E0UBjVRSsC7ROxv9Q6/UlmIr+g+6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=I5QfiKSx; 
 arc=none smtp.remote-ip=185.70.43.99
X-Greylist: delayed 89141 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 14 Oct 2026 01:55:32 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=I5QfiKSx
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.99;
 helo=mail-4399.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AB8D60857
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1791942929; x=1792202129;
 bh=01YwOi2/uAS3It/Bh1ofAJQhIgThbCg9B7XKECik9p4=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=I5QfiKSxCtG1YDYbyN9wjtdSVMr0rsUrpflqd1RDgskhIJN0UWhf+mMw4f0egrpUu
 IzDvXALeP3xRabzACeMQW7Y9RkuXDFey/d1HD8j3yh3X3ugIwR2GQvQJHa7mINZo8B
 QiK2ObD4LgNUlWoCDWAsx5ytxiKHzYgbnoCYK4nAPM5XEsUm3DfBxTMP0VEe9zY5Tl
 pPPasTrD8+95NNHu8hpp1+ZGJoQiEEuZoW6jWlePryindzrGxAzZvvW43vzV9y3m7j
 LFjQX/asDa/Za5uDHzEssl8yh45+0F2pobG/aHrcb9A0iFCS9CyPAs1FDJCO9arqNO
 wIXv9YoxHUG9A==
Date: Wed, 14 Oct 2026 01:55:27 +0000
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
From: Paul Moses <p@1g4.org>
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
Message-ID: <3ENFP7uTslkckm5F-vJGiT-bUKoxM7UZkqUy6vRJmxG3SFZV1ty2SVd-mbpUFR2GbkrVEo-crpxeh-Y97avpH07Io2vRjXzYvm-IQvY-lPI=@1g4.org>
In-Reply-To: <XZJHApdBRAdKWBcW4_dF6GzwUtdFV3-oYE9H5H1xSptrfzKOyXye7vRpqF6pmFsa3naLORrFmJtH_GFwAdKM-XaQlYWJfbFIMqzepUHSN1E=@1g4.org>
References: <20261013010854.4068874-1-p@1g4.org>
 <sashiko-outbox-170659@kernel.org>
 <XZJHApdBRAdKWBcW4_dF6GzwUtdFV3-oYE9H5H1xSptrfzKOyXye7vRpqF6pmFsa3naLORrFmJtH_GFwAdKM-XaQlYWJfbFIMqzepUHSN1E=@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: a36d59d3625cb498dcf7abb16ed1a608d98cf7fb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: intel-wired-lan-bounces@osuosl.org





On Tuesday, October 13th, 2026 at 8:40 PM, Paul Moses <p@1g4.org> wrote:

>=20
>=20
>=20
>=20
> On Tuesday, October 13th, 2026 at 8:10 PM, sashiko-bot@kernel.org <sashik=
o-bot@kernel.org> wrote:
>=20
> > Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
> > - [High] igc: Frame Preemption express packets (mPackets) lose TSIP str=
ipping when interleaved
> > - [High] igc: incomplete TSIP underflow fix due to XDP fragment drop
> > --
> >
> > commit 61d038c91b93b927335a69df60dbf6cc817c79e2
> > Author: Paul Moses <p@1g4.org>
> > igc: only strip RX timestamp header from first buffer
> >
> > This patch modifies the RX path to only subtract the 16-byte TSIP inlin=
e
> > timestamp from the first buffer of an skb-assembled packet. This is int=
ended
> > to prevent an unsigned length underflow on continuation buffers shorter=
 than
> > 16 bytes.
> >
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/=
ethernet/intel/igc/igc_main.c
> > > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector=
 *q_vector, const int budget)
> > >
> > >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_off=
set;
> > >
> > > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > +=09=09if (!skb &&
> > > +=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > >  =09=09=09ctx.rx_ts =3D pktbuf;
> > >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> > >  =09=09=09size -=3D IGC_TS_HDR_LEN;
> > >  =09=09}
> >
> > [Severity: High]
> > Does this condition corrupt interleaved express packets?
> >
> > Frame Preemption allows express packets (mPackets) to be interleaved in=
 the
> > RX ring while a preemptable packet is being assembled. When an mPacket
> > arrives during this assembly, skb will be non-NULL.
> >
> > Because of the new !skb check, the mPacket's TSIP header won't be strip=
ped,
> > leaving pkt_offset at 0 and size unmodified.
> >
> > Shortly after this check in igc_clean_rx_irq(), the mPacket is handled:
> >
> >     if (igc_fpe_is_pmac_enabled(adapter) &&
> >         igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_off=
set)) {
> >             /* Advance the ring next-to-clean */
> >             igc_is_non_eop(rx_ring, rx_desc);
> >             ...
> >
> > Will this pass the unadjusted size and unstripped TSIP header (pktbuf +=
 0)
> > into igc_fpe_handle_mpacket(), treating the 16-byte hardware timestamp =
as
> > packet payload?
>=20
> It'll drop, not do that, but I'll fix in this series.
>=20
>=20
> >
> > [Severity: High]
> > Does this fix fully prevent the continuation fragment underflow?
> >
> > The patch attempts to fix a queue stall caused by an integer underflow =
on
> > continuation fragments, but relies on skb being non-NULL to detect them=
.
> >
> > If XDP is enabled and the administrator has enabled the rx-all feature
> > (disabling MTU enforcement), an oversized packet can be split across mu=
ltiple
> > descriptors. If the XDP program drops the first descriptor (e.g., retur=
ning
> > XDP_DROP), skb remains NULL.
> >
> > When the loop hits igc_is_non_eop() and continues to the next descripto=
r,
> > skb will still be NULL. If that continuation fragment is shorter than
> > 16 bytes and has the TSIP status bit set, won't this check evaluate to =
true
> > and cause size to underflow exactly as it did before the patch?
> >
>=20
> No, xdp was still no bueno, but I've had some breakthroughs already today=
 and
> this is all mostly finished, I'll submit v3 series shortly.
>=20
> Thanks,
> Paul
>=20
>=20

Is this list private? Can I openly discuss remaining security matters?
