Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBA7C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 713056071C;
	Tue, 15 Sep 2026 17:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SaTPYA8xcHkZ; Tue, 15 Sep 2026 17:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 462F860732
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492663;
	b=mqm12GNsVi9/A/Tbvp4FmdLWkxRO27bvcLxho8WxK9ThKVYZJEpBwJVTlw7pw5g2FH//
	 5vNCUT6oB+H1lnlEAea1Xy2GvQFEjmo9+/u9+DnjtCrVIkuj7P6ZP1GgoRAC92nlYmF9/
	 qNr3kAMLI7Mciaprd8SiuEnPW1aj3Hsj1uEOI7VFwiEYDy+L6E+J8ng+8HbayylKUppWk
	 hkk6BW4hI8ff2HvDOm42XCKESGsWG4h0rOoVGupccjmKVPpFa2qcrbsO10/PDsft+4Sks
	 L7dyCQHM2mdOi7RIEAdRkcdD0xX9rW8w8OiJNKWaMa2sppqL+boemUVWmh8fX6E5ldQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fp8wJxWuumatGVjI+YCt9Q6O6hUP8tXGtI5nMGsUbio=;
	b=FdKOGDVzM3wz4nB0yhOhQIHGHu07FeInhL9MXFkk0ukj6FnKLFKbp+p/+rWHSW3XQCXL
	 modTNmJ1JPNsFOto7ufsjm+qVybr5L0i8dDLGDGZVamt/ARtrEXTCXY42jswz/D1bNyH5
	 cKL27ZFA9YnhO34MQ+thXTcYByeT2NnSul0p9NHE+tB80ms53/CITcHoiIu0OcN/E3voR
	 c9WxdRMJ9Ppj6yFKIIWA4POm5iGLgjgLuG/CG0DwWZh9Fm4SNZyIezWca/PSle2puj/JP
	 U/Wf8jSL1tdPDMG5kaAnLToEsY2eZre9NuQHCA44M9VNB/C/A1GYdgOd/oXoo0+Z+tA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492663;
	bh=fp8wJxWuumatGVjI+YCt9Q6O6hUP8tXGtI5nMGsUbio=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6vJw2Ly+hSComyN31pKhmUU7uZyBr43s5qjJ7GXjruPyxRXGF6H/Pjplbs+RZnAHj
	 IUf6PBWaUfsQ48MLXJAuO3ndFozJFLQY1jOTCgnT+oHSB2MD8u2XElAEHeg5A1d9gS
	 nWbbO42v3JoH1Q6qMG8LQnv3KXy94DG4ge+Q7ZN3OVfrFIdL2qXoHpAiZmyZinP5+z
	 9D3S989UDlM/5nCOg4xkRTMHlNu+70S7oGJwYzSgJ9fDteXcVw2tCCAP4ojPmGU0Go
	 DyQBBxgnavyCqnEpuU3Gvk5qF0bmvKkqnjq0MVlHrfotqzGSNgNlF4dRFPPc/pLQWK
	 /mirweQOIv23g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 462F860732;
	Tue, 15 Sep 2026 17:17:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACEE0493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E9C880C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdzcJQgdVxEs for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9F34080C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460395;
 b=op4DujaCIrRGXx9c4g01Ba4EPIfRy8pdayPMhYWg1MZ9cSEqwn2xxFtIYQ5lnkWxlJBe
 A2BMS5k1Vv24a9knmwNsJvbgIW6G4+dONs/kHf+e3Y/NstWu5nNynBJptbuIqUgHBTEa9
 a5B0y/s01FZxa2M9I4g1wcD4YLBqN2FKSV/GtcFk08D1eWgQlMRC8JWhHHwuwNlaEBWx2
 HKBtxG1tj6YzyuvGeSrZpuwEpMHAj4ZzRulG8DXtC+MozxxKx1ta7qcuIEQjWYjalxk8w
 xd8o/5QWAIdwXQNs1HAQsaaAtU2z6BrU3qDIl60lpul7KbtfFeogV5XvJLzBBcMUNxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460395;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=fp8wJxWuumatGVjI+YCt9Q6O6hUP8tXGtI5nMGsUbio=;
 b=hyhKGBI2yxHr9dAObEiXO32vQvBtATgkICX0HhOQ5TWb1/QcLlAEonFQkM+J0cdVMbV1
 Sz3NG/DzmHNEXiK99W2lOfM4VF0UiwFxbZB5ihtCkx+AOg677MVNlHXPm2nvOBlT/vMlP
 Sy0OM7TA61bf4zOTSj/gBbsLEqvDA5JdNhzu71pZL/uqmlRz1DgLU08cT7Mmn3v4HbanZ
 ljhybox/iDis1WyG7r7wwYMNHsn/5cPfMcnYPgki4LPCvchUjjIXLctUhI6/8HaZCEhBO
 to+wZNMLmpa45Y2xchKl3c8PBcu7gEE2Cm4o2iWQn05fI1wMfV7RmErHr6Xyd107mBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=e8DoYMGc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3qf-oagukd6guwzjwowwotm.kwuqvbmt-eqzml-tivtqaba.wacwat.wzo@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=e8DoYMGc
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F34080C3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:54 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so49009595ad.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460394; x=1790065194; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fp8wJxWuumatGVjI+YCt9Q6O6hUP8tXGtI5nMGsUbio=;
 b=e8DoYMGcUJovVHF0wOA499DBMyMhgKylCKXINL0QGkYn48qwueOGLmHFlnRudD2PKv
 soAtKModObSDLdoaTJCdOkjAYcM4Sff0GCoIQzP0S/tSk54tJbpdT/pKNAzNrUyMjcQv
 jy+NSEa5TyRDQtiXwmiIAPIXTnlWtu/p7JSrXDOFR3Sj4LEv3cnT7YnHfiSIxDbsIcjd
 8SHEjjvYQIaI+tlcJce5mvcfNP7BTv7A2gJNSsch3lMtDnAYQFVmnUd2Aivmv0I4CMZ+
 5GFLWMBCkWcXFZBcC2hcijfCrD7mncCuR3eMQICn/qz0fIZbtj+hSZ+BqQQPS/3yAOWG
 Yn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460394; x=1790065194;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fp8wJxWuumatGVjI+YCt9Q6O6hUP8tXGtI5nMGsUbio=;
 b=D5JFLBkG+sf2x+kIesf/sQM7x5nJq2h3ZiTNrHoBT/R5fZm2i+WWpvIrPYiotkqO1P
 4zJ79jMH0oN4ZYb8anRNYRgtuhxTSgqVAXXSKThGv8vAurZOLn7uqqne5EoUmcgTiO7h
 h1zm1nQCIgxh8IYaZ+w4uMG5OVT/pq6yCGGOZ7PPBxHO2ZMx3LymtY+eHV3AU/fu1xJf
 2ujgnjCkZkA5bZ0lye6TL50Ka4n7eEyo6crOMgaAXcPvKIVptJPrseY6iQSKgJsdIj0N
 KCiVG8SsI4lhVCJrrI6Zpa+nAgVvV+p6hGzwIWP2R8Cn2DYGAiGPw6QDtAmq1h6+8yYj
 tOQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwpvr7mjunDjZ4DcTzfFG2gbIvATJeJBgOvf/J89pbQs7bk9AHd+5+Pbiav6D3KmiEPYliipgy7x/904wYRRo=@lists.osuosl.org
X-Gm-Message-State: AFuF++myv88gNEpLsiM/080Vsl5GyYudBaaqhZhGSs7wPEsbS8PdSNUg
 PipPO075uHC0m0I92wJw6ltyBgbB4pqh8C51Lxu/TTEQ09Is7HiSwN5ReeMO38iOYfH9/V/XkJK
 W
X-Received: from plbkw15.prod.google.com ([2002:a17:902:f90f:b0:2db:5cac:a627])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ffd0:b0:2bf:27b2:4b80
 with SMTP id d9443c01a7336-2dd8384ce53mr639785ad.14.1789460393875; Tue, 15
 Sep 2026 01:19:53 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:23 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-7-morbo@google.com>
Subject: [PATCH 06/28] comedi: comedi_bond: Refactor strlcat() to seq_buf in
 do_dev_config()
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
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:36 +0000
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

do_dev_config() builds a space-separated list of bonded devices in
devpriv->name by formatting each "minor:subdev " pair into a temporary
stack buffer with snprintf() and appending it with strlcat() in a loop.

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf and seq_buf_printf() to format each entry directly into
devpriv->name. This avoids repeated rescanning of devpriv->name and
eliminates the temporary buffer.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: SecurityEngineerAgent:Gemini2.5 [editor_update_file, make_kern=
el_build_single_file]
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
 drivers/comedi/drivers/comedi_bond.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/=
comedi_bond.c
index 8e10ecab4f0d..a10cfbd04c72 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -39,6 +39,7 @@
=20
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 #include <linux/comedi.h>
 #include <linux/comedi/comedilib.h>
@@ -170,10 +171,11 @@ static int do_dev_config(struct comedi_device *dev, s=
truct comedi_devconfig *it)
 {
 	struct comedi_bond_private *devpriv =3D dev->private;
 	DECLARE_BITMAP(devs_opened, COMEDI_NUM_BOARD_MINORS);
+	struct seq_buf s;
 	int i;
=20
 	memset(&devs_opened, 0, sizeof(devs_opened));
-	devpriv->name[0] =3D 0;
+	seq_buf_init(&s, devpriv->name, sizeof(devpriv->name));
 	/*
 	 * Loop through all comedi devices specified on the command-line,
 	 * building our device list.
@@ -250,15 +252,9 @@ static int do_dev_config(struct comedi_device *dev, st=
ruct comedi_devconfig *it)
 			}
 			devpriv->devs =3D devs;
 			devpriv->devs[devpriv->ndevs++] =3D bdev;
-			{
-				/* Append dev:subdev to devpriv->name */
-				char buf[20];
=20
-				snprintf(buf, sizeof(buf), "%u:%u ",
-					 bdev->minor, bdev->subdev);
-				strlcat(devpriv->name, buf,
-					sizeof(devpriv->name));
-			}
+			/* Append dev:subdev to devpriv->name */
+			seq_buf_printf(&s, "%u:%u ", bdev->minor, bdev->subdev);
 		}
 	}
=20
@@ -267,6 +263,8 @@ static int do_dev_config(struct comedi_device *dev, str=
uct comedi_devconfig *it)
 		return -EINVAL;
 	}
=20
+	seq_buf_str(&s);
+
 	return 0;
 }
=20
--=20
2.55.0.1032.g73a4cd73de-goog

