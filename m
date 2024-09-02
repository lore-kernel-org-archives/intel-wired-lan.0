Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E4CCD342A
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Sep 2024 15:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 914C6607B2;
	Tue,  3 Sep 2024 15:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhlEWDmNSowU; Tue,  3 Sep 2024 15:02:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72610606A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1725375747;
	bh=pDGjPAsvGhFBZy+JgYt1ubN/rCEHAsdnswlCu3ZNTv4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=n4P84g4Ly0AOBQLb9YX1XtVy/X3u0IvQxCenknrvfILCeIDPa+HBb0KrafdMzkz0L
	 eA1jAEFIpFQYcl5D5OxN79OmIWcbVrCNiwdcniYqiq9wtWb6/dtpBWdxxTBhMBTE9i
	 mtxDB9YonQZy5Wft5fiJIjIeTxQus/h86ix1HxX9v3wKF/TGT61v5EIrh32MZ4CjT/
	 WvA+30lOK0eU2Am4s/0l3gB+EAAfVHxzK33ChTDd+lzlL9XUYTHHGnqzSYPGc69gob
	 HdfOlYK93Uc/jpUEYvI3fauoKWD+EQldHLA0/zj2HFnswFvgyXrQdd5gnb8owg4hY7
	 ekzt81Itsehhg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72610606A9;
	Tue,  3 Sep 2024 15:02:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 59CD91BF414
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Sep 2024 13:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46489404C2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Sep 2024 13:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qdzhF0oJJvcc for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Sep 2024 13:24:07 +0000 (UTC)
X-Greylist: delayed 1097 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 02 Sep 2024 13:24:05 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7F75A403CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F75A403CC
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.189;
 helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com;
 receiver=<UNKNOWN> 
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F75A403CC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Sep 2024 13:24:05 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wy84v5BNVz69Ms;
 Mon,  2 Sep 2024 21:00:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
 by mail.maildlp.com (Postfix) with ESMTPS id 2755B1402DE;
 Mon,  2 Sep 2024 21:05:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 21:05:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <anthony.l.nguyen@intel.com>
Date: Mon, 2 Sep 2024 21:14:07 +0800
Message-ID: <20240902131407.3087903-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-Mailman-Approved-At: Tue, 03 Sep 2024 15:02:25 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=huawei.com
Subject: [Intel-wired-lan] [PATCH net-next] ice: Make use of assign_bit() API
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
Cc: przemyslaw.kitszel@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, lihongbo22@huawei.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

We have for some time the assign_bit() API to replace open coded

    if (foo)
            set_bit(n, bar);
    else
            clear_bit(n, bar);

Use this API to clean the code. No functional change intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 46d3c5a34d6a..e3ad91b3ba77 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6522,8 +6522,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 	if (changed & NETIF_F_HW_TC) {
 		bool ena = !!(features & NETIF_F_HW_TC);
 
-		ena ? set_bit(ICE_FLAG_CLS_FLOWER, pf->flags) :
-		      clear_bit(ICE_FLAG_CLS_FLOWER, pf->flags);
+		assign_bit(ICE_FLAG_CLS_FLOWER, pf->flags, ena);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
-- 
2.34.1

