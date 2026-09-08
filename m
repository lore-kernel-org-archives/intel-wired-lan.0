Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1402C79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 16:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90AB880A70;
	Tue,  8 Sep 2026 16:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4wZf04V4evse; Tue,  8 Sep 2026 16:19:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D189880A79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788884354;
	b=ebRwpWdywABOQM8d/yslVLLN1IrklFAPXXaVUESpgkwhD2Tq7E48UofJIdyNUKuReVzS
	 hP6q9BQ8boBBpyy0m5NbaKEWNKfj43XJnpbkmLJYi+2fUGUtfC5HYN4ecd36aVG53Jp5t
	 LwWsXqfUyXI94O7oMstuxZ2bjp+GYWoieAws4oyj/Q+oyR3PhFLd3IOnxqsEm5p+AThEl
	 uwJuqIRmf/0W9EDbCOacZRyRLRak+qbDf7yRjxlUe9qc+3Jk18ZFRqu+a4HmyFFiL2X7V
	 tCJIKtKT3SSFJWY9J2rIWOWrGonM6UY+BLyAOo0giQ05UiXhZkWtZ7G4iOcYcjoO9Aw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788884354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yepOPbk2xqrS2qH4Rao8LR9xXZs/RGCAVI2E0/TV1ao=;
	b=ppwrK/Lm6JD/rwu0tJ/e6vx+Ag94vHtdOv1ShbVQN8gor+2/ic0j8Cc8LPMwrZy9KoTB
	 buCDhROlZ/+ZP8wLU8nt49441Dh6nXjxjZr5HqIoAGohGJR81SXh39Llm1itzyzDYYE10
	 y3ptNIgj21/RTBLq2o09d7mL+7nBhhnVWfNxnD75H8vi1CNCmKSZxlen7Ood4QX/Vv0kf
	 4xr7b49cIVBn0s9RN59Dsby+l2aO4BnmAung4B4TOYUooLMjcftl+usJB6abAZFfZnPzn
	 ins6lMXvGA3HhM7B5XNf7yM86SYkvc4JiwFYbv5wfeNNVOZPIkmpHchuQ01SeamC92w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dyvMtdSy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788884354;
	bh=yepOPbk2xqrS2qH4Rao8LR9xXZs/RGCAVI2E0/TV1ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wtS51aHqQt7X83GA78Ojb7xCilcS0umolz9bZMRVZT7TIzZ1uSsBRK30XCszVxOei
	 qD3RgybkQjL+22Ei7qfv7IoU8/GORXCsVsdSDWgWe8RLBratW3xJMav8zocLrvEWqD
	 Fgi3qKbvVsTcy/b8q2TXk5L9vXSPX7JlFKp/wFQcNk2WsZVNubJUQjBlVaIGRNraxj
	 d8dgF8IqIn+12OJb7yuNdpiVPBYk5IyLG8JFzNGIBdXSmMqeQImdNUtjiLn/5UO73R
	 vCxft5COXhuX9JVU/QSemrxEBmyWxDe1/8XmjFxw9zF/vELjPyzw/5UwxOgTc+nUvt
	 trN9YxMOPtc2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D189880A79;
	Tue,  8 Sep 2026 16:19:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27684230
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 16:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CD6380A79
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 16:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kO7CFfnKcBTG for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 16:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EA84380A5A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788884352;
 b=Czpt4hh4rNwAc91S2L3A6I+T2Vf+JUYACzYDM8EIwJHEiQRI81tFEBEx8/utWLjsr9QB
 MyQnrvFFYE6aRvN5OXJRCqI3JR1SLyTLKIs9qCLCfufqZ1vw0sd9M3p3hVaZl0M3o4CxZ
 X/FKQm+NFcag35NfwEfeYJdddoEgxz8O0LQ3lNU96DV2ycOqekdrTr+GU1pCM7o60uBUN
 8EVo52ObNeNXHqX2gAtHypjKS38+fgWF73wjZlGBTM/YcX3xW2Ytq7La1nRlrx+cL3lGW
 /3eo7fXGKo7XUTdf4x1IyTDptok7uGTRyyr1Yltz5v3dmcT1SGvnMFjBvpKzSoB16hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788884352;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=yepOPbk2xqrS2qH4Rao8LR9xXZs/RGCAVI2E0/TV1ao=;
 b=TfyR6cBlHXCkLZ44DYk27y7mLCJ+3x1uSLzsZ3iD9BSPk0uCn+yIaHzGguSVsfGDbhmZ
 87pUvNmZGlwQEfXljhpl8c2SXqNj5ejAJJztWHdLJjotGPU0/PNSP+xLplOdIZB7G7Elo
 DDRucfCgf+O2u+MIg0GOUS1l+cZoZPBcTCXFR3m7l2sSP4S7TSCRkhQPQW8s0fmOsp7xG
 NcCDLncLSY9Tiej9MBwCqdk6m+It3n7jySwCUeFkc0bOn9kmzQqmGi7yE54kBI5t8ojaS
 oOCyoISEcKaaUHioF61aci9WqqBItOsAZtWQZ18Y3RNO6MWBMTm8+cJjZIHVTLQxEPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dyvMtdSy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=rivaldihormat@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dyvMtdSy
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA84380A5A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 16:19:11 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9b4b63so182964fac.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 08 Sep 2026 09:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788884350; cv=none;
 d=google.com; s=arc-20260327;
 b=fJbnv5tnrf77avHGS1fxbVhJprn9APMwQhfbu8F8D86gVmL9m+rNV5qnq+tGl9bKGr
 DtY+WV1FopNuyhgQcUaEjQHXNldU/J+z2wEVPjweMhgr+jVswrQPE7CG/slBT2u/7BaJ
 5AHFrA6tEPPuXrXdapvXuj4ecnglae2lW5RDCdBQfmW/WWqspKOnBneDPHWaZ6lncEJH
 yAz7/QHM/2fHPJX423TMZXGncPgRBlOVA8KwXdn704y2zBfSusjPUfHkQv8RTGq+nrdv
 Pz6iiVu0nYbYNVpg0jZtyE3dFe+eOSGnj2Q3u+knwO4Qe8TkYLr9CFUIsbl9lIoyPoBk
 T0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yepOPbk2xqrS2qH4Rao8LR9xXZs/RGCAVI2E0/TV1ao=;
 fh=m3O/YGA/LNkdRsUa7Q88JVBJ4ukkDTTNJHGnz/sQFBE=;
 b=moe3WVD5//ImUWzDtGlExBoMAAiUS1u/70p/oSDXbzJrs5hGg9GmfwUGEsBS4cDddX
 mh/JGRAiXhXqx/yLzSldrBPRrugyiuJcbJVhKt6uXs7o2OU7T5GZIHvD0bpzg5w6c2QF
 I9H0JGU9tCEg1TvVuyaRyWezbvCwhBHmNJMqRKdVZfTyygxng08RY5mzgt4k8E3LHiHK
 NIAAq7a5Q5UHNiR/nD4EfeuNeEWlccAD11xzcs6v3LTSmNEOg7/KSxGpJ01UUpEV5OHI
 xXGL13AswtkhAcnr1CSn/2Ur+Vw3QqDuLEpPgC9ME3bF1FOyimAIBhjoY+qkOPGjhpd+
 zeKg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788884350; x=1789489150; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yepOPbk2xqrS2qH4Rao8LR9xXZs/RGCAVI2E0/TV1ao=;
 b=dyvMtdSyijNodAbbaG9N748YcYOHOnphSHDD4B/hyqTWQkl8aZD/j8dYxjJlBz040L
 X534Hw7cWB/MV1jUsW4jbV1LIflIUjIGJKAG4zPJj0VwW2kUIs46l1HEDA667cg27fF3
 XuIaqJ6OJShOOhyKl/dHJazWpEr0I1Hw+w6jhP781QAl81gNzPzqfrev199HdYu/pqoK
 KqL3rOypprjuWMdgGMuxpr1qNM0x687l22wAcRyiF+iSpm2QHNyce61LX86rgUpliwzQ
 2of3+AR0uLNl31uS/BoLJXsxS4Ak2y8+ABz47hJ7Wthn9p/m9wQkwOdt10om4sRTuJG0
 O91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788884350; x=1789489150;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yepOPbk2xqrS2qH4Rao8LR9xXZs/RGCAVI2E0/TV1ao=;
 b=TSONmxmv9g4Wqt9fUeexLQZqqT+E5UTcdFMV7hHSL94WLPaklmcytwgaozSzlmecMB
 oEwcOBC43Y/+vegwFn7qsa2zTElGNEdtgPxsL20n2XbwsxP0Jn8/AyRYcs16lvDuEmwh
 QwJfbnT4sG42qG3i5cjl/RTwesNR3ytIQ+fhK2z5iclGTd0itLLr3ON6XqoOGz/d5qbd
 QjJT/1MwL49WiDOUFpnj+Xg0ZFOzqKrha97WSiD8YeW7YH26voFtt/pfoWd3DyM1lr8E
 xSZGrpqNS57gTWEGCHUlh3B7ZZ2pTAR0AWjZtwwoUurlsdrUD63rnLqefSkmPMaFF9FK
 zAmg==
X-Gm-Message-State: AFuF++kalHmVoWuUmwZHF0kra2f49I2YtkZT+USjq8R9oynj9W4OzhR0
 m/cJ6919PgG8LVgfBRSYOoillwd1mJj95WwFCkc0w7uw15yJpQPZflOIZQqUd2oyNKZgkYvGDHO
 yLbZugAvyEd+vaNySEIoi1eZaSr6aosc=
X-Gm-Gg: AYBFou3gpvr2GHI3iIN8qW8YP9ufT5SLPouuLcU2WsMYMPkEoRCz3L5wXbRy7b9pKdZ
 x/3k2/QiNCv714tjkmM5AzJPd8BSB1Kpp1Mqu6CL0IfA0Fxs943t9HE8x8n+H9DfNmYc6aclNxm
 hGMnwHEpEZrBbOQEVPtjMGJDGI+m0MSEhfzH2yZUFX71K7S0gcK27nXBLxER1hBuQLHyWsU0lXa
 K3qkSBdg5PWtNW2BRfYlRSsgj76SWxsWXjvFpy3VUdXZ2VgSSH0WOO3Sr3CUs57pqa64ry+Kpsh
 nEESNm2r9E46C+W7+g+9iBEvLBrINqBmo459A10ttOP6
X-Received: by 2002:a05:6871:a852:b0:46a:6a57:2bf4 with SMTP id
 586e51a60fabf-479df6ac2a3mr2785044fac.3.1788884349993; Tue, 08 Sep 2026
 09:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260905163144.17069-1-rivaldihormat@gmail.com>
 <IA3PR11MB8986B28E945AAA687B05BB36E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986B28E945AAA687B05BB36E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Rivaldi Hormat <rivaldihormat@gmail.com>
Date: Wed, 9 Sep 2026 00:18:55 +0800
X-Gm-Features: AcwNN1VBiVpTV7X29XE2QQy6-grgpLOhDYJlsYNHxljj5vBAxJR50AKJGNR4Xg0
Message-ID: <CAOiPs2DY+_1KMtdLF1_=sN9gRK=cOVxPF=WcWJ17f5s_--MSAg@mail.gmail.com>
Subject: Re: [PATCH] i40e: fix integer overflow in i40e_dbg_command_write()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000039c62a065afb185a"
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

--00000000000039c62a065afb185a
Content-Type: text/plain; charset="UTF-8"

Dear Alex,

Terima kasih atas masukannya. Saya sudah memperbaiki commit message sesuai
arahan Anda. Mohon maaf, patch v2 yang benar (4 baris) sudah saya kirimkan
ke milis, namun karena kesalahan teknis, email tersebut terkirim terpisah
dari thread ini.

Regards,
Rifaldi Hormat

Pada Sel, 8 Sep 2026, 22.36, Loktionov, Aleksandr <
aleksandr.loktionov@intel.com> menulis:

>
>
> > -----Original Message-----
> > From: rivaldihormat-debug <rivaldihormat@gmail.com>
> > Sent: Saturday, September 5, 2026 6:32 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: linux-kernel@vger.kernel.org; Rifaldi Hormat
> > <rivaldihormat@gmail.com>
> > Subject: [PATCH] i40e: fix integer overflow in
> > i40e_dbg_command_write()
> >
> > From: Rifaldi Hormat <rivaldihormat@gmail.com>
> >
>
> Dear Rifaldi,
>
> Thank you for the patch to fix the integer overflow in
> i40e_dbg_command_write().
> The fix is sensible. However, please ensure your commit message clearly
> states:
>
> - The bug: An attacker or local user could trigger a buffer overflow or
> integer overflow by writing large amounts of data to the debugfs file.
> - The fix: Limiting the write size to PAGE_SIZE.
> - Why PAGE_SIZE: It is a common limit for debugfs writes to prevent
> excessive stack/heap allocation.
>
> With the best regards
> Alex
>
> > Signed-off-by: Rifaldi Hormat <rivaldihormat@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > index 0b52509cb14c..74e75504fdda 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> > @@ -722,6 +722,8 @@ static ssize_t i40e_dbg_command_write(struct file
> > *filp,
> >       int cnt;
> >
> >       /* don't allow partial writes */
> > +     if (count == 0 || count > PAGE_SIZE)
> > +             return -EINVAL;
> >       if (*ppos != 0)
> >               return 0;
> >
> > @@ -1605,6 +1607,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct
> > file *filp,
> >       int i, cnt;
> >
> >       /* don't allow partial writes */
> > +     if (count == 0 || count > PAGE_SIZE)
> > +             return -EINVAL;
> >       if (*ppos != 0)
> >               return 0;
> >
> > --
> > 2.53.0
>
>

--00000000000039c62a065afb185a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">Dear Alex,<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Terima kasih atas masuka=
nnya. Saya sudah memperbaiki commit message sesuai arahan Anda. Mohon maaf,=
 patch v2 yang benar (4 baris) sudah saya kirimkan ke milis, namun karena k=
esalahan teknis, email tersebut terkirim terpisah dari thread ini.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">=
Rifaldi Hormat=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">Pada Sel, 8 Sep 2026, 22.36=
, Loktionov, Aleksandr &lt;<a href=3D"mailto:aleksandr.loktionov@intel.com"=
>aleksandr.loktionov@intel.com</a>&gt; menulis:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: rivaldihormat-debug &lt;<a href=3D"mailto:rivaldihormat@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">rivaldihormat@gmail.com</a>&gt;<br>
&gt; Sent: Saturday, September 5, 2026 6:32 PM<br>
&gt; To: <a href=3D"mailto:intel-wired-lan@lists.osuosl.org" target=3D"_bla=
nk" rel=3D"noreferrer">intel-wired-lan@lists.osuosl.org</a><br>
&gt; Cc: <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank" =
rel=3D"noreferrer">linux-kernel@vger.kernel.org</a>; Rifaldi Hormat<br>
&gt; &lt;<a href=3D"mailto:rivaldihormat@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">rivaldihormat@gmail.com</a>&gt;<br>
&gt; Subject: [PATCH] i40e: fix integer overflow in<br>
&gt; i40e_dbg_command_write()<br>
&gt; <br>
&gt; From: Rifaldi Hormat &lt;<a href=3D"mailto:rivaldihormat@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">rivaldihormat@gmail.com</a>&gt;<br>
&gt; <br>
<br>
Dear Rifaldi,<br>
<br>
Thank you for the patch to fix the integer overflow in i40e_dbg_command_wri=
te().<br>
The fix is sensible. However, please ensure your commit message clearly sta=
tes:<br>
<br>
- The bug: An attacker or local user could trigger a buffer overflow or int=
eger overflow by writing large amounts of data to the debugfs file.<br>
- The fix: Limiting the write size to PAGE_SIZE.<br>
- Why PAGE_SIZE: It is a common limit for debugfs writes to prevent excessi=
ve stack/heap allocation.<br>
<br>
With the best regards<br>
Alex<br>
<br>
&gt; Signed-off-by: Rifaldi Hormat &lt;<a href=3D"mailto:rivaldihormat@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">rivaldihormat@gmail.com</a>&gt;=
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c<br>
&gt; b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c<br>
&gt; index 0b52509cb14c..74e75504fdda 100644<br>
&gt; --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c<br>
&gt; +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c<br>
&gt; @@ -722,6 +722,8 @@ static ssize_t i40e_dbg_command_write(struct file<=
br>
&gt; *filp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int cnt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* don&#39;t allow partial writes */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (count =3D=3D 0 || count &gt; PAGE_SIZE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*ppos !=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; <br>
&gt; @@ -1605,6 +1607,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct<=
br>
&gt; file *filp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, cnt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* don&#39;t allow partial writes */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (count =3D=3D 0 || count &gt; PAGE_SIZE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*ppos !=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; <br>
&gt; --<br>
&gt; 2.53.0<br>
<br>
</blockquote></div>

--00000000000039c62a065afb185a--
