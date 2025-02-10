Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B13C0219E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Feb 2025 09:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E09B81EA4;
	Mon, 10 Feb 2025 09:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydWB75u415Bu; Mon, 10 Feb 2025 09:19:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C0FA81EA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739179187;
	bh=Ix2EmGz88Zjmg5yPhCy0AMV3QC7r2VV+0+xpiwxQjRA=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ki0UrLqy50+NvromRfm/b52Uyd03Nkdka4QdYgjNxFJNDxOR4S61CgVoZCXqa7GUr
	 xdY344lU9iEzxSIXgZXLUS670kdncyCNv/H6aZqj3HTCep/orJy9DN63zc3jCUoKj4
	 wvYQtU0Hdl/TR2G8A0QiuM7cy4IJ9xfFRYqElZ/5JE30qMDsl1frRdp0PF2hX0yeKl
	 jED/8fTQm4xqPj0KlhVap16syfkqpn7sR4MS+8EZ3/vUwvi6VLeI6BdcgrXeMOnTFZ
	 xfarmTQYDpW4/Y06vXjvY9EBGK6QNn1w23yjZe/mETR7ymIUTlxYlpW0xmyOIUBh6Q
	 2Q2uAQVhgNmDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C0FA81EA6;
	Mon, 10 Feb 2025 09:19:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60FC6C2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Feb 2025 09:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 403114124D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Feb 2025 09:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRrO3xENVaA5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Feb 2025 09:19:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=kurt@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 677884125F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 677884125F
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 677884125F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Feb 2025 09:19:44 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Mon, 10 Feb 2025 10:19:34 +0100
Message-Id: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbEqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwMz3cz0pPjMokLdNNNEkxSTlNQkIwNzJaDqgqLUtMwKsEnRsbW1AIJ
 ScMxZAAAA
X-Change-ID: 20250206-igb_irq-f5a4d4deb207
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=3AIrpIXR0RLR4O6Ma9nszz+1ni74W7Wyb++QRtN/mvQ=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnqcSogachtm51iVVzqCye+2W0qpWJsii2A7ODu
 Dg2gg7otG6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ6nEqAAKCRDBk9HyqkZz
 gkSBD/9OcRsADRzX8fLdmYn9GRAHSr8KY6SsSpjxeFGtkB+EgUVuZIxGoKgU7qfSm5PI60puyAo
 YOmNk4HdQRBoNzdbUMVyrNOYo1mzeUbDFSSeBR9pNkn7wyWOhbDh2oMK7GbYiwz9bXHxCrYU8zY
 VaLBskEHSvgjwXkM36HGEwyBq8Zy0dNuT1/xdbYGb/f3H9g4b12iqlDYWAplgyHAPMWN0UAGhhJ
 ScBBvmIkrOu+VEQx/Cf9TAW9o1byPeIMh49fflxjHVEg+7rNV9Ewwqqk+uqVJVZB/DL9R0vTjO1
 CPeHQmbqerpxP8H7d5kmOavLBNXdsuVloZjlBPKPOAsC5NhkFrqpO4Nzhj7xgMbpoI0+Kr3qTtu
 4sN7VETWlXQhW83vGABGz953Cmc0aL5ErVcRjL0iYgw7lz8YxZRz6Pgk2DjsVRgjdMEjW+8EOdw
 E3GIHA2o/sUo5PqpolHRa/4opRvjyrlBFVQGMzNRirJgKg8SQ4TE/TjRfEbSqG3D7WK04ctMBtN
 ST7cOvZJzsAlVh5kCiSHXBIgWasJ/pZwyxa45z5VOOLGSJll5gcc1hNSXls9S/PeTOIA7XyJ6kK
 4XopRUhJLVoXZ+5H3ho19kbGMQAxLPOR0+El8Rz6R5CT3RUnk4myV10L10gAYR9So4N+QUcoMrT
 Bb+/9Ec7gtviqYw==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1739179178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ix2EmGz88Zjmg5yPhCy0AMV3QC7r2VV+0+xpiwxQjRA=;
 b=UdlG1pTtn2aqez4G2wG5H0h3QDC6Xr6KsezXoVzbmBdY/67LnMuOs5ZbNuyAB3ozf5OXgp
 39+FIL8lbul5z3jNEkYPbLIXczDV3reQ5zU7C01Y67IYtCq86MXlqiGYDU2x4IW9ob15S/
 73jzUPcwkqgZP9bPktjvSBuSBW1k7rh3yND04+ld7Le/82/UpkxyjiflIu2cK6ZSK2w6Dp
 P7edAhF6brC+wBTwaeZFod0VVSIh3+swpm+EXqHboEuiM4clmUXzBbRS9N7MRM6507q2+s
 KQaSNqqexBHV1/7NA76HaiDMHwYNB1//mBUn8KTXA5G1oKmBAFm4gUc6BHD0EA==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1739179178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ix2EmGz88Zjmg5yPhCy0AMV3QC7r2VV+0+xpiwxQjRA=;
 b=TulK/1yRQpdco/ARbXTOPCxlSrKl40Syw824xdUEIUopxj27XGCp2F6V7qxrq73Nkl7vXP
 cQxT7Mrhf7BBEwBg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=UdlG1pTt; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=TulK/1yR
Subject: [Intel-wired-lan] [PATCH 0/3] igb: XDP/ZC follow up
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is a follow up for the igb XDP/ZC implementation. The first two 
patches link the IRQs and queues to NAPI instances. This is required to 
bring back the XDP/ZC busy polling support. The last patch removes 
undesired IRQs (injected via igb watchdog) while busy polling with 
napi_defer_hard_irqs and gro_flush_timeout set.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Kurt Kanzenbach (3):
      igb: Link IRQs to NAPI instances
      igb: Link queues to NAPI instances
      igb: Get rid of spurious interrupts

 drivers/net/ethernet/intel/igb/igb.h      |  5 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 67 ++++++++++++++++++++++++++-----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  3 ++
 3 files changed, 65 insertions(+), 10 deletions(-)
---
base-commit: acdefab0dcbc3833b5a734ab80d792bb778517a0
change-id: 20250206-igb_irq-f5a4d4deb207

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>

