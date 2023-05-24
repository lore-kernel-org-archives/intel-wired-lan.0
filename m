Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD673C77B73
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 May 2023 10:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D34861144;
	Wed, 24 May 2023 10:02:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D34861144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684922542;
	bh=G95CPPJE2LtSWz5aNEQxbvYLaz9KiS6XlY0hrv+aupc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=lshzEFrQpsuDoBdLpGKKsnTkLGtr+YQ3XnflFrtxKUuRTyUmgjeMObNc0kmyeylCN
	 zSyP0XhgraeQyXbpgN6lPaiUd77HqDt6VVtL55l5CmAnfh3LDvSYLC3k9y8OgWYSDt
	 buSxPK8dQNWLbRHmY5bcclEesrTqFarBW74ch965rbMFlci69Ot3k2a8O5wXRJW9cn
	 sgtBBW3q9TmLjXxa2UCcHAUlP11nvUz+B0SUU+mgJIsNrL111sM+PkDA6Gbr+9p7so
	 jq9em2Y/PBmSGcU5EYthdoJeAWZQkp9mjW2PvWCfySOcJx09DSXVsYVAl5hJpSfKmw
	 J55oF7jA6pF2w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QpXJvUn479hH; Wed, 24 May 2023 10:02:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A69761174;
	Wed, 24 May 2023 10:02:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A69761174
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8413F1BF38C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 May 2023 10:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65AA761174
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 May 2023 10:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65AA761174
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S4HiYEX8ZySE for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 May 2023 10:02:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 886C661144
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 886C661144
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 May 2023 10:02:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0VjNdztr_1684922526; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VjNdztr_1684922526) by smtp.aliyun-inc.com;
 Wed, 24 May 2023 18:02:11 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jesse.brandeburg@intel.com
Date: Wed, 24 May 2023 18:02:03 +0800
Message-Id: <20230524100203.28645-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Subject: [Intel-wired-lan] [PATCH v2] iavf: Remove useless else if
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
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The assignment of the else and if branches is the same, so the if else
here is redundant, so we remove it.

./drivers/net/ethernet/intel/iavf/iavf_main.c:2203:6-8: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5255
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Add a comment.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2de4baff4c20..da5011359425 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2200,9 +2200,9 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 		vlan_ethertype = ETH_P_8021Q;
 	else if (prev_features & (NETIF_F_HW_VLAN_STAG_RX | NETIF_F_HW_VLAN_STAG_TX))
 		vlan_ethertype = ETH_P_8021AD;
-	else if (prev_features & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_TX))
-		vlan_ethertype = ETH_P_8021Q;
-	else
+	else /* The branch cover "else if (prev_features & (NETIF_F_HW_VLAN_CTAG_RX |
+	      * NETIF_F_HW_VLAN_CTAG_TX))"
+	      */
 		vlan_ethertype = ETH_P_8021Q;
 
 	if (!(features & (NETIF_F_HW_VLAN_STAG_RX | NETIF_F_HW_VLAN_CTAG_RX)))
-- 
2.20.1.7.g153144c

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
