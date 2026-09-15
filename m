Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29623C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3CE3606F7;
	Tue, 15 Sep 2026 17:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sqktx_MrrR-9; Tue, 15 Sep 2026 17:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D17B76071C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492673;
	b=KSHkbe5w/xvgFPqvgjXgrZbvWdOhC9uHnKQdcC4JUKm0hWnhwaY8j8oSNRn3gxfV2Ban
	 oQC4ZFKR3xFpRhMjwkjtErNWv6XbK6xb1Uj3HUHYdQ146mVtjtBG1sj4Q339tfFqGh6nG
	 DYvdm/tVEOTzt13Mp3oFZLNCDgAiKnRUZajQFkQ7y1aTkHTj/owhkwCTwSIbZyGsLLcyf
	 RyOd0Usp4OV6JNioxXFExM1eDTs42UqubPIE8Uczzt7a6TTMa/xyWfe0SXsZpFzIIwAsq
	 qVhCU+7FTz06prpY4w7sXgJwzPYaCzpM0t0ByQVDSPRFDfPwE4RamoyoEG39jyGAagA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y5tFxAHb/e8uKrTICVzoygvHAjZ6k748iiDqUmGJfRE=;
	b=TABfTN3Iy/7vD7Inm0Ymwgzw//I7heEcMG/8NH86dAj1O95OzYVOtpK6muYdtEqvVRGf
	 fow6ZrW2SGRIyHlYa1A0kHZ51w6WLO9kUEYitQIhyNtubqv4SshcPYEpDYhspbEFQnQkw
	 2LhmJtnN23CKYVSUVr7g1FAYM39euDt3HdJ289nT3xAexd0COb09Pd/UF0vzVG/Nbh73x
	 gKd/HdgLshDmwnnvE983qFi7gSO1dwOGPNRKrcrYjqEXoNd8jp1xR457PEOdDpAzpkVrh
	 CBvhUUjjB/Ii5CrjYQr2fYMLUYcezGhlf/dDG1Do3c4FFOQPYD/r+RXXz6gQjjiMs7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=YhmeZ3+r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492673;
	bh=y5tFxAHb/e8uKrTICVzoygvHAjZ6k748iiDqUmGJfRE=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5cSQ33lTSBYkN7qxbUbB323+WCu27d9KtRtprvhFogunTHO/LE3IXTe7h4+pEtyKg
	 elRaWptu2eotGniBYs3xWF/MilRCriqL+/EfYq8H+Ax9D/DFwpamXOZDRYSX3+sH9a
	 K+a4fFquO1BxKnVqkuCLf3BSR2nYtAvx0aLGrobvVMhsZ8x4EET/xRyXAyXuWG43Ss
	 uXpJ7GxcpT484Rz/LaGiGpGgFmmPygJcPWoe0BPww6iK1P8F7alBQvmtZNXzyexOsj
	 2e1WJfsFo+k6VJI6vfeHMeBysk2NtO1I3mi3JhCiDthHZ8TeGpbxBXLn6CIADlEnzA
	 zQoGqLUbefOnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D17B76071C;
	Tue, 15 Sep 2026 17:17:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4A12493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA60360681
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3SGB0R-WSknb for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C28AC605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460408;
 b=kOrzl4e8xJq2tlHXU00M9hYVG4mEf+Q6SQ1s46aIGUmeq6fJU7UNqjXSL+1aI68nRA7X
 poL2lXtx1JJhKg9RBRC4y//RA0eM1dHfZqDZejn43UWqlUCsIQCpZsx1M6A2iFdS9QR4g
 UeZSjHVulBJh03Y4i2zcB5VhU88GxqGuWAfrpNRvJVLvs9+tllMw8VP/YtiHUIR7ber4u
 qxwROXg3ohVSGbJEi097jLxqIX3hyWVKdYC8VxQX8ueFkRZpxd891KehBBLObUDyU+ivI
 179POLb+dur08PGVDCY4UeyaN9iGagLq2bFDSvHT843YOYYX7op+AVkElCUlMzwXA6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=y5tFxAHb/e8uKrTICVzoygvHAjZ6k748iiDqUmGJfRE=;
 b=pC0Z9UvPrnPw00ZB5Tbbu3ax9C5tmwSVkFz7Jd47/SnqhADBcXVDIHcdsD8OpfXjdCRP
 8u/x/dfUZrqLSb//Que8ppZlEsEEtIYdRwrYUfouBzyCtaQtRPP1YOhoEOg+Q55tR3UJS
 wgBwmPh6DGW+qcvxHUYAZnYh1WEp1pKKVyyXN0RAnV4XGll2+bRUordgnJ/JIsVSN19RU
 EADgUjmvK31qujGqxp61N2TSbKANfxj1v4VjZrL/msfdn0FOnHSm5iG6FLXt4GvFGTvMn
 RHb4JPGP3r9mKxxaMQ4lyV6035mv9Boe83W29as7nCxhxa9vUcXF9BCH4wur5IGmNEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=YhmeZ3+r; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3tv-oagukd7uhjmwjbjjbgz.xjhdiozg-rdmzy-gvigdnon.jnpjng.jmb@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=YhmeZ3+r
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C28AC605E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:08 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2dc92350888so72280965ad.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460408; x=1790065208; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y5tFxAHb/e8uKrTICVzoygvHAjZ6k748iiDqUmGJfRE=;
 b=YhmeZ3+r6OWxWJmcKsWq53rpHf85dsfOvwxuiVuo/w291APseu1dCRWdrzb3kS45Ne
 2sbdYgOg5M+w92m2/OcxL/FE45ydcvGE40ugU6whwlAMntK4eqTZ0YOY+nISo8DxDKoM
 ITBbrXwuH4WRMtiinxq6Tnjeww9uU0VKZHo4iacLXaVVC0CZv3HEtUARkU8NrHaea38l
 FgATsnvZvxjIDpn/HglB46I6mPIk693Axp0eVGACu3ZHtom7g8uBoyeZkOW8U44n0ims
 x+s1PPIcURf5shby2odDkMKrYkzsc1PEXXJ+5Yjo014GfEzMBSN9++jr6xz4XlSt7iYV
 cXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460408; x=1790065208;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5tFxAHb/e8uKrTICVzoygvHAjZ6k748iiDqUmGJfRE=;
 b=zh36tXom4IwvVUBfORJ1xzc12NTa75MWwHGbuIp9EsmC/NFDkT6RQiQ0lNV4m6buC3
 SWwk0QW85TApW6J7tsfZ0gE2OQOoxbXcmkdfoiOdcsE6wo0QCNnko2x9oDJbiXTiZ9xg
 dRoIf0aaADc/0j5prKJ2Ym3xM70R4J1zUqMILpBTPrWpLcgOa9W0hlgEo6XyV2CwWa/b
 +o1NOOc5uNieyVBwkTgq6uOHWeUpvE/cyD7ykNGUCz36YB6zier9aZWChj71cvGWfDeI
 iYxlyH6s7p16ngudNBaUGN5qOXlRTb83/aOQRBDtHyMfICgzB+UQTZXyR98D/e64B1ax
 K6NA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl1NnR+axv0mOlV4bpf5jyDXnFtEmUW40fQmGoRJzMWazVzeqDOUVAPsAN4C702wWon6DynWMjnWqcdyaAYDc=@lists.osuosl.org
X-Gm-Message-State: AFuF++m5rS5TWxtv+NREpTL+v0AqJ40DN/71oextJdvEszMmNsAMsMX4
 z8SdHOt5u/qcgo+uNW/YVdQWqW3g39BEZ7V0LLMcHX/xLMzTgpauRwwGcSxHfqmhMTv/YwmpbPQ
 M
X-Received: from plav12.prod.google.com ([2002:a17:902:f0cc:b0:2dd:3949:eb03])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c40d:b0:2db:5c0a:f184
 with SMTP id d9443c01a7336-2dd6c6fc4f3mr121827545ad.17.1789460406752; Tue, 15
 Sep 2026 01:20:06 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:31 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-15-morbo@google.com>
Subject: [PATCH 14/28] ALSA: usb-audio: Refactor append_ctl_name() to use
 snprintf()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
 Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Matthias Schwarzott <zzam@gentoo.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
 Kees Cook <kees@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andrew Morton <akpm@linux-foundation.org>,
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
 "=?UTF-8?q?C=C3=A1ssio=20Gabriel?=" <cassiogabrielcontato@gmail.com>,
 Rong Zhang <i@rong.moe>, 
 Arun Raghavan <arunr@valvesoftware.com>, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-edac@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org, 
 devel@lists.orangefs.org, linux-hardening@vger.kernel.org, 
 linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:37 +0000
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

In preparation for removing the deprecated strlcat() API[1], replace the
strlcat() call in append_ctl_name() with strlen() and snprintf(),
preserving its return value semantics (the total length of the string it
attempted to create).

Also replace an open-coded strlcat() call in build_connector_control()
with append_ctl_name().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:Claude-3-5-Sonnet [editor_update_file, shell_command_r=
un]
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthias Schwarzott <zzam@gentoo.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc: "Martin K. Petersen" <mkp@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Simon Horman <horms@kernel.org>
Cc: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Kanglong Wang <wangkanglong@loongson.cn>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Qiang Ma <maqianga@uniontech.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Thorsten Blum <blum@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jiaming Zhang <r772577952@gmail.com>
Cc: Will Porter <mrwillporter@gmail.com>
Cc: Cen Zhang <zzzccc427@gmail.com>
Cc: "C=C3=A1ssio Gabriel" <cassiogabrielcontato@gmail.com>
Cc: Rong Zhang <i@rong.moe>
Cc: Arun Raghavan <arunr@valvesoftware.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-input@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: devicetree@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Cc: devel@lists.orangefs.org
Cc: linux-hardening@vger.kernel.org
Cc: linux-sound@vger.kernel.org
---
 sound/usb/mixer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ecaa8bc08d7c..f64ecad4e77e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1722,7 +1722,11 @@ const struct snd_kcontrol_new *snd_usb_feature_unit_=
ctl =3D &usb_feature_unit_ctl;
  */
 static size_t append_ctl_name(struct snd_kcontrol *kctl, const char *str)
 {
-	return strlcat(kctl->id.name, str, sizeof(kctl->id.name));
+	size_t len =3D strlen(kctl->id.name);
+
+	if (len >=3D sizeof(kctl->id.name))
+		return len + strlen(str);
+	return len + snprintf(kctl->id.name + len, sizeof(kctl->id.name) - len, "=
%s", str);
 }
=20
 /*
@@ -2090,7 +2094,7 @@ static void build_connector_control(struct usb_mixer_=
interface *mixer,
 	}
=20
 	if (check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name)))
-		strlcat(kctl->id.name, " Jack", sizeof(kctl->id.name));
+		append_ctl_name(kctl, " Jack");
 	else
 		get_connector_control_name(mixer, term, is_input, kctl->id.name,
 					   sizeof(kctl->id.name));
--=20
2.55.0.1032.g73a4cd73de-goog

