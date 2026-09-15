Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EFFC982C5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 490F580D1F;
	Tue, 15 Sep 2026 17:18:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsN_R6Sn0Nr4; Tue, 15 Sep 2026 17:18:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 257DA80CF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492686;
	b=fvALcCE+suNSRFpwPxvCl4uIwn/dLObH3bnK0g7b7kdWCmR2EP11Xa1wkecR0lRA14OJ
	 g0SDXuQKceN8wWGz10nTD8CeOeYDbBKTG8VJnlML1fzbOoqI6JyxVVJfCbgi6EIcQZZ4f
	 UzMohr+i/piaUNKAum4IYAJlIpHQSLIJKFB5JpicnvlDkfG6IpbK7u44VJGC/oJ2hQ0uZ
	 7UAY0zMbg2xyZgqgIVlllNVCZvobOF37slXNCllNQe/4lWI4UVXnQ99zvAFeolyUU/M8w
	 yS54AlLVoGP+8p7WhlyI1VAZVLuIDZzpDGFaUgtCfUZ1srmZRvvfjyjGoF724bUtFqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3R1bHblX/YSNAoDVuSots2jijK47BJf7ndWg1gXSC20=;
	b=BlaZvTYq+wzGmVAv/JcI0b9h8vUNQjupEGZ/B0DWKGDTAIcurTVgywUhl3ioCUGnc+Be
	 DfDgZJ1F8er8OLqOUylcWC/N/kq6CKaoDXNMkmeZZ+vlKKDdXPCN06QWyddVHi0/ahQme
	 NVNWYcPWAMoj5/DbjAQ91KwLx1bWcmVIoBW7tBa3GJfB1DtLmr9nNlzM3heUrdjaW3DGT
	 x1NbGFBqSOYVVJxnBcseQaz7wIIbWTRZ/uX4bBj85kHvD6QUoE0i7QZY5EDdPHkOIk1P1
	 dyiucB7FPbgg9L3qYQHFaqHsScjKtm5yCERqTLE0HVabClknKKZhbYO3kXQabYBVznA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492686;
	bh=3R1bHblX/YSNAoDVuSots2jijK47BJf7ndWg1gXSC20=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fsEC7jLFLZJzrRyf7KoUyZ5hbVjslzcvEsPUv1tEVDbNbVGJpCI5wfv7NWv1Mr5gv
	 tl1rGtG8R0co5Ov4rsTg7vkGvZU3PLgrJuT9sN2BQZeOy6X7n8A14RKnZPMnZkVrh0
	 wKgPbH54CZ0DllH9rIzSQINVgpYMf0SGAqDFrNT299WXYvLVE+DULQW8ZcCikaJtu1
	 h6pqsU80Ju+X7EoXWUpD4t57xj+95S6fPeR7MuHnOUE+cKuAR9ogUFW7OzWZrPVpb2
	 Z+MJp0CP5yJogfJW7RZQ/q50MUejnmVVlMgYj21nva9av3s7UoShpF7UFH+7CnPhvz
	 I/jtaB659Vjmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 257DA80CF0;
	Tue, 15 Sep 2026 17:18:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AD4A2E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0C83403E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDjpepdhMMHY for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 099D9403A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460420;
 b=BiCoQeYCreWfXXYMzHmAwedZM10RLLIOd5W6KFUYw04yez2rFSRddK5hwoT2XoMBHH5A
 +Ztsk6YbBNCXLDwzPjBJcwALzJJWXrLNKdGAnG+2H1hE/T82q/kO6K1OHbM69n+poi+Xo
 AzF64yljNAHyFqokWxYBx46YXB5Ea2HvtIKguCmGeA7ns7lzNBcb2DwUs3vzP10TXPg8m
 qyZHC+E87Q5+eja3+fTsBVsr2vHmDQ9ZKmAXdk1RGYmpsVXssJjP3fyu5cD7Gj71KfaKW
 NtW7hviKpVo/FzQh+iNXyex1pqQks0SEqchJT6JdfSAQ6T+8lUgcfYO+tq9TaR4PPzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460420;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=3R1bHblX/YSNAoDVuSots2jijK47BJf7ndWg1gXSC20=;
 b=sporxxD9pH2m7ksdXxIihoUIs318uS9Gc7cPk7WE4bOBB/vZFl9ay2Ufmm2Wems5AXFN
 5G0lD2lc5plyinoNw49ZQ9GfQHePJTJhAxvHgmzDb6z6f50d1sxHi8MAvaQn/iTm6YsUZ
 /sUyCjEO+TjcLgyuBFWHjeib4ZXRGTO3akrIj4MgyxqCHkxNNa+cfVb+N44K/9fugyUUi
 R+Ie01Yt6t2lYAIv6ODkTxn0O4lswrM72I4AIzX21Da0xJxRPWb89ybQDoRXC/sCSCZzA
 8Zgs1pB2ky87EYuy8j376EIYtqsXPcsdlxtSVodW4EiJLOoZyavINdW6M3pD2/Gs2jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=B9FGrC45; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com;
 envelope-from=3wv-oagukd8etvyivnvvnsl.jvtpu0ls-3pylk-shuspz0z.vz1vzs.vyn@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=B9FGrC45
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 099D9403A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:19 +0000 (UTC)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc132709c76so5389686a12.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460419; x=1790065219; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3R1bHblX/YSNAoDVuSots2jijK47BJf7ndWg1gXSC20=;
 b=B9FGrC45UA2YavOB8YST705943Ylrw85qPLRhzypHgd+nlm6YErdQU148pY1PbvvyF
 jeh0qpQdUImo2NAveXLfJRchKhtCEAxfkye/3fl0GGtUdUsjaUqeKMmnrku/3NK2znQY
 clmzVnoqDY3dGCQvMGWSXmrKGNdY9FmM/BHyI8YWbzEPNiYfB5uPUrHrPbkNd3iYDibH
 YgrMLB7PPzStQLw9ewaeJA6I/Ct5l2lzC3eg/QjRfj7XfoB2Y4PjPf/FDWoGkQ+4xU+i
 GgqXCabcO8fpfob5mkeCDhL61ubtkyo06g8jW13Ce32x6StPE70+Eo7pTBw8miDkqrYf
 CM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460419; x=1790065219;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3R1bHblX/YSNAoDVuSots2jijK47BJf7ndWg1gXSC20=;
 b=yTEK/HYqunWo/wusExaX4y7FXTRQyDVbL3Zl1e5zUBOA2LxC/ALGOg8Kb1nG7Mws8D
 FMOUxnLjClvzy9sTICZ85Bfh0sOIyJfaXyhjzosYwdkbWHuG1pDvRwXkR58p9cUbqtGI
 4+O1XJzelBP547uCjltyRYp8nRACPVMLankYQTpZ/8KKUzLilPGP64ouaSzUHcmssZdX
 d+GSe3WO+tUX3mEW1sIARR3zJ2NTNxbh4zc+tJ+CZzCSfhEAD/BAwDD/QM9h9Lx0fzaA
 mmLoumSPeFFCLWjnQxeJ6kNjTglOYKgsZzAA5WyiUl3xYXVNf4NirUQrbnFpoiDnDhjq
 u9Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpx78AHhz0io1NB3R+41HwHP+GfDCamSluwdI/fBhg0Tz5JJNtf+LINy/HuRE6GStikyHlDJcPjCvNluNYH34=@lists.osuosl.org
X-Gm-Message-State: AFuF++nYz+lY9+fAIXUljEpLoSYwDP+qSTKYCRGLtABIFtbS7X7w02FK
 78efSWU/wlNdBwa3yK1EmZGy0tErkw88VOP2ushqYrVVt9c6wIpf3ziEIedhMmTdkHJQo/XwoKc
 N
X-Received: from pghu21.prod.google.com ([2002:a63:ef15:0:b0:cc4:da05:ef4c])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3315:b0:3d3:aec2:4dcd
 with SMTP id adf61e73a8af0-3db40623e61mr13262094637.25.1789460418341; Tue, 15
 Sep 2026 01:20:18 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:44 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-28-morbo@google.com>
Subject: [PATCH 27/28] drm/xe/pf: Convert strlcat() to seq_buf in
 control_read()
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

control_read() builds a list of supported SR-IOV VF control commands in a
stack buffer by calling strlcat() twice per command in a loop.

In preparation for removing the deprecated strlcat() API[1], use struct
seq_buf and seq_buf_printf() to format each command line and pass
seq_buf_used() directly to simple_read_from_buffer().

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: CoT-Agent:Gemini-2.0-Flash [editor_update_file, shell_command_=
run]
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
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c b/drivers/gpu/drm/=
xe/xe_gt_sriov_pf_debugfs.c
index 0f242db775e1..5db7fc067c4d 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/debugfs.h>
+#include <linux/seq_buf.h>
=20
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
@@ -663,15 +664,15 @@ static ssize_t control_write(struct file *file, const=
 char __user *buf, size_t c
 static ssize_t control_read(struct file *file, char __user *buf, size_t co=
unt, loff_t *ppos)
 {
 	char help[128];
+	struct seq_buf s;
 	size_t n;
=20
-	help[0] =3D '\0';
+	seq_buf_init(&s, help, sizeof(help));
 	for (n =3D 0; n < ARRAY_SIZE(control_cmds); n++) {
-		strlcat(help, control_cmds[n].cmd, sizeof(help));
-		strlcat(help, "\n", sizeof(help));
+		seq_buf_printf(&s, "%s\n", control_cmds[n].cmd);
 	}
=20
-	return simple_read_from_buffer(buf, count, ppos, help, strlen(help));
+	return simple_read_from_buffer(buf, count, ppos, help, seq_buf_used(&s));
 }
=20
 static const struct file_operations control_ops =3D {
--=20
2.55.0.1032.g73a4cd73de-goog

