Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82724D2FEF4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 23:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFCA640826;
	Tue, 27 Jan 2026 23:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6EkuZLjEzTI; Tue, 27 Jan 2026 23:36:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52488408AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769556989;
	bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=2DFMWcr+9z5eOP4jLtex3ePJI8i9gimY/ZtRdDzJiZS33BRdj1hbyoil4KpteSerY
	 6KVeGoz4lzqjI7ye8P55Mb87x2+jl/IQY21Dymvj0EIyynaRMV5Nw1TsZn9plc8Lte
	 CVZ6hQ1F3B22QX1jI4qn6VUZJCpGIZxjuJ59GlPjCZ/Jkj2COJonx4JEdx6jeh6hm9
	 QyVCQo4vjROMGGOkuyfg/xBNytoDYl0RrULfITD0IohNwftY+ToIkDB8LVyfJ5Z4iv
	 Xl7U2O2M7rIdYC+JoLY8C3f0WPBeEi823GyUBx93YvhFu+UzWdoT5cALhDPr8kjq+r
	 J6Y9BcriY7Smw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52488408AB;
	Tue, 27 Jan 2026 23:36:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C268160
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 23:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1248760DB2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 23:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y3jTsOL7RcWt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 23:36:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=brianvv@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 56520607DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56520607DD
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56520607DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 23:36:27 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1233c155a42so9012082c88.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 15:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769556986; cv=none;
 d=google.com; s=arc-20240605;
 b=cVcviIqJBlFMKIFIlo69TdTgXM6uF9wRc4+McNlM5ww07SrMtvw6cX2El2/bpPPpJ5
 YHJgTsAXFQNidy9LyCE9f/v3d0g8aXTjYNj3r8cAIooTHBRi4NWMJQ2gGyP5QWnL9uEG
 3vD4HiOvKiU6vqyFCzWYUBeeQKFd3JE8EHycI4BKivphCzKz3mfHJUOgNSxq6w3Pwdve
 1Ifr10KvShRpNefnhq7Z7Ihn4uz08vmj3XqZjQDVi0XO7iXQ7fLIkXy1uQVutyHXvnd4
 hV9T/rMft3Zi3dDljOh/DZ1/mDFFslMTQx0lII2wRnwksF5GiNBims8FckZhokPUUmky
 24gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
 fh=lfxCX9poGsNvb2l4VY3l1Zl0OADOyxihc36we/fiecI=;
 b=LaNTLlnNY6skwim6epk5QWVtXEQr+WwiscAufYYBBirR1IswrpMI9n0CCKzf6Lwe8t
 wSWQT6ajMkgrIbzdMM4wJhD+vjM7Gjh9mk0ju0ic6o6MnIRL7x2Eti3qMOT+QK1LEI3j
 OBtjV1gP42RiJeetjC0d0MP0fuyrcLOHcqw8IAsrqa4U/ypQOeV0TI8wrqpBZ1VtZ588
 9VuZIVI8PYA2LyNiUduvMwqm6v/jTXQ4EslBZt6PSep1aCxISxaLvE0CK0IZV20FJ8v8
 9pEC9gtJPSVq3ZLmu0H0h5mBH0IbTGPIQdE+U/y4wPSyieGGHlNDdWB3VSJP0I0g4ZsC
 PXrA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769556986; x=1770161786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
 b=OTodm60wHjgRRoIXWAbL913R73Ia/hdx8STovuoYiLr0QOHliLPZz8jBOIoK9D/iQb
 ZgNlWQblwYsSVtVTd/SkyYmVAN0Kg4sBRq5rzdTD+EbgHGJWdlThj4vqBCZrU+TLssa/
 5QoqnoxDIwZuBer0xfU6/zfAmhXIJP1j+ga2SEVz4AgsGFnwhO8CKIpXtEwtXnRiaEPY
 NbMCLSIAvi+qhKd/o7qVzugrJ7WU8bBiS1Ee7vNx/Z7jKfevxh3vr1TU3ZQtRNUkGpXT
 eBsqJUuXA++PbB56h6lkOQIjCbVo/8dPM7dkK9RmyZnlVAvycmcP83KOPC4sj0p1HNKt
 YayA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw4u487SNmh3uvrUZy4jsRSDpc+B9qva7wXA1Gypqjk8nE5yGiNamjy+NmVgMSGvF1yAMxAHW70ymoCk6GtfI=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yx8uOg0XTg0PAyRGjbnpcynxYRen9xULii/as6oSogU6iXnWYOL
 kTFCBNdocNN5Yzpb96DOfy9qPSw/CQ1syGIN0FtwbXqV5hjdLgxB1uRpIck0+zcmaD38HfOYhIT
 8evunGXAH8qW63NoJLOIcp6f88WI+4Q1/ej3LtYQ/gSlbqSOF+I3wtA==
X-Gm-Gg: AZuq6aIHiAB+SiWtUUm5mdsy1vpp4XtgPdlOU7YOxxWp6go6lCpu+yWVrg5L+BrooYf
 qzIut9xHCzXU5Fbc9MfvxqP1KBB59wdWw0zorUt/3/c0+QQhkwCeuOe2jom7XjdWz8pk6Iga7rT
 QY2IsKBdo/8WxWO0JYXqeHkUsoqjID0nniKSA2dLF40gBWRgVekSdeLgBlWsvP4xBLv+RZ+3Nqs
 RQ8MGT2MqLR0bWpqkiVEuH4GITn1ZlRcmMN84pUkZ3UrLEEWVov27VEIgt8fR1wvWZb7Uj/TOXb
 6kcP8wA=
X-Received: by 2002:a05:7022:b8d:b0:11b:c86b:386a with SMTP id
 a92af1059eb24-124a005d23emr2116677c88.5.1769556985955; Tue, 27 Jan 2026
 15:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20260123204058.651080-1-brianvv@google.com>
 <IA3PR11MB8986BB2FDDBB664CB318FB15E593A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aXj652w2_ogi6ysW@horms.kernel.org>
In-Reply-To: <aXj652w2_ogi6ysW@horms.kernel.org>
Date: Tue, 27 Jan 2026 18:36:14 -0500
X-Gm-Features: AZwV_QjWoxjQ2IyE58EkwujS_Wda4iWgVwAJUWoQZ6k4jRVWrPX8AnwG2cxiXI8
Message-ID: <CAMzD94T=VS8J5A1VZH_KriY7BMHf90rrGEK=4Jyuzc3SxHJhKA@mail.gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Brian Vazquez <brianvv.kernel@gmail.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 David Decotigny <decot@google.com>, 
 Li Li <boolli@google.com>, "Singhai, Anjali" <anjali.singhai@intel.com>, 
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Tantilov,
 Emil S" <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769556986; x=1770161786; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
 b=jGlwAKrilrusk0MZ6P1WiG+J+jrd8VTSReDwVBT8EK8aTXM50IumcjgrkA0S7DYzKB
 6TFvLxnIbDQMUZCnacgSDtM7oFkEY0w6RRDE/bDM9PivGLx6nyONa15u+Oi9gsLgcztk
 vSgN8zqYUDST+cfvIpWzfmlF3Zj7rrstIuA5sz7mfF/tSXDfOMg8pcqYdQwcqqkkfGOB
 Ys++Ntc6sTvKzQGVCM1Rpty0D/gs2mPQbYjAffaWbvl0zwciV9dlvQamTibSCWKeQxPF
 5xU/sRrZx/ENwKsA1PRH4U1ntlmjIXv/kkkRiJC/ItO9zJShSTWlMpwruajPlUcImFTx
 KAZw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20230601 header.b=jGlwAKri
Subject: Re: [Intel-wired-lan] [iwl-net PATCH] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
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
From: Brian Vazquez via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Brian Vazquez <brianvv@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hey Simon, last version is v3 it does have the Fixes tag now. Thanks!


On Tue, Jan 27, 2026 at 12:50=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Mon, Jan 26, 2026 at 07:27:15AM +0000, Loktionov, Aleksandr wrote:
>
> ...
>
> > I think could be nice to have proper Fixes: tag, but anyway.
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>
> If this is to be submitted to net (via iwl-net), which I assume is the
> plan, then please add a Fixes tag.
>
> Thanks!
