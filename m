Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2157C88E7D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B665D606F7;
	Tue, 15 Sep 2026 17:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KECQ-IdeY-Wj; Tue, 15 Sep 2026 17:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9451E6071C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492679;
	b=WSeAq7p9nCrOnXGEdC1QxU/oOILEcsP0n7T1BdSGLeUK948KMSscR2jkKvWJf+U1SFNk
	 P03+1SfN7Lo5UJcsutPOttfa3W3fpcAQa3E2DdYSnyXC7ENeymOBzfjPvyHNsUj0xxdj8
	 UeSJ4RfJGJPFZjWGFRLe7bhltEi3isJCsQU1NIDj4cHArDhmucw/jR8p7HhY3dx9RGRLv
	 39gsuDI5KCXDkmzAKdwLu2gHd8w1UXsM+fR1QHtL++1Bed/NbK8M3ayZDZRYYNkgFJs8t
	 XlFgVnZrL7jtUMlUzjgI8aygplm0VgCBRlnRL/CP3xpNyHWBTFCvYNToJ8/0A0zZRMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XkXp/XZtfYpYjiXJEDXdoQGA1NlHq2kVyqBGidLpG58=;
	b=L81DGMCuBghjgvgr2W2RdZvAigVe6sBNL8gz1alv1oeVOATAVwiA39siig+pcLfP2RH9
	 dzVpM7Lk6B5LBrLGAbxTn0Wck64a4Bkyy/4rBu+FCT6X3w9Lo+hwgRthfdazoqSpbln5l
	 +4K0ycdL63bbO+RNd/xCCopCGxcwVcHVUMmA+07R0Pj76WG8CIw5EW2W9dREIz8EAwBeS
	 QbR626i5PNrYKMYGR4EoB+DRT28Zgwm/GXYtRUVKPTXFWaVPNiqVLOpZthLSElbZwuVkR
	 NOMWIV8GAUSRmlaCdjLTwphYrwnfUcYnWnB6IrRYvY7U4fxQGwVfSxd9YxzqcYs2K+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZlV2pIuE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492679;
	bh=XkXp/XZtfYpYjiXJEDXdoQGA1NlHq2kVyqBGidLpG58=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLWavhTvn3Oy7e48922FwJx4JVdvx08AAlCqCwVJ2xBiekdUt7nIc6SeYTcBcNJr4
	 tr5TZKFaFEWQaKdHgwZIEadnF/gf10luDHGH4xfyQ4yC+UmRXg4cJzHmahcXRYgYAL
	 leVjo/oAOnEthIwzEZr1Sm5QKufW/oetrTOxm7UXPER52Ww1AjdyGhK4yqIcCeuhHT
	 sfn1FBXaoKflz7huSLNQxjoNtcYqGIl3Dt7t5tEWIhgWA1oIW1G3jRCfc/AfOAdhWI
	 0oBEUBbuxXNMPmrWLkbqvM2LH/va2DFEqz/UdvqbkIsTnX9AwsZ2oApF/IZbubE7Sk
	 9v7DUhAx+31WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9451E6071C;
	Tue, 15 Sep 2026 17:17:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FE96493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D74560721
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDs--jhOVezR for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 419AC60708
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460413;
 b=lztx5+8ewLJhSS7P7lGt+XmZfkRRmZkU32/wwiKZ8NWF3QqtVDDYAdGq5GTviRVOQWM8
 FNkJAQZdkSTp/Uf62ddpHooBlyl38fmisLBTB6iKhGfl7oGo0KfxSrfuB2qstGcqWkL0K
 Rx2Qljzh+ChKyVKBieYpjpA1fryalEqMKFElLbI4JtUxcTH9YjzqxkjmXmTtljfPgJujh
 R4HaBE8Q88qp59JnUFACeAH6G/EArSWCXjzIt31IUw47GGlzR03oWUzBmYS++zBjLc7Fo
 s2Y0sEawMqDV7P8d4/xXzhjcfZDJgcB8ffeLip0mzrUvz3p9py4wrRShqAkXx/RWEJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460413;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=XkXp/XZtfYpYjiXJEDXdoQGA1NlHq2kVyqBGidLpG58=;
 b=aW7fx73ebx3WmcpXlvDk9DzRTR+EnLraMV2Zt33NRNDRr+kInLwfZuQjKAmXyxeuwWr2
 vfjDV83dpimTnct6jT81UN3xKWVSmj445SVzTvI8NBljQ9PXKjtaZlzjJRhDEcdf6ltSi
 eEu7C/BkuNxEtZKy+idyeLPYXT6hkx9o3rRn/IdlKi5zo23HlwXuDh7EBKoxxzQBMDxW4
 Gy59tqtgT0GDUD+IllI373uVvIjOPGVoGLMOMGh6SoZqOO98QI6usORnTgqJuMiAw70yM
 ARm44Mof6Zp6WstGP1y5cKFZiL08PEO7Czh0TgFKlq3rqn28cKAqgna4kA0PwNE1L5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=ZlV2pIuE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3u_-oagukd7ortwgtlttlqj.htrnsyjq-1nwji-qfsqnxyx.txztxq.twl@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZlV2pIuE
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 419AC60708
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so82546335ad.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460412; x=1790065212; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XkXp/XZtfYpYjiXJEDXdoQGA1NlHq2kVyqBGidLpG58=;
 b=ZlV2pIuEigkFMg4N1QpCBPbDK5FpeChgiHwONuncZHXMWPCDsbhvKSWjAnGjdIqsQO
 7iYykCe79/q/Ry2T7bx4JPYda47wVONsZFF2wY+5TyvX7Mc3f253LDaLS027b/DnI1sg
 pm+7irK9Dt7BMIwwIxxiltrDIdEA0fMDvJDbgVcxq0wH9NfVjVJZhDV7VfXxd9x3CbzB
 QlSU6kdPV5ctNHvlm+3wRiexp6sX0CKW35Ms50NQSI2MyPHJqEg2Z/voMY6wnZ0luqJ9
 YkFDR/dULZ9mC+ZJprzdI8bLCo5JZoETdOWNrU0W25FHC88pRe6sd0pTF880f+BmGmyx
 U7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460412; x=1790065212;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XkXp/XZtfYpYjiXJEDXdoQGA1NlHq2kVyqBGidLpG58=;
 b=U0RmoheeQgF8FccNgZK/4jMLH5UyMVY9YY7rcvajze/g5O5tDXU5H2Sw/x2qmv9PRA
 9NMm+pTmPT5H2HgpFWlAQjVwp5ykxH49mxTCtRv8ugV82ma5CCvmXKXTqxWqHLTatJoO
 3+/+bAZsHw75sqJPWTs9kkInbQ8aJN8Zbpd0ElLRyKAlOf5O9dEiNjXgKEgdW9r53V0t
 2s5fiLAIglVJ1kVskMhUEWceqeaSQY2DNQ5UOLBot78cY1LS2tP5177rRxs4nThpa9Fa
 dM6jFwRi5ZvMOKtQyjZXJq97BaBUF3pz9org5W5ipfhvH1z2qZ5YnWcUCFdTNNW4cccA
 RaGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrSJ7V8b3CiZMcZkwkok8Qxrk0PEYFgz3E9Sgir/XDZEWfboQHZwqsOhhpAlvL4bsYm36K3GMtra+eQ4ajUbM=@lists.osuosl.org
X-Gm-Message-State: AFuF++m+JeEUuXoihr8WgW7mMou02iGFHO+2We3eRzqIUVXHUeW57131
 hC4dT+uN/ZFoBKk0knjU1LsX2yzCL2cN4tbVpOlY1toC8z/kYgge82z4+N9oLFZsLNYiez+wWO8
 v
X-Received: from plbkc7.prod.google.com ([2002:a17:903:33c7:b0:2dd:630:cea4])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1965:b0:2d3:716e:e2ae
 with SMTP id d9443c01a7336-2dd6c5ef019mr154580855ad.6.1789460411846; Tue, 15
 Sep 2026 01:20:11 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:37 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-21-morbo@google.com>
Subject: [PATCH 20/28] parisc: Refactor strlcat() to seq_buf in setup_cmdline()
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

setup_cmdline() uses multiple strlcat() calls to conditionally append
default console and earlycon parameters to boot_command_line.

In preparation for removing the deprecated strlcat() API[1], initialize a
struct seq_buf with the existing boot_command_line contents and use
seq_buf_printf() to append the console parameters.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:Gemini-1.5-Pro [editor_update_file, shell_command_run]
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
 arch/parisc/kernel/setup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index d3e17a7a8901..fa3efc82ad87 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
+#include <linux/seq_buf.h>
 #define PCI_DEBUG
 #include <linux/pci.h>
 #undef PCI_DEBUG
@@ -42,6 +43,7 @@ static char __initdata command_line[COMMAND_LINE_SIZE];
 static void __init setup_cmdline(char **cmdline_p)
 {
 	extern unsigned int boot_args[];
+	struct seq_buf s;
 	char *p;
=20
 	*cmdline_p =3D command_line;
@@ -54,19 +56,21 @@ static void __init setup_cmdline(char **cmdline_p)
 	strscpy(boot_command_line, (char *)__va(boot_args[1]),
 		COMMAND_LINE_SIZE);
=20
+	s.buffer =3D boot_command_line;
+	s.size =3D COMMAND_LINE_SIZE;
+	s.len =3D strlen(boot_command_line);
+
 	/* autodetect console type (if not done by palo yet) */
 	p =3D boot_command_line;
 	if (!str_has_prefix(p, "console=3D") && !strstr(p, " console=3D")) {
-		strlcat(p, " console=3D", COMMAND_LINE_SIZE);
-		if (PAGE0->mem_cons.cl_class =3D=3D CL_DUPLEX)
-			strlcat(p, "ttyS0", COMMAND_LINE_SIZE);
-		else
-			strlcat(p, "tty0", COMMAND_LINE_SIZE);
+		seq_buf_printf(&s, " console=3D%s",
+			       PAGE0->mem_cons.cl_class =3D=3D CL_DUPLEX ?
+			       "ttyS0" : "tty0");
 	}
=20
 	/* default to use early console */
 	if (!strstr(p, "earlycon"))
-		strlcat(p, " earlycon=3Dpdc", COMMAND_LINE_SIZE);
+		seq_buf_printf(&s, " earlycon=3Dpdc");
=20
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* did palo pass us a ramdisk? */
--=20
2.55.0.1032.g73a4cd73de-goog

