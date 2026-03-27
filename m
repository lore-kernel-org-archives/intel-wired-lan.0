Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222B110BA430
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF0C861297;
	Fri, 27 Mar 2026 07:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZwVvVNtOXlA; Fri, 27 Mar 2026 07:31:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42F3061298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596667;
	bh=vf5bCKLrTnzgHFzxSn0rHITuDK+kLOQaxY+F3NtJXUM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/KaF3ilL+UALv0VbnhPfZ0M55xY50lelQD3lQL7RoX9P0wy7cW6vqV4xDIYS93Hm
	 rrflZr6HdgI6Qc5/ufkPBnhJdxDTZ7CLLNAGoXWFghXrWuLc1YI8wdK3zL0Gdo5vkp
	 CEM6bq9YsDwT9wPw/0hsGmtJxhD8N775KILzSSDKHizkjcJg+LunP4J/JT9GViU4Ce
	 McbwPTbBcXLdAQ1RWdRdArIwOGTFQj8KDEn7nXuSMK5Uobfd+vSEAgE0JR+LykfAZp
	 KqkTFEiEaqMwtB33lEDD7q5cD4+G6M41nGbYwDrksuVdW3KAS3Fjs8lBO46IExmRWV
	 oDbNB5wx+YhYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42F3061298;
	Fri, 27 Mar 2026 07:31:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC13D249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDFAF415C8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANKQvfVTmK5P for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CD73041598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD73041598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD73041598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:04 +0000 (UTC)
X-CSE-ConnectionGUID: WbH3yhQCRg+qLGZytXb0zg==
X-CSE-MsgGUID: 91asOJjZRgS+bNsnPFdIHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734336"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:31:04 -0700
X-CSE-ConnectionGUID: z9BBHnttQH2GFsKTFs2Nhg==
X-CSE-MsgGUID: Adr+VMHDTJ+eNwSeTiifwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740450"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:31:03 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:30:46 +0100
Message-ID: <20260327073046.134085-12-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596665; x=1806132665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QTbc+V8S9tIlg4mhaTbYxSvbv3dy+sH80dNtXOoQmKA=;
 b=Op0WetS0gSudkV9Y80bmTzSeAa0SY9TOq3e3QASv543YbqXYOXU4LzmP
 qHXOP9+dlqy8nsqpyVQ4UhBCN3LrD9W+yvKxE0JH1fbk/r/d9qAL9Ra9g
 z2Z6jcfLlX/XK/p+RyGID9jAgjBsU/vGQF7YknpP3NcVoOR//MHVkUlX+
 HHLeFOA4TTB4knY4VYbhdtZBH3wHONcK+48CaWXgJ1alhjMJ8Nwgsa7GN
 QqyGAi+wOCUcT1eYa5gdeC4fql+jTFAF5vEVehsa+QSyYeM1thy+ojLqb
 bSr2dZYXkmG2wPH+xbL6jJgvQ6duxgqjOS7pLZcVEbhAuqMGE3dO5CIEM
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Op0WetS0
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: extend 5 s SWFW semaphore
 timeout to all X550EM variants
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

From: Marta Plantykow <marta.a.plantykow@intel.com>

The 5-second SWFW semaphore timeout added for X550 (ixgbe_mac_X550)
also applies to X550EM devices (e.g. X550EM_a, X550EM_x) since they
share the same FW and the same SR-dump-driven worst-case latency of
~3.2 s / module-update latency of ~4.5 s.  Change the mac-type
comparison from '== ixgbe_mac_X550' to a range check that covers
all three X550-family enum values (ixgbe_mac_X550, ixgbe_mac_X550EM_x,
ixgbe_mac_x550em_a) without inadvertently capturing later entries such
as ixgbe_mac_e610 which share the same swfw-sync function but have
not been validated against this exact timing requirement.

Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 85047ef..298958d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -577,7 +577,8 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 
 	swmask |= swi2c_mask;
 	fwmask |= swi2c_mask << 2;
-	if (hw->mac.type == ixgbe_mac_X550)
+	if (hw->mac.type >= ixgbe_mac_X550 &&
+	    hw->mac.type <= ixgbe_mac_x550em_a)
 		timeout = 1000;
 
 	for (i = 0; i < timeout; i++) {
-- 
2.52.0

