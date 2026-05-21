Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7CBCD5BAF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 May 2026 15:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C4FF61AD1;
	Thu, 21 May 2026 15:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXiueWmV5E_g; Thu, 21 May 2026 15:46:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43A4F61ACC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779378400;
	bh=EQSpA4ZTPRnz9G9H3FIaLAkaSDGkNEul7L4Q8NT2ouo=;
	h=Date:To:Cc:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=RVGV83x/cECTRUit0PAP8HkZtWHqYy6YpPCeq+yqIr2sConzhduiHfWUM5X0TfK/s
	 Yp7nVmeimUN1eqE1fJPwKlXCQ5mJq9FDl8Jhx61m/B6zfHIQ+a1WnTlyrNMc+xe9ld
	 DiPlWp2aI1JW9ixMtMcnybEKQbnrISFu5h2mdrSDn5S7lmd0ZyZSQrZn9PU2yXq4vG
	 qm5kp9m/lKTbUVpBDVkVCbqlLkJuUqxV3v2lZLawQ0ei9QQ8GiDpPtm5o7esr/PplA
	 tnsCn2QntaFDhFCPeXWEx5QW7DCgAK1Hw1dKqe3vxzcPOrXmPbVV4HXwvvn33uMnX+
	 vQR+f95IP8VUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43A4F61ACC;
	Thu, 21 May 2026 15:46:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A90282
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 06:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD9D241DA8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 06:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVkGFdQbnG70 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 May 2026 06:26:30 +0000 (UTC)
X-Greylist: delayed 909 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 21 May 2026 06:26:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BB0BC41DA7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB0BC41DA7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.117.158.93;
 helo=sender-pp-o93.zoho.in; envelope-from=linuxuser509@zohomail.in;
 receiver=<UNKNOWN> 
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB0BC41DA7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 May 2026 06:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779343828; cv=none; d=zohomail.in; s=zohoarc; 
 b=ZdoHJQqyT/sdSj+9pX3W7UlwLWq3pRWl4FJ+eU7sXyDcujetypKNZ94IBJF2Wk31sHh69irhf41TvF+x/PM8Lc/A60htlIwn0vL4ke6S62kEHpxH/6XA33Aq8am6A8YUzzx1sA3Q/OSRysQHgIhKn4rVU5GRYDOIMma1PVu3eq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1779343828;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EQSpA4ZTPRnz9G9H3FIaLAkaSDGkNEul7L4Q8NT2ouo=; 
 b=NhvT0EqPM3n/EBW56byQG2gdbTZaX7ZPDIsET/RXXbPedE2VZX16O3hV8CtVbRQK8QbKGFc7a8rFPTlHniFvuh/07Xxkhy0+BMEFJWjdu/7NIOz0Ad9FNY+lpzLkmOmRAluVDpCEXHY6xZ2y2S6e2WT+96uSfGNibkDMsuRuCJ8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
 dmarc=pass header.from=<linuxuser509@zohomail.in>
Received: from mail.zoho.in by mx.zoho.in
 with SMTP id 1779343819672847.3911387241204;
 Thu, 21 May 2026 11:40:19 +0530 (IST)
Received: from  [27.59.63.162] by mail.zoho.in
 with HTTP;Thu, 21 May 2026 11:40:19 +0530 (IST)
Date: Thu, 21 May 2026 11:40:19 +0530
To: "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrewnetdev" <andrew+netdev@lunn.ch>,
 "davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
 "kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>
Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
 "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
In-Reply-To: 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Approved-At: Thu, 21 May 2026 15:46:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1779343828; 
 s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=EQSpA4ZTPRnz9G9H3FIaLAkaSDGkNEul7L4Q8NT2ouo=;
 b=p0LUN66tKJtnMqgbMoL3gcbNvX6Or5P1xY7lbeWoubjE5dyUK5IQshG+oRKzT97Q
 r9AqfLVIcKt8s42yb0da/rXqBED+Xvuqn0xcrdkxy/YIaKMxru5pG6UK1uLjwzg/w3v
 o5h13xDI3YzK+wIC1IxNo5u5DcsRxrLI3Aptl3SU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.in
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.in header.i=linuxuser509@zohomail.in
 header.a=rsa-sha256 header.s=zoho header.b=p0LUN66t
Subject: [Intel-wired-lan] [PATCH net-next] net: e100: replace silent 'hope
 for the best' with debug message
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
From: Ashwin Gundarapu via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sun, 10 May 2026 15:09:12 +0530
Subject: [PATCH] net: e100: replace silent 'hope for the best' with debug
 message

Replace a silent return with a debug message when no MII PHY is
detected on known variants. This gives users visibility into the
failure instead of silently hoping for the best.

Found by checkpatch.pl inspection.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/ethernet/intel/e100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 9074b558de35..bfacf877ca40 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1450,7 +1450,9 @@ static int e100_phy_init(struct nic *nic)
 		 * But do this AFTER MII checking only, since this does
 		 * lookup of EEPROM values which may easily be unreliable. */
 		if (e100_phy_check_without_mii(nic))
-			return 0; /* simply return and hope for the best */
+                        netif_dbg(nic, probe, nic->netdev,
+                                  "No MII PHY detected, continuing anyway\n");
+                        return 0;
 		else {
 			/* for unknown cases log a fatal error */
 			netif_err(nic, hw, nic->netdev,
-- 
2.43.0
