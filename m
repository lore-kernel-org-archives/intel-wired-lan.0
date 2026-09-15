Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468C7C982C1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1627B80C2D;
	Tue, 15 Sep 2026 17:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9Diqr_TDqwk; Tue, 15 Sep 2026 17:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E3BD080BF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492675;
	b=F0xuxik0DEs0cQBbj51RinAda0G3+xFjke/v3W0YUIRxMy8lC6/sCiigWEkFzKCeaov9
	 Y4CJuZnFzwJa5aKQXEkta1FG8cBIgqn7tYYQukxuYV/yIygAE4d+xh5PbChsB9AhlruvD
	 GObu5173Mbkw0I97n4Mi1A4cjKFpzWfE5FGVStawg5Sz8B06lcLUI0gPwZnxqJejXBWsi
	 +bqM6oqZR83j79WxTFGEh4Y88XwIrt4XRjfnJAT8Tjm3wjtEdElIsbowFt3keHDarDshN
	 /Uqz4JVngWhaj2AUmuUuS1Cgbcs/23qOTZgVttlUzzRWwcqfe9pLPpQU4hetqLGnYMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jabuqrMs8PQTYoTuRH1Tce2jM5ZfyHhnXojFxmEofr0=;
	b=bOdS1aysJ/go5igZaFKnQ/qTp+GFU/kIHDYRUeI9tyGtEPqZ1hPts7DFRE/HpPgFeN4A
	 NFX3IkcYd3VMzZHmbuj/fPNwsMw9EjkLCUREi/Lm/KhNfiQiVmS01Med20hOzY0Gz0Cse
	 TwRm0T2cikQ+kGtSkXPSHTy7c1EHqeuO5mWEXFZJxWZ2g8hmTZYwHJwZgRMh08N8Yu7Sa
	 rtviMqAj3GAHn13lnIzCuyKk3/I3wLviA1+O0uxbPXE6XzQc6VADuxNcuo/0DOJZwUP69
	 c8xEd0Tb+uDGIUaltIiKxKEpef88KIEKjvfNj38VPeqEz8ywLftfPhBN+sBkWFeG7hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492674;
	bh=jabuqrMs8PQTYoTuRH1Tce2jM5ZfyHhnXojFxmEofr0=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OSbPzE7oBf6KugPYjD+FVjEmyuWdHDFjFve3VV0gtCnLPEpnTD/4f8Xr63QeVSBF4
	 fHEenDrsFXKf95VHCONLhjyG0O9nBO6790yAj3kslC2SFvd93nDmhdQ8osdZ/3GfPb
	 vQPbNZuiChhpJXJQMtx0Nv0h5f0KUTE0jhac9x+iJr5UW62CtKobiEBf4As0CFUDpx
	 i/W79cE35FcNtuVHpI80IwFCkNS73r3lkLiGiwhUjyBVCRu1NunhJZiQZGG16FqxdY
	 96cooy5hJMx/tKQgreTAXphoSLJU+HyBxo+3egor6WwYXNJK9wVtdfAE+XxTIhY4Oa
	 J5qrkbyveGUQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3BD080BF0;
	Tue, 15 Sep 2026 17:17:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 312942E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1711F4018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J66VLqBNr08E for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0B669401A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460410;
 b=eIbPJO/De/9EXdYHLWAu6LE/38C7TkOeBdtsz7iQ7Hnaz7SnQBY0YwsKsSw7Qj4A2TTD
 Evi4gMu7bw752rW9X3TVSxjo1edvcge0JE5r0Xzob47xRsp4l8V31r208/bA2pe1eSEcK
 cJNHuAgklV8F35vbotiakKjKKayiet6bFDPEAx2+mjUWv6QYwFiJEj6bAI34FxHDLsXHy
 dbZaxYbfUel8Swro1cshga0XP7zYlA7crwOS9Dr9JTYP+66nI+0hOpvgDOsZVsCML0OY3
 xYsp8kG/fLUsErIlm2kxk+nJf5dvUWdX45W+ZYFR/o8/nv8DfnIlFAD0t4tsdFQZDpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=jabuqrMs8PQTYoTuRH1Tce2jM5ZfyHhnXojFxmEofr0=;
 b=Aztqq7IhxpwGLSHQ3cM+vG78AAbgUjShqUap8Bj0vjyOHeXgmpZ5qf/EQiiP4IH6ITNg
 fOvUqXnJYlyLwYWyitC+awDwdx3YyLnkw4VaesJ3uam8U0+Gs4pnBZ62YGA/jwAKJOwxi
 8Ghrby+A+lwk5JXgfhCj46kreuV+R+Nb2BnHGSIGbcdlSB+V1sUeFPpx+hIavnOsLX9hg
 5oTK5oQsCzTaU+8xrDMxmcrhqQ0Pc0LhzBXiqFp9ZRiwCnNYh/Oryb0j2VW/b+Qi8XVof
 jqDrgvFccSv5wR+urhedTNUuqSFVVho2W28gpJTy5OLscd2ADop5kFhdxIXlJIdD7zQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=hU4NMCGx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com;
 envelope-from=3t_-oagukd7yiknxkckkcha.ykiejpah-senaz-hwjheopo.koqkoh.knc@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=hU4NMCGx
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B669401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:08 +0000 (UTC)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2cec4226c70so55725915ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460408; x=1790065208; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jabuqrMs8PQTYoTuRH1Tce2jM5ZfyHhnXojFxmEofr0=;
 b=hU4NMCGx+8RGwEN58r+NRm+s8AjyMuERMyJFUggNz9FpI6bPOu/RePvLGicS/5/O8b
 WTtRkU8k9URSes80K2l+TMQfYQJPX5eg0cFtdDyecjHZDLipjmUJUW/N8KCSjvHkNTiC
 5GpacGNbMdWK6/+MDuh68P8cSBbvnOuCffH/+vwC5xgPVNx/S2HKBIwurREP/NEm3T8r
 fCwWplYRChlPmYMp8SV4doeaQSOHMAoYoILCaQl72kjJEzALcE6oy0DnXyMrVp/8ekF3
 8TF+axGmICPPzU8cE6M61h4A4WKp5khdU5oBs1vnPl/R0AO327+8QvkFx0w0KCQunDc0
 4FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460408; x=1790065208;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jabuqrMs8PQTYoTuRH1Tce2jM5ZfyHhnXojFxmEofr0=;
 b=awCaQwLRCs2vRlKYvuC3xQM6vT+UaObfQKSQbirEbe2ZnewFc/0lGzFq05iTQd5/OQ
 jlliv2nBv0eGIA6mkOTprzAitoSA93Cb0zMVlTyEkOtXf7easNFLPFsaE5M99ilqqgrB
 4c/0PHdnACr1d+xNR6MYCx3HIPHIveE2+I5lulE1tDX8xFnVw/MaV/3OmyVv36zgzSzt
 wgUMJmcwsbH3J48xHv5G+rLvUVFTMxzO3KQ5F3ywDbCwN/KEKwGDNvwOo/GL2L0t4s2c
 u+bXVAkqEoOYMT+YIT8rE3+g24qxytbbOqyClIv7t7qWOPtYL3IQwb10bsVzjPXbIXhw
 Tsaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBycYcf9THCIFQ3Re+IWthT0aoYTrhDLOdIStSn8n92GmBbB1eGeCMwy2M3o65XnCZcuueeb0RcW4YS5apYBq/U=@lists.osuosl.org
X-Gm-Message-State: AFuF++lZPdAmxSdDWikCLIPL0xrLK2Y0D24j3Fm3b8waHyH3puW2Vb1b
 0ZxCj8OI8OeQrqMvtVcXbNmRqluAiSh9Q5R07RqbCwIopf/CNgfyZKvGmBe4Q9avXlupfBPi3kh
 n
X-Received: from plde9.prod.google.com ([2002:a17:902:d389:b0:2db:820a:9228])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f786:b0:2dd:4070:8f5
 with SMTP id d9443c01a7336-2dd6c758602mr148465515ad.21.1789460407562; Tue, 15
 Sep 2026 01:20:07 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:32 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-16-morbo@google.com>
Subject: [PATCH 15/28] orangefs: Use seq_buf for debug help string generation
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

orangefs_prepare_debugfs_help_string() constructs the debugfs help text in
a dynamically allocated buffer using repeated strlcat() calls across
keyword loops, rescanning the buffer on every append.

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf to build the help string. This tracks the write position across
the loops, allows formatting each keyword line with a single
seq_buf_printf() call, and checks for truncation via
seq_buf_has_overflowed().

Additionally, replace the final strlcat() call that copies the completed
string into debug_help_string with strscpy().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Gemini:gemini-2.0-flash-exp [shell_command_run, editor_update_=
file]
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
 fs/orangefs/orangefs-debugfs.c | 36 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.=
c
index 9f94919a6bc6..6e2f9887eab4 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -37,6 +37,7 @@
  */
 #include <linux/debugfs.h>
 #include <linux/slab.h>
+#include <linux/seq_buf.h>
=20
 #include <linux/uaccess.h>
=20
@@ -623,10 +624,10 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 	char *client_title =3D "Client Debug Keywords:\n";
 	char *kernel_title =3D "Kernel Debug Keywords:\n";
 	size_t string_size =3D  DEBUG_HELP_STRING_SIZE;
-	size_t result_size;
 	size_t i;
 	char *new;
 	int rc =3D -EINVAL;
+	struct seq_buf s;
=20
 	gossip_debug(GOSSIP_UTILS_DEBUG, "%s: start\n", __func__);
=20
@@ -640,17 +641,14 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 		goto out;
 	}
=20
+	seq_buf_init(&s, new, string_size);
+
 	/*
-	 * strlcat(dst, src, size) will append at most
-	 * "size - strlen(dst) - 1" bytes of src onto dst,
-	 * null terminating the result, and return the total
-	 * length of the string it tried to create.
-	 *
 	 * We'll just plow through here building our new debug
-	 * help string and let strlcat take care of assuring that
+	 * help string and let seq_buf take care of assuring that
 	 * dst doesn't overflow.
 	 */
-	strlcat(new, client_title, string_size);
+	seq_buf_puts(&s, client_title);
=20
 	if (!at_boot) {
=20
@@ -665,24 +663,18 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 			goto out;
 		}
=20
-		for (i =3D 0; i < cdm_element_count; i++) {
-			strlcat(new, "\t", string_size);
-			strlcat(new, cdm_array[i].keyword, string_size);
-			strlcat(new, "\n", string_size);
-		}
+		for (i =3D 0; i < cdm_element_count; i++)
+			seq_buf_printf(&s, "\t%s\n", cdm_array[i].keyword);
 	}
=20
-	strlcat(new, "\n", string_size);
-	strlcat(new, kernel_title, string_size);
+	seq_buf_puts(&s, "\n");
+	seq_buf_puts(&s, kernel_title);
=20
-	for (i =3D 0; i < num_kmod_keyword_mask_map; i++) {
-		strlcat(new, "\t", string_size);
-		strlcat(new, s_kmod_keyword_mask_map[i].keyword, string_size);
-		result_size =3D strlcat(new, "\n", string_size);
-	}
+	for (i =3D 0; i < num_kmod_keyword_mask_map; i++)
+		seq_buf_printf(&s, "\t%s\n", s_kmod_keyword_mask_map[i].keyword);
=20
 	/* See if we tried to put too many bytes into "new"... */
-	if (result_size >=3D string_size) {
+	if (seq_buf_has_overflowed(&s)) {
 		kfree(new);
 		goto out;
 	}
@@ -692,7 +684,7 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 	} else {
 		mutex_lock(&orangefs_help_file_lock);
 		memset(debug_help_string, 0, DEBUG_HELP_STRING_SIZE);
-		strlcat(debug_help_string, new, string_size);
+		strscpy(debug_help_string, new, DEBUG_HELP_STRING_SIZE);
 		mutex_unlock(&orangefs_help_file_lock);
 		kfree(new);
 	}
--=20
2.55.0.1032.g73a4cd73de-goog

