Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A8DC4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Nov 2022 16:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E55540B51;
	Tue, 22 Nov 2022 16:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E55540B51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669133319;
	bh=nMfEmkHfQPFzr3y+dwQZkdZqEnpeguTXCXPSsTr9aCY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=87xoKx8a3X7h1H64R7J9qtWodGtnIAZLg0LD/UzeLuCCCYuFTIoOlFD/tNVpLpkD5
	 2XnPphQLCIq14m7t/lTRdnbTREhgP8LzAO+mN0yIw2gNGNG+rPHyYPxqAZfBUwGUFa
	 irBkGdMAPfWtuZufKux5M/5D5kpYdLKTJtQ89G8WPOHq5y910i0G+gnDV6ncuOL79d
	 Tuntadi7gSTZBsHuZoA4WIr1xHpyD1iXnswanuTJRftDy19D+eI9lbgEMOFDnPDah5
	 enfI2rgJen/YWvvIfwbWeY8Sw5+E0M6FH1f35YVVN/aIugyWbLDsVL507PCQHlqR8w
	 oHIEfQew7cCjw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K_av4kZyeVfB; Tue, 22 Nov 2022 16:08:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A01F540B13;
	Tue, 22 Nov 2022 16:08:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A01F540B13
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3F9A91BF37A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 02:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A6A481324
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 02:28:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A6A481324
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9njgCE6Irw7o for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Nov 2022 02:28:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4AE8812C9
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4AE8812C9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Nov 2022 02:28:57 +0000 (UTC)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGSqC71TZz15MwY;
 Tue, 22 Nov 2022 10:28:23 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:28:52 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <alexander.h.duyck@intel.com>,
 <jeffrey.t.kirsher@intel.com>, <cuigaosheng1@huawei.com>
Date: Tue, 22 Nov 2022 10:28:52 +0800
Message-ID: <20221122022852.1384927-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:08:37 +0000
Subject: [Intel-wired-lan] [PATCH net,
 v2] intel/igbvf: free irq on the error path in igbvf_request_msix()
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

In igbvf_request_msix(), irqs have not been freed on the err path,
we need to free it. Fix it.

Fixes: d4e0fe01a38a ("igbvf: add new driver to support 82576 virtual functions")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 3a32809510fc..72cb1b56e9f2 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1074,7 +1074,7 @@ static int igbvf_request_msix(struct igbvf_adapter *adapter)
 			  igbvf_intr_msix_rx, 0, adapter->rx_ring->name,
 			  netdev);
 	if (err)
-		goto out;
+		goto free_irq_tx;
 
 	adapter->rx_ring->itr_register = E1000_EITR(vector);
 	adapter->rx_ring->itr_val = adapter->current_itr;
@@ -1083,10 +1083,14 @@ static int igbvf_request_msix(struct igbvf_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  igbvf_msix_other, 0, netdev->name, netdev);
 	if (err)
-		goto out;
+		goto free_irq_rx;
 
 	igbvf_configure_msix(adapter);
 	return 0;
+free_irq_rx:
+	free_irq(adapter->msix_entries[--vector].vector, netdev);
+free_irq_tx:
+	free_irq(adapter->msix_entries[--vector].vector, netdev);
 out:
 	return err;
 }
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
