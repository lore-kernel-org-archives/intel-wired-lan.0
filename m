Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA8AC982C5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1D40807E2;
	Tue, 15 Sep 2026 17:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fkcfQo-cEsUb; Tue, 15 Sep 2026 17:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD39380B80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492672;
	b=W1mM9FDYzV9X0z3fuihLM5DNpd7DUC04uzgKo4Ay8dYhTxnnULeeIeYYx+X0Mjs/M52+
	 VUkrkDGzimhGVee1J2PFWF2XEkEIY6B6kUS/xUCRLf8TIBBqQZjOG3wqRG1oUBq7nWoQB
	 YkRou1HCBUvvCXbtWZCa9sjph+m7y2YanGciJfzT+rnjGIfEbNxQEh6CK0GYlGIYxGueZ
	 u/E5MSHQvRhZyYkOs/HVXkNqTKqIGsI2/u2iEslmCkSvlFddH2aZKddL/6aGme95dMG0f
	 a6UJEQTyBrN/ZdP/06VHHAylhkUS4kvqLXLBmsQ5f0ELIKTYXMRZReEJZgmRHcdvQ1g==
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
	bh=EgFMWIs3mUJyaWhldMFLFql9frpSc6deV3MqyJ0yzUw=;
	b=C5msFdxj4gH7n+nvezKqMzefz7Vy1we69PmRrlJfV6IeL/42DEmHYS/KVx7pRxN2x5aO
	 ewL7cw56DL7pVkUn9R4UfEGF815QvfRa/8DeJLD/e5YCZijHXmoAJtm42NIvuUK4Z1ukv
	 Rj6mCr/fYWJLxvffg/Jae6Ravz9xaaiYIHfPYjPrZZR1lTuFeYZhdzM+H+BRRXDN0f1NB
	 PWGZqzG6CF0H0ExVP92gNyHAW7xhbRpW5zozAQGnLw+WjxzQ9XJkboD1WQkwdAro2CoOH
	 9DTq9u+tgsva9kKkK08DsPhj6esKgEGqNud64Y1+ceaOvzd7RzVCRjG7dddgDdD907w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492671;
	bh=EgFMWIs3mUJyaWhldMFLFql9frpSc6deV3MqyJ0yzUw=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lv2eIMjFEcvDSS/MjPdaOFeNmu1dWITBaBooY3u1GqWSAbf0n7qqj6n4Q3zqjf/7F
	 LC0PgLbpvnLoMZPtc2kmi9la6Zep2IKBYp02RwJ8JViM6+RY7xtXG2gXDdLQmRpYyt
	 XkRKHeK0ioaxwoePwXvnMji/5ov9g7/KQvIMOUupI1iZPUl6nz6uG3pPVtgH+SDGPg
	 EeP0s/O6N3iiVk1dW1Pwq0Kb+io0dCicNPhUwKKQQcsFQxGQ0B7fLE/Ds/3XEUVcwi
	 4nHOUc8pQfik+S5SW9Z3zMf+buCD1LGFjW5AOxQo713ROUC7pDAWtg/j0EQpUTpDBY
	 Vy2Vz3OjtCLgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD39380B80;
	Tue, 15 Sep 2026 17:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E857493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8D90401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rdmr-w52ueZK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:20:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D84664018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460402;
 b=KkIMBKECg/QxGp2Uqh8iPi+1d97DDIv63u8ByG8AqIGjFsopvVzbM0V/Nq8CgTBoAVlp
 3M11s9c9rMHra+zY7AiXlSx7/uTgA/EjM+1iUNfdImszR811l7tneJAMEDEbAte2Ede8K
 G1Ga6gI29GpAT3AVxqtuJhf9QaEKYIXemufh1Ti9Rejld8GbXu1w20o4Cy19V0OXa4shJ
 2CIVt8jMZTFwtOOmgE0RmHzYBjPu9Y2V6eta4YlMDlqtnwrKbSBq6hQccA0GpcrYOzRoN
 Ssm1dClyVeHtA12aqf85nyurp+wBOd93mLNurRg5MyqmHB5v+4eiifhL+/3V3r8Vwkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460402;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=EgFMWIs3mUJyaWhldMFLFql9frpSc6deV3MqyJ0yzUw=;
 b=TTgHe7FF87nfP2BxGanIdPCqvN5GGKH0jdy6W9kcqKmC70KKJqkWKzbz3TXAAWQB0STt
 sfRzk0ris9WVGdwGZpHUhm5v/S5fqibfDjUo3AO1BZmKcNpjIzuEsotusjHrCBD5OR8nV
 1yq3MyZFh3cYBpxdoWTRD+QnqV/3LmvreRvoZ8/5UreMjepeiFRBe7rRL5iknE9jbJTwU
 PjxJvLb+UhjNFG+M9LlVTDotxCy9mWEo/EZR4R6MGMe0GEveas4cw496Ur64wZy0XkYSx
 +/2VFIxccqQe6DohtZ19NEDFY+3oZzWMDZcki+P9Bbs4kIrhINGcOwsdkspXm+me+vQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=U5gtc1Kb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::648"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::648; helo=mail-pl1-x648.google.com;
 envelope-from=3rv-oagukd60zbeobtbbtyr.pbzvagry-jverq-ynayvfgf.bfhbfy.bet@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=U5gtc1Kb
Received: from mail-pl1-x648.google.com (mail-pl1-x648.google.com
 [IPv6:2607:f8b0:4864:20::648])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D84664018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:20:00 +0000 (UTC)
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2db3d832827so52312805ad.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460400; x=1790065200; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EgFMWIs3mUJyaWhldMFLFql9frpSc6deV3MqyJ0yzUw=;
 b=U5gtc1KbTg3pd1mQFDctF8T/7piHlee+gIiifKFhhmlCCYhwKWn+UqiCQmRblfK4/N
 klMmO3DqAQeXvauToQzdF6evpRfP6gg4TljoQ5C4eCTAVwb3a8qaXB1OKj2ny3ysm67Z
 nNleIqwzImpAQFpOhLC0CInC+uafc1oEQaZtJCZhQvuIa7oIZXCgos2Jv15qTCjKYAwK
 DbuYJR9hgY3mPINepshtce3uaZduzaGtGzdq/Eyth3PoErGOsYyVKvgJvRMr4bFpoQxA
 UA2eWJluH+nQr6kRswzXNX8X2nBfEeTxzt09eWRIO8Hf6ikPJwLERhjzbUhOsEVvq8PQ
 cotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460400; x=1790065200;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EgFMWIs3mUJyaWhldMFLFql9frpSc6deV3MqyJ0yzUw=;
 b=14VEBqhkh/K2vawoq1UIKAU2yFvvT6oC0HDZvwpR6eUu+vofgr+nu7JBO1geyZdlya
 wP+mso6YdWWf77zZuhdaixMgjW3ClDRRjOKh+7KoFjhVnUCLWRv5KEYgikpHIGE0ITub
 JYel8Aeb/CxmewuA/fny8MYpCOvs6IUxkhweaoPcI/qVn5YjjTCRSBuTR5/OseFY4mMl
 e/6XfxvnnD3kcr5fUAhFbmQfFiJ1pAT1sCOnltBq5BhB/Nhb7HI3j2hOlolbRD3Z5l+H
 mjS2p40ASJbSiuXXIcJ6cEygJqcV1mul56gH6Sh8ZV65Sn6byPsTXARVaWsFtvZiRq8a
 1afA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCSRoB8kcHtoZqFoMkR1mZ/PZZDsF3fYzVTWsJ5d6dapy6tWyLze+F6LZIaIMinWNMdUmEn9Wz0VmtBC3w6eY=@lists.osuosl.org
X-Gm-Message-State: AFuF++n1P0HkefSd2zxcZenSFlGERvhQzZQyqchFSKtTPSjfeVrbVodT
 l+XYGHAgOkys/bgtKhIrBf3jlmVH6VvQxAbjGYAOK/dW8t+jS03oEvf2ncPFQZ35jZ+MByY2Ds7
 W
X-Received: from plrf13.prod.google.com ([2002:a17:902:ab8d:b0:2d9:21a2:1910])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32cc:b0:2db:3d84:effc
 with SMTP id d9443c01a7336-2dd6c5d600fmr121011565ad.6.1789460398023; Tue, 15
 Sep 2026 01:19:58 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:28 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-12-morbo@google.com>
Subject: [PATCH 11/28] wifi: brcmfmac: Replace strlcat() with snprintf() in
 brcmf_fw_alloc_request()
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

brcmf_fw_alloc_request() constructs firmware file paths by chaining
strscpy() and multiple strlcat() calls for the module parameter path,
separator, base name, and extension.

In preparation for removing the deprecated strlcat() API[1], format the
complete firmware path in a single snprintf() call.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: SecurityEngineer:GPT-4o [editor_update_file, make_kernel_build=
_single_file, shell_command_run]
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
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 22ff326f1924..2f74a952599e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -845,22 +845,17 @@ brcmf_fw_alloc_request(u32 chip, u32 chiprev,
 	fwreq->n_items =3D n_fwnames;
=20
 	for (j =3D 0; j < n_fwnames; j++) {
-		fwreq->items[j].path =3D fwnames[j].path;
-		fwnames[j].path[0] =3D '\0';
 		/* check if firmware path is provided by module parameter */
 		if (brcmf_mp_global.firmware_path[0] !=3D '\0') {
-			strscpy(fwnames[j].path, mp_path,
-				BRCMF_FW_NAME_LEN);
-
-			if (end !=3D '/') {
-				strlcat(fwnames[j].path, "/",
-					BRCMF_FW_NAME_LEN);
-			}
+			snprintf(fwnames[j].path, BRCMF_FW_NAME_LEN, "%s%s%s%s",
+				 mp_path, (end =3D=3D '/') ? "" : "/",
+				 mapping_table[i].fw_base,
+				 fwnames[j].extension);
+		} else {
+			snprintf(fwnames[j].path, BRCMF_FW_NAME_LEN, "%s%s",
+				 mapping_table[i].fw_base,
+				 fwnames[j].extension);
 		}
-		strlcat(fwnames[j].path, mapping_table[i].fw_base,
-			BRCMF_FW_NAME_LEN);
-		strlcat(fwnames[j].path, fwnames[j].extension,
-			BRCMF_FW_NAME_LEN);
 		fwreq->items[j].path =3D fwnames[j].path;
 	}
=20
--=20
2.55.0.1032.g73a4cd73de-goog

