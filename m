Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA03EE4996
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Aug 2023 15:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15AF1405A6;
	Mon, 21 Aug 2023 15:14:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15AF1405A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692630863;
	bh=1wwsuHGVIrcthd1qmxoSYGV7ZpiCCYXN074k9kluKA4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=s6+DsI0sJmECVEv0++bDx8hVBdXbfi+8Sc/3Sg6XWjNxRMb0UqjynMzWAXGtrt1JU
	 GRNZdTcel7FKDrEyHFh67oChyT6RPcS6vn85ZaZhgFHN0a9hRK4z8o0vBAvBjdJzlE
	 n3vMV9Dxc9cEGqL6IaDfDnsrqdvATDtQFsYIR6QFLx8WWn6lmmL15RHwsVSHjrRpN9
	 3tQpTjkdp2ZpcmUdwTBE7YpBx5PDKTA8zy9HuBgNalTMSwoyToigf0I3VgarConJet
	 vbgN/1GySEqBXc1sLByWR70ndw170mA7lEE7llSPEGmXSJH/R/C27KyWpBhqn3+Hjj
	 7Zu5o1hb+FSew==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fn3_ZYZ3zXEI; Mon, 21 Aug 2023 15:14:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9A2140857;
	Mon, 21 Aug 2023 15:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9A2140857
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 52C511BF2F2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Aug 2023 13:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AE5260BCB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Aug 2023 13:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AE5260BCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWsskR5hR6gX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Aug 2023 13:43:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E62E960AE3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Aug 2023 13:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E62E960AE3
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTtrQ549VzLpNv;
 Mon, 21 Aug 2023 21:39:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:42:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Date: Mon, 21 Aug 2023 21:42:29 +0800
Message-ID: <20230821134229.3132692-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 21 Aug 2023 15:14:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ethernet/intel: Use
 list_for_each_entry() helper
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
Cc: ruanjinjie@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Convert list_for_each() to list_for_each_entry() where applicable.

No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c      | 7 ++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9f63a10c6f80..bf9c2f6a1164 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7850,7 +7850,6 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
-	struct list_head *pos;
 	struct vf_mac_filter *entry = NULL;
 	int ret = 0;
 
@@ -7871,8 +7870,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 	switch (info) {
 	case E1000_VF_MAC_FILTER_CLR:
 		/* remove all unicast MAC filters related to the current VF */
-		list_for_each(pos, &adapter->vf_macs.l) {
-			entry = list_entry(pos, struct vf_mac_filter, l);
+		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
@@ -7882,8 +7880,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 		break;
 	case E1000_VF_MAC_FILTER_ADD:
 		/* try to find empty slot in the list */
-		list_for_each(pos, &adapter->vf_macs.l) {
-			entry = list_entry(pos, struct vf_mac_filter, l);
+		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
 			if (entry->free)
 				break;
 		}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 29cc60988071..4c6e2a485d8e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -639,12 +639,10 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
 	struct vf_macvlans *entry;
-	struct list_head *pos;
 	int retval = 0;
 
 	if (index <= 1) {
-		list_for_each(pos, &adapter->vf_mvs.l) {
-			entry = list_entry(pos, struct vf_macvlans, l);
+		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
@@ -664,8 +662,7 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 
 	entry = NULL;
 
-	list_for_each(pos, &adapter->vf_mvs.l) {
-		entry = list_entry(pos, struct vf_macvlans, l);
+	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
 		if (entry->free)
 			break;
 	}
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
