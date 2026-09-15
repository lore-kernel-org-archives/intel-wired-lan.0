Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4343FC982C1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D7160755;
	Tue, 15 Sep 2026 17:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtszKd213a5B; Tue, 15 Sep 2026 17:17:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9F1F6075D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492671;
	b=DLQSg19oEjzlEhQBYSaiSDBH/Mhe7RABAjxJvKhJ+GdfEN+v4/27JknrMfa7NArqGc36
	 RiC9II5QyUvwptiIKXciluD15UK2SHZ8Sce0Epq/AWhnjokWpsZFUshqe0+Eo793QfYv7
	 nqWAi2v6Xg0sbsRspaCD0dN6Ebfd7slfMGVOQP+nMrV29y2iGd+N7x0IUs93gtt6aE7WO
	 81RXeTcUjH+fKmR1bSaLV7zW0lM+3MowFBd1JkuI67KXJ650YLt0J+So7LIM4j1gdoblZ
	 l2PHjqkpPjTGfMPGhzWQJXE1QvhLbSm+fMU6bhLxmuigZi3ep6v6XwVKWYDdhjtnIKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ANECGYJQk2+Ya+FPrAm+IsCBeyM6Er0meffRIzFfkVU=;
	b=Wf1lFeEZdSkkREXmPvcOcUpqflXfjSuS9k+ahDw4JtuRyC/wcOwdWUiOYgpVsanCsAOf
	 bYYPxrIhQU83/h+FXbqCtMdsamB3Dhv4azwOJrV6vBTZLEZqSeuwkECoI9p98uX5nQrPS
	 /vJD0uLygO59WyCc126ssoBXu1Ay52zw2SIqf9HyUdbAKHj/SKQE6CM2QTe0jUPaxyAMm
	 fym6FqTJea1WGpv2vTRQDy0SUr6D6rq6Mc1lSST6dZ6KlTWWRLKc+ZKuCNJCHbcKwdjmO
	 PX1Q1RZeU/0yZ+hgX3LYnaIAShbVsrRvdg08415+JY/mV+sDdhpODvpuJNy5decH4FQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492671;
	bh=ANECGYJQk2+Ya+FPrAm+IsCBeyM6Er0meffRIzFfkVU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sutZVQNBb1HsrFyzVsVPzKo9hJSaUW1NF7QxLHQ7Z25TK3Y8YurfKk68nlYVdiHoa
	 cejMhXPh9zK6r5P48AS3811IKcxlCEWN9U4jcQ85eSlE48XPtuZHqIMq3eZSXjnZjT
	 qay0x2Larl14mABJGf/rWIgAeML3v+X7WWnNqYIM2xZNAIU5qt0lXOvZiLdJxOZjCu
	 Ox/o1EWYV8V9PPk70VloZ92Uk40n1g4sF3qz+l7zuAhONo0EGiUtlvLKpM76VCZOoz
	 iqN2kwCUekXuCMzMw6gUhxKjkomJtbrRA0Cgt+uaiR+HADIZe/BVUzyUuI814zeWzK
	 Z/EMy0t6BXjrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9F1F6075D;
	Tue, 15 Sep 2026 17:17:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6D6ADCF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB15C401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UrDBawaW8qJ3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B7BF34018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460400;
 b=L/f5sjmymKb//gSmLSs8oRu4kuv9YoG9mww5EoWwF9OOGTFhYe0sY2ptnPvNDMpsVVOy
 r1Fd16j8yXH1XZsApomOQCsY8w4Pr07eHVshVxROU0MEBTiiY7DvBX+h5zZ+8phn0vwAD
 uBGe11TXUTdelD7pAxs1qEnyDbxxStiItX/WMq9rlT3cIkLnrpkenVvoUY6Uktc/5Hcpr
 5cf0DWo9PiMn75M/8Faa9TAwH/i0vL4Qd/mDsbp/rhWMIFlKQtXd0PGlA9Z4mpqbxo/Eo
 9i6Ej2zz8ESGFMKf1Gmr0UCqQ4HbuNx0yczaRt10wlfs7xfxtdFecebR/+bRN2d4NdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460400;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=ANECGYJQk2+Ya+FPrAm+IsCBeyM6Er0meffRIzFfkVU=;
 b=FGg621Fedb6Uv31fcZqRbuiP0F64IjTTngYgg2EZ/sVbwhoLJ15NmxNVtcwfWqECd0cs
 +mmlfbhFnuV0kJIEj4so9VzoaQB6Iz13V2EIht5Uxdl7IhnKiqyv/YM9nS8LIrKM+vymw
 SOUOyH36M9TCeJFXvqmRsgdoGdB5vOI9Bz0oWClYDLDNto5SGIG0VHiNJC3k3orKiwb4E
 /l8xsWMr9Z/uBwIrh9+Ac92sLX7OpW/Kf5BYVDGuQjXKfuX6Ltv+fCcmlZEHsQKFmbKxe
 ijqmYONWtmAuADbhFFKmkcShathnReoaYs/1d0jowHV314EjSSc3zL1+mebXb/+sJjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=Aj4m+KMf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com;
 envelope-from=3rv-oagukd60zbeobtbbtyr.pbzvagry-jverq-ynayvfgf.bfhbfy.bet@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=Aj4m+KMf
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com
 [IPv6:2607:f8b0:4864:20::1047])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7BF34018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:00 +0000 (UTC)
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so9420546a91.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460399; x=1790065199; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ANECGYJQk2+Ya+FPrAm+IsCBeyM6Er0meffRIzFfkVU=;
 b=Aj4m+KMfmm7cOIoCLaYa/gVasxx3ctuEOojLJHWp1/FZPczNBxp2leMBeRJBOy3saO
 vr5bmMXq+Gwo1Fv7WMMMAVzC3hm5qGGlD8PC6HdGZn9D8xJYrVx2V2T4agxBKwwITe6a
 pSdxsuLCGoXqhHJ7WIzY5hLzcyjOC3cRuoFW7w0/QkxG3le2HOIPVoWDshhOWUowOmgJ
 U1M7KZOXH5JWD7fjTTjJs8X/rMGZhbA5zijXNn3msKnW9QRTYzlALt8VXnPisrHDFAlO
 fyQe8I4oxflGRQqysFotopVCn5FL3bI2iFtwL1VlogoRNtP6du+ffexK3WTPbvkPKGyX
 XTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460399; x=1790065199;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ANECGYJQk2+Ya+FPrAm+IsCBeyM6Er0meffRIzFfkVU=;
 b=PUn44VPgqmudQv2zpqp92oMNwXcpLHmtU9jYGTk1JbqXVCELyN7w1haFBWymR25aiA
 s9Qi8y02aHJ5yWoB5/UcDAg9mi5IpmLGLQxDZG0DXfqaVqRDCqaJwsbl9Ab0bFih/qSF
 lfglrHrzU60Wi1uWM6xPJHO7z2oIUEP/+NQCSO4EibY7oJVq2sWXck08bnr+FIm0BJq6
 yZB45AtLkUiLKWaJ/pDOmlhG2pLPoLNycFbM/i5mWL1dUXPYWxmdj1Hyl5rlXAuFJEpf
 +P1aeoaG+HQMg6Nqf/EYPxL/qQvXWxPEB1NgdhbNI9rRCgInUpa8sLQqtZ66Q2+Wg5WB
 JRPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBww+2Vbjoe1ayaBZ8OtjPPkdi28zoene40Q/pf7JkDYxjk2xhwRBsusK32bHfVV/ji5f47RdLpkigrYD3DqjTc=@lists.osuosl.org
X-Gm-Message-State: AFuF++l52MA/+ftmorZAZEh+2jjWtI+hvGw1rRONGRdWeQbQ3gmMsFeA
 LVex83oaZimIyzTYMJiQaetfjjDw9YgXpZcZpIyGz5g81B0QBcrshcHOoFgxKYzDvy/hawqiJVQ
 y
X-Received: from pllj10.prod.google.com ([2002:a17:902:758a:b0:2dd:63c:daa3])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccd1:b0:2dd:40cb:a04c
 with SMTP id d9443c01a7336-2dd8386925cmr476775ad.19.1789460398847; Tue, 15
 Sep 2026 01:19:58 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:29 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-13-morbo@google.com>
Subject: [PATCH 12/28] fortify: Convert strlcat() to snprintf() in strcat()
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

The fortified implementation of strcat() in include/linux/fortify-string.h
currently relies on strlcat() to perform bounded concatenation and detect
buffer overflows.

In preparation for removing the deprecated strlcat() API[1], replace the
strlcat() call in strcat(). When the destination buffer size is unknown
(SIZE_MAX), call __underlying_strcat() directly. Otherwise, determine the
destination length with __fortify_strlen() and append the source string
using __builtin_snprintf(), preserving the existing fortify_panic() check
on overflow.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: SecurityEngineer:Gemini1.5Pro [editor_update_file, shell_comma=
nd_run, test_runner_run_kunit_test]
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
 include/linux/fortify-string.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.=
h
index cf841dc71fef..0b489124bfcb 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -363,7 +363,12 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	const size_t p_size =3D __member_size(p);
-	const size_t wanted =3D strlcat(p, q, p_size);
+
+	if (p_size =3D=3D SIZE_MAX)
+		return __underlying_strcat(p, q);
+
+	const size_t p_len =3D __fortify_strlen(p);
+	const size_t wanted =3D p_len + __builtin_snprintf(p + p_len, p_size - p_=
len, "%s", q);
=20
 	if (p_size <=3D wanted)
 		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p_size, wanted + 1, p)=
;
--=20
2.55.0.1032.g73a4cd73de-goog

