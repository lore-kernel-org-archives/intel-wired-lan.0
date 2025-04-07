Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E34BC369A4
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Apr 2025 19:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32D8740C39;
	Mon,  7 Apr 2025 19:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgL_W_SBcana; Mon,  7 Apr 2025 19:16:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A23CD40CE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744053360;
	bh=MztmDK5MDwMGkK4wiB6ZKUi9u0b5TQPjmv+NE91jbe4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mgxK4LtJ8FsAtPRBvjLMj4BzEfl+eEJMkbME7mkpoHCbCkKvAsPIlr5CgBkDtJ3WP
	 pBj93jXs03Bk9pXUvg+SnAEa9D1hkGocCKBfe1RRgpklWzwdltKh/EbdWUelXBf2bH
	 //s7orTp1v4TEES5t1WuMuOsrjbOJ6YCX0Kc/3t9yMjw8VEKNt547HJgRj8ZXPhnY2
	 P+3DI0daKDFkyzECxQ15xIwc1RLRrEC+HCusR20y0MnkDsHKYpCfk2n6WrW/cSv/qA
	 ZXKvXmJK9FH0Y/0eql3KYmrmLu7aGo5CXWH0O0aM4pxn8gYt+thSaYR9YUFLMiGmv3
	 1CPnZkwdM/qqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A23CD40CE2;
	Mon,  7 Apr 2025 19:16:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 436E0DA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Apr 2025 19:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 695E64157C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Apr 2025 19:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVKivB_uMuvT for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Apr 2025 19:15:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=david.m.ertman@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CF020415BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF020415BA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF020415BA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Apr 2025 19:15:52 +0000 (UTC)
X-CSE-ConnectionGUID: N94dg/WJR4ieBzO/HQq/nQ==
X-CSE-MsgGUID: oNfew9bARb605CScNRN1MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49307040"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="49307040"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 12:15:51 -0700
X-CSE-ConnectionGUID: RSVLYUX1S9O8ZLS/nD/uaA==
X-CSE-MsgGUID: cOIwA2GKTxi+MoNizqV0SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="128979595"
Received: from dmert-vmdev.jf.intel.com ([10.165.18.186])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 12:15:51 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon,  7 Apr 2025 15:15:15 -0400
Message-ID: <20250407191517.767433-7-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407191517.767433-1-david.m.ertman@intel.com>
References: <20250407191517.767433-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744053353; x=1775589353;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vGZbQ5U3a4Vb36d08xxqd46J7T4GVTCl4Gi4nRWrJQU=;
 b=EC5eEsKIzZ7dttRg0v/eNKYbty/BltpryW2EWI6bqUUbG32HlVKTo7fn
 u1aBzHQIsiRUy2zpxldZkY7mePPQAIDQtiKLg59qu+iCKr28HuACqtC3U
 xXYwhxGe98yDe2OPtSdR0iN/952k/SEt8HViqo+ZvI7wV3xEIfOtpPbpd
 jNmsgagrChjvbJ/f3opq3gtgQS81PFw8jzuocLZ3cLWU6Wo7bZ8bpDQzN
 PGdkqgaxApohKQM7KNu+rWIZ7Dz6d/9Vzm7Rx/5zAfb1B+8oRWYs21SCt
 hZTuzRhXPtW3G8F6BtDnvBkZGl3oX+l5d1f4fKmmFyJOIMgrNKts3fgki
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EC5eEsKI
Subject: [Intel-wired-lan] [PATCH iwl-next 6/8] ice: cleanup capabilities
 evaluation
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

When evaluating the capabilities field, the ICE_AQC_BIT_ROCEV2_LAG and
ICE_AQC_BIT_SRIOV_LAG defines were both not using the BIT operator, instead
simply setting a hex value that set the correct bits.  While not inaccurate,
this method is misleading, and when it is expanded in the following
implementation it becomes even more confusing.

Switch to using the BIT() operator to clarify what is being checked.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 2eaa4ab8e791..b3298063f1bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -133,8 +133,8 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE		0x0085
 #define ICE_AQC_CAPS_NAC_TOPOLOGY			0x0087
 #define ICE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
-#define ICE_AQC_BIT_ROCEV2_LAG				0x01
-#define ICE_AQC_BIT_SRIOV_LAG				0x02
+#define ICE_AQC_BIT_ROCEV2_LAG				BIT(0)
+#define ICE_AQC_BIT_SRIOV_LAG				BIT(1)
 
 	u8 major_ver;
 	u8 minor_ver;
-- 
2.49.0

