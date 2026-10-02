Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E948CA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB940810AE;
	Fri,  2 Oct 2026 08:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZABX4KI5gnB3; Fri,  2 Oct 2026 08:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F1D66810B8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790929948;
	b=i2A//TNb+Pmlq9CqbMuXnWShcQdigAdfVQkkyhPO9M1CCvguxlp9JWjYx9T+ASkJyhG7
	 DPt1qB1MmCE79MtZ/aszWm9U4aDNOO/jD6Q9EcqWhbY9lr2sq1PzA60obDjKnU2dZviAi
	 vUKtKvvxltt4MPPdtQ2qG3prTmo2/fT1sZlvyPkwClUTaYEMaIaQ0QtpqEpXfGuZkPZz7
	 jPfwQyxEqcZBVrwG4iq5ZFTkwBYDaiEZBa8/KkA6iQ1neEDPFZzqfmxQRSB4rWMAhOVMt
	 RmCmUi5IYz9/UFurSDUrWW1GJ3mXqOYx2NT7hJSfg903v4jW6LQMytjC193ggUSw07A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790929948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
	b=JaJV+daGlGbti63qIKJs0JQIgpdsTWAV+hP1HARLI6tqMx4U2y6C1aE8r+kIIZcKo118
	 pKs3Oqz3A1cI74Leio1gWZyeOjisUzNQI1ChozsW69hfFdEgYiw2AnoidWpRVZ9M4ykYC
	 xLYgAvcFY5UOlPtEXw+55G0q15P7FlzeMzLWbAbtM04F7qf7AgwlmhS6qCSmYn2StYypD
	 SzlkX0IyAQq+c9z6ywIrgAup/EYRwVaiyGcBjOpvsyXHt01lbOyPUgpy1voxEcXzTlQMP
	 WZJMmTcH/ktIlhgaouTUKtcx06s7Iiey0/AgNhqNK6nY5vLX1zLRckSi9IvVNcS3Wnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YJYG0T6l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790929948;
	bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pc28CDorUrPlm0tEzs75GlDgpL+L7BpI1/f17eoEYqLQLSz3SsVXHCmgcURwv/W4w
	 rzq/ORnQ3Vhhuq7HPJe2jG2eS0dM8l7ye9gO3ZxHpp+iJRLwjqgUq1FDkJ3dJkXHM7
	 ryNOHgZQO3YZrWEDvc9whPVQXoFj3oTz/Kcd1hU+YDvBGM17eLL0Ic5BSPLMMugoY3
	 MLytv2ffnUG7z4g2TlQm96IRgt8HtxkkUnT1gUiCmc1u7qE/ANFoVRIV1r/daDnnG9
	 1xtPep4I9og8m1dJEp1MWZ6Ia6jzEmHsYBS5TM9QQzxgWrs4Jz4m6pAi0+73I0Yr1U
	 4XXXqoMw77eKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1D66810B8;
	Fri,  2 Oct 2026 08:32:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 862F634D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B932810AE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ibw7QJG4ULeQ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 08:32:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3A6AD810B8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790929945;
 b=Dcxhrh4hRYWa5z3pJ4ZVp+PTV5BfCggs7nmrP34C3dFAnOT1pP3cWeQDHmiZYQSRumpS
 BBjTm+crmFewZzGPymP4uZZiiNC3tKHoJ/8ho5orh2ulA6krosaMHMHEQv1JToi5FQvpS
 ls3prKVaebHMti6M6f3UFnUYJ8xUChWUb9dWp9z2vP8AbZf7BwsECUYO1C6MdQZG/9f6p
 1oRNS/Cbw5+0fNEckRs+44/SsBvQPB0UAtbGocmP1vwGCmxlU07twIrCbLiknY/hZgN+K
 78mX8rJufOjHtMGkDRw9w/Og8nUD6eEYCN/CPx5OnalIAEB3/cfweO8Doj7ajaciaJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790929945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
 b=O4EFzFCWnlpkNhXGd5/y/NEX/GqT+0W9ewWLoXNGR99MDOlEtswra5MH6z7ZGiynY9ir
 ZDa1odrpuYHr8JOyZHmnHgYrXmqLL5y0zAQzCs5gqNt+uTVjmqpJl0KxXiHxeuVpPOk1L
 f33SI3rnNtug5xypH1MQ1d/LIyL46EIYBANijzSD2WB6GcK4vyTotrEtb4eNnAlF0uRck
 lPL3rh5U7zR0gCQhEHL6ALvT3x6qXrGPzApx4zfXLtPEiGK6U+ZlAXJtdM5cXc1d9alo1
 Cw7rx9Or9XJeLZvt9FwrA8qjmVYYsr1LytOdC6pG/OP4j98H6Y4o3aZeiuOt8jDnI+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=suse.com; 
 dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=YJYG0T6l; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=petr.pavlu@suse.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=google header.b=YJYG0T6l
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A6AD810B8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 08:32:24 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887840c529so2521409f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 02 Oct 2026 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790929942; x=1791534742; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
 b=YJYG0T6lEOLag5XASkf60diL28qs2HXJz8f2KjXD6Trjtci3m/EcwTSxrgyh6R8Nxl
 vr7VPNrjpuhYScrUjpJGngCTDQidUK2HeSrV3GPoajthyb9nFOocrCx5o75k3RNn25wz
 0lb51bhkrhd/flNxwyUC9y6pFQ/WC1WtDhpvrZ95q4msmmpi3Oe4/KZYRKutXTy8XOCV
 dq7aZIKh4oVe+cISSmgQw+AnMbKLqu2QVg3Ui6eDhM7P2EyYnUO0VIM7LlkfMbspKiwQ
 sEdkyTshlwVPqkK4Kd/A9QkROh2b0LvtMNLnmKE6Q8fapkgRMGXLrbdIUslC2W4hY/lE
 n2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929942; x=1791534742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
 b=PpMMs/seIpfpDUqJPKb0yNSZsHraX6xoPvEeJ8m7Qb4tOy+qGhdBUXM6214THoP4eE
 htjw6cMERkhNLflWQxiLc9AA252E+/ehe/O0jAjAHbhgxciemAh4Fs5FEYY2MNvM3mGA
 0+bhsBo4j24KSSneQ5yjJ2piSYprVVmmGjY66BACmTBxCfcmUhOjfhMAEoySWMb4Ajnv
 PoJ5/6+FvTbnP6GLwY54LGzQWqIfHIHdyNDyNaDv2S9wzk9IiqQtRTAwOFlxiLqDyw10
 HScF3FNyb8HGkNNGASbo+OihjzELdafA54EhffsQeyTWMeaTBGVvM2O7ynWh4jVo5+Ek
 VtGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkQxCTd0CUCZ0MzjhHp2hLPWwygwXAczYmT2AkHNkHWtoYWM/auiWatYna7Nk9wDrE25UbsxijY2RyZS/94yQ=@lists.osuosl.org
X-Gm-Message-State: AFuF++nOu3FiUdVjsiToGemO5b/AMeyZOqnAazQ3jPO1OKxABuCPKUX+
 TGT9px3p0h3Qj2e+g6enfC3mNvy8nFLP9Oe4NoTGmULdDMVjG5K7qycfV0469prnmLc=
X-Gm-Gg: AYBFou1hd29p7zP1UL6bkLWJuhCK4AC1iDfecc9FW3wV/qf5SH63ETuFwwYH4elgTA8
 dSsbYXzxgcC1rDFQrK0YvqcPMdVpGoIJxNs5Vqq28c0xGuaEtd7vDvzxlEMWutrBZZ4pZIIwftt
 XD9jPqGv02C/pYYevMSmmkuJlE/dWXF7SvLqxajV9tTVUsNnc5g01Zxy43aX63fe61z9bpiGy9V
 Er/6KAwzHzAYvBIXN/Z/3QpGjKAZNk0pnq50X+2UsJxMchzgcvHZh9q7Oq/uBAqKAcgBpbEAZ+s
 eOhYcmmQQsmx6uVVn/k7rQCOIdkzPyVHc3+z9C9FdgvJPaBf/A5jXhUVOCcF0F8VL2wU72uvum6
 EKpKeS24SO8yHoIMPZQu//nJReb4oFZLmEyyss2dtjIZ1hlDIiqS/Z671dqKA1rQKHiMuxJz3w8
 lT2GBd98u+80eX1xZeE75iSEi0u/PLi1DjEdb/DZNJsjNORj+dJ43FOBtYSPI5SeDgKcA=
X-Received: by 2002:a05:600c:548c:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a027534bd7mr33259805e9.5.1790929942490; 
 Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
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
Subject: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
Date: Fri,  2 Oct 2026 10:31:01 +0200
Message-ID: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
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

Replace the remaining uses of __MODULE_STRING() with __stringify() in
preparation for its removal.

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/hwmon/fschmd.c         | 3 ++-
 drivers/hwmon/nct7904.c        | 5 +++--
 drivers/hwmon/sch56xx-common.c | 3 ++-
 drivers/hwmon/w83793.c         | 5 +++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 019fc32bf318..df9418a86c83 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -35,6 +35,7 @@
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
 #include <linux/kref.h>
+#include <linux/stringify.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
@@ -43,7 +44,7 @@ static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum chips { fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl };
 
diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 976b8a008e44..04e1a8e6db37 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/watchdog.h>
+#include <linux/stringify.h>
 
 #define VENDOR_ID_REG		0x7A	/* Any bank */
 #define NUVOTON_ID		0x50
@@ -113,12 +114,12 @@
 static int timeout;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
-			__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+			__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index a385aae3bb0f..febb8ba7dc2c 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -18,13 +18,14 @@
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include "sch56xx-common.h"
 
 /* Insmod parameters */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define SIO_SCH56XX_LD_EM	0x0C	/* Embedded uController Logical Dev */
 #define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index c6ef04c69856..e1f2708b5db6 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
+#include <linux/stringify.h>
 
 /* Default values */
 #define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
@@ -57,13 +58,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* default timeout in minutes */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in minutes. 2<= timeout <=255 (default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved

-- 
2.55.0
