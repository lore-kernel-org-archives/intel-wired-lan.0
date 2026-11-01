Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DD606A324
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Nov 2026 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LOkRXVYT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tas/gGhe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F067140674;
	Sun,  1 Nov 2026 02:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otOTf8_vpSxL; Sun,  1 Nov 2026 02:38:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 526844064C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793500712;
	b=OoaHdCy4SrX6R9dqK+0jpf94B4O3c9GgBgUpf6Bq2s9TrBi2b/DhFgzxZZsXAb7Can8o
	 DMycXvhGHu468VXoNHMSAQSHSCARjPXg9tqJgNTXVKiSFjPptmImqJsGI6ByjW5sPuOle
	 b6uSjDniwMuTKjpg/53QQZ1Us9PryhODqvPcNQlwBasAqomgVcu5o3JZTxxujgY47TUUy
	 aq6QbKO9TUgiUim50JJoYx6/LfZKr9f8h5HD6zWvPgasj5w5GKoruhpuvpgHsFSePV86r
	 caQuej9MKxztLA1og0CNRKoETWS2qLD1hTRmHtTuyP3cNZWlhxHP5Ro1m/BqmcJzleA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793500712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
	b=adt3douOZcTfKnKp4rj1qXMWPybweArggcZ2ePthSn2w7cdJiCO+k4QEUbIT2bLXJt74
	 UPm0pwS8IKodqBmPd0bZWf+ZLgnI4O4kyAM3hd9t/114D9GKrozNTpdGAo/YyqcQqLeA3
	 eSRfsB6Cs3oSitiCpIHizif8cxRhohuE0LAycf4/maH/Zw1WkYUM4g2dpHvLAV6dnxpFd
	 /KLFKNylrHUv38NLENYF8d8etTfBWf1qd+7rmzYbFd7tCtu5RyJeI8W7G9VijO9v7rxMY
	 kMPWWUeMrWWIVKP36rlbhRywf6xjD7SF687fZLAh/V6wHXZZFN6qBHeNatUQWFdrtUg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793500712;
	bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOkRXVYTU2pHmeB7gUxwEf5zD/MMmL4Y/OK/XT7jVSDrYbGpvrKFgbS5sSJjT9TIe
	 OAp9aod+PXNdhgdUX6o0Fgn9/K9qvk6HotmMo2DRCF89VtJ3K3C9XhRBPLf9gFxOwA
	 vABbacBxLhzUiS9uHiZgwbG6perZCLGZhjsRXxGxSpl9lCe8YRLZVYB4p0S7LaWprb
	 IogPxcGOzst3umNBB0qqUTzl0U+1FD6myTJwCY1i0NAtoByn3ccMtKS/ClrIpmXTwI
	 5/U0ExrTcRzRHCVT8YYLYxm+Ui6BnpbBTGWKpcw34esrCVNbhklUjGLxziyBfFlsUu
	 WFUINubDibj7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 526844064C;
	Sun,  1 Nov 2026 02:38:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEC35156
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 02:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FB1380E24
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 02:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jt3z9_pwFoIw for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Nov 2026 02:38:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2DF580E22
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793500710;
 b=nu5LrSVqZRTM6zgtmakeBXjGPfvhb5dhOmwZ0zvGgDzmftiOvjXVhKlvn2PmNrMbZuX7
 8jgmo+KiPEj2WemsyXexcVSmX0IkeKuLVYYHsKIUCOiaWmbbLkTAUcLyK5t7i4ED20cSl
 1Vk7D6zPGIV1+cNgrX1+f4RWge8mGfQ8dndHcUpvoe5SUVSC/h8G3e69jRk20zkMwAmIj
 8w5/CAS/SEYO2NAMlULg37wm5Dta03Ifl11wQUIMIPpyECD2iwiivzK3yhDVEndgvtDgK
 N+hkpZ9UC/GCoPP6vfbNEMvWVrd9UFyhps+WhmiXI0x/I4RDcfWk2nX73eON6KM2tuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793500710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
 b=alUH5wc4Lu0L3rxVHFNBUk+R2yckDclcywNT5lrrU90izES/L6qSKsChDtQE8KBO1PQs
 UashkZqKF2/VodnEJmhV+y61vV93G0cbXDrVnohaaRBfojD6ln+DDZokB1JuVj1WodSCK
 vAFhc0iXti2QxXrxHWOrM+4rX6lbLxs/2e14IyEA/IgNu+6hxBCnaBU6+6X70zZR982Ia
 9xhSK+1BIrP3CH9wcra5fvktSrm4GqHs80SzZw8Jenutwa/3/fXlKERneH0/5HkMEf75f
 Bh9WyPLPHjJpig5l90hf3GhkmTPYaJ8HBo98pcQVCjvj1ib6ikavbBuiRSY9sxZGGug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="tas/gGhe"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=kerneljasonxing@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tas/gGhe
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2DF580E22
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 02:38:29 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5bfc32574e7so440005e87.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Oct 2026 19:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793500707; cv=none;
 d=google.com; s=arc-20260327;
 b=IVtPvXAfhRss2gERUgnIytTaB94lKRiK07I726be9h0YTStaDenN8lYunA391SoZ4O
 Z47ahqX81ZujQ/dCQcpS8/w8h16Fs5CBBjmAJWVXAHDepulDb/8ykSbP6VS3Qf2AdAGB
 fzpAsxTiPdiGoeP/f+EAa3iQVJUzvDyT4AAHBEX/pq9uAa8gRxSUUzE34dfpPxaCNeOL
 yNXr+ZO8EF4SC5eA/AjHnkStscyfgSHGVM0j65PrqBD+PQTp5rAL+4hrZm6QKKwLG5vn
 65pmCNl5FCKpNW/mV6S+WsiSzCAsGEGKLPkFkFWdUJYEs3CrFl0ZW9SLxOX6DjtSfH5y
 pjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
 fh=nGGMYD1cvAaCqFopfCIoPqRo5Ue1jHQZOIfiMnK77FI=;
 b=rxL+zs8ZkDvx5aRjZg76LCnyMkypH9t39HJ+mpaR4GuKHTTDK6NbS6qgMN1sBXe6Mv
 SVOR5wlp6OCr6pG31iFAkDedl8rekp7AU7wJ+9jqST9JuO5+1nm7GlMqvUPD029fXZBb
 3H5c0PpdFbHs7U/yk6fFpcCGr4DJmVt+RLCFE/9+dskF/kWjgLEZOQ/qTp8XhiTuMTxY
 NbeSKTjl1htmeBuIlfTdN4UPfkO2XvrGQDK/Tay8Q9br2H23jtjQP6WR0p3EEmlRDf73
 QHwP4QekT05GUSl7ahhNkMgemt3YcWg7QSA3ojhwL7HQK5hHVAzxb5/229g54/eE6IYt
 5Ujw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793500707; x=1794105507; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
 b=tas/gGhew+EXdEePajU7i9J+b3O/B1L+mGri00vhBXrst/MZjYfFyd18jjwVeQHf3U
 3nbeqe+IyzanB+aUM7Q9q/yoMyxQPEwHuEhdL02pJzj0D9nwP1flziPZoD/jI2bmzyxc
 hXNF7JAsx0gOlZFlWiualvQIz2ufqeZnOh23we14iKCioaVOX8RSoLKz4cZtb2MDcvCI
 7HWZy6Aqzn2RvuiUnwB1W4xNx3cOsnDNpZtqNrSMv1y+dTSBjvuqhwQvEz5C79wJAeOF
 kLzHUsY6p2qMmtQYpHO5giqy5susLpwzUtMA5fQ1ZBc73beXI7c8sgS2VWC+QQnG6w1L
 tKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793500707; x=1794105507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
 b=OpV/zV+e+Uwgf4YHLlJHUzWL/lVQxgwJ0SC5lBJ9vMAXD8ix5Ypuwswe15+9XzFAjZ
 v/hSVYj3DKZkCqujaFyG00MLMhAhpbtPxyIsUOyvwaEMn1zBBM0uZXL0nvGtLGaKhtqu
 Bmv6OVYotybpSN7iRosIHjJQ3e/WLeNw6CIt3ZMosOxJgo3li0oy1D8T1xarASmx6CUb
 jMUlY/Aoyhw/h0KhYXnynEZR0C3QIXouxRcuV7dzpyWkvZxwi6eJg5hUm8Qw1wOYiOgd
 qChSOdMxnOyu7S3bkqcjajQJXpB0hRHr+VZgd37f3f7WcvOGdIHL4fXFWkzssTcsb6Wh
 cNrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdC6+aWZqGkpbjSgZL5Uxmp7n74NyxSwsQrZjpKj+72HL6Do5TD4iqtyG4VvAM4arw7KebQ3kGpZyytT4eqxY=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIrUGefPGGunTveeaQRAKy5SXvPm/WcInTQRkNgyDVO5ncB64cR
 HNm/dGFty3aEjMyyg/Dd86NZ2anEjgkczDQ2Q+lTqcnGfkUUXJ810pfS2q7yjaBuk3zZSxd2BJC
 ZLR0+BXAOYLpxe/2Hpx4BkE2LeJvwqWw=
X-Gm-Gg: AYBFou2IjJsd/CzieSsowlrrlWVkBHvBvmDEB8RuHfsGdLzOax1ajLLwxKroto0imoI
 GekfH86RViTVGYmoLgPmcEzdABnHlBVZkgwD6AjjURa9Fz6vAxAQ4WcOo6q4ezbPDMRFczgvMb1
 KOcVUt2ZMx0JvdJCcsNNar4JrslKk7gBAY0s+zgzFZGSOarZfVY0Pk+yVyED3fSNsg0FqinnFEs
 bYo+gx4x/RZbsyY7Qua/tP6KK9miBHSsY3Wy/QYSEisCLzFwlKemkyFL6XW1Y92PAk4PONRl8gl
 VzGxJR471SFMnMKmhdpTyiHmeoimSxRrfmtE7ICK7cpOprtMJmylgCFRdMnpaJ4o7Lw5a/8zKDw
 LW5eRCUTAqk5s1C0P1CT6gCNPmTxNvgLR0Ghll8y8Yqnrd2LK52wVVqTNnDNbRfD6uEHPprYgCs
 kKXyNHi5Umz2dkoyP7IjmtMKfmh9l8Vb7ux6cm+J47l5Nw67izSps=
X-Received: by 2002:a05:6512:a96:b0:5bf:c9c7:eae0 with SMTP id
 2adb3069b0e04-5bfd9564f18mr1864662e87.4.1793500706846; Sat, 31 Oct 2026
 19:38:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Nov 2026 10:37:49 +0800
X-Gm-Features: AclHuK-w2Xb5r-XGPIWLPa0peqPZ35FQ_khofZikgGeMh4wAdy4AzH-tS50Oovk
Message-ID: <CAL+tcoB=SG5WT0VrkhuPp_5VYtFHWDFhWMCNM421WzoU4z9=9A@mail.gmail.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
To: marcin.knap@vecima.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
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
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 4:16=E2=80=AFPM Marcin Knap via B4 Relay
<devnull+marcin.knap.vecima.com@kernel.org> wrote:
>
> From: Marcin Knap <marcin.knap@vecima.com>
>
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
>
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> most drivers rely on that: mlx5e treats the failure as XDP_DROP and
> releases the buffer when the Rx WQE is refilled, while i40e, ice,
> ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
> buffer is therefore freed twice. It gets reused for another Rx
> descriptor, the second free puts an in-use buffer back on the pool
> free list, and the same UMEM frame is later handed to user space
> twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
> -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
> after the core has freed it.
>
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. A few drivers relied on the core freeing the buffer, so make them
> free it:
>
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the already freed buffer. Free the buffer and
>   report it as consumed instead.
>
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
>
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>

Agreed with Bjorn the contract can be documented as a follow-up patch.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
