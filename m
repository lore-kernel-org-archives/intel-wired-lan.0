Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E7DC44520
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 11:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4107980AD1;
	Mon, 20 Jul 2026 11:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QoMgtUy9JU90; Mon, 20 Jul 2026 11:59:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A07F580AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784548791;
	bh=qLXK6JCAvIGNvIgBjsUmn6fO5AUXJSLlQjLnEhDZhrk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aBOr9yKv0cSf11YEXLPL6Gpswog2qDJoIWVk7CK6fx5b9zzy3cQDV8HXWQP1l4w03
	 N9DDrQ8CyzsEpe33SsaDepxsjoHX5c31n3yH8KT3YNSiloDKJ0kBzLwB2qWzfW/zJr
	 j+kc5B66eZPGd3wP/koqXVfgtN9DyuqP181rFsNTOJB5iM+w6X4eAhmcCgkdutMVId
	 QmYQOp5lW2jSxls/2lBNqXcc5eKgOLZLFOAI/PHDdJyg5LWe60Y1er0SsWCXsQlwtp
	 jpwOxsddU3AZFM4vGfUrxytQMKRWcg9/JLx/tL2Mhjl2pBqKbIZgNbmMXfI9/44pWZ
	 alykcd4LUncbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A07F580AE3;
	Mon, 20 Jul 2026 11:59:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3B931F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDA7260649
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_YSvBBvAppe for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 11:59:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C4FE660615
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4FE660615
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4FE660615
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 11:59:48 +0000 (UTC)
X-CSE-ConnectionGUID: e8zx6YjBQ5iSJ2YyLxW4Fg==
X-CSE-MsgGUID: OcrdTdQBTUKktmXPTlkxmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85328162"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85328162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 04:59:48 -0700
X-CSE-ConnectionGUID: AYe2gW+wTI6btREDZPeZlw==
X-CSE-MsgGUID: W1JydWI6RTW7h641hKN2jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258078352"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by orviesa009.jf.intel.com with ESMTP; 20 Jul 2026 04:59:46 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 arkadiusz.kubalewski@intel.com, konstantin.ilichev@intel.com
Date: Mon, 20 Jul 2026 14:01:28 +0200
Message-ID: <20260720120151.2675206-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784548789; x=1816084789;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cQpFxk8hs1T7IiXEb5h07BYkfLQqnsRKlmfqU5be4UU=;
 b=e4MVSql9ZhStLbVBWciUd+2e1BtgvvxkHWP1ZMayAhZ9w32XkeV8d8ZJ
 lwiex9aecz8TxFhMbkT3fFVSaWYH7EC/tr2t0Hru1b1paadhZMfSdgtj4
 3H/mgGAMHpABkqvcPx/HNiGAKzHq3waDy0x+2gOo3AoaW07a8nQWqIeeL
 8MxmctntMWM8+Fwl9nBOoawDyi57chqgq6g+OTwxWc6nCIFcwWHHN7c24
 YQSanaUB+G3ydqKV9EI5hDt+sj/pxo4SCMUqalZWCqXzbnGLiUhXHq9KG
 ci8XRWQjMqz4HsARENBr2tLoqKkKqsS5WdzVVfJ3VfsJcwWPBUpB5H2t/
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e4MVSql9
Subject: [Intel-wired-lan] [PATCH iwl-net 0/4] ice: fix PTP timestamp
 handling issues
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

This series fixes several PTP timestamp handling issues in the ice
driver that manifest during link state transitions on E82x devices.
Together, these issues can cause Tx timestamp timeouts, ptp4l service
disruptions, and on PREEMPT_RT kernels, a system livelock requiring a
hard reboot.

The root cause is a set of race conditions in the PTP link change path.
When taking the link down (ice_down) or bringing it up
(ice_up_complete), the PTP recalibration and cleanup were not properly
synchronized with actual physical link transitions. This allowed Tx
timestamp requests to be queued against uncalibrated or stopped PHY
hardware, producing orphaned timestamp ready bits in the PHY registers.

On E82x, the PHY will not generate a new timestamp interrupt until all
outstanding ready bits have been read. Orphaned bits — set for slots
with no matching software tracker entry — are never read, permanently
blocking new timestamp interrupts. The existing periodic work detects
this symptom and re-triggers the interrupt, but without clearing the
stale bits, this creates an infinite trigger loop. On PREEMPT_RT
kernels, the resulting interrupt storm causes RCU stalls and eventually
a full system livelock.

Arkadiusz Kubalewski (1):
  ice: call PTP link change only from link events

Jacob Keller (1):
  ice: clear unexpected Tx timestamp ready bits to prevent stuck PHY

Karol Kolacinski (2):
  ice: keep Tx timestamps disabled until offset calibration completes
  ice: cancel E82x offset verification work during reset preparation

 drivers/net/ethernet/intel/ice/ice_main.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 155 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  89 +++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h   |   7 +
 5 files changed, 219 insertions(+), 36 deletions(-)

-- 
2.43.0
