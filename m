Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DB4C5321C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 11:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E75C40694;
	Mon, 27 Jul 2026 11:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkbdopKp39Xe; Mon, 27 Jul 2026 11:08:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9AA840675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785150530;
	bh=pV1TDUaa2YAV2kxJY3x35Y0FQXGiZRc6WWYevwzWDGg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QsW02e/BdMJqZPQqvOrffDxKmbxA0uNbEl5CGzZ2aughC3T1d9U8xICsgEwC4wsuE
	 o79LDnz2/zO6omtlpjTLBEYgaEHG/m7dPV2LhMZI4I7ddFPbjBNt3ufWig6rIN2EV0
	 ReeXJLT4x494x1OIjqfZNm+Mdw26ZcmCEAweaxMwNgtDfr5rQiWwu04VeAMbrb/oNS
	 tx2Od6+QBa7fpDu9w29i0VRbEqpyCOTMNwmcaCO6vchLv9ZjOVSXP+toS9GsFBnDYq
	 u0lfUpsrHTTNq7PaDmMQ96e/Pn+q/aGAswpzG/swNZ+OodwZ2Q6+LDPa5oOZkr0bCu
	 qGqsZl3RwdeeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AA840675;
	Mon, 27 Jul 2026 11:08:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 914FD26C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 11:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EB0840651
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 11:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CqN5IRS_Yg3e for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 11:08:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ekffu200098@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E7F9C40675
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7F9C40675
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7F9C40675
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 11:08:46 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81e86df8987so29997197b3.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 04:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785150525; cv=none;
 d=google.com; s=arc-20260327;
 b=Hcz2A2NSbVoQDZre/zzIaN9DCi/pRN5kcKFKumY3kemT9xAQGeGSLJoIRhxBUZ7fvn
 OZmX4pLK0vS4JoVzDS7YVVG+5Fsi8GxkMSiREVGna8S7upFZjdEc3M4GzYa4ONml6VG7
 iEXYEq7uVDEWoxl1JbmfaMAz4QS/jFoomlUA7+r2P1biqim+GEL4hCoq3Ntqi5za1NXt
 6Ki4quDromdTGCvT+41+Gl7bFBz+0ZSRtVzzBEYiZ20s+FLX/WJrJjFcgOyYe35Fxl1o
 BofwAq/mkYrG2umPmnIQU5tXimoIVx/kRl4lfxxT8+LRDfqQB1c7krtXbKS58+UapF4D
 1k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pV1TDUaa2YAV2kxJY3x35Y0FQXGiZRc6WWYevwzWDGg=;
 fh=UPyV3xZ54KA/E/sOeCPOxkrwu9lHu5VqoPs0IEP19FA=;
 b=bOJjyFK3GnJdmN/E/CvUTNDW9F9NV23fkUcIIAwDk4F9m/bNAeej7ghOuUlPvv8z3O
 uMqeW8IQDbgTbkG6TDsCUkf4qGwUsOY8J2st7Qvq+JbV0B/gMqRL5j6c01tbr4SGCE0X
 vcADef+iNT1Z9RLQzSm2YqeSK3XNPVoBe8GlIEvsWDTN3wz5/qxsIGEF+R9WBOe4M+Jw
 RwKMSUxLenwiTlXsQDdlmU7wtE/cTgPaxeG+jtkYnhSAK2vss/rrd9yi+vsx8NvrELo2
 D8HsoAa1jsb4QfKBVOM693dpnlFsx4GUesLZNM7CZFU7gq5V1F8mabIhfZLljsim8fwP
 XfxQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785150525; x=1785755325;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pV1TDUaa2YAV2kxJY3x35Y0FQXGiZRc6WWYevwzWDGg=;
 b=sUHDA8Dd1C0MdAxHeBmHguByS+Cios+kCDOA5FkqwNshZ2C3sga4Ml9Q1QJkCNsb2P
 5WXzBOyNAp/+6mJBWpfWOe6HPri3FE0N6QtQtVFvywMqphbgois6MiX5pocE5nmTtoRg
 hc38QxrjjemVePSsrb4J2pBh0an+DlCjDxRoWWVw+ovcVsOH00nSq96C5SZc7w0rj/Ue
 GKhkKsi1d7W7XtrIxeuluBM2zkigTu1iqeVx5BvHGdibf0UjpzR4hkDfK1R/5DiQmgzT
 gE4BTIJlU/wQAiVbcsDXCxmCW/tV+HLZ9a3kBXY+h3t1VOyD5uIP9j9zGKmPLHBXoCgz
 tRWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9gumSvhoHQ/l7uZKit0WbLvbXkqBwuLoEPZwbm7P86/puHUQX1eI0zDn9eWQGkufMyXwikLMfijkEs0YPU/g=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwbcYCuh84OW0eNy8IQj4aD/qiK9hk7avh4M4TC5Jg5b5gZriCY
 FgvqT4SAqWODiGVeKEy66Aez0Gd5N7bX0oHWb9GG4OP1AWTj901XDulXk3E2GtlL8iEeyJTng3R
 czLLvXtEtNBDtXyjgnPNH7rizZcyNL/U=
X-Gm-Gg: AR+sD10uOML1V9Gf5oruCSkbMEqXfKUqgdKs25tvKus6RYxMDTOuOAksLvq4DN4k3+r
 UZnX0tJmwCs3AWo2381IKJYAOaJwECnzh/VJhwtC/DWc+zAwy0PAnv2++h8mGcfexPlN7XBF9uS
 rVY3AcvTSisyHeNbidktFin/8RQZel8EBrzfi37G8EsC7shvLma/6nD6ZMmCjnf6t2AkuP7u7YP
 aycxaeuKUvgfwl3t5nYpFIM2QDxfHIcDfbEz53bIM0r8MCtq0PIdTE5Wr0=
X-Received: by 2002:a05:690c:3747:b0:809:86c6:ee18 with SMTP id
 00721157ae682-81f69e3978bmr27868337b3.37.1785150525277; Mon, 27 Jul 2026
 04:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260724144822.6af8213f@kernel.org>
 <0ee1ef4aa7daa908bf28397ccc639c89b6aabd9c@intel.com>
In-Reply-To: <0ee1ef4aa7daa908bf28397ccc639c89b6aabd9c@intel.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Mon, 27 Jul 2026 20:08:33 +0900
X-Gm-Features: AUfX_mzhfgKW48GB4CRuyNKliFu1x1EH8aDGDqYePXeE0rGOBX3Wid5IOU1hKpc
Message-ID: <CABFDxMFMOAZ_3kYxEGCutnGt1OSSmgvmwx-=M1RxGc3VGKORYQ@mail.gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Julia.Lawall@inria.fr, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Borislav Petkov <bp@alien8.de>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Jaroslav Kysela <perex@perex.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Julian Anastasov <ja@ssi.bg>,
 Leon Romanovsky <leon@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linusw@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthew Sakai <msakai@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Mike Rapoport <rppt@kernel.org>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>,
 Shuah Khan <shuah@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>,
 Stephen Boyd <sboyd@kernel.org>, 
 Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>,
 Thomas Renninger <trenn@suse.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, 
 Yazen Ghannam <Yazen.Ghannam@amd.com>, cocci@inria.fr,
 amd-gfx@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, dm-devel@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org, 
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785150525; x=1785755325; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pV1TDUaa2YAV2kxJY3x35Y0FQXGiZRc6WWYevwzWDGg=;
 b=UWpyBc6L6T3/qtpNpi5mpMobA8viUqkJhMot76xgJpheipbanG3mDosBeol2dmBzDg
 n1Jiu5RdxKMvTH8mNLeMvukW+5S7fJ9BdlWUmB63CyKNx1GNsci5DOGurbk0zxrKoNKH
 1Uk4PRjmC31CbgRVpoKWi7BLO9tLaY15ePsRh9U7gbzgPAaLzDgjyzKADbttC5oG81Fi
 VTiZcWAkV5CpbxY9gSMV/YCm3OfqRSz0PxsEL9eQgnh41FgJUFZSThhAXu46cU1FoT8d
 fLrApL4onMVVKroA+PPbDXDxN/BZfzrFt3wpCBsYvBQLFy91Um6lCB55F2m6ZaThuQvd
 2cyg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UWpyBc6L
Subject: Re: [Intel-wired-lan] [PATCH 00/36] treewide: remove conditional
 returns with no effect
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello,

On Mon, Jul 27, 2026 at 5:30=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Fri, 24 Jul 2026, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri, 24 Jul 2026 03:45:02 +0900 Sang-Heon Jeon wrote:
> >> Patch 1 adds a Coccinelle script that matches the pattern, including
> >> negation and constant-comparison variants. Where a local variable is
> >> assigned right before the check, the assignment and the two returns
> >> turn into a single return of the assigned expression.
> >
> > Huh, I thought we already had such script. Various script children have
> > been sending such "cleanups" in the past.
>
> We did, and it was removed, I believe in 1a617a8475e8 ("coccinelle:
> misc: remove "complex return code" warnings"), because people just don't
> want this constant churn.
>
> It's perfectly fine to have the error case and happy day scenario
> separated.

Thanks for sharing the history.

I checked the mailing list. The removed script looks similar to the
new one, but it is different. The removed script reported a
conditional return followed by an explicit return 0, where the error
case and happy day scenario are separated as you mentioned, and Johan
also complained about this 10 years ago.

But the new script only reports when both branches return the same
variable, not the explicit 0. So, I think the new script is close to
the restricted version that Julia mentioned 10 years ago, and it
should be acceptable.

>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel

Best Regards,
Sang-Heon Jeon
