Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD03C433EF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jun 2022 15:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E0194196A;
	Tue, 21 Jun 2022 15:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E0194196A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1655825475;
	bh=x/dH9gLNrMUJjENqYWQP9aGDgrftzTG66E6CDFD6/TI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=9AIyKpU8zcwFLV7MQ8fBtnri/INI8IqPeDzb8EMqc2H6wg1GfuhHYuRO4xhHeMRiq
	 pOKvtZsCIeJI4Iq6xGsWIqRibcO50E3bKppy+oC42xh4PuhCStS1aASlWh8Yk7S0A1
	 QpOxugoUvCcQAx8TBjrx9A1NfkxcqeeylIifwXJXNXjQa/fL3kSTGMbxZNUtG26pYl
	 lgrHNqMPfOGcQ6EC+hLgCUO26X+AJjhPzPy+lXQhG29PL0w8w7NSjeRb7+UC5qdaN5
	 HgMp9jcUY1yqplAaAO73MZdq81lxoml34WLUOdcKGVZLPFcxDwH815SDMCQkPV8QfY
	 Utwqrlwq4c2WA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmC2ntRmWNwp; Tue, 21 Jun 2022 15:31:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B16E418FE;
	Tue, 21 Jun 2022 15:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B16E418FE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2CC291BF5DB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jun 2022 08:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF45240BB2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jun 2022 08:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF45240BB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EH7TW_BaQRQ1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jun 2022 08:34:04 +0000 (UTC)
X-Greylist: delayed 00:06:35 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5A35404EB
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5A35404EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jun 2022 08:34:03 +0000 (UTC)
X-QQ-mid: bizesmtp84t1655800307tp96dari
Received: from ubuntu.localdomain ( [106.117.99.68])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 21 Jun 2022 16:31:42 +0800 (CST)
X-QQ-SSF: 01000000007000209000B00A0000000
X-QQ-FEAT: 0VgNaGdhy9i3VEgTjda6YTeTUjwUfOcImznDL6T2LXaZA2NbnSfXY1kzYj4wX
 t4P4vhDP0uFEgNKYWsiYzOWMCHw/oep9gTTRwmXEi+9fjX+I2c73H0oaXT3LQ4/fbPX8kDd
 48m7ZLETi83rkgCTaPCq5BbS5BmIlP29LhhA7xL5ua1kiuKqYg8lzawQ20Rtr0Uy0reliM2
 ndcX/2Luky4X4Pb9dsOIVx67CvUzjnLs5CWsFN47jR98iH8N3KLLGFgycF8usTl4QuS4dlK
 NOw5CnXyy2nqCB/fviIu1Rc5iqmHa6h7gMaS7k80Gyd4Ynti4HaNZWm3362I4A2QMxrWn99
 206wO8pIWtxTJWS/XI=
X-QQ-GoodBg: 0
From: Jiang Jian <jiangjian@cdjrlc.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Date: Tue, 21 Jun 2022 16:31:40 +0800
Message-Id: <20220621083140.54004-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Mailman-Approved-At: Tue, 21 Jun 2022 15:31:12 +0000
Subject: [Intel-wired-lan] [PATCH] igb: remove unexpected word "the"
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 jiangjian@cdjrlc.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

there is an unexpected word "the" in the comments that need to be removed

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index cbe92fd23a70..8d6e44ee1895 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2207,7 +2207,7 @@ s32 igb_write_phy_reg_82580(struct e1000_hw *hw, u32 offset, u16 data)
  *  igb_reset_mdicnfg_82580 - Reset MDICNFG destination and com_mdio bits
  *  @hw: pointer to the HW structure
  *
- *  This resets the the MDICNFG.Destination and MDICNFG.Com_MDIO bits based on
+ *  This resets the MDICNFG.Destination and MDICNFG.Com_MDIO bits based on
  *  the values found in the EEPROM.  This addresses an issue in which these
  *  bits are not restored from EEPROM after reset.
  **/
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
