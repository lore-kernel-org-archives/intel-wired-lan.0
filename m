Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BA606A685
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WdAZ1HvZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIS5HmmF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83FBF40816;
	Wed, 25 Nov 2026 16:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDFhA0zhuxHw; Wed, 25 Nov 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E23B64081A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795624418;
	b=ppXKm+YmjeAMsnZblzYumYlZH2Me6NbO5RTBFH89AY0t+8JLfDHBJjzc85uKUeVS8x1g
	 FtJMu6dDr23uGKf1KJsYwAYQIe7PXOIKYw0G0ETDq9fvKyQ4PjrWT+3C5Nq47BWArfuft
	 UM8Y6ZE/ZcMLJaz+iLDX6DVmVsuVyUVlxO2zOvZD7YDOiqP/o8lH8uES6WA2xZupBhlmk
	 YCeZS+CMXj5WIHbR06ygOsa7A54JtqRTwNOcc9xTULH8jEjgYckOt0Ht/FxNrHCQIupou
	 OIQHl6265XRLNKyKb4WJGMr3o38VSGveLo442EeRiMjFPyHNui+J+0iH+GqQn4u4/dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795624418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
	b=sKe3ZCk3DddWrLFvmYc/g1zGrsK+ghS7FL9ziGAyvidLbeJPBdmrHQ6rwi1UTjVy9l3i
	 Sdz/W1WPGRb2QGs7UIcpVhbKte8WEGUWPJns3IaoetXt9Ly5XBk5v75XJcrjWD24cnMDG
	 ca3YyuoCzgNhMD/aIo+V4IdFDBVMGS1sGoDiLaFjgLYflatXyl+m0CValWSee/0Iwxd0T
	 +tWPWJSwOCbOegrtRwWZRsaIu2MO/Sb+BXAh5PZ5+dnZPYOehkC0i0mJcnh44eGsEL+bL
	 4BSQ74SR8qzgWr8SVcmbI9ldzrI+YXAGrmULw0w51pR0EVR0J8vULnm4I4VXscWPt8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795624417;
	bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WdAZ1HvZSobd8nVCwpQEAO1IjEVfudyBSkuM8/KYOjiXU0eDZUNbHCtOwl75h3KAR
	 H5XikZCp1lZ+zAs5MjecPalUd4y1KGwjt4+8HPN1A97jHDXRwwLlEODhy85Nuw9mB0
	 yPyNIZWffpyeV5laMsDtFWWYB3wJjhsjtDe4f9bYlPhCig47DpMUseUWeGlTn3/BfM
	 SWRlA7Yj+J8YtsIYVSObuAeSzgo/WPbyC4j8akm6A7lfVQRuaxUZjamE7nFZ7+qEjx
	 K6fMrKJA4BInsyjnWe2+/bl8d0T4NFf3YYY+m62jnEB9uUvkOKpRQqlbz2JAG8CtI+
	 0bwLq63hiuMPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E23B64081A;
	Wed, 25 Nov 2026 16:33:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C21D226D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A732540453
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BmLGwrQrqaO for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 16:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 894F140116
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OIS5HmmF
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 894F140116
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:33:35 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso8755515e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795624413; x=1796229213; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
 b=OIS5HmmF0sMBtT89OYliJWd3MUwLHEakeqGOY+5bSb113Y0/Iqzs0kKcq958fFJgQg
 uxLdnfMtu7+M6D0BPLsOUgIrx5SbGQAZUerw3sGOj/vJaVxitUheJ0ByT0tOPbbE5SSN
 FtyZGc3x2uhReOrDrpIMDwvGPcmt12h+CuUI119gwHSl452ntQGpFyTZsoo7u/ZD8VeB
 dhU/wFwHoxpNPa/SoZYNuEo89aLw8VifsIf5ag5brIzLhr7usXAUCLgMLqNkUuubCSXN
 QMk8jhmyGBshtOWAzf9dOGHe5Ah6KeqL51D2/kmhTcn/YPV7xHIdcauEW5pzEAlZZQrs
 qtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624413; x=1796229213;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G8pGBF4gig+42xucKEgB4reT/S4vYsrjWIoua9qgDow=;
 b=2v43lwEyB3lYzr6hiSfe+gt/iKhPWp92cfqb9hIIrzfp6eBFzPBzV6GbX7YpOwFN55
 UuqN+OQUmSc59Wukumm1isROU8dXds1sK/gRFXmn3E8OuIZ+ecRE9oV+592/31pKEVXb
 FrMGYpnWLwg4DhUxxycBjnmUau+qPcSte+h/IZ/khuhHsQenrqI7G4U+lc1pGnCcJYh2
 9dsvnT6CkNIc7Z4oKAE4mk7RfViTxWlIP1ypreWhJ/UzhuR3e5Z2lrT7SIWdhHIqIv57
 BYOOjTB91WJ44Mrwr/j4wGLz8mk9QBKcC6bLZVujA0bAZbOjUwTnee+wrYf1ssBkasr5
 zIpA==
X-Forwarded-Encrypted: i=1;
 AL+hErG5/j2ei0NcMEaPzvy+grv8sCrPTE2ZOOFqMR83p8tXEwfRZV355NvTrXAiMgNHpt1XjnwdJiTAjAJViOYa8V0=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/GHqvAWqCOPQaLKnnEJ/4DkUHTLMbBDGtpNa1xJR7ism3FbYTg
 mIoA2QqDIkUbhasOTQOAzr/ENfKNg0g4msZfZUUQx7RKFDtSmvZ1g8/GNqzPvzDQGrgjgfueBMJ
 bRDo+LkzaeJwVQGcdCVzpP1UrHz2OLCo=
X-Gm-Gg: AZFdTZeZLVqvkCrJ2QIFya1V9+bpEwyWgpGrt46nmD6jNN3dph8LSLK6RDA6d/kCIEW
 Rfic3ImTz+XtGHYLZ6v70+p17vGS3MLml3XJXw8KyQUYSHfzFq5ae7o/mkdqS1D+H/hpSg0MbBg
 YUT0lw/sY2AAtPPjUCsICMDEdZmXcAb0zgIRbRizdYpyDtBJAIhqmD/CRE6LirYVCKjaxFx2nQI
 c9hfSxx9VoTg8mzLw+SLqynMk9Q4ynw/bEHpfootTKQ6TU72lPKmwIXbmAveofCRv7oip6GmXEF
 CzdxDBTe6Ne5Ff8ubgZAO/qpWfSCAjXph3Uii2gbNszqX7vDnIwVb9KiAPcO8QKVBrLy4gc9NG2
 z7oz99Zmw5rR5XK2RO3fxVflW523GSFBwgyw5OzG9mENvVEWaMnKk4GfGqjsqFvHeskgJswMOVK
 zd/+0YwUQIOgNHSOBMVAoTSv/QULyLPpeDxuDgSHf32pS6OHDyQAGLOdF/1vPFmO/CfXFjenzAO
 Gk=
X-Received: by 2002:a05:600c:3113:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb88816b2bmr398390865e9.27.1795624413003; Wed, 25 Nov 2026
 08:33:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
 <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
 <20261125090732.69233-1-tianyi@cloudflare.com>
In-Reply-To: <20261125090732.69233-1-tianyi@cloudflare.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2026 08:32:56 -0800
X-Gm-Features: Aa3M54pUd6pmzCO8UswpNG_p1Cop8RfCo2MjSO4FX8Mgp7n0ftvtp2HqSVfaiy8
Message-ID: <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>, 
 Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, 
 tianyi.gao@linux.dev, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 1:08=E2=80=AFAM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> On Mon, 2026-11-23 at 16:17 -0800, Alexander Duyck wrote:
> > Any reason why you couldn't just strip the GCS enable flags from the
> > rings when you add the XDP program in ndo_bpf instead of having to add
> > a check for every packet if the XDP program is present? That would be
> > closer to what they did for the Mellanox NIC and wouldn't be adding
> > code to the hot path. Then it is just a matter of also adding an info
> > message that you are disabling this in the log so if somebody does
> > have to figure out a regression it should be more obvious.
>
> Thank you for your valuable comments.
>
> Clearing the flag in ndo_bpf alone is not enough, because
> ice_vsi_alloc_rings() sets it again on a VSI rebuild, for example after
> "ethtool -L" or a PF reset, while the program stays attached.
>
> In v2 I will set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq(), which runs
> every time a ring comes up, similar to what mlx5 does when it opens the
> RQ.
>
> v2 also logs an info message when a program is attached on a port
> with GCS. I tested it on E830 with attach, detach and "ethtool -L",
> and I will send it soon.
>
> > Thinking in terms of what the final fix for this might look like,
> > currently the drivers are already starting to carry stuff for frags to
> > determine if they support jumbo frames via frags or not. I suspect we
> > will likely need to do something similar when the time comes
> > indicating if the program can avoid corrupting a checksum or not when
> > it is stripping headers.
> >
> > I am not super thrilled with the idea of this becoming standardized.
> > In theory this would be much better if there was some way to pass the
> > data out that the frame was mangled and what the checksum adjustment
> > is to the total frame.
>
> 100% agree. We should be able to tell whether a frame was modified,
> keep CHECKSUM_COMPLETE for the frames that were not, and give XDP
> programs kfuncs to read and set the checksum status.
>
> Unfortunately, today there is a big gap before we start that:
>
> - [1] lets a program read the checksum status, including the
>   CHECKSUM_COMPLETE value.
> - [2] lets a program set CHECKSUM_NONE or CHECKSUM_UNNECESSARY with
>   csum_level on the skb.
> - Nothing lets a program pass a corrected CHECKSUM_COMPLETE value to
>   the skb. [3] lists this as future work.

Realistically speaking there is an easy solution to this in the
program itself. It would be to look at using something like the
REDIRECT action instead of just stripping the tunnels and passing it
back to the original interface. It would then take the frame and stop
processing the remaining descriptor data. As it stands that would be
the more correct solution as you could then just redirect it to the
tunnel interface I assume you have stacked on top of it and have it
receive the frame instead of having received it at the interface that
just head the header stripped.

It would also match up better with how the stack would actually expect
this to work if you didn't have the XDP program in place.
