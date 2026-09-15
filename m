Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A01C88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC336074F;
	Tue, 15 Sep 2026 17:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id StSF5rN5mURf; Tue, 15 Sep 2026 17:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3A90E60755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492666;
	b=EnTZXtE9TfJHdSo8ig06+kVHaB0GV9ta/WRhbkDKL8q4Lc/c6sRz6296MWTcasCUf9PU
	 sZS6Fhqx22l/jwFpniNYTea+xzig/7vNKqUTg56/4eHf0G2TOlKL/KX8u+scfw/HzwOiD
	 7xY+4VrApqr9U0kUwbeipYbRrOCOiANJ/VPaUqKhA/3cPvVGBvEpZPQN+oD9ACNCAmgQB
	 P3HzlSpDPkGgoU8aqzZoUMd7+dUDIVKZRWw81A1yLiePSNTXPfAqGg0hmguk6evI3PA8K
	 Rp4a/N3Kd//uREAkFDy3OYk/sfgj/Dtkfx8wu9LIs/yFOWzQsUE/sdP91Veer7r2Deg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GTPji740I5eKt5N5xuOCbc+sv4InPenFdSBTJb2/BeU=;
	b=B6ncdA26g8au2KAhgpfvc5W+4txNSA0ULk5jrtp1/pSqy/hDmzH6PoWhJgxkigxye2SQ
	 DCdTGHBdImDj3T3SG0BuS6VvMAx5yIr7HUUy6d9IXDQrGugJzYMA6/rPhe5OrzY2Dw2v0
	 fGCMMJwYKpeKXwG3HA6Q9T0pBmFC2lnmqhas2MHMPjcD+cW4Az371m3/BgnNQGvbCqKwB
	 3uLZI7BlCVikw64MvOUX5ps6tY10ewZgALvANyLsVEuFcm+a1xM/xWKyxo5oG00gdJGYq
	 4YeRJFiSxeKRZVqrGbtcfOdYxunl54ZodT+wkVaNLdmompOukp2sK53PvwOVxPcBEMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492666;
	bh=GTPji740I5eKt5N5xuOCbc+sv4InPenFdSBTJb2/BeU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FDtkdDX99hkK5uulV93KdE98ulegAqfDDNfXOOBhM3eN9I0n5FSJJ/bEOgKg5F+ow
	 JAzorkbo0aNkogjJEXBIKC3IEsDe1W7Eay6oVTPHhOmfnSOLvB6EjJTZtYrCKn+kJA
	 TTL7MYl+rwuSyVZNZDgx0ZYqIJzGFY1wl1d0uM0i1XO/0gC1V6I5Ttb1BCuqOqrw4a
	 iyphvPBUUS7T1pI/XtrrFzJ72OLMNjJ9kNAMYP518cWSjVa2LN9PEwubCjS6xWxF7F
	 WgO2Q7sRsp8CimkGAXMp/FoRvpbo/+MCUqDOB/K+mH4l5cwzv+wd1o2hU0U/jNQxTi
	 9W/doRnMVJxvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A90E60755;
	Tue, 15 Sep 2026 17:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DE7C493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5240380C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3avS8ZPrtLS6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6171C80C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460398;
 b=ZY2zmczdSFhVJkqSpBHoDrG8bvoqPN8ID6qmwAUPSCtTByqchJa8yykgOYq9BveVcdX3
 6kXQaR9lrFrAGVC0rHoTmybtr18pF+iNxCOY/vgHHX70hV8kOcfd64jRHNzIsRf3RLO0B
 cJn6YwdRGWhFPPrIFM7V7cHn/H7hIEmu+LWzELFcZiN91+2eVxteqB1qkIoBNUSHus5hQ
 ESKxOCFfS1N2o7IZmmSgwjprLn94v+eAiHPXDASFH2HbykDwSFrishVheftN6Scy+rRoJ
 hw9LmtoBhsZAiKeio8zIkKw5GEzs8E7FSXfDdQ6dlv5Ff5/gszi9T5D6OVCmFxUQm/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=GTPji740I5eKt5N5xuOCbc+sv4InPenFdSBTJb2/BeU=;
 b=LFKFmBdfer6ptrPHW1cCtvewdCvDxZF3eQKwUcsq9rz1mjjegmo1j2ZneHytxhfWu1gR
 rrsTd5Y18WL5yPCYiAbWKos6l+COXbxdDNV2RSVh6e6R2tLjEJ6vIQVqt2l2nOi5GMVIh
 i7hU/aqkbqkn9NRvEAzFLySyUMhHUpqB3ZTavX6a2nrbzTtrvGJWVW8XL3qIaemlKH9/q
 8oRxbM86rDY1y3eQf+FKPMeiI524HqtjPL3KpuBWgfcXsim5KzHFCHbASBULG7q9lLHLk
 aUbncHUglTktdr7cfBdkdzFjKmUpaJ+I5750R8mPbzYdTqHwpIb4tzRtO2GkgS8GZ7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=Tg6ZAGq3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com;
 envelope-from=3rp-oagukd6sxzcmzrzzrwp.nzxtyepw-htcpo-wlywtded.zdfzdw.zcr@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=Tg6ZAGq3
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6171C80C3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:57 +0000 (UTC)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2db87f759c5so73162975ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460397; x=1790065197; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GTPji740I5eKt5N5xuOCbc+sv4InPenFdSBTJb2/BeU=;
 b=Tg6ZAGq3nQwSpxexqlnSAlEkixphuwQkHvLb2QdJMInmItGsi67uyDmrQVFELGqoyE
 zFad4P+JJK7+7jDbSaweSuirHOPpcXoL7hWYarnmdskXM9axAyxrBy3WzsirxKepokwn
 yoryPimcpVtuLWnhGzc9S+fLn8IYqYNdQUdgxvlfUtMlEsHUzrq4xfCQs27kb+3LvOUu
 q9st8hYP5IJ3UiKAM2CAWzTtEYgmcdwrOfW4QPYuDh8jJirYnTpsFvOLlJF68A60/U/9
 xhzFnbwqM9MQ4qvaLK9QHfqj7JP/2JdMplKI5JhzlYbtODrGYhHfq82Syx32ZW4V2QDI
 x1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460397; x=1790065197;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GTPji740I5eKt5N5xuOCbc+sv4InPenFdSBTJb2/BeU=;
 b=kgJtUqlaGzL0S1/amnWGqta7glTJOAKPxeZCyPGw5lKnl18e35eDVmRM1WJ7oPBuLA
 vhqLzgA2sx5YrXXSWPmIqFNpVh204YBfIjg7wCrtreEFx1oE/ESVdEbtlOAJKwzxYfE7
 A52sHQ29N+DkmBdxt9nxRNL6G69rbtOCz42ewp+c+lGWdZwGvH8QG/E1AUuzUeOh/Gnh
 OhhzSBaUvTZajZroEsIw50Na2JGX0X3Nq2GUrzGacPgpzqkUyaQPUoc0un92DE2O1xsq
 r7Zz2jFvAnjApML5s6vkqhBum0FSEoyj6Ve6nXpWQghTwqs5Ed+oodertzhlCQNQxO1c
 nyKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByoC+wBgZGKqvRDUG6JLHg2SIAOo1ukm27uwW119VlxkRXoZgSYA9ml9CnCasJx4UbcBC14Jat9itAHp2nkpTE=@lists.osuosl.org
X-Gm-Message-State: AFuF++mA6uKGOzM4k2IDbUgnt+4RquGxH0liNN5FN1NSFqH0SstIboEf
 cudm+QNG06+P5rEMaaU5VR6BtWCaljYwH+XjsVlRksfooLjS5/w8UW80kKmwM3Uc/eh8mEQx46J
 g
X-Received: from pltt2.prod.google.com ([2002:a17:902:d142:b0:2dd:5303:f006])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:244d:b0:2c8:248a:5dbb
 with SMTP id d9443c01a7336-2dd6c5eecb7mr124092305ad.7.1789460396342; Tue, 15
 Sep 2026 01:19:56 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:26 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-10-morbo@google.com>
Subject: [PATCH 09/28] drm/dp_mst: Refactor build_mst_prop_path() to use
 seq_buf
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

build_mst_prop_path() constructs an MST property path by formatting port
numbers into a temporary buffer and appending them to "proppath" with
strlcat() in a loop.

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf and seq_buf_printf() to format the path components directly into
"proppath", eliminating the temporary buffer and repeated string scans.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Claude-3-5-Sonnet:20241022 [editor_update_file, make_kernel_bu=
ild_single_file]
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
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/dr=
m/display/drm_dp_mst_topology.c
index 7ce9e212770a..229b5fec44bf 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/seq_buf.h>
 #include <linux/seq_file.h>
=20
 #if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
@@ -2216,19 +2217,21 @@ static void build_mst_prop_path(const struct drm_dp=
_mst_branch *mstb,
 				char *proppath,
 				size_t proppath_size)
 {
+	struct seq_buf s;
 	int i;
-	char temp[8];
=20
-	snprintf(proppath, proppath_size, "mst:%d", mstb->mgr->conn_base_id);
+	seq_buf_init(&s, proppath, proppath_size);
+
+	seq_buf_printf(&s, "mst:%d", mstb->mgr->conn_base_id);
 	for (i =3D 0; i < (mstb->lct - 1); i++) {
 		int shift =3D (i % 2) ? 0 : 4;
 		int port_num =3D (mstb->rad[i / 2] >> shift) & 0xf;
=20
-		snprintf(temp, sizeof(temp), "-%d", port_num);
-		strlcat(proppath, temp, proppath_size);
+		seq_buf_printf(&s, "-%d", port_num);
 	}
-	snprintf(temp, sizeof(temp), "-%d", pnum);
-	strlcat(proppath, temp, proppath_size);
+	seq_buf_printf(&s, "-%d", pnum);
+
+	seq_buf_str(&s);
 }
=20
 /**
--=20
2.55.0.1032.g73a4cd73de-goog

