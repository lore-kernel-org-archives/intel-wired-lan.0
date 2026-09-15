Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D7C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1BF880C73;
	Tue, 15 Sep 2026 17:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGCC1EdT7BrG; Tue, 15 Sep 2026 17:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A64BB80C53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492678;
	b=cJW8RN8G1jWLeNzzZ0AqREgvwuPxAvYmAFvKlVBjRrNavBu/YUmjseEW184iF2f5A0j0
	 nCIfGMxW704CQmrAjecrr6N2Hpm4KoIIRKqRu6Pl7wKkcKim9CmhpYv+Iiy6QsFzGy1DD
	 Lz/ojeLy0slGiMbJjNscocsEIKh+4btW0rJh2YHOZTfnnUtFCNviI8/Hgx2n/IK7pc+oz
	 cz39Mr7cHhrJH71kjfgp60oEzeApkHsMplqnk1z19l4JHMgZ3g9x6N2KDneAYdRTB6yrW
	 hHWCatVNche5lcV3eaqzMQYo5EfIoqb6Gg1Vg3O4VEKIafqid5JaCsSeDUhs3JgbDsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tzVl62qjzRm92BALDDypl3TnCOJSNAaLaOJ/zmWRh10=;
	b=QHTbY1FfURsCt3RbBx4aIUrLR81h6kxOfhnzk+8DBcCvh16azCMB58GbGG6YkmlY6lX7
	 xr3pFt0icqwe8wU5bs3MaCzgLOcPCp0jzkOuQbn3w3IqAYzhlHpXp6Qsu4XQe+BbH8Fiu
	 obt2gLMJl6Jd1UvakiUWsDZjnL1GOx19dGXpLRliG9U31IHla5M/28sSBYZzRTCLPMRsY
	 IcotWnRUhze6fbjwws/y11JJMjvHTyKyy7suLvDOIH0snelqUtVyCOKuvt76GR4K7BVNj
	 hVJyH3BcybOBR9RI+CIfRmC2mq5Ku5VYSe25dLydXFwhQs6+Gj1k3fgW3DxOIVW1PZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492678;
	bh=tzVl62qjzRm92BALDDypl3TnCOJSNAaLaOJ/zmWRh10=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blxeXLXbZVabUXnABDSQlrSmXqi6Nmo8ktdR8PJyrMP2SrPQ/NqbgtEHc23ciUtzB
	 vkU70r55alYZBnk4Jfq6Hdv840vcd3Jr8hTPk57egK8xagf8BiGq2eXaJyvgRp3LPY
	 bnPrjgb0y/6nlHXZ9RqiNprXA6YDxU36nI8maxwbfqcKxEg2NsW1bkvQypztsA0Fbk
	 kYJfQS4WV+ce09uPyu9nzHEUOewAzXV8thyfGRwDUqASKOhz1oVBKNEZpFWWR3EJ2U
	 VBQx3VgKnD4vbU0beBS2RpA5WbUd9qzIUpLtcrphMLqI1dkCn9qPv9jwQSiSc1fGe+
	 6GRn6cgbTTw8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A64BB80C53;
	Tue, 15 Sep 2026 17:17:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B644B493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97B4B60721
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7tUzPyqcdpGm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 89C3560681
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460412;
 b=KxlJASzO8qJyT/ZGYj1mB4TQUxu7mtWyIyXGaDT9CnUp2w2086Ddoqn5RSb5HRWMeWl6
 nDmfJIPmSk7hx8iRw54o2ycye6l3JzcYgRLqhebw1ovtrzRgdlrmRWL6Zxcaq4AMwsofR
 Behjs5Sg51gt5MEeKhB2UAdtEUV0DjKE+btyGqI5TL9HLWFPDqsUFc3B9D+hqgasnE4y/
 RMAEomNikDL6pHcyZqZ796aoOuvWaIfIlXromYTgeqxQnVUSovtZBgtJVAmSvt9xJSl/q
 SWpZNVC5/4aITyC5PCn2F5UFDkXKIea1496F+1N+1J4glo4b4ehfUQuDgdMLAHwvztw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=tzVl62qjzRm92BALDDypl3TnCOJSNAaLaOJ/zmWRh10=;
 b=GE13OMtDVl802yCibKxwyuRMnJT7QsHzKYiV/yE4Rv5cWYm71hyurHimMmU7jMyjgrRf
 2TVO2TQE18ZAiClMDkUZI3p4wH1XkbHF+pJiau5fZwB37Cgk8lrmOICARTxTk+8L9bu/7
 Saayuf0eOHkWAajpi8lBBXPH5dXky9b11+g0xAYZj2H4DwiYwt7hMPRByAHLIVk8+gIES
 wZi8RzAlZQBrxhK4wTTtgjAeOZP4avEiJewXoiU6Gwfl0t5D8NOuCOuqm22tooc9aHRM8
 fTGLxk3b+PRqupSRGqkZ6AoXrkChBmq24VP30a8bUFBQBQ+pGH7+I4wsnFzlYsQCuAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=KjPt8kBX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3u_-oagukd7ortwgtlttlqj.htrnsyjq-1nwji-qfsqnxyx.txztxq.twl@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=KjPt8kBX
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89C3560681
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso78284875ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460411; x=1790065211; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tzVl62qjzRm92BALDDypl3TnCOJSNAaLaOJ/zmWRh10=;
 b=KjPt8kBXRjRxaBvxIXHlpC9h5ImHZFqxUbEjaNGiK+/8E4GRY5HQeiQr2mZR7lUFe+
 Jqo0S0xiflsYlKih7+q+r4FCnCpBA2xhbvjz9iBJSQzmbtOS45zrh26zv4V+ydvpah38
 VYsaUg76autq+v+MgCK8bt0VkFp350CDF0hUthXYhHtq8hTI8ETxLhIZZgBJnclTc0Su
 wuNjY90JMuxVQknTgQ31KD3DZ5DhD82kDXp47onw1vWtcThlTUXKvSEzmv458CRKBVL0
 WkG5k0Rybz5shDhGHlmMEkEC8lXqoVIjrDlznU4C6L1a72XQs9JEqOB5g9OPDoBhcx16
 sjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460411; x=1790065211;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzVl62qjzRm92BALDDypl3TnCOJSNAaLaOJ/zmWRh10=;
 b=wnXWFBf9G27/s2MMQyDn7cCjmxCfkMIPsjH1wnROEjiqFOSA0nxTrBPJ5voQojLpnX
 audm3IrrhISCyx7xiARArc2rs2gcDlAVCQ4/5Jh9GI3me/3MuYFrMTp1ChrAws/1hyoZ
 zhpynUgYjgFzmBs/9fc+qGi7J5+3bqUIpF2JK1L9dKKaAJ743pUhOejUl7L8xpJv2SCE
 qw7vqWaGfj9DOQKehS5v3sugqqgQMYvQkBDJDJFgf0HSprCexP7OaeGcJQos348nnCtr
 LLD4zEobuC6tNSIlA8ytk8gLkdVkrjgGOzRusjTglvC0DM850aQBqumYH4rlrYZ0LrQr
 DwxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIkLwdT5TL+LJqZys5YZNTRLjAHTkjvVqXpPihePygkV6ccY+t4MBVgFFPyypmaACKc2h9q4n6GHsOW15Zd0w=@lists.osuosl.org
X-Gm-Message-State: AFuF++kxjda5ze9qykoVjbcCP5xGnFiF5QEX/QnOOeYHFJ0uZH/YGfZr
 0C/S1rbGqRYS+RuDqLnHyQ8LcTRUmuLJfpFWQKqX1cSe1QySv/A03seNSaJcoq/H2OonGmT6WLM
 X
X-Received: from plbjx4.prod.google.com ([2002:a17:903:1384:b0:2dd:1457:fac8])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:190d:b0:2dd:4168:7bd3
 with SMTP id d9443c01a7336-2dd6c6c0cb1mr140747065ad.12.1789460411041; Tue, 15
 Sep 2026 01:20:11 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:36 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-20-morbo@google.com>
Subject: [PATCH 19/28] x86/setup: Use snprintf() to concatenate builtin and
 boot command lines
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

When CONFIG_CMDLINE_BOOL is enabled without CONFIG_CMDLINE_OVERRIDE,
setup_arch() appends boot_command_line to builtin_cmdline using two
strlcat() calls before copying the result back to boot_command_line.

In preparation for removing the deprecated strlcat() API[1], format the
combined command line into a temporary buffer using a single snprintf()
call and copy the result to both builtin_cmdline and boot_command_line.
Using a temporary buffer avoids undefined behavior from passing overlapping
source and destination buffers to snprintf().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Developer:Gemini_2.5_Pro [editor_update_file, make_kernel_buil=
d_single_file, checkpatch_run]
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
 arch/x86/kernel/setup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cda6adb9f69c..c40e0edd7c13 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -916,9 +916,11 @@ void __init setup_arch(char **cmdline_p)
 #else
 	if (builtin_cmdline[0]) {
 		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		char tmp[COMMAND_LINE_SIZE];
+
+		snprintf(tmp, COMMAND_LINE_SIZE, "%s %s", builtin_cmdline, boot_command_=
line);
+		strscpy(builtin_cmdline, tmp, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, tmp, COMMAND_LINE_SIZE);
 	}
 #endif
 	builtin_cmdline_added =3D true;
--=20
2.55.0.1032.g73a4cd73de-goog

