Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DD606A332
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dMOvxgbr;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=E2pTaF4I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B477680D5E;
	Mon, 26 Oct 2026 22:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KWiPyScnXSZx; Mon, 26 Oct 2026 22:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E504780D10
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052786;
	b=E6QIMx3in/nwtxg3ct0rfVcP37QEq67usShjSGz0ur0hOLO4XkpSI9rZR2FbFsabI3MX
	 0Y6/l5fb3AfvTWWjxTK18715KpyV5OHiq81JqoefqVu6SMPU60u18FPJPQ8bI1Z7z6yGk
	 ScGZsyMbBy1gYWck6KRrfa05n/L+4zlw/SqHWu++dvS1MBV0mue5lfatQI8TzM/FX2S8t
	 lvB/fYUUD/FQTr+F04VgozmH97TSCLE8ostjHHrUlFW5oqzxFXJB3QGNo7KrTTnZVJnGI
	 MBcxd92X5c29NH2rpO3Q5K+rF4ARd/teg9dHCDWBRhU7ErdM4JEbfqinJ2MCEecjJwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=66e8573GWZnz7bvZntPapm81qvP1dPCQ3yxm7LEhbdg=;
	b=XZ6PvkaYatvkeSalbfW365CQ+bRK2/Ww8gVenOCtzQVwV2Kt/tl5JYS++L7UfBFPzhl0
	 hZRhcOd2sP2YrxpqSu3+7xr8E0pp6Ncg7uoLUD33MqVV/R9kwLs7FAfXMKZFHKKHoaGsv
	 SmXoW/hixUTqzcf0eI39nDq+9+/NKfiMxysY5H1CZ2rU3CcmLuP6gWjedVnOpxMKxEW37
	 UvND40ta0Flih1bn0LdE9Hpy9RCSLTA2nEenkExdG+WfKSMIruuMtqDypZ49Ntf8xyYmx
	 MFgszQoTvJZxxwkkUq1j4Yjb0epiPt/cTqK2Ht3OVfwswVBv7pkHIcuqV1yFcO29KQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793052785;
	bh=66e8573GWZnz7bvZntPapm81qvP1dPCQ3yxm7LEhbdg=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dMOvxgbrc+xUbFXyove857JzY3ba/SmO3v82Z0zN5RR6XnHw4n111yf2AQVC/oK2q
	 rSw5nb+GtHOeoNrWpupO+WsRvEnBm4xeKhBXsefh2U2HxL+tkdznvoC8b8yVWeVNZL
	 nsAmA+4Igk1jgW7q9b2OzXznuKuzx932DZ5fOQRQbLYRVKBPul7zBIz/EwMXXIaRxc
	 0GfK1thgp6vU+2+r8i5z9q7ouBu4oZqZCBURJgx6qbyWl/G1/0u/YRKruJ+YWOoy1n
	 zMLsfLqnGKV5FeOh/pcf61zSO820d8aqtEwkzpDPUKwPvVDzZwT8w+vU1+CkcUyUji
	 6FAo1Y1SLr9yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E504780D10;
	Mon, 26 Oct 2026 22:13:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69F4B2F5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BDCE40205
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oQz_PmrfWTE for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 208F940075
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.118
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793052782;
 b=sI/mBz2++3tSHkZKCyMyMfD5vfWaCswjY4NoSY6NZXe31pakPPbRbe+ylFt32xCsmerG
 ngE/P3+6be24Ok3YO/53SOLB5VErOV/z4Ir/bo1xiDASdoi+qrqv8c5LeBCN1TOjaVRsM
 GdsTr0jTXFnzioIpLY3w+NgyGEWBxvWGjknE1ub94EZfjek0qUrIGrfUcJ5dcGMF8AUuw
 tHEvU9PUL6MBqhlxK2wK3Jof44hCX3RP2TQd5bNuDvevR0YawbvTPFI5J9PQToKJ0vsSC
 0NMTtKMjkjjMjDjhrGY77LBwhE0USL64My9fgAZMNsXgWVZ97UH5El9PzBfdiaqwSCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052782;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=66e8573GWZnz7bvZntPapm81qvP1dPCQ3yxm7LEhbdg=;
 b=bEwEUfrAiqVq7FMJHwoMAYsvdDmGf1ApCm8ZmSHZn4L1xDB4GUHd+Y6YBIn+rgTo5sHg
 kLgbJK9LArSVuqE2EQMyoY9lFdCDp6ukqaB0q069ZlUgaDf98pgXvU3AJzRIcC39GlANY
 miMfHRridKatXRbKqT+MQuaO1D0JSq4XS1o8jC1UB5YSMeuO8pUso9ABs8dPWcst+Be2w
 SViRBvqGBTD2Rz8KDyYmmNTCF8zLGFDtvWDK0PXjTJbSdDThqKbF5sotUeWSQoCt00B10
 FGOy9TsmAR+YiuNI63soCFQOSkBwtvMzk0H/aUXDwXRugI0xa+ZQesArDJeDjGFPhJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=E2pTaF4I; 
 arc=none smtp.remote-ip=109.224.244.118
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.118;
 helo=mail-244118.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=E2pTaF4I
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch
 [109.224.244.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 208F940075
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793052776; x=1793311976;
 bh=66e8573GWZnz7bvZntPapm81qvP1dPCQ3yxm7LEhbdg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=E2pTaF4IHfCB5bU4RuhRkXhZvCfTmH3d1oCLK7CeOVhuxG7WnpzFfSWxm0ckTvv3l
 FgrrXutYFGD2bckDM1CMUkxgkc+9IE9x3VVX1cOw0qSAtMPW5aIRjop+BAehf6F4Bc
 dnRm5i8T+RXlb0joRV5msZOqPODJOP1hLEfOEPvYZfKvMc5f9NQgwdT+h3yFSNHBC0
 3rKnslJNGF3G/dhGQYCxy63DFRKz1A598lCF/W4RHRd1fKKMZH/i8+p/GJnjpcHNKw
 YE8OCXGRGxiVy2x6UgYnduL7hrrv0iv6rkEP37/0rf7U/SdIbW0dCOp8xMKKepZhPc
 HCXaGaNfrIZpQ==
Date: Mon, 26 Oct 2026 22:12:51 +0000
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
Message-ID: <XxgY3anjXL5MwVEpWmTA-tZLeDhfNvdTDJ3n_8jTLgnomanMs92AQS6-QHZyNzAi5tSQM4UDHEZyKs1sG39MrfHwma2BkaoxScclyny5KOw=@1g4.org>
In-Reply-To: <at+t/jHczGvyXKRN@boxer>
References: <20261025065154.2037149-1-p@1g4.org> <at+t/jHczGvyXKRN@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ac7101c3c05c84577692eb23b23ecea516f2e015
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1





On Monday, October 26th, 2026 at 2:46 PM, Maciej Fijalkowski <maciej.fijalk=
owski@intel.com> wrote:

> On Sun, Oct 25, 2026 at 06:52:06AM +0000, Paul Moses wrote:
> > TSIP remains set on continuation descriptors, but the inline timestamp
> > header exists only in the first buffer. Stripping it from every
> > descriptor truncates split frames and can underflow short buffers.
> >
> > skb ownership cannot identify frame boundaries when XDP consumes the
> > first buffer or AF_XDP uses zero-copy.
> >
> > Track rx_in_frame per ring and update it as descriptors are consumed.
> > Strip timestamps only from first buffers, reject unsupported split
> > frames before XDP and drain continuations. Account discarded
> > descriptors against NAPI work without counting successful RX.
> >
> > Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> > Fixes: 26575105d6ed ("igc: Add initial XDP support")
> > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> > ---
> > - This supersedes "igc: only strip RX timestamp header from first buffe=
r"
> >   following feedback from Simon Horman, Maciej Fijalkowski and Sashiko.
> >
> > Changes:
> > - track frame boundaries independently of skb ownership
> > - guard timestamp stripping and drain unsupported split frames
> > - cover the AF_XDP zero-copy RX path
> > ---
> >  drivers/net/ethernet/intel/igc/igc.h      |  1 +
> >  drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++-------
> >  2 files changed, 64 insertions(+), 24 deletions(-)
>=20
> Hi Paul,
>=20
> I think this implementation went off track. We should make sure we *never=
*
> enter data path for XDP/AF_XDP multi-buffer scenario until we add real
> support to it within this driver. Now you sorta handle fragmented packets
> in data path.
>=20
> I tried to argue with bot reports that it hallucinated for
> igc_clean_rx_irq() content (which was concise and to the point) and agree=
d
> the AF_XDP should *not* be exposed to any fragmented traffic, which shoul=
d
> be addressed on HW RX ring configuration side, not within data path.
>=20
> Also this should have been a v3 with a link to previous revisions so we
> could keep track what has been changing between versions.
>=20
> Here's something that would address ZC fragmentation issue. Could you giv=
e
> it a spin on your side as I don't currently have igc in my setup handy.
>=20
>=20
> From a3edec7db135f13a567565a652da5cc850505f7f Mon Sep 17 00:00:00 2001
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Mon, 26 Oct 2026 15:00:00 +0100
> Subject: [PATCH net] igc: fix AF_XDP receive buffer size for 2K UMEM chun=
ks
>=20
> SRRCTL.BSIZEPKT has a granularity of 1 KiB. With a 2 KiB UMEM
> chunk and the default XDP headroom, xsk_pool_get_rx_frame_size()
> returns 1792. Programming this value truncates the hardware receive
> buffer size to 1 KiB, even though an MTU-sized frame fits in the
> usable UMEM area.
>=20
> XDP on igc is limited to MTU 1500, so configure a 2 KiB receive
> buffer for XSK rings. Limit RLPML to the maximum supported Ethernet
> frame size while XDP is attached, regardless of PAGE_SIZE, to avoid
> oversized frames spanning descriptors or exceeding the usable UMEM
> space.
>=20
> RLPML is currently programmed from igc_set_rx_mode(), which can run
> without RTNL, for example on an IPv6 multicast join, and could then
> use a stale XDP state. RLPML does not depend on the address lists.
> Program it from igc_setup_rctl() instead, next to RCTL.LPE, and from
> igc_xdp_set_prog() while the rings are disabled. This avoids
> netif_addr_lock_bh() usage.
>=20
> Validate that the XSK frame size accommodates a maximum-size frame
> with two VLAN tags, FCS and the optional inline RX timestamp. Check
> against the maximum supported XDP MTU, rather than the current MTU,
> which can change after the socket is bound.
>=20
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 33 +++++++++++++++++------
>  drivers/net/ethernet/intel/igc/igc_xdp.c  | 11 +++++---
>  3 files changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/=
intel/igc/igc.h
> index 17f213cc93e4..ad1062f8531a 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -765,6 +765,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw,=
 u32 offset, u16 *data)
>  =09return -EOPNOTSUPP;
>  }
>=20
> +void igc_set_rlpml(struct igc_adapter *adapter);
>  void igc_reinit_locked(struct igc_adapter *);
>  struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
>  =09=09=09=09      u32 location);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..38a5702647f4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter=
 *adapter,
>  =09ring->next_to_clean =3D 0;
>  =09ring->next_to_use =3D 0;
>=20
> +=09/* igc's XDP limits MTU to 1500; all XSK RX buffers can use 2kb;
> +=09 * RLPML limits the receive length to fit after UMEM headroom.
> +=09 */
>  =09if (ring->xsk_pool)
> -=09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +=09=09buf_size =3D IGC_RXBUFFER_2048;
>  =09else if (ring_uses_large_buffer(ring))
>  =09=09buf_size =3D IGC_RXBUFFER_3072;
>  =09else
> @@ -830,6 +833,25 @@ static void igc_setup_mrqc(struct igc_adapter *adapt=
er)
>  =09wr32(IGC_MRQC, mrqc);
>  }
>=20
> +void igc_set_rlpml(struct igc_adapter *adapter)
> +{
> +=09struct igc_hw *hw =3D &adapter->hw;
> +=09u32 rlpml =3D MAX_JUMBO_FRAME_SIZE;
> +
> +#if (PAGE_SIZE < 8192)
> +=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> +=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> +#endif
> +=09/* igc's XDP currently does not support jumbo frames. Limit the
> +=09 * accepted packet size regardless of PAGE_SIZE so it fits in a 2kb
> +=09 * XSK chunk.
> +=09 */
> +=09if (igc_xdp_is_enabled(adapter))
> +=09=09rlpml =3D ETH_FRAME_LEN + VLAN_HLEN * 2 + ETH_FCS_LEN;
> +
> +=09wr32(IGC_RLPML, rlpml);
> +}
> +
>  /**
>   * igc_setup_rctl - configure the receive control registers
>   * @adapter: Board private structure
> @@ -874,6 +896,7 @@ static void igc_setup_rctl(struct igc_adapter *adapte=
r)
>  =09=09=09  IGC_RCTL_CFIEN); /* Disable VLAN CFIEN Filter */
>  =09}
>=20
> +=09igc_set_rlpml(adapter);
>  =09wr32(IGC_RCTL, rctl);
>  }
>=20
> @@ -4116,7 +4139,7 @@ static void igc_set_rx_mode(struct net_device *netd=
ev)
>  {
>  =09struct igc_adapter *adapter =3D netdev_priv(netdev);
>  =09struct igc_hw *hw =3D &adapter->hw;
> -=09u32 rctl =3D 0, rlpml =3D MAX_JUMBO_FRAME_SIZE;
> +=09u32 rctl =3D 0;
>  =09int count;
>=20
>  =09/* Check for Promiscuous and All Multicast modes */
> @@ -4146,12 +4169,6 @@ static void igc_set_rx_mode(struct net_device *net=
dev)
>  =09/* update state of unicast and multicast */
>  =09rctl |=3D rd32(IGC_RCTL) & ~(IGC_RCTL_UPE | IGC_RCTL_MPE);
>  =09wr32(IGC_RCTL, rctl);
> -
> -#if (PAGE_SIZE < 8192)
> -=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> -=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
> -#endif
> -=09wr32(IGC_RLPML, rlpml);
>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ether=
net/intel/igc/igc_xdp.c
> index 9eb47b4beb06..a0f1ecb2ed5f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -34,6 +34,8 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struc=
t bpf_prog *prog,
>  =09}
>=20
>  =09old_prog =3D xchg(&adapter->xdp_prog, prog);
> +=09if (if_running && need_update)
> +=09=09igc_set_rlpml(adapter);
>  =09if (old_prog)
>  =09=09bpf_prog_put(old_prog);
>=20
> @@ -69,11 +71,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *ad=
apter,
>  =09=09return -EINVAL;
>=20
>  =09frame_size =3D xsk_pool_get_rx_frame_size(pool);
> -=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
> +=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2 +
> +=09=09=09 ETH_FCS_LEN + IGC_TS_HDR_LEN) {
>  =09=09/* When XDP is enabled, the driver doesn't support frames that
> -=09=09 * span over multiple buffers. To avoid that, we check if xsk
> -=09=09 * frame size is big enough to fit the max ethernet frame size
> -=09=09 * + vlan double tagging.
> +=09=09 * span multiple buffers. Check the maximum supported MTU, not
> +=09=09 * current MTU, as it may change while the pool is bound. Account
> +=09=09 * for double VLAN tags, FCS and inline RX timestamping.
>  =09=09 */
>  =09=09return -EOPNOTSUPP;
>  =09}
> --
> 2.43.0
>=20
>=20
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/etherne=
t/intel/igc/igc.h
> > index 17f213cc93e4..635d49701e62 100644
> > --- a/drivers/net/ethernet/intel/igc/igc.h
> > +++ b/drivers/net/ethernet/intel/igc/igc.h
> > @@ -198,6 +198,7 @@ struct igc_ring {
> >  =09=09=09struct igc_rx_packet_stats pkt_stats;
> >  =09=09=09struct u64_stats_sync rx_syncp;
> >  =09=09=09struct sk_buff *skb;
> > +=09=09=09bool rx_in_frame;
> >  =09=09};
> >  =09};
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c..9ca5558c762c 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring=
)
> >  =09=09igc_clean_rx_ring_page_shared(ring);
> >
> >  =09clear_ring_uses_large_buffer(ring);
> > +=09ring->rx_in_frame =3D false;
> >
> >  =09ring->next_to_alloc =3D 0;
> >  =09ring->next_to_clean =3D 0;
> > @@ -673,6 +674,7 @@ static void igc_configure_rx_ring(struct igc_adapte=
r *adapter,
> >  =09/* reset next-to- use/clean to place SW in sync with hardware */
> >  =09ring->next_to_clean =3D 0;
> >  =09ring->next_to_use =3D 0;
> > +=09ring->rx_in_frame =3D false;
> >
> >  =09if (ring->xsk_pool)
> >  =09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
> > @@ -2111,10 +2113,8 @@ static bool igc_can_reuse_rx_page(struct igc_rx_=
buffer *rx_buffer,
> >   * @rx_ring: Rx ring being processed
> >   * @rx_desc: Rx descriptor for current buffer
> >   *
> > - * This function updates next to clean.  If the buffer is an EOP buffe=
r
> > - * this function exits returning false, otherwise it will place the
> > - * sk_buff in the next buffer to be chained and return true indicating
> > - * that this is in fact a non-EOP buffer.
> > + * Advance next to clean and retain frame position for the next descri=
ptor.
> > + * Return true if the consumed descriptor does not end the frame.
> >   */
> >  static bool igc_is_non_eop(struct igc_ring *rx_ring,
> >  =09=09=09   union igc_adv_rx_desc *rx_desc)
> > @@ -2127,10 +2127,8 @@ static bool igc_is_non_eop(struct igc_ring *rx_r=
ing,
> >
> >  =09prefetch(IGC_RX_DESC(rx_ring, ntc));
> >
> > -=09if (likely(igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)))
> > -=09=09return false;
> > -
> > -=09return true;
> > +=09rx_ring->rx_in_frame =3D !igc_test_staterr(rx_desc, IGC_RXD_STAT_EO=
P);
> > +=09return unlikely(rx_ring->rx_in_frame);
> >  }
> >
> >  /**
> > @@ -2601,7 +2599,7 @@ static void igc_update_rx_stats(struct igc_q_vect=
or *q_vector,
> >
> >  static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int b=
udget)
> >  {
> > -=09unsigned int total_bytes =3D 0, total_packets =3D 0;
> > +=09unsigned int total_bytes =3D 0, total_packets =3D 0, work_done =3D =
0;
> >  =09struct igc_adapter *adapter =3D q_vector->adapter;
> >  =09struct igc_ring *rx_ring =3D q_vector->rx.ring;
> >  =09struct sk_buff *skb =3D rx_ring->skb;
> > @@ -2609,13 +2607,15 @@ static int igc_clean_rx_irq(struct igc_q_vector=
 *q_vector, const int budget)
> >  =09int xdp_status =3D 0, rx_buffer_pgcnt;
> >  =09int xdp_res =3D 0;
> >
> > -=09while (likely(total_packets < budget)) {
> > +=09while (likely(work_done < budget)) {
> >  =09=09struct igc_xdp_buff ctx =3D { .rx_ts =3D NULL };
> > +=09=09bool first =3D !rx_ring->rx_in_frame;
> >  =09=09struct igc_rx_buffer *rx_buffer;
> >  =09=09union igc_adv_rx_desc *rx_desc;
> >  =09=09unsigned int size, truesize;
> >  =09=09int pkt_offset =3D 0;
> >  =09=09void *pktbuf;
> > +=09=09bool tsip;
> >
> >  =09=09/* return some buffers to hardware, one at a time is too slow */
> >  =09=09if (cleaned_count >=3D IGC_RX_BUFFER_WRITE) {
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
> >
> > -=09=09if (igc_fpe_is_pmac_enabled(adapter) &&
> > +=09=09if (first && igc_fpe_is_pmac_enabled(adapter) &&
> >  =09=09    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_=
offset)) {
> >  =09=09=09/* Advance the ring next-to-clean */
> >  =09=09=09igc_is_non_eop(rx_ring, rx_desc);
> >  =09=09=09cleaned_count++;
> > +=09=09=09work_done++;
> >  =09=09=09continue;
> >  =09=09}
> >
> > @@ -2664,6 +2677,12 @@ static int igc_clean_rx_irq(struct igc_q_vector =
*q_vector, const int budget)
> >  =09=09=09xdp_res =3D igc_xdp_run_prog(adapter, &ctx.xdp);
> >  =09=09}
> >
> > +=09=09if (xdp_res) {
> > +=09=09=09total_bytes +=3D size;
> > +=09=09=09total_packets++;
> > +=09=09}
> > +
> > +xdp_done:
> >  =09=09if (xdp_res) {
> >  =09=09=09switch (xdp_res) {
> >  =09=09=09case IGC_XDP_CONSUMED:
> > @@ -2676,8 +2695,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >  =09=09=09=09break;
> >  =09=09=09}
> >
> > -=09=09=09total_packets++;
> > -=09=09=09total_bytes +=3D size;
> > +=09=09=09work_done++;
> >  =09=09} else if (skb)
> >  =09=09=09igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
> >  =09=09else if (ring_uses_build_skb(rx_ring))
> > @@ -2700,8 +2718,15 @@ static int igc_clean_rx_irq(struct igc_q_vector =
*q_vector, const int budget)
> >  =09=09if (igc_is_non_eop(rx_ring, rx_desc))
> >  =09=09=09continue;
> >
> > +=09=09if (xdp_res) {
> > +=09=09=09skb =3D NULL;
> > +=09=09=09continue;
> > +=09=09}
> > +
> > +=09=09work_done++;
> > +
> >  =09=09/* verify the packet layout is correct */
> > -=09=09if (xdp_res || igc_cleanup_headers(rx_ring, rx_desc, skb)) {
> > +=09=09if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
> >  =09=09=09skb =3D NULL;
> >  =09=09=09continue;
> >  =09=09}
> > @@ -2717,7 +2742,6 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >  =09=09/* reset skb pointer */
> >  =09=09skb =3D NULL;
> >
> > -=09=09/* update budget accounting */
> >  =09=09total_packets++;
> >  =09}
> >
> > @@ -2732,7 +2756,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *=
q_vector, const int budget)
> >  =09if (cleaned_count)
> >  =09=09igc_alloc_rx_buffers(rx_ring, cleaned_count);
> >
> > -=09return total_packets;
> > +=09return work_done;
> >  }
> >
> >  static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
> > @@ -2797,10 +2821,10 @@ static struct igc_xdp_buff *xsk_buff_to_igc_ctx=
(struct xdp_buff *xdp)
> >
> >  static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const in=
t budget)
> >  {
> > +=09int total_bytes =3D 0, total_packets =3D 0, work_done =3D 0;
> >  =09struct igc_adapter *adapter =3D q_vector->adapter;
> >  =09struct igc_ring *ring =3D q_vector->rx.ring;
> >  =09u16 cleaned_count =3D igc_desc_unused(ring);
> > -=09int total_bytes =3D 0, total_packets =3D 0;
> >  =09u16 ntc =3D ring->next_to_clean;
> >  =09struct bpf_prog *prog;
> >  =09bool failure =3D false;
> > @@ -2810,11 +2834,13 @@ static int igc_clean_rx_irq_zc(struct igc_q_vec=
tor *q_vector, const int budget)
> >
> >  =09prog =3D READ_ONCE(adapter->xdp_prog);
> >
> > -=09while (likely(total_packets < budget)) {
> > +=09while (likely(work_done < budget)) {
> > +=09=09bool first =3D !ring->rx_in_frame;
> >  =09=09union igc_adv_rx_desc *desc;
> >  =09=09struct igc_rx_buffer *bi;
> >  =09=09struct igc_xdp_buff *ctx;
> >  =09=09unsigned int size;
> > +=09=09bool eop, tsip;
> >  =09=09int res;
> >
> >  =09=09desc =3D IGC_RX_DESC(ring, ntc);
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
> > @@ -2851,6 +2886,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vect=
or *q_vector, const int budget)
> >  =09=09xsk_buff_dma_sync_for_cpu(bi->xdp);
> >
> >  =09=09res =3D __igc_xdp_run_prog(adapter, prog, bi->xdp);
> > +=09=09total_bytes +=3D size;
> > +=09=09total_packets++;
> > +
> > +xdp_done:
> >  =09=09switch (res) {
> >  =09=09case IGC_XDP_PASS:
> >  =09=09=09igc_dispatch_skb_zc(q_vector, desc, ctx);
> > @@ -2865,8 +2904,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vecto=
r *q_vector, const int budget)
> >  =09=09}
> >
> >  =09=09bi->xdp =3D NULL;
> > -=09=09total_bytes +=3D size;
> > -=09=09total_packets++;
> > +=09=09ring->rx_in_frame =3D !eop;
> > +=09=09work_done++;
> >  =09=09cleaned_count++;
> >  =09=09ntc++;
> >  =09=09if (ntc =3D=3D ring->count)
> > @@ -2889,10 +2928,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vec=
tor *q_vector, const int budget)
> >  =09=09=09xsk_set_rx_need_wakeup(ring->xsk_pool);
> >  =09=09else
> >  =09=09=09xsk_clear_rx_need_wakeup(ring->xsk_pool);
> > -=09=09return total_packets;
> > +=09=09return work_done;
> >  =09}
> >
> > -=09return failure ? budget : total_packets;
> > +=09return failure ? budget : work_done;
> >  }
> >
> >  static void igc_update_tx_stats(struct igc_q_vector *q_vector,
> >
>=20

Looks good to me, passes basic testing, and I would rather you/intel do thi=
s patch

For posterity, I did email Tony with handoff notes stating I'd rather not d=
o the=20
xdp/xsk/af_xdp/fpe side of things, but hadn't heard back so I kept going. 
