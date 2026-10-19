Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4F606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=WvZLnae6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XcHjobgX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D6E681053;
	Mon, 19 Oct 2026 22:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Xs3NSQ9Z8Y4; Mon, 19 Oct 2026 22:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AEC9980FEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450579;
	b=UqTT1j5ZyL3571ZNd3MPrkGAO+0AJc02/45/8y/DXePGNvBFidpUHtIL1oVIR+CE3vX0
	 oUR8osdTFbCphPnPsFC3M5hpLHHhpSk5bSpERKg1L5xloPTFZU9PHHj0YG1JBK6s9vIeD
	 Iviz7HzlyM2a+fmgGGuArXWoxSphE5UAnPr/f+aJWOCibhMgSVttyD9iMtfaz9Z5x3cCr
	 5Zbg5PKxVW2WdpdgicSNAhVdD57DGcZcLOL4araUcOUpTFcjOu8Dhls0QJMNebVs3SCVh
	 it+MN1V/tB4AYMs85R2i66FvORVLaRYrIAxK+HnIsPYM5JMH3k6W97t31s2qh1/pFhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
	b=H55aspxLXHY3ULr/dHEHQMHVWJvFx6s9cFuqi+XqFsiBbxA7pxXk+yB7ti6eGAht/gFK
	 +g9EB82Ym7J/b2HIFwGy0bkEB9NFwjqRhQD4vFzST6QTl6HnRSfCvOZ5KwMIBcHWM3GO8
	 hadPuGgtlinD8IKrTp4Hln4S84l2ziiy/QhErX/Z08Oo0/9Fj+wRGfMBHx+YQI0w1Crlh
	 lY7AdIOhhynSBirpkdKUQ8hbZbmCvvfLnNT8XVqShn6QU673xoxTo9QDjAJOzO53Xk0H1
	 fCR0YM9TenH3WrX044AGSUN1h2UO63xInWsaUz3OQuSYV5kX0nCBf9zKYQsDEX6UAiA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450579;
	bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WvZLnae6wx9iWyR8CEel3eCgzSsfVQCTDS+E+BsPHShNHPIcACo0kHyYTWJUouVyw
	 zipam1CKTy0VpcwYmJ92IDtDS/q8skfdKmObkZFDJqxFqfYktC3LO07JJbnqLVlP5m
	 C2v/7BkoTpJTCcJMkxKH/uconO+Z4KICd6Yc3CvHarOB9JLkpxIixHOx3MmKoQiL6J
	 DAYTIPVKR79JLVUWxplOPrQMKehO0EpJQZdsJRsrJIr9YKPalxbyEEj4Htk62q0I8t
	 LJha9TcGKbT5XaBMS5kWGw7/wktu8+zn7BiZc8tuDiOlec01HL2/PyPcyx2lioorxX
	 8j5wytpZRHPKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEC9980FEF;
	Mon, 19 Oct 2026 22:56:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75AAA23A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 15:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67329404DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 15:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0YWaEwWCselW for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 15:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7088140478
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792422229;
 b=gaE33SfE04/SZ80a/RlBlCg/Uj6LNp2Ie6VLWe+hivprlIs09w9mCZBZDIqngwdOBvJA
 2NuDABJmi3a7zlXuKOzXt8mtudZskPyntjtZnSIy9JCoEOyfJntQIcM0MRqyqKo+NT0C1
 tdzK4K0losuRgvbvkSNF6v+rj461n3vpqh0tPjxIhkEZ/pFf2gd1qCZPDImAcvZUIaEgJ
 d1D5zDD1CfZEcDW6YxAAddK70d6Dm6vG643XTpzjtWbQWZ/ntpV9k5fB5OcMSkBzTzcs7
 J4SbXxqhjQ1qouzYBh/vAqsogFZgdIjLTtWTRKvBN91WSWgmGNGAlWJAWoFi0qw164Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792422229;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
 b=hBNaqizhZ5Sq3JBcpsmuZyjPD5kZBY/KUCEhErOP2OtYeif74JV4ZzpNyGukKU7Tb1zd
 bBo9hA0EqEBKjM+Uhi399p1kxIs3xpi6F4BmEUL3zr8V7s0Ui2BnATHsT2WrNikWrbqYa
 39VVVsvf2mB2Z2ixa6tsf1gnQjt1pS+wNwlnZ5DIB6bTponH/He2Dz0glhm8geuYkDxKN
 NpySUhW0y3jYQ5luaMy5YVKJTzWYQjcIhClPB5NEjolNNjTMRSEGRaNDrmWjYXWyCncXW
 D5jGRCURuDmHTt6+77djqSC8y3qntZR0IvyNYZcisFOlGks304SnMqb5XrBxDoCuGkw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XcHjobgX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XcHjobgX
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7088140478
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 15:03:48 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso21553027b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 08:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792422228; cv=none;
 d=google.com; s=arc-20260327;
 b=imP3ETkwDeNIdSSmQofexMBij9Ne9OaFudcfDbeZGvx3hL4GC8hqZo0WG3KksWXTJW
 9bqH8PyHK5DgPjh+KI0kXQyrI1k+nOPzaG0GQSoRAqm/qjl6dMYPrWoWuWFhoHVlhoRV
 R+Y3fjf7RbrHd6zILQmI/eSSIwlpkO017QWLiWnhhJKcx1PkiJeeCXz6lKLVarOkDOSn
 J5e0Pxq+7eHO8AEuijJ8fgeD7Oa2iM/CZ1unKZFdRAkWgraYDIhkpyZ4ote/e3mE7GvT
 FHjv4nRxj2LLqP6/SRK+VtDiTJJZySyGdjF+Lh7bPuuWvAXVuj6E5f26n8lQSwCUbOoW
 0f1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
 fh=032IjD3k1v47FjDy2514asslT4fZuYoatCoXIJ5hPZE=;
 b=EAE3AbaVoViBH9y1FcfNwzFHaowWmugj+oNjKDPRK5RstOBhiYGQ3J5RK8Gyfq31E2
 PJqUlT3pTjMBRsuv8b5zUsxg1MDDKOS/Vxs8EcI9D9bxIRnC+PWkq8jFqvwCZ7DILnlQ
 IEyh838AjoB+bycDuY0FCH550k67Oww6YyUwts3LtyQzKj67R1w+/buWC57Z6TMKjiBx
 KNELgzRqNeC5HjJDOLAcUF+u0MEYwbQnMYH95W847ch5LQuPBYhwEbgpfo7E1SzGiv9b
 nHsVtLAKdfrz6dUB4AW7yQqlZyPRpgxAJmkGh1lgB85CPtX/gsD5Us43JwIe/a4YBAx4
 wgKQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792422228; x=1793027028; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
 b=XcHjobgXBb7RQE0CLhksLh+37+ab5XySsLEeh/x5p6buwBQ+XwetZO4yFrfuTT64Rs
 N2oD2TIXPUPcqYMDLbMj+WAwWS7xuUa+1FPTAkXHfFJksdPI1w1T1CwkagOU17BUuLSd
 0c8Paw7YZv35+ekS9BoHfmA/J/Dy4IeHqGX3hMMAJGvO6HBwagN/3n9+pAUy67Owf0tQ
 JkhVyV7bDnRIwuezPB3b+7vNwIY3pUnjVi7PaE+sJvZteRjqTR9UIlSSG96xDuy7UGsS
 ofvi3aNp9rYqF5mZblAc75A8KZtmRuGV3M3LmQMiGfy/7W60PhWztO2/rKIn6j5Qf4FT
 veJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792422228; x=1793027028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5QTDlON/KbcJhL3/P1XHXLsZg4JTmgtOWrzjy+XctCQ=;
 b=cS5xIywhMVq40ncu3fopxEi39heAzpK5MPDp90VGIJX/+8j3O/pKbseN4qmbt8FkuS
 C94JQUhLJzWqIVHbqXhvMD3M7sRsUntFPhv53cvU12OIVOkKWNOvvJOo6MhZlqdarhol
 obAsMIApvK26Ecsk6B4r+KaLWeMT6cZi/PU3rdgRSXPSH1SCxFOFxmdfHxN9ynQ4VR9c
 /sq/OloxAVyTk7kV7Lcl2bRCg96IkUk1yjm5sjPF9CFp7EnanebiJRb/hjKdelBjt8eU
 efkg8tS+1eldE5bzSLiovSWU9uBDHjRNEcgZi2FAu50gEvqB1BrjpNuL2LqCMkER6W2C
 mgUQ==
X-Gm-Message-State: AFq9FYJfF7EwXSbu/fetuhTBR9iCiL0of/MRe6Pjk3RKyZPkPLIJEXss
 ji+hY9scEmR3aB5Z4gPjeqDdvvMQ9l+w7jV4WXyIORJjDzeKdjbwGNpWsfUUQ2/yrR09ZTqD7Uh
 zhJ6l3e59GdXL8waZI0VLNWhAsBFjWhE=
X-Gm-Gg: AYBFou3mmrXsG/w69PS326p3c29XpFL48DdVqWppJ+lMRfogXMUcEMSO0IUxS/APpco
 H/USIMMC04eAlXKbaJX7rsWfPJyOIhCgLaGN0+3ZbL7zmfqOImzd0mqS/QupkzDYlFK5uRr17Ik
 2t9K3lbykBkreb3/IiTAYPY3nBD8ksZPSuJs4pQIYa0IKJ9zNMaBd+m6Rlyzrtpq+qE1gQX1ZXH
 ivl853F76Joywp0QpzWxhFdO4cYkNqyWMXfD4mQqMA1qkAiVGvN7/q0sYeqdRHjF94Mr4IPQqeX
 t64y+LGLAeFs1+F/PppwFmGxmuVRA+KKsNlFgQa39AqfH8NZVh3vBwP2fHtCrdRlfF30hTDN0+G
 JnsWcJrMvguCbmQ==
X-Received: by 2002:a05:690c:dd5:b0:8b0:ce9f:29a5 with SMTP id
 00721157ae682-8b0f2134c02mr22560477b3.18.1792422227751; Mon, 19 Oct 2026
 08:03:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018203215.77371-1-andrebrait@gmail.com>
 <atYbzARmBOVuRTdW@luna.proxmox.com>
In-Reply-To: <atYbzARmBOVuRTdW@luna.proxmox.com>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Mon, 19 Oct 2026 17:03:10 +0200
X-Gm-Features: AclHuK-nY0XZAuJA3DmN1wCDwTD2SwIY60IsaVP3Mg8yQeVWH5_YcsZSKoFnKPI
Message-ID: <CALhGy9=s7FDzCPUWiEc-XFJUrRjkr13Lmq-_ZXWXaCm9cm6p7A@mail.gmail.com>
Subject: Re: [PATCH iwl-net] e1000e: segment TSO packets whose headers cross a
 4 KB boundary
To: Gabriel Goller <g.goller@proxmox.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 19 Oct 2026 22:56:11 +0000
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

**The previous email was sent as HTML by mistake**
**Sending again as text. My apologies for the noise.**

Hi Gabriel,

Yes, I checked the ordering and this leaves a gap in the check.
Software VLAN insertion moves skb->data back by VLAN_HLEN, which
can create a header crossing when the original data started near
the beginning of a 4 KB boundary. skb_cow_head() can also relocate
the buffer.

There are other later layout changes inside e1000e too: the payload-pull
workaround in e1000_xmit_frame() and skb_cow_head() in e1000_tso().
I need to account for those before relying on the checked address.

The posted testing covers the original untagged reproducer, not
these cases. I=E2=80=99ll address this in v2 and test the affected paths.

I think V2 can make the final decision inside e1000_xmit_frame():

 1. Complete VLAN insertion, payload pulling and any head copy-on-write.
 2. Check the final buffer address and header length.
 3. Use hardware TSO if safe; otherwise explicitly segment in software.

The check must precede TSO header rewriting and descriptor programming.
AFAICT software fallback also needs correct ring-space and queue handling,
not just clearing feature bits.

I will have Claude try to reproduce this on the same Proxmox hosts
with the v1 fix already applied, to isolate crashes to later packet growth.

Andr=C3=A9 Brait

Andr=C3=A9 Brait


On Mon, Oct 19, 2026 at 3:36=E2=80=AFPM Gabriel Goller <g.goller@proxmox.co=
m> wrote:
>
> Hi Andre,
>
> On 18.10.2026 22:32, Andre Brait wrote:
> > [snip]
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/e=
thernet/intel/e1000e/netdev.c
> > index 834a5b888..6f95ed19a 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/delay.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/sizes.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/tcp.h>
> >  #include <linux/ipv6.h>
> > @@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device =
*netdev,
> >       return 1;
> >  }
> >
> > +/**
> > + * e1000_features_check - validate offloads for a packet about to be s=
ent
> > + * @skb: packet to check
> > + * @netdev: network interface device structure
> > + * @features: offload features usable for this packet
> > + *
> > + * The transmit DMA can stop for good when a TSO packet's protocol hea=
ders
> > + * cross a 4 KB boundary in the buffer holding them: the descriptor is=
 never
> > + * written back, the driver reports "Detected Hardware Unit Hang", and=
 only a
> > + * reset brings the queue back. Seen on I219-LM/-V (PCH) with forwarde=
d
> > + * guest traffic, which arrives as linear GSO skbs that can start anyw=
here in a
> > + * page. Let the stack segment those few packets in software instead.
> > + *
> > + * Returns: the features to use for @skb.
> > + */
> > +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> > +                                           struct net_device *netdev,
> > +                                           netdev_features_t features)
> > +{
> > +     if (skb_is_gso(skb) &&
> > +         (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))=
 &&
> > +         (offset_in_page(skb->data) & (SZ_4K - 1)) +
> > +         skb_tcp_all_headers(skb) > SZ_4K)
>
> Hmm, doesn't validate_xmit_skb call validate_xmit_vlan after the
> ndo_features_check, which means that the vlan header can be pushed into t=
he
> packet? Meaning the packet can grow after this check.
>
> > +             features &=3D ~NETIF_F_GSO_MASK;
> > +
> > +     return features;
> > +}
> > +
> >  static const struct net_device_ops e1000e_netdev_ops =3D {
> >       .ndo_open               =3D e1000e_open,
> >       .ndo_stop               =3D e1000e_close,
> > @@ -7378,7 +7407,7 @@ static const struct net_device_ops e1000e_netdev_=
ops =3D {
> >  #endif
> >       .ndo_set_features       =3D e1000_set_features,
> >       .ndo_fix_features       =3D e1000_fix_features,
> > -     .ndo_features_check     =3D passthru_features_check,
> > +     .ndo_features_check     =3D e1000_features_check,
> >       .ndo_hwtstamp_get       =3D e1000e_hwtstamp_get,
> >       .ndo_hwtstamp_set       =3D e1000e_hwtstamp_set,
> >  };
> > --
> > 2.56.0
>
> Gabriel
>
