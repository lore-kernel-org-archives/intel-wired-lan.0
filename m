Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0778FC982C5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D084280C64;
	Tue, 15 Sep 2026 17:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lUNbWObjQGCN; Tue, 15 Sep 2026 17:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B40C680BC0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492677;
	b=rbMomw6gtISiG5K4vCtYVbZfcJf6MI+JVgg7L0llLVbu1g4iVoJquMPZDunZJJbN9pdP
	 Yi12uS1ykyFk67RGK9BjEj7IcQB0Tk/bEUFtDgchwwYVseHBZ0udTbkbGBRLau4m1Q3v8
	 5lRPV1fQ1PdyPoMWvehaUknisld4dxg6P/BvhTUpy0ZI5DlpNDZ8U9RuJjBRnzdw7IzW6
	 a0JtBcq6aOhRtPJ6rZYgZqehRrNGyZowJBBWw93JP7T02jyEt6F+N13DhLSkI3WM+BTMo
	 memRW1UocBQzMycxbCmlmI73IlgDOkHFxOeiNiLlzkw7mns1Thp5+SUKcQrkpQASB3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TmKdBXO38kbe6W228p+vBZ76A7D+nQJddOBfd0uRZ54=;
	b=f1dnAW0AKoiR3K4nvuU5Nz+CjSHu816+V4eTLwL1BSnEga3pn0xEdb9Lb1h0e6uw7OrW
	 4lbUxBr2JwDnE77G0MmNFcUQqw+qu2YPR7R6SqkVfm+ZemE2nE5kyCt8fyLmiB6+8kM2C
	 dP5PUojZYSB9zaYDXKdh48RutoCo0DyNtgClt7QDU1tCDzW9BnegKGnkrxJX50awwXIrz
	 7yOXYXf6HszkXAeDb2IBjqmJqIKC/cAImAllfENuY3py3NwdLfPO0fZRJSoIsICAvDnQE
	 SGSszscJANuzHRscpgW3OmNUrA3ThHxHg7SU9ErhsoftAR+qecgWldve1vZYvF2Nv4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492677;
	bh=TmKdBXO38kbe6W228p+vBZ76A7D+nQJddOBfd0uRZ54=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5R/nGbu57DeOkiCfzUQhiPuQ6ZDSFJdgJA4bNhkVU04+vEwdEmGphUGIzd/jWVvrR
	 p62KfehnnsnIHB+MZ9U2nRo8HQ+B8E0UlPZr7Euddh5YT1320fP+uTyXAmUosf+4n+
	 zf90PP2cFmwTR8qHRQP9sGd7kwKVpCwmHDxHmZ+ACACIRwuWdU+emiY8xSV3VzD9E+
	 MlgN8XVaktzmqialZ4tbI0LQ647Av4goRGb/0XSBAqFr9K7X+OTe1XwDbsbMm6Djmb
	 7zmKUYOGdXyWnxG3XtEXFZhz/JDhL7h9EuMD4o+SgCgUnJ3/qLq/YVqPI0XJpx5agz
	 i/hq5LCJ22nEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B40C680BC0;
	Tue, 15 Sep 2026 17:17:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9666DDCF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CA9F60721
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q03561xybe_S for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 665D2605E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460412;
 b=D/3gVmF64LiVfoDN2Gwgtitec2LaCNZxvZ700tGr3yBz4zFRYQUL+5tJplKPKJABJqrC
 RCWC8HbePbeMFdisDnRgYk+i8FPEULyeUgcu02quxVuEikEM89mTT7a5XPZffKpqYNAWG
 x7XzYmZvkNRTyfU54G+rpODCbG7WjZiLtfywEy64KyxH+6iaeWLCj0QX7QypjM8jTfSi2
 hulcNe3+54i5U543e1NHZdl91h7QaSG27EzKCbuDrqvVJz1BWE7vYFTeNCcKR9kAf47dj
 t69o97cJD8hV4R6J01594l+IUcbq1uKRr57rCri7TUWIHu+4r6gcLxp+O47ZOWPHVfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=TmKdBXO38kbe6W228p+vBZ76A7D+nQJddOBfd0uRZ54=;
 b=KmSk5pywhmbPnveqPikWISR+kHZYvI17CvRJFlM9UBMldu8rHLIFSnIbwMQxg0PSb7wj
 t5l9p7zicuBImZm94lejItW9eYrVv8U2E4rrjIdjFT1aEamrJao5wvUMtrYZv3ppPmiph
 Xq9KuAvlDq7qB/Vn1fRMsBeBJrztDEzcz90zYWmBXWtnsmT+w7tiunlELIWHutszBht1j
 dn365QxlOmiyEs7fATAUSEeEDcfuGDYDZdoEjO8D8QMMnTIKm41E3nTauxS5z0QrMFiRB
 E6Bw1BwuX6fMHMTRJKKIyAtKOFWh1VPPUaEQ2pVmVtnleTTMQSotQXhYnK7eLVsGKnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=H89nA3EO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com;
 envelope-from=3uv-oagukd7klnqanfnnfkd.bnlhmsdk-vhqdc-kzmkhrsr.nrtnrk.nqf@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=H89nA3EO
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 665D2605E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:11 +0000 (UTC)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2dd667770efso7536145ad.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460411; x=1790065211; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TmKdBXO38kbe6W228p+vBZ76A7D+nQJddOBfd0uRZ54=;
 b=H89nA3EOeAYpaNJ7f13WdwhvtM0sBOZr1IKVDCsioACxZvoE/Hk7mZO1ZsyINKclxQ
 jQapIYpaVpo3CdaZbCPQnclSuqEq1Hq1UlURrRkuMLd+LZPcc//rABJGirvU/LcoctOk
 0DM07DIIVRyhKXZ7V8bSYIwhmJgbyLjMrtHwaxaRqEnakF5bbQhPZwOQfgLkwOMUN1No
 Mh5WuvIoDBKizWyrcbh2Pvu0fGPajuNZ+luwDgb1Ko7ii+SA38H1PpGLHmwSXl5n2kGU
 3iRREVRdySAPsbrHuCrGFgTiIqXDvPO1J9h7FD/AwEfIqS60eV2YDxHfRxOKsqw+uZZ2
 LEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460411; x=1790065211;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmKdBXO38kbe6W228p+vBZ76A7D+nQJddOBfd0uRZ54=;
 b=NeWfGryeQzliZ02H7bQsXNgXuX6aSvPKIXUSM298/JbzEdrooIRNpvAMpwVyJK72fN
 OxDSiUm1wMfyteqqYDTfYM+AymZujOTnWUMUIN+WpPKeh7vNLsaYqQr4Z6Hz7D5Jdxcn
 2k+YvrP9toUHu1Iv1SSLQOrNlYgm7/5H0KsfTkkSEWpCfi2yeUUj1Vnmzy5jcO5Hzc3I
 VMPtNyA07CWotzEgLRb5eDzbUgw1cQ6RypjuxPxZJpDH/zDe4y6EFZOug/Nh7av1CDV5
 o2djVM7HmCzcflSjIs93bvXZA9ek1eiVVSQTWnXIRCkJQDw+E/oEew74YJUq3o3R/6Up
 2Ccw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmHCwafX7a97QWA2PDIBPy39rCOw3BU3NKtGBXxFN/HrEsDRgS0QLNptHQC+ojdS3GbFwY4m3gT7S/CjApRCc=@lists.osuosl.org
X-Gm-Message-State: AFuF++k1xOSc5eI7AYqQ/C4loVm9whxNJWio/ZfDxKg26WLudWKG4x0K
 d8fwONpI9eZSLQh0Ks/vJb7WpgIRLx0/vvHGoGXDJUu9J5y8pl5WNiZbsSNAxEqmNv1nYGjkMGN
 f
X-Received: from plw16.prod.google.com ([2002:a17:903:45d0:b0:2dd:203e:7d7f])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e544:b0:2d8:d4cf:fe49
 with SMTP id d9443c01a7336-2dd7654538dmr37587935ad.15.1789460410166; Tue, 15
 Sep 2026 01:20:10 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:35 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-19-morbo@google.com>
Subject: [PATCH 18/28] LoongArch: Refactor bootcmdline_init() to use seq_buf
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

bootcmdline_init() uses multiple strlcat() calls to append
init_command_line or CONFIG_CMDLINE to boot_command_line.

In preparation for removing the deprecated strlcat() API[1], initialize a
struct seq_buf with the existing contents of boot_command_line and use
seq_buf_puts() to append the command line fragments.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoPilot:1.0 [shell_command_run, editor_update_file, make_kerne=
l_build_single_file]
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
 arch/loongarch/kernel/setup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 6fa4a22a58fd..826396f141b9 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <linux/of_address.h>
 #include <linux/suspend.h>
 #include <linux/swiotlb.h>
+#include <linux/seq_buf.h>
=20
 #include <asm/addrspace.h>
 #include <asm/alternative.h>
@@ -305,6 +306,8 @@ static void __init fdt_setup(void)
=20
 static void __init bootcmdline_init(char **cmdline_p)
 {
+	struct seq_buf s;
+
 	/*
 	 * If CONFIG_CMDLINE_FORCE is enabled then initializing the command line
 	 * is trivial - we simply use the built-in command line unconditionally &
@@ -315,6 +318,11 @@ static void __init bootcmdline_init(char **cmdline_p)
 		goto out;
 	}
=20
+	/* Initialize seq_buf pointing to boot_command_line */
+	s.buffer =3D boot_command_line;
+	s.size =3D COMMAND_LINE_SIZE;
+	s.len =3D strlen(boot_command_line);
+
 #ifdef CONFIG_OF_FLATTREE
 	/*
 	 * If CONFIG_CMDLINE_BOOTLOADER is enabled and we are in FDT-based system=
,
@@ -323,11 +331,11 @@ static void __init bootcmdline_init(char **cmdline_p)
 	 * to boot_command_line.
 	 */
 	if (initial_boot_params) {
-		if (boot_command_line[0])
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		if (s.len)
+			seq_buf_puts(&s, " ");
=20
-		if (!strstr(boot_command_line, init_command_line))
-			strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
+		if (!strstr(s.buffer, init_command_line))
+			seq_buf_puts(&s, init_command_line);
=20
 		goto out;
 	}
@@ -338,14 +346,14 @@ static void __init bootcmdline_init(char **cmdline_p)
 	 * CONFIG_CMDLINE_EXTEND is enabled.
 	 */
 	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && CONFIG_CMDLINE[0]) {
-		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-		strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		seq_buf_puts(&s, " ");
+		seq_buf_puts(&s, CONFIG_CMDLINE);
 	}
=20
 	/*
 	 * Use built-in command line if the bootloader command line is empty.
 	 */
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0])
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !s.len)
 		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
=20
 out:
--=20
2.55.0.1032.g73a4cd73de-goog

