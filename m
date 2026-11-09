Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84E606A334
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=O/cELM/4;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NZfG6F3Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3702440782;
	Mon,  9 Nov 2026 14:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xdd-DucgCyts; Mon,  9 Nov 2026 14:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63B1E40783
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794236077;
	b=UBfOVfEQ4uexv5yqEB4MHyqdRCB+1eaNi1ofbTIlmARYN8Ac2GGavqPu5m+WRPZoCAxh
	 0H6z9MViqI1/NXJgLybUYX60RKmmwrtI1B+TyaeGex+4CvwQ0RgbDqTd1p9pNDuJtvkWq
	 ZQVd653/vr/D3oL0y2bqCglTyfI6RD83woyM+EVz7F4ivjlONCJW0ty1jorP3tAJmheLZ
	 FA1lGdtZJMH0zEiTk8RzoceGfnKShu4ODRK/2DZH5zoKoB9rjy35iX83NZAMwTWhZNuVb
	 ej0zDHvUiTxxbMXQyrIumIhI5fU3OiNvevmnVNM1yqA01tRZT7ZLY1d26HJTqVvM3fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794236077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
	b=FyrM+PwMO5s1WhKdZbTBHasvvEje+OTVsu5Iz0EMkOj8BXxbcrTEmxLl3YyCk2qiMp6X
	 tuYGxcTZFuIOx76VBj696cq04jjXJ/enyrq0OBH56GPXb2xe8Q3fESIvosbb4x+qPOE4o
	 sPJVc7KJV0J22X/TilZlGLgNZuPYByDrpG8mqHl+MUS9qNsP53rYJ8XyjQdkZaGv9ly1a
	 rNSXamdYs0YtoF9WrTJm3mBpAXVxT/+DCoI3t6uk2kZ/UdqLgYWKCWluZhroe9sOn+suF
	 WprUJOSkQO3lpYxnPbG92Vm2g4OtWMxRrcwirIct4da5Yv8+GkBfr9u2O5d5+kpdW4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NZfG6F3Z;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794236077;
	bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/cELM/4ABGTichJ7aiTKzAonAqQ/f5a1MrWFSg5FD/NofZl6KA6ZnomNqb8g/J0Y
	 j199BSF1ePDqdqO6CZ4QlRbvmlb9VvJ2vzCr/lrgblLKK+amv/cKX0Xkdae2f3DjpV
	 DTB8luYGFeo46zMhOW3cAmDt6kjF22S0dTeHwtLV+6DHRDe+UHThH8cVQSeVF6MZW2
	 4SQ+L0azMZDHOwBd/ADbM2GMvdVIJID+ath5drGdwXxKMrzZLtAm6INK1DO1ghow4n
	 HMB1cyD0hPcEB1iwFqy+P6wup/hiiJlTvjCLEasrUctuhfo0VOpwXFsjhpXnu3/NL4
	 dTzSukrHVeDCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B1E40783;
	Mon,  9 Nov 2026 14:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7D52251
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADDA540783
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCdqE9ZUoAjs for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 14:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF4CE40769
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::834"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com;
 envelope-from=lrizzo@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=NZfG6F3Z
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF4CE40769
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 14:54:34 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-535f598d126so252931cf.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794236073; x=1794840873; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
 b=NZfG6F3Z7vNSeNJIA4RgKFjAGJYy6NgapiDx6f/cpzI8h1DwWQIV2EDKcJlS0SsRAC
 1b4ZxC4OVlNGlBKo5T4VadFC3WZ3PxIpu5/gFJOBpPmFoDZn83ZM5pA+wqqxWjen9FvU
 SPLnhx83eNNfHcBCN69OdW5WA5rp33/b2f0OGaE6gXALCaVMh1MzFm9A3wGxiJBiq44g
 Qg1BRmag8Nu8NZAbkVdlFlTcD+pQgM1iQmQ0GYUxXXkZl/gtbTS78ITCysCtHU8VglCC
 EpFfOa2JIUlObdnU8VCKkO0JRPXYZxquvOXgNHiTFrVOc0tx3CFnnptwxz5SR9w/aetS
 E02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794236073; x=1794840873;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
 b=IrE1YCz0d1lHAfDnBA5EIb+Yy6a1fRVK0gNvza4Yzu8IzxAXuebsN8PngrhuZuA6Ds
 bUljY53462DOh+ExgAilpphHd0fiZZScPTK0ih92e6qeLVbIqEaXawQL6y6YJzzGN04C
 wU1DOuCw7doTgTih5ikMVfgFaAPQMnLwVvUpi59DPT589DRfEsSG7iTOqRZYwyN2j2vD
 7VTajnfAV0kkwZU34z9pj4mYFJkGPDw424dRrc58Ctev+hhXVLcgV8KVRzIllcxzm73m
 5DtKn+8y7os19n+Oq/kJ1VjhFts/qRNYKapJWMtPWawRbA7IcmfwFJ+xR7j1TuaElQsZ
 v7fA==
X-Gm-Message-State: APuU4Z9Ok4Pq0vttMRFN34EQ3w8OjsCVpt9Jii4+oVAGmqvBWNH3CcQx
 4y6W1GL+QCu5WovpJyeNpezQxFhYdd/ghg4OnqlYfqZvT+U1oivM45Byj5ghlXsllyYnHf0b/Y5
 SQ70FhmwOQsev0m3GtKpPR9h2k+rzcKgaAQpyrhKf
X-Gm-Gg: AYBFou1XPTsOGEfW2qdHZO0LB7ecMkBNoEwWBpGsBhONKRF/G6WQqmVdMrSmsvRiRbq
 iPOvpp0zt1geFU81Fja4D3/VTuktPNtkP8vs+CuMYzgaTNFc9j5j3VHQlBhCLKDZk8SsoPEgPWz
 ODuglYn3KYUDVkX6VaGj9eBoWm8+IhA7MAIMHm+GXMZkHsG9cYdluM8V7oCPZ/nGM6rZyzwIqyy
 Qli1TOiFnpRYK9o+amsTPnxaaTtS7DKW+ab/pvpGMO8Hs9skoF1TO2XBonGH66JF5yTgAFFfA3K
 zpRTJeKHX4TnCheMWz11GcJPkU6wtOTUyeS7Og4619/IXJZ7iX1gqTlx3/V4Xye0XiSzsmfCpcb
 5G3a35KIg+pLzs24AHYhiPLhhhi3yISvP2CivxUPvaLEeS8J61ZFO8KOorGc=
X-Received: by 2002:ac8:5c88:0:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-54f9fd8f8d1mr38320671cf.2.1794236072272; Mon, 09 Nov 2026
 06:54:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103162326.3615979-1-lrizzo@google.com>
 <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
In-Reply-To: <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 9 Nov 2026 15:53:55 +0100
X-Gm-Features: AclHuK8TskNldJ9T-2m3-q5kqcKrV-1RZ0T7vtN0-Um1ktY8-kpgA25IyzuryKc
Message-ID: <CAMOZA0KTYjRGuD3axNKaNb-o5=c8Zt=zG4Q3JFxPbWuBVu5MKg@mail.gmail.com>
Subject: Re: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 7:08=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Luigi Rizzo <lrizzo@google.com>
> Date: Tue,  3 Nov 2026 16:23:23 +0000
>
> > libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> > driver fills its Rx rings at open or on queue reconfiguration. That
> > fill runs in process context, right after page_pool_create() and before
> > the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> > needlessly restrictive there: it can neither reclaim nor compact, while
> > the initial fill can allocate tens of thousands of buffers across all
> > queues.
> >
> > Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
> > libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> > Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> > to GFP_KERNEL.
> >
> > v3:
> >   - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
> >     argument on its own line in page_pool_alloc_netmem() (Alexander Lob=
akin)
> > v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.co=
m/
> >   - split into two patches (libeth helper and idpf consumer)
> > v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.co=
m/
> >
> > Luigi Rizzo (2):
> >   libeth: add __libeth_rx_alloc() to specify allocation flags
> >   idpf: use GFP_KERNEL for the initial Rx ring fill
>
> For the series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Looking further at the problem, gemini pointed out that libeth_rx_alloc()
is called in a way that makes it easy and robust to tell when it
can use GFP_KERNEL. This would greatly simplify the patch.

Alexander, do you like this version better perhaps ?

cheers
luigi

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e6..38c0e5066f0ef 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -104,10 +104,17 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq);
 static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u3=
2 i)
 {
        struct libeth_fqe *buf =3D &fq->fqes[i];
+       /* fq->fqes is zero-allocated and pre-filled in process context for
+        * indices [0 .. fq->count - 2]; slot fq->count - 1 is first alloca=
ted
+        * in NAPI. Use GFP_KERNEL for initial pre-fill and GFP_ATOMIC afte=
r.
+        */
+       gfp_t gfp =3D (buf->truesize || i =3D=3D fq->count - 1) ?
+                   GFP_ATOMIC : GFP_KERNEL;

        buf->truesize =3D fq->truesize;
-       buf->netmem =3D page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-                                                &buf->truesize);
+       buf->netmem =3D page_pool_alloc_netmem(fq->pp, &buf->offset,
+                                            &buf->truesize,
+                                            gfp | __GFP_NOWARN);
        if (unlikely(!buf->netmem))
                return DMA_MAPPING_ERROR;

>
> Thanks!
> Olek
