Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CDCC88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2ECC80BE7;
	Tue, 15 Sep 2026 17:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0yiptZFH9er; Tue, 15 Sep 2026 17:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CE47580790
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492672;
	b=hVrWRThOMl3fNv/aZ4lM/PptrkXY23R0saCLmZPqMf4yhYKqbiSUiGrWjzMDBGYf4IQH
	 C/u73ffoh8P1g97G1s+an9m35GcLdSeVwBAFSByo0G5GjUDAyoZWp6I+EKxnI+VRgrjD9
	 0uJaOlTZ/kaE4RZ3W6otkFq7v5mt4hakk15T47CWSZ5mB6ioKNuG50hWIrcwaSx+4mH+1
	 jzlmMLGSbJs1PU6hWeNx+0z3MsEqLBiJvAQBGNRx0FxAAZ6Fvw3JQgdsNQvSNeYESPHIx
	 AunfhCMU2GRVkD9mNbfLBrffs57v16m75zu51EsWzTROhAqcO89ahKmD3ueU/yI97/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YdNQWB21luiE9Gdv0Q1IFwuCzs7Lvdhhb2Hfuit5b6U=;
	b=PBzIdvNRrLrEr/+uEqE/4qT9d81bBIWyZ/cUfRdCp+GOv6lDBcfSLaQ5yPQH5uFHFVYe
	 UWBoPEP1P6raqNz1EDUjsPoRNoSJq65HYh+/voe7zrXpskE9pWpO2MRlf4OjdAMFpkbwW
	 CxcLqz+7Yui45kriMk/Mx34I9cVDZ4Uwt+wrnZ9dPxMEU6feIIs7PyH3Q51IhrVkQeLtL
	 sXbTZVMdVzLTQ8CdHDvLuWHWQcNV7SnrlX0naXNIup5uH7kq7TFEZxANHP9cbqHb8rR0P
	 PktZoL8AAfSQ+wLQ+ImAUOo5rqRWLzW+IPXflOAeCUWQZ3MmuATqk6K2ECAp9tC4hew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492672;
	bh=YdNQWB21luiE9Gdv0Q1IFwuCzs7Lvdhhb2Hfuit5b6U=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xcxd6cpGBf0C71EC00UqPiSETTsEDA1aK1fQ0/THnVTXS2rOWU+Qe2VE0z6nZyxyv
	 mTuBn9OnvPnpTGvENyoVYgjB0/JAXDp7++Lkjhdu+mauvvoroGXsxMUPC6FwQH9Onf
	 7C7DeW9k2UCl55lxpNkqSp83IKV3WsnuuUkPeIu9wV1tMo4YKZUH7H3OTzAmDFU8d/
	 bO8qWbf4Og/5C5/s1rVZO4JLUmudYhHFu8sdvtutxR+QlZEse3JFQeSv6xh7ZRXk1t
	 AK9mwNgtT/CMeBMYy/6fH1IDVmfoaNLCPHPN1Xk7R+6V/tRDvGgXaIrEnopHvFcHXV
	 lgLUd2HkLMpjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE47580790;
	Tue, 15 Sep 2026 17:17:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B722E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FFCD403D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmOa8mir5UYL for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7EAE0403A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460407;
 b=lm1TKrAFM7fJkg2r8Za4+NworViZE3/Q+h4rNm9BgjLL4uFKwnmmiEFvB0qYrRiTefbV
 YE97FLpJrMoyjzIuUw1mWejA2/2RF0NSHcDKqzsO7a3njSrKsg5u/mJsgnmuJTF1ZnBQ6
 xHHqdCGainmMtgz6stLm1s0iIcx1qG2WdlpXcsb8IJ5HjpZz1gjPw0f5eIpYXa5h4PWiG
 wQ49IZlIn0uBeswn+P06m0BkG2vyUTveJQuEFpLddrwgBXxN00A1l3La39wgshiHqTJNG
 OojC6ATGII9hnqmTMWcrdEOp/8wvsHSgiSyv0n5KSLw/yqcjylO85zR7RtUfB7vq+5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=YdNQWB21luiE9Gdv0Q1IFwuCzs7Lvdhhb2Hfuit5b6U=;
 b=LZXhrqHuBXNrVzm00Rk+76068aS3DCdGdIMQHG1Rv0Qvqemxn/GBdvKIaRhU28og6T3s
 nxf3FkWJbDLbDXYGt/AP94ik/5S+VhvEj8duVK5GAR5A75GH1l1xIS2Gejst50gqzLpa4
 dkbSmM6X8sWG+0Ini7rqs24SETzN9LyATIES1S6SHcGo3f6RtaV+JeclWqsbYBoK8h/GI
 Yyw6BwcK45IBCxSw85xi+13BM3NRXZdKsScQBR9Q/JaKS1CK6xg7LAEaUXbqo/ovM4ZQ4
 N+fLoZdNrHHNVrXrs6JktpF5RRkjL7smEMXBOMfOvTBmxyCfj9pbyjHD3RL8M2CTGiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b="W+P4w/G8"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3tf-oagukd7qgilviaiiafy.wigchnyf-qclyx-fuhfcmnm.imoimf.ila@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=W+P4w/G8
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EAE0403A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:06 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso97488735ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460406; x=1790065206; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YdNQWB21luiE9Gdv0Q1IFwuCzs7Lvdhhb2Hfuit5b6U=;
 b=W+P4w/G8Q/Wvb7ezJd8+y69AStdi84sae11NLbn3P8/o70UY6PxlipihbdRagqV7CO
 0wRWTUInP2AcIKWgIpTT+f490VMmbfUcT8+ogxdSxwCC0dNvGvVzddgOLa102JKHbd8E
 H65wN4L57ENLcz5nB6iLEtGYRu2EDFs5QB4oRaaTcqvXTTRARczY7WE+BBbrreDxFUek
 mSiWv2c/bKdYwKFbji0YbhAMY7dh9xfWWXb9+phM4H7hvzkHWTlZnaf4wWFQCS7qIPvZ
 Aq2jLyeXonaS8TZ6X3rEA6DVcoHl1MkFurMLMNQQIcIAEzyfwdqgwTwwaBOZQP0mqJ/6
 CHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460406; x=1790065206;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YdNQWB21luiE9Gdv0Q1IFwuCzs7Lvdhhb2Hfuit5b6U=;
 b=K5VpfeItbj01Tq3WCdCPAx1Aafj/mMs+xrYPSViYazgI0JYE0s98cw8U8yoim5VtwG
 D3agKKa5at+0yt2imvWDEtx/b1xKs4Fy/y7P1GicLh2XzPdEi3BotXjkVJX+1u9q/xj6
 roM2IZmlU/G3m7WjqHZ1S/DV+aIsKO/V5f0DoQ77aQ2SkpB01Jak0iNk0GmSyq1w41/2
 ZP2lm8Zl4vYO7wNoHO1TvHiJcSXMaj0lf3jsXxvoRSLaqLo91aphOcackP+jgti3o0T/
 NgD17qVAnhCEhOdeEddsI+RiSQjSGfon6D+ifqE2uH6WyjLf7YLA1N1bpUS+9+2egwQ0
 NTvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3ZmWTLB5lrqNRB/em+n83rudonrF82AaUcvD8Pp/kdf9rOYcDUaxGETCsTYFpXg87GhoKtA95VGtyPOkYF/o=@lists.osuosl.org
X-Gm-Message-State: AFuF++lb66F6oV694nyLOg2MWMF4XFj1q7QDVWf5TTv0An/z9/kcXFIE
 FLs5ia7UoZWBILF98auA0/ye3jYK217Y5DRwSJk4dQPoH9xI5xm/kFTeG8fOAx3xVEa2xMreUFp
 Y
X-Received: from plld7.prod.google.com ([2002:a17:902:7287:b0:2db:142b:72cc])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:238b:b0:2d8:d4cc:5bb1
 with SMTP id d9443c01a7336-2dd83867c8amr573655ad.17.1789460405925; Tue, 15
 Sep 2026 01:20:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:30 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-14-morbo@google.com>
Subject: [PATCH 13/28] i40e: Replace strlcat() with snprintf() in
 i40e_nvm_version_str()
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

i40e_nvm_version_str() uses strlcat() to optionally append the EETrackID
and combo image version strings to the NVM version buffer.

In preparation for removing the deprecated strlcat() API[1], replace these
strlcat() calls with bounded snprintf() calls at the current end of the
buffer.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:r1-preview [editor_update_file, shell_command_run]
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
 drivers/net/ethernet/intel/i40e/i40e.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/=
intel/i40e/i40e.h
index 1b6a8fbaa648..9f792128a0ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1059,19 +1059,26 @@ static inline char *i40e_nvm_version_str(struct i40=
e_hw *hw, char *buf,
 					 size_t len)
 {
 	char ver[16] =3D " ";
+	size_t offset;
=20
 	/* Get NVM version */
 	i40e_info_nvm_ver(hw, buf, len);
=20
 	/* Append EETrackID if provided */
 	i40e_info_eetrack(hw, &ver[1], sizeof(ver) - 1);
-	if (strlen(ver) > 1)
-		strlcat(buf, ver, len);
+	if (strlen(ver) > 1) {
+		offset =3D strlen(buf);
+		if (offset < len)
+			snprintf(buf + offset, len - offset, "%s", ver);
+	}
=20
 	/* Append combo image version if provided */
 	i40e_info_civd_ver(hw, &ver[1], sizeof(ver) - 1);
-	if (strlen(ver) > 1)
-		strlcat(buf, ver, len);
+	if (strlen(ver) > 1) {
+		offset =3D strlen(buf);
+		if (offset < len)
+			snprintf(buf + offset, len - offset, "%s", ver);
+	}
=20
 	return buf;
 }
--=20
2.55.0.1032.g73a4cd73de-goog

