Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70375F588C2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Apr 2026 13:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1735E61114;
	Mon, 20 Apr 2026 13:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUUBwG8TnDjL; Mon, 20 Apr 2026 13:16:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 297E161111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776690982;
	bh=vyYjCbh4hfy8ck7jhn4MmvniDqQsTjyG82RU6rIKd5E=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFowRJJSMD1lNnu2gmI7xT5LP0ODSa7crULLEHYadD6K+iQcaMJEQ/9MPZHBdn4Vk
	 sMEUlDWA29qgQs5noUKy0H0PK7V3MH6sh3jyT3EdacZSBgci/LUgSZtY0OcICGjc3H
	 uh5Y3PJeP4TI9uslIIVAdKnEyY0kKvLVwEs7ft8O/hLc85018q1U9+l6T9/Za8iSfE
	 STKr+b/hisTv5BoAq+Gos4UxXngdvGMhrMpEukLyWKphde/K7EtamujSAKvxd1nD53
	 BoWIk4w9zVoRQdV3bZ4whRdVCVlxqe2S7La1vHbpApPtnQF5Vuqyso+oWw5TCw3pQV
	 7dllYbstG13Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 297E161111;
	Mon, 20 Apr 2026 13:16:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 049D1259
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA1DD40514
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kEkDpT9rARts for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Apr 2026 13:16:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 27DD340261
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27DD340261
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27DD340261
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 13:16:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AB6D7418AD;
 Mon, 20 Apr 2026 13:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B71C2BCF6;
 Mon, 20 Apr 2026 13:16:16 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Agalakov Daniil <ade@amicon.ru>, Iskhakov Daniil <dish@amicon.ru>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Sasha Levin <sashal@kernel.org>,
 jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 09:08:08 -0400
Message-ID: <20260420131539.986432-22-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776690978;
 bh=49HN6o4yrsP/WG3TNcVwqMVx1kYceSAQjTh2AygBxfk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cqdZgMY8OvAgJFp3z9cW5IWD8UEHaBY8Uvnn8ROOOnxVIBbjrD1bvMK1tFpts+ue7
 qh3G+7Nn0YBabBCA8jAFznzZ1sJ6RFoLJNo8t4Vuu3SHagFJoPvqEuRKMzWkM9Ph0U
 jZ+70Gy6z3ve+EMLQmFCqhx5KApX0GxxYNP3lBnqm2MKEhulpfN6zmIRHHhVsBVo3I
 IKFrQM1bpYsOuX8FOp51K7Il/sU5ws9z6ROWUXJaY2Eg3eWJsLa3fTTbQswmVLGlEz
 ruJNbK8KR+YrF8CHd0G4y5Qx9Bzj/kMtwCepJRyeMNrW+7syvBCs3enWkJMBXEOZjX
 I3iLElrGcsaWw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cqdZgMY8
Subject: [Intel-wired-lan] [PATCH AUTOSEL 6.18] e1000: check return value of
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

From: Agalakov Daniil <ade@amicon.ru>

[ Upstream commit d3baa34a470771399c1495bc04b1e26ac15d598e ]

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 726365c567ef3..75d0bfa7530b4 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -496,14 +496,19 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, first_word, 1,
 					    &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
+	if ((eeprom->offset + eeprom->len) & 1) {
 		/* need read/modify/write of last changed EEPROM word
 		 * only the first byte of the word is being modified
 		 */
 		ret_val = e1000_read_eeprom(hw, last_word, 1,
 					    &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 	}
 
 	/* Device's eeprom is always little-endian, word addressable */
@@ -522,6 +527,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	if ((ret_val == 0) && (first_word <= EEPROM_CHECKSUM_REG))
 		e1000_update_eeprom_checksum(hw);
 
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
-- 
2.53.0

