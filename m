Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ADFC88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 796076074D;
	Tue, 15 Sep 2026 17:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lR456fMhf0nB; Tue, 15 Sep 2026 17:18:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 61BA060760
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492682;
	b=O9rzKqrpWOAZv0DZKpSwWxg9/GJsoMm12/xlxxaC1VfZTR3kSvbVoolstuS9rM/wdsdy
	 wvGLnmpj1qsh17OZc0v25QNb/CDXntW4kFm+lzYQvhUznAPHqLc9cFnf2AusLELe2e+Hr
	 XU0e8Y9aVNMjgGerE8s5K1ULP1KSjvBjTcOYS3ZGnWF091FqlJ1WH1zghfLPCXGpINW20
	 66MtQLRPr3G/QlT3Fs+9up8VEmzp2ybEtJ0kaZsANEVOZOLa3bwElEYIhQvbau75tU6Mt
	 99QwnS1moajTUqBptxCP7mI6ojqt7hybs3JBozN1gUI/aWWeIU0BhjB6q6VkSzyrUoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6A34g5ncwO0UUCNmS7GYn32h6CG74u/Wx3k3q5PSbh8=;
	b=H4TnkzEKJAlqvgFiJSoSY0eYihNFozUA03hwuDP1zyRM5eat3piado/NI5Tw+Fu5Vhi9
	 wuYk1C5UXUQaMKtJNixDzERGncOU+Mm0LfbbOT/ubEwGVpiy5KCB236u3TNGks0FIKQ5v
	 y/5TRThgPDG9qy5pJJpJCA96o04RRAN2+p2uVhxWLyCVJYtRMJiOEO00gX3pgGkcmmChy
	 /714v4wJXGi9/6G6g0wgo0qEPjnNKneNQgn/wT61p382b2F30WaPUxfQFR5G1NHEWs5oh
	 yExBpRRPCLKfp722W/jklFwrz7s7hj1VCNRb9l4kOaxkvYJfh/cp9YUeU4qveL0Gyeg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492682;
	bh=6A34g5ncwO0UUCNmS7GYn32h6CG74u/Wx3k3q5PSbh8=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtESmRBxfmo9snA85Qqo6Hf0OkbITT+Eah871M7MggeDGR6G8x4XI0/YDZMEmHXiI
	 kwyYiL9RNbsENx29G8Mm0NjAgIOZ1PUxCF9/b0OJS7UxDPhIGcQt5pbSlUCMSRfdrJ
	 G5Ne+mzTLWdXcxnASyZYO4iTuv/2q57jElmlT8UQLyOCHQyIZ9Gi11F5zVIVCuJ8Qc
	 ST19d8IQ3nkUDhpunyb0/ZZKw4rctLH4LOzU6fVOenGXu9sYjJTfP4LbbrA++4MTC1
	 I0cstFltVW5UMGWo1EPlvFDnInjUVQEVbUgfgqTN9dnsxY18Reui0CilFOok/nCVP7
	 BGzw/0lFDDw/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61BA060760;
	Tue, 15 Sep 2026 17:18:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E18D493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64E2B4018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id up_Owz-ZEQ7J for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 53ED1401A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460416;
 b=Uf4UVLP4XhpWZKCGBQ8IM20mkB1NxHo6iw3EfcUfay8OXB7XMkXcSWO3eroSj7cdc5vu
 pYVTM9f21gkB4pcPQcUCF8wliDBtTgy/Uvaqc+WQHewF2QMnLhyOGHs/jVz5hBwDTfqds
 9gi0DYpRbH7y+mDn8SVqKbbILtk14ow1C7Tk0xP6EWZdZDZgSAtbN1J/B8u+tKWjIbSWQ
 akn/z7blsRtTdFMBwMHkiiKzxXzQ6QgLilSQujangupD0hQS2b6GE1221kwqD/64VTkKm
 chFeWavebgGJNPoyqTTqsNgi+Pz3iBbYMd1+U8zf66KZ6+zolYe8VeVamiD1RqOwWfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=6A34g5ncwO0UUCNmS7GYn32h6CG74u/Wx3k3q5PSbh8=;
 b=U0BGvBp1avR+6ef7TI4BFcNmMApKZVf+fhj5rbAVh7UqeCBicBwF6kNhZH4s5AN9CtX1
 mbrmo72HXJ3KDC9Ol60J7XLmexsn/CTYgbzBwSxG0dp/deHVGUMubU6RlJxlq3L3v/MvF
 lYmssC0TQoCulI2TZETDbZ2dhjRQdqbY/sIE98IBDfYeS8EwO9nMKpxWjVksxoKHGgWp7
 9LSZg4jnYYRdcKAunGCHhSYW0dUp/FWb7+NoHk/56XHRtx4zW+3mqYgInXfZgFGxtd2W/
 hO6kHEQ/N/WPnLJhm0gRoOOlBuNgrmCxgO10xodACJV8Hkr7YXGlwxOFKfVSBs7QYCQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=GWvXPg5C; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3vf-oagukd7woqtdqiqqing.eqokpvgn-yktgf-ncpnkuvu.quwqun.qti@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=GWvXPg5C
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53ED1401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:15 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2db87f759c5so73167135ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460414; x=1790065214; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6A34g5ncwO0UUCNmS7GYn32h6CG74u/Wx3k3q5PSbh8=;
 b=GWvXPg5CHjgh6HYcp1HSLHbbMkCAFD4socAxBxmng9rcOA/6+iJ9J6ItV+WsJ2sNoq
 hCR2voIq3q6AC2jCPWP3lBrXTvSDluOOn7/xZFwB6vR0bWFnKkAOaiutcOSBJyAFuoGe
 aBPzff/vh5Gr+sF26yxINNlasWzMKGez4ZzPLXv1TuAZuf8K0erplXvIszsqDhiAD5rn
 q60QG16hAgQuxd/akdbAcxBxWN86BX/3UHPqrXeDml3RniGVh83iTFjhUZV8NTvpmNeK
 bMhxCyqoXQpiqBWbGa405zx5QdGC59FOtU6Ce0jxCesImyiVTloTw5bNaMzxU6ALS1S7
 ofaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460414; x=1790065214;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6A34g5ncwO0UUCNmS7GYn32h6CG74u/Wx3k3q5PSbh8=;
 b=xvEWM0g+WGnpiAabPZrjIzAa6xnO3mY6Lj/T7MozR6xqK5xgGQtpsY0+aKsRFmhWhz
 EorLdWM7l4bd50ojrAJ0haa7Nw1YFXzBvTlHg8ewfAz5MLaPtsWsIGe+HCmxwrWStQIy
 nctm4hB66wh9r8xB2pI8hXO2f/20hnr90IaivQK7EoF3xNzDJ+CZMrF9/NPS9Im9O8nF
 syBv0ShisdyYgqa2C9JVgsA08eKf1U/bDphvgP1Pu/DCNzbLP3t9Qc062/DFz/bQCw5I
 H7usVYrnWy2MaaCWuK1iaXVVf+rJhzmLVkBB7vpU+bdhzYhVnu0L4X1EKiKTydGIS429
 5UhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlM2+zqOSqf0G7XWwrPgpKbMXbouWmc8wV204iDTDoJghqhzb4GLv+R7PdupDv58/LaIKAM0due0hWl01xYMc=@lists.osuosl.org
X-Gm-Message-State: AFuF++kXGedfNmZyUfXHZ78hkYs4uM4Noxb5sAaCNGEChPJCcoa0BYdR
 qTBBqhojweRSJy/HQL770VOBoiTYUixAWoBDKYu3lMoqt7djw10usO3sFF7CIDG0WzhBTVGpib8
 P
X-Received: from plyw21.prod.google.com ([2002:a17:902:d715:b0:2db:8c06:4fa6])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f712:b0:2db:20fa:9443
 with SMTP id d9443c01a7336-2dd6c6db8c2mr126055895ad.13.1789460413607; Tue, 15
 Sep 2026 01:20:13 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:39 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-23-morbo@google.com>
Subject: [PATCH 22/28] media: si2165: Use snprintf() to format frontend name
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

si2165_probe() constructs the frontend name by appending the chip name and
supported delivery system suffixes (" DVB-T", " DVB-C") to
state->fe.ops.info.name using multiple strlcat() calls.

In preparation for removing the deprecated strlcat() API[1], format the
complete frontend name in a single snprintf() call.

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
 drivers/media/dvb-frontends/si2165.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/media/dvb-frontends/si2165.c b/drivers/media/dvb-front=
ends/si2165.c
index f1241b63aa5c..bd15eb58fc84 100644
--- a/drivers/media/dvb-frontends/si2165.c
+++ b/drivers/media/dvb-frontends/si2165.c
@@ -1243,20 +1243,17 @@ static int si2165_probe(struct i2c_client *client)
 		chip_name, rev_char, state->chip_type,
 		state->chip_revcode);
=20
-	strlcat(state->fe.ops.info.name, chip_name,
-		sizeof(state->fe.ops.info.name));
+	snprintf(state->fe.ops.info.name, sizeof(state->fe.ops.info.name),
+		 "Silicon Labs %s%s%s",
+		 chip_name,
+		 state->has_dvbt ? " DVB-T" : "",
+		 state->has_dvbc ? " DVB-C" : "");
=20
 	n =3D 0;
-	if (state->has_dvbt) {
+	if (state->has_dvbt)
 		state->fe.ops.delsys[n++] =3D SYS_DVBT;
-		strlcat(state->fe.ops.info.name, " DVB-T",
-			sizeof(state->fe.ops.info.name));
-	}
-	if (state->has_dvbc) {
+	if (state->has_dvbc)
 		state->fe.ops.delsys[n++] =3D SYS_DVBC_ANNEX_A;
-		strlcat(state->fe.ops.info.name, " DVB-C",
-			sizeof(state->fe.ops.info.name));
-	}
=20
 	/* return fe pointer */
 	*pdata->fe =3D &state->fe;
--=20
2.55.0.1032.g73a4cd73de-goog

