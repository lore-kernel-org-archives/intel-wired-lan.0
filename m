Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2606EC88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A889880ADA;
	Tue, 15 Sep 2026 17:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qGFJEWY6s9qM; Tue, 15 Sep 2026 17:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8816980AE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492659;
	b=KTiqtoiqTwPwFYZovYYkXiA/kYKW+IPxGt6kqbuv1eHOBbkhDfn2wj02uGJ6dPT+M9U/
	 aU+DjllKXccpQHFxB9KNLq9yvVjVKJBkgQ9JHVAfO9sUNm1xAeEtR5FruZV/hddxHAIp7
	 C5kE9Se13/qimgqv/9jhR+06uVKtSoc/PHV7MSmgMQHwbsbTDlMRfSacOjt3BCxTjJD1c
	 voYg9Vx/ISACO2IBcrKFYP5Uf02b7hjiaG3WRQtuoyJS802y1YLeIDBKNo0JY/fTmpu8R
	 oqytP+DWsI1QpNWs91Mqn3rQ3DxruAWhPldnf4BggJfiJgYcwgGX9eOG2a0ypBq5vNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=12RWpnF69Y0ZtQBdjS9tdwBwekyotqtFAvTiEZFvq+s=;
	b=TbkzRuHnb56/dfqVroq5kVt4G9kR99sPO7S8UToGaz35opNVFRatF28nOhlxgZzBgY8m
	 c9gDDY0vBNog/NuGR1uKYuLE6PsA9/F2dq5W1jXfdRkAjHIOPgmkEwJGP1+88hPDQ4FmH
	 tNUjQkavO/KJLvJBtSzTPWm6bMHp/6DUgvMo3oUR0Yhl/VP4fIX6MDIugYiwjBKo30ubo
	 AmPyRKZIYDkzaNQnnv38tFGN0IeNNuNw5DRZm/f/LhHoNhblYcf5ZvySDFTXxvWlakMnM
	 kyJKq5Y+WWo2Ra9PBoZEwDB667inpDwPyJrV+dG6CEXJ1dz4+CG0+ekUtmDFAqJUfTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492659;
	bh=12RWpnF69Y0ZtQBdjS9tdwBwekyotqtFAvTiEZFvq+s=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QwVz+YcAkmjoacX73l2hNd9ri59zEawKgmcnUL/qgLBQuCfiy6QiorEODPKP0dRbK
	 Nmms7/HFvP0oz1qAe47x/JN3GOMAjT57TIXdXJyBafQb/lnaz8+gxWdJow0jIYipUh
	 IaY1Gn3AaKk6FGs+L59wyk/Fav+7onw9rEy1Z6cCXXHC1IIzz5r5CzwXJERPaiiLc1
	 Cjo2KA/jiNxUP2LWQOUW2FT/Um7yr3R4AfMZkL7MRvKRcPeya58wl271LNwjCl8OGX
	 VjYGeNZZHyom/0gFegOuf4nUtK48kMuDt/HkM0VHJYA3LSOB28VOJ/jPzCWUm3xcoF
	 69GHWvwuZUasg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8816980AE3;
	Tue, 15 Sep 2026 17:17:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F25E8493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D863C4005A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdnM_fn89cRw for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CA7BA4018D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460392;
 b=IHa/Cdj0b6k1bThvHAGvLAwszIWEtFyq1vJt58n0kuToEPcL6kTnvn9EJp7bjgmiFdcw
 iqL7+FB6JMOFZJ1uRl6LhEwf8qt7CqYsUeC4hyqMs0qcJapY25aMi+VPIh+iJuEGDS//y
 kp5cEdNzQ/rQFEzdmqlMXA7PNrY7Svmnn5XCWDetQ1BwgzvCRyO+yhK2/VxdAYN2H92jq
 l2CUiWHo3N/EjaQIFz2PZZ4s38jVoU4mujDr6g3H7CI0ODxzuJD2nDwFI4LdJBy10Fj7t
 53Z7EeBqo6AGKaShvBJDYDZXz8XdMtyNQX5BxWxo+o4RzFZiScKAbxCfOjCp9BNr6fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460392;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=12RWpnF69Y0ZtQBdjS9tdwBwekyotqtFAvTiEZFvq+s=;
 b=entvuT8ZeSG4NVgO10om7RDH6GEhSencVm2aiFKmyM3iqOfw1jvYdZhPC7j0nI2RtQ7K
 hUhF/Oq9IraP1xC/MkQfRje5um6RBVRlc+OIzkn/jvW+AmX/jH32/qz+x5dDJmLadqx8k
 ninMfKF9auYhcGkrrZDg5aRLRkakBISc59bYVHVp0mEjaSc0L95zUVg2rJulK3SZT1axs
 dsPyN3OZEYnM3zP/bCD/ouU1I2yvq8NcEt+iaGMFvqQQUeNK/wuDxRh03b9F+Hwa5TyvQ
 Lkd+cRbaC5MsK0d6f738wz8mRyknW8MnH84MfKKoOOzHvXlMfp6Zq1kNOhtnlterjxg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b="l3FF6Cb/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com;
 envelope-from=3pf-oagukd6qqsvfsksskpi.gsqmrxip-amvih-perpmwxw.swyswp.svk@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=l3FF6Cb/
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA7BA4018D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:51 +0000 (UTC)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so4056727a12.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460391; x=1790065191; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=12RWpnF69Y0ZtQBdjS9tdwBwekyotqtFAvTiEZFvq+s=;
 b=l3FF6Cb/C1TvWYRZwZbHzqCOHaTqlugCer3cGGywCMOxnEHNx/0gCe3l1ZHRlXaNUs
 pNUV1ks5/GJvcvLWnjxMiGurWO2lRrlxI3T6/FiXEAMl54aC3B+eNRVLQtsf9mU0YLaF
 SkY0ewvjK9nTz2pia3RtxApvhf3RHWhkE+KEiZOxIzmuO7ObBOecJY5dZW8fr9YhYI7p
 WV1fthYo9/btz0olY3gjARNTO0F80i3BUyMe7MMH3XB4wp7QDNAUdtngwu6YI9kSkqkV
 j9T05Z7L//egZyMIT3XFxX3fP7BqNvnzibrNTOmykLsQs4DftrY+5n4yJ+SXRiaCz1Ml
 /Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460391; x=1790065191;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=12RWpnF69Y0ZtQBdjS9tdwBwekyotqtFAvTiEZFvq+s=;
 b=TV3zEgozP2wxU/XAqQL/NNmPARywkrcRSil/lAUqZvKw+IpT7qfAWKal4Kl77Kjosz
 lDwmAgkgrmmX55VXVG39xOBdprZref3KWamRbGVIeVYBSy5d+atXzdQEUnc4appIbR+u
 s45LxJtZuxJk9z8fPhNSc4ws4cm5NGkaQyjKe2iJJAbN2LB9Ka1Igcx6hFcqDiXcF0hV
 uFgXUFAVoeGtkGpsaTx/N5i+nhISWbmng1COB43uI4qZSoWRK8oL/nnik93Vpl5ers+k
 /cwCU+24xGs4+5F+ELt2U/Nc5zbBFxUDYSqd1+0HzCwVrmmo8SysqEZ8afMPAQTDJyXK
 kThg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiAmcgnT+Y21arhtGroJgvervj94OVQTZ/9ekcBPv4aS9WcMzIoU8kwCqnO6w1958Ck9qnXdwF4tb1Plpm3sI=@lists.osuosl.org
X-Gm-Message-State: AFuF++m6ZUnBRydj4mL/VasRZ+W0wZp+qlEmAj+FiddRIjCLB9rjGmlb
 GzP28XSOMWEe89AIcBgvErkte0qkiB9XiUa1Fkez2HDFxJkHgAG7BEXG9XfCu4oA8qDTvwSG2Yh
 Z
X-Received: from pgdo4-n2.prod.google.com
 ([2002:a05:6a02:6204:20b0:cc4:31fa:cb70])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2587:b0:3d1:c99f:efbf
 with SMTP id adf61e73a8af0-3db405a991dmr13264267637.14.1789460389672; Tue, 15
 Sep 2026 01:19:49 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:18 +0000
In-Reply-To: <20260915081910.4142719-1-morbo@google.com>
Mime-Version: 1.0
References: <20260915081910.4142719-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-2-morbo@google.com>
Subject: [PATCH 01/28] ALSA: ac97: Refactor snd_ac97_get_name() to use
 snprintf()
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

snd_ac97_get_name() appends the codec name using two strlcat() calls and
then appends the revision using an unbounded sprintf() at
"name + strlen(name)", which could overflow the destination buffer.

In preparation for removing the deprecated strlcat() API[1], replace the
strlcat() and sprintf() calls with a single snprintf() using the existing
string length, matching the pattern already used in the "else" branch.

Link: https://github.com/KSPP/linux/issues/370 [1]
Cc: codemender-patching+linux@google.com
Assisted-by: Claude-3-5-Sonnet:20241022 [editor_update_file, shell_command_=
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
 sound/pci/ac97/ac97_codec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 0bb65be021d9..e145099ee02a 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1850,10 +1850,12 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsig=
ned int id, char *name,
=20
 	pid =3D look_for_codec_id(snd_ac97_codec_ids, id);
 	if (pid) {
-		strlcat(name, " ", maxlen);
-		strlcat(name, pid->name, maxlen);
+		int l =3D strlen(name);
+
 		if (pid->mask !=3D 0xffffffff)
-			sprintf(name + strlen(name), " rev %u", id & ~pid->mask);
+			snprintf(name + l, maxlen - l, " %s rev %u", pid->name, id & ~pid->mask=
);
+		else
+			snprintf(name + l, maxlen - l, " %s", pid->name);
 		if (ac97 && pid->patch) {
 			if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
 			    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
@@ -1861,6 +1863,7 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigne=
d int id, char *name,
 		}
 	} else {
 		int l =3D strlen(name);
+
 		snprintf(name + l, maxlen - l, " id %x", id & 0xff);
 	}
 }
--=20
2.55.0.1032.g73a4cd73de-goog

