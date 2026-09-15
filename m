Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600B9C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A6B680CA8;
	Tue, 15 Sep 2026 17:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MjH6ICwSL5fq; Tue, 15 Sep 2026 17:18:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 472F080CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492684;
	b=a9nWsqsMeJOzon2m4MsyQyOkgiOM8qScYa1grM9Z8BPgfllLU/xrQjeRxg4q6b7m3e4F
	 Qw9oqNd7DExfjHQf54au2ma0/TDVThEO4wUFRCQicrtsB0Mlinqq2TFOUwhjP150LvmH5
	 rYOD2ECgAIFnGb1ttomZReLO5Ezr7I2jO7Aw1HVoPhx7GzRsnl7YeQevSk6CdASBeIYVy
	 MwXsDdN2WebHT16w8+IFf/ctMHO0EueMiDfXeQ8ywip5fEyxN3HBPByx4bOWL7RLZhdds
	 Oi7J33AtJTv1pWrkeGHt4CgamTCOX7DaA1/WDZw2+qzhGXxPFHeXrwtEPJOikPX2ggw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LcsuffwFDxj4u6SThnIq1nFzZdsoWr9GB9tsbe2KVjo=;
	b=XBPuxJhNSd0ctPTnXXz7FBPsI+koXtSd/d9R0/123VAQFYfidqm1S+b0XYOQr86JO5J5
	 HPscCGfyPXN6Nay9zagoZQ9aPzSW/g/E50NYrP8gaUV7WzN074NIpELkT9FRFibEWK5BA
	 oIZNe2tqcrXwS8R4y0k/nsrKUeW3gwGvdT/3NKnpDDBBMRI/QJIwEcWQtXO6kA208eNh2
	 ET2hM/y17WCmobT3U333Czhau0paWqkm+kAIlsZdc1QQlOMzqmcczQocTorj111BmWZ3c
	 cMtaghRoqBMMx4Yev1s6naZ9QSTqnWtgeFQUJ84i+eA+Q4VSVrPxZutjbF2rbIfEpOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492684;
	bh=LcsuffwFDxj4u6SThnIq1nFzZdsoWr9GB9tsbe2KVjo=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Zl/6otbRcqRJHAKTYmMJYkn1q06UNaHvDbHYwNTRXiXPEch8ywr83iMiUp7oYs/y
	 MAgj9v1WXIuBj5LgWiPRZXg0LxKPw1sOWaViQnRzgyJDb6f4gSIE+SCfpuheV0tnjK
	 zrKUT6/DhkivQct/MonNDliOsCNvbmrFiZdBPUWT4fkeYQa/ffLAsvKC3f8T5FGBnG
	 8Sc7EHv3erj+8J+gNrwpVp2g4v/QlESliZRDzDo7BGmGslhr+QXzm3c4Lbiw90pnqv
	 n0bBkwmHYAy404IcoZlnIwMdfv57Rz0N5wCLLnhHCYDWQBMQbzwaKck34lAFYOPnQo
	 p9NbKo30/hhCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 472F080CB6;
	Tue, 15 Sep 2026 17:18:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 496B5493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BA6B60721
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qakGe5-sEwdR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6633C605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460418;
 b=inm8DFMle9Ng0eI8oFdMk/sFBOlHewaDWje9NiJaakMMTS3SwXQ8+15KkH28uNuaxRKK
 ODRyyXibY/nwaBvnmwYCWdEV3/Hfm68Iu/TE3TctP1WOZcl5qeQwjk7G9oYxXK+vRdZMH
 tg7sBsNCBaZQh5VCFg+WrIS4BnQxBOczZlmy7zsI9GlE+OgRdvF9p94tnjOVvTU6u3SI0
 +8svunHQxB9QG6Y81iISoMMGqYgsSVMsJ5kTw/g5V3DDflwxM7muvbyHZ/HSXYSMAoCA6
 ARievzfLD0pmVr7pd8qG9M8OuSPUzg33E+IC73EcTvVrVnLe6wGP9uXPSc9I/hcVWqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460418;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=LcsuffwFDxj4u6SThnIq1nFzZdsoWr9GB9tsbe2KVjo=;
 b=Ze0Lj4Q0KccV2wwVJtTvLqhtrv5cbO8kVHujk0g2PEqgrnKArYe30RAV2dx9zJ2hGMBv
 +60XOFlJe2IBymQPXYczHSIERoxknQVN3dgbWyBk/zwFvnV8SmXufbwlXze2NNidU5mla
 eG0jpwTnQCU9QcyMWmBxpTM2eCMcEBot2ZfZNHLE9CigpuzpEoNmZKYJW72OP2PDxnX58
 LzzEvGL5W4CVVXCrOYR+Al/pliaV+IBSX7uhw9b1TU6Va6yE08LH/AzwvWEvWZJ7sg3jl
 vmUtIQn6dmC0TbNlg96NlJCi/FDZhtOmP7kfCHKSiwKkNog1mkl9SLfWZO/ee5/fl1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=jAgYuJHk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com;
 envelope-from=3v_-oagukd74qsvfsksskpi.gsqmrxip-0mvih-perpmwxw.swyswp.svk@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=jAgYuJHk
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6633C605E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:18 +0000 (UTC)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2db8e9fe9c7so60583125ad.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460417; x=1790065217; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LcsuffwFDxj4u6SThnIq1nFzZdsoWr9GB9tsbe2KVjo=;
 b=jAgYuJHkzf66/ii8Rh7SaHrLoIVJoyPC/QM8OwJ74McTI1cLKeJ4Naw70R4XMUC2q6
 KQWfTC//w42Pz/DJrCutCQRns1/Vs0ecrq2uISvp9edJv2mpCzx9/q6P+5/2/6yGKAQ+
 bnuUppqzTcCnuEXvHEyrY2FJrb1t8LAb2mMUpMflQ4xbCZvQ3oXzWeMXbZ3tcoOfTeTj
 +uJqX4zqb0apTvaQ1+CLjx3iZenfcG4WNq9jTsAurGIMr+S6LUqbT8dEQa3YZYtzo5Uv
 EAQbFPUKJiWf7fR02CD8lmIVsmTOo0ON+EUCC+MViFnX1IylCNHzyWF4sGy2xnNpmt22
 a6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460417; x=1790065217;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LcsuffwFDxj4u6SThnIq1nFzZdsoWr9GB9tsbe2KVjo=;
 b=AQswPKsNSkNtF2qO5cQdzJnP3RROPSznNGCrqlIZPxju9rxLpdjqSxoNkHx44QEHLP
 y7gXo5oghg7baQMqzW1HxKL4eGSBZA9I9le5yaRQyQSlsL0JUctPWz9LzTMZ6QFb+tyz
 MTdGXbFNfSCgGBTYuYvaaFPd1OEOF5s1Sj0lRUVxzmUaCooZAfdl+2k2ts/aEOLlp27Q
 DLTYq3D2VyAyB6BLnOMf+U2upDuNO8mrNgxP6kEquMB22KFdBgr5Pnyty47aEjYKL4oW
 y/ZgXZJvu7atWjFKZIBTHYq1HjpYMLySfea6hoKx33BZj+vuUcvVl3wrrNTjIjji3Tdn
 hQ2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByFntX5KU6Bqe0Lg0s2HV4qcohHWj8zUCj1k4wzKLTIVlmKpkXwNlM+QyG1VtudkkPcch+E2lcboIfGKRbaivY=@lists.osuosl.org
X-Gm-Message-State: AFuF++mopdRDTdsiXnQN3v/8ovUZzSUqgjnoPTgtljszqFClAJI1Cprf
 guZVd4sYHVLOhYWDaYrv+D1I0Mz3LmTtaK6B880aMcqvHQbqmRwTsGdptfeO7rr+gcqv6bkp5dz
 t
X-Received: from plxm10.prod.google.com ([2002:a17:902:db0a:b0:2d9:7bf:6891])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b50:b0:2db:8ae7:a5d2
 with SMTP id d9443c01a7336-2dd6c5f39camr129000865ad.9.1789460415373; Tue, 15
 Sep 2026 01:20:15 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:41 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-25-morbo@google.com>
Subject: [PATCH 24/28] EDAC/thunderx: Fix stale error context in
 thunderx_l2c_threaded_isr()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
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

thunderx_l2c_threaded_isr() computes "tail" and "ctx" once before entering
the loop that drains the L2C error ring, and never updates them on
subsequent iterations. When multiple errors are queued, every iteration
reports the first ring entry rather than advancing through the ring,
causing subsequent hardware errors in a batch to go unreported.

Recompute "tail" and "ctx" at the start of each loop iteration, matching
the sibling thunderx_ocx_com_threaded_isr() and
thunderx_ocx_lnk_threaded_isr() handlers.

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
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
 drivers/edac/thunderx_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 9c0a1e48f96f..e7c335ca0c36 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1880,6 +1880,9 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq,=
 void *irq_id)
=20
 	while (CIRC_CNT(l2c->ring_head, l2c->ring_tail,
 			ARRAY_SIZE(l2c->err_ctx))) {
+		tail =3D ring_pos(l2c->ring_tail, ARRAY_SIZE(l2c->err_ctx));
+		ctx =3D &l2c->err_ctx[tail];
+
 		snprintf(msg, L2C_MESSAGE_SIZE,
 			 "%s: %s: %016llx, %s: %016llx",
 			 l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
--=20
2.55.0.1032.g73a4cd73de-goog

