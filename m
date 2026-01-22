Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2DFC44500
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Jan 2026 08:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85A3B80D5A;
	Thu, 22 Jan 2026 08:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djlrlvaKau2j; Thu, 22 Jan 2026 08:51:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD17885047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769071888;
	bh=AnFAIqy6+CO6QRrmk829noaSvU32jZGzmoLT6Zw9+5g=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BXiD6qNXlJ3mOAjMbVxdJkpiNHlLIlhIuPW07ja3qhCvFkvklOhNcHYakKixK8S09
	 xB6nPi3bPhSnpNChX5qoAfzMq+HEj35Z0ERE0MN57tKiaXqrosZ9XB1i4LMVah7vnb
	 V+m0T15aGljOMQjwbEUmQjK4/UHzieNniD9LZS2rnZ2mxAWh64RLtwCRvesOXjHvRG
	 CpsnPBsINwyzvYrrAnElyd5hpvnmRWZAzwTBc0sWzOA/RoY6KSlC3CNdyEoP0fVOl0
	 sZorTwyk1vY+Y7XkfzarjWB8JmqkFEJnGA3KB3beoIcwOnlsCYCAYxNyn/cYMvA3It
	 KAc30SV7+SSSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD17885047;
	Thu, 22 Jan 2026 08:51:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04299122
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 08:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD20F6F7A5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 08:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JDGtfEG8imrx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Jan 2026 08:51:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3B0236F6BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B0236F6BE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B0236F6BE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Jan 2026 08:51:26 +0000 (UTC)
X-CSE-ConnectionGUID: AzJ+qOukSCuaopMb4PXd2A==
X-CSE-MsgGUID: I+Ha1XxUT6umwGUO3QFMHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70224344"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; d="scan'208";a="70224344"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 00:51:08 -0800
X-CSE-ConnectionGUID: foltntY4Sx6EY8TfgtzUzQ==
X-CSE-MsgGUID: wk0yBgu/TEiO+afE/IQcQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; d="scan'208";a="205924946"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa010.jf.intel.com with ESMTP; 22 Jan 2026 00:51:03 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Thu, 22 Jan 2026 09:51:02 +0100
Message-ID: <20260122085102.1117651-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769071888; x=1800607888;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NmNlucIgKwK3+ale7vaInUF2bjHcFehAzVXgbuyDoSI=;
 b=eNIJaK4d/lWoX1S8iBhMmFxIhsYciXR+XZajG5+UED1XeCVp8bpMaiQS
 6LldODYqGFlRKQt2Tc84jZ4YWanV1FORKlDSQgiMf8CLEXqeSrzBC2/oN
 M2QYy6FoRe+7EL4cu5PMtz7OasFeF9/+RVPuTSY2Uq9jbgFvUMNI4YhZR
 c6XRKA0LKLNxfiph59SUyqpe9n80HTkk24f6ljeygECNyV3YjO9hhu4/a
 Yf3wVdfRy6cyCVPelgdIL7rwvdI5Ap9Emo7BcqOe1LKVOE8nSW4mF6GCr
 yIoK3l+4jSKc6kRPP5NRrVWUmWDrJyDAI6QlkJ/1HGRsxBuU/72QH+p6E
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eNIJaK4d
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: fix type punning in
 ixgbe_update_flash_X550
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

Add a u32 buffer array member to union ixgbe_hic_hdr2 and use it
directly instead of casting the union address to u32 pointer. This
avoids potential strict aliasing violations and makes the code more
explicit about the buffer usage.

The ixgbe_host_interface_command function expects a void* buffer, so
providing a proper u32 array member in the union is the correct
approach rather than relying on pointer casting. This eliminates the
type punning issue where we were casting the union pointer to u32*.

By using buffer.buf instead of &buffer, we pass the address of the
u32 array directly, which is semantically correct and avoids any
potential undefined behavior from strict aliasing rule violations.

Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61f2ef6..eb5bf3b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
 };
 
 union ixgbe_hic_hdr2 {
+	u32 buf[1];
 	struct ixgbe_hic_hdr2_req req;
 	struct ixgbe_hic_hdr2_rsp rsp;
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 76d2fa3..4a0ccbf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1228,7 +1228,7 @@ static int ixgbe_update_flash_X550(struct ixgbe_hw *hw)
 	buffer.req.buf_lenl = FW_SHADOW_RAM_DUMP_LEN;
 	buffer.req.checksum = FW_DEFAULT_CHECKSUM;
 
-	status = ixgbe_host_interface_command(hw, &buffer, sizeof(buffer),
+	status = ixgbe_host_interface_command(hw, buffer.buf, sizeof(buffer),
 					      IXGBE_HI_COMMAND_TIMEOUT, false);
 	return status;
 }
-- 
2.52.0

