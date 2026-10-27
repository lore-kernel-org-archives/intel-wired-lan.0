Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E54606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=k7yDVfsX;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=nSWkwrSp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3D8E40689;
	Tue, 27 Oct 2026 16:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oiv2uNO50nbo; Tue, 27 Oct 2026 16:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28FA940664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793118617;
	b=pC2oqCZ7tYCMNoO7iLvJtyk28OxTQ9kV28s1vPMDykXxS9lUSx9v8QbY8iMozwL3Xwpf
	 vDtsvpZcuyeblkUBW55m3c2KkFR/a2Za8BX06L/bqPwa2wM9ZDxTGuP+zI42SBqzNB2I4
	 0ItuyuMfzm7uGgoiILMqWCUNb8f+ucvcRnAc80gzJl/DZasVul7kAf/ADW2ukD8J2L9hD
	 DXmb9QyeVKDtmFEMS+roR1lG4dI+B9wSNlRuxosmE6dU9JPIQXUz9kpTcNSj07kaMTxWb
	 AtVFDSn6TqRHP5ltMpn96tDT153nroSM2l02Fa6A1JR8fs8omX6tdsrRcSSKe1XK4xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793118617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z/3jpXuKR8Ek75myDtIS6oISZLc5tTxlxTmwToUVi/Q=;
	b=tUyNhgZeAbjKNE6sm1vr27k91QU/pAVg3na2P2KD1AGhndPeNh7vWPngoMT195k9+ceP
	 mEXdJa+FYGwgNsA1oQA7qJiASBnAG91/12DY5sO66XhvtsXhhY3gAfX6KDirYTtJFYYym
	 a4RfugDfh4raFMCPVXXVzwIt0Zc+bVUlroT84WOCOTwXHSaxobfWT8/m1msCl44GneDAp
	 E7QzQ0pisUR4l6uu7RkOyKhMr5Lhifx9otMIntUD3inAql47JsWvpZcozGd906iuRhnC2
	 z5/FUHyTfSXy3QJigN8h4X+mbm5WwA35w1T2h0DK80EtNSq63lsj+W+UOHA/zXPMDZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793118617;
	bh=z/3jpXuKR8Ek75myDtIS6oISZLc5tTxlxTmwToUVi/Q=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k7yDVfsXAsCk+gDb0dFPmA2axySyyxGV8Gonj2JnxLL2luUSuqi3c4GjNAmWCsChc
	 fZrPkF795YSO22u0HCiubdummrDjV1ZeJCb6U/l1Otaq6MyLpw2v1wC+2tSUXwqxta
	 2AF56vGXKEdYJ8j7NuPa/q6svravhJpVSKyl0hwkTpgIvfEYO0ulqZvyjfi+WKxbGm
	 UGkmgZryf8PvmMjhd7/6nl+7eddzbC4KJaod4MyHjhyYiU+S4h8hcqoGETY5/fuxdM
	 BXSqVzNsnt2lemReG/55KVWb4qz6o2AMC1bKkdX1dRuwIFM3DL6uY6WiwHN5YooEd2
	 2nYG2r5WA7Adw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28FA940664;
	Tue, 27 Oct 2026 16:30:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B64E24BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A86CA6068F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvY1VcuWb19Y for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 16:30:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 074F5605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793118614;
 b=Q2eI/XVs7Md2Xz0uUG7Bct0E7NsIRaOyBzlr2MgbPBvQUDLALpgLdYy0vVkczIyXVQX1
 1a4KPvv9LICrNeKvnNoRxK2PETF5rXCZ7eDWkHGBzZMoqb+YxWZzhTUtvymhTVUldDdGP
 Fcj7HdtG887ycje17/kxoP/RccaE7+6aXPSSXuvwqoEkz2dlNypNaKNSAFke4PQ1ZDmoM
 BqWh97GjVR1q1wod1BUr75cvKi4sTsXmOkUbKWHMpyih7oiXFDhrFFiIbYMdo6Y+TXpqM
 wlwnXjSeJT4srG7FRoAUKfCRAIhS4wqRurxG2Dg7E0mwUiwaOTFZjfrYo5/adGPwbjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793118614;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=z/3jpXuKR8Ek75myDtIS6oISZLc5tTxlxTmwToUVi/Q=;
 b=ev1Wts6G3a+/ABOTscF/3z2TjD7fzKWWMPfXMgD2uWYVEDT/e4R6CM4EsHj9tG0zKeV/
 VZQOGIcHPOETBx8Zj8rz9buyVTVrrxKIxfuVwoGnwBUayJyFQ1pXy61f6b28e6eDCiUvE
 TYGUwExemAhvcUldGQte0AwhWhkD8bFJHYSsomLiKbzZ5PvQ98H+hSzfFjsHrawfl49hY
 kolOipS8zY0fMfh3uI8Kq1Kqfq16ko0slrt4kiF0NfQut/My26d2TNuRzItAiwajBg0wN
 7ZaXr7y+XPrlDUI9ONoMvmrtomcKO0zm8HOQtxna/VhbqgU0hLnZ0XleDbBtQ5TAvkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=nSWkwrSp; 
 arc=none smtp.remote-ip=109.224.244.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.21;
 helo=mail-24421.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=nSWkwrSp
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 074F5605D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793118607; x=1793377807;
 bh=z/3jpXuKR8Ek75myDtIS6oISZLc5tTxlxTmwToUVi/Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nSWkwrSpNgrFzE4n9LAMKt6PEdv8HOS2JVM7mE3Zo09iiDZ13pynId9Ydvnu4M3UB
 iH+w5WgWV/iHrwO47RGhPAi6+bmNcOPtitVsUlSfGdJCSIlAHRd6BbG94qmZ+xSyul
 rDSTVeY2trT697oMv+92cyxI352rU1n6bk0KSbECfuc/7AlHklW5cKiQrqRDt1KKzg
 bYsieFz0X+ril90PfxYHhQ/e3VS4+YLMHW8TcDB2aU7+VihwSB7HXvcxU9l1L2WDkk
 mO9hPcQuc43TgjhFE67L2w8U9mRD6Va6YwzNOEfGWgGKoQ6fiaYzjZ2EG12NM0Ibi+
 5GqNUmSUtU1pw==
Date: Tue, 27 Oct 2026 16:30:02 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 vedang.patel@intel.com, jithu.joseph@intel.com, andre.guedes@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <eZWITZTcOwr2NglsQ81lTVz7KdBTIb7L8jpSRGGX3Ts-wlGb6eIUGco_iev6GD5OFkaOmIMwKlADpfVh9KE-FdHCRgfFDSs6ZzYCaJbgp8I=@1g4.org>
In-Reply-To: <auBfnRqpsuF4B+J9@boxer>
References: <20261025065154.2037149-1-p@1g4.org> <at+t/jHczGvyXKRN@boxer>
 <XxgY3anjXL5MwVEpWmTA-tZLeDhfNvdTDJ3n_8jTLgnomanMs92AQS6-QHZyNzAi5tSQM4UDHEZyKs1sG39MrfHwma2BkaoxScclyny5KOw=@1g4.org>
 <auBfnRqpsuF4B+J9@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 2f363783c4d49599380b8b788c0128422907cb62
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





On Tuesday, October 27th, 2026 at 3:24 AM, Maciej Fijalkowski <maciej.fijal=
kowski@intel.com> wrote:

> On Mon, Oct 26, 2026 at 10:12:51PM +0000, Paul Moses wrote:
> >
> >
> >
> >
> > On Monday, October 26th, 2026 at 2:46 PM, Maciej Fijalkowski <maciej.fi=
jalkowski@intel.com> wrote:
> >
> > > On Sun, Oct 25, 2026 at 06:52:06AM +0000, Paul Moses wrote:
> > > > TSIP remains set on continuation descriptors, but the inline timest=
amp
> > > > header exists only in the first buffer. Stripping it from every
> > > > descriptor truncates split frames and can underflow short buffers.
> > > >
> > > > skb ownership cannot identify frame boundaries when XDP consumes th=
e
> > > > first buffer or AF_XDP uses zero-copy.
> > > >
> > > > Track rx_in_frame per ring and update it as descriptors are consume=
d.
> > > > Strip timestamps only from first buffers, reject unsupported split
> > > > frames before XDP and drain continuations. Account discarded
> > > > descriptors against NAPI work without counting successful RX.
> > > >
> > > > Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> > > > Fixes: 26575105d6ed ("igc: Add initial XDP support")
> > > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses <p@1g4.org>
> > > > ---
> > > > - This supersedes "igc: only strip RX timestamp header from first b=
uffer"
> > > >   following feedback from Simon Horman, Maciej Fijalkowski and Sash=
iko.
> > > >
> > > > Changes:
> > > > - track frame boundaries independently of skb ownership
> > > > - guard timestamp stripping and drain unsupported split frames
> > > > - cover the AF_XDP zero-copy RX path
> > > > ---
> > > >  drivers/net/ethernet/intel/igc/igc.h      |  1 +
> > > >  drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++---=
----
> > > >  2 files changed, 64 insertions(+), 24 deletions(-)
> > >
> > > Hi Paul,
> > >
> > > I think this implementation went off track. We should make sure we *n=
ever*
> > > enter data path for XDP/AF_XDP multi-buffer scenario until we add rea=
l
> > > support to it within this driver. Now you sorta handle fragmented pac=
kets
> > > in data path.
> > >
> > > I tried to argue with bot reports that it hallucinated for
> > > igc_clean_rx_irq() content (which was concise and to the point) and a=
greed
> > > the AF_XDP should *not* be exposed to any fragmented traffic, which s=
hould
> > > be addressed on HW RX ring configuration side, not within data path.
> > >
> > > Also this should have been a v3 with a link to previous revisions so =
we
> > > could keep track what has been changing between versions.
> > >
> > > Here's something that would address ZC fragmentation issue. Could you=
 give
> > > it a spin on your side as I don't currently have igc in my setup hand=
y.
>=20
> [...]
>=20
> >
> > Looks good to me, passes basic testing, and I would rather you/intel do=
 this patch
> >
> > For posterity, I did email Tony with handoff notes stating I'd rather n=
ot do the
> > xdp/xsk/af_xdp/fpe side of things, but hadn't heard back so I kept goin=
g.
>=20
> I think this was within the thread where AI hallucinated and I stepped in=
.

No worries, it turned out more interesting than expected.=20

> If you are not fed up yet you can take your v2 and the patch I added here
> and send this as a change set. From my POV it would be better as you have
> the HW to test this against and ironically my igc card went into
> /dev/null's lab.
>=20
> >
>=20
Not fed up but sleep deprived, yes, I'll do that.


