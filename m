Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C74AE91295
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 08:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB60480E55;
	Thu,  5 Feb 2026 08:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQLENb_HHNLn; Thu,  5 Feb 2026 08:50:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 551F980E4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770281458;
	bh=vzZSPwzsQrlN833+ulO08E4OEkrP3Y5ctEKzjtV2B+Q=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qcz8KKKuOwPYfyjRTnOOhjBbkTHhz/o38m2BZJ7OoJ6YWG5VHkhr/8b/SbD0hOdva
	 wZvO4l0ZDfJ7xtg0UBA/qHAiVLIolmfHmoPZ7ZjNTYzOBPT2gjFUxR91vM0p3T9yEP
	 xmc+9QmAWgGQIwzzD07kU300pcyLXRAcOmX6KBc5CH5LbHTDUZo7ScLxkULM2IVqcT
	 81AB7spAvYAYJekjdelmjOdPiOslSEM2ffaEz5SQDu5L33VdlwQbqT4kmsqxZQQk0c
	 Tm6Lqa26jJAex1aduC5zKc5H/+h5SSjfnNgHJFTsHMlqPjHOMxq/WBvTGGugNYHmnR
	 6PPinuJnMgiPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 551F980E4D;
	Thu,  5 Feb 2026 08:50:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56489F5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 08:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 444CE40B8D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 08:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAUhdS06E41X for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 08:50:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 12ED640B5E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12ED640B5E
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12ED640B5E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 08:50:55 +0000 (UTC)
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6158oWoE095645
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 5 Feb 2026 17:50:33 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>
Date: Thu,  5 Feb 2026 08:50:26 +0000
Message-ID: <20260205085030.60080-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=vzZSPwzsQrlN833+ulO08E4OEkrP3Y5ctEKzjtV2B+Q=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1770281433; v=1;
 b=qHbkn/Xhh5GCW3lqtt3BFNbRWW2diSTeAbyG65f/JYW0cpqRPrvOWQfIqoP9ADEk
 xtXMlputaR8IBEMaPyQ0yZJS7/cnJHY0v/edvAP9nO+3zE2eEhmcHODVYMGjkG6o
 hOxhNtQeP+1MQ1JClMAJp6inMhph9FdxS0ta3QbbNTkCrV5+W7G+wtXlKziqqdih
 OMhQjz2d+pysDFsaqGqaCMDLCLV92fMGb/ORDuKBtbCPTYHWOZ+E1rsgreVjGWLz
 vZeYjkDgLCDRfP6YcbveoWH891MTrgHKjZwMdp3WJ6L70qdtww0XJLENEkgj1QTK
 XA8ezhbJ8QIZURItM1FPZA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=qHbkn/Xh
Subject: [Intel-wired-lan] [PATCH v1 iwl-net] igc: fix null pointer
 dereference in igc_eeprom_test() on NVM-less devices
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

On devices without NVM, hw->nvm.ops.validate is set to NULL, therefore
functions that perform EEPROM-related operations such as
igc_ethtool_set_eeprom() and igc_probe() check for NVM presence in
advance. However igc_eeprom_test() unconditionally calls
hw->nvm.ops.validate(), potentially causing a null pointer dereference.

NVM-less devices may not be common but possible, so add NULL check
before calling hw->nvm.ops.validate().

Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244ee70..973d26a5a6c9 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -158,7 +158,7 @@ bool igc_eeprom_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	if (hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
+	if (hw->nvm.ops.validate && hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
 		*data = 1;
 		return false;
 	}
-- 
2.51.0

