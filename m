Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A460A2601
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EX6ScRAf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYo98RHW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8665607DD;
	Tue, 20 Oct 2026 06:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6i5mkQK4RsDE; Tue, 20 Oct 2026 06:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCFE7607E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792476568;
	b=FV0l3E81olswBUojuMIdg1XLOZu3esRif0C5Q4hELuNUgXw6WfkFDS+GjoyfIzQmemId
	 5LlFix2Bqf02PeblF6+fi9c5yqwfnhdDEyzQYJWunbLJskYH35bQ2wlXBCI5DWlKMX4y3
	 HgGEKqC640D3x7r9/DHlYKqFbaPKGu1Xn/59jH9PdLQZ3W7WUJTNNq1buWDs7Hb32wn7W
	 4FjquBsjGRLWq/RB8sLlbkv9zayl5zenL/9lTBqtrkY6/oxTa7PQoHNjj6+gxYRtchXNr
	 iIrZJ+TnI5tvgzncYZRrwBR5dPw+iO/n5fwpjO9vtiH2ukDNI76Is9IuNV6xhb8i4mg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792476568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
	b=O6qj1YY8hKucOYdYAiwsHzTp8RV7aopdKo35OvzXbpQmxEtpdJ7urStDYHsw4XDgSeRL
	 5w1HKBfg+hE3zIB163e9kSXFxoP/BLUjn/a/2UlsNVkPxIyZ86RIMn6l++8XcXrZCKZeF
	 1RwSvFNF8mbGXjFRZ/AQ4Voxbzu2q/SbKVqZ7Jcd121L8/Z3qpIGiTndPsUj5jZ39Z5td
	 iGs/9F95lW4jC+tHaI61f4pLeJ7uxn4ueyfqy8SWRAabC76CBXRVIIuEVxHEB9n4u+aeC
	 x8tkJPS+lAmj9YzkG4whz7dTvL8YJJDEHtL/RmBf9CDSuW97/gaSyeHlouy8xLKRodA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792476567;
	bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EX6ScRAf7xvegvwguQXuj+L0UbzXyMld35oShc69LAuckemGR/Lotsr4eCmzcP8XN
	 J7mzdRtC3BfO0m3Sf3hfQ/gfwDiGRiE7s8VYVHNtggdRcXApJr5Pl9Afl6Hl1uS4C2
	 DE3T9ZpqIFa3sIx08uROfJKBLh/V6KGnKGgrnBhUZ9Bd+3oCkOtlUThBfVuZHavagI
	 60taSjGnAIV6fIOmT+MGyZZEZzoCim7i0LLTARMTMaDBES1v1+4dfvvJxeTOr9Pvo2
	 okjgJ4YLATmzqwocuk0B+812exKEM+6DLHJqcMCGz/+YwhVZnaxoz9btElQ2en+80M
	 0cR4wp8Rcm6iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCFE7607E6;
	Tue, 20 Oct 2026 06:09:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5866123A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A53140800
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UfAgi0AjUh06 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 06:09:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77B2E40574
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792476565;
 b=XmUJhPFojBpZA/5x689EH6cpRpavN3KllK+s0AeuwWjtfqiML0rgPwebWCoQAe3M0K0E
 67mIFNAu+oV7KnaAXyD7OK/plZRQYWdOwBCU0v8PfGNmvZYBx2UbwfSpb8+tBti5MTveF
 r9CLiYKmuy8vvhbxd9TBqMGNKvMkrZVX+hgJDTTPo43L0lfEumBUEMx5rDn6D5gyb2WmP
 AKJdaPfqym8kJjfCnrhzMsLVsO40azIXfhPA8UNz2BgVO74F1ZLHOiKPra3AbIJlYqv3D
 pXnavsFJmxGQGAASogntdfN3NKvJCaeI3Z+NVobozrRucfF04pY/mknyrvuz9inMRBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792476565;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
 b=jqQ3vLMFAwnQtdT6/vlVQXgfOThAZmsK6L1hMsJhaiOdY0pHUwQ7uzKafpSiFB+D6vEp
 koJnBY4IO96pKTZ5kPmSCPleRJgolHtqBrnGk5J03iBHWIYP2pwPGwnwNALe3/m7YiY9J
 T1zquIWcWJK9oR+OIt0H2qIFJImyg4ou6eLbLit2URGKuxkkxmyqFBvSu8gEHnDlaTGlL
 iUsOvJUkS7oMbCHS5DiRoNCOQXknwynLWF+mG4RUcKNUbtE0EcIUf9hPbcN6F6RNrir/4
 pTuVgjcI7De59uc5O3UwXHfa9A4dZIwBfRDz/eoUiZEop6mFJrMgUoXNk6TeWTJa9ww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FYo98RHW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FYo98RHW
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77B2E40574
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:09:25 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e9995ce866so21370485ad.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 23:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792476564; cv=none;
 d=google.com; s=arc-20260327;
 b=HI+aYz1pMK34cGtBngur6snjN5Ym8Ja8iQ3vNks/KSE8SlcnWlq2xxKbIPV2UiZexh
 HdgcvNn4SE0z2Yo23v/iRaGF2HjkKM+xVLWwzw3XtdRxDGsZ/ijAFsh+0HpZHHBf1sY6
 l0WCKwNVTWPIyoesMhKYSXtO5aBbyz2LUKGc38hbtN1hMMooB0633+VRPo11zJalFIBg
 tdSpAeQHbBjkWRt/FlUZSF3bOXNqQydTmjG23h9GEEV1HoGXUn6UWuLPeTO1sJBwL0R6
 iNnIWUCuI++bH9EDVEiitm5MqWc+CPJQVl2oNReFRjxbfjkKwyEEG/aJ1TMFZNKA8Tu7
 Ykpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
 fh=mdz524LbseKZpWdacg2K8ACHtGN3WN+/LR0TDOIwCXU=;
 b=RCdF4Y1q3mleyzUDUTTCE2bjmzbUOtVaFyenKYjMVzjAv2IaoK2IPkIEu+3qUMUQsa
 GIx3VBv3Op6OCrGG+/xob6rypSVxyMP/QKFVAqji7JCiCgsZ/AvK5lsA6aCWeNB970pE
 wwf6pedQbiCFzSVu26oFLFU0QiGUddd6so8HlJnrWZgKnR5Tag0jy0+ek2+YariNFNYL
 OKD8c3ighhHCfSp3AIQYvbDyh23DmYAOwWtSVcgVfZm5y16SXEqTXBgalaAXfT7HT95k
 C8wm5MPzNMi+gAJa+FvGautG1p20cDBMAlt43421ZGLj2l3LvJsnOBG30J9frsbAF05J
 RENQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792476564; x=1793081364; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
 b=FYo98RHWodAz1UZWX/KfXYLdGtmSXbdcRCkdqZlHP3m6T39SkC6fwIzCK/eYevI89e
 QM+rswTfffPkfPWLR6kWBc/PwQHciFnOsuLYExgbkv6Kiy8lzQ2hDUyuqjhayrF5qhzE
 ARvQcAmQ7EBvJzfKIePsps7TMQe1gssmP6pbSEimdTSEECeLD86Q/5A4Z9weQ7C8c416
 n0YOupN2PdEskgurn73sMCO7D1vF8nyxGbJG4wJ+02t+jY0vUFjAnhwilDN5C0/AnO3+
 k8ND0hcJrbGBm7CMZHhmisv/VWQ7aC1UZxUkeE40uH4JvGcnSxnH1wHZUhGj9KLNq7LM
 KFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792476564; x=1793081364;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
 b=LgK5+Insz2wfujd6a46eHLoM3ho2mY+PPEvfERN+2LBGwuJrPeUv6q/RcPhkQMJXd2
 EjO0hpcNryScVdvYS16ttOAd9E5u1IA1Be0KDK5vCQKpAHS5VgIjwdpR3hzIHlumSjo7
 i+u3ls+jo11zG9Plx4QfRZct7zLdzPi7k41q0NdVqrq95ZkczgjDC08YmuJj3YbkMY2Y
 v3pg92Qrt5pQnbMslxtJvc1E4yQ/kzvxKispDel4TNvKvyi5+l5GrGLVb72fm2cs9fyL
 u8GSX813UtQAxSSqf4vhmCoSwwp+fo/qlF5RVoBDkUFzj0/Cvr+Wo4iEXqsnySAbcUEx
 vQ5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlmtAQEz00BozR69XsFyaSEqmopfrUfFyqIqF/3Uw3swE+B+p9L1YJyyMRTnfly6rkWh2SchQuUWE47ygESdI=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKfRPDqFzUFy+HVV+uuqd2KEB2zwfrXtp1jsHmi2dmU1kJezKee
 Tu1RmpTmzywIcnKCyy1zFVID09dmrAqNl3Z8lYCZyEdCLPg9PWkWI0G7iCMEV+WGJNcAOJrANxJ
 eEVqO4K2AHOus+KrNgurV92MtOeyBiaw=
X-Gm-Gg: AYBFou0ihZ7RMBI8sVeooUzvZm5jedVdSPaQFJJH+KgNv/v3CppRwBTCL0UR2kel//p
 h7OGlvuyTsEwMbaKdYwIWTeqHRTNGtUO1G09ihxzncmxvf4zuQ5qtOy5xo76pQkfODTBNQJShs8
 vVduMw5vH+hqzqeLa7vjvLcd85Rrl9fwsxgKvcDbBYZk6eStwWRP+ZHVNssPb4D1hrXH4A0lrop
 KF3yG0d2YUoB3BJ3x22ej87akntszmCRYBM8PoD6sIBMlvEoV/UZy6z9LDx+ptLANTkqt84ydVC
 RrKK0pKnLPGInhri+SqsxBAObJHA5cKL54mYPCD/ELm/wN9bop6v6gDH
X-Received: by 2002:a17:903:2f88:b0:2e8:1d5c:f6f2 with SMTP id
 d9443c01a7336-2e9a69f8f83mr83802375ad.24.1792476564489; Mon, 19 Oct 2026
 23:09:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
In-Reply-To: <ataHK9s/MpNgXWhT@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 20 Oct 2026 09:09:11 +0300
X-Gm-Features: AclHuK-XbUcddl9KosRGKNZXHh6f-ueh77OfYnuvOwoLmpUVjr9gfpKt9gc-2dI
Message-ID: <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: marcin.knap@vecima.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 00:14, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Oct 19, 2026 at 10:22:02AM +0200, Marcin Knap via B4 Relay wrote:
> > From: Marcin Knap <marcin.knap@vecima.com>
> >
> > When an XDP program redirects a zero-copy buffer to an XSK and the
> > socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> > -ENOBUFS to xdp_do_redirect().
> >
> > A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> > drivers rely on that: mlx5e treats the failure as XDP_DROP and releases
>
> Sashiko report shows that drivers are rather inconsistent here

A note to ourselves, we should write a section in the documentation
for AF_XDP that defines the expected driver behavior. There are very
likely more inconsistencies out there since this was never explicitly
specified anywhere.

> > the buffer when the Rx WQE is refilled, and i40e and ice free it on
> > XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for
> > another Rx descriptor, the second free puts an in-use buffer back on
> > the pool free list, and the same UMEM frame is later handed to user
> > space twice.
>
> Did you verify this or is this rather a speculation? xp_free() protects
> against double-free cases.
>
> > On mlx5 with striding RQ this also ended in a NULL pointer
> > dereference in mlx5e_post_rx_wqes().
>
> Please more info on this then.
>
> >
> > Leave the buffer with the caller on both the single-buffer and the
> > multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> > do. i40e and ice relied on the core freeing the buffer on their
> > need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.
> >
> > Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> > zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> > with the Rx ring. With this change no duplicate frames were seen with
> > striding RQ on or off.
>
> Have you thought about massaging mlx driver instead of intel + core?
> Even when that would be correct approach ixgbe would miss being addressed.
>
> >
> > Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> > Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> > ---
> > Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> > The i40e and ice changes and the multi-buffer path are build-tested
> > only, as I don't have that hardware available.
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +
> >  drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +
> >  net/xdp/xsk.c                              | 15 +++------------
> >  3 files changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..d32c7255f0b3 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> >               return;
> >
> >       if (xdp_res == I40E_XDP_EXIT) {
> > +             xsk_buff_free(xdp_buff);
> >               *failure = true;
> >               return;
> >       }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 0643017541c3..7c1dd4c87a71 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> >                       xdp_xmit |= xdp_res;
> >               } else if (xdp_res == ICE_XDP_EXIT) {
> > +                     xsk_buff_free(first);
> >                       failure = true;
> >                       first = NULL;
> >                       break;
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6..0edc160c660f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >       struct list_head *xskb_list;
> >       u32 contd = 0;
> >       u32 num_desc;
> > -     int err;
> >
> > -     if (likely(!frags)) {
> > -             err = __xsk_rcv_zc(xs, xskb, len, contd);
> > -             if (err)
> > -                     goto err;
> > -             return 0;
> > -     }
> > +     if (likely(!frags))
> > +             return __xsk_rcv_zc(xs, xskb, len, contd);
> >
> >       contd = XDP_PKT_CONTD;
> >       num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
> >       if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> >               xs->rx_queue_full++;
> > -             err = -ENOBUFS;
> > -             goto err;
> > +             return -ENOBUFS;
> >       }
> >
> >       __xsk_rcv_zc_safe(xs, xskb, len, contd);
> > @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >       }
> >
> >       return 0;
> > -err:
> > -     xsk_buff_free(xdp);
> > -     return err;
> >  }
> >
> >  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> >
> > ---
> > base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
> > change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
> >
> > Best regards,
> > --
> > Marcin Knap <marcin.knap@vecima.com>
> >
> >
>
