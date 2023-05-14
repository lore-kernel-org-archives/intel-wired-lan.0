Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACFC77B7D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 May 2023 15:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4107C41D67;
	Mon, 15 May 2023 15:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4107C41D67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684163579;
	bh=6Il0ka2fJU5IVgVIyTxuFfkKouQRvA5cvYR+BcvGi4I=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PMDKIaHzDierN9tQMlwYfDa4AHqVVLZWfjjjv8BM356mhipAbNMU3s4NPgPmAfmIG
	 Dqe543NbcwInc0IoLXdt/ZiXS7VONeDdQ8VYjl3K2a3qQGg96a5sKtUeJ5fjVkIieC
	 BOW/kZF7jKafJInSfGQw6vg958rU16Jbe9oBw+j+VL1Kj3w39J7Ya36WJOXJpSP9Qa
	 6tXQYx4BM/90gZBSIBd7qkPvrUY1Vk/vCsn+jzS3w573qAdzPQib2h7BJ3REGkgWzz
	 h8AoheJioJZTLz75g6L8b5B63iT9Etka0YDNqxF7OLk8eKBDBk3VlLGijQUReTnTGB
	 zMnYkLVBLzSDw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lmt6iw8jhwkN; Mon, 15 May 2023 15:12:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3CCEA41D59;
	Mon, 15 May 2023 15:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CCEA41D59
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D4DCE1BF41D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 May 2023 09:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A927A40586
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 May 2023 09:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A927A40586
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o9-4mfmL3K_g for <intel-wired-lan@lists.osuosl.org>;
 Sun, 14 May 2023 09:35:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CE694013C
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CE694013C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 May 2023 09:35:34 +0000 (UTC)
Received: by air.basealt.ru (Postfix, from userid 490)
 id 51F532F2022E; Sun, 14 May 2023 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [176.59.56.94])
 by air.basealt.ru (Postfix) with ESMTPSA id 484C52F20227;
 Sun, 14 May 2023 09:35:27 +0000 (UTC)
From: kovalev@altlinux.org
To: kovalev@altlinux.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
 sasha.neftin@intel.com, jeffrey.t.kirsher@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 14 May 2023 12:34:28 +0300
Message-Id: <20230514093428.113471-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.6
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 May 2023 15:12:52 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Add "cnp" PCH boards to the
 packet loss fixing workaround
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Vasiliy Kovalev <kovalev@altlinux.org>

Add CannonLake and some Comet Lake Client Platform into the range
of workaround for packet loss issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217436
Fixes: 639e298f432fb0 ("e1000e: Fix packet loss on Tiger Lake and later")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 9466f65a6da77..e233a0b93bcf1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4875,7 +4875,7 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	/* Enable workaround for packet loss issue on TGP PCH
 	 * Do not gate DMA clock from the modPHY block
 	 */
-	if (mac->type >= e1000_pch_tgp) {
+	if (mac->type >= e1000_pch_cnp) {
 		fflt_dbg = er32(FFLT_DBG);
 		fflt_dbg |= E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK;
 		ew32(FFLT_DBG, fflt_dbg);
-- 
2.33.6

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
