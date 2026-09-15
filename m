Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E74AC88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDBE46074D;
	Tue, 15 Sep 2026 17:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvD-xF5IQpWh; Tue, 15 Sep 2026 17:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ADB6C6074F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492676;
	b=YD0YVcDNI2gVoRsLFIdB3qstPnaGYCUcvCkUMsLbwClQW1XhPhjNinn6RDLne+zcNXlr
	 f5yOW8sPYARrsU+HM56nC9j5GCWxZQq2nvLP3r2o0sT7BY6XKMBaqmPyosGPNl/zrDSYs
	 2Q479JUAefile48zA8sGuNJX/Yauribxdlet6/Q05rjPBXBA1DxCT2DJztgf50ETF5rvC
	 6/kvgN8Z4IzFCPnaH7EMFWauJOOxdLXKMvAada55CEfk4VC1Yc9xX+l8JEUQlUoj9jBqe
	 zct2XAKmogDefp/VSetIyR3FTZeqiMv0wCEd7PwdaeCOa8+gY6wyKV+gF/tarXuDjZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eELVo8fI0ZjlHs2eEJ49S4+N/SPMib/OwBxEH2gJjRU=;
	b=ISwMuiCZhJc7+c7/1IoZQy8wM6UQpnIo0+So60Rb8t8K5Zi61Gz4D+gTJOsMRwqW4mT5
	 B87ZBdxfRu0qMu4CTaT66Y0S6qo2pj1e6CWXVOvEya9CSANQ51Sr+U6ZkvbnoyanBnmzv
	 ZagLp1Y1KzMlD1xwBy7PFw/XpJoiThqLLBvyaLUsIDLMLHFdw9/45jpta6yme255XGfxD
	 /y3YnaaXBxFTzWW0vEu95xYmACFumdYrYv8kaX1TmcSEoPTwi62r3b8+7fbCD2BB2fyHB
	 W922TDSz0lf4vIsFYVwCXSmFB91/QgEPtb/5HtILZRMCMnPlFRRtUVA+6OVmcfB7XLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492676;
	bh=eELVo8fI0ZjlHs2eEJ49S4+N/SPMib/OwBxEH2gJjRU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hhpp46wiAwq3WQYWDrmi5lJITrBx1vtcmgITBwG0TefQDT1ytISY3N6JOFX7kqLSU
	 5BLwKGKz/rboNQo/uJqO+AeXdbroGFscjNm/ySiYi4Eu8rQsWU+8mHoSet0svMV8Tp
	 JrUVrm7F+zw58PrvLQkKFdaX9fJIy+cHDiUrEyecWF3NUtnaACeDvIRaMPIa+zFP82
	 Ws/a4AbtNpPyMvfZJB4oTaasXhSINobOlyZxwGdq7dwYS+xQVTavDdHNyqRo9bzeRI
	 DE8IONIGugVVk4dLU+6XpTWCUxaz5FQtEELuRnXX2jppkYsNPra/mTVLgyzItj1Jim
	 Ggac2LVKL+dLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADB6C6074F;
	Tue, 15 Sep 2026 17:17:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 723802E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5840540402
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLZZGFuTRntw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 415E6403D3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460411;
 b=Zmx3c3AvNt0k5/gyiuACysW6RlCmV2MhO3aMyI2aPPTjd5mkgJFNKXl/XnLfazV/jNFy
 Q4Q3rPsfjKExa7xZVqK20evYLfnG/3anG2ORT1ceNhuCI6SC8ZQ7pjGUmf4crfoD3+XXA
 CPKpWwsvPHMggTYrSiYCHV+RxcpBU0BfXb9Jzca6sgt+SZLDx3gl4OR5Zw8EPoupcF57c
 yD8Sbc6VPlJGDEOZQRuM9iRBKvdbCUqvpmtys9RJaFQbK+mxyzMNKLq0fNxXV4f34APj+
 /UQxFSVVkCWrV4Ewrsi567jBA0Wre3pw0CZp+2l88+qRbB/wEYOSnpnPM7xorml8aMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460411;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=eELVo8fI0ZjlHs2eEJ49S4+N/SPMib/OwBxEH2gJjRU=;
 b=aQ/MXkuM8x4bbvRUlj2Z9l/2oedbXNNhcGtimdff0ELycmgM3KTb8iFKDp2N9aQIxIZl
 guBxUiQNTNVuKMj3OHXNGEsBNX6QatLoLRc5pLVFBuc7859jn6lY9p/AZKPOL/WozLeXm
 EcBCmE5qyHnZR2nQb5IR+LIhxBEE0/fHEpSj6hA9Jk7lUP2EqvQf2q8ECfbvKw85lj6lL
 J9TChm+gYfxmGdP8ML+976+be1CQWU0U/7ELCBxOmiUYz89e7KnW/BDWVvrxU97FFzI/W
 uw6XXidkxGIZhfVEIEs6l3LeJcBeBkHzd4c0wIF0axBXqYYod+N3eV3/+u6qF+qd03Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=fyyZ5JvA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3uf-oagukd7gkmpzmemmejc.amkglrcj-ugpcb-jyljgqrq.mqsmqj.mpe@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=fyyZ5JvA
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 415E6403D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:10 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so67418685ad.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460410; x=1790065210; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eELVo8fI0ZjlHs2eEJ49S4+N/SPMib/OwBxEH2gJjRU=;
 b=fyyZ5JvAAmCc9bcHinxiyN3MtTrxvVipwZbQ2m8h6IPK0+pKgQHlYTyQ6laSDPQf0f
 j3YQG+Q9sggd8s5tDXKQrcbYi4zcrTDfAFfWsmcWqwnGcTo2kUAG2tIHAG+CYGCOMGHb
 AlRsIzSKjFhrDs+tvYh8/gVcDehqvjCLS5+Gq4QowsmM/twMQUu/FbZ+wi7uWtwzfoxh
 Q/OC1blxRrnAGY+1t01DHVfVXcSa8XLu6U2TV+M9tLc1aSSg6qQdTYmCOfoZ4eDUolMt
 b3Pe/1q2l59NSNP6ys7AYEDw3IObP5+nEEtxoJY5CM2q2Fitvc1oAuSnSpZa3OJksTQk
 knGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460410; x=1790065210;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eELVo8fI0ZjlHs2eEJ49S4+N/SPMib/OwBxEH2gJjRU=;
 b=hUaZID6G4DI3QwKK5XuvKZbLdnxnlIud6azTKVnANpt+yKUhHhMN/v1Qg4B3HChaUq
 onyckCQC9vwn1j/mq3IFCvxv7FRNQiiki5gX8zVNErEA7mKCBAFeSDpUSXHcUFnFuF2T
 ee1ataubUs4EZdqRhbivkcAgqvignCeZb/S52he5HV8rIhiRozoZQ83pl+UtrTkUZ/hy
 kxYUxKlbl+d3zEAfDJ6yxuZkaNCTrOPWLgLwLr6K3WvR5FZMkx6ihCgN+BKM5d2ZSC7x
 3/MmQIo4Yn62GgfktoW/laJfan004SfeVIMUkyIbjCdNyIpfdfxQPDT3l3fAOY1+fMt3
 0rtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsfVAvz7XiMnldEnRXSzKdHZrXEaT6gMpDYbn19IhgeBNvWXAojv7mDOJLLO7/skdFnfj3nGqVhLn+cpKybDY=@lists.osuosl.org
X-Gm-Message-State: AFuF++maBd8mxarYcO1n8EPrxUTphCVBQj1D5WQNrA2IJTyAGyH4PV6Y
 X+Zd35EqfD7TDozUdesKn7ewd5B1BvYFTjMdIXfvLUSUsz7s9v/9tXUPwklXHnYyXoolsI6W1ef
 q
X-Received: from plvv1.prod.google.com ([2002:a17:902:d081:b0:2ca:ceab:34a3])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f612:b0:2d8:d4dd:24c0
 with SMTP id d9443c01a7336-2dd6c7e1a9fmr128970685ad.21.1789460409250; Tue, 15
 Sep 2026 01:20:09 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:34 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-18-morbo@google.com>
Subject: [PATCH 17/28] MIPS: cmdline: Refactor bootcmdline_append() to use
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

bootcmdline_append() passes "max" (the maximum length of the source
string "s") as the destination buffer size argument to strlcat(). Because
strlcat() expects the total size of the destination buffer
(COMMAND_LINE_SIZE), it fails to append anything whenever "max" is smaller
than the current length of boot_command_line, and could overflow
boot_command_line if "max" exceeds COMMAND_LINE_SIZE.

In preparation for removing the deprecated strlcat() API[1], replace the
strlcat() calls with snprintf() using the "%.*s" precision specifier. This
bounds the read from "s" to at most "max" bytes while properly respecting
the remaining space in boot_command_line.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: SecurityEngineer:Gemini2.5Pro [editor_update_file, shell_comma=
nd_run, make_kernel_build_single_file, test_runner_run_kunit_test]
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
 arch/mips/kernel/setup.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1ae6d0c0e1d6..0d9c2137d675 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -518,13 +518,28 @@ static void __init check_kernel_sections_mem(void)
=20
 static void __init bootcmdline_append(const char *s, size_t max)
 {
+	size_t len;
+	int prec;
+
 	if (!s[0] || !max)
 		return;
=20
-	if (boot_command_line[0])
-		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+	len =3D strlen(boot_command_line);
+	if (len >=3D COMMAND_LINE_SIZE - 1)
+		return;
=20
-	strlcat(boot_command_line, s, max);
+	if (len) {
+		if (COMMAND_LINE_SIZE - len < 3)
+			return;
+
+		prec =3D min_t(size_t, max, COMMAND_LINE_SIZE - len - 2);
+		snprintf(boot_command_line + len, COMMAND_LINE_SIZE - len, " %.*s",
+			 prec, s);
+	} else {
+		prec =3D min_t(size_t, max, COMMAND_LINE_SIZE - 1);
+		snprintf(boot_command_line, COMMAND_LINE_SIZE, "%.*s",
+			 prec, s);
+	}
 }
=20
 #ifdef CONFIG_OF_EARLY_FLATTREE
--=20
2.55.0.1032.g73a4cd73de-goog

