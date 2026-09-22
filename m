Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73624C982FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 15:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FE444069D;
	Tue, 22 Sep 2026 15:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2jeEYxrQi2S; Tue, 22 Sep 2026 15:22:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2DBDD40642
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090559;
	b=GQep53FxveLaaFt8TJ0/U9/Fz4aRyZRMxKgg/OU3IPpE3HDsnaVR6BuzEIHZVwZwwhbC
	 XsBo/kKv0c9TqOCLpjQj9935EegV7ZL6fC0a9j+l1XJlz74vbOa6IgM2KCwjv0GwIew2E
	 B2Ka1FWZwkbsOck+N9zNXDYlKfD7+oP7RV4KIlRVR2WIVaE2PBPtFRKApHWi317X6BQGr
	 Jf7yktjWqC76s8b27/lxjMrUOkN52p7AcCwtYiYFkh93xzpJDEGrS503GqjahBBbv8Eng
	 liRtvaUJDhoeAk1g/PPlvJ+3o7oUd86WqAGuUJIss2Z5BSmjG0NlUqOKvFnKo7ZbTaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-Change-ID:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
	b=Ufm1+1v+eyuvcDgTtQI0IEkrLZ5pTvPltNGs/BtZirJY+islNUecuXME1bwh1s2J43U/
	 0M5TMvw0bFDAYxJJHe1l0cvaaIS4EXJh+hbwdwnNEq529Z05l/JqePtEtbf5Ekw1EozQO
	 NsiJXb0Oj13AB/hATzLvyPO+8ycP3qWSYdQXN6mhKX8nfd0gtBp3bJ0ITrogGEpH8gpe6
	 thrqQdGqF+2aUcjVSBqTLU/iKdT9hD/x78YA8NPsV9mxtiCb3Kdv6i1YyVEQhRmyjbqHH
	 /O1hbbsySZZEPeGByjnLp5IfT9al1JBvPUE6LUlnyHAcxK+Nsk1DKJF7q7PPnZ2l3hw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790090559;
	bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lo1dXkThQiTPNgDV8cf3MfP6iozdeXirPzKgXnvW4bXCXNTi3V1obwRxnDFfjpIbM
	 /XqvN51yhSTezjfwO+DVyEc7oDcRSzBwxsSBmZoMsidY6MIwtRmyK3hbdFUoUB4AGU
	 hhht/M4spsdY8kzssVeC4I6EwSZm9V4ASRuQDUuE+oi3VG2mJcCDn8gd/fYoq2+WCh
	 o2g/j0dk1WYVoJpl6LBQmMT/l/zsGMBzYNVI7OXSyLRsQ7UR2lz1miJB9CDpqvlJww
	 3w0lPOTii/QyH/dxBPWYUJ8krGGrUBE8i5Qoikfsanj6RnXPPuEkLGHThlVDm7nodJ
	 yJD5dPZDSUPsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DBDD40642;
	Tue, 22 Sep 2026 15:22:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 939F1D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 13:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7963A80DE5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 13:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBqWoV_fXB3T for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 13:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C15480DA2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790084021;
 b=Cy6xKHyQfVSkXZZc8b6kixXJLcSPke5Uon6J4Be2OCPdoACELEb3PWnE9NZX8dOmkLVg
 1uy4GmNroafmYt5rt+8sSnGVTV7xlhL/KC6bTompE7dJsgHn3RlbWfEqWb+5VQgSV2HG8
 KUy7J9sScK3MuXYIadYlwfmMk+EboWEnMdRRa8aUjLAyYtK0GsSZPODXtqZTZJcvUoYVC
 R7YTlBEgOnM2rrrrvb7unXCXIXND14hrB1ZuPEIqSF9X5fjfyCHTWeM/NVixU+GbC+TNn
 PevW6+SxwGku+oG1FVKxs0pYJtViCxYLQOTT5vIpoTN+57r8zHgL8sOY7FclmUysAhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790084021;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 X-Change-ID:Content-Transfer-Encoding;
 bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
 b=AVNQB2bZO29tXM7cmAhI4IAERaDazCi2Efm88NgTnOPlJLYlRsQ2paw9QsHE3laGf7ol
 8+BtvSMPIKnImctane4lguV8nKJ3yuSslNXLTXykpGi4Wk76qdfJFOcaRzhO3/CyHfwmd
 wGX2sYwJajsJ7admQX8mcAfTbxfH1923BD6ljiNOnSaEjrotWLS1nJgi2qkm2WwXvvIqa
 //ZfOmHLaeUaRokzD4HRzPf8ZiLzvkvp6kLSc9UuaGHDCOGnb+s0d3/rK1pBxuRW8M8yp
 dZkIYuwbVR5/CzKEPw+uIvVaGzG8XVWMhrlu45iHy/FrZ7dWOm8LvfhbpQXx11CfaYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=suse.com; 
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=DcNrnyS+; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=google header.b=DcNrnyS+
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C15480DA2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 13:33:40 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so29697245e9.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790084018; x=1790688818; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
 b=DcNrnyS+BYc9RIe67+fJnosvjFh/+GgYrXYy4UylXAXX8RWfdv9UINnGJ0qedcs4wJ
 rUApl8oC0D5mC0XppztE9JFm1VBQdsJScRTbHYXlBACdEO4gfN01+/f4vKTY1TlzN/C8
 5EhlTYbrMUyEQvGwbmoRTjTQJtUlpol/desZrXdCt1wH/mxfseho16zQNJJYBD6zPTyw
 HJkk7zYoYb4Wp7VkzgdvPKonf0+IYAkW4zI4gxj4u8sIFB1cCjBNqOs4lktRjZE4txR6
 s/+ThZZpgR2aeS5iz/msO+SILpaXbA+f2WFTZRxmPdoVbuK5OrB3PAeFXtIBTO7kNBJY
 6yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084018; x=1790688818;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C2Z6J0Xb+XGgk1d/nTkGyflldNnpf7sHk7JSW+3DTk4=;
 b=D+BabP3BvyDuduwA4Q7HJQpt9xSxKaoKvceaOWcljf3l88RDrD2/oVss/WTla1Mxw1
 Ewc9qzSwxmZjryMcS9ZCjLyKqfGz+YjA6B2XOvkIqnBu+CKi4UegHzeM1yO86oepf/KR
 i23pjhnu6QyvF4HZ5aQouDDEJ8ebjeRmSDcM1BwwHpb93M6ehwwHT341+7IpCS3euHsc
 5za5tfI0CYnZYuSvRCLj6Avo25vYX3skkFyCE3njaxaXZkrBExHEYBKV6PMCOF+rG2mF
 2Xewofiazg6a8Pu4kqpY4M0QQxh/Le0keEHxUnGHANuf6UsUjAj2cByR2NhcUOBnbkx1
 MnVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIJFgFxPwVUZetCGgX/RRgX/uIkisD+WQcGgt0uB+YSNLBA6ewqvdyk+FuqLk5Q8CM5fnZIjyOl1H6b7ODbBU=@lists.osuosl.org
X-Gm-Message-State: AFuF++khBThkHqEP+aAfUNe/r8lJ7dyqNxWxUxSZQwUveqS3X5GXwltq
 ApEreZ5p1jF1mawbs8ZgYXBJr9DPogm3HjEVZQ6MmdgU7hrArjhLnto84CzHiygRIYw=
X-Gm-Gg: AYBFou3nbrlXmaz2JPdbZZN/UqmhYtEpgB3qrbeWUiA5ndok8HHmgQmq9o0jAr/v3oA
 j1VRQoyd0jBsyDuwzMDSEGxbYf8lAvCUOGhS3RfuZi3OwLKU3Jx2ohXqAykKI9HPx7bc08KBuDo
 lkmsr5LlksxhaI9sma09lwHydb4PDrECFsoMW76261a5M+YKftRXyTe9zN01WEnoBNvgCQNTb6e
 GD+uZviWptcgkrN28KhfLO1p3fEG89zs2HZ0ctExKruyr2oPLO7/e/eXMCt6EVA1QTVIaDPKZ+v
 3UXTkm8VFaENsauWe4A9NMvM/w8C3bzjGx1TZ6vUm6nFdJKW3bXe/XfDwCIXkzxO/HNEETM1Fc/
 SUgJ1O7knnSUSN6n1bP411GyMr9+2DFin5495wXzlBS/vBEAgC/jPdb3T+H1sb4mYss8ZFoM/5G
 LXfQf9H+eK1XOKYnwhQzQ908pMkx9KgnTQ86j5Fe3k08epRGTBdGCCCdBUh60DJ4LsCTSYZyXmf
 ocQ983QqzflFRkoCE1ztQe8mP52UOOpCWwuIas7Ku3vbSI2VkRiGG58TbRilkWJisyXSxQ=
X-Received: by 2002:a05:600c:a085:b0:49d:25b0:cc60 with SMTP id
 5b1f17b1804b1-49fc5747f7bmr216383615e9.29.1790084018052; 
 Tue, 22 Sep 2026 06:33:38 -0700 (PDT)
Received: from zovi.suse.cz
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:33:37 -0700 (PDT)
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
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:20 +0200
Message-ID: <20260922-module-string-v1-0-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260919-module-string-d64816f203d9
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:22:38 +0000
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

Replace the remaining uses of __MODULE_STRING() with __stringify() and
remove the macro.

Apologies for the wide distribution. Acked-bys are appreciated.

[1] https://git.kernel.org/tglx/history/c/136839a1b4

---
Petr Pavlu (3):
      watchdog: Replace __MODULE_STRING() with __stringify()
      drivers: Replace __MODULE_STRING() with __stringify()
      module: Remove obsolete __MODULE_STRING()

 drivers/comedi/comedi_fops.c                          |  5 +++--
 drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
 drivers/hwmon/fschmd.c                                |  3 ++-
 drivers/hwmon/nct7904.c                               |  5 +++--
 drivers/hwmon/sch56xx-common.c                        |  3 ++-
 drivers/hwmon/w83793.c                                |  5 +++--
 drivers/i2c/busses/i2c-kempld.c                       |  3 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_param.c      |  9 +++++----
 drivers/net/ethernet/atheros/atlx/atl1.c              |  3 ++-
 drivers/net/ethernet/atheros/atlx/atl2.c              | 11 ++++++-----
 drivers/net/ethernet/intel/e1000/e1000_param.c        | 15 ++++++++-------
 drivers/net/ethernet/intel/e1000e/param.c             | 16 ++++++----------
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c |  7 ++++---
 drivers/platform/cznic/turris-omnia-mcu-watchdog.c    |  3 ++-
 drivers/rtc/rtc-ds1374.c                              |  3 ++-
 drivers/thunderbolt/tb.c                              |  3 ++-
 drivers/thunderbolt/tunnel.c                          |  5 +++--
 drivers/tty/serial/8250/8250_platform.c               |  3 ++-
 drivers/usb/atm/speedtch.c                            | 15 ++++++++-------
 drivers/usb/atm/usbatm.c                              | 17 +++++++++--------
 drivers/watchdog/acquirewdt.c                         |  3 ++-
 drivers/watchdog/advantech_ec_wdt.c                   |  3 ++-
 drivers/watchdog/advantechwdt.c                       |  5 +++--
 drivers/watchdog/airoha_wdt.c                         |  5 +++--
 drivers/watchdog/alim1535_wdt.c                       |  5 +++--
 drivers/watchdog/alim7101_wdt.c                       |  5 +++--
 drivers/watchdog/arm_smc_wdt.c                        |  3 ++-
 drivers/watchdog/armada_37xx_wdt.c                    |  3 ++-
 drivers/watchdog/aspeed_wdt.c                         |  3 ++-
 drivers/watchdog/at91rm9200_wdt.c                     |  5 +++--
 drivers/watchdog/at91sam9_wdt.c                       |  5 +++--
 drivers/watchdog/atcwdt200_wdt.c                      |  5 +++--
 drivers/watchdog/ath79_wdt.c                          |  5 +++--
 drivers/watchdog/bcm2835_wdt.c                        |  3 ++-
 drivers/watchdog/bcm47xx_wdt.c                        |  5 +++--
 drivers/watchdog/bcm7038_wdt.c                        |  3 ++-
 drivers/watchdog/booke_wdt.c                          |  3 ++-
 drivers/watchdog/cadence_wdt.c                        |  5 +++--
 drivers/watchdog/cgbc_wdt.c                           |  7 ++++---
 drivers/watchdog/da9052_wdt.c                         |  5 +++--
 drivers/watchdog/da9055_wdt.c                         |  3 ++-
 drivers/watchdog/davinci_wdt.c                        |  5 +++--
 drivers/watchdog/db8500_wdt.c                         |  5 +++--
 drivers/watchdog/dw_wdt.c                             |  3 ++-
 drivers/watchdog/ebc-c384_wdt.c                       |  5 +++--
 drivers/watchdog/eurotechwdt.c                        |  3 ++-
 drivers/watchdog/exar_wdt.c                           |  5 +++--
 drivers/watchdog/f71808e_wdt.c                        |  9 +++++----
 drivers/watchdog/gef_wdt.c                            |  3 ++-
 drivers/watchdog/geodewdt.c                           |  5 +++--
 drivers/watchdog/gpio_wdt.c                           |  3 ++-
 drivers/watchdog/hpwdt.c                              |  3 ++-
 drivers/watchdog/i6300esb.c                           |  9 +++++----
 drivers/watchdog/iTCO_wdt.c                           |  5 +++--
 drivers/watchdog/ib700wdt.c                           |  5 +++--
 drivers/watchdog/ibmasr.c                             |  3 ++-
 drivers/watchdog/ie6xx_wdt.c                          |  5 +++--
 drivers/watchdog/imgpdc_wdt.c                         |  5 +++--
 drivers/watchdog/imx2_wdt.c                           |  5 +++--
 drivers/watchdog/imx7ulp_wdt.c                        |  3 ++-
 drivers/watchdog/imx_sc_wdt.c                         |  3 ++-
 drivers/watchdog/indydog.c                            |  3 ++-
 drivers/watchdog/intel_oc_wdt.c                       |  5 +++--
 drivers/watchdog/it87_wdt.c                           |  7 ++++---
 drivers/watchdog/jz4740_wdt.c                         |  7 ++++---
 drivers/watchdog/keembay_wdt.c                        |  5 +++--
 drivers/watchdog/kempld_wdt.c                         |  7 ++++---
 drivers/watchdog/lenovo_se10_wdt.c                    |  5 +++--
 drivers/watchdog/lenovo_se30_wdt.c                    |  5 +++--
 drivers/watchdog/lenovo_se30g2_se60_wdt.c             |  5 +++--
 drivers/watchdog/loongson1_wdt.c                      |  5 +++--
 drivers/watchdog/lpc18xx_wdt.c                        |  5 +++--
 drivers/watchdog/ma35d1_wdt.c                         |  3 ++-
 drivers/watchdog/max63xx_wdt.c                        |  7 ++++---
 drivers/watchdog/max77620_wdt.c                       |  3 ++-
 drivers/watchdog/mena21_wdt.c                         |  3 ++-
 drivers/watchdog/menf21bmc_wdt.c                      |  3 ++-
 drivers/watchdog/menz69_wdt.c                         |  3 ++-
 drivers/watchdog/meson_gxbb_wdt.c                     |  5 +++--
 drivers/watchdog/meson_wdt.c                          |  3 ++-
 drivers/watchdog/mixcomwd.c                           |  3 ++-
 drivers/watchdog/mpc8xxx_wdt.c                        |  5 +++--
 drivers/watchdog/mt7621_wdt.c                         |  3 ++-
 drivers/watchdog/mtk_wdt.c                            |  3 ++-
 drivers/watchdog/nct6694_wdt.c                        |  3 ++-
 drivers/watchdog/ni903x_wdt.c                         |  5 +++--
 drivers/watchdog/nic7018_wdt.c                        |  5 +++--
 drivers/watchdog/nv_tco.c                             |  5 +++--
 drivers/watchdog/octeon-wdt-main.c                    |  5 +++--
 drivers/watchdog/omap_wdt.c                           |  3 ++-
 drivers/watchdog/orion_wdt.c                          |  3 ++-
 drivers/watchdog/pc87413_wdt.c                        |  7 ++++---
 drivers/watchdog/pcwd.c                               |  5 +++--
 drivers/watchdog/pcwd_pci.c                           |  5 +++--
 drivers/watchdog/pcwd_usb.c                           |  5 +++--
 drivers/watchdog/pika_wdt.c                           |  5 +++--
 drivers/watchdog/pnx4008_wdt.c                        |  5 +++--
 drivers/watchdog/pseries-wdt.c                        |  7 ++++---
 drivers/watchdog/rc32434_wdt.c                        |  5 +++--
 drivers/watchdog/renesas_wdt.c                        |  3 ++-
 drivers/watchdog/rn5t618_wdt.c                        |  3 ++-
 drivers/watchdog/rt2880_wdt.c                         |  3 ++-
 drivers/watchdog/rti_wdt.c                            |  5 +++--
 drivers/watchdog/rzg2l_wdt.c                          |  3 ++-
 drivers/watchdog/rzv2h_wdt.c                          |  3 ++-
 drivers/watchdog/s32g_wdt.c                           |  5 +++--
 drivers/watchdog/s3c2410_wdt.c                        |  7 ++++---
 drivers/watchdog/sama5d4_wdt.c                        |  5 +++--
 drivers/watchdog/sbc60xxwdt.c                         |  5 +++--
 drivers/watchdog/sbc7240_wdt.c                        |  5 +++--
 drivers/watchdog/sbc8360.c                            |  3 ++-
 drivers/watchdog/sbc_epx_c3.c                         |  3 ++-
 drivers/watchdog/sbsa_gwdt.c                          |  5 +++--
 drivers/watchdog/sc1200wdt.c                          |  3 ++-
 drivers/watchdog/sch311x_wdt.c                        |  5 +++--
 drivers/watchdog/shwdt.c                              |  7 ++++---
 drivers/watchdog/simatic-ipc-wdt.c                    |  3 ++-
 drivers/watchdog/sl28cpld_wdt.c                       |  3 ++-
 drivers/watchdog/smsc37b787_wdt.c                     |  3 ++-
 drivers/watchdog/softdog.c                            |  5 +++--
 drivers/watchdog/sp5100_tco.c                         |  7 ++++---
 drivers/watchdog/starfive-wdt.c                       |  7 ++++---
 drivers/watchdog/stmp3xxx_rtc_wdt.c                   |  5 +++--
 drivers/watchdog/stpmic1_wdt.c                        |  3 ++-
 drivers/watchdog/sun4v_wdt.c                          |  5 +++--
 drivers/watchdog/sunplus_wdt.c                        |  3 ++-
 drivers/watchdog/sunxi_wdt.c                          |  3 ++-
 drivers/watchdog/tegra_wdt.c                          |  5 +++--
 drivers/watchdog/tqmx86_wdt.c                         |  3 ++-
 drivers/watchdog/ts4800_wdt.c                         |  3 ++-
 drivers/watchdog/twl4030_wdt.c                        |  3 ++-
 drivers/watchdog/txx9wdt.c                            |  7 ++++---
 drivers/watchdog/uniphier_wdt.c                       |  5 +++--
 drivers/watchdog/via_wdt.c                            |  5 +++--
 drivers/watchdog/visconti_wdt.c                       |  3 ++-
 drivers/watchdog/w83627hf_wdt.c                       |  5 +++--
 drivers/watchdog/w83877f_wdt.c                        |  5 +++--
 drivers/watchdog/w83977f_wdt.c                        |  5 +++--
 drivers/watchdog/wafer5823wdt.c                       |  5 +++--
 drivers/watchdog/watchdog_dev.c                       |  5 +++--
 drivers/watchdog/wdat_wdt.c                           |  5 +++--
 drivers/watchdog/wdt.c                                |  5 +++--
 drivers/watchdog/wdt977.c                             |  5 +++--
 drivers/watchdog/wdt_pci.c                            |  5 +++--
 drivers/watchdog/wm831x_wdt.c                         |  3 ++-
 drivers/watchdog/wm8350_wdt.c                         |  3 ++-
 drivers/watchdog/xen_wdt.c                            |  5 +++--
 drivers/watchdog/xilinx_wwdt.c                        |  5 +++--
 drivers/watchdog/ziirave_wdt.c                        |  3 ++-
 include/linux/module.h                                |  4 ----
 150 files changed, 428 insertions(+), 288 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260919-module-string-d64816f203d9
