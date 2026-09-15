Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3203DC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 19:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8AAA4055F;
	Tue, 15 Sep 2026 19:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktOTuzrjffue; Tue, 15 Sep 2026 19:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F40C34051D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789500654;
	b=Xh67uPzsd/c4RwN+EuCBOxtdLcf42Ihl4MweWZ+FqwXqyyRi+kwzdSgW4lccOajm2dwy
	 72y/J9cTCdILUwTKuqd3kohy6xeNAD9mvJrZ6MVV0qQYZK/EXb3HVpF7q9hJDDZiW4YL5
	 BUvBiEhd+IpR3EFdYmgB8E+erLuXy0SkJBbs53UGX5E4U58MfOhkft8+EXnt89iVxlznI
	 woUr6wzpFhhL3iXcJqDV96Ri3baL2wOYjvqwHR9XECvmjvxVQct5tp14dDF1nPNscaxIL
	 hqpp/hXwtzONFIDnYB/YVXe6rptVuW6kpOhbKvMYtEsmP07Q7MKsrufmmGNILUvd7Xw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789500654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
	b=mThtjTBGwX6hGH+0tMblSoyPlWW4uW46s6/XeN52wveR2l5stLMumfXpCyvesQGMnVIH
	 lRWG1Jt2T/vXWNNMoMXfsy4JnAkdu3ZDj0dkozszAfJJPYTxsAQigeF5ZIetY3w35+MnJ
	 SRDIrDejDVTjJQ0Rs+nNVU4QinkeSNB0y2YwFa3H0x2hzyuD/PB0u60EIs8Y4IcKhtwG+
	 Ta/JfdB+0XYD66X0aPfYv3xX26Ln7E1EmfI+HaXKrUuJ4b2fMA73dACaEjWAG+eP9CGsL
	 BlEKtBTOnMHhQnDTsYEWrgfqjUwow3vK8575YEDnB5hwndPxO0JQjQBmhcILcg2xifw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BAJ542YV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789500654;
	bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BnQGvNXQFzEoUH2ClKXvLOvWP1z5qLv8Am6vC5xsyt7+527SpUwzg83RWVZmd6ERU
	 hU9a8YCRI3/6uifoNMXTiFL/wSxx+06/nglcxmWIaI/qyCE/lJTENrtxVEx24JqLKh
	 tQfr3g+j0WaCwVJ6PPMyxvcWfOqacsyu3Nbff2L3QaX8xHqg2Nuo3ufVPTU24/c1zh
	 QOO24b9KU1PVr+27WJgP+72ufrpMde7e2g7kO/PWNFCF0OENZcfizaKyOYRVzceYTy
	 bEJp7LoAsce/yknEBaufqVAFKJDdZjns5SLsUZflYxIQtrVczR2gxvk09LooXqxji4
	 y+pvB9fnrQF9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F40C34051D;
	Tue, 15 Sep 2026 19:30:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A98B2E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C7904051D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lqSVWofkV4ZW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 19:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4422E4050E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:3a::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789500651;
 b=EX5akfiEA55qa2ZRDg4hqA85PnM20wHXmpq3qO7DbWjGHmW2Nm9YsNBPxdix4+dXypjK
 YFqbX+VLtTHoz02/IiTz6+IGiOJjzMqXc4m4RGYVtnJbphZJqoDxS4JQw2P9FsjBpTA4e
 DqW82KVppKfmyWqG+QtPjEruoReeHVchJDdb2JLzexflwXUGMJ0j8wDDixDDTV7tn29yc
 JeZOnuKbW0hOTqWbkKTxv2zdcu+BxyUd30nL0ZC/ZjBByYqeywoofiRxJQfXCtZ2D8G5W
 r3TRtQ5ofAmT8sW/bhZH3e/pU1LSu4bpK9HB4iVZ0+ivkcSC1/Ei/satsmhvO8ZuvJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789500651;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 b=NHkGc57p+l57BvTbydH+3UDian0syFa0iqS7LvVMHXqyEQnQ9GZrSJUunw+RFuRlm8wm
 /otpIamdfsCGEOEJTmYw5aZq304iP/AO3OEVS7vpnt+d6nVSSbGBhr2Ggt+mRmi3TTMIi
 2J0iFKwp5tbTivzq1HRZczXkjBV/bYMJxnu3wv5pC8DISqjQmU4I5BQe+PTNgd49X4cbY
 IJ0D6xv6vzzSof7jPG8Bq/7yPeZVv0SvVdOLcBBFxkw5AluzESCvIZ78lC73xakSc9ggw
 jrtCeGeP/vAweT1AO6NVhLMuDNSPnjGEAU+T4/Dn8xVCKgpUROTXiLnZvK4U25m7d8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=BAJ542YV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:3a::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:3a::10; helo=mail-vs2-x10.google.com;
 envelope-from=morbo@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=BAJ542YV
Received: from mail-vs2-x10.google.com (mail-vs2-x10.google.com
 [IPv6:2a00:1450:4864:3a::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4422E4050E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 19:30:50 +0000 (UTC)
Received: by mail-vs2-x10.google.com with SMTP id
 71dfb90a1353d-5c67e504d59so53893e0c.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500649; cv=none;
 d=google.com; s=arc-20260327;
 b=Aj7qiNdUChDjGrgSEEUiWJjEGEB/f3f0nx2FDoJr1DFiS6X8o1c/Rsj09oKbKmr6sk
 Asm6YEpazCNPhVtWpz87LrT8W889wEiSFJ8yURlkUPBpms9lNVSfGD19ZnJEvZz1Ofb6
 4OK560ZTObzk4n203CBQlOJiRQx2ADbLYoj8nSOzDbesE01+e36PboK9IDkYobYdLwSa
 UVQgxy3xRLwKhJhy8B/1kZLmMHHUGYI49Ochuj1yGjRxrncOt16nZJLilvprXpfdB6Ji
 C70izxfTQXvy6OaCbMDXAtQKBbrjZEdIuXy+tsJ7+evY7BYilN1y4SWfgV2gOWotExho
 BacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 fh=Z1WXKMNM68tJHRV7gDXw95MJS0Ho30vceNz59nfS2iQ=;
 b=VJAMUGcsZmJu1KlavcpQsQ1QJjGkj3MPNvgDmH3VCgNlaWDP+gGlUe7WLIv59iadBA
 JNCWcfIBgTNSvdUyB8QJba12LYdF3pQiWW1RYB0wuRubQpti+OQGjHnobx/i+0Zae9HU
 FWb5HM390srcirpsJ47UoZ3LdMz4U+0e1RTNuQcrB2EsjRaMYKKhQfpVK46yQVgKLpyd
 xLShBXFOqUUxwb5mnwZSe0cisClJtwpz+2GRJ2vOcJVG7MUQmXhlduZkcS2NyEKQP2Kw
 q8wSbVZ+7RMzUqpzAqWs5PWZ9vtmzMD6Kdv2kULc1QILOE7gqpFhOCUdSXYdIM2uPCDS
 hD0w==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789500649; x=1790105449; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 b=BAJ542YVV75KRySOFjetegQ0ZSifc59A9y0oLuFsmA88WfImXpw5rayJEmtSZsTJtd
 Ixf6rsr9/OwH3VtY+0SZgWRU2j4RRl7ptjdrEnTQM+q8Rgwwp2HFNTdL4mX130FP2LiB
 gYbf9mvgpSKAoYLVeg7V2bB0LmXusf/yGe2EKJOVBek+eB7rUmx8w4fag8GPppzPa5Tl
 cxcLKo6HULJgbjj4ERw6iTE1C8ZYLBpEebUEjl7Vzbr2sXlVR22tHXTXehIgZ6w2b7lH
 JEgzmaksPxwHMmIb5qa+pUJUwsN8LZ4Q4lddzOf9eZL9N6/A71jhCRkyaak5WcMhi0vH
 V/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500649; x=1790105449;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bRLtXj28C7ZetbPCXePmHpMel3/nm53ij0hFxwsbjIQ=;
 b=VdmBNKQgD3iPH2Is9pD7PcTodZLbqcqi5lyy0i2v44OqMFm0VTCi/kz8A0X+hgt6ot
 8kV5Jy0ED0nU3BrswxK7myh2E8zvpN178Xf7pV4v5QQTHjUaUTt86iufyARQxv544HRM
 g5O7YnglT4XAyJXb4bPffWOfLeymbk1+63+Neqp1pLASOo/0eqMn/j865TicThtPetRX
 I4FSl3bjR1TV+YvajuUmXxPswir4i/FsGER04NNUcSiFKM96zXPaQz2QY68E/GI7z/br
 eH8VCqN+swzKFNfG3QMo3XCNvWhP+BacalF64x3AUS8MN2xlZvK39N+2es3YdngZKqiT
 KKpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJVeaWa9kgcvAtQfnQ2Uik6OOfV/fdoUZwE7zETQpEfvZYPVm8aXg+9gUKcA3kX2KZivlshjUUROHWQzWL3Mc=@lists.osuosl.org
X-Gm-Message-State: AFuF++nIf7kskIdKfylqs1YnqJqdIG8Xgf2gHnY8yWPoONPRzPjq7D47
 +SsqIyfOZx97bUx5YXEj6uGfV1SLFdyiRKc4xdNGraxIT63Djrqcr6Va9F1u9L+GEsewGeAlmmo
 afWrfRNDAgWHOi3LufG9U6nfIMQIzqpJr2TWSLKA=
X-Gm-Gg: AYBFou3NoiyPxyIKDybvNfYE/ztS/4Lz5h0LbiO/s3bsUfDwV9dr+1R9TeiGgotIQ0s
 3lULb+uIj8ZuRATuApG2o6RSjehs7Z3lSMpiDktB8chB+GgxyFQJfw9uqIrGGP/Cy/U8kwBHEhv
 FPLIJOk0ZqGQfuqITO4w9+uIII40YhfxzupBoPPeCjd+MkYj60YV0jIL4EIzTq8zFSDISEEynlw
 ej/bwB5i8P9KssmgYPfmMpSOMzbpxbnWK2vTX4zbQidQCPeVHKcWbtNXanrWqKa+iREaBc3kvgh
 y49jXhTsBlwDYjynHSDH13Gvx1X2DZkTnZNL1QNBTEfD9wm/wP6l274eZv5yvBwYxbyj2n2VwVu
 MTZTdbGJz3J/aHor3ghqzm2oArATBzNA2kWV0HxDFCvHDwd8ihHNNtsiDxUFyHVY=
X-Received: by 2002:a05:6122:8d4:b0:5c8:3697:9289 with SMTP id
 71dfb90a1353d-5c993b49b7cmr4231155e0c.8.1789500648289; Tue, 15 Sep 2026
 12:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
 <20260915081910.4142719-22-morbo@google.com>
 <202609151147.C5B45CB@keescook>
In-Reply-To: <202609151147.C5B45CB@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 15 Sep 2026 12:30:31 -0700
X-Gm-Features: AcwNN1W7vYosDgc2DMy2_OinBNj1qeEQ35WOY6PL8-NHlzjaHMOKmE1leyIGWNs
Message-ID: <CAGG=3QXYtmJqE5oy5ZD0-G0=GNxK71KKYurusNJvLQNqR-o6+A@mail.gmail.com>
Subject: Re: [PATCH 21/28] NFS: nfsroot: Refactor root_nfs_cat() to use
 snprintf()
To: Kees Cook <kees@kernel.org>
Cc: nikitash.mariiaw@gmail.com, linux-kernel@vger.kernel.org, 
 codemender-patching+linux@google.com, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Tony Luck <tony.luck@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Matthias Schwarzott <zzam@gentoo.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "Martin K. Petersen" <mkp@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Simon Horman <horms@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Kanglong Wang <wangkanglong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Qiang Ma <maqianga@uniontech.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Ard Biesheuvel <ardb@kernel.org>,
 Breno Leitao <leitao@debian.org>, Thorsten Blum <blum@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lyude Paul <lyude@redhat.com>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>, Imre Deak <imre.deak@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Johan Hovold <johan@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>,
 Jiaming Zhang <r772577952@gmail.com>, 
 Will Porter <mrwillporter@gmail.com>, Cen Zhang <zzzccc427@gmail.com>, 
 =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 Rong Zhang <i@rong.moe>, Arun Raghavan <arunr@valvesoftware.com>, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-edac@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-input@vger.kernel.org, 
 linux-media@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-nfs@vger.kernel.org, devel@lists.orangefs.org, 
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 15, 2026 at 11:52=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Sep 15, 2026 at 08:18:38AM +0000, Bill Wendling wrote:
> >  fs/nfs/nfsroot.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> This collides with:
> https://lore.kernel.org/all/27956255dde39f58d73a7b51cb53cbe3d7804f54.1786=
411026.git.mariianikitash@google.com/
>
> > +     ret =3D snprintf(dest + len, destlen - len, "%s%s",
> > +                    (len && dest[len - 1] !=3D ',') ? "," : "", src);
>
> I prefer Mariia's version because this inline ternary is difficult
> to read.
>
Agreed. I was trying to not stomp on her work. Please ignore this patch.

-bw

> I was expecting to land hers soon if the NFS folks don't pipe up. It is
> one of the rare cases of still being open-coded, but the strlen() usage
> was pre-existing to check for the trailing comma, so it's not a clean
> seq_buf() conversion candidate...
>
> --
> Kees Cook
