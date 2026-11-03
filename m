Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E44606A32C
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hwy6yPr5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=le0whQKd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6519F8081C;
	Tue,  3 Nov 2026 16:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBTC8FVGlYLE; Tue,  3 Nov 2026 16:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C5FE806F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723320;
	b=mldNtx46zVE9Aw9pjYas8hdN5LjBsIzjAscSxzflU+NxZEFBidHDqLou81Wh1GCNaC8h
	 lLBMeOrQW+ppVTZWL8w1PN/pTecH3phP5WVYQjv5rPKHI8jXUI9YUbu/6zDM6vbs+jptt
	 6QtXF0NyTDGDR8odfKIVVp+o8LDBTsEwW+fZd/iOkiH5ZDlXvanySTQOWYVI7BOt3Z9cI
	 3XhWB9Ypolht3ABCJHjLXZ11Z3+OZ2s9WgM4lMDNxo84l8Hu29Tx1nQdMNrTSGp24COtq
	 dYKCzdn/ybTfn8fzf3s4qfFwsC5Avub1D0gH1hna+uqcjLe06W7IMTtTA1+tuNO3Fxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
	b=jKvcqkaF3m0lT5wnU5H/AmBQH7LIWVnQIWAGBOFnZ/e4DLyQVxZGsV7BNDEbPCEUU9W1
	 99PosIFFjWRq7Ri3rU3VLN2ZhmkWNVuOrK72eyIh4uWh3i0vto34KAdC79ePACH3Vz2JS
	 REcqD/1GClEVuyTBKr05S3zX12drU1rODOi0gNejp6v85RQJRIWZLJXCPbDV8wbFVygva
	 +7kZ7ebxG8d11PAPd12oeGwxY6MhtIamb211Iibcp+2Lksbq+khKHO702yXUQt9NeT5aD
	 V0aU0fQ6IzTe02MbxQD9Doq7Aszk06clAW4VeONDQahGDZQThuoQDznza1R85Y5lmKQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793723320;
	bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hwy6yPr5fgT8ujXx/oNIm+ryGjSbEZqxa8q+ZDiepyNkQIQ+G7o+okBk1YRR7Gifn
	 twYqSpFTfUpsvppeVwzkXgMS+ViOdBEn4Jyl042/dvy78cLDO0GG4L4wA/9zswtC4i
	 vMqpKBJBZSiT/QxmHavJ5zFVJeB9TPKYEjkGMns3ZHSyHWerQwERGUJ2AMs1ZaaPv8
	 r6ptIOleDGbvfelHViGdD9+O95XS++7n5SrmuQbd3XnVYPldNaNnahSCGJ4j28+Q7O
	 M3fYuRGwn1aAPjmJMP30X5mL4KLSJDk1Q2Ke5yBiuRVY+DSvT45gJEvjYErITbURkL
	 XVEPrGydWVotw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C5FE806F6;
	Tue,  3 Nov 2026 16:28:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D71FD2AC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C885B400BE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0QSg7dsmepE for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 16:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8406840062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723318;
 b=kyXj0ruhu3tO6zHW/MSNO8eqg1z3dLzmXGejLmvmx068NGIYWkqGnb3x3JMnrh8LZLLr
 fVHu/MXzZUHOFwoV/4LK2JyqEPYUusNOLU4DLKQ5ZF9VywIiYuNJizhINc5TlxqawRnSO
 x4SSEmoXTHip9AzcmE3RpdljRa3Fn6EYVWjpHtOWpigzg60vI3as10FEG/lEUxNgOLFAE
 +JpVKYnVqVI8vdtzaMLRLqogM4P/uWerw7kwYRzPf3yh5Yj6/p/2P9aTIBKvHp5Ts8hOk
 X+0acD7L3x8DvYqAxdvwdIGglu9W76We69wbwVXlxv9dU7z6uEwXS4J8oXg5hJ5GctQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793723318;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
 b=StiA8bOSS7eRRxjbCp8I9R7/v5CTYVp0VAcExYsJHTNVqKa2VyAwb3VL9Fk6hJBbWRrb
 yENZOc/0qtzdZrI4kCuXjI/mP/3SchvOLs5fA754CZZ1sVU7+Oks2McEYPal0p02Pqkkb
 lfLXoNYwSRFqCeA7Gk2NhIjtVHdYd+7RXD4BwHXGQEn0ocQUNuWEZan2+a5FH8ki4/f7q
 rr5mpckUhTv+P3xwxMIWRoxui1dWw2sO6SHvDd6xV/JDrI/uXQJDslNCeXDxPwK5BpT91
 rBkXURs7F09ecewcmRZ9O3EfrOSMaqHHgCBeuXy1Hs4iC5Wn3EqMq1BgIiLbAyq67fg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=le0whQKd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=le0whQKd
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8406840062
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:28:37 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso2353237f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Nov 2026 08:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723315; cv=none;
 d=google.com; s=arc-20260327;
 b=qVvzL8lelxPOdByzGHAvTSH4UD/sjyraizDa1Pokcn+p6kFlDQz//gxG+jfz8sTE+w
 no58+Wb4gJEOTXVqkhXSG+XdThl/z88VMK1RMl2NvCpGmEQS+arlkl+5R9fy5DywA6lM
 V5WZ0kL77x85Getb7V7Z9/0YmqZlQFI9AG8fkhd6dhWHXyB6zVzADttek3HK8Iddbym0
 97rWuEJugfI9+ghkC6rMu0uSGBc8kR7kV9BHiOebwTQv+miN92GissAKRxFf2nchfTMd
 VhS7DVdcpbriywmoDF4Kwcysb9Id7ZvFYlZUWgQ3pil/xSdncA5uaR2nwi+XE2L3aGYK
 HHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
 fh=CQPwpG3DzXKRlNfMsrUW62mfB15zNMlN9JfRXliDAb4=;
 b=K67o8Imn3KzQF+NXam0iV6YbWxN1CdH2k+Rl9GYJ6OZDjuBWzhQQfagttRR+MOrk9U
 /BeLWq8Shq6i+4+OjkmG8uSyhgIz3UZhjhUQ9gINT2bMehLU8mrK423WuPoreG2jDKah
 tFPtoBdgBVWkEwXyn2wsV+uZLz3sRW0IrPdVGXswVkcjSKVfqakXSXieoYYqHrv9W89m
 SRxb5clv8e+6AZxjxfH4qjWPZTR2vtfy+m5OCRuxr7nNv3wMgnQL3c2+ZjFbR4MLTY1f
 rAbRtJjuo/PRCUAxShSAYED2LsPaWfuWxUaW0yIbsQhRhc7WPY/EttMFAcmPHK0JBolj
 MVlQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793723315; x=1794328115; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
 b=le0whQKdO6XksTX4j4z1+aZIThTiNC7RhZF6cZEfqj1ti0KfcyY85mEwWi99bDITSZ
 j4W/cGyh96T/H0rCCLHT7fgQX54YT5C5CGdDvgAjnf64872L12SOEHbfXv5B1lEx8iEc
 UB4+hj3qJrfY8xyL1uVSCRTjFCUbhRzCJ28G7AldrVIipOWpqYXD7f90VM9q6nefvom3
 0UqxEO9K/8SypsWEgnENmebdS0jr3o8RMrO7y9VOATZtP+sPtCwxvHo3AVktmZrs9GSa
 FxltAFhKvT8XkYzHVeJbuJNzjqyUtUANZCEcj4+5cxj8M5T6O9t27YYz8AZnerC9l5XO
 1+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723315; x=1794328115;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iNrqawb7znOhdynzk3QZawC3lApb5SKPQ8U0JnSF1mQ=;
 b=o6BdOLYOeDDh58u/pWcDTYmDxUFVlR7SE2VWTfiPt61pE56FivA7ksDcKwl3iOg6Je
 klpqDk2P0smtLWYcynhzgiWWE6BQAJBvGv4eGu/2eanB7en0m2tW4y5lCZ1P7/PXFZ5C
 +zrYM4QCJTItaOBy3xR09Jz6dvIZHMo5X15KU1oq97E9BTD1hL78df4ajTYGjpgRpTig
 w03jVxTKgbrKwfzPT4gF9YF0OBeCy8H8iTy+A3WUSzqJx129arkVvn48IsoeA/PHYkOG
 c2Iiv9zJan/EguZ7gnqCHzzqvYzmN4NlmZqmewUn1JPTLvMWmBzVamnAf0pgfRDk6TvP
 V2Ew==
X-Gm-Message-State: APuU4Z9JWfdlTtA9D7UTPj5nMd2xo3iOAHH9PJallfe0qs7vxExYfiyO
 LBMsQmxNPpdhZ85niRGrQjjOLPzgSbsV7nsLHbI5USGaO21pK8RkZhnbAkCx7pi41zv/FF+owGf
 VP/HzzciDSSLHmfUjwj3WaDR4xu/bcoQ=
X-Gm-Gg: AYBFou05FuZECI92AeW0nH/W2fsI2v2XtSen0Vr2WcYFnz62pMfjf1Q5V7ewoklIKBL
 qVWsTaRMlSFFepo2MgwSkV99lfsuy3B7Rpcht6nOjsWl7O3pRVeSLNM2aH78enCBsk9u4pQaRTf
 +Tp1BOT/UCO5rMI87DBV2kUER3WkauX4k2DezlHbJfF7Kkz78q+8x9GcPjiVBJBkgNRGIbKthMu
 kYHXzGa6ZVu9xGPFCtGDg7vrEGfUEUsTF+8nNf7jc3GUsyjX0wwHQO3e2x4zgBgrmuu1FNwkGpt
 6puFjV8fD3Nlr8D1tYuGWKdjO3A2Fp0ftR4wiHt/hQwAmhmo15Zclef4QZ/gVsjKFDHMRHAlFCl
 XKzidR42Zv+tX0P2nV8yB4YnPjEjM7CEX3uY/nNKF0z7EDjZ1d0CusR+FVbiwaUH2ghbur4dFGE
 RFRGqEmjludgsTYp78xCdHG6oKRiox2eDZzsTcbEfvVALiPKxsD5T2Ag==
X-Received: by 2002:a05:6000:2404:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-48e6e2c1e2amr29659218f8f.8.1793723314831; Tue, 03 Nov 2026
 08:28:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028170239.28606-1-tactii@gmail.com>
 <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
 <8df82d18-da9e-4077-8ed4-316e5314882a@gmail.com>
 <CAKgT0UfcR12X-+O5XvzqCV4Hh5rHs5dPZSps5t=1rPC5SU88eQ@mail.gmail.com>
 <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
In-Reply-To: <bf1f9ee0-c7ec-4e6b-bf22-14e64413118d@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 3 Nov 2026 08:27:58 -0800
X-Gm-Features: AclHuK-P7m9VOIbcOGQMmiHqx-bxMRQC6xGVDdY-66Tx-Pag-hb_2xV8nBD-_BU
Message-ID: <CAKgT0UfTMsJok7ZOBukzrVKvTC9qV38jdfWH6yKDEPJSEsB3CQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andre Brait <andrebrait@gmail.com>, stable@vger.kernel.org
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 8:32=E2=80=AFPM Matt Vollrath <tactii@gmail.com> wro=
te:
>
> On 10/31/26 12:53, Alexander Duyck wrote:
> > On Fri, Oct 30, 2026 at 12:00=E2=80=AFPM Matt Vollrath <tactii@gmail.co=
m> wrote:
> >>
> >> On 10/29/26 12:47, Alexander H Duyck wrote:
> >>> On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> >>>> When an skb arrives at the driver and the header length exceeds the =
u8
> >>>> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped value=
s
> >>>> are sent to the card. If TSO is enabled, some header lengths will ca=
use
> >>>> the card to hang.
> >>>>
> >>>> This was reproduced on an I218-V with an unprivileged Python script.
> >>>
> >>> Can you elaborate on what the script did to trigger this? I am
> >>> wondering if it can even get there with a valid frame supported by th=
e
> >>> interface since most of these e1000e parts don't support tunnels and
> >>> such.
> >>
> >> I will send you the script OOB. To be clear, this is a security fix,
> >> not a correctness fix for rarely used paths. The rules say I have to
> >> post the fix publicly because an LLM found it in a
> >> function-by-function scan.
> >
> > I got the script, will try to take a look at it over this weekend.
> >
> >>> Also did it have separate cases for the CSUM vs the GSO? I would
> >>> suspect this is more a CSUM issue than a GSO issue.
> >>
> >> I have only reproduced hardware hang when TSO is enabled on the nic.
> >> Otherwise it likely just mangles the packet, but I have not confirmed
> >> that.
> >>
> >>>> Fix it by disabling GSO and checksum offload when the header length =
(and
> >>>> checksum offset) would exceed the field widths. Compensate for a
> >>>> software-inserted VLAN tag.
> >>>>
> >>>> Because of a quirk in the ordering of ndo_features_check, the skb's
> >>>> transport_header field may be stale. If the skb carries
> >>>> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, ther=
e's
> >>>> no reliable interface, so don't offload it.
> >>>>
> >>>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (curren=
tly for ICH9 devices only)")
> >>>
> >>> I am pretty sure this Fixes tag is bogus. This is the introduction of
> >>> the e1000e driver which was in 2007. The ndo_features_check didn't
> >>> exist until 2014 sometime after that if I am not mistaken.
> >>
> >> My understanding is the Fixes tag should point at the commit where the
> >> bug was introduced. A comment on the Cc: stable tag indicates how far
> >> back the fix can backport. I didn't bother because this patch should
> >> apply back to 5.0 (skb_is_gso_tcp()) and the oldest LTS is 5.10.
> >
> > I get that, but at the same time the fixes tag is pointing at the
> > driver when what more likely happened is that the stack evolved past
> > what the driver can handle as evidenced by the fact that the fix would
> > never be able to backport that far as the function it was adding was
> > introduced sometime after the additional stack complexity was added.
>
> The Fixes tag seems correct to me. To confirm it I reproduced the hanging
> hdr_len values against 2.6.24 on top of Fedora 8. It was more or less the
> same script, just with different headers. I can't confirm that it hangs
> the limited set of hardware supported in the first driver commit. Maybe
> Intel could test it in their lab.
>
> It's worth finding new core complexities causing problems in drivers, but
> in this case the mechanism predates the driver. It really has been a
> security bug for 19 years. The switch was enabling TSO6 when e1000e was
> spawned from e1000.
>
> The fix not being able to backport all the way to the Fixes tag was a
> choice. It has nothing to do with the bug not being a bug that far back.
> I'm not spending time supporting Linux 2.6 or any pre-LTS kernel, nor is
> anybody at Intel or kernel.org, as far as I know.
>
> The attack surface and details of exploit have changed over time, but
> that's not a story that a single Fixes tag can tell. It's the story of
> IPv6 headers.

The thing is this has had cycles where you could do it and where you
couldn't. My thought is that it would have made more sense to tag:
Fixes: f2701b185e05 ("e1000e: Enable TSO for stacked VLAN")

Basically there were a number of efforts to fix this in the 20-teens
as all the extra headers for tunnels is when this started to really
become an issue. In addition the driver ended up being moved at some
point between so this likely went from being fixed to being broken
again in a few cycles over the years.

> >>> Much of the complexity that enabled frames to build up massive header=
s
> >>> wasn't until much later when the network tunnels and OVS started bein=
g
> >>> added.
> >>
> >> The repro script should work back to 4.10.
> >
> > Okay. However, that still only goes back as far as 2017 if I am not
> > mistaken. The diff you are blaming is from 2007. I suspect we should
> > be looking at blaming whatever introduced the ability to push the
> > headers this far as the driver itself isn't likely the root cause for
> > the issue, but instead a header change was.
> >
> >>>> Cc: stable@vger.kernel.org
> >>>> Assisted-by: LLM
> >>>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> >>>> ---
> >>>>    drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++=
++++-
> >>>>    1 file changed, 33 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/ne=
t/ethernet/intel/e1000e/netdev.c
> >>>> index 6f85dab5c55c5..370776657d100 100644
> >>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> >>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> >>>> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_devi=
ce *netdev,
> >>>>       return 1;
> >>>>    }
> >>>>
> >>>> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> >>>> +                                          struct net_device *netdev=
,
> >>>> +                                          netdev_features_t feature=
s)
> >>>> +{
> >>>> +    /* Do not offload packets whose header lengths exceed the u8 fi=
elds
> >>>> +     * in the descriptor.
> >>>> +     */
> >>>> +    unsigned int hdr_len =3D 0;
> >>>> +
> >>>> +    if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >>>> +            const struct tcphdr *th =3D (const void *)skb_checksum_=
start(skb);
> >>>> +
> >>>> +            hdr_len =3D skb_checksum_start_offset(skb);
> >>>> +            if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> >>>> +                    hdr_len +=3D __tcp_hdrlen(th);
> >>>> +            else
> >>>> +                    hdr_len +=3D skb->csum_offset;
> >>>> +    } else if (skb_is_gso(skb)) {
> >>>> +            /* Work around untrustworthy header offsets in this cas=
e. */
> >>>> +            return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MAS=
K);
> >>>> +    }
> >>>
> >>> Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
> >>> the frame must not be TCP/UDP GSO since for those normally the checks=
um
> >>> and offsets should be populated. Have you identified cases where we a=
re
> >>> seeing TCP/UDP GSO w/o the checksum being set up?
> >>
> >> It looks like this particular case is never reached by normal traffic.
> >> It has to be GSO without NEEDS_CSUM. This is only produced by a buggy,
> >> hostile or niche setup.
> >>
> >> When CHECKSUM_PARTIAL is not set, the csum_start/csum_offset fields ar=
e
> >> used for csum instead, or left zeroed.
> >>
> >> The transport_header field is unreliable when a packet is being routed=
,
> >> so you would need to parse the packet from the top to find where the
> >> transport header ends.
> >>
> >> Rather than walk all the headers for hdr_len, it seemed prudent to jus=
t
> >> categorically deny offload for these exceptional cases. I could be
> >> convinced otherwise.
> >
> > The point I was trying to get at is that the stack shouldn't be
> > allowing those sort of frames through in the first place. Basically if
> > checksum partial isn't set the stack should be rejecting the frame for
> > UDP/TCP GSO, not the drivers.
>
> I agree that this patch demonstrates how obtuse it is for an
> ndo_features_check to reliably measure header length, which is something
> that several drivers need to do in the hook. The issues being worked
> around should be fixed in core.
>
> GSO without NEEDS_CSUM is the biggest offender, no driver is checking for
> that in their implementation of ndo_features_check.

The point is that it shouldn't need to. It looks like this is
something that was broken over time to first enable FCoE and then
GSO_FRAGLIST. The way it used to work is the code required
CHECSUM_PARTIAL only.

> Using a potentially stale transport header is next in line. Several
> drivers are getting this wrong. I'm working on a fix, a simple reorder.
>
> >>>   From what I can tell it looks like the only valid cases for it not =
to
> >>> be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame a=
re
> >>> FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
> >>> anyway.
> >>
> >> FCoE was switched to CHECKSUM_PARTIAL in 253aab0597d9e
> >
> > This is part of the problem. It pushed through the ability for
> > CHECKSUM_UNECESSARY to be valid in an outgoing TCP frame, and then was
> > reverted back to using CHECKSUM_PARTIAL. That is what is partially
> > what is allowing the non-partial checksum through for GSO frames.
> >
> > I will probably look at submitting a diff for this next week to look
> > at limiting this as there are a number of drivers that already expect
> > all TSO/USO frames to have CHECKSUM_PARTIAL always set before they
> > start processing the frames.
>
> That would be great.

The one thing that it should change about your patch is that you won't
need to do the clearing of CHECKSUM_PARTIAL. Basically if that isn't
set you can assume there will be no offload requested as GSO will not
allow it through unless GSO_FRAGLIST

I will try to push my patch out sometime today and try to remember to
CC you on it.
