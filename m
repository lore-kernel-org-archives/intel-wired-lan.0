Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964C606A325
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DYkXSi5/;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rk4l/VVL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 934CD6066A;
	Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6OaspcS3SQp; Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEADF6067A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795257391;
	b=Ec8gz6qc/XMUesZM4LHaCUX6Yuv4PROb/FTPr/yYUA5bkSxkejYM4MRuJorWJYdj07+U
	 dg5vdCFYcew6G5y0lJY3/zrZJM1R9CSEtjTeVbXLGYwqRg3nziQHF89BeeYqkkb9UxEwK
	 ljQBLOeI8ieqg/H1/LmieqZPYZT5kN4g73B6rlTYvKyqkKU1aYHPASgXD07sKVVVJkfr7
	 pMYd8h0NEFPOLSt2z8RErWvvXlelzrFTm7K5XsTxDK228D5MLb3SBtXdPMZHwpfOVISvh
	 rVfscuhu+HaEOZdnoNEFijSU6QqKCEU0hcrjaWg+I19cr/qx2PVrWvk1or5Da6YYHUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795257391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7YilFJHIMBhnIWQiW5Cx1KzDPc6CgaF1NrneZ3Yl9/c=;
	b=jp6myoB0zr3x/wMalxYLFGrNPPhscyCyYnuSqCdps+3ragzz9/svyaYNH7lSfR+KITYQ
	 2HhE10OICzH9m6CJ7T5WwKsMamXvJ7dgFOrljSRZQP5ONAhTYNMi/3p7m8IhKXzmrRT/d
	 3sp4RzaQ8xVzErhrVC/C0pd/XE2z7ZWHmdoZb7txrYrVkd5nRE6FQBChst/ywx5gfXWON
	 5P6k0J1baO945JmSy/Q3p0MtE5IcPXDJv9ThG69nzpHyqJHb/xN5Og68+NWiA9tb+8fSP
	 gWQZWF6RkTyTe8TrsWiajBSwx/7LiNXYf9CzFMuJzE0igKlLWmhQGlYmiOMiJf4rCgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795257390;
	bh=7YilFJHIMBhnIWQiW5Cx1KzDPc6CgaF1NrneZ3Yl9/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYkXSi5/m98NHErqn7ygVUqkK7Ew596MQF/4Q7kvsGffLpFt73fcQ6wU/5EY1VZ6U
	 08qAVP0w82ChgSGCsj+7+T0uJpQcJToh8EPHfESuO49JKUa/1n+wZCglbYYcQZsyeq
	 52XartTi9HWSWH5L5ttKifYIU30kqYNAydWkYILc/tqUXGg59DDhQmCGRTlBH5c2Oi
	 /65VWmhZEvY0EUHgJH8gJ8ApV9IrzfW/BPWxO1GFCrz3oretFsM+5UyhiRqhDqa+Az
	 bGATgLs/dqCV18jQHaFUgJcjkQwVXIar1s9a5FKvN6SOxpbgUN3ST430Qn+A3a5Gqs
	 BxbVCjLGwy17Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEADF6067A;
	Sat, 21 Nov 2026 10:36:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 803641AB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7158A4006F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiFiCHWo3MrU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 10:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 19C1C40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=rk4l/VVL
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19C1C40012
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 970B7C6222A;
 Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7A5B6603CF;
 Sat, 21 Nov 2026 10:36:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 788A211BC045E; Sat, 21 Nov 2026 11:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795257384; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=7YilFJHIMBhnIWQiW5Cx1KzDPc6CgaF1NrneZ3Yl9/c=;
 b=rk4l/VVLw7nlhVNhKX757qAzI0R2LnQyXJfiUk9qpvLXYPdQrjJOc/ascgg9Rg1wTCHI2X
 rjYlT7z4B82aGaqj8Hgxi+TafGjXshQXYbLH9W0AwKlp5R+Bjh0xDKvIXWh0+ZsheQFS0z
 ufF+FQff5HOSlzhSMLHTtx1P0XO8Bj0uKq5a7c/tszDE41Keqk6gtFvfI8P8CaHIvYh6fF
 3H7ON6SOAyOvlRLm0gAga+NaftEsoJ7xPHPN1dn+F39FUOAlh7y8OE9EM8ZNiqx4oFJKVM
 4FRYL9cwuQVXggDhyUlqE8iY6JHzQv1f9gt25xA66Kh4JZ7BtYo32KVWiYTFPw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 matttbe@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: [PATCH iwl-next 1/3] igb: don't change the pause config when changing
 the link ksettings
Date: Sat, 21 Nov 2026 11:36:10 +0100
Message-ID: <20261121103613.166611-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121103613.166611-1-maxime.chevallier@bootlin.com>
References: <20261121103613.166611-1-maxime.chevallier@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When enabling link autoneg, or changing any setting while link autoneg
is on, the flow control configuration is reset to the e1000_fc_default
mode.

Flow-control config should be changed through the .set_pauseparams()
ops, let the configuration as-is in the .set_ksettings() path.

Tested on i350-T4 cards.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ccc7302dc7bd..cfa36eab8b0a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -322,8 +322,6 @@ static int igb_set_link_ksettings(struct net_device *netdev,
 						     ADVERTISED_Autoneg;
 		}
 		advertising = hw->phy.autoneg_advertised;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = e1000_fc_default;
 	} else {
 		u32 speed = cmd->base.speed;
 		/* calling this overrides forced MDI setting */
-- 
2.56.1

