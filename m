Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3329FD2ED0F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Jan 2026 14:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 264EF6FE44;
	Tue, 20 Jan 2026 14:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y70Oxndm9Hbb; Tue, 20 Jan 2026 14:02:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFC5B6FE40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768917754;
	bh=mzIxuATxpJRGrg9GxTbERuno3fZW0VU1T96fY46PozY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i4U34qyS+AJHMr7aEgpV7kZLfrmU/1wxy8XtLO9REgdxjkOghcpE2pV9Kb43NNYTW
	 d6az2OVUiuH/HneOvf5S+mYdyjEE2fyEuzFk8nfJRUcjbjBQCKWBwsT5tvdpXZY+EI
	 uDv7Fwk39RZdI/bP08SKa/YpBgf31Oe1oZFiluC92/ELRjllPtvYFu0j5l8zLa8Csf
	 7ELGM1ApeUK5oziqd0d1d8WN3Gt6pn3W8HEEc4fSQS4ga3k971TCpGVPVLf+OfKVFS
	 ioH4P5WXk0zkFqE5RUbBtunzfqJs/GBbliw6I/AYuffwcjafw88TNnULBMngW688uX
	 KIQglVFcdjD9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFC5B6FE40;
	Tue, 20 Jan 2026 14:02:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14C02160
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 14:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D38CB6FE3E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 14:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZbnM1II7W7X for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Jan 2026 14:02:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CE0B86FE39
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE0B86FE39
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE0B86FE39
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 14:02:30 +0000 (UTC)
X-CSE-ConnectionGUID: yZq4nJeeSHifKEKoAG96LA==
X-CSE-MsgGUID: E6ytDEm9SJ+uN+nG+iuHqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711764"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="72711764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 06:02:30 -0800
X-CSE-ConnectionGUID: Z5suzBncQDu70q0WFZuPMg==
X-CSE-MsgGUID: JJ/4cUhHRUGPttSghNokGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="210978921"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:29 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Tue, 20 Jan 2026 14:44:31 +0100
Message-Id: <20260120134434.1931602-4-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768917751; x=1800453751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tSnNz7TB1ia5nhbzp+EuV2163blMz9E/aGy0jHVUOYI=;
 b=Lb0fuKo7NIX59u1k0QAsO06+clfqLMD5nMpXgvqVTXsztbYt5uDjhwZP
 5UoaquM8T0w+Z6mRzA3nJHol7n0X/lj4nVRgFh5z+F2cLdN5jiiDjT4hN
 eeNDxPZLZ5lW7mhbbNcfwhVb/qVtxYmsyE4ulibbQBgLcUr2787Ko+umN
 R7r+rU9yZDu44H4D1TUm0N3jcuoGrQaUp1Z2IGQNUp18L0u/LXAT5EXyZ
 RqpS5Jcd2/dOXbMJKV5rmmYh4+Xmh8ryArhjdgS4O3mQT9EPsQls3WTiH
 k/23Xl11msEcFfy6KEpowjl2JD6/8hravEieFmECvfwhpfRNISUVlIbwN
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Lb0fuKo7
Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/6] ixgbe: E610: update EEE
 supported speeds
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

Despite there was no EEE (Energy Efficient Ethernet) feature
support for E610 adapters, eee_speeds_supported variable was
defined and even initialized with some EEE speeds.

As E610 adapter supports EEE only for 10G, 5G and 2.5G speeds,
update hw.phy.eee_speeds_supported. Remove unsupported speeds -
10M, 100M and 1G.

Add also entry for 5G speed in EEE speeds mapping array used
by ethtool callbacks.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c    | 11 ++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 431c932f036b..289a04183e03 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1998,9 +1998,14 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	/* Set PHY ID */
 	memcpy(&hw->phy.id, pcaps.phy_id_oui, sizeof(u32));
 
-	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_10_FULL |
-				       IXGBE_LINK_SPEED_100_FULL |
-				       IXGBE_LINK_SPEED_1GB_FULL;
+	/* E610 supports EEE only for speeds above 1G */
+	if (hw->device_id == IXGBE_DEV_ID_E610_2_5G_T)
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL;
+	else
+		hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_2_5GB_FULL |
+					       IXGBE_LINK_SPEED_5GB_FULL |
+					       IXGBE_LINK_SPEED_10GB_FULL;
+
 	hw->phy.eee_speeds_advertised = hw->phy.eee_speeds_supported;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index bb4b53fee234..779e2425e4aa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3540,6 +3540,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
 
-- 
2.31.1

