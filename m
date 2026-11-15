Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E17606A32F
	for <intel-wired-lan@archiver.kernel.org>; Sun, 15 Nov 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0Fz7Mti/;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CeH/9GGQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6B4F80C47;
	Sun, 15 Nov 2026 23:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xk8dkmBHAuQW; Sun, 15 Nov 2026 23:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC88280DC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794785810;
	b=QmIlLGsdg5KEix+moKp5fWl2nCoyylmC7jp9r+bvwNtEDYzXK2RDAnBVgDKjahL67hFZ
	 o0wCGujWzsLWyVnwlaSPJheepUSjnvCu0jg4kSH0j/WtsUXER1s2X3jueaJWqkSuzfgQu
	 pTBwF2pDbqIBAuvP4TZgeDHfz+QIGzoEq+gSd/l+39dCIvi4INWBEJqKe8cGtKB2AQDrR
	 rSus6DAlV0/L0WJCxNdBFbWcer4aYnfJuIkQcIhcN4N0tLtHRqCJ6HzSsw4oAX6H0qfT0
	 yMlvXwp/ua6jM3BA+aFAtZ5VzMSNYvZHK2+Z1fzFmmiQBJ5HrpdEZ1B++y/LmH8bP7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794785810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
	b=CD/0H06NiZpU6EaxnNMtL8NVf0jiEqjeGjFhR068Jp7pyLCcx/KlnaoAaAl+NkTksdcV
	 9CsZhme0QRl3y9+p7u4iURY7db0f7J2n6WY5WgRGKTe1dDkRuAGkloytszG8l52wht0kc
	 xn7F+xQIRccy4ypS3TanGdiCODUNqQbpJTBvFHC2pDSpTgT+5dtHIjecBcvkNzEEKd54P
	 RX/H1VUf4Mn64kqAKYYrJO1PW7DKn5S8ePFXTM6oPZEuKTLVyZjC+wO13gIeuKIwB6/6D
	 llDsvpKrafXbSK61tBZFCKLakfTVhgUIC/MOTAArxgPEKvokDcUSZASdPhKd/+gV1Iw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794785810;
	bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Fz7Mti/mIIgTlwV68VK0LBCEo+SPJTai5BZqXYQahi/dZAGMHhNdUt/KE5ve+1r0
	 A0O3jyJCVe2C0tyer2bmHarn8CUWiAahGJG7W9Ls6/oImgYsTM5CuFDgWJBiQe3er0
	 fzFCQiBflbCtgC7VXYInVc6KgYntiS+AngALF3kEcpYOnAJkgefBKx6rSjkhMSx8T9
	 XoxIn8kup3WdAFL1hSUfhgbovJAX4nJV/yve8FoYseUU0ENVA5AVP4zJxVyUcRbUij
	 Kg89o+Gh7gNKsOucKezUnvL5lryzrkoW9lFuCc9zF9XULwuVi56vXRo2O1Mfmm+r5e
	 vLU3/HFEGJDIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC88280DC5;
	Sun, 15 Nov 2026 23:36:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E7E72E5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 23:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BCBE40072
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 23:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxGoTzGBj4sM for <intel-wired-lan@lists.osuosl.org>;
 Sun, 15 Nov 2026 23:36:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C7F9940012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=CeH/9GGQ
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7F9940012
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 23:36:46 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso2558300eaf.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 15 Nov 2026 15:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794785805; x=1795390605;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
 b=CeH/9GGQqDHXXvMXgLYd9ijOJ7Lo71xdjEyeup0Pg1z8qkQe9P+jldoE0ZhuN1XAId
 dnr6qyS21aQQ3fQ8UmAF0+xzPzeN8HvubIe0v4fPihoZ0FjHqFkRZRaYoAyqoGT0AX+c
 xuCgIsvYDkQ7wz7Zp9vHd2tPJFFe4fSLenbU4hX5rwJcWjwKqwKu4r8qKOqxAQED9q+E
 HrY+n3ow13Xo1c6R96kcKjK2rJCajHVsslaluVpYP8Z0SuAgfHqE1r/Rlxs8z7ThrerU
 Ct6wiM9FB1Mku+/iNuXqWKMxdAVBU/g3RPCGOqKiH/n2M97GwdUxCTdLjssQ41mDaMUX
 KSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794785805; x=1795390605;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eiEJgJLTePDasa4fCxlIDYNvy/YXg5RoYnLKMhW0V1k=;
 b=LbGO8VJW7LEHnFqneBzYYn4IS6Nxm+2dFYSod4j8HwcKEBfoez0J0m8kqXDlTkhGdo
 HQOcYXUxAT9XdEGH0JAQw8iC4eaagqwfrhKEJiYFMJz7Nm5o6XZKZ9yueRKtV4PGmQKn
 GZwYTrJHC5xEJlVgK/QY/cHC2wtKB6gizKH56sO7cBkixKXRuVjTnVijKYidMCaWVQzm
 v8mAaPz4e/aOzpaqmcRiVpBMBv4Ss7AezrODmhgSfuITabELmqSCBJGayu4s4o+gelE8
 NWDE8Lu5HmS/Pa1f7dNU1CD1v6/UmmpixsXSbAwIK55omi3K1IbvU5ONqdOCefpiVFEF
 Ta/A==
X-Forwarded-Encrypted: i=1;
 AL+hErHcNwGhXlu+4oZCXQZI+j3iaecAuohSWj5DgAnkebBBIXEK61fHmoRFYIn69JC2PkQPEGoL27kGF7kFsDtNVas=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/XuJMwcqinbhjie7PPGbBgc1j59E5bGeqvjjHAYk2Tq7LxubMd
 vQSsQ+ogUKLoCZvBlKiwSPDFy2oiYkzoJ1kbIGGhbGV6lTZjYvcXmHfdUJfr5THufX/uDHCTalW
 XeOHN2E5xbS03ebEXkDhpWoFiXBbqGGEkbhim74wxHA==
X-Gm-Gg: AYBFou25fFxbDshmwTRH/a3tmQz0l5tLGHP8g7CUGDBTbupi7K0FOVZ8NBVTrKE/s80
 gZBO1co6xs3YKEK+V22l9JLJBh//UJQReeUQiKgGYl+g+ct0p5Hc3xslWh3RDlhvBZPXg0NoXCr
 KjafksIscHR4zm5VxZAQwCULQfDCNv1j8VDFT9lSLnfISJmUdy746oNC6+EpInk9Tf0+uAoS6YZ
 3Yf3Z1qxAXgMGvNKAZUNq7dkV3LFJKdOBr0hNOhiG09/FtYj8G8cLwm5LwW7SJun7WUqPmsCtiA
 nVgWBsOJ3mwlev+bkTa1R83KC5PpKckN/pRq/FTU9A3KkFsEeJXKgp4O7WDxklJ8UD8fg7Jx22D
 /qTimIcIMQrr5IGZdd6Hyy1ClqI5S2Y6jAhJniENb20Qxtc2kcy2tKKBIRL1Y9/H/Rm4zHvjTld
 JFFQn55Juc3cnvKJgFH/errH5UPWqe7y4=
X-Received: by 2002:a05:6820:3411:20b0:71a:f794:49af with SMTP id
 006d021491bc7-71af7944afamr223598eaf.56.1794785805311; Sun, 15 Nov 2026
 15:36:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org>
In-Reply-To: <20261115113902.4834dda6@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Sun, 15 Nov 2026 23:36:34 +0000
X-Gm-Features: AclHuK-Ta2Fkr4hOVhZX_y8Xr7mXxa9_sbD5R_U1pL1RP64y3ME0zGRwgXOH1aQ
Message-ID: <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 llvm@lists.linux.dev, kernel-team@cloudflare.com, 
 Tianyi Gao <tianyi.gao@linux.dev>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 11:39:02 -0800 Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 01:07:46 +0000 Tianyi Gao wrote:
> > - On veth, an XDP program removes software GSO from the peer, limits
> >   its MTU, and can copy skbs from the peer.
>
> Could you remind us why you XDP_REDIRECT xdp_frames to the veth
> if you end up allocating the skb on the veth, anyway?
>
> I thought that was to let veth run its own prog before skb is allocated
> but you're saying that you want to avoid veth having a prog, so clearly
> it's not that.

Thank you for your comment!

XDP_REDIRECT into a veth without a program on it has been supported
since commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog
before xmit of XDP frame"). There is demand for it [1].

With or without a program on the veth, and on cpumap, this series
keeps the RX metadata from the NIC until the skb is built.

[1] https://lore.kernel.org/all/20210416175929.35c3c389@carbon/

Thanks,
Tianyi
