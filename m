Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C8DC88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24ADE80ADE;
	Tue, 15 Sep 2026 17:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KB0abStoLZno; Tue, 15 Sep 2026 17:18:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 18C1880BD6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492687;
	b=f7bGXNGiXgXOQSNnTAL8287i9OhRJFqezJEthTfADoK62aMiY66Jj/6kkcdncabbu2Fz
	 3Fv09w1o291/ILYs2h0IXQcEc5wpGZXEulO+zgFH8K4nVbo5yNfIpCThrauRcSONAii8s
	 bnRP6GLiWFEBdjmHePbsodBKOfjhiHmDdtP/MHCED4reDlbm0Um97gGY35UrLP6uuOGjq
	 3ks0eENIXdywvbMI/EQWvbRJZTm+z+P1nFsMI7nCuHKFd4FrSvB2XNYyuojpvtS5ojyQP
	 bULywQeiFXnwIrhkbnSGdXsXPtQAJv1sdZnboAhoXA/v7SN6gZEWE6I6OfvMo7BVakw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RYxDJLbbwpCoc34IeHntB/eNfLB4EmZZnrz8tORBuFs=;
	b=VwwFNVAnsg85+/CJj9xvNQ8ks46W0UpcOIOHfenUQUnmJEIJUs0wncFaRUfkKbVv5OTn
	 fA0JZhojWoF7NqHYHp0ucFp5BE1yGmiFqWPyWcReNaqV/9yU9/XV4upq6DbA4SRzX6Bm4
	 1zC8HmWLHaRu/4NGt5GDhY6V4hl+VyZK77e/IeRD9Y8cDDQHJ3C0pMVIQ9clPv1rRZ3cO
	 K7MooEtA3Hg36t4HhCeTaYJ4QHaukZdpPOOCBusczESJV6srZvGppVlJZxNEo+FHqeNck
	 zc9IS3iafRRLFZCdlzWMBiKMy+snAlXBcLkfafyKczr0wbVd7NAM8RAlE8f070OZMiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492687;
	bh=RYxDJLbbwpCoc34IeHntB/eNfLB4EmZZnrz8tORBuFs=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tcFn0NMYt5M8BfaBZYtAJwOVQdbAvNaxtaSlbcAbwefshzJ+rdnD+JKlHEefaxNw+
	 JCfNF8JIEUTyBpTBQZgIveG2ioHLlnuwjhinTw459UWdj1EI5oVk5rXaCtX2e+I5ge
	 d01DbmMJVGLFj4YyJedKbBu/Kob+gBc0W04RBRJmda6OkSusnVLMMkGzUQ/Q21/7X/
	 fF+jcLOR9cWoI41DZAdwKjOZp6wzlZdInSoL6QKrEnLC1HJWl9XK3BfFkGXHWQyugU
	 QdOgpYayAtVQIUA2B63S2r8UD5tZTY+p756ottQrKYA65DSPlNqs3/LIDFvTP7IxDw
	 Ijts4xEoj/NYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18C1880BD6;
	Tue, 15 Sep 2026 17:18:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF4532E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 958C6401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xri5oQAe0laO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8EA494018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460424;
 b=Eg6ydKObbCPeXRmy+jzu2+j+zyj4nDCdbNrMu0VO+baWQceZ+uc5X2M3MhWlTUdeADMi
 94j8XFtAaaMBVFdZ4NqrdCdiD4/TOnhx/odf3wwpqeuDBtNul2EiUA/Ink53mG2d5/zej
 8JU1LBVxMQxJqmG/jFAVjT/oqCbYaORVESTb+CC4QVWmY3Uo2X5sbx6a09ssijYILWxxs
 fFF38ojyWnIM46/7kVYBzjCLV++prFRAl7l/3wRWSWaXtxFgZ7KOwx90hzmBdtsGxlZfh
 aEzyRujuC5w2IYe5DcuRoqS3uzRMRxPXKq8iEgdlwFrG0SDolaxp0yLETzXTMnkOvZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=RYxDJLbbwpCoc34IeHntB/eNfLB4EmZZnrz8tORBuFs=;
 b=blZJVpCKRD4vOh15B6FVb3mV7IIg2Cd7PqHyG3/moNBG8vqACwRU7g5qM++uvjA7LZJF
 vCC/JjuiSx8quF2EJ0Yg2I93Og+7NfWOoXh1grKWWTT4WxZsSzCt+p1b2KvxwMU69GPjN
 0j1ijFpTNj4DoBbibiiKgkxjZoMr0ozJ9AEshrJyXMRa83gdJCfhH185NfDtAgSvrbjON
 3Hhzy26LrAFsGXtT+GilMzwveDWb/ydgfAT2k71Io9b7rHqGRqo+iUeKvoViKWhQxE06n
 y1DRuef+RHg3qxp5TD+PeVFDJBnrjHABIq6h3B86M2891cHsvl0VmDjGceeZHGs2a6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=T40mF4YU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com;
 envelope-from=3w_-oagukd8iuwzjwowwotm.kwuqv1mt-4qzml-tivtq010.w02w0t.wzo@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=T40mF4YU
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EA494018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:23 +0000 (UTC)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2d6fed0652bso45540135ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460422; x=1790065222; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RYxDJLbbwpCoc34IeHntB/eNfLB4EmZZnrz8tORBuFs=;
 b=T40mF4YUVrHSPEXero4cdxPbrJHjWaavP2z9Sjdc/OxyL3GeNIlj8lkV5OzKNDTc87
 UBebVIZgn6ZF70EG61UnbqOvGnrHlXGbfHDaqHXIymGzOQVmuFIjrj1kp02Dhb7RRj+L
 ULGiEPRKX7xhkheR/MnkhnXh5AQjddUgq1kmqeDo3okSDR7b8ekl8ufGW+atTkwA7HNb
 aXeg2+gQm6ay/M4/3a5iSEKnvyfUVBsgY2g0p6UAOuPrJwp2FHD8V9c1q/YBYEBqsmvq
 2BEnmQdAkfnQKhB6lcPDLPJYQyjItTiQg4awOmaFeklTyBAOPEczBIZFqu94jnboq81J
 P2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460422; x=1790065222;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RYxDJLbbwpCoc34IeHntB/eNfLB4EmZZnrz8tORBuFs=;
 b=Jv0vqEGxGX/yEyGAHK14TKdccSm8Vf5tn0Mm7fkL06RM9Oh4tUo9H1lJVCtcfX5JYR
 pt4cV15mQmG8al6nVISRbID2Fey403bx1VMpePBS4vwprhqdwgqzW3UXWSfDB7xWZvaU
 jQXOl80MOiC9S88tGRHhiL6hlNsnC3J7WMucwURTSyRo6d1eoc+bACQd+srIgVsEZXDF
 TUe9DyiFra5hfZjNUfrhK3B/L9uCD2ENETwZlBWAqsKDSnPUQpVY1W2eD2Kc1FJ+e94h
 xfUBSKt10OnC6/B1EVzqI+JGmvrcoUwa6r1x2awXez+9Gk9l5QJ4xR6cx4Z4KUjKU1GR
 5ueA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ9TyKxH7KuNnScgNH22RG/tKnHEzNAUC1Toh2kNrEi3eLpMVI1PTM56+5E2PQ57TP5R3cnRdq0q5+b0F9nkI=@lists.osuosl.org
X-Gm-Message-State: AFuF++nsJ+uF3QIvmlnv78ziF/my36kjXvJRoCaSJe6dbycikjrhInn+
 Tusn+cx/Ke5oHDQIsOQ0b8Odfo2v2o/qkjYrte4dwD78IBhEwNXvkIbEuxDvLJdu75P0Z5snEKP
 9
X-Received: from plas19.prod.google.com ([2002:a17:903:2013:b0:2dd:75f1:13f5])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:40c6:b0:2d0:cc92:f7a9
 with SMTP id d9443c01a7336-2dd837a6aeemr1077095ad.4.1789460419151; Tue, 15
 Sep 2026 01:20:19 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:45 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-29-morbo@google.com>
Subject: [PATCH 28/28] drm/xe/pf: Refactor strlcat() to seq_buf in
 sched_group_engines_read()
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

Similar to control_read(), sched_group_engines_read() constructs a
space-separated list of hardware engine names in a stack buffer using
repeated strlcat() calls inside a loop.

In preparation for removing the deprecated strlcat() API[1], refactor
sched_group_engines_read() to use struct seq_buf and seq_buf_printf().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Developer:Gemini [editor_update_file, make_kernel_build_single=
_file, shell_command_run]
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
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c b/drivers/gpu/drm/=
xe/xe_gt_sriov_pf_debugfs.c
index 5db7fc067c4d..548a50f74422 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
@@ -377,8 +377,10 @@ static ssize_t sched_group_engines_read(struct file *f=
ile, char __user *buf,
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 	char engines[128];
+	struct seq_buf s;
+	const char *s_str;
=20
-	engines[0] =3D '\0';
+	seq_buf_init(&s, engines, sizeof(engines));
=20
 	if (group < num_groups) {
 		for_each_hw_engine(hwe, gt, id) {
@@ -386,15 +388,14 @@ static ssize_t sched_group_engines_read(struct file *=
file, char __user *buf,
 			u16 guc_logical_instance =3D xe_hwe_guc_logical_instance(hwe);
 			u32 mask =3D groups[group].engines[guc_class];
=20
-			if (mask & BIT(guc_logical_instance)) {
-				strlcat(engines, hwe->name, sizeof(engines));
-				strlcat(engines, " ", sizeof(engines));
-			}
+			if (mask & BIT(guc_logical_instance))
+				seq_buf_printf(&s, "%s ", hwe->name);
 		}
-		strlcat(engines, "\n", sizeof(engines));
+		seq_buf_puts(&s, "\n");
 	}
=20
-	return simple_read_from_buffer(buf, count, ppos, engines, strlen(engines)=
);
+	s_str =3D seq_buf_str(&s);
+	return simple_read_from_buffer(buf, count, ppos, s_str, strlen(s_str));
 }
=20
 static const struct file_operations sched_group_engines_fops =3D {
--=20
2.55.0.1032.g73a4cd73de-goog

