Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ABFC77B7A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 May 2023 08:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EF2D60E5C;
	Fri, 19 May 2023 08:39:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EF2D60E5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684485554;
	bh=Qw5B4TPwSOyiyAMFSpakyRkkf1u2gp3x1H++SgyEWVs=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=IWODAfgsn7tgfynYBarGyADuXPY1bw7rhfIKSBR2ErTkkiJVpkyO4o4oGhPxgKJnh
	 3Px9AB8hDJecH0AYg7Yp3mPvVLN4fDU1K9VW/dOCZy6dCJNyKXzRATw+xvraN4VDsr
	 M885x8diOsvNAgLZAhudvjZgjbs7T3UCF+i1WCeqG7vCx8bQty7JDYWLeR3NJMdshj
	 FTlgjg4mGPFAATA9ExB5Y7U0NnoC7TMJxBwcllwksMm6Z//+QQGNMsYgCxOMCjEF5S
	 ga3yv7Bpp92BMVi9PZ/oQbILMGE65BsnnUkspFTeGHvRRB0s+CcAe/nz+iTnS0bAel
	 agUtphOmABS6g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1nf5dXb__JE; Fri, 19 May 2023 08:39:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C8D460F7C;
	Fri, 19 May 2023 08:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C8D460F7C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 81F1C1BF419
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 May 2023 08:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 679A240494
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 May 2023 08:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 679A240494
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3XrV8FkWtKOQ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 May 2023 08:39:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94E44400DA
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94E44400DA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 May 2023 08:39:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0Vj-4ra6_1684485529; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0Vj-4ra6_1684485529) by smtp.aliyun-inc.com;
 Fri, 19 May 2023 16:39:02 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jesse.brandeburg@intel.com
Date: Fri, 19 May 2023 16:38:48 +0800
Message-Id: <20230519083848.58828-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
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
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5255
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2de4baff4c20..cf8538cebfe0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2200,8 +2200,6 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 		vlan_ethertype = ETH_P_8021Q;
 	else if (prev_features & (NETIF_F_HW_VLAN_STAG_RX | NETIF_F_HW_VLAN_STAG_TX))
 		vlan_ethertype = ETH_P_8021AD;
-	else if (prev_features & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_TX))
-		vlan_ethertype = ETH_P_8021Q;
 	else
 		vlan_ethertype = ETH_P_8021Q;
 
-- 
2.20.1.7.g153144c

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
