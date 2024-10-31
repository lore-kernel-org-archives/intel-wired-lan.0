Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7AED767DB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 31 Oct 2024 15:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9297560902;
	Thu, 31 Oct 2024 15:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7Wyd7z0IR_H; Thu, 31 Oct 2024 15:20:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D674960A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730388014;
	bh=pX0HrTTm7HCYLgahgZX3qc/QSX+GT80c5O9hkkRw0k8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qdLVzrbEFYVwlXHQgujIW5J6vWDTv9pC0tCKjKhWmEZEXCyOEFAAq+jIw4KMefFBf
	 tqLtlH1hTfwiNuiYQB2XMgsFq/NQ7lZ8oLu51DYP4TQGuR0GC0RMtbiXNGmqHW9A3Z
	 yU5qMUogJM7XJkwg5prt1sDubBPL76T6LtGWMlXZb5g7ixYApmBlf5UMwjo/NMBKR1
	 OJgXRb+rr9Pzo/GJ+sKFoa7OIS6YuQhiznt0PIT2suiIMTJs8zN+oRMjnEgG8Rx58S
	 8tBtsIW6zJA4o65TFPqeRNvrmJlC2Mfe37HXMzMGloKP1PUPHie0tDU/A2DYOlWmcH
	 BDNkaFWE/sqKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D674960A3D;
	Thu, 31 Oct 2024 15:20:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 339C2494E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Oct 2024 06:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0576560900
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Oct 2024 06:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzxsigDqbIH1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 31 Oct 2024 06:00:14 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F034E608FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F034E608FB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F034E608FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Oct 2024 06:00:13 +0000 (UTC)
X-CSE-ConnectionGUID: t66lGRujQyKrDzNhPo8WIg==
X-CSE-MsgGUID: qslY/zm2QF6XURIZEs6/tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30272914"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30272914"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 23:00:14 -0700
X-CSE-ConnectionGUID: 7wwz33LMQzS7GO/vxF3PRw==
X-CSE-MsgGUID: HZDAcR/nS+SbesStu1tJag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82183636"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
 by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 23:00:12 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sridhar.samudrala@intel.com
Date: Thu, 31 Oct 2024 07:00:08 +0100
Message-ID: <20241031060009.38979-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
References: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Oct 2024 15:20:09 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730354414; x=1761890414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ah4ER9uuaDuiKqExVX2njPkUq8+DKNu+ToTM9QJUQk8=;
 b=OqqEo72EG9RO8KTGougtis8VzTqy2xhGJNeFIwX6M7ch5IZLdMmuFVJc
 EJul2irbCAZuS5IHswY+1Vux3pYBhiQiMnMh1HQUQsiO2s+tpT23pldUs
 DZtXPeQLKMuSwpLNf5VlYM5WBCQ3Tk+euNkSdIkf1gWrzPN/SKEcQAXlw
 3kAmH4/5VwQ1W2E1ivouXyDGvPNlhjfboVCwkBMOnbmkAgNRfM5orkA+I
 jOY0bfUEfE8AJT2V15nMn88U5F4E7TL5zMVLMmV1iNsU11KPFMYDKfYd9
 Hry/KGSBNfV8ZYcLXHJCZ6/fMEt5X2zK7Uwuueod2gBd27anjC24G5aUN
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OqqEo72E
Subject: [Intel-wired-lan] [iwl-next v1 2/3] ice: ethtool support for SF
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

Initial support for subfunction device. Mostly it is sharing the same
ethtool ops as the PF, however, define new ops structure to support
only needed part of ethtool ops.

Define new function for getting stats length as subfunction VSI have
less stats available than PF one.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 28 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b552439fc1f9..9e2f20ed55d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -47,6 +47,7 @@ static int ice_q_stats_len(struct net_device *netdev)
 		 / sizeof(u64))
 #define ICE_ALL_STATS_LEN(n)	(ICE_PF_STATS_LEN + ICE_PFC_STATS_LEN + \
 				 ICE_VSI_STATS_LEN + ice_q_stats_len(n))
+#define ICE_SF_STATS_LEN(n)	(ICE_VSI_STATS_LEN + ice_q_stats_len(n))
 
 static const struct ice_stats ice_gstrings_vsi_stats[] = {
 	ICE_VSI_STAT("rx_unicast", eth_stats.rx_unicast),
@@ -4431,6 +4432,16 @@ static int ice_repr_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
+static int ice_sf_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ICE_SF_STATS_LEN(netdev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 #define ICE_I2C_EEPROM_DEV_ADDR		0xA0
 #define ICE_I2C_EEPROM_DEV_ADDR2	0xA2
 #define ICE_MODULE_TYPE_SFP		0x03
@@ -4870,6 +4881,23 @@ void ice_set_ethtool_repr_ops(struct net_device *netdev)
 	netdev->ethtool_ops = &ice_ethtool_repr_ops;
 }
 
+static const struct ethtool_ops ice_ethtool_sf_ops = {
+	.get_drvinfo		= ice_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_channels		= ice_get_channels,
+	.set_channels		= ice_set_channels,
+	.get_ringparam		= ice_get_ringparam,
+	.set_ringparam		= ice_set_ringparam,
+	.get_strings		= ice_get_strings,
+	.get_ethtool_stats	= ice_get_ethtool_stats,
+	.get_sset_count		= ice_sf_get_sset_count,
+};
+
+void ice_set_ethtool_sf_ops(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &ice_ethtool_sf_ops;
+}
+
 /**
  * ice_set_ethtool_ops - setup netdev ethtool ops
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..d63492c25949 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -58,6 +58,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
+	ice_set_ethtool_sf_ops(netdev);
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
-- 
2.42.0

