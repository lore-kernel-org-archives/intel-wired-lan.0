Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1750C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91872606CE;
	Tue, 15 Sep 2026 17:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O4ts-_mT13JN; Tue, 15 Sep 2026 17:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7807C606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492660;
	b=iwBlEcAAkIcXmjFkOgWnuCqSGwk/x/+Oj8CFZGJOnxMU4lXVZBVCV7t8oxo3uWFHzu+W
	 Znj9I4S3KIuQyBVqkXKomu1ISmwv4m0Y0aG6EmDITF9wHBUKgBqZcPiNbkQG8qIhTNmNj
	 a9nCrnyMR2dDQwWnszeu9X3M0bNwPGlyl2X6axQhHVWHNytOFjCBsatwsbZCSJQ7sKZA9
	 bkqgyB/a1/J3CCCEgAuB1QDF2a7/7gxBrKJFpxwP5g09BUP7P6TqVBUNPwpMn3ijAWOp3
	 wXzDhWn/9FpWyg6MonfjjJrw9Vg71DfdHgmGGd55iNwz2LGdfXWOI0+SIRx3ePFmwpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i189Z1372pvpafDRMVnLFn5IBf8O4Z3ONLFW1RCweBo=;
	b=d9QdTmxqmUi87+AAgcQUUxPKpwxeW67FOz9D1Uc91hOeCzqjzSZxE/5HViW0NycG9Uk9
	 QDIyPxPEdX7QYpg6kreIWETZm9PU5JTzsCAwgqR1bLck4J10ciAYW3z+mmJjb8Qfx0VNH
	 6952nCYkDq3jNMYr0cHCo4cYFgU6gb1vGzNVuiPFuZ9Nc1hcjGCPBSAcMXPCyL6yaBj5e
	 vAJtZnMVftRyiYha+rWoCW7Ck4oOl1D7Ih+oiZY5tS7khuCNZDHY50EHMQGFDIlMiC6Tt
	 145Z2ncypB8X4HpdcBQNfhLCoZWZdDNG4stpsprArh1Uc/GZhOQw7/vvAnuG5dbuwrw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492660;
	bh=i189Z1372pvpafDRMVnLFn5IBf8O4Z3ONLFW1RCweBo=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2x1Krkotwey4etiI2dyg1lBlD6/aqfd/HRPsR0Z087rUmcIn6KafboT/P7KBdZlVj
	 9kFfAuxmoRCsKamKg2D4Phi5skDHUfjkv28Ol6F2SqCQJZ7XGtg8Oe4EvuKgMGTLyA
	 v6YNps/pdS+frCFO00ZavRmYIRnIgRjFdo7iu+73hUhgYI5sRqjMAfKrkO7N8fwUrW
	 gkeT4GdCMgKeXJXhLK2WIHaMrCFyJjTD019X5K+uDfw3K0A3L2fKwWZqNZa1tbJSmP
	 pRRE4zjy0PEFEmdoWj3j2Acn9lJULGLOe6Gy5hPnGP8dIdcm38Lyuu2VQgWIx3YjkH
	 Mh/ZenLF59vfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7807C606F7;
	Tue, 15 Sep 2026 17:17:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A379A2E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9464A80C4D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wleNVwOsNp8d for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 726F180C3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460392;
 b=enctUYxlVhsYZotRnyIiKFFUkvY59dJPNEa9LsucVLjexccIBcru94qAmwOYFsy+3m4n
 pO/54F9q2JojctfBqSRKlqnL4/VdnD5TWOMY0KZAIIP93WRMQ7MN3B4jqJW3neVOa39Y3
 a/FPVy+Z9RlhRyQh2/YUJKrnQr1BBD4K8e6veburuD1Aj9/T+aA87g+7zhSZwOg+v+xGT
 HgQE/WmFp3OY9o9Y2d/Zwo135Zmesmb0+R85CPgDrNGVjMLOdQmtCQVf/0yGAcmpmS60D
 pExeqIQwqoGYnHWrFzgcPia/KpJlqHst/GSGPFFbd7+9MfkD5YgyIb+spXMWzL9rHKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460392;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=i189Z1372pvpafDRMVnLFn5IBf8O4Z3ONLFW1RCweBo=;
 b=CWUXWWXtWq0QIewWqexshYSzH6144cC3YXiMNR+JM6vq/nCKeAwxCzsR2s9acqpMNwps
 2mdi0BLKqXcjEoVvSOIEReFNNFRTFFOmxCzQPhbp71mz0LGqYJPlOCqMub0qGWH3hRGmn
 OZALK34uJURGPV/+kr96Q4Ifi2/LcuZAuSARHWdBXnln14oZlcFS2OGHkAqHdNodJ6jA2
 /LNSBibiAl8LKZAnZt4TZm9d939uL8Y1Jts76Xiy4nxTIFoM+lXgPsJIpsvsorXaIp0Ja
 RQOZLNA4XWvsRlzmyBvH7nE5meQt9FgdhUAm7eZjxHQkXATH5Y4Nj3/jW/Zc97zewdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=BzCtv9eU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3pv-oagukd6urtwgtlttlqj.htrnsyjq-bnwji-qfsqnxyx.txztxq.twl@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=BzCtv9eU
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 726F180C3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:51 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2dcfed75f77so62046035ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460391; x=1790065191; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i189Z1372pvpafDRMVnLFn5IBf8O4Z3ONLFW1RCweBo=;
 b=BzCtv9eUV+9IRewJDTIke0hPnXBWRgLASNA1W1HQS0++Aj+AHiT5CQsRlxJdYLUwnt
 CaERZzowTFVRfuhgjgdsUfclwPCpboF5PvRsHqYx9QHG44eyOjoQyi4CIETz///4SXkz
 ybT5yOEhd7m2TooBx/NZklFIQbYZ3YgSAJXcxp2lr6+btZaV3+wtrYyfXy4ojVQOYMiS
 HsXSWcf+QitVCfMytlGPDoxFfq3xVcNt3HHJomJWYZ+8Mrc0twH+2TN7PvXjybm+drjy
 DjqjeoAbHPxxFIgPPDASfLpl4YqGXobZ7CNbWzcyR2rksloAokyoAjwSrlxsgqIqtdm+
 b35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460391; x=1790065191;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i189Z1372pvpafDRMVnLFn5IBf8O4Z3ONLFW1RCweBo=;
 b=qmLDvCW+YUWN2dLSwjb8yFE1uBFYT68wGV+sWgROxzsWAKem9qimYY839vVAogLmVQ
 2LP1C+OlYq7ClUBJyXacTGxjtuQTMwxg4u0Ag9qMjIrm0FoCkDtq+Wcv8mozdVXgvvME
 tgSFJaatztV82xEKW89Hu8X9Lk9ctJ48YoQNH0ckzb3M7chG2jfhBpcUy6o8FrUUeeQ/
 eWcAvR6JEFU6LxiAvTosRDkmwwY6WUYldlScXWWDsLc1hUqVV8AEcizanaSHQ8kJxJF2
 vDZD5q3NRHOyC0wCbTPAEHT6lvqM5EBZnS43FvQFRe6en/AYPiGKo6jhs2j+V6hmj+sU
 HFhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVXamlFx1PxwDX02JKVhrFmSx3M6Wguy0Tqzh6AtSZ1v9ne4L7oE9kPo6D4j6s1cunpSL+CLpPdGmWpT0qCag=@lists.osuosl.org
X-Gm-Message-State: AFuF++kP/vjK2LK1VhlSP5sGdDwS3mvbWcvUdSzRoJRCtD+FpuazJexC
 HD/0sBrcLRLMzLjztYhl870oTYKSWId6YUSU7vny++dHZ+Iz2ClTBE7zA0WRrbJkcoP9yTpKwxT
 9
X-Received: from plrd12.prod.google.com ([2002:a17:902:aa8c:b0:2db:8b6a:31a7])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:388d:b0:2dd:143:d5
 with SMTP id d9443c01a7336-2dd6c75a396mr155065525ad.22.1789460390543; Tue, 15
 Sep 2026 01:19:50 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:19 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-3-morbo@google.com>
Subject: [PATCH 02/28] sunrpc: Refactor rpc_sockaddr2uaddr() to use snprintf()
 instead of strlcat()
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

rpc_sockaddr2uaddr() formats the IP address into "addrbuf", formats the
port into a temporary "portbuf" buffer with snprintf(), and then appends
"portbuf" to "addrbuf" using strlcat().

In preparation for removing the deprecated strlcat() API[1], capture the
length returned by rpc_ntop4() and rpc_ntop6_noscopeid() and format the
port directly onto the end of "addrbuf" with snprintf(). This eliminates
the strlcat() call and the temporary "portbuf" buffer.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:3.5-sonnet [editor_update_file, shell_command_run]
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
 net/sunrpc/addr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 97ff11973c49..a1e4173e5a53 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -264,18 +264,20 @@ EXPORT_SYMBOL_GPL(rpc_pton);
  */
 char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
 {
-	char portbuf[RPCBIND_MAXUADDRPLEN];
 	char addrbuf[RPCBIND_MAXUADDRLEN];
 	unsigned short port;
+	size_t len;
=20
 	switch (sap->sa_family) {
 	case AF_INET:
-		if (rpc_ntop4(sap, addrbuf, sizeof(addrbuf)) =3D=3D 0)
+		len =3D rpc_ntop4(sap, addrbuf, sizeof(addrbuf));
+		if (len =3D=3D 0 || len >=3D sizeof(addrbuf))
 			return NULL;
 		port =3D ntohs(((struct sockaddr_in *)sap)->sin_port);
 		break;
 	case AF_INET6:
-		if (rpc_ntop6_noscopeid(sap, addrbuf, sizeof(addrbuf)) =3D=3D 0)
+		len =3D rpc_ntop6_noscopeid(sap, addrbuf, sizeof(addrbuf));
+		if (len =3D=3D 0 || len >=3D sizeof(addrbuf))
 			return NULL;
 		port =3D ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
 		break;
@@ -283,11 +285,8 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, g=
fp_t gfp_flags)
 		return NULL;
 	}
=20
-	if (snprintf(portbuf, sizeof(portbuf),
-		     ".%u.%u", port >> 8, port & 0xff) >=3D (int)sizeof(portbuf))
-		return NULL;
-
-	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >=3D sizeof(addrbuf))
+	if (snprintf(addrbuf + len, sizeof(addrbuf) - len,
+		     ".%u.%u", port >> 8, port & 0xff) >=3D sizeof(addrbuf) - len)
 		return NULL;
=20
 	return kstrdup(addrbuf, gfp_flags);
@@ -352,3 +351,4 @@ size_t rpc_uaddr2sockaddr(struct net *net, const char *=
uaddr,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rpc_uaddr2sockaddr);
+
--=20
2.55.0.1032.g73a4cd73de-goog

