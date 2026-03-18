Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED56103E197
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 15:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1541940C38;
	Wed, 18 Mar 2026 15:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgvApKZKwIld; Wed, 18 Mar 2026 15:16:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A89E240C16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773846983;
	bh=w2XoeCRrsLq58FPrSx00MG5aEZc6oKuZ6kVe2aN7jA4=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NfGHCERO7RD90nXC2Wv+7PXAbPJ0R9VzRoWQ69Rs7I2YlxwnshdYvc0RPCbOdbuMU
	 cKqWf/Dxge/khOddZ96St5/AAO/dJu6RgIiroWU0Py621qDn7l2Rixzk0a5CDc0a97
	 Fs5EdojVP6hnDLnIlqLYOTpsR2Da74FCaHtb32t4/qCuEmn+5a6tmKW6TxuLUO8E8A
	 h2IsPldwr3dyp/EZsPSj31DBR2YXFtN2aLI+nQxhPaMCto80C6+L0in38jU/YDNHoo
	 RzJpvJkoOyTORwD1J3dX4JiLIf4FIjgJE0uxw06T3g01biaNkDqMxCQQprlkbDeyux
	 igosOsXkhlb2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A89E240C16;
	Wed, 18 Mar 2026 15:16:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 090791AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 12:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA88583BA6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 12:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GNRwGDxo8SpK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 12:20:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.108.111.100;
 helo=mail.amicon.ru; envelope-from=ade@amicon.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 647F883BB4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 647F883BB4
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 647F883BB4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 12:20:47 +0000 (UTC)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Mar
 2026 15:05:31 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Date: Wed, 18 Mar 2026 15:05:07 +0300
Message-ID: <20260318120512.687149-4-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318120512.687149-1-ade@amicon.ru>
References: <20260318120512.687149-1-ade@amicon.ru>
MIME-Version: 1.0
X-Originating-IP: [172.16.2.46]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:16:20 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail;
 c=simple/simple; 
 t=1773835531; h=from:subject:to:date:message-id;
 bh=XZen40Yk+QoMIT6s4hnv4GEbtv6HyjqcTqgr8GMETfI=;
 b=KarlrZZHrsoqSVRJAFH0BUR8rZgVSwlvrDy97U52GJXk15tmNkczjrtdFai1urFpF38fGgSGoLq
 OAnjIUpfI4Lq4gEK+D2g/C18jZ4LYIsnS7A0cnjUQlzhaSvOy4t3+yMDx/OZHAVwVMMRYVLzmGz0F
 8tLGyj9tcebnFFyc402qWvT8Z0+GFFPQNcNt5yShTF7W3tWBDxOi2U9Im89o2jmGlU3FbiTVAHRmb
 MnXaUzgwadhBUY1Is9YVmQKTmSXWhCqBMH+/d8zCUF8EtKAKXQhIaQBtLcNgnJsnIIA1yWpZMyB1I
 OTK/D+yOr5uT6FYggJyw/tnJUKYjpekPAr1w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amicon.ru
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru
 header.a=rsa-sha256 header.s=mail header.b=KarlrZZH
Subject: [Intel-wired-lan] [PATCH net 3/3] e1000e: fix endianness conversion
 of uninitialized words
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

[Why]
In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
words. However, only the boundary words (the first and the last) are
populated from the EEPROM if the write request is not word-aligned.
The words in the middle of the buffer remain uninitialized because they
are intended to be completely overwritten by the new data via memcpy().

The previous implementation had a loop that performed le16_to_cpus()
on the entire buffer. This resulted in endianness conversion being
performed on uninitialized memory for all interior words.

Fix this by converting the endianness only for the boundary words
immediately after they are successfully read from the EEPROM.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index dbed30943ef4..a8b35ae41141 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -583,20 +583,25 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		/* need read/modify/write of first changed EEPROM word */
 		/* only the second byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, first_word, 1, &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
+
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (!ret_val))
+	if ((eeprom->offset + eeprom->len) & 1) {
 		/* need read/modify/write of last changed EEPROM word */
 		/* only the first byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, last_word, 1,
 					 &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 
-	if (ret_val)
-		goto out;
-
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	memcpy(ptr, bytes, eeprom->len);
 
-- 
2.51.0

