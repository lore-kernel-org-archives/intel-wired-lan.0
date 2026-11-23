Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0F606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Qy123Hyk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccUvg+d+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7CA8605F4;
	Mon, 23 Nov 2026 14:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZc48xa9ghyY; Mon, 23 Nov 2026 14:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38F41606B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442872;
	b=AJMqNYsS4WZ3HWnXzTso295mmbTmL4mWx7C+wKNf+18J3Q/8Z6PVCG++hx2eOikrTXtK
	 OZ/55vbgcr1mM+QAgHO475eddadsDrpp+qMgvqmSG7dhbIHKr0y7Uaq3p667OF8ECm4/A
	 HchXMSNltm4T930/GzWtE0GSgFDC0kH2V/+Jhgt9JKNGyt94UvbHpd7/JByclgeSF94nt
	 ZQ7/n9f7F5a3wwRSWt/oFtTWgcDsjNZ29jQBaTQZwVTk4OeLJkLy7V7+wiMcRd7T4ocH+
	 T4wpkUeiWxXuzcHg0Taq21Q9lwU7Xma0EZpQWLic6qfzkSbl1m1uylWi8vg1aPM8BwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T7GzsM1fM5csZ7LhdpWY4BYMZVarBLjJGxAmOC3EEqY=;
	b=KNmctbJ4w8nGQdwPrHOwycn9jEwBjLUu4cKxxF9lqLNijaQGCwHzjczQq8Y8b0jNKGOI
	 Vddv2rgXeT0YxGRuyhpGuopKE3VmVz2kGzSA1jd/XorGNq7yUuINYmOX0cVZdhqYdzxGX
	 XyJpQozhqjdXt+jFFNgYRBMyyQLnCdxi/tXl8pmDGDOqScYdP3DN7tkdANa+1HTn4reVv
	 eaXw5AthHfCNXuNUzDp1BbHMVpdM7hAaBJ3MUP1Q9981eO1AJHXHKX8/aZiaS5FuXJxf1
	 3ppi511iNknOtmKuHKN93/G6i1OExFci00fivXNmvwLuwiAuGRt7lHSAALj+uJ/3f4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795442872;
	bh=T7GzsM1fM5csZ7LhdpWY4BYMZVarBLjJGxAmOC3EEqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qy123HykEv14nK6I+Bm+aKT1eEG7ekmdoxp/5v2WyHvyDTH8mo7ohwD37svWTNWnP
	 iDFBP1bdZqfaCc5R5cARpOprEZc/ZzH5xbbxAs96ZAgfHknoS2itkw3Sf2FUBbRBe6
	 Le0eIufpa0dPgDYO8KHk6tH5GoL3xQPSlIymqITuID0i4kogskuXcQFXCsk8roSZ/h
	 2sH+tf63GWdvdcWJ1H4q+RHQOMXFq9iFXb0kRP+U0nHMtHD8ssfdrvlUW/0TGrshv6
	 wtRawTrGXbUeujJYPvhUdRBVAW6mPgusNmLrtyWa1TgZwjtzAamhgaEBOu/vgcYlcl
	 8o5Db1TzAN5TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38F41606B1;
	Mon, 23 Nov 2026 14:07:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C922371
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DFDA405BB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lt_pUvDhXVie for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 14:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EF2740573
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ccUvg+d+
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EF2740573
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:07:49 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso1396308a91.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795442869; x=1796047669; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T7GzsM1fM5csZ7LhdpWY4BYMZVarBLjJGxAmOC3EEqY=;
 b=ccUvg+d+ZqukGqvHN0ad57Dt1QN5QghxIAYbQwbj4enapUP3uAqPbxxzKFtKMKIoT7
 go3IAM8/iliMRMwE61RVgkQuhtACBEbHVuh7cczuLM/QnRzPq8osi1bqtAlqlMF5kWVD
 ZZ3l4UzpRbvNUn2zT1RBQsmeN2sgIAYMJwJhaFuCPh9hDD8299PfsEqlY+KRe4Dsl98w
 HCuhFxFtXAKNdtESviLA9PNDTzpRd2lmQ8gHrYdQen1GgYvrbw6krorTC+pfwmCADByQ
 9J+v/RCpstUkkl7pxH9MSAWHx3ZZLydszC0xfRROTE705DoWmsgRjGG5U+tY2o6DVcet
 /F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442869; x=1796047669;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T7GzsM1fM5csZ7LhdpWY4BYMZVarBLjJGxAmOC3EEqY=;
 b=pG54y95Oh9iB6g28dJv6IVYLWivn/2Wt8c/iiF71b/QdvpjDV/5F8ve7+nub5WVMGw
 e70p2+t2xo6xXHSqP9v757J/8ans6yH9lhl99mQ/XAPoK43oGI3Qn/0OTxLyqV+5i2ko
 zXuNPUYwUWODqjxc1+eiiEJoWdu5m0Idi2ydS+m4WZhXooDRFwOWEcyWSUn2OHHRNKoS
 zGBmj1NCmR2SHpirmE6NGy4pemdddM8ajPnay87F5VYe5FnOnv1MEynh+u2b3cpzIwW2
 CFNCRmSf/4LI0ZJFGV41uXbb+nPg7TbKMIdkqNCxDH4MMLgm0LRvQDTMcZSMPk26Wgq3
 HBdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEqkpgeAfnmMmT5kfh9NhXRCJI2HviGxw4Twjh83jjCayDCQrAOM4axv8RKaqiSjmwb3tr1k+xoN3yeAwFmgFc=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9WTmGKGUte0yyCZ55ys3WtGtK8Dxmc+wO3z7IE8VIu40zHOnv3
 LzXjlmq/p/CjDeJW9QwQg6kcqpOcV7MYDLRVsDVWjkPVPcmN0rSjmkpqzMX5LjIAid8bmFMsNU8
 L8tieYb7xQjRPLWjoXlnTzMn+PvMq+aVof8Z8ay4=
X-Gm-Gg: AZFdTZein+Xf8me6jwFdJb7C/ZkB5MINv5UFToCGwwkdh2A4313WpCdjazSnpYnLbr1
 RnF3EstefMaw5/zpcQZ3Li2xXR5rO+oBRqbiJdUAsYfjS/KF3KgWGzEwrKARwDFJqAR237dK4AD
 rtOVhNYYKVcmS27O/IC+gYv0BpOyg+ZYX/cwBdVfMx77yKg+OP1N66jfnvr8+VdYqHGBYcDX9n8
 xvwVMIADpyHlbmvm2vKCPkrk4Z25+v5ZA+iwm+c+kq12MX+IRN1ufmJEAquD7sNVdW4VfHUACry
 VUohSB0sIN2e1g+uYt2NwkbND4ejilm2IvDenNkDblyO0tbDP9VPSiNxbi9iqrPilEikX7vZHG8
 AZVAIUYLoPEidU7TP+hCqrESbNcxB32lxlzkwbP0=
X-Received: by 2002:a17:90b:2d8a:b0:3ab:189b:6981 with SMTP id
 98e67ed59e1d1-3b41c953639mr10087547a91.48.1795442868710; Mon, 23 Nov 2026
 06:07:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-2-magnus.karlsson@intel.com>
 <877bi321yw.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <877bi321yw.fsf@all.your.base.are.belong.to.us>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Nov 2026 15:07:33 +0100
X-Gm-Features: Aa3M54oRlXnhzrgId3cP_lq2shH_unrS2otI5Gm4pK5Y2aM2Ibdh8yvJZTICByk
Message-ID: <CAJ8uoz2zy+aFC5=vR14FBz_q6KAztSEby2hNVFrBYeeSeWAw8g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] xsk: add USO support for skb path
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
 kerneljasonxing@gmail.com, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 jacob.e.keller@intel.com
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
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 12:59, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrot=
e:
>
> Magnus Karlsson <magnus.karlsson@intel.com> writes:
>
> > diff --git a/net/xdp/Makefile b/net/xdp/Makefile
> > index 30cdc4315f42..b6109e0e5547 100644
> > --- a/net/xdp/Makefile
> > +++ b/net/xdp/Makefile
> > @@ -986,12 +990,62 @@ static void xsk_drop_skb(struct sk_buff *skb)
> >       xs->skb =3D NULL;
> >  }
> >
> > +static int xsk_skb_uso(struct sk_buff *skb)
> > +{
> > +     struct xsk_tx_uso_info uso =3D {
> > +             .metadata.request =3D {
> > +                     .gso_size =3D skb_shinfo(skb)->gso_size,
> > +                     .csum_start =3D skb_transport_offset(skb),
> > +                     .network_offset =3D skb_network_offset(skb),
> > +             },
> > +             .header_len =3D skb_transport_offset(skb) + sizeof(struct=
 udphdr),
> > +             .len =3D skb->len,
> > +     };
> > +     int depth, err;
> > +
> > +     /* Best effort: a bond or team device can change type while the p=
ool
> > +      * is bound, also after this check.
> > +      */
>
> What would be the effect of that? Would it make sense to be more
> restrictive?

If a bonded device changed the type to non-Ethernet, there would be a
short window in which packets would be dropped and or sent out
garbled. After that, they would be correctly counted as
tx_invalid_descs. So I think it is ok to not be more restrictive since
this should be a rare operation while you are having traffic running
with an xsk socket.

> > @@ -999,18 +1053,43 @@ static int xsk_skb_metadata(struct sk_buff *skb,=
 void *buffer,
> >
> >       meta =3D buffer - pool->tx_metadata_len;
> >       if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> > -             return -EINVAL;
> > +             goto err;
> > +
> > +     if (flags & XDP_TXMD_FLAGS_USO) {
> > +             u16 nhoff =3D READ_ONCE(meta->request.network_offset);
> > +             u16 offset =3D READ_ONCE(meta->request.csum_offset);
> > +             u16 thoff =3D READ_ONCE(meta->request.csum_start);
> > +             u16 size =3D READ_ONCE(meta->request.gso_size);
>
> Instead of all these READ_ONCE, maybe snapshot (as in patch 3) here as
> well?

Will do.

> > @@ -1021,6 +1100,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, =
void *buffer,
> >       xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> >
> >       return 0;
> > +
> > +err:
> > +     return flags & XDP_TXMD_FLAGS_USO ? -EOVERFLOW : err;
>
> Seems error prone? Better to set the proper error further up, or am I
> missing something?

You are not missing anything. I can move it up earlier with some restructur=
ing.

>
> Bj=C3=B6rn
