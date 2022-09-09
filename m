Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B59ECAAA1
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Sep 2022 12:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD7A983EFE;
	Fri,  9 Sep 2022 12:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD7A983EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1662727841;
	bh=qIHTp+xB08CQrqMHvYaElrZBdH9wlKUa70YBetSR29U=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=J8OiQvLW9wb8zBL6Fr7fUvkwYMNAsi79F/Y1TwOji6335YiZ2Ew05vTbflwPDGimo
	 WnwTkTfp+yTs52ta5uCMxCTgYveBaE+hTxhHvaNLlGUvW/mC10oFKNcfFuQXCaAdcd
	 OFJSKVvD5Hs7Vg0fu9phhADRQVRKpcpvvuTVna1J/GW/+JKZ0k3ihkiFEklGGFRRum
	 3HpBkHjWo7ks3qsa3diQKYdrdGGHjfPUCJPmIVUGNnm8bXaiegRTn8PJCKeMERQKmC
	 HISglBAxWlfV8sKH2PUh92/jMhTlFhK2pMT/IKpK0Ey8M8cT/Z/FrpzHQ3r/aO06Mk
	 P9pzacN04Z3CA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s31aImY2zP4H; Fri,  9 Sep 2022 12:50:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96C3D83EFB;
	Fri,  9 Sep 2022 12:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96C3D83EFB
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6C3061BF369
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Sep 2022 03:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5361D830DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Sep 2022 03:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5361D830DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgK1fPBa9836 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Sep 2022 03:38:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68286830C5
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68286830C5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Sep 2022 03:37:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0VP7oAkp_1662694361; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VP7oAkp_1662694361) by smtp.aliyun-inc.com;
 Fri, 09 Sep 2022 11:32:45 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jesse.brandeburg@intel.com
Date: Fri,  9 Sep 2022 11:32:40 +0800
Message-Id: <20220909033240.46329-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 09 Sep 2022 12:50:35 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: Remove useless else if
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 intel-wired-lan@lists.osuosl.org, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The assignment of the else and else if branches is the same, so the else
if here is redundant, so we remove it and add a comment to make the code
here readable.

./drivers/net/ethernet/intel/iavf/iavf_main.c:2211:6-8: WARNING: possible condition with no effect (if == else).

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2106
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 1671e52b6ba2..e105ffeca074 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2208,9 +2208,7 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 		vlan_ethertype = ETH_P_8021Q;
 	else if (prev_features & (NETIF_F_HW_VLAN_STAG_RX | NETIF_F_HW_VLAN_STAG_TX))
 		vlan_ethertype = ETH_P_8021AD;
-	else if (prev_features & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_TX))
-		vlan_ethertype = ETH_P_8021Q;
-	else
+	else /* contains prev_features & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_TX) */
 		vlan_ethertype = ETH_P_8021Q;
 
 	if (!(features & (NETIF_F_HW_VLAN_STAG_RX | NETIF_F_HW_VLAN_CTAG_RX)))
-- 
2.20.1.7.g153144c

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
