Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACB606A32D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xr5byWiH;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DScpJPv9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CFED80CEC;
	Mon, 26 Oct 2026 10:15:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzkZmUnl7qrZ; Mon, 26 Oct 2026 10:15:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF8BD80D48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793009721;
	b=lF0H+K6hLqqJiS438Gh4JMlcwUFltrVEUpT8RFnEtJ+YWmMxQuewtmToFInYS+i6dFFZ
	 z8smAXaGQFgwpCM7Dg/D0JvI2kvZz5bdOvrD0gQ2tRAcT+trcPQB1WFKj4S4PZJWYQE5q
	 RoOWXIPXrRd0PXe1N1S60AwTNIOOl7ct3pjewBnWDkGhcKo62KjJWZ6xLNHD882BYuQtn
	 DQRjcXsI1dHMa01C+JAz0fA60BoP76Fhj7Db5ZkUSyUEnvoC19AmEH7r1EV6+5kRIXir4
	 EFt5MVZIBZEgPycDVJ2HERksXVC+kLKVTUyzsFoMUyfBTkPi6uGrvdtkCI093e0Q24w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793009721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
	b=JgFLnTHSn2c6A+Ghs7c6QKqZnOT4IRTBWFQmqs+IllQkoeGfrqv4rOqgq1D0kaCP1gbK
	 v1I53T6uSVPb8swEAngybKAcLsUytNKVOCtL3ZsyzFPOCUYNm8+4x6jnRgSM9eyMcNAcz
	 qjycTfQEmKSCZGHzM9UWFE8/ISYS3k90jcmfztNerWtUsE+cpOzWpeNSWBaloPqsWvhZF
	 MZJc8aW3fwLGXCcDDYIfuefqKe5mpdB+jHW3QZBgC2oRz4BjRlO69LmO81kpERf/95kLO
	 iCg4muZsXnrt/hcsZbCb4D9/fv9HV5YzlSsvAAd3dEPpKrYyLYqtNUFSH1+T7iyYqqQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793009721;
	bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xr5byWiH52HTaZStr6ZyBmE5ZHlHXZfogOCVKTr7lhgLhANlpqWgKm2Hl6wz4yrtl
	 wWRGdvNoTRK6xPxIzGxSdm7RZ4zYHWcv/363t96ops4/paPmJfuH87Qmto5MnzMYh/
	 rnyiJV/V0bRJixHcloGFddsatCG/fDfTs9yQwCDujnkcEg14BqCsj0KQgFQs85Ko3N
	 Tnf+/9QV/6WY7t8HiPb7mCRUh9UmcQl7nS9N5CIbbDwbngrVXhKX72He9Ct21ti5bm
	 lCEwjnlUl/47ISIvSb6D0BFZxr/c/b49fvVeynD90DHJu7Q85XWNVBu+1H/FtnKdzA
	 YtzILbzCNp+gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF8BD80D48;
	Mon, 26 Oct 2026 10:15:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C34B43B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 10:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A96A5405EE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 10:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teBJTPyP3aj9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 10:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7BA26405DC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793009720;
 b=io8QYshfoAs+EUxBxFblf2OfP9OfIPv6TZ3sVJuId5bBqlenA1/pM2wRM8ZmAcSrP8II
 Z7VI8anyHnOrTfBQmrIELhwJP/+oT5qZYT2U/dcRRo8mRQqfb4HKRDu/xOxVQCHpOLt0I
 Et1pbT0XcpgNAuj5f7T9yicx20D9EkDMbXmDU5Hjd3dBGa9ZVg3mrg33fW8fAC7dUhYo+
 PJN0wZywP/+So8sl0pZK5omlH7cLmsb6+snlcBt/Kx22o67rZNnWrlydxeln1quepgLDf
 6UQ4J2oBemVFwIYfKmdMWY/34kKyXDkevgGwK45Vj9VkyhoTDiCVDvpfWsvT4qe3zkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793009720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
 b=KbxGuij3IDtsOyymovlC1AisLY7ZhZ5EERwwGjrZPCDEhr0f6oVtt/Tu2+xVkdm6l/5T
 9noQnmKatM1d7vInd6/gA247+8mT39afXoVhQJPBIyq5ym6eoRoDJBwYnDjq+5GX8yjtk
 OYFmp8OlCOsZ+ZvnDbVToVHZI9GYMh7HmQWzUevc8iMKA3TM0rMr3ISzeyZr9xhnGBFuK
 Wcw4007uR6JkxYydcIH5epCPrGTlfMRrIlJ7L0h4zFQCPz0jTAPqRGGp5g1YWUkF1Q9Nb
 zUh+AMmf5TJqcR5gfoJ8ZNiY/VBVik8XL2jGby00mHBfEC3vAnQC4IbVxxGZI0La8gw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DScpJPv9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=b2rancourt@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DScpJPv9
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BA26405DC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 10:15:19 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4956869750eso18365315e9.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 03:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793009717; cv=none;
 d=google.com; s=arc-20260327;
 b=GkE9ezWLUWjFhNin71hpkWxXejiE7/dK2GmKDBWHC5YcWT3/1ujlD6Uwmx8agC6WaI
 XwyDTzIx3/+IWz4Q/0hukOKlFUO0LzFzToNsIBR60MmvqCrMj4RmzJJ3rOuazYccejAy
 LT20QPFS7/iBiyltEbVZ25ZfDoTFKXIWsOREIXXD/N4NB9kvsilRkX2ozAdtPMc66VAd
 ZUAaU+PPRUEFihwu0qWpNHIEwCTgvGTCZ6bGLZdgsZodEinfwdHWfnSvmItmVK/PAJ++
 EY15s68foSu2FNi4fryZJeCb3OYU5WG1qc7QcywXaZGz8FTayXwXK79E47XvdWsqW+yj
 X5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
 fh=Z4Iaf1dWPe6uIZffNMJwrAqXwiiJweLZKVqKtZ60OMo=;
 b=nmf+PCWMHn1O1XGWTlHfSqMuUahqXZfV/UQSv3h6Walf3jUGyhym7fRtBpbjq+dhOK
 Z9qarEjOi2NBKbcOTQ4g34yGvQW0SqTc1ty+1yEO3CjEz2qb3F0B1pi8fjAjI5gumIuS
 lup337IOzUB37hpmayi3ef8aUmTE3Len5vRagVZ09PFA+JV4rwgHcZNM0QyD2ManG+5+
 VFWNIDJ/rLioDqc9HzEZVG2W7FMAzc1kYDs3ckfJrHhPPCPmFPfhFs2RU9O6+C7QQK/k
 b3/dkAG8QymXtm4lrTMMbQX8Ye7EsAniWrsML18VHT8HfIzm8Xq7e3OPk8cNML9l9gC3
 N5uA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793009717; x=1793614517; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
 b=DScpJPv9cayHTJuhBXW4snUodde8XFvPu9kYPYju2xfyyA2ismOrbJOLrQtAdKkA84
 4GISsrC0sJDVgpgFFvabeDOK4uAB0K2dyjgRM2KUOSr51ere5gZ1CVSdw28t2ZtYJz71
 4rVTllpBfksAna+TI01iC8h5xnotpiLY35SFWAXzWG/Op5DnAwYslcW4FH79uR+gcB7O
 vAo+LrIDEC5o2yWTH1QmHJl1Zn29idTcBgLry/hGevNrZu4G9g1lrbH9wVZC38lI6f6k
 X6VlrpMzM6CXESz/FuVIa+xEaaAZWsuXMop0hZxLgsSP/OL2aP+uGL6PTFC4CCABlnqX
 pzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009717; x=1793614517;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
 b=jCI3DRczgrAfXhPiYiISGeMQElQgtiNup7+nuMf/F1xirDThFkYStkApn/Vt11DdcR
 6F+cokssG7n+jHiHK8p4DbJxWbaQlXGlnrLEgp7V7nP2A6phXHPOgNMfo+4p0UefY03p
 xMcGRHGqHQ58zMXSaNWhYGU/3IIbXKgIoP8aB2plKWvmKLAUU8z2GxhW1/HWW637cemV
 IOzCAoeyrFhYNpfUpnKwN0h1ee+L/aGy08ycO/nbU/0nhXISJSOhw7tKd/Mt/mGpjXr0
 73VorV7PUBQhxA9co5Lb8XHgxacTJmkMx1P9tAKFFm3NCQfNHs0t5MVM4ia2R2mOHG77
 EMiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2IxeiiiAnW2tuvYOCDNu5wbxDVHgFKhvSyH3hDsONCGPP8um0XeywZkS+WCnP5XJAhS4xmLQXGHw6obgxE38=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKdi6v5LlidQek2Wd92zqSuN54bTjH9BpEGtLnTBxKsNmzDmqer
 uiaIkPmCNu52ayuoCWy26fN5z4jYX5Zq0WwLf3XJyn3yR/b97xYfwSErIf76BsSkIr5F1L3y+NI
 JQ8VVCFWDcEY7A2Ugyzu9oGp7dSpnxGA=
X-Gm-Gg: AYBFou32UmtopPcbEGU2JV4wxDylfGrrAFXzStXb4+JKyHqZ0kuFgTPLP0RVc6hLOsv
 PMyTy4DYcPdBwk1hs6/W4z4mGveux8EqKOqlypdn4c9TSuUetn0P4nuEzIDh42VRRWMrYExRZ3t
 lAfZQ/KuOdY+Xp2wIMQ3iuksJPJIsx28ABRRYdXPrgkOLVGE8aSws6kt+w1yeyD4lZbNcXKImFB
 EmsKDCIQoGo4Q1adoQfX0360jgbtFAtVv8cKFItIk3fLl5kDd/vvz3MKvWoxghQYxhjV59LAzrT
 OT/AyM369LEfSzFt9xTMiDVTE5Tv5ixGVOjDPZoWIfDvWpTOTfMwHV6I3bhnmR4SGTrkFDQp0pY
 J1N9oADqwTw3CJkmsD7v2KBPFkeb9Q1d2YdGrWlucLMZc2PwqHswSiPBTnooQvYRrGlufRUdFI0
 sR9kaCHfuSKmEFIo6Xw54Wux66qor3bKzo05T3jPDvMYUrA/AcR7EyErtKsN/mGWxkUqCItIPVk
 FGmNIZ6RkPYdA==
X-Received: by 2002:a05:600c:a06:b0:4a2:40:7f35 with SMTP id
 5b1f17b1804b1-4a35acaaacfmr115694155e9.31.1793009716860; Mon, 26 Oct 2026
 03:15:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004152840.61222-1-b2rancourt@gmail.com>
 <e8669ef4-1b3e-4429-a6b2-db4c6a734f7f@intel.com>
In-Reply-To: <e8669ef4-1b3e-4429-a6b2-db4c6a734f7f@intel.com>
From: Benoit 2r <b2rancourt@gmail.com>
Date: Mon, 26 Oct 2026 11:14:40 +0100
X-Gm-Features: AclHuK8a3o2txfU9CppftX-zSmZGF88PYoTCRr2FEwkGvWFsn1ZWRvLH6WvAKpU
Message-ID: <CABti8MHmpc=sY5zE9Hpdq4OP_-Th_E7O1XQi=Md-aznGQmtikg@mail.gmail.com>
Subject: Re: [PATCH iwl-net 0/2] igc: Fix Tx hangs after NETDEV_TX_BUSY with
 TSO
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sasha Neftin <sasha.neftin@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dima,

Thank you for the review and for the explanation.

Yes, going with patch 1 only is fine with me. It is the actual fix for
the problem I hit: in my tests, it removed every NETDEV_TX_BUSY return
and every Tx timeout on its own.

I agree that patch 2 is a broader question. The same pattern exists in
other Intel drivers, so it makes more sense for your team to decide
whether and how to handle it consistently across them. I'm happy to
leave that to you.

Thanks again for taking care of my contribution.

Best regards,
Benoit


Le lun. 26 oct. 2026 =C3=A0 10:04, Ruinskiy, Dima <dima.ruinskiy@intel.com>=
 a =C3=A9crit :
>
> On 04/10/2026 18:28, Benoit DE RANCOURT wrote:
> > Since commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first
> > flag bit"), igc_xmit_frame_ring() requires count + 5 free descriptors,
> > while the queue is only stopped in advance below DESC_NEEDED =3D
> > MAX_SKB_FRAGS + 4. TSO skbs with 16 or 17 fragments then hit
> > NETDEV_TX_BUSY. That return skips the tail write deferred by
> > xmit_more, so the queue can stay stopped with descriptors the hardware
> > never saw, until the Tx watchdog resets the adapter.
> >
> > Patch 1 aligns DESC_NEEDED with the admission check. Patch 2 writes the
> > tail before returning NETDEV_TX_BUSY, which remains reachable for skbs
> > with buffers larger than IGC_MAX_DATA_PER_TXD. Each patch was tested
> > alone; together they keep the queue stop logic consistent and the
> > remaining busy path safe.
> >
> > Setup: CWWK router, Pentium Gold 8505, six I226-V (8086:125c rev 04,
> > NVM 2017:888d), 7.2.8, default MAX_SKB_FRAGS =3D 17. Load: CPU saturate=
d
> > with busy loops, a remote build routed through the port, two SSH bulk
> > streams in each direction and short TCP bursts, 180 seconds of load
> > per run observed during a 195-second probe window, TSO enabled on the
> > egress port. bpftrace probes on igc_xmit_frame, __igc_maybe_stop_tx
> > and igc_poll recorded NETDEV_TX_BUSY returns, the inferred last tail
> > write and next_to_clean stalls.
> >
> >                         runs  Tx timeouts  NETDEV_TX_BUSY  TX_OK return=
s
> >    unpatched 7.2.8         3           25           10890       7.3M
> >    patch 2 only            3            0           10751       9.5M
> >    patch 1 only            3            0               0       8.8M
> >    both patches            3            0               0       9.4M
> >    unpatched, TSO off      1            0               0      21.5M
> >
> > In all 25 timeout episodes, the stalled queue had pending descriptors
> > after a NETDEV_TX_BUSY return. The probes inferred at least 214
> > descriptors beyond the last tail write. For that queue, the hardware
> > register dump showed TDH =3D TDT =3D the next_to_clean value recorded b=
y
> > the probe.
> >
> > With both patches applied, no NETDEV_TX_BUSY occurred, so the flush
> > path of patch 2 was not exercised in that run; its effect is shown by
> > the patch 2 only runs.
> >
> > TX_OK returns count igc_xmit_frame() calls returning NETDEV_TX_OK,
> > excluding NETDEV_TX_BUSY retries. These are software call counts,
> > not hardware packet counters; with TSO disabled, segmentation occurs
> > before the driver.
> >
> > Related code, not addressed in this series and not tested:
> >
> > - bnxt: commit e8d8c5d80f5e ("bnxt: make sure xmit_more + errors does
> >    not miss doorbells") rings a pending doorbell on the drop paths. It
> >    leaves the busy path alone, reasoning that busy can only happen if
> >    start_xmit races with completions that both enable the queue, in
> >    which case no kick can be pending; the current code warns "ring busy
> >    w/ flush pending!" if that assumption breaks. In igc, patch 1
> >    restores that property for skbs whose buffers each fit in one
> >    descriptor, and patch 2 covers the remaining case.
> >
> > - igc drop paths (skb_put_padto() failure in igc_xmit_frame(), out_drop
> >    in igc_xmit_frame_ring(), the DMA mapping error path of igc_tx_map()=
)
> >    also return without writing a pending tail, the case bnxt fixed in
> >    e8d8c5d80f5e and 00eeab0c644a ("bnxt_en: Write doorbell when
> >    linearizing skb fails"). The queue is not stopped there, so pending
> >    descriptors are delayed until the next transmit on that queue rather
> >    than stranded.
> >
> > - igb, ixgbe, fm10k, i40e, iavf, ice, e1000e and e1000 also defer the
> >    tail write with xmit_more and return NETDEV_TX_BUSY from their
> >    admission check without writing it. Their stop thresholds match
> >    their admission checks, so this should only be reachable for skbs
> >    needing more descriptors than the stop threshold assumes.
> >
> > Not done:
> > - runtime test on a kernel built from this tree; the patches were
> >    tested on 7.2.8, where the affected code is identical, and apply
> >    cleanly here;
> > - launch time (ETF/taprio) and XDP/AF_XDP traffic, which share the
> >    ring and the wake threshold;
> > - longer runs and other I226/I225 boards;
> > - only the igc objects were built with W=3D1 under allmodconfig, not
> >    the full tree.
> >
> > The analysis and the patches were prepared with an LLM-based coding
> > assistant, which also wrote the bpftrace probes; the results above come
> > from those probes and the kernel log on real hardware.
> >
> > Benoit DE RANCOURT (2):
> >    igc: Fix Tx stop threshold to cover empty frame descriptors
> >    igc: Flush pending Tx descriptors before returning NETDEV_TX_BUSY
> >
> >   drivers/net/ethernet/intel/igc/igc.h      | 8 ++++++--
> >   drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
> >   2 files changed, 11 insertions(+), 3 deletions(-)
> >
> >
> > base-commit: a83267db14681b3be481e02a4d5a38177507006c
>
> Hi Benoit,
> Thank you for this fix. Much appreciated.
>
> I wonder if we can go just with patch 1 for now. Reasons:
> - As per the analysis, just Patch 1 resolves all the issues encountered
> (the corner case resolved by patch 2 is not reached anymore, although it
> remains theoretically possible)
> - As explained in the cover letter, Patch 2 changes the behavior in a
> way that makes it inconsistent with what other drivers are doing. Maybe
> the new behavior is more correct in all cases, maybe not, but in general
> I prefer to avoid introducing inconsistencies, especially when I don't
> fully understand the effects.
>
> Best,
> Dima
