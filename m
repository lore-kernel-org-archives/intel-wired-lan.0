Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA8606A31E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iu/704Ag;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bWy+D7Bt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F7CB407D1;
	Mon, 19 Oct 2026 22:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XBLOmeXeVx4d; Mon, 19 Oct 2026 22:56:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9BC35407C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450578;
	b=rK0lqfSLMhg6XsdYyxCvrUiPAU+wxCgyJ/kWmtqxShTpxzky4wc5+S9W1I5p61j+/fvA
	 pjZNiSCrRnknbL/jpc+7u+m33hErjBxpDcAfvMcsqYISKS7667mtlqPZECV4bGWPjEp8r
	 xeIugeYv56XaGUE3/P4LEiG3BRO4xil/wOvJczC5L9UBTK8UrE3ON7BXenhxZCYdSRoTT
	 OJw7pCoqfpwK6nCvfJExRtbJH0dbzCg2d1/9KiF06Z2/W4Kv64f8rIY2hfXfcIaVBCcgp
	 dZm9XD6EY3hYzLOsbf8keLBsDxUXPDQZarcrx9T/sGiR+NZfRCEPlVkETAzNK49OnaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eBc+Etm7JnnYsPpLM+1boVICJS0t6jw7EvMUn5KU300=;
	b=dMFmIPQhQ//g0Y/lUR3eqgcq95p5c1ICYjJAlhQIjRX4im7A7LO95O37uE8DQxXn9etK
	 GgONYf0rMSzrVVkw6W0K8SH42KMSKPanOuSKxdM9gVNjfdm3Z+kM052ZCWTIXVQkVYzE0
	 VuFDqNNn/SeSB8mhCTKgadkfmpDCgoXBIemxLXWLbcCmMj+iqEZiKnuAvP8Tjnc4VqcMG
	 kiphado5BSU53ThjJdiJzsuLTJgWuiLTXSSK2uzDhJI/IyOxdbomO/q7X/4wzSEiEZgki
	 ef8EDDv0BewW1+Y0zlAITjcNPpTvmvJfTrwhBFgxUmijtalpIKb6lzCWpqouE6mMlJA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450578;
	bh=eBc+Etm7JnnYsPpLM+1boVICJS0t6jw7EvMUn5KU300=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iu/704AgW/Np05HtFLQhttaMMnp5cC1g5EJTMjjHG2/ypcA6/ffOxPuPLQz9IP/Ho
	 Tco6/ViomPQhkcELD6xr42x4hyFuytCcH8ddiV9sRxp+AZMnToAwde7E2JwLTceuLZ
	 L2+wdDtzMjmyRPe4ZEaOsBBL77pHkFyryTgZS3y5igH7mzFjeMfWzkTJZRPHV3uF3j
	 sWvOLXtfU0n/iHqQB0hkgTlmQfeZWlhr+oAuvauH4dwx/HmNGmitdGsq8UAYp0VCGC
	 u7blN6veBI0etfmo7GAXv8l/a+rjRA8OXuGrdSHXXZnZ21p1qquhKOO5sqx4/v80PB
	 d2uzxRePfM9NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BC35407C5;
	Mon, 19 Oct 2026 22:56:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD152263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B37A260662
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:11:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgrw8Jmo-MPW for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 14:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B50F560634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792419089;
 b=QSJeELFlQOHk+6UA/477CYE8sukCUF1UM35llciEUSs94U8uwGNenEvoquI8hcUEMMyv
 U42+tdcwR2ozevmTI1DVmapKBKPPJ11WfH+BQdkwDr9jxFFOdM93HXun22Ekbp+rX4BVS
 D6jd5KwbGLxAC0yQkwG0Wh89Jm/Zy3DK+zHZ8Xysvz3eZgbYKyJSGgCiCKw9wQzV8dzZy
 IUzrqTlDxDhoGeBcFfDb1UJKqzZIequ+GwpaxFUlDwlQcOjEZ9XDIrDSQoDIuyYmmW07y
 Jp8EYLQ5aIyX7fvx0dEG5Cz400n/TCx6DJqstKLtILVuCyPibcGJuSU5yv5Z9SK5orw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792419089;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=eBc+Etm7JnnYsPpLM+1boVICJS0t6jw7EvMUn5KU300=;
 b=b88Yh6lOz3rZi/VDFr6TdAjD6NKYmD4spFtr1yQkgtGp0rCScxCq/uW71iK4izsPU0fw
 qGbZ21cg3zVSSCJYUH0AvDXsOxcW1QDBdGPnDLh7PF+raBee5pajWL7bYS0h+52DmX3UV
 UsJBBZyt89KwDDQcxM6Q14qOTOLgnMrV5kBL3PGWZ7llBpr5jDQrYf+jZVU3leqbvfSXn
 fisUun0p6YE5JeHiUCJc0uCixib3MgbWVRdP2kSd0VT/T0A6bPFOXxuOT3Zm1Habz+0wf
 Kf34cZ4iT/jnkpNcDRT+D8SNeX0mGhhx5I8i0I9NQ0jMo6KHrPHVJ1nDI2PJgXzsVWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bWy+D7Bt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=andrebrait@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bWy+D7Bt
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B50F560634
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:11:29 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc4ca696de6so1232734a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 07:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792419089; cv=none;
 d=google.com; s=arc-20260327;
 b=S2xn0hlRy6PoGnGwZZT0QU1yEu2PF+bQije88GVxbohKGanUNF7G/x7/KZK8EA4A8D
 EuFo6rg9fmMpNOngLt6lb/e16YoJJDihDnpFPMTg+HPao2MGsT8DiuFW1b2RqYtmGwTZ
 6SBu+1m+CL7PJHfArGCHBbwUWQrBEeP7P6P4CXik/EMwKPKCu8P+IkJAY8N6ul0XA5pT
 N2no9Z/pDmQE4guAX7sPowy8iz1oAl5BJXEfslKn7P7diXEnBC/zJZzHWUULX2o0ZZV7
 JxHSkJJGaLxv0wh6ONT9MvoEGVE4tx/qFd/6NlLr6C+Hhtlr3R6RGdYWQo+eD4AyXPbs
 QQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eBc+Etm7JnnYsPpLM+1boVICJS0t6jw7EvMUn5KU300=;
 fh=032IjD3k1v47FjDy2514asslT4fZuYoatCoXIJ5hPZE=;
 b=QiOgwTDmF8nMfzrbiab9LtfzQsy854Rb7/0WBoh/ioCaC2X2af9Q4rtiaWEanF6qKf
 +34vzTW/1BuEHzdjrhpIqyovFxe26FxRJdaTVvZF9H+9LnAoVuYmfw4GtCM6LZin4RrT
 bXQ3+3oizlhOz4B/FEpUbO2PfKzyOHdtcP8d6ZZ38FbC21l0wyLF8RM1YxlweCAGzf2w
 03yzEqm0H3coXdwFrM7Q3Vhpjr3LpFmpTvCQcwgaRoXDuuFtPNU6NxkP1exEReNitXlr
 EVqi+pCk3QqjYMsHxLqHxnl3h/9l72uCG3D99TQZOxa5zGXKTnzuWw1aIAPXOA06fP6E
 DLPg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792419089; x=1793023889; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eBc+Etm7JnnYsPpLM+1boVICJS0t6jw7EvMUn5KU300=;
 b=bWy+D7Btzm2ZuaYFul0KBXiF/hXbvM1VenxDz+MRHBjXVsU9FoWLXb/HTCwhisJ01V
 8FMye1pmwNazHO1SOf76AJyLrQDnPnfv+XtLiRep17cFkvhutOFlPZHhdcJjRaVIoWRO
 zGT5feFgfpJJuhNFzgGzjBtbMhHYIXYUCCnJQ3M6hd3eI38ZttDICwgJYIsBa8ede3xA
 YhUAg14uCC0nIxCBA8/lFZWFhHm5kcTq8RNueB9GXTk3pDGp2Nb1V5au5kzoOAuavfx/
 A+4Jk+dTr1wHsoeWGqf4s8mhPpRg/VzzXun/6hdFXgfoKyFswBag5mrZmV1l2HWwjrsc
 jT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792419089; x=1793023889;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eBc+Etm7JnnYsPpLM+1boVICJS0t6jw7EvMUn5KU300=;
 b=Ez98F3fIqk/QLY+rUI/JgVZqrAEW1umJ9rXZVm3vmCuEB90jQ/Urn88GeXm+EaH2+B
 uUFmxpdtaCdf6L+jAi9ym9t+x9NEroK3CWSsUS8BVb1Auz3BaGzdFtZCPwU+FpnjJhO1
 3ABgZAhXPf/Hvq2RCAR+WCpfLU6g8d6Iar4kCSxTVQk/F07lzv68bIcMfzrNSg/X5ZeN
 IvGF/G1s7MnjL75kbnzyQhT8rix0Tg80ESbPUTCGaQb9BVYjt4xeud/kxJuwXFIOFB03
 FTyohHh1WHl9K5I8wgPPfukS1EzLXrkHAL/xAA35FnYfKwSsOKTqG4NbNdwfGBRK8aeY
 /jaw==
X-Gm-Message-State: AFq9FYLmbP2IFBbpcb6UHgYPGFcV08Tu7mdXzLNW0oKgUUNfIO5PSyxD
 w/Xin32T0NHg4//yUG84SRMPjEcq3g87vG0ipyncnKsxzTisFw/hDosVerC43mwrDle/aVrnQ4Q
 ZpB8BOqjh9eFvPzPFGuOrCMiykw4Jg8M=
X-Gm-Gg: AYBFou2hxoT33s96fz8DLfBltXJzHyrPFgLBVwlj6Nyke/tY4NHpYXpnBjBk/PsEDdy
 XkVg2KMY3RJ87oWbv2zIZInckQaja8oMg5ftoyZY0VhvKIZg2pwGjVHuudmvYbX+MQeh6PmKsbp
 0zR5PR0Sfe+e1OnX0eK6Xu0XigdZpQSIhWhjcW/vObcEDOlh0Yh1Xcrp9pb04E2sMzXDYGVvlfu
 XJVPZ1AIynReNWaUJhLlvrXN0lyRkDnINccZ/4WlbCTwse6FdbkK1tbvMRGDFyG84ZIutroMn/5
 e5I3/j0UyMwc+9SU6NZNEfWP2sNFPwuXwcJGG9xdsPa7Tq/fMfwsRxQPKvISPRcUMZOGC2GNG+l
 aGj2UcbSKL66j3w==
X-Received: by 2002:a05:6a20:430b:b0:3e2:5d7f:f630 with SMTP id
 adf61e73a8af0-3e25d7ffbfcmr1249448637.54.1792419088466; Mon, 19 Oct 2026
 07:11:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018203215.77371-1-andrebrait@gmail.com>
 <atYbzARmBOVuRTdW@luna.proxmox.com>
In-Reply-To: <atYbzARmBOVuRTdW@luna.proxmox.com>
From: =?UTF-8?B?QW5kcsOpIEJyYWl0?= <andrebrait@gmail.com>
Date: Mon, 19 Oct 2026 16:10:51 +0200
X-Gm-Features: AclHuK9iZqZ2zShn0VRn1l48wHj9uJp-cFgFwoqGyozLdGBtItJEWQqWvmxpEHM
Message-ID: <CALhGy9kS_d5QpA=LamC4Cwt_EsMTJWkS0vE4Sm4FKMfrJ4QEeg@mail.gmail.com>
Subject: Re: [PATCH iwl-net] e1000e: segment TSO packets whose headers cross a
 4 KB boundary
To: Gabriel Goller <g.goller@proxmox.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Content-Type: multipart/alternative; boundary="0000000000000e8ab4065e321761"
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
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000000e8ab4065e321761
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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


On Mon, Oct 19, 2026 at 3:36=E2=80=AFPM Gabriel Goller <g.goller@proxmox.co=
m> wrote:

> Hi Andre,
>
> On 18.10.2026 22:32, Andre Brait wrote:
> > [snip]
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
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
> > @@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device
> *netdev,
> >       return 1;
> >  }
> >
> > +/**
> > + * e1000_features_check - validate offloads for a packet about to be
> sent
> > + * @skb: packet to check
> > + * @netdev: network interface device structure
> > + * @features: offload features usable for this packet
> > + *
> > + * The transmit DMA can stop for good when a TSO packet's protocol
> headers
> > + * cross a 4 KB boundary in the buffer holding them: the descriptor is
> never
> > + * written back, the driver reports "Detected Hardware Unit Hang", and
> only a
> > + * reset brings the queue back. Seen on I219-LM/-V (PCH) with forwarde=
d
> > + * guest traffic, which arrives as linear GSO skbs that can start
> anywhere in a
> > + * page. Let the stack segment those few packets in software instead.
> > + *
> > + * Returns: the features to use for @skb.
> > + */
> > +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> > +                                           struct net_device *netdev,
> > +                                           netdev_features_t features)
> > +{
> > +     if (skb_is_gso(skb) &&
> > +         (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
> &&
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
> > @@ -7378,7 +7407,7 @@ static const struct net_device_ops
> e1000e_netdev_ops =3D {
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
>

--0000000000000e8ab4065e321761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gabriel,<br><br>Yes, I checked the ordering and th=
is leaves a gap in the check.<br>Software VLAN insertion moves skb-&gt;data=
 back by VLAN_HLEN, which<br>can create a header crossing when the original=
 data started near<br>the beginning of a 4 KB boundary. skb_cow_head() can =
also relocate<br>the buffer.<br><br>There are other later layout changes in=
side e1000e too: the payload-pull<br>workaround in e1000_xmit_frame() and s=
kb_cow_head() in e1000_tso().<br>I need to account for those before relying=
 on the checked address.<br><br>The posted testing covers the original unta=
gged reproducer, not<br>these cases. I=E2=80=99ll address this in v2 and te=
st the affected paths.<br><br>I think V2 can make the final decision inside=
 e1000_xmit_frame():<br><br>=C2=A01. Complete VLAN insertion, payload pulli=
ng and any head copy-on-write.<br>=C2=A02. Check the final buffer address a=
nd header length.<br>=C2=A03. Use hardware TSO if safe; otherwise explicitl=
y segment in software.<br><br>The check must precede TSO header rewriting a=
nd descriptor programming.</div><div>AFAICT software fallback also needs co=
rrect ring-space and queue handling,<br><span style=3D"background-color:tra=
nsparent">not just=C2=A0</span><span style=3D"background-color:transparent"=
>clearing feature bits.<br><br>I will have Claude try to reproduce this on =
the same Proxmox hosts<br>with the v1 fix already applied, to isolate crash=
es to later packet growth.</span></div><div><br></div><div><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr">Andr=C3=A9 Brait<br></div></div></div><br></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Oct 19, 2026 at 3:36=E2=80=AFPM Gabriel Goller &lt;<a href=3D"mailto:g.gol=
ler@proxmox.com">g.goller@proxmox.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Andre,<br>
<br>
On 18.10.2026 22:32, Andre Brait wrote:<br>
&gt; [snip]<br>
&gt; diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/=
ethernet/intel/e1000e/netdev.c<br>
&gt; index 834a5b888..6f95ed19a 100644<br>
&gt; --- a/drivers/net/ethernet/intel/e1000e/netdev.c<br>
&gt; +++ b/drivers/net/ethernet/intel/e1000e/netdev.c<br>
&gt; @@ -11,6 +11,7 @@<br>
&gt;=C2=A0 #include &lt;linux/pagemap.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/delay.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/netdevice.h&gt;<br>
&gt; +#include &lt;linux/sizes.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/interrupt.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/tcp.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/ipv6.h&gt;<br>
&gt; @@ -7359,6 +7360,34 @@ static int e1000_set_features(struct net_device=
 *netdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * e1000_features_check - validate offloads for a packet about to be =
sent<br>
&gt; + * @skb: packet to check<br>
&gt; + * @netdev: network interface device structure<br>
&gt; + * @features: offload features usable for this packet<br>
&gt; + *<br>
&gt; + * The transmit DMA can stop for good when a TSO packet&#39;s protoco=
l headers<br>
&gt; + * cross a 4 KB boundary in the buffer holding them: the descriptor i=
s never<br>
&gt; + * written back, the driver reports &quot;Detected Hardware Unit Hang=
&quot;, and only a<br>
&gt; + * reset brings the queue back. Seen on I219-LM/-V (PCH) with forward=
ed<br>
&gt; + * guest traffic, which arrives as linear GSO skbs that can start any=
where in a<br>
&gt; + * page. Let the stack segment those few packets in software instead.=
<br>
&gt; + *<br>
&gt; + * Returns: the features to use for @skb.<br>
&gt; + */<br>
&gt; +static netdev_features_t e1000_features_check(struct sk_buff *skb,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct net_device *netdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0netdev_features_t features)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (skb_is_gso(skb) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(skb_shinfo(skb)-&gt;gso_type &amp;=
 (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(offset_in_page(skb-&gt;data) &amp;=
 (SZ_4K - 1)) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0skb_tcp_all_headers(skb) &gt; SZ_4K=
)<br>
<br>
Hmm, doesn&#39;t validate_xmit_skb call validate_xmit_vlan after the<br>
ndo_features_check, which means that the vlan header can be pushed into the=
<br>
packet? Meaning the packet can grow after this check.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features &amp;=3D ~NE=
TIF_F_GSO_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return features;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static const struct net_device_ops e1000e_netdev_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D e1000e_open,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_stop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D e1000e_close,<br>
&gt; @@ -7378,7 +7407,7 @@ static const struct net_device_ops e1000e_netdev=
_ops =3D {<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_set_features=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D e1000_set_features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_fix_features=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D e1000_fix_features,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.ndo_features_check=C2=A0 =C2=A0 =C2=A0=3D passth=
ru_features_check,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.ndo_features_check=C2=A0 =C2=A0 =C2=A0=3D e1000_=
features_check,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_hwtstamp_get=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D e1000e_hwtstamp_get,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.ndo_hwtstamp_set=C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D e1000e_hwtstamp_set,<br>
&gt;=C2=A0 };<br>
&gt; -- <br>
&gt; 2.56.0<br>
<br>
Gabriel<br>
<br>
</blockquote></div>

--0000000000000e8ab4065e321761--
