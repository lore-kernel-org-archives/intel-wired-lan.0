Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCA606A31F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=f8LK/GXo;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r8XTKfSb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C09A607E4;
	Wed, 21 Oct 2026 15:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zoc5wTvi6EcP; Wed, 21 Oct 2026 15:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A14D60846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792597846;
	b=ZX+kg6n2CYJv6UYH1aW/OboZOB6wCii7ocQpRK0rEDn0ws62GmqeVOZXEguSwhrhUhfd
	 H0RYxYk6TALiaipfaiNnW+k2HfhjPHEWoZfy/fmgHBoeP5jEF1DLnDTf+xUhsFfAf9Kz+
	 AS+2rrFjspuaFP7c0OmqhLGE64c+JB/qMdVDvqQHwtXv+kMAhgo7YZ/EupsL+jRRRS6Hr
	 KrCNWQM4fsENemyhLtNM6aI3/Mot7VIUuhliEVzW1UpfShFU5RRpawq6+FOEZi0pqVCjn
	 1pS55VmHbBh7fJK0XgGjS9/82GEBSH77esHDtdROGjd92PKphvysA83yBKbDQZndzVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792597846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
	b=BgCHiTVbSzI7W8OLo7wsuE0S49VpQqTrBJxLV3fm7mzjaEBmUHWRGvqbx+F+X/94Xrnj
	 kR6q2htz9dBvh+xzbVaaJUhn/1BcXtgCTi2cDMZBecMOjVJ/RQOUsPrdJMTiFmSYBBb3L
	 CYGZZW8jvnJsFZ+K45s5yTatQriYVV7y6YZFXY8R2nMnCnpbiIp9mGwQvMR78NZVGtloF
	 H1qJ4j/HsXvoJD33PmbyWH4f65uI72Uvj7U8ZNucFbz77tSvhAcIzlfx720i1tv41esvf
	 6Pu4YGncyLylI1BJRAmalSoxBi7oB56RSI0Q6Vez+lBJ7FKI9MJe83p8WCv1vHfIZJQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792597846;
	bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f8LK/GXoEK+ITps1Ggq+OMW/QtuvIQl6HOAoZ6ePJU+4+FvGVQ3oboTkt5lsVnVIe
	 vfgi0iz4+Yv+wMJT8r+Vsc0BIGC3CC7YdM1PBME7vaeQRIbJTIDCqW8JfJ/kTgQUeM
	 8LtMF9WI5i/Nc3DhkTOIY701UoFK3BMKFvFNAEmYaE/XZOOJ3/EICYMiAdGbcx0OE6
	 MSwPkTOrz810pPsOMrNSxnM87GIJW+H/xY/RspAwDb08Nb14zaVQagxWnqI3LmCtFA
	 Xul0oB+4A8dPnPEsJf+7l+2QgZXC4PCOz8UrKXh8QNc5PDf0yBMRmjDAAX88FeQuBM
	 GEibd3cTUfWxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A14D60846;
	Wed, 21 Oct 2026 15:50:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21D28930
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 15:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C27C4016B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 15:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQ90rnURPnuQ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 15:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 13BBC40077
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792597842;
 b=PXw/RgPZaaW5oFSy/XYc9coPoueAeCdQgmKdJLGfD1yXHAs/hnmWQFztYTC+hnduhg9H
 EhYpoUsq+rJV9QDVdbTU4/NFPj95rRwlRuhN/5Su6fEuoyciNmA467K2YyOINF2CONky1
 iLErJs0n9MF0eQLAo/eFIY+7yy6f6N0mudAYW9zYiqQEM6hGXC1mi98f7h6UP42ZdBaU2
 KPprM14V3YL8oFbAaxZXNjPnNNbMZumBXqAf9UDBo94OZ/f14jBKvMfCLqKIs3MJB63r6
 ZScj43+nbbn53o9cpBnsOj6aJUF9QmgjVC/xhdrCcNGId1pNRu8msPVPvpN5K8pIunQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792597842;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
 b=SSzKmEbKOhBRgZMdbvkpIOVTqqTjRvaaUbAarotB+52J87v19L058JBn3x9cobcoy5GN
 TL3zx/N2cCzxLPXoa/v5vt3IOjahPE/EZzD+RYDEPpoGq4ZGhCHUHlEtyAt9uhosxMBIJ
 dBOaWs7W1e69KyLfmguf7FTVZxNfKgs75TJ1tKdI/7riR901ZTXxBZ1d5d/kxbO+PQi2v
 Gy6WX9oTXNlGcwMHIVuhvMwfKi6wnmyUI+HPCiPPmgbcUXbfQ3zN7DK+QizuDAJOEWdRt
 SGEAZg/6fwSNnuks9NwmbsYkC7uUW5nGPW2hN44T9oJ7VBA2m9hMY51wAOmU024np9w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=r8XTKfSb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=lrizzo@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=r8XTKfSb
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13BBC40077
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 15:50:41 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e9f6a16afcso64405ad.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792597841; cv=none;
 d=google.com; s=arc-20260327;
 b=OZFfpZZD71ON+MPDp18bY0cdguIwdOYTgXfc6que98M/R23vYCgljkQ9urK79DnUN+
 CjZptQbbjsLvS9fNT4VYa945k7zctbHI0yGqyD3nK4hLNpmaWFygPZUjB3qyeg7SUe6a
 iWBcoG/3GjiemRvS03DaPzVHMbMeLawyClwjAbSdjIPXztJLDwX3lT68oMycMCmsYHpx
 AOjBMFe0Dftu2wY7zMwHccr7+zuDfw8L1bx5d64wLk+AyRESQP1PkssVUl+VBgzq28hw
 AxJfazuymqD5KFN1Qc9xJxP9qaGOfzGvlI8l3LQp1Tmr6ZZSJULhpYLOctdzudK2bPBo
 4arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
 fh=HgBva3Qx3FhDAmsoiyeqxhN/InxxWWhzTbfG4zVbXbo=;
 b=rdnXk96M98gbvHIWAds5am1gTxa5xwQSz9g1na2RpCY5h35asiRHOzTVPR9CzcUQBx
 cUlGqY+2YsspD6GhKOycjgCnytJm3+HltS2PCCA9238B3weTT7HcJPejiINuGMxIJE3C
 xcDJDb9F9jJNK+TIzSuvFBgRT8TJviqL1my8QNyW8/kTyI4+ATT1gqNigfrCuP68PLAy
 O9pLjdNIFcuQFT5KYhxvLIgZY6r9/W57U1AS4LoCV8ujC5J+BSZq89BJfQgpAQaH9MkH
 rvlSG4yING8fXQqzB/Bfoi2tkfxIypYhp0CNbtHtJyEJaQpNBlRNFlrq1ov9+FJ7tNWS
 FfZw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792597841; x=1793202641; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
 b=r8XTKfSbUFhj2O+8JkumTD0oFpJjpVs9o5JOlxz5pPsoXtdg6uF3nfZ8gAI/Gz5JNO
 yjIqT9VhNLb1evzbcf7nIe1L0LFqxkqm/F12BewZRt8F9u9rMYp4v5duecTLG8nqOC33
 oNX2cznZalbgIv99VgHCLlIuLmd5hqZI9zqlpOhYo8PUV56J0BD/31i+l7UUVns6kkQC
 8RG164E9FcLAAYRaDi1lC0pX1zox7F8X29VayhgQDrFB0z/fP0021WwMEtfWdlVxSp1I
 VPRvt55TojqU1C6ukJMgCvNE7JgKO7SkfPJI6MJ+zZz2fxWb5dxz/NUnXpWu+AeUUjMY
 Iu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792597841; x=1793202641;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
 b=fH5647umKoEVEH5MV7firRdMb+W0v3jtKiiugi8XiL9qldt03wyhzEXqLkkDqYd0b3
 tTdHvA5ik9dYLr8v/YAjptag7sqJmlCLE1qkK1vfqxgtyxZV5NkykcpyPgetNNRj1b9j
 czkNgm5Q3ZDS3Sl2x5lNyZE2q+1BtgYfFu0BK/oNTONziZ371I2EA94jibkotEwGHUdD
 RPiuNwbAd3xBB9B4nV91fA9cCQqQlgL/bca8n9oN3WXjWgzmbAAGE/0yqfgZBybkNqBv
 rhkm3pyMT10h3O7tqHEer7o2nZAWqWfKH2lUubK2JmWvIvYVuHiVIhGKS4i5ewpTpVJB
 7TGg==
X-Gm-Message-State: AFq9FYIMfwWjpz4g/3nCzhz1ueDL19Wi2+0zQTuT11Bye0ZYHCXulGSg
 ItYvrD8IzjPr3dMbo/2uJ1BvgR1MYwyOFLEwzjKPwIB8R47Z8JcA0LUJ34HLwdBbw/cCtVuMuSS
 aiX6iDgCrte2YQABJM37LHobWSd0JMbIwdiaE6Sdk
X-Gm-Gg: AYBFou3Sdo78CgpmW2BKaji2EpHNbXJtNIfU4/airhu3hM2fcmomMUPl83Rz2kEmytc
 YVp6aMX6Yf2PKJZpnIIH//I4Qa2vqPK2HLCKf1TF1fUf823DrQ9Ca1z0hGjw3zwyknOu6VcaYda
 jAJJ6d7b4/qfw+E+PUZSUqcUqvB+QDqZfWNjc0mUkNVMZWOrdQw0vc2d5s+FcxUFMp8xMm5u8bY
 C7HjouTHo0afHeL3p3VHOylvIXqK1EGYt+4Xmqbv4Z4rtM1wTsIglXBZPV8ShaFjCmmh8Azn5Fv
 X/n6SmeJvK2gJJD34xaKB8RFk31SYUvtz/xtpn5NsPK7ADDNr5Pl2R4bCVCBNY2hLaHxiZ+lRtw
 bkwFuPJ5B9t5u8QcdD5IxGzXIfB6H9PWhxfuq/w==
X-Received: by 2002:a17:902:dacb:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2ea1ad8e5b6mr11446815ad.5.1792597840207; Wed, 21 Oct 2026
 08:50:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com>
 <c599f939-0308-428f-aeaa-fc990446cea1@intel.com>
In-Reply-To: <c599f939-0308-428f-aeaa-fc990446cea1@intel.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 21 Oct 2026 17:50:04 +0200
X-Gm-Features: AclHuK9FmBdcnW_p7t6lt2QnH0JAdG8PU46GyBiVJSlHu7N5H8oC8Cumb4S0jYI
Message-ID: <CAMOZA0LrxfP3zDCutahGqRLuS7ueCppbCT7Oi-h9=xwAAit4sw@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
 Brian Vazquez <brianvv@google.com>, Joshua Hay <joshua.a.hay@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 4:57=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Luigi Rizzo <lrizzo@google.com>
> Date: Mon, 19 Oct 2026 21:06:02 +0000
>
> > libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> > driver fills its Rx rings at open or on queue reconfiguration. That
> > fill runs in process context, right after page_pool_create() and before
> > the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> > needlessly restrictive there: it can neither reclaim nor compact, while
> > the initial fill can allocate tens of thousands of buffers across all
> > queues.
> >
> > Patch 1 adds libeth_rx_alloc_gfp() taking a gfp_t parameter and turns
> > libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> > Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> > to GFP_KERNEL.
>
> This is done for simplicity and performance reasons (although I've just
> realized that this helper is fully inline, so it will inline your new
> GFP argument as well).
>
> But could anyone explain me why the initial fill is bad to do with
> GFP_ATOMIC?

It might not be so bad now, but consider something like DMA-PMD
https://lore.kernel.org/all/20261003212241.3432303-1-lrizzo@google.com/
that allocates buffers from larger chunks to reduce IOTLB pressure
and iommu-related costs.

An innocent request for one buffer could cause the pagepool provider
to request a higher order page, which in turn may require some
compaction work and sleeping.

Using GFP_ATOMIC could cause unnecessary allocation failures
if pages are not readily available (and in O(100K) allocations
something could easily go wrong).

FWIW other drivers are not very consistent in their use of flags for
initial allocations, but I think this is more to simplify code reuse
(as you pointed out) than for a real requirement.

cheers
luigi
