Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EAB109C028
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 15:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 877DE812AF;
	Wed, 25 Mar 2026 15:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SiKdrb0wXxS7; Wed, 25 Mar 2026 15:12:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52CAA812AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774451520;
	bh=sNiO1tOOzZPAzSYMCv/dEDIMcjY8ft8tB93nY+0ZPsg=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3xGzWrHfNwsR6ZoILcRd9R3ttgzoNZPBBn/IKWUihUoq4RDVB2DnSuv4PLOIRueTa
	 zONopfEIIKYuQNiBGisFXN44LVXNuihDaoNWsDt21IR+ljilDopt2i2M8Bxf6znPoq
	 0jpey8+BuLouehcgejf6kzd0wlVJed/sSuQYsHioqtYeiL5Yob0JDMvPPcgUcr+fzq
	 GhoXcA7K5B2A/uHoayqxWxsLRNx1RDwiwrcDyoCSn7jZUFlG5UQ0e65RQofEHNfznm
	 Poz51zUWYQmluH3VcFAdOojncv0DYoLPtKHr6zXRKXy3uMsuMcd5JVYTsySuaEmake
	 eFLKA/OOIjpMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52CAA812AB;
	Wed, 25 Mar 2026 15:12:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 977A2353
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DAF94094A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZtox_Pyy9VP for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 15:11:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.108.111.100;
 helo=mail.amicon.ru; envelope-from=ade@amicon.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 84991408AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84991408AD
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84991408AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:11:57 +0000 (UTC)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 25 Mar
 2026 18:11:54 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Date: Wed, 25 Mar 2026 18:02:20 +0300
Message-ID: <20260325151132.1399812-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
References: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.2.46]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail;
 c=simple/simple; 
 t=1774451514; h=from:subject:to:date:message-id;
 bh=AE2guXMBp5DQPNbyJ1WdoFUb172juDOs9bZKDoSilTQ=;
 b=EXaqtQB8KUspwu79iQIwBlh7uPDjwVNXL27lIYm1NdEKxdsJNzPjIToBnw9JESsy7HSIAO5HumS
 FpYEIVrVHHuRKJ2dp5c6JHN0Zi4YzCo7XqfK8FbkN2JKx98VqId1tKgbV8WXNhuf9+U3EG4+LI1+i
 yNsfeym+UQYduB57J7lksJltmgV86fSXZ3ek8PLtZQ1LL8I2Z0Rs+pSq8FABwl09FMPoKy0RWUMOL
 n7ziIINxNWFSSHXGnCsqjG0iWnPzIqiUwpwds3EIf/vePzmlQwn4Rhoau0C5u9Bjh8goNdgLQjE8L
 3HN0Cyzm0aAwbKPuqHzG3eBNGJmJgwt5ZYPw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amicon.ru
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256
 header.s=mail header.b=EXaqtQB8
Subject: [Intel-wired-lan] [PATCH net v2] e1000: check return value of
 e1000_read_eeprom
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
e1000_set_eeprom() performs a read-modify-write operation when the write
range is not word-aligned. This requires reading the first and last words
of the range from the EEPROM to preserve the unmodified bytes.

However, the code does not check the return value of e1000_read_eeprom().
If the read fails, the operation continues using uninitialized data from
eeprom_buff. This results in corrupted data being written back to the
EEPROM for the boundary words.

Add the missing error checks and abort the operation if reading fails.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
v2:
 - Split from original series.
 - Updated the error checking logic to be consistent with the
   implementation in the e1000e driver.

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index ab232b3fbbd0..a9c56505adcb 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -506,6 +506,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 					    &eeprom_buff[last_word - first_word]);
 	}
 
+	if (ret_val)
+		goto out;
+
+
 	/* Device's eeprom is always little-endian, word addressable */
 	for (i = 0; i < last_word - first_word + 1; i++)
 		le16_to_cpus(&eeprom_buff[i]);
@@ -522,6 +526,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	if ((ret_val == 0) && (first_word <= EEPROM_CHECKSUM_REG))
 		e1000_update_eeprom_checksum(hw);
 
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
-- 
2.51.0

