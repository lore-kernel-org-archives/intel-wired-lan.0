Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2F2C001B0
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Aug 2023 10:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C337760B9B;
	Fri, 11 Aug 2023 10:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C337760B9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691751034;
	bh=DLWdnNJIWjeAIsWw9EG6N9G3YNKmxRopO9LL94EaijQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=iVRrB6OkoNJGnm+3RohPWShA+U4e+7NzxAwssjEXVtb1Z6X7gXlsEUnhRvbUs1qcS
	 D7XQv2w13wPIWKGbKqGgscmdtSjtjLBNnvBctSYBaBMMa9SygrubqA0zUSpI87oNAd
	 FCfAG3V0fxOF5G7V4DrvJomsb5Prcqah5kIvT/D07LU5+nQM9ftYicHiGvvFbT9wh7
	 w73XfsXZFhzrv1r0ilxqpFnxxMlpVrPD+Sn2/9q85aHquJp63784zSWFoZRbTCDDf8
	 AT2yquuJHMdCGppyDu3nrR4MGgRLJBDCafPxByfCzwYIvPanpqtiv+i6vYUt9oOo7H
	 PCc8AdqwuBF0w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKaSpY_AyQPt; Fri, 11 Aug 2023 10:50:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C47E260D77;
	Fri, 11 Aug 2023 10:50:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C47E260D77
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E06E51BF289
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Aug 2023 10:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B432641D77
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Aug 2023 10:50:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B432641D77
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o45QrRQK0zPr for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Aug 2023 10:50:30 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D16134160F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Aug 2023 10:50:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D16134160F
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RMgVC6FWGzqSff;
 Fri, 11 Aug 2023 18:47:31 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:50:23 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <yuehaibing@huawei.com>
Date: Fri, 11 Aug 2023 18:50:05 +0800
Message-ID: <20230811105005.7692-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Subject: [Intel-wired-lan] [PATCH net-next] net: e1000: Remove unused
 declarations
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

Commit 675ad47375c7 ("e1000: Use netdev_<level>, pr_<level> and dev_<level>")
declared but never implemented e1000_get_hw_dev_name().
Commit 1532ecea1deb ("e1000: drop dead pcie code from e1000")
removed e1000_check_mng_mode()/e1000_blink_led_start() but not the declarations.
Commit c46b59b241ec ("e1000: Remove unused function e1000_mta_set.")
removed e1000_mta_set() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000.h    | 1 -
 drivers/net/ethernet/intel/e1000/e1000_hw.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 4817eb13ca6f..75f3fd1d8d6e 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -347,6 +347,5 @@ bool e1000_has_link(struct e1000_adapter *adapter);
 void e1000_power_up_phy(struct e1000_adapter *);
 void e1000_set_ethtool_ops(struct net_device *netdev);
 void e1000_check_options(struct e1000_adapter *adapter);
-char *e1000_get_hw_dev_name(struct e1000_hw *hw);
 
 #endif /* _E1000_H_ */
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.h b/drivers/net/ethernet/intel/e1000/e1000_hw.h
index b57a04954ccf..95cdd17134e5 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.h
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.h
@@ -343,7 +343,6 @@ struct e1000_host_mng_dhcp_cookie {
 };
 #endif
 
-bool e1000_check_mng_mode(struct e1000_hw *hw);
 s32 e1000_read_eeprom(struct e1000_hw *hw, u16 reg, u16 words, u16 * data);
 s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw);
 s32 e1000_update_eeprom_checksum(struct e1000_hw *hw);
@@ -352,7 +351,6 @@ s32 e1000_read_mac_addr(struct e1000_hw *hw);
 
 /* Filters (multicast, vlan, receive) */
 u32 e1000_hash_mc_addr(struct e1000_hw *hw, u8 * mc_addr);
-void e1000_mta_set(struct e1000_hw *hw, u32 hash_value);
 void e1000_rar_set(struct e1000_hw *hw, u8 * mc_addr, u32 rar_index);
 void e1000_write_vfta(struct e1000_hw *hw, u32 offset, u32 value);
 
@@ -361,7 +359,6 @@ s32 e1000_setup_led(struct e1000_hw *hw);
 s32 e1000_cleanup_led(struct e1000_hw *hw);
 s32 e1000_led_on(struct e1000_hw *hw);
 s32 e1000_led_off(struct e1000_hw *hw);
-s32 e1000_blink_led_start(struct e1000_hw *hw);
 
 /* Adaptive IFS Functions */
 
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
