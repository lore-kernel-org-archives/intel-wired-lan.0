Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62F606A320
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JJmGbmBC;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KN5OIDCJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 075BF606D5;
	Sat, 21 Nov 2026 10:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IYp9FmKoajsB; Sat, 21 Nov 2026 10:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68AD0606E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795257395;
	b=Zo9+hFzjvLxU1Ta0D0W8+H/cQo1i+bDIQAUSyBN5Bi+f07HNbCsrAuDwdJ7+//KPFT0q
	 Hws61dp0HeRW1GnO6PTEAMJkOfZNckqHyTS0PP9zn/4OZQ5wTnnlqK2d62g+f3Ve7m2IG
	 JT9lqSqNb+fzbpbW3ad5hLHnCGW7z4+eB+MCl0EGbdICJ9Ioxc0S2pJ9nbGTeCuZ0iQ1F
	 XB56vXVDycJYe+MtTu0KnFiEeIwX3ypVJNthGj7XpglusZ6uwV1MCctTLYleSYUc3oQaL
	 WtOFdDm4yENZ1ASMOATLEf2mAO1YPhZnANmKrhQ8hOnQSuTU15ax6avyYq/7WAL9voA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795257395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a24bhYwRQlrJ8z4mZ8p6S5WIN7NkVtJONVg17lD3DVs=;
	b=bBMhF1+zeQZiaxYvks2je2ncTKZze3T6vX8a7SpOLUEZjdrwyveG4KCPM+MGEA7uplgi
	 x+isxsWlp6YioBRiV6Dl9RvtNSzKCfdFIURbLrzEBNSjq3OSSXXL5uuBjXWoOj60lhLC8
	 /kgni/+hGkd8GmgWxl+SkSc9eaJ0FoAc6WpJ5YKQVl9TgEilevIQcjaRQEyMAhMF4swwO
	 DqCtynPhfm3xAXgJJ1wQ36y8Otmlc8LB2tfdN8e+TcrriFi9upqTkq0kKl1YvnHresCns
	 AoZwH4F8N0MKBkFRL8tF1oWljPjYs7q7ak9m40wg4r8kGPqxgYM1fi0VjaNZiQCvKXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KN5OIDCJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795257395;
	bh=a24bhYwRQlrJ8z4mZ8p6S5WIN7NkVtJONVg17lD3DVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JJmGbmBCw6jn+RjUSHG/jLIN4Vd1eX0SbzRTxrGp33r8VM1YtUXDWWnrJG4x7B7Ta
	 7nmgaYYniNbgKpsyZyzEjudlgBNXM0MGuvaERqE9BxaFcDGN4TSrvx9FV7cGhkTkTM
	 B3/7HxGn/giybQkSEW+UUmo9077iich8VVK8Kh7lkYa2sMbABYqHcwhRUzLayT+ulb
	 8CScMNUD6wkVgfkXzajDBMHTBMXRFjn+qC8HrbcrQQYcO7wv6sC/Z+BDKGpPV5E4Vk
	 RPvGY2w3JCgpD32ja43YMTPd0Dkge3s8BnoFz05UxWvqkp8ra0EZSROhoDEpG3gRv+
	 eC7jdRVg0WqyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68AD0606E9;
	Sat, 21 Nov 2026 10:36:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF7A91AB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A18B76069D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kXYNycCJBdja for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 10:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01B076063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=KN5OIDCJ
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01B076063A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B6748C6222C;
 Sat, 21 Nov 2026 10:36:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A3723603CF;
 Sat, 21 Nov 2026 10:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B3DDA11BC0EEE; Sat, 21 Nov 2026 11:36:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795257388; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=a24bhYwRQlrJ8z4mZ8p6S5WIN7NkVtJONVg17lD3DVs=;
 b=KN5OIDCJS3mC0DV+/tecB4+KKiXxsNzUimcVpOio47YJDKwEcksfwVowgpNyRg1ZD2lcIF
 GQCVvuCIkvP3d2JHjffbMwDCyfNKdse6/EdBSRrf5HSrgciILsrR4FraaWAwOBqZmmo7wn
 mc0JOhkUpwqBedgOLZngfuIqLKHmR9DgaMfctLk0qrQohs8x5857cQFqvHPjVsEXLRZJ+b
 FIB63DuigV4QMezJhfc6TWMijigY8AG/YdQqDWlFWEgRF0gGkXbUpqCVCQEeA5gEv3rHLe
 I0nxZtrA+tjwtcDhSiDJdxleiZz4LD0I8m2QzayyCkwLDvwVakqY90Ce5hWi5Q==
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
Subject: [PATCH iwl-next 3/3] igb: advertise symmetric pause only for full
 flow control
Date: Sat, 21 Nov 2026 11:36:12 +0100
Message-ID: <20261121103613.166611-4-maxime.chevallier@bootlin.com>
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

When flow-control is "rx on, tx on", the "Pause" bit alone should be
advertised, as per te linkmode_set_pause() implementation, which follows
the 802.3 specs.

The Asym bit is for asymetric configs, such as "rx on tx off" or
"rx off tx on".  Let's align with the specs and not advertise ASYM for
full flow control.

Tested on I350-T4 PCIe cards.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/intel/igb/e1000_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index cd65008c7ef5..98dda73d507b 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1043,7 +1043,8 @@ static s32 igb_phy_setup_autoneg(struct e1000_hw *hw)
 		/* Flow control (both RX and TX) is enabled by a software
 		 * over-ride.
 		 */
-		mii_autoneg_adv_reg |= (NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
+		mii_autoneg_adv_reg |= NWAY_AR_PAUSE;
+		mii_autoneg_adv_reg &= ~NWAY_AR_ASM_DIR;
 		break;
 	default:
 		hw_dbg("Flow control param set incorrectly\n");
-- 
2.56.1

