Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7BCA5FD9
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1510840A8D;
	Fri,  2 Oct 2026 08:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4hQ33RDIDff; Fri,  2 Oct 2026 08:32:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE93E40B26
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790929951;
	b=OKkyKIT21EHh3LuSsia2lXFAL+V9XGBgPpoRD4j4LjgVlnWmGj3vqZxC33HJKiCDkom7
	 RbVX1Fj8AXXzKhvoqSUFUjkVkaprg0NZAaVINUk0kWSfPJXpHuiBPG+7MRwrpAcWSxpLA
	 /BTK7J6NRLxEZixYeol5yiKk1QnmYocWIDvBSEPNgQ/Whs2PTJ/mTak8fBde3ALbl+Aoi
	 fmQYch8IU7ALX+KXh4HShWPw24IsgdDbwZHYeiV2RfPnx2vEH2AMGReI9CYVh8TWO8ASy
	 fwcFVosctOQ8BjHcflxwCr+JbJ6dbLR8fvrc4ecLdMCDYW5JX7QJZjAvxLk5U8ZaMlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790929951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
	b=iBqmqUGiCz9XRfszOETLmX3Cn2MbK7iwkS0Z1EYbHapPjMP4i4ptQnzH8XiFVM28YiZo
	 YNK+ywAtHtKROTFt6C0fsdQgjqBla/lDIZcMwq+mzCzp2PNKXEVfJ81a3oty03FnPLltM
	 LwTxhT8RqQfZUhWh5gK1r65+yu1m7kqdDMKL9TeIK0J+N4r9wniBnk0ZB1efYCnr14YKw
	 5eDvNTieBk8M5Iz6w+g2zd/AxKMIml++pymEonM1+cybH8GAQ80tV36hBtZkzARgdWPKJ
	 TsH5LDHYZdtVxiY445wypAdd9se18L4oVOA9BlBhvI8fhxRwJjvXzi2G1+VQ3YKs61w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790929951;
	bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IvfhU2cQGoIQ5WNqxsX0u655oYg8euHVGVsSAdY9pnfkrMSVjg5zjkxbpcwrumq/3
	 6MfZp9NEVpFOh6beZHPSKpyaQBSvSwUAF+gD78qaoLCsgJn0qhCvY/wfhJd9g6CCue
	 Z/JtkHgq26o7ikLJbdgWsH3DRdlhK2rLFqFwy8RLflbmwyUQN9aeN4+kaOASKHfPzb
	 /vbDMcZJLYVtcKufLhwOZkHh8JZHUjhREF7Zrx7ZA/AfR2vFOB/Dn/ZECajVnpS6jN
	 dgYJm4Q0OA1gDEfwWqFb4KfPu6S84Le6rr0mfZRLT0mivpriRgKBrrqht+xjM+sWxN
	 JOYk2vXuZuPaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE93E40B26;
	Fri,  2 Oct 2026 08:32:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7169282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80D9B81130
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S20fDIfTBJ_g for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 08:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 758C681115
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790929948;
 b=qh1I7jgvUwE2T4w8H5pLPGfCZ7jnLPfOJu6UEkMYWR9IO1hisrpZedo3auZzTqXYqkv/
 FlEWmM680nYthO0/J7l0UkZ93FwdxNoW9fxAzSV4iCbrYkh8uaqTQ2VeS4v6zOkVTO6Ep
 /onz1bzcxb7s9V3RVLoadwL2cTxROdreTEpe3AVEP0LaXAfleSxxlbh6y3R64biuvmsOy
 iWnXviPobnmR8O1acbLmKMIy4cAmh3t5YsKkMo1KmQjPe1b0RkqJ9yJW27BFgxvrKQYXH
 8K3+NJaYOYDeIHtiNhzB6QN2bzXriNzzJiW+CEOhaw/WYtfsH0l6fB6laIu9VHIOqAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790929948;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
 b=ekdTYGTfkLdmgZU0/0k/oxqcRVrVVoYGVB1aQFUWKjzry9721A3DqHG1KSiCoDQb6THy
 jFqK6TtdX3IRrOKKIRLSSVt50u8568ATM4L2tRz1qzj1cJnfW1lHQhLiMrAoQUufRmx1Z
 ryJwAtdZ4yFb22iJKfpAkmjZDg5CUDfJuk32494pggX9j7nC2K4ch5BBDkSf/C7Fb7lo1
 XL91dCfW83Usaw+URd5EYzjBpsi2cPgsNSoWIvLJiT7MODALspMrgrfNvHslGg5iz+vpG
 A9zeMCro11gbugVmIKm9nKoF49VeQViTca/F2X/K8wlweHvM649T4fttcyZA7iKzILw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=suse.com; 
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b="V4y0Qg/3"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=google header.b=V4y0Qg/3
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 758C681115
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:27 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so55587155e9.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 02 Oct 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790929946; x=1791534746; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
 b=V4y0Qg/3KjvFiptVIoLisUzc0fi3AbDO7MQjeJJPMQuKKEj+DV723ErD//FliRn21j
 vH425cZoeBPFx2Z1m7Kns9UH06k+hKTePoOgVVGGpFbttUcAWOyUEiZYkHAw9KTikYzi
 u5m+BmP9JnTqrmpmKt+FNsYmmqYIb80MWAfvbGBo/xHUBRr54jdFOXFQCwocl+sqB8/F
 46GAjfbrRXaOCEYXgUjYiUcutUrNg2/m8sIwEhCzpqJZRherj18gclj3zh0yxIQd4Bj8
 TZKz2aLvDiVdLXfT8ZNlxbP/rdBh9B3kkOeBvHTks+H6S7PYEQFf3QbnC5vq607bqNPT
 cSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929946; x=1791534746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
 b=eRTbLBwxyCnPRJ22ODjIRbcvU6vIfZeGDOnn+Ji+RV4W4mZhXwgPnEI5hwxLfzavcY
 an1Ln6bcH4rVWKK9MoU47YboNfh29dcyZzytYuslzYAov1kw/51nCkvlAOaYNpzar6VE
 6lhJFW6241D34HpaQeduwsJphLXKHqTAVSPOFPkpJRlnUFVi/VD5ZbK2zciryF5w22tS
 F8CqFyncG3ZsL+s7M7bc+2LFKVtSBKU710uy5OplZt/MCMVbVAmcy1jmG3OOhD31ndLv
 zHPuYhbtns15irhKqBSvdHLDI/eWyyBseYBrBDOphxuTLfvYDmPolLScshFfAb/w8hHB
 eR/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzRBRtAyDy0wIsg6a1M4ZqpKv2dnqveS0ozEUEzo9md44i1XCFvKXHhddpLJEzeM0zGbWnFIbww5fqqg/fMPY=@lists.osuosl.org
X-Gm-Message-State: AFuF++kWJSIkMDdCN6q7zqmHvVBlziCPmqV7MdSqnk+o6q4Dr0+ref3a
 ZveczhOJHvBxxhXvTGFccZpt8PYSDW7tRO7UTeCyC6tcBOSgbiM97fwo1qGUz435Poo=
X-Gm-Gg: AYBFou3FwsBHTxxacn/eM/tIU+iYMp7Jl+wnN4fqEdb8KSRZOj50LFkSLspSrG0d44r
 3RfX+ZWntk0lbLapBqt7wTPCoVwbw+ipxG45wRWeK7ft51XRoah6Hhdu9Fgx+YpQdtR+gvN8yxg
 Qta6N8BQm8hKqwc/NKEYoC2Og7TQlp0T9Jbkljo2GDFWBugH0c0tkyU8f6HkdgpeY5G5L71w2bi
 bDMVjhAKsdR4jkXFJ1EhSrqlHObfTPTgDDZsmM8E8QKwir8+Bqhzh3yjNHhsuwzb8zRDTG6MS1b
 JlIeoJty2MHt0YitzATAtMt57nt9nqXs/QKjneXm3jo133qk12ANSH7Z05hfxeYJeZlO+k2kcRG
 iNDovvFuvxAQogpGVmKsqKcQWuc9/b/HkdbPaYMGQ4facvk1s7XgpqYgigIBtwq028h9+dJUuiH
 FP7TFXk5q/WDVa+J5ZjExyLkmNclaqo09lZGlh8QnXij42fDY7rhpAysZSoV7WtCiouBA=
X-Received: by 2002:a05:600c:4307:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a0274569f9mr25694905e9.0.1790929945843; 
 Fri, 02 Oct 2026 01:32:25 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:32:25 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>,
 Andi Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] module: Remove obsolete __MODULE_STRING()
Date: Fri,  2 Oct 2026 10:31:03 +0200
Message-ID: <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f6f90cd88f15..37de77340032 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -896,10 +896,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
