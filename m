Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05C1C982C1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8944780BCD;
	Tue, 15 Sep 2026 17:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gf_j7Lcue8xj; Tue, 15 Sep 2026 17:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 689C380B5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492661;
	b=Ju5nOwEqzLD5ghw2o067JW59voRg+6M0kK6Rd/Hk+LF7rNdgmdxWCW779Xo9RN4JhiqQ
	 MorX/INtALYbDioOHYtkvFDBBq8ir/K2Ca15exU49HGGWuUppgthPRdUgVa1AcvhJ0nyG
	 WMZtom7FUjBDhofknx6g6jRc/U7hiBH2p7m//Jlut2+oYY8Xj0roGwcZ0niB4D5mgKyJi
	 03llsLlHbEaJUa9yn5cMFaYhzyeqCheOUf0PCtICYHAFgZ60+WvoP+1KnlNJtFm/1FVXZ
	 r9Q0iKg2Gsx5J1LxqDRZ2lhXw8hsNarsx+A1EGGqEAF4VzjWUt7uix/2aly7Hluevzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e1xTXUdJBJy44H7rwXmvsQjBVl/r1YS8CWHRr4HN54c=;
	b=bzNHtqui6BICSMwRMjwXTRkQxsJZTCqAcaX9lO1It3QhHdBIMOY7G8LYOxmvsB03OF8Y
	 P6y0XCC1Du7vRcPzzvHWm5VLpxAsVJ254dO+Dfbl9q2VE8YOB5OZr5kvqs4Grn42VkljD
	 /8qaICVgBA834tUl8FTOCSWA4M85/ONWaFhIjMM2WFuVi84snrLttcO5+kojiRXA+kDQy
	 6YROcHQLR981uQ9UMLJ5jlFSiNm6v1tymmZIlt/bJ9k6Oc1as6oVmpY2D8WNDFwH+Uh5g
	 tB7Oxli8nLtEKDJsiIV6c4qUrK0i/ud46ueLku2upm8snm+1j7KpQt/Tyw+mHEb+enA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492661;
	bh=e1xTXUdJBJy44H7rwXmvsQjBVl/r1YS8CWHRr4HN54c=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YmZCyO1Oarh15b1cFVrx+Gh0k9NK/h/fcVm/BZcjvWEiTTkFeqTZrj/ix8ll7mjz+
	 BadDG/AxBbnzAebi9cUPmeVpLHG1h5rtfhLCZ0P2M0jQ0L94XNj2Y8Lm+a8ZbDaHan
	 rwmb6GOCgnAbec0IxWoToq45JY+nZ+rzBghpTsTWq7Mri67OYV6gqQUA2n5uFFKJp+
	 xuyLyTpWX3o4Y1laO11DRrccO4O3/d7A96+3L5Lg24BVOCXxk3ZGT6p96lEhd1ZkTl
	 6MeOnVWpmXFkL040xnMeCQrJPEYquvuZAix8RyDR2D2ycSU8jM/bAyH5mUcry0cfen
	 tH/tyC29elNcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 689C380B5F;
	Tue, 15 Sep 2026 17:17:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 315B3493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 237E660681
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WmejBRC4QwD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1E370605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460393;
 b=Hgz2H31epl5HHwdXtNuI/OuzxKFdNu/Kwz3XxU62P/wGMC6wAn0nWNzKya8XTh3Q2RSA
 9NNQYzsRjC+Xl3eAsFMDMgqmEuyZiC8hIO1fT3CHGg89tUYSOopH1BkmR8SJecxiOq7J3
 gyxoOIZ6B3m9aLSE1SbpFeakxjGpfUi7E0BxPWlOdcwVkMJK9TCOz/zKTFEt1GiRh/TtG
 2qCOqRzLN8RjniDAiC/ZTRibTc61ej9piMORf4MKIG7qKctLhEbmAP8MaQTBTQsSy6wo8
 dJeUiEpIMptgXmtI7UZ1/yKfIY929C1pM2TvLpIF1wqOGqQ10hXqb6vN0zLPjm1Js9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460393;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=e1xTXUdJBJy44H7rwXmvsQjBVl/r1YS8CWHRr4HN54c=;
 b=jy8IHRfMRFRdlzwm9Fz01FLRG43mU/1HpyX74m1dbfLmKRQGliyHK2UnWNG9ZF2lFT1h
 9T6Pt4s1EqlM8rxizwe7ExM+dcLQxbkW/vBxaBS7V9ElTRaBGEkwozNL1fv7ksuXrnUMA
 hjGQHgww/DN3TTPAMEn36x9e6ttauoB54vDXxrP5XUkLq2YlQI1zRezOUX5phOFquEKoA
 IcWZUjwS72+NqyoEQRPyRh2VKz4zF17v/fHNDb/wICtJFfKL51UiXYiOuqW6fj0RoWBX0
 n5QTKSO6g7LibiH6PGmtYWhQRQZE8dlrI/8R7sYBcq+nIRgmJuyWoNz77IvDuYI/ZwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=o+qji61U; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com;
 envelope-from=3p_-oagukd6ysuxhumuumrk.iusotzkr-coxkj-rgtroyzy.uyauyr.uxm@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=o+qji61U
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E370605E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2d6fb956002so52098515ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460392; x=1790065192; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e1xTXUdJBJy44H7rwXmvsQjBVl/r1YS8CWHRr4HN54c=;
 b=o+qji61UC133K1QhajjQRK418EpzK3eTLDIiuWA6xmaTwQ4AF7dKj6UfRz6hZjOMKv
 K22EHo3kRbaWT9z6Nj/PqRWrG0OfdpRG6ItuLPbB71MiU/2YbItbmJA/YXaap727cSYM
 8CYZ4TgXxxfJplCIl/rpGjVxHS9BdFqEedT7kN9HGYv12qI2j3KcXlpnSz0KCvkjkG+T
 pcopzW5wt86jEW63zPL4d6+5DVt+DQPapGHDkGtBR6Z6EALp4K5DAB2bhoM5b9AQckrM
 Mqe6iCCEwU7vGH0LR+Gi+6MaAhpcLs6hK6ydqW0wa+IiQ0dic7prkF/Qv5Qk7QIBwy3T
 dj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460392; x=1790065192;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e1xTXUdJBJy44H7rwXmvsQjBVl/r1YS8CWHRr4HN54c=;
 b=1iybqXb8vHnpYqDe4xTcuk2j4PVz+vU/8HIKx/DsK4ECXDbDYzvZODsCjZD86HTEQr
 9lyxX+TDbKZ/fQDDAk8TEIcm9u7pHjPzCGK/vnWdP4JdS+tV+JwbS5w5nTO0uvXpTMcI
 bIko5Z+Pha3+8g4MazA1v5tl3AKtiqjpLqn+9gvnlseNAa8uPT1G4+SGJ+CqS+us55ho
 HdhRFcMQ1TgkXdDQX+OAD9jPrl6KYAsz94I3jUYF4HCyE0vgkmLenhNw6eMqt7dbDoFC
 QYoobM6NoQ/OXf6mdotZ59JVfregyIxrCTqEJpBmsk4mezsxexv6Uyye2m2FvRYIwHQ/
 Yqdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8JHbod3EwN3x2ycWgn2rH8n4WlxNLXTFtquCw39Vo95zu5ZsRWUUgjA5+CjgqLoPcpozHPPFPS1BQQi+Sgsk=@lists.osuosl.org
X-Gm-Message-State: AFuF++mEOId79GjFx89/fCNkhKma17of68eJHWIfojyUQS25nyiEYKgs
 YzUQ76NYnHUH4oCb6WEZa+PnRL3UmrUfpSS6vmgLBdtaSiZIBGw1PKXHZ72paF7KZIZBxK22wc7
 x
X-Received: from plty2.prod.google.com ([2002:a17:902:8642:b0:2d8:da84:22a9])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b8e:b0:2d8:d4d3:3fbb
 with SMTP id d9443c01a7336-2dd6c73445amr126364165ad.15.1789460391377; Tue, 15
 Sep 2026 01:19:51 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:20 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-4-morbo@google.com>
Subject: [PATCH 03/28] ARM: atags: Replace strlcat() with snprintf() for
 cmdline extend
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

When CONFIG_CMDLINE_EXTEND is enabled, parse_tag_cmdline() uses two
strlcat() calls to append a space and the bootloader tag command line to
default_command_line.

In preparation for removing the deprecated strlcat() API[1], compute the
length of default_command_line once and append the space and tag command
line in a single snprintf() call.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: developer:gpt-4o [editor_update_file, shell_command_run]
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
 arch/arm/kernel/atags_parse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 4ec591bde3df..21140b44d96e 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -121,9 +121,10 @@ __tagtable(ATAG_REVISION, parse_tag_revision);
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
 #if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
-	strlcat(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
+	size_t len =3D strlen(default_command_line);
+
+	snprintf(default_command_line + len, COMMAND_LINE_SIZE - len,
+		 " %s", tag->u.cmdline.cmdline);
 #elif defined(CONFIG_CMDLINE_FORCE)
 	pr_warn("Ignoring tag cmdline (using the default kernel command line)\n")=
;
 #else
--=20
2.55.0.1032.g73a4cd73de-goog

