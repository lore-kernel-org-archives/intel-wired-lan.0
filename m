Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADB6C433FE
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Nov 2022 14:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CD0060FCC;
	Thu,  3 Nov 2022 14:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CD0060FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667485813;
	bh=Z2b4o7rH8hIb8AKjRz2RHUsFfQkPjqBvSuFIRO94ZhM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=9rr5e3NQOgJqBlnVwyyvzLvMJAbshB8gC/kNZqErOi/AFXBieZ3Y+Q3U/6fT2KZWh
	 MW90qmdqNdR5VBTzG2HJ8z6MKpbtLZy1Xlh46ndG7JnmGBR8WHCxPH/5iU7uy7CabD
	 1mW5u03XhwCof0F+JmWK17xy+tgVbxJhkbi6I5lcOYtAY6WljlmFAhTNSuKqNhHiKk
	 1J4Gpe0LyK3+pNPQHu2QZNBIaC8a9hgkbh1rAJcdhlN77SWQTAOmltNZhFcZciPV26
	 w3dVOfQJ5F8etFNmfeiGMsYrdd1wNn5KTQyrVMH4CctFU/QPw+CWOj7R9TNEm4lT6n
	 zE0+fsrckxqCA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecupEb0eM9FB; Thu,  3 Nov 2022 14:30:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B280A60EA1;
	Thu,  3 Nov 2022 14:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B280A60EA1
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9135A1BF38A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Nov 2022 14:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AA6840297
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Nov 2022 14:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AA6840297
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HFrNv-BVxX4s for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Nov 2022 14:30:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBA7740253
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBA7740253
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Nov 2022 14:30:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="310815665"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; d="scan'208";a="310815665"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2022 07:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="634694079"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; d="scan'208";a="634694079"
Received: from propan.igk.intel.com ([10.123.220.122])
 by orsmga002.jf.intel.com with ESMTP; 03 Nov 2022 07:30:09 -0700
From: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  3 Nov 2022 15:30:05 +0100
Message-Id: <20221103143005.578149-1-anatolii.gerasymenko@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667485810; x=1699021810;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5KzDF2m1Xk6hlQuSweed0H0kODN1ZPBkhk40KCgZ6hE=;
 b=GckeHmp1FgP3E2oFR2ZroEjDf+Rs5jAEJuYsbh2QmsbUwd+B4ebXPeu1
 g6cSuA8h7XowaGU/k4i/H0gCw0/tnwgVehm2DVrP0VVJRr8EsupGEB/1L
 CN9ygw+FhkdMahI1VGMp6gyVAz5dtYGNMV3vtL0oIHM2HjbRpQsLmsLKr
 p38d70OF2Ktce7HXpqrKVH+3/Wrn4bsrnST2Dufbu6nD9FHw1zFkztMfk
 oCfkXZNkdF1euWpVQcYS8IsvcT8WDCBipdxAav4T/mPf1nbPUvs8T83br
 gfZwZLtd2WRGsnkFcRw4ViIVQzVS9Rmq7GP9K+kc1KcjIzhg84PvJkyzM
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GckeHmp1
Subject: [Intel-wired-lan] [PATCH net-next v1] ice: Use ICE_RLAN_BASE_S
 instead of magic number
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
Cc: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit 72adf2421d9b ("ice: Move common functions out of ice_main.c part
2/7") moved an older version of ice_setup_rx_ctx() function with
usage of magic number 7.
Reimplement the commit 5ab522443bd1 ("ice: Cleanup magic number") to use
ICE_RLAN_BASE_S instead of magic number.

Fixes: 72adf2421d9b ("ice: Move common functions out of ice_main.c part 2/7")
Signed-off-by: Anatolii Gerasymenko <anatolii.gerasymenko@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 9e36f01dfa4f..3a774b196fa0 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -389,7 +389,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	 * Indicates the starting address of the descriptor queue defined in
 	 * 128 Byte units.
 	 */
-	rlan_ctx.base = ring->dma >> 7;
+	rlan_ctx.base = ring->dma >> ICE_RLAN_BASE_S;
 
 	rlan_ctx.qlen = ring->count;
 
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
