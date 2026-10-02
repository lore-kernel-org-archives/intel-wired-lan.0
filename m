Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3229BCA5FD9
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF50B4084D;
	Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXnZixa4TrlR; Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1DE0D407FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790929946;
	b=pKrOcKJUvAJOTw8rBSYBIU3UqNtHNG01N8egX2bMVIAdDvprCqJj24t4eraTfjuT++8u
	 DwdtgP/LUK4Zk7GzPjHBikeUCKpdwfJKVkvx4xgqC5OCcwIxisaFopUo9/IZUV+yBC9Id
	 T8sc8/+uUYIaQ1RrN6khUMaaMTtzmZWcarRYTZqjTdAuO51PU6roqdlpbAXjvVFW20cbL
	 Gth8OalL1Ue54lY2KVxvPCnPzfVLO/dyfNwKkgFJr6Ck41smwR0uvAGNbpYPnhCAElR+z
	 7ZnRUQsXLZVrF0JUjYDkBaM53Fs4pKSBzLCb+Cz5FHT2FrdiOTdcu7LgNI1Xb27GjqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790929946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-Change-ID:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
	b=H+sFZ4FHO/TkOBjW2J7DXC792inIdq77Wb6yHNiHeqsUp3AKmWd4LTi1B/FgpKf3FUNP
	 g9SDKJoUEhvsaUR8BODXu5gkygmmILpwW0LhqMh7sUdQoLA1gCe0nBtyOHc5ZJHnpwwIe
	 7NBZ9ho4YdRPuOg2K8FYrMWWPMBTKsLjRIzBJ+8KI/QU1YhYreHTGAdzQ/meX7SpadPbm
	 Ft3MA387LB9MHYWFuYbkGcpBwqZCAu95lUHUYideo0E8Bi46jJzSVCWqOS4hqMv+la6D4
	 l3PHqdgjM50x/zIh6ZKKPa1Tdk8kN/oWFLrFj+2asm9Q48I10/wHL7Kil9MtAb/Hm0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790929946;
	bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wT6uy+TXiMIrV9tyffMyReUiX4bs2PUuUIE76KP4e3K3wG160WS5AlC0unSJ6KckE
	 Q5hS4PmaCxL7oA9flyNQH4NHUxD2UO6BcJwW8nO3M1d/7Ji3ZUDnPstq/msfWfITe8
	 LGSLTkHrUFNcj2F2RHaphTWnPBuSFY73eDj08+D5nItB21cZm1Fu2zxp3w+EsAMmaC
	 8SUcRsGBVJ8TfpG8QF8rCDbQByJphWjO5v6pmnlFF2KSkNBpf/4fnWTmpWJah3uzxZ
	 v571vpE+mhOgGg3J3sDJjZDscCbdUJ4L32r/r5EgUuSUhkC3r0CHgKjr+6Nn23Xa4v
	 wON8XOmCAjATQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DE0D407FB;
	Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A3E5282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BAE3810C0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojC2C8DEQlZk for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 08:32:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2A38F810AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790929944;
 b=K2/vXuOAEcqOOEghR7qQqqhI118c1SuyW01SHKisGUMVb8JOHvTrGZRM1/ZRcc75L2mX
 AYDXndyEmJLiN8MqbROxNcUBBkiLcxFJM4gq+ZSF0jdUm6vscQpLUK92pOIgdWeVMHyFK
 8sCh3KQEpWP3x+ef8A5fqBnorWBZtGlZrxvEAnqs1qp4rtpfzzY/iRYFKhj1UWMEXCafX
 qQWquY+A9pinhzTbF1Higtz26BN3cGmLxLgC2RO8mUlJERHjtowqVv710tM86hncdJpv+
 ZiPHoKvHdOaZZSLg6TvpcZ3+eNPGuCJcWwbHdGPpYviMct8VCN8J3CcdTEHuabdCIsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790929944;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 X-Change-ID:Content-Transfer-Encoding;
 bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
 b=I15N1jSFz7HKEDBdK3hDICtn4Qm3InbKpSeVFx2YvCAdB+ttLjf/NkOORDzLoGHRQUR8
 BEWU5/hWz8z2pFvCFPGTjaH5Kb2/WqYpYz3wBl2/dst7gIvfRMwgCfzaFiHUPiknOTXoD
 Va4IWdQdp+kyY7j5KsGRcW21+zZCwJZ0ByZRchsAThJCGq1EQ3pPW9ZMrsxSyeUVnT0qA
 BNExuVf/H/h8xAZ85WaYCqVxxspStFpdf3YZ7PebT3jrOSK6gt5dnUF2u5ihnX4hiNfLZ
 1+yXIprILXsSFlRTyva7/zmguISkYlZoJo7WfbN4Zz37oKzEePR45u5fe7R34pTmEig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=suse.com; 
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=K1SVEj70; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=petr.pavlu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=K1SVEj70
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A38F810AE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:23 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so55586555e9.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 02 Oct 2026 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790929941; x=1791534741; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
 b=K1SVEj70h4Jis5igCRaUFK8ggAyBH5NsYoUiLBueUaT9y9Sxwv2liUavy4vME0dB6c
 yJl+Uz2r2mR0eoOZjjZjC8NGBs/wa/X2PSrPZXwJC3XbdNIoFQm6IRa8mMeilMijQ0Mt
 fgfMNSC1S+BTshHp8jJbu35+gWHK60byLzj1NnuYhYYpGUib6xeGcg1gN4U3wA0piiJS
 bahLLYE2xjxjazQ3qp0VJhXUUPpo/idiqscOxqK1cWU4Yc2V/beJh+Rsag9RZbCdvt3w
 bO/WxaRNOq6hUgAhl+9M7ENSbJxvFos/j5OvENMwz+RvJGoNdcKZEvv0v8MSDgsEHqv9
 Oklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929941; x=1791534741;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
 b=yiNBngruL6OH3HqIsZpw8VLxJorKkrhHnwoPi4yulxxHN/nOwHv6F/Qqt0e+So6hu/
 44num/GmoG7OX1tl1PHr4JLkz1iueHmjF8Euzelzn5zLXADAqJB5NkL1AUnJiWEeCXxW
 86efBC+J/NwN6omMszPLckGIPVrdnOlaIBPSvStv7UJqzi+e5DIEsO5PAlk7c7a7UGTH
 etZtYfXoTJCrJFHcLr0W7hOXdjgXhJ4+HFi+HeM11SCFH6Qeola7AvOF4iEL/9i7s41B
 V2R+3kaBWcVItXTmUuTr1N2t83NyanCFz7crMuCtGC0cTJ8QPP99j/K5hyHhvYLrqSj2
 nJew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxv/hlAT0Pc5XqRCAxRxJ5k2emTroItun/6DOc/feJar4dHqlozh88Y1Nfc9wIM71dklaTuWZWtVQpE2VT3fjw=@lists.osuosl.org
X-Gm-Message-State: AFuF++mZ0mAVwNNVptBQDeIUS5WjxY2SD7HGYT2dk+YB1P6QVmUB8+LT
 1rYciaRQ8mtvTuPN3FCaYRk4LAWauQD/XiLRvkXgGOBbdOHcGOHoB4hwi5/+ZxhYGVI=
X-Gm-Gg: AYBFou3yJxI+29Ksg3IQEcFuaA2w0dK2SFRy99MApIeITEJQzKqkC6ZnIdvl/iN3YWN
 P9A1zdGcqjRcX36c7EquX8uKo4vJbqQzudAtOlanyoYonRbIZAeykG98iYmttgnRw/+7MUBUseC
 qAcJo8Sqx+wVJ7+D+uctlesL3mx8avYqTQibKjzLFCtWDPsG+/LnvhybVqhRfH1VzQUWZT3N+xM
 MYnWCnHo3/QfHrso1WsNua2gu+Qe3dL//PZgtfGTPJo9oPfScL0v6Tle7i3WfB+LhsR2dq+iNlt
 8R2qgXcb+6mvpi73oulgjwPGdPseqb91hB4y64C92YFssqOiXbeqVE+yNdNf8J/QGUr9VjMlafs
 ghiWPFJnoUMdDYAoDO5vrecnL2Xr1uiNxEgK7cWBuldABoSBNoctZpIJNC89b4xAQs5EF33XzDX
 SE3XuBNUa3BOA8oiM4u0LzffX+egV7MqOz3UDOebPZt2ehgT50zLVeJOXK4/qkS/CK0w==
X-Received: by 2002:a05:600c:4e41:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-4a0274f9bfbmr42577955e9.3.1790929940907; 
 Fri, 02 Oct 2026 01:32:20 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:32:20 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Date: Fri,  2 Oct 2026 10:31:00 +0200
Message-ID: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260919-module-string-d64816f203d9
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

Replace the remaining uses of __MODULE_STRING() with __stringify() and
remove the macro.

Apologies for the wide distribution. Acked-bys are appreciated.

[1] https://git.kernel.org/tglx/history/c/136839a1b4

---
Changes in v2:
- Rebase on top of next-20260930.
- Drop 'watchdog: Replace __MODULE_STRING() with __stringify()' since it
  has already been queued on watchdog-next.
- Split the hwmon changes into a separate patch.
- Link to v1: https://patch.msgid.link/20260922-module-string-v1-0-c18766690185@suse.com

---
Petr Pavlu (3):
      hwmon: Replace __MODULE_STRING() with __stringify()
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
 include/linux/module.h                                |  4 ----
 21 files changed, 76 insertions(+), 65 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260919-module-string-d64816f203d9
