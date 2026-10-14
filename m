Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20CACC6B1D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 01:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52D41809A4;
	Wed, 14 Oct 2026 01:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehJ7KUOEH_mM; Wed, 14 Oct 2026 01:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 819F180C17
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791942029;
	b=q2HKuaruWQIaoWEkiQcsRdoK717bhoPtNl6hnP9YU0y53HEpLUXi+y93WrHdlLqXCKKi
	 Eqf4Wy4P1gH3zsev+Fnqs0QklfIUvmf6GkZQSZ0ocUO7JFQiCdZJRHuJeTfybZcGfPNih
	 nYzdPUTxtcqx1eFtV2pc6V+PgA+MDxca0Ud/aR9WoO0WHhvUS3Bk2mVKCNAjTbG2J90j2
	 PS21STNOFWgJZWT3oXHoC6yPFAW+lWd2bwHtl1e8bx21RSqlJunKeAEwXJt4ChYVu8K+6
	 73re2rvHCpdnooWU1n9J1PmcMgq6ycmBEivuDVXnh8jwNgUwattcNDywwogUzVpmcQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791942029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5qXayZM9AmqtffRsvq7u0g+eKrTa1RlGSDoXxNdCu3M=;
	b=seS059GbWlzj1pb50Ibup+OhsvYn18dkVl2L+BxqOH7Ga8DeWH9y2qfhIq4Epc39eqnt
	 s1lBZ1l6oddCYCa99U3B/X2nEQKmHtNoyoQusVRaTVBNxV33vx3AtZJ/Mzi0K5OC9QN6s
	 5Sl8DmHydf8Zxkut2N3pMrmR6rgyS+aqA0QtNDR69T6ZSP2dqTq8o8iwnHMZX6hUKVxRh
	 yDvaWN+EAeNnK9aGd7wM05EzYc/sm2d3H4R6qCFNsGqo+AvWG15tZ2kiJYDo1V++cH7WY
	 hRrnhItqmWy7cD80bNKeEKzB6OtygKTxZ1Nmp8zMZ34w3bUUxMlcNjA/0yOJ9Mm9UQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=kLv22cs1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791942029;
	bh=5qXayZM9AmqtffRsvq7u0g+eKrTa1RlGSDoXxNdCu3M=;
	h=Date:To:From:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpHkJorhoIt3I/L4XV9nXPEbOeIIWzInNEaHK4Aq/jhgg+hqPe4lKsfcEZn4bxpL0
	 sJsposxP5f7JvnjvvIbaPnBp9lroyIwsYy6IC+oaiRvGY3HNGMiQ6ftABK2YaOETz9
	 qqvV/m2wEQbyjqiaSa1Hj0ap3VB5oWLKV/lpdpTxzInLitRjtC1gYPkXCC9HTMUrDT
	 CktmcmTDcBFE1ge1B7GywzEOpleiod6F/BKr5PvBWQYHLqHi3i1UXfPYIfRu1hrUrH
	 9DDKDPXabJPAgxcwEoAsUY3BeT+fYF+rXkvFglo8rVbi34oUdRF6m9cyTGkEnN0XrZ
	 L9IaWQsHkxrwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 819F180C17;
	Wed, 14 Oct 2026 01:40:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 978A62AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89571809A4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tytLuwNOcEGU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 01:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5ED6380C17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.9.206.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791942026;
 b=XzpvvRb4WvhnSUIfXt6sftVOtJDAKTSdu2QLdOO8C+kq3zqr7RuPV5E/fnojwncEfK8B
 fmYP9dGeVhNliNn/pBeGEX523ggdz3u23uMbn8K3lxMUITCZPCjyo2EoU4fksFwhcfDaR
 Z130izLc7V2Q0MVApwDkV5WamauCf/XSUmnlRtP1D0GDS/IhppFSKQ73AKKXqb8iPxHSC
 Q2Zqu/7csgmbZPTPEWUDe2HrFek+WoZkx0lQ1GBoXAmveHUTzN8QmemVY+3IvaQwPOq5k
 yUQTFFypuPpbJpOTlH1eMkKL5rKtpjLVT7j0qOVNQt0F3NIKxWisqo7xIiJx+4oAcRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791942026;
 h=Received-SPF:DKIM-Signature:Date:To:From:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=5qXayZM9AmqtffRsvq7u0g+eKrTa1RlGSDoXxNdCu3M=;
 b=jdn4jFqAA791PK9hok/1F/osERgOC9DQPiZz+RqyQ0gEQrBXJrjCaBoDg3DAAoRQoVnx
 s4HZk3Z65d8UcMW1pQl7nBVC+Ar4vshBXQ81EcJwEYEF/Yl6yrOKX4+bIRJA5yo1xmxTE
 KlsDfzPLqpBKmYlF+3+cIAMz4YMneHQzo5+usq23vgD4K0UaljhUexSJa0rvnoMHHpFmz
 i20PmnHuotsr7Lfs74upTdjvWR2gZ/PPvkvOVY0MZf2Vyo2SSO/4yfOUP519Zch3mQhXC
 /hziwr17oNbntlxzVSfmP1cUXiEq4diZAZ2mxHwLI57A5haHvEYjqheavrr6ktGwqXg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=kLv22cs1; 
 arc=none smtp.remote-ip=85.9.206.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.206.169;
 helo=mail-05.mail-europe.com; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=kLv22cs1
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5ED6380C17
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1791942012; x=1792201212;
 bh=5qXayZM9AmqtffRsvq7u0g+eKrTa1RlGSDoXxNdCu3M=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=kLv22cs1yqDS5KJsZKWxakxCw4tGcFDqpB4Is5VIkVGTg2jmUKBTBm1xYfHt7ofu1
 JioZAaR0odmMPM0mNO5IxfCxG3KXxuIYntzJGR2ANVgEdFN0m8suygk36QuSVmM/sS
 X3gkuCl4AL44xC0HyUTb/NcwVrHkdLD/jbWNUXFRoWY+UoqDPnZGB3/pTRFTGYWfhI
 7Bs+Nd1tnQJpM7+9c00YqYSkwYUmJyIJdrwcO9JTz/DDo8AfD6+tJP/DhMGEmL8Fbo
 TbbZRrc+GK33QEDSknQ5rL6bFYdG0WeD9WeNe3WlsM6798eA45y/6p3gQCNgkynkLy
 p91vEcsoxZarQ==
Date: Wed, 14 Oct 2026 01:40:08 +0000
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
From: Paul Moses <p@1g4.org>
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
Message-ID: <XZJHApdBRAdKWBcW4_dF6GzwUtdFV3-oYE9H5H1xSptrfzKOyXye7vRpqF6pmFsa3naLORrFmJtH_GFwAdKM-XaQlYWJfbFIMqzepUHSN1E=@1g4.org>
In-Reply-To: <sashiko-outbox-170659@kernel.org>
References: <20261013010854.4068874-1-p@1g4.org>
 <sashiko-outbox-170659@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: afdb3a4c6de350789ff22533139979540bae359e
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





On Tuesday, October 13th, 2026 at 8:10 PM, sashiko-bot@kernel.org <sashiko-=
bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] igc: Frame Preemption express packets (mPackets) lose TSIP strip=
ping when interleaved
> - [High] igc: incomplete TSIP underflow fix due to XDP fragment drop
> --
>=20
> commit 61d038c91b93b927335a69df60dbf6cc817c79e2
> Author: Paul Moses <p@1g4.org>
> igc: only strip RX timestamp header from first buffer
>=20
> This patch modifies the RX path to only subtract the 16-byte TSIP inline
> timestamp from the first buffer of an skb-assembled packet. This is inten=
ded
> to prevent an unsigned length underflow on continuation buffers shorter t=
han
> 16 bytes.
>=20
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >
> >  =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offse=
t;
> >
> > -=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > +=09=09if (!skb &&
> > +=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> >  =09=09=09ctx.rx_ts =3D pktbuf;
> >  =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
> >  =09=09=09size -=3D IGC_TS_HDR_LEN;
> >  =09=09}
>=20
> [Severity: High]
> Does this condition corrupt interleaved express packets?
>=20
> Frame Preemption allows express packets (mPackets) to be interleaved in t=
he
> RX ring while a preemptable packet is being assembled. When an mPacket
> arrives during this assembly, skb will be non-NULL.
>=20
> Because of the new !skb check, the mPacket's TSIP header won't be strippe=
d,
> leaving pkt_offset at 0 and size unmodified.
>=20
> Shortly after this check in igc_clean_rx_irq(), the mPacket is handled:
>=20
>     if (igc_fpe_is_pmac_enabled(adapter) &&
>         igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offse=
t)) {
>             /* Advance the ring next-to-clean */
>             igc_is_non_eop(rx_ring, rx_desc);
>             ...
>=20
> Will this pass the unadjusted size and unstripped TSIP header (pktbuf + 0=
)
> into igc_fpe_handle_mpacket(), treating the 16-byte hardware timestamp as
> packet payload?

It'll drop, not do that, but I'll fix in this series.


>=20
> [Severity: High]
> Does this fix fully prevent the continuation fragment underflow?
>=20
> The patch attempts to fix a queue stall caused by an integer underflow on
> continuation fragments, but relies on skb being non-NULL to detect them.
>=20
> If XDP is enabled and the administrator has enabled the rx-all feature
> (disabling MTU enforcement), an oversized packet can be split across mult=
iple
> descriptors. If the XDP program drops the first descriptor (e.g., returni=
ng
> XDP_DROP), skb remains NULL.
>=20
> When the loop hits igc_is_non_eop() and continues to the next descriptor,
> skb will still be NULL. If that continuation fragment is shorter than
> 16 bytes and has the TSIP status bit set, won't this check evaluate to tr=
ue
> and cause size to underflow exactly as it did before the patch?
>=20

No, xdp was still no bueno, but I've had some breakthroughs already today a=
nd
this is all mostly finished, I'll submit v3 series shortly.

Thanks,
Paul


