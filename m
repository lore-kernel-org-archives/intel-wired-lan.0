Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107DC982C1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA29F80C6D;
	Tue, 15 Sep 2026 17:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94DdX0m_4twV; Tue, 15 Sep 2026 17:18:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 879D980851
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492680;
	b=Pj8xWfIhV6zXqiIpU7aevbT8+oFTGRsOgq3B0uni1RBVzT6buQhH/uobNLkWj7KXFUWr
	 EBw6e9Fdoykl8KHnZ4OeccJQYCUQ14bgCBXuvR2/V0La4HQdQKEqjafNpnoBewYiXNkfK
	 DiP2ffqPMVYgjdahdyBCTZuytM0xAdrgKLR0Thu2PhN+mo1yOJVG8IUCCY09+dijde6ji
	 p5Bc5M9QOaX9JsjwHMyJxKU6E2MRjrbqeo/cg6yMTnTwWf7KLxDnPXGMhwJeCjzdzWk9K
	 LgOc4zBMpobTyBeg6nIQFz7yp2irpMVycMXmglyuA+1F2i6dx/Gma9tyOW/Iyo4jAAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aUeRHnlHuLyd8Os/OfUYHyanuI/6gSGpcAdXKzgjG1A=;
	b=EwIblg1PhbJLdr9+oF9s9y32hBtzYXOkRRqDfNnzbVaFTwfb6vDQU+1k3tmuYv+aybCY
	 /UtqY1bK9m0uQYfqOoUtO5tFZoNbOpany0c+KZu6LvwwmI/tyzXIvY7VA2s1FxFhY/2Hj
	 +55T121TAzdClvNrfIxVXF0OY3P5MpRod4f12MbXjr28cdqZleS2QOUFbCZB8ouZWFD7i
	 HyT9JC0LaQ+TUKY/JfofgyMpP8VGde7DBS6ROAx8b1qZo6KOgJcPne1IFINIVBwqQqRKm
	 7m4mq7qxKbgx/byofE+XaF2Z1fXW7p/ShgfmNIfVhINvXmFiH3WFj7e2kVyYVSMtVxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DQ2hGc9g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492680;
	bh=aUeRHnlHuLyd8Os/OfUYHyanuI/6gSGpcAdXKzgjG1A=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=36Gk1/aPx2NXCwiqrq5qkYoeDh7rZv33lWhe3qRWKbq+RyuNf1fCgJv3CZfdzkGdw
	 K4Fuu3o6ua6TFB36wJZ+49nY94dwWHo15CYFTmd/FbX9grXdrNrkLWJvt2AIXSyoo2
	 wo5vPI5yoZ2ThIUW/77eE+wZVd8vBMGkDClq1YxdsNEZtzVbzJpe7HML6BKwi6hti1
	 QQWZ0t28pMsTx4goamYN3OYjqFVtdi7B5PfTv0ID5fNMkN8/9NfAl7bnlvluTrD0FU
	 JQmtIlctkPCSJ6BPhOd5h3Iah3jxFeOxJk+BYFScn9PCmpeJkKRrJVH6B85v/3pf9q
	 +uBnqMPgo6mgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 879D980851;
	Tue, 15 Sep 2026 17:18:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D55C493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EFDD80C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cY3vr_PJmMtD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B03D80C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460416;
 b=F6Dso2h+wP8pCc6KA5utQDJZvgY7VGzpBDZERV7BIY8vjHVSwPjltoEOzq6uhoxtlwz6
 J7kC4W+DB26aeSAArZ/aom30ruhvM+94xym1OjJjIcMm3BDkFevLJECCOsq13t3/17gt8
 i5DtxABeUkiX2qWnPS6Aj+p3lCgqDazuZ1avHhQmvrc4vTacjhL8hxrSxrAXb0fKGnp5E
 JyXjidLHU+k1DjQJPzXtuuaJCKnOisRrc1jwDRUsn0DuFLeY7SskOWc58n4jxEgbZgD6Q
 Hb5fDansz4ssCMHn5gm6cJUb36lZhFnPRsvrTwmOwuA/XZxnOakgXjigH7w6TQvN6MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=aUeRHnlHuLyd8Os/OfUYHyanuI/6gSGpcAdXKzgjG1A=;
 b=giUpN0Md5wxmvu4T4awmUDpREaYuG1MF61axZv651uhzmCRHAkz63CQiFouBTpjDG5i0
 C8l7vOxEnDhH4yHkPCymXkLIHXTkS8g4UdxrnnuxqUBF7XzU0vIPfVtl8LrD/JdfUrMpI
 O95RzHDy2YImcqp//FU9w5X3pMLkiqGMG+Seb5Le/udXqPLqU+GgqvcUVZHhDliwIs96J
 IIAkmy8A6OJTDrlmOzvw6jYZePo3D5FnG+YhGSeFTQ6cGXnO3id4OVLaUvZVBEVMAZq4S
 WfFDFhLX9dfSof0fJZ0IxrPLi83u7cbJ9ANT9SPw1f8HWvlpgJ0HwGFNLbQl7UzmUEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=DQ2hGc9g; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com;
 envelope-from=3vv-oagukd70pruerjrrjoh.frplqwho-zluhg-odqolvwv.rvxrvo.ruj@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=DQ2hGc9g
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B03D80C3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:15 +0000 (UTC)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2dc7337e2a7so52778335ad.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460415; x=1790065215; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aUeRHnlHuLyd8Os/OfUYHyanuI/6gSGpcAdXKzgjG1A=;
 b=DQ2hGc9gF9HsapsEYgHRxXCv0+jcAilGC6oCLstEwpT+nPNwUPYIkeVYEvLrlDV25z
 L2bfRPhcrSZ+rHohZjfDUIDnWzgZIdyl+oOgKlAM0A7JQ/WDRViNe31RXXTNUCN3OLbY
 W6wZJMwPaFJVM+UZCUOqnFp81RpnXU9gaBTRhSGxoKDj3XC7JsWs852lPmTY/0sCN9IX
 tk2V5uo5zhINWsA7Z5Oc6QY2mmOHPfwjzOG9lmyrfK+84cezZkcF2APffg+iI0ULCafO
 k6TmIXjUQCO7N7isTWknA9a8XmwAZuIeAKggiJhVkGb2wYT5TDScqN5xKG9fJibFymub
 cBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460415; x=1790065215;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUeRHnlHuLyd8Os/OfUYHyanuI/6gSGpcAdXKzgjG1A=;
 b=ckSjJrdIL6b5hbMjoiTAotkKum9aiX/ZE1bFzC50zCs6YM09jnJ2soPsH5up4YjvZ0
 LgiDXrzZqx9bee+i9FWM7HqMRuPQBMMK8LxZgQ0CLUj6bpSZN2p6petXAHTRZJ7WInIy
 FVU3+6E6Cx/51sQaRkGH8pwYn01vcxaAEMBN32GrVB5eOYeAamWUI4aVe9G7uZZfVJ+A
 FJrs80qjStBwCwuxb7MRIkLHDtt3jZjc6io65lKzkckyr5Hs5maIbf8ivrLt5I5Vuolt
 PxP8B+dA1WhBr7fSWzebR7ysES8coDVqn0goLBT+dfUisnv+vtUZqL92Q/nywWwiySHG
 +HAw==
X-Forwarded-Encrypted: i=1;
 AKwUvByqDoCPkclWX2jW/GPgQ+trmM27Vl4yMp7rndmSLVer7s5mTQLbk92thItPVc21Qys7mJ091/1Vaeb3YHZ7Fks=@lists.osuosl.org
X-Gm-Message-State: AFuF++kCixpNWc/LcKtZD8T0ofj1eUk0cFFxaR5Ehrb0NwgnKLiLXGK/
 CNnHUEj+gE/XU1YaAQzmihzGEGl2TXpqzTQfZpZ+p2K9blG8uav+vbmSDo24vdTq4uUWf06mQP6
 g
X-Received: from plbmz16.prod.google.com ([2002:a17:903:3510:b0:2dd:2adc:aa80])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:a8b:b0:2d9:26b3:547
 with SMTP id d9443c01a7336-2dd83882243mr420135ad.20.1789460414438; Tue, 15
 Sep 2026 01:20:14 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:40 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-24-morbo@google.com>
Subject: [PATCH 23/28] Input: synaptics_usb - use seq_buf and snprintf() for
 name and phys
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

synusb_probe() constructs the device name and physical path using a mix of
strscpy(), strlcat(), and snprintf().

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf to incrementally build synusb->name, and format synusb->phys with
snprintf() after generating the USB path.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Gemini:1.5-Pro-002 [editor_update_file, make_kernel_build_sing=
le_file, test_runner_run_kunit_test]
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
 drivers/input/mouse/synaptics_usb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/syna=
ptics_usb.c
index 880a0c79148c..d13d2d6202ee 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -41,6 +41,7 @@
 #include <linux/usb.h>
 #include <linux/input.h>
 #include <linux/usb/input.h>
+#include <linux/seq_buf.h>
=20
 #define USB_VENDOR_ID_SYNAPTICS	0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001	/* Synaptics USB TouchPad */
@@ -278,6 +279,8 @@ static int synusb_probe(struct usb_interface *intf,
 	struct input_dev *input_dev;
 	unsigned int intf_num =3D intf->cur_altsetting->desc.bInterfaceNumber;
 	unsigned int altsetting =3D min(intf->num_altsetting, 1U);
+	struct seq_buf s;
+	char path[64];
 	int error;
=20
 	error =3D usb_set_interface(udev, intf_num, altsetting);
@@ -334,27 +337,29 @@ static int synusb_probe(struct usb_interface *intf,
 			 ep->bInterval);
 	synusb->urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
=20
+	seq_buf_init(&s, synusb->name, sizeof(synusb->name));
+
 	if (udev->manufacturer)
-		strscpy(synusb->name, udev->manufacturer,
-			sizeof(synusb->name));
+		seq_buf_puts(&s, udev->manufacturer);
=20
 	if (udev->product) {
 		if (udev->manufacturer)
-			strlcat(synusb->name, " ", sizeof(synusb->name));
-		strlcat(synusb->name, udev->product, sizeof(synusb->name));
+			seq_buf_puts(&s, " ");
+		seq_buf_puts(&s, udev->product);
 	}
=20
-	if (!strlen(synusb->name))
-		snprintf(synusb->name, sizeof(synusb->name),
-			 "USB Synaptics Device %04x:%04x",
-			 le16_to_cpu(udev->descriptor.idVendor),
-			 le16_to_cpu(udev->descriptor.idProduct));
+	if (!seq_buf_used(&s))
+		seq_buf_printf(&s, "USB Synaptics Device %04x:%04x",
+			       le16_to_cpu(udev->descriptor.idVendor),
+			       le16_to_cpu(udev->descriptor.idProduct));
=20
 	if (synusb->flags & SYNUSB_STICK)
-		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
+		seq_buf_puts(&s, " (Stick)");
=20
-	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
-	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
+	seq_buf_str(&s);
+
+	usb_make_path(udev, path, sizeof(path));
+	snprintf(synusb->phys, sizeof(synusb->phys), "%s/input0", path);
=20
 	input_dev->name =3D synusb->name;
 	input_dev->phys =3D synusb->phys;
--=20
2.55.0.1032.g73a4cd73de-goog

