Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3966AEBFD0C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Apr 2026 07:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 039CB60E5C;
	Mon, 13 Apr 2026 07:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id COUmy5VpACwb; Mon, 13 Apr 2026 07:30:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4683B61AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776065445;
	bh=W1xI0bBNunllNsuk4/jnpm7QutxP8+n6tedzFzwwQCE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OwL1en9hziRsG/WFv6GEBWUU/xL0GhHhbZMRQl4Wru8uVKEE1WR2FJ+mfaNydjhB3
	 5q28EIeQT9JJYopl1J6urYxF+vaXEMPh5qMN55Vz+9fBOGAvEhn8cY7FobHrdZzPAA
	 vZI+BMrRJ05AkqxB8Gz/vObLaasy9ZI92lL6x0eA/dhqCQa6NXsHiM481PTUlvTRVx
	 YGsByvLRVM5/fCx03nZMROySugbJJhbzoKqjS1enbDJta5hOglwBsiDD5hCEtsbu3J
	 DpPB749ux2Javb4VlyBj824ia7btMAvu/2gPq/+6Vju1Hd28amL+ctfErzhaAj5Pwc
	 bWHhuG9ovHG4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4683B61AD8;
	Mon, 13 Apr 2026 07:30:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C656D194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 07:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC7748238D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 07:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iG4eOqBjy6Uc for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Apr 2026 07:30:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AF73D84193
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF73D84193
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF73D84193
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Apr 2026 07:30:42 +0000 (UTC)
X-CSE-ConnectionGUID: rVBXGSOBQDKjjcaTlQsNMg==
X-CSE-MsgGUID: uo4icXYuTw+KFEvfvlYSyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876634"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="80876634"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 00:30:42 -0700
X-CSE-ConnectionGUID: OUEEpF2+TKa8ZrxWFrbaog==
X-CSE-MsgGUID: +/NwIoe9QEWOv7dHNLPQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="267700551"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
 Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Date: Mon, 13 Apr 2026 09:30:33 +0200
Message-ID: <20260413073035.4082204-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776065443; x=1807601443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BEQZpYdie0qiN2xtDyQz59CbnPWVsowDYUJhO2NHgJ0=;
 b=myWNNXZxwgAF1tS3KrbQP8MqQkJUzxg9+/9oGPjT8pU4z37Tyg4N1g7b
 h+LH+RqwLdoqPl5iVqy+HNhmdThtSgnVMn4Bc2N5Q+7U0WoTQ/B7OaURp
 eC5lKo1kV7Tbx0ay7q6AxMN0XstSL4ZcJM8ywxG5ioyTCNj3+AcNImsdm
 yVvHlxavLO3WNvumIquNw1ouyd4v4wOR7Dvr6ntV3+GR4maFUkQArwT/5
 J7ovuKNBuJUd9MXBDUdv6Ja0SaEmShoyQBuewDV1Idq17NAw3bTVvtttL
 dACWO9D5Jh/ztkkk8FUyvIblGvoFRqrGv/f0dZP8Yc5iNEH9oXrcz1Ajd
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=myWNNXZx
Subject: [Intel-wired-lan] [PATCH iwl-net 3/5] iavf: prevent VSI corruption
 when ring params changed during reset
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

From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>

Changing ring parameters via ethtool triggers a VF reset and queue
reconfiguration. If ethtool is called again before the first reset
completes, the second reset races with uninitialised queue state and
can corrupt the VSI resource tree on the PF side.

Return -EAGAIN from iavf_set_ringparam() when the adapter is already
resetting or its queues are disabled.

Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 1cd1f3f..3909131 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
+	if (adapter->state == __IAVF_RESETTING ||
+	    (adapter->state == __IAVF_RUNNING &&
+	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
+		return -EAGAIN;
+
 	if (ring->tx_pending > IAVF_MAX_TXD ||
 	    ring->tx_pending < IAVF_MIN_TXD ||
 	    ring->rx_pending > IAVF_MAX_RXD ||
-- 
2.52.0

