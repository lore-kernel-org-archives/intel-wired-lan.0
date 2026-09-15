Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50545C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E8D480851;
	Tue, 15 Sep 2026 17:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yivyjntksaQ; Tue, 15 Sep 2026 17:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F3C280843
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492670;
	b=dx+OBp3C6QqiwFB2oSAPXyTQCld6eZOTC4QaMsRl4ffMjQxbUXFXhLz0R2gH05rUbhBX
	 RLl7cERTOQTX0vciWI6SpgefYSs6VsagApn90n+XKKKZjXLGARPzonEMHopsc+cRJb/Ej
	 QPkozEDIGvhl85eNeDqkKZbzNeRQeCcNl4j1crKLsBnlIRw6+ufKCTMe3wFhDTklOHvUL
	 x71ILwQQ9o4Zt+exlFMnndfj7T3AK1SaKmGCcWqcjax5i3Qv+nEEm47LtajSvuOAUknHH
	 nugllOiQ3NOEff1lucMr/lPcU6hPkpYaL6DF5nngDNmaTxhB6SpCSp0aiWxLg9UiAMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q9qHU7CDEu6zWWmniYe9q2ucwWYfoa3UieeTJM1aJto=;
	b=IB2V12GvTVvHNOg/qU/m5YSW+3XbvRmgpl3PrdpyjWhvQRRceciyxa0Zlzf5Mr0P5ZP0
	 qCNo9/HxBNexFTH+IiVYfLoerM9Mnproh+Q49PgVDMZGZlKBJg7UNm+bhVi8Vjc8AEAZH
	 2VTa43DtY72omsgo0a4KUTshygR/P85ohn8GSD4SJCQbKCPkPhJnbF91aoag8fCfDiyX/
	 MpYDOifhNNCZhKuUIJ5OcfdkDSd/NAagXjsqYTQnopbW5LQaVPElFV47jSliZ0eJF8Qaz
	 1qBFYhyGPOo5TCjW2cDqEIo2TkeGDM3Hat7RuLC/PYSWpbHTQGYx5lwi8i8ON0W52SA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492670;
	bh=q9qHU7CDEu6zWWmniYe9q2ucwWYfoa3UieeTJM1aJto=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EluRLuXzq5pFrizwFl/rBT6ya11lZIYulxTrJcfW/nur3+wwfhvewzDQxdDCo8aj/
	 8thscAFzvnQnfhxfBz/UCsKwqBcsgOQGVHm5PStfgE+IrPOEI7v7ArbWwp10lH8dxg
	 QgsdUySnY7JNKMnJO7Gypw/pN8xYQ0IT+WXcIvYiHBzZIgL5lQRKCYH51iIdOjajQh
	 AOugJguAsF8U+hz4YlC8TXNe7JFu7xyjzaSbxi98FHSIqpAe0aFN6SNhktT/RD2Mxn
	 eHsGZntIWj72x5inyrucVX529OHbkrZNp0H130rZHpveosq1mWtrBLbugpgRktgw1W
	 DJhfOYKl2wkHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F3C280843;
	Tue, 15 Sep 2026 17:17:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD0E22E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE20D40475
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2O5DnQK-ccO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A9EB403E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460398;
 b=rgkz0/teAFFCAfPL9Zy27HlhBvJHIGtZ5oKeZNC4XlPXuZC/83qrEm3b0CUkzyMoB0/7
 7YX/f3tmg1ZV5rkE3dEcn+MbbK+UQHlcBSkqS0R3kc6DpN8zDu3UjF6fAvdD/Njukvw/t
 1BA9h0qVs8lAB1AwAmUXW/kxp38ZP+jW8MWPkTFFC0FkC1UvTplksr9+ovwTNLImVWXiN
 bBE6LM7dDi6/kZYlcZZF7HzSbdMwJgLrF3RbmbXK/UxeylMMqUFHcOytosnadI0R2yPO9
 RycLdjx0wynKWHZIMC53A1N8CWv6j4I2Ep0Dr4f8K7OT2D2qb2Sj7ZBy+QuzZZex4wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=q9qHU7CDEu6zWWmniYe9q2ucwWYfoa3UieeTJM1aJto=;
 b=R7JHalVf8O0UdAZgG/xP4FBQD7+9NyHOnvudLgpLT2wpydSnbjxbZzg/zBHSTPO5WuX5
 zfxCO7E/b5/sbqsZnA9N22wDYCW+DB4hh3AYTw9DHRUfFo48+pUbim8lRvZfkzmzVV/uV
 D/HLi1lgAnqu+mvGIeOuxgaIZJB/p52De2rM93UaV/S9MOTrnX3tPsrZ/IEqHAu8t9kfR
 jZRqKdAijZQOTLlC5Be1dMETKQFvoQSEXYi9U/Ltr0P19z3mazLXkT8EA4HE4GVi+EwjJ
 u/jFG0+RvPDWxPYyr+i3sgtdKknUs3ID4+/LDVjaH6PD0KJsCXJ3ffuVXiDQEjMOxNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=maaHppDx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3rf-oagukd6wyadnasaasxq.oayuzfqx-iudqp-xmzxuefe.aegaex.ads@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=maaHppDx
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A9EB403E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:58 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2dc7337e2a7so52771545ad.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460397; x=1790065197; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q9qHU7CDEu6zWWmniYe9q2ucwWYfoa3UieeTJM1aJto=;
 b=maaHppDxmW0roWwQV5pu9qZUPqmVmB1gGoRc3aYf1zBaNIUjLB+jLv4Fth4PRQzeVC
 E0mXqsW8e/Ku79Pfpf/IG+lhJIQFZ65MmjMCoFgGCFE4aaWY4ICNG4HFgbcJpWZHHYsv
 LyEtMBM1Wowmr0uJ3PdmP5gWySG7BUJY4yC2v1vSJORwihtnfaoS0i5y7tFzOUDveZm5
 3yejI90J301hp4uOwFACLfsyqjePlP6z4YS6SS9yFmzXvqUXEOg0hdqccphYlpPNRe0U
 BqtzhPUSj9nV7cv0hTY6Rjsv6MFufzmYj36mDqrjbBTQTkO4EHIFdZZtxaSAarFzOwQ+
 8+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460397; x=1790065197;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q9qHU7CDEu6zWWmniYe9q2ucwWYfoa3UieeTJM1aJto=;
 b=L05g76qQBzshZH9DcRXHKLr4JsfQu1s4BHjK1NgJq87nHjnWyRJvBXa2WzxcEeHcSE
 bezsenMlovJSrJmAGtjK90rSii4vG4S6a5gf2P4ZQ7/mBSwu5LyPSbqX+Jpv9/y8geUD
 kV75ooTyHKfSX/NM4V+nBwa5XGbqBdQUynonmtQkT6KvoFz+W9LqJKezX3dpWWswsEK7
 FXXoeUC6SayT0b/k3mnf7wLYj+VDc6bibH/yFnWKndTCLNeZqO83W9K5MRA4Ym0LohUU
 urcYl6Nsvfy0ec9ppLPhW91EFkRnct31Ygn8X44yyrI37BLNWyiVDfhHawlyLKtcKGoU
 bM0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBweidk9YDsX9DpO+8JcPPmdrlEndo4GC0fpH/NuhL0fX68q1ERqGtl5nvRJvefviZIBijE32xBaSab/okozXvc=@lists.osuosl.org
X-Gm-Message-State: AFuF++lcQKiboY+PuTklbmnAZQrAAgfOp+zjLpSUPEJJHSuygvtd2fEh
 w5LX/1lMDwzU4AMt9MFxdsb4JiRO+T5BDr5S8uUhoBL68z8YKeKGL/1RUngjFn/qcZ94ucMGp/g
 r
X-Received: from plhc17.prod.google.com ([2002:a17:903:2351:b0:2cf:ca4d:25e3])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2408:b0:2d8:d4ce:9f32
 with SMTP id d9443c01a7336-2dd83869ae3mr512075ad.16.1789460397125; Tue, 15
 Sep 2026 01:19:57 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:27 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-11-morbo@google.com>
Subject: [PATCH 10/28] of/fdt: Replace strlcat() with snprintf() in
 early_init_dt_scan_chosen()
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

When CONFIG_CMDLINE_EXTEND is enabled, early_init_dt_scan_chosen() uses
two strlcat() calls to append a space and CONFIG_CMDLINE to the command
line buffer.

In preparation for removing the deprecated strlcat() API[1], replace the
strlcat() calls with a single snprintf() call using the existing string
length.

Additionally, check for a NULL initial_boot_params pointer and jump to
"handle_cmdline" so that CONFIG_CMDLINE handling still occurs without
dereferencing a NULL FDT pointer in fdt_path_offset().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Assistant:Claude-3.5-Sonnet [editor_update_file, shell_command=
_run]
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
 drivers/of/fdt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a64afc3ded3d..311021a83f03 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1095,6 +1095,9 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	const void *rng_seed;
 	const void *fdt =3D initial_boot_params;
=20
+	if (!fdt)
+		goto handle_cmdline;
+
 	node =3D fdt_path_offset(fdt, "/chosen");
 	if (node < 0)
 		node =3D fdt_path_offset(fdt, "/chosen@0");
@@ -1133,8 +1136,12 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	 */
 #ifdef CONFIG_CMDLINE
 #if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
-	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+	{
+		size_t len =3D strlen(cmdline);
+
+		if (len < COMMAND_LINE_SIZE)
+			snprintf(cmdline + len, COMMAND_LINE_SIZE - len, " %s", CONFIG_CMDLINE)=
;
+	}
 #elif defined(CONFIG_CMDLINE_FORCE)
 	strscpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #else
--=20
2.55.0.1032.g73a4cd73de-goog

