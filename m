Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C9606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UUXCxF2K;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=obR0omlz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92FFD80A79;
	Tue, 27 Oct 2026 16:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lL6pVYnWHrmh; Tue, 27 Oct 2026 16:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 49A3480F80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793118790;
	b=XvjaRGyy81GKakW3fNcgRtrySLU4sQ3WRsl98z9fLAlZL0Uori+GYg7oZ6Vobkr+0CdD
	 R8842vY/NNp5TO7v5Cc+r40eMJMVVT17s5eigTV/hiIkZCcqGvxgmpPr8D3zzNiHiPG+9
	 oXt1NMe+2aQj4IqFwaNFJK1BS4DsfN/xlsC+pY4Vc/c6dwLKQUD4p9goh/aDtB+qiTfUR
	 xOi3yfEet/bH8OLfZH+J9V/Or4Y5EafMezxTPIvOV96M4RbUw2P1IAb2Xy0zqTUW4Tsou
	 Wz8ythdlRHSqeMTXA65G4TUElLx1kM1Wp+5cyc++/NrSQ3S/u3TJHAjRuU20w669HoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793118790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
	b=HeDDEtzj7vAgq08SZMjGsTpB4edmJiGb2ulQ5SqeHNiFpkOU3EnrNP170jlBxWRhGxNJ
	 WLUwbXhOdfwz9hAK9xLfe8LrClLTMXd3+Idw+CJ7jzYGYVJBUky7SNU67au+j7BZXYfWS
	 UeHQPsuTKJYSsA+rc/F/aa1pyCXgFZ4ZcRzZhiu88rY/Tbg7hzW+kPrVnyGCoEUNa9LTv
	 G15YxziHmUu9b1DTxGPsQ91DKpmacaVxhDBMj6pUTkv8XfxaIeecPbcc67KW+obRIFiw0
	 4RzEgH8pp8Z+vqeLqdG5zQdsWuJCYMg3wQ+oBKtYbQm0NiTkApXdj2wf/2ArznWSqzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793118790;
	bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UUXCxF2KcqL7/mAvctNOS7QMjoz8RRbu1zcTwBjqIyjhPv3ERng5MCzioopvnTdJV
	 nxZEHVhfUYDcRZtQp2Hag3W7NLux5gvCdmjtfGE7QaXfyd3eLqhlKYsKk9Vetxsh61
	 ADWPMO++s4RJNfFnVNBfKSTOS2gTXQfXMSIJqU815dEWOY7lARrR3hlaQF77RajvPD
	 mZzsneuayMi5bDGhICOUKOZA2L9yVwMsrNbNHNzCruoKrq/LB0UsZbH6gfWEkCn0TV
	 vM2fZZKQEGy5opJFwrtHiLH+SAPhoVNyPFO8YTJ8L94h8bVBnUUQJQO6fzny+85NpS
	 BpFUu2OfxmEBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A3480F80;
	Tue, 27 Oct 2026 16:33:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 30059A32
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20CDE6068F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_MPT47N6wxt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 16:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B15C6064A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.98
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793118788;
 b=jwDgqwtJfueKby8Tk8BCMd3oshDvGTSFIlC7XQasgY1xLMmnorCw/TUZ5seQabgZkxS4
 AkcWRsZnnZ74JoYcKgihrmnzYGm+lsZI+JHALxde0oknA2WQjNit6sRxKpOFDu/UU4dWj
 kKNaLnwXxaASysHX/EXNtAXCpayuKjFPhJZyvo1ZNEk//mtLW+WWGrYAyFGUPDvp14HDs
 hSGdQvwyLL1iirHKWCc4mwNeb//5lzLE/+Zkpjz4rR/eDYPkAymcQJIh7uGIVkU9/FRUm
 GohfCA/fwpIJaAZzO7X0Fcj4dzhc86OPOi8jCbjR9O/5cmyrqqjXEp47eDFXETrrZrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793118788;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
 b=ZnGenX9BdehoaKvAjAkFkG0HvPcxNBEOGQ9x2qli9lc9yiBPuRzVFEMHDYClyAjMoaye
 HtBbTxBWWIVotZsjjOEtRXZ4s5fFzPvfmeUDQbSnBpFwzTCGesR8vs8Oh3RCkR1olQmZP
 UNd2ZbOkY0pNtOFtzUpiVkmyzmz/WDPkXMgMDxBMab1PkCKAXEgwFQIAp+h4DU80UwZJG
 6CW3kp5NmqZKcgh1Jq5NOzdh50Z8KpzcujuAR8X2FGUT/SiS+XL3cVYG4EL4uwH0GoViV
 IimhMDf8z2H3CwLjfZwDQDB4KeEyunYL30izCkD41neJlCaM87Pn8mVLC+A/IlwBL7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=obR0omlz; 
 arc=none smtp.remote-ip=185.70.43.98
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.98;
 helo=mail-4398.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=obR0omlz
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B15C6064A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793118785; x=1793377985;
 bh=TbMT5lghyaS7KxQgJ+MM/CluoulGShAxSFb3s558JYY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=obR0omlz+RH9skUK/AijjQJ0MbxcBbLaq7bLBd+ZpUKNrs6DZIiO03GL5wtCPo4tU
 oxLSsRs6PHG8SP/+utakZfh3tB6mub8qUPGxwgV/IpqiRTGtsAFyWH/w6biugAASJL
 3oRf38MGoR6/+0DToGYWTq/JQckkQg99rkiqXbE+knIq5yKQxZmsMrcJ/PtYNi4whL
 mGSW+uToCK9TQO0TECEevVoO/rADbQ1Qm7wx4E7bXCKHanRLimHQngryr1pCy5hU5Z
 FS+z6Av0bvsU+H9mKg4N9ixa/kk3bNu4VLmVofYZWHIBWPZTiGMul+YrhgIkRBEgGD
 idF/xJ5XQGSQQ==
Date: Tue, 27 Oct 2026 16:32:59 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <R7FJ9H2Yqq7aJ5dcgVzcIZN-iI5qNsSVTCHlGTVoz9-HMbzAcMqJ6qCtNLlpjc6DATjNq67fgeC6paxLm4r5hBf4s85vmMOlLqB8MbAFTr0=@1g4.org>
In-Reply-To: <auBehtniOJTRGfaD@boxer>
References: <20261023141317.3904442-1-p@1g4.org> <at+yluh1NVm78gn6@boxer>
 <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
 <auBehtniOJTRGfaD@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 31b7716a514270b0b4fbc73d35c670e646ea2b41
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





On Tuesday, October 27th, 2026 at 3:19 AM, Maciej Fijalkowski <maciej.fijal=
kowski@intel.com> wrote:

> On Mon, Oct 26, 2026 at 10:18:03PM +0000, Paul Moses wrote:
> > On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fi=
jalkowski@intel.com> wrote:
> >
> > > On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > > > Converting an XSK buffer to an XDP frame allocates a page and retur=
ns
> > > > the original buffer to its pool. If the TX ring is full or DMA mapp=
ing
> > > > fails, igc_xdp_xmit_back() returns an error without freeing the cop=
y.
> > > > The RX cleaner cannot release it, so the page leaks.
> > > >
> > > > Return the copied frame on TX failure. Save the RX memory type befo=
re
> > > > conversion so native frames remain RX-owned on failure.
> > > >
> > > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses <p@1g4.org>
> > > > ---
> > > > Tested on Intel I225-V with baseline and patched kernels. Physical
> > > > pause-frame backpressure caused 46 leaked copies on the baseline.
> > > > With the fix, all 72 rejected copies were returned once and freed,
> > > > and all 192 copies were accounted for.
> > > >
> > > >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/ne=
t/ethernet/intel/igc/igc_main.c
> > > > index 1fb5f3cbe93c..39263fd04aa9 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_a=
dapter *adapter, int cpu)
> > > >
> > > >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct x=
dp_buff *xdp)
> > > >  {
> > > > +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> > >
> > > small nit is we require a concept called RCT (reverse christmas tree)
> > > which makes you to order variable declarations from longest line to
> > > shortest.
> > >
> > > >  =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> > > >  =09int cpu =3D smp_processor_id();
> > > >  =09struct netdev_queue *nq;
> > > > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adap=
ter *adapter, struct xdp_buff *xdp)
> > > >  =09txq_trans_cond_update(nq);
> > > >  =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
> > > >  =09__netif_tx_unlock(nq);
> > > > +
> > > > +=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
> > > > +=09=09xdp_return_frame(xdpf);
> > >
> > > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >
> > > > +
> > > >  =09return res;
> > > >  }
> > > >
> > > > --
> > > > 2.56.GIT
> > > >
> > > >
> > > >
> > >
> >
> > Never know what to do in these cases, order matters here, so
> > do I touch more lines to move the assignment down below?
>=20
> =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> +=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> =09int cpu =3D smp_processor_id();
> =09struct netdev_queue *nq;
>=20
> this would satisfy the RCT rule.
>=20

Ok I'll send soon.
