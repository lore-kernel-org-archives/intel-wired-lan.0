Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277D8C19F29
	for <intel-wired-lan@archiver.kernel.org>; Fri, 29 Jul 2022 13:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF1C540A05;
	Fri, 29 Jul 2022 13:35:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF1C540A05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659101741;
	bh=ZKjmOThxtezyOmTw+TnIqaF7nIGIZzVXBLar+zoTQUU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vRwueCkakpQJtz0TaDhd4bOnGZTrLWNd7ygOOR8405Ujq01SMwxca6SwWdaANDY30
	 7ogSzIMS52eBEMzBNC6ivGYgpQeuS91ntbBVfwv1cmn7WlVac8x5RRGqzdFK4vCJpM
	 LqfehKdOSotnFMtEf7tzYPZp+9laQj6IP3+QtQ1oIQbM2XosjPlF0VFU9Re13dyyBN
	 AYbYU9qqKa2eD9w8KgEpv0kdq6/2Ca3ligPt32FOqL9L7lRBVLZ9Eji2UBBJjkLjJL
	 nyElysUb1TdpJDdgFfrIv4fUxHWv+60jJlouTrNsR+zce37QXPzIZu9fhs3egzP7MZ
	 IhOUJCCtooQ9w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fegVrR8g0nw; Fri, 29 Jul 2022 13:35:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B7C841812;
	Fri, 29 Jul 2022 13:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B7C841812
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 24B581BF288
 for <intel-wired-lan@lists.osuosl.org>; Fri, 29 Jul 2022 10:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3C6160E6D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 29 Jul 2022 10:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3C6160E6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JL-YHcFcRS6R for <intel-wired-lan@lists.osuosl.org>;
 Fri, 29 Jul 2022 10:25:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4466860B16
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4466860B16
 for <intel-wired-lan@lists.osuosl.org>; Fri, 29 Jul 2022 10:25:17 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvNqz0VZ4zlWQ6;
 Fri, 29 Jul 2022 18:22:39 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 18:24:51 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 18:24:50 +0800
From: Guangbin Huang <huangguangbin2@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <snelson@pensando.io>, <brett@pensando.io>,
 <drivers@pensando.io>, <anthony.l.nguyen@intel.com>,
 <jesse.brandeburg@intel.com>
Date: Fri, 29 Jul 2022 18:17:54 +0800
Message-ID: <20220729101755.4798-2-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220729101755.4798-1-huangguangbin2@huawei.com>
References: <20220729101755.4798-1-huangguangbin2@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 29 Jul 2022 13:35:27 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] net: ice: fix error
 NETIF_F_HW_VLAN_CTAG_FILTER check in ice_vsi_sync_fltr()
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
Cc: huangguangbin2@huawei.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 lipeng321@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jian Shen <shenjian15@huawei.com>

vsi->current_netdev_flags is used store the current net device
flags, not the active netdevice features. So it should use
vsi->netdev->featurs, rather than vsi->current_netdev_flags
to check NETIF_F_HW_VLAN_CTAG_FILTER.

Fixes: 1babaf77f49d ("ice: Advertise 802.1ad VLAN filtering and offloads for PF netdev")

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9f02b60459f1..bc68dc5c6927 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -433,7 +433,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 						IFF_PROMISC;
 					goto out_promisc;
 				}
-				if (vsi->current_netdev_flags &
+				if (vsi->netdev->features &
 				    NETIF_F_HW_VLAN_CTAG_FILTER)
 					vlan_ops->ena_rx_filtering(vsi);
 			}
-- 
2.33.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
