Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DA9C88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C112B80AEC;
	Tue, 15 Sep 2026 17:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgwBk8jqQsPw; Tue, 15 Sep 2026 17:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 92EA880A49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492658;
	b=Kdck3CUJUfvAsfBADDqyuH66dHERrq+46/caldpTFCFfocoIsCLRiUsP5HfW8Xj4H3J9
	 W24toZafm9WtQ6VQFDVW7pGZ5maesrslDX1a3YRyUKWHC6UEQM9pAvKJhUAox+UGbErV5
	 pGrCJAwjm+QMYiEbSUV5PAKEmRNNnZNsCr2upmmBdvYGjuZYUHfL7M21ZDG0kPwIyxFY/
	 8XyHnZYcIQEURl7PF0xy+11Pq6RWdDbNtofTty1GjljY0p4xlZUOm5qooHc+3R7ynYDaK
	 4HRhxjSaIB9vZQ0/YYeqdDLMd08z2CIKtYHLMSwkQwu4PiOnFu/aF3rfkIyOzk1PocQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
	b=hq8BHIO5QwXgmRMTr0WfXh935CY6W+Sdf3KMHShLruNAlQ5iphUgttIpKft2QeAgSd27
	 g7PHn513Pp6xfgoAEuXXH+QhVCvhOARYPbbMOAcKn5pxwEDgORcSQGrb6u/BQZHKbT99m
	 ufJPBwkzaa/hTeBNRBf1yof1+y4S7zvxrR/XMXZJid8LOiPMw6IS3AhCMXllH/ZRSTJ5S
	 xfCXkk9XAEUxQ/He9T7ysmXErHrtkiU1A3qSriPNuk+0LyxGI/Zy72iHuWzENYYAUzhL0
	 qOtc5VteDOKgwEPPFa3xMji5AY32GH2PQ5DMD70mcKWVlx1YTMF4PP+WbpTw4uFAZkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492658;
	bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XZyW1bENWY+CIfJXBTBe7YX94LroWp3KLy8lx403hRr5NZAPXBuLasTtnzEOgRucc
	 dA7AgaEhlf4AYb6rG4VnwAbuRwwwuD1qB7lRDG8Vy+penGB0JtS/PD4eMpOKF37wzg
	 EfbgrNwzmdNCQX4dxgcVIoutpssa+mkufVitLFtxuZDTrsE+MAaMHH8ShRghwLqSTS
	 YdjruoTQvr436oB+8tp2qS0tecVrBN9AHY6KpQv7nhj/d74wEVHKjWAhpZGTnm/eNq
	 mmTDeb5pe0hWAHGlTSlyxqQG+FIWClqY/pvGb0w6YRdZ3F11fh4FFWTgD5fvfZUu0c
	 2QMoFTIyl+WAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92EA880A49;
	Tue, 15 Sep 2026 17:17:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C03FE493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5EE7401A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HV7O5kEw2Kob for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 71CF84005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789460391;
 b=DXjiwWZE1flkBU5zs9bPUrGAskxJ/5wPafx2NGjJk2b/6BsTD2yxqJTjUXmGJwrHpKNO
 pJ4O8D9OCtrApLB86WIzHfoj0EAQBwRHAWldtv9WKBLRRCL05kOOXMs8VjnXOd88Idwji
 8VHGzQorotm4365BUG5nIhY4W+N34wuerOQvqD14E1+hRYpVeolThMzZmogMEKUq7Wo6P
 BWI+DckvbW8SZzIGqKe00mJdG7apHmx2jg9Od00r9v8cI9X+nee7VmN5/9u5E5q66gwxK
 CI0ccp5oX1eOx8DzLiz+7gACEuJNwWZbnM/M2R5IHE84bdxGK7r00V7S1iHwQbqG/2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789460391;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
 b=fubUWub1FK/Z2X+lB6PDYeu5NiA9m43lEf6KCBwPRmCnUOs/F5R3JIFrlHkwl/7nGpv1
 dX4l/80I4psLhMN00n20UR5HIbxSYW9ktfM1nkCjC9mPBUekjzk17fo6R24xTC0TDAiK6
 /urKPxPw/EgM9noAzfJVbtvoN/0ifHY17fPtDbMU8kLnBhxo0FG+vuPMn9wYzUcQgN6fr
 xPipkJ9qWSzABOkjtUoP1mGmBDYvHHnteEomzorbSle1Hvfk/ej6pF9+U2r7NrQLycH87
 ZJRVpMk9TVYIHTC6p3x2dhIe9rmlhKHZrFOLSzt99eViNz57ZYKUJf5TayFxArS1/zA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=plLhWKdS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com;
 envelope-from=3pp-oagukd6mpruerjrrjoh.frplqwho-zluhg-odqolvwv.rvxrvo.ruj@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=plLhWKdS
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com
 [IPv6:2607:f8b0:4864:20::546])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71CF84005A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:19:50 +0000 (UTC)
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso5333280a12.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789460390; x=1790065190; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
 b=plLhWKdSaQBetnggpnhAJJu6MBX4TeKYW2KOjOg/WZwiVEng/HT1nyP2dbqYBRslSz
 4Mf8y1XVMXKuuNHnH1WoKuKHActPyMunCLFLlt0pMLdZGFsUOhiYPIfZhaWy30QJBnen
 9e1c0n6ddiVMIuQhP5i8+l6uk3BHYb3G18UXHzNTGfZx/Tqk3XG/1viGXuTCQ9k70zWo
 4yHXhImYiOFJKJUF8Z3B8X7tBfGsbqA++IxJKweP5oTZrJQcWqorgstvrKbypcNWXnnV
 43Se/tBOCKNICNjshBYeX8Wb1mumFWok4+84M9dWqpiRp0F60N0vZ585/+3XR6G52Y46
 elEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789460390; x=1790065190;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cTJ+iDaVRz+oQczzBBEu9x7Pp5Lm2h3B0iGAZglcmy4=;
 b=w1o+lic8wu4mtpNoQ9ui4dBWJvfr34jxsaZsrCcuG9j5hreQocjtJPKfogQg9F2LH5
 1r7jISu7MaO+DVY9363OBYoLRGOrhsQZz8Fmu8crjul0PMKAk3cAXwO+wpqar9QKeXvM
 MXrcc5dPW2PdIWEkWjnQW0vfoim5vMtiJ0rdU4inO8Z/I5/G2XDKaws3E6tiTPLUBfme
 qqEvtlCQGBvmy8T7puWx5SoRrbHqcrJhx9kZQzOI4gy/k6Cb6BSW3jCS3BlS8YN3/Ipd
 uA2VwxSpC9WO6KVM+wi4erchy6R8JcRfNfMwwATdURuMicV7IWtBhZD0ySgupjF7dSZI
 Ct9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS2CIQrBiKUCqDJC6mFr4cC3INxfEZwYtqoMbrW7ANpRVBIuXRVp8NaHFyomeCf7aE3o7a/wJyclg8UIcIyqI=@lists.osuosl.org
X-Gm-Message-State: AFuF++nzli03cDYltm29Z+nmnEgGgjly64YLmyYF2rCkocRQicbeBN4I
 3vzE+y9hOhUGJiU9lLZrnCtE8O79dcRQgswwqJf2mivpkdjCZU/rl6HjlImdzoLrkVVdJkjpGNN
 q
X-Received: from pgbo14.prod.google.com ([2002:a63:5a0e:0:b0:cc4:337f:e10f])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9f:b0:3b4:61f:1fec
 with SMTP id adf61e73a8af0-3db4038ec7cmr15429477637.2.1789460388838; Tue, 15
 Sep 2026 01:19:48 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:18:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915081910.4142719-1-morbo@google.com>
Subject: [PATCH 00/28] Replace remaining strlcat() call sites with
 snprintf()/seq_buf()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
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

strlcat() is deprecated: like strcat(), it requires re-scanning the
destination string from the beginning on every call, which is O(n^2)
when used to build up a string incrementally, and its truncation
behavior is easy to get wrong. See:

  https://github.com/KSPP/linux/issues/370

This series removes the remaining strlcat() call sites in the tree
(plus the one inside fortify-string.h's strcat() implementation
itself), replacing each with snprintf(), scnprintf(), or the seq_buf()
API, whichever best fits the surrounding code.

One unrelated fix is included. While auditing drivers/edac/thunderx_edac.c
for its strlcat() conversion, "EDAC/thunderx: Fix stale error context in
thunderx_l2c_threaded_isr()" addresses a pre-existing bug, present since
the driver's original 2017 commit: thunderx_l2c_threaded_isr() computes
its ring "tail"/"ctx" once before its drain loop and never recomputes
them per iteration, unlike the analogous OCX handlers in the same file,
so it re-reports the same ring entry for every queued error instead of
draining the ring. It's split out as its own patch, ahead of the
strlcat() conversion for that file, so it can be reviewed and
backported independently of the rest of this series.

Bill Wendling (28):
  ALSA: ac97: Refactor snd_ac97_get_name() to use snprintf()
  sunrpc: Refactor rpc_sockaddr2uaddr() to use snprintf() instead of
    strlcat()
  ARM: atags: Replace strlcat() with snprintf() for cmdline extend
  scsi: bfa: Use snprintf() in bfa_fcs_fabric_nsymb_init()
  ALSA: usb-audio: Refactor usb_audio_make_longname() to use seq_buf
  comedi: comedi_bond: Refactor strlcat() to seq_buf in do_dev_config()
  scsi: bfa: Use snprintf() in bfa_fcs_fabric_psymb_init()
  devlink: Refactor strlcat() to seq_buf in
    __devlink_compat_running_version()
  drm/dp_mst: Refactor build_mst_prop_path() to use seq_buf
  of/fdt: Replace strlcat() with snprintf() in
    early_init_dt_scan_chosen()
  wifi: brcmfmac: Replace strlcat() with snprintf() in
    brcmf_fw_alloc_request()
  fortify: Convert strlcat() to snprintf() in strcat()
  i40e: Replace strlcat() with snprintf() in i40e_nvm_version_str()
  ALSA: usb-audio: Refactor append_ctl_name() to use snprintf()
  orangefs: Use seq_buf for debug help string generation
  pinctrl: samsung: Use snprintf() to construct pin bank names
  MIPS: cmdline: Refactor bootcmdline_append() to use snprintf()
  LoongArch: Refactor bootcmdline_init() to use seq_buf instead of
    strlcat()
  x86/setup: Use snprintf() to concatenate builtin and boot command
    lines
  parisc: Refactor strlcat() to seq_buf in setup_cmdline()
  NFS: nfsroot: Refactor root_nfs_cat() to use snprintf()
  media: si2165: Use snprintf() to format frontend name
  Input: synaptics_usb - use seq_buf and snprintf() for name and phys
  EDAC/thunderx: Fix stale error context in thunderx_l2c_threaded_isr()
  EDAC/thunderx: Replace strlcat() with seq_buf
  wifi: wil6210: Refactor resume_triggers2string() to use seq_buf
  drm/xe/pf: Convert strlcat() to seq_buf in control_read()
  drm/xe/pf: Refactor strlcat() to seq_buf in sched_group_engines_read()

 arch/arm/kernel/atags_parse.c                 |  7 +-
 arch/loongarch/kernel/setup.c                 | 22 +++--
 arch/mips/kernel/setup.c                      | 21 ++++-
 arch/parisc/kernel/setup.c                    | 16 ++--
 arch/x86/kernel/setup.c                       |  8 +-
 drivers/comedi/drivers/comedi_bond.c          | 16 ++--
 drivers/edac/thunderx_edac.c                  | 67 ++++++++++------
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 15 ++--
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c   | 24 +++---
 drivers/input/mouse/synaptics_usb.c           | 29 ++++---
 drivers/media/dvb-frontends/si2165.c          | 17 ++--
 drivers/net/ethernet/intel/i40e/i40e.h        | 15 +++-
 drivers/net/wireless/ath/wil6210/wmi.c        | 38 +++++----
 .../broadcom/brcm80211/brcmfmac/firmware.c    | 21 ++---
 drivers/of/fdt.c                              | 11 ++-
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  3 +-
 drivers/scsi/bfa/bfa_fcs.c                    | 80 +++++--------------
 fs/nfs/nfsroot.c                              | 11 ++-
 fs/orangefs/orangefs-debugfs.c                | 36 ++++-----
 include/linux/fortify-string.h                |  7 +-
 net/devlink/dev.c                             |  8 +-
 net/sunrpc/addr.c                             | 16 ++--
 sound/pci/ac97/ac97_codec.c                   |  9 ++-
 sound/usb/card.c                              | 58 +++++++++-----
 sound/usb/mixer.c                             |  8 +-
 25 files changed, 309 insertions(+), 254 deletions(-)
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

--=20
2.47.3

