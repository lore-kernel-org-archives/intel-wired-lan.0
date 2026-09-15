Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3738C88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C39580B80;
	Tue, 15 Sep 2026 17:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o49wJ_GzaT7i; Tue, 15 Sep 2026 17:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5051F80BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492662;
	b=RRSL7G987jcIVgh8Pexuo5u72ZEk0D/4324YqkGgVBCyEE0onq0VUYMyrJyQxd8SybPH
	 +v57wlX2EzhyfQOICJBB+5qmmflkSCZc3kKOJYUqlZjG3xP1IMNcURVtNDed+8D7kEl16
	 xnTkrnfAYu1VfK6Ykw9bZk6f/Dd16RQLbQh3GdVhTlIfv6RRq70QSmj5LacVChKQ6uCPb
	 6d3bORzQwfCLNB0DsQR68UCu0VjM4dDrDlw/18vCTLqTs99MLB//mKb/9K883TgcYx3XC
	 myiFBwuX0gyVIEbNtQocITPNCoSN+dNEbzPC++DAjHH9HIhIXnk5bts0A2OO8JKWWZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zWD4hm0/QtNssxCPHbfwVqSd2Rh5fwz1bRTM/8vetN0=;
	b=plt3lsL9A3+d7pll/733jP3R3mDngAhtdmlfxYmJ8bBj47qy1iHFAgECOUSmTleF6Ke8
	 yP57mqxmzUBqSrrAsKf4IpQUBJGZqqbDACxhYOQCvLk/Autw1xdRFb97UO6gRrC6qbrZO
	 U0+XCyKC6dzAJjAIyiehKMWY0Z8H0twXUHeUq47lSRlyTzoas3jGHAFYQQdzYCSUUwjjZ
	 66+R872+owUM/TNUM636N9y9S/78GTAmSm4z2wpbrpdBSpSL+qG0trEWO351O+iNal0la
	 A0MSWIOS7SST2ygpj8sxDT2veQnov1Gpq9q27SLddhUsGQPXiVsC1C2umRK8eGNJKuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vcl6Gu8b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492662;
	bh=zWD4hm0/QtNssxCPHbfwVqSd2Rh5fwz1bRTM/8vetN0=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bwcAPtNOKk0wCybXZYfv44rxFKRdaYRxoodg5GeBDqz1aVMsyqzxWKDhUMmlI3B3a
	 70f3t2hs0Rarhf7IeWBhjVB/MYhL40lAKxyTmy8YuofI9qCpZ7uhid7RRxP8Ys11C4
	 EPWudI9m2ALZ68gv61k6z1Qc8RAKQDuluXCkdF+GQZeKEgzh5K0ZtOSJ8vLGxAvcnT
	 iyJdXTMdIvSlbHdqycghcO5lfAD43Gul77BpMLPBGFRoRJP/jipDUJiiTXWQLf3Vgn
	 lrDAXAh1nT/2oX3pqufJJqKyqXbssox9sftZoopLZl4XFLaU8niN9ZnZcgLtYkjTO9
	 UXDwtyABLnwWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5051F80BB8;
	Tue, 15 Sep 2026 17:17:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98E68493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EAAE80C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gch56312xfnE for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 78F2980C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460394;
 b=HZdDUo5ZLpr1mfv1LfHbXoQwwTwvoAQoITfDfkSrAqIE6ey5PATfEu1818yYUFccYQLl
 qaNFp3ne6gSOmSLmtUsLe4PAhYUx7LCmNCVjeYL7B2xxfvWUn3c4/MV7LWOTZ6BGN/TRa
 swDqLTtkP5MaxTnotMnqrgmWE/ZWRwUWg9IKlz7CzT1gv2jNqB/rBeu9vtbstGR8F8BmN
 Tfcoat/zN4bwcUDUw3kQtky1pglvLxftT6jEAVh+4MTqRs9IXDE+E+Sp9qdMS00R+Dcyg
 IVKygofBuZ8FdTRsXzgSXXxxadsnnf4WGWsstttT069SNqzExP6AaNqq3t9zyuruC1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460394;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=zWD4hm0/QtNssxCPHbfwVqSd2Rh5fwz1bRTM/8vetN0=;
 b=G2reYx9HZqjHzNSKupW2J/Q4ZrciPn4FEFNHbr7/tRFTYnOEG9YW4JC0ZabNGdp9GHYe
 jxIUItc0xs8Isnw1BLGh1AWoMEs1JS4lk67wGa1/j5FuVyNb3Kc4yQfXzlduC0ZYcynnR
 Zc5BUW85F9iT1/13rooEjx9CLzVkn9kwWr4husQN2QX069qR6i1P92DMUamwsQDgwl5r7
 pClBXSxiAiPZkX+NQUilocwbEQMP0I5r74GuoYg5Mq8uexdvgLWBLL77MXXqc26yav3N6
 OW2u/2kXy06MvpTgZ+YZkTBDhlLiLKds1LI+ZNIlUkQihAZ6iNwbkGE+5QINvKPITYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=vcl6Gu8b; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3qp-oagukd6ctvyivnvvnsl.jvtpuals-dpylk-shuspzaz.vzbvzs.vyn@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=vcl6Gu8b
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78F2980C3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:53 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so73486585ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460393; x=1790065193; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zWD4hm0/QtNssxCPHbfwVqSd2Rh5fwz1bRTM/8vetN0=;
 b=vcl6Gu8beHPspUF6zVbOYmaM4563ZR4VoniE38OyadVtDWzVGub5EzwFH45l6aJDpE
 n1oOBlPiJjWm5rMQzi6Qnj1r5dmgFC9zrPh2ZN2ZcsClO66uBvfFn0q+AJkNs8VZeddG
 KtBLVi75wpnokibN+SyGAqjNqQ7wUn3bQmuXD6tLG+GhFqRUfY7lH2VbRLOUNyP1Q6KJ
 mQKE14niP6Ga4uLnlCGGFvdrcZQjj7P+ni7EMMIAVURpG0R9R3F89g/cl1ejNlyHVDGN
 HyZBp8kOuK0xd9+ujTGE0PkT1JKQNyWHGARzn4QTqwVAVcpU6r9Mx10gNTqrBQes34Kv
 A0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460393; x=1790065193;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zWD4hm0/QtNssxCPHbfwVqSd2Rh5fwz1bRTM/8vetN0=;
 b=XcFEYwhf0cu9YOBaffmGSFUaadzFTm44kf5BtDfg2n5bQJ/JuiXPKjoSBN6y1q2IWp
 mRlP0rRfLUUaeyizLCikaHF7eypywojTjpHQ2RNVsK4USR13fBBCGV9qmpHTRInt9a+t
 IjQFsKwBDm/igaXjOumBDSfAQoxek95dqoZnj9U8Pd6b+4Y+m67lQ/oENEHgkFIRGORz
 zKASBoBmzsUaps1Eb9F9grjgDvFOklrLnIx726Q754NfcNLQ4AOc5QTjM5rPjv+YOHGS
 ppW5aMaZT0AovJyCo54VgPVMAkMSlxVkArboQTIwf4bPugPuAtYGehRVE2JpLpds2/N0
 1A5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBywb3BM2GQhJkMT8eH/dvnl0SOtmIrceeurf0GbDNvUrgjbzzRKk2WuvzbCGR1CoF2Oobzyi1JDslP+pPHJ068=@lists.osuosl.org
X-Gm-Message-State: AFuF++lqrCbG7gpnW6sx6tLMcG6JM3OV877wnH6gywSir8pVqucR1XfM
 EVCCNSeu4IBM+lvTRQfdwJvEpEw7H4V8yby5UkHm6qocq/zCJnhhxOLpqN1jQe/ViTX7kt3HddU
 m
X-Received: from plot14.prod.google.com ([2002:a17:902:8c8e:b0:2dd:4712:5539])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f541:b0:2dd:1701:3b6e
 with SMTP id d9443c01a7336-2dd6c73381dmr119309875ad.16.1789460392218; Tue, 15
 Sep 2026 01:19:52 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:21 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-5-morbo@google.com>
Subject: [PATCH 04/28] scsi: bfa: Use snprintf() in bfa_fcs_fabric_nsymb_init()
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

bfa_fcs_fabric_nsymb_init() constructs the node symbolic name using
strscpy() followed by five strlcat() calls and explicit NUL-termination.

In preparation for removing the deprecated strlcat() API[1], replace the
chained string copies with a single snprintf() call.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Gemini-2.5-Pro:2.5 [shell_command_run, editor_update_file]
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
 drivers/scsi/bfa/bfa_fcs.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
index 9b57312f43f5..7a4e0e8c7182 100644
--- a/drivers/scsi/bfa/bfa_fcs.c
+++ b/drivers/scsi/bfa/bfa_fcs.c
@@ -821,30 +821,13 @@ bfa_fcs_fabric_nsymb_init(struct bfa_fcs_fabric_s *fa=
bric)
=20
 	bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
=20
-	/* Model name/number */
-	strscpy(port_cfg->node_sym_name.symname, model,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->node_sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-	/* Driver Version */
-	strlcat(port_cfg->node_sym_name.symname, (char *)driver_info->version,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->node_sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-	/* Host machine name */
-	strlcat(port_cfg->node_sym_name.symname,
-		driver_info->host_machine_name,
-		BFA_SYMNAME_MAXLEN);
-	strlcat(port_cfg->node_sym_name.symname,
-			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
-			BFA_SYMNAME_MAXLEN);
-
-	/* null terminate */
-	port_cfg->node_sym_name.symname[BFA_SYMNAME_MAXLEN - 1] =3D 0;
+	/* Model name/number, Driver Version, Host machine name */
+	snprintf(port_cfg->node_sym_name.symname, BFA_SYMNAME_MAXLEN,
+		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR
+		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR
+		 "%s" BFA_FCS_PORT_SYMBNAME_SEPARATOR,
+		 model, (char *)driver_info->version,
+		 driver_info->host_machine_name);
 }
=20
 /*
--=20
2.55.0.1032.g73a4cd73de-goog

