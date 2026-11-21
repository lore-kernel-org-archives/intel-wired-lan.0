Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48115606A32A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nzNCOdzX;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=O0zJU9nN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 235EA606C0;
	Sat, 21 Nov 2026 10:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWcaBFu2NsFH; Sat, 21 Nov 2026 10:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89872606D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795257394;
	b=tDrs5kVNMEjYegc68PChiucs2R3G79tjvWlNatuFOCPx/J9BZwdozYslGXbepXXkxPU0
	 dYcweBVKy4rqAXuUJribrXEW5mbVaPfDm8mT56Mmbx4t6RMVndknXeMCgx54V1RuEimpZ
	 xkN9m/3N/Tv4Gp6ht+T2WVnI+Rot6YlAHHVjWvFRMuOKMQqokJzl7TADWzdrr14mk5jgP
	 JgEW/p96+ZkbqWfr1udKyheyYNdmsSGR2MvDkbtB9UChdSIOEu49qbOg5rXfhk+GTrYwk
	 3wzmXo79kxm9cSsGPqSvdtJi2Gi2fkLkGEPcv0y8vstka+VttS4LzW1bTqSrRfk0qVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795257394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1HEjco31EGEWm3OKEP6kPdguqOM3laifo1Dc/FOQ61A=;
	b=p4/uFFDwz/iG+N3VhwDXKJl98wNC/sKew+up5oxFDmnWcb61Ow9s8l6JY1npQwaME/M8
	 WEPRGtlkr2IDJd1lxJtu3TwDr2e5E3TZJypsBcWqUnDbWLIrEtU1zUXfNEiV6xq9yixsh
	 2HsBAOR2akrUuJ6AJknSUHG8MzI5piAv2uK3rqi2pBL3S1Qmh30VQCstGmxoGiXY2k3PI
	 a3GucCmvIvprTp8FsS9JpfCIYAGzQ/3lrDy04tA6LNh5NjvpgK2Ri0d4UQBVNR5RrQwiZ
	 /rIRImLoRi7xswsC87j99tNIdN8frfNE0zUtyTqBjdepr6+y9qfMC73HSKh+wRVi6Ug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=O0zJU9nN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795257394;
	bh=1HEjco31EGEWm3OKEP6kPdguqOM3laifo1Dc/FOQ61A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nzNCOdzXQnjGar591UBuC8CYYvAq0z1NrwXsNk+bNKQ4NlGsQJv3bz9oWgvOCIpdq
	 Jq9o3Oe+EIPayufMSLT4hsxXrfJ2a1Ziad63eHNykwvVsw2+hRZHcBEvDo2wKpe80D
	 fBfQ7MlT/9c444tWmoTFRMfXbZ2RPv1FS/NC0eyhJACqa8kxiK68UGUfyVnAU1wJ51
	 XUY86/U8esQpI3Oe58u4u2d96S7+1DqjJnqKkXIsVTlCSv3KZJnB5rvZgtog2n7lXI
	 FfpvX+kZiXyMMbp2jIm2slbhfPwRVNFK0587Q2QwfUwRwIiWsc/xOXZG1NUCxd51Ny
	 IcMVwoC1krLjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89872606D5;
	Sat, 21 Nov 2026 10:36:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C5459C1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A4266069D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EP1A4Xp5NsL8 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 10:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6B016063A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=maxime.chevallier@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=O0zJU9nN
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6B016063A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4E12A4E41699;
 Sat, 21 Nov 2026 10:36:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 24723603CF;
 Sat, 21 Nov 2026 10:36:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0375711BC103D; Sat, 21 Nov 2026 11:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795257386; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=1HEjco31EGEWm3OKEP6kPdguqOM3laifo1Dc/FOQ61A=;
 b=O0zJU9nNiuvDj6i3ujkkd6VDAFdI+bZ3QGiTP3UtBMlJEXRTkiOrpBYsl+cnrVAhiMa7Nc
 XcQKny8xCQ3GHvg+IEfqJEe4dvOBnrlVK++Pka8KQ4IAGkaA/AZOH08mAGU5iJUhSaR+E0
 8ZhhAcvvJ3CIGkXFDQfPhQI/qNTeT+n78QROVjc1B7zPcpqM/xFsjyksFIeYB5zAIT/mFS
 dj1wlYuWJ1aJRhfEo2OqVQBnblV8pHLvzlYA6TbaCNaKzTBpjccGisgmapXPdF1CnsXPhW
 RTSIY6ToqgaDTEFZ2ZQ0gf11dp150EIiA7yZ7sEBzc7Odp26iYjYVX0KcUchxA==
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
Subject: [PATCH iwl-next 2/3] igb: take the user intent into account when
 pause autoneg is on
Date: Sat, 21 Nov 2026 11:36:11 +0100
Message-ID: <20261121103613.166611-3-maxime.chevallier@bootlin.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the pause parameters on igb are set to the default value when
pause autoneg is enabled, regardless of the parameters supplied by the
user (i.e. it ignores the "rx on/off tx on/off" params when pause aneg
is on).

Let's take the user intent into account when enabling pause autoneg.
While at it, simplify the tests on tx/rx values.

Tested on i350-T4 cards.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index cfa36eab8b0a..03c69409a6f4 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -406,8 +406,16 @@ static int igb_set_pauseparam(struct net_device *netdev,
 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
+	if (pause->rx_pause && pause->tx_pause)
+		hw->fc.requested_mode = e1000_fc_full;
+	else if (pause->rx_pause)
+		hw->fc.requested_mode = e1000_fc_rx_pause;
+	else if (pause->tx_pause)
+		hw->fc.requested_mode = e1000_fc_tx_pause;
+	else
+		hw->fc.requested_mode = e1000_fc_none;
+
 	if (adapter->fc_autoneg == AUTONEG_ENABLE) {
-		hw->fc.requested_mode = e1000_fc_default;
 		if (netif_running(adapter->netdev)) {
 			igb_down(adapter);
 			igb_up(adapter);
@@ -415,15 +423,6 @@ static int igb_set_pauseparam(struct net_device *netdev,
 			igb_reset(adapter);
 		}
 	} else {
-		if (pause->rx_pause && pause->tx_pause)
-			hw->fc.requested_mode = e1000_fc_full;
-		else if (pause->rx_pause && !pause->tx_pause)
-			hw->fc.requested_mode = e1000_fc_rx_pause;
-		else if (!pause->rx_pause && pause->tx_pause)
-			hw->fc.requested_mode = e1000_fc_tx_pause;
-		else if (!pause->rx_pause && !pause->tx_pause)
-			hw->fc.requested_mode = e1000_fc_none;
-
 		hw->fc.current_mode = hw->fc.requested_mode;
 
 		retval = ((hw->phy.media_type == e1000_media_type_copper) ?
-- 
2.56.1

