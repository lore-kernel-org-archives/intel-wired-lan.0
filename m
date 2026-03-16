Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC48EFCBD1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 07:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C79D40C9D;
	Mon, 16 Mar 2026 07:21:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXKNVEFFY3bT; Mon, 16 Mar 2026 07:21:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFE5C40C92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773645660;
	bh=YFyK9Oqgfq6kyY7eL0ZXTk+UzohKrWINlFygaLd7fhc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fl4fCQsSBehpFG7UHrWtqM0kvUkQKy2uhJP/qd/41lz31GMoEdsizooltlvwWHyyd
	 Q5FoAZzC3UEf0c1NS3dDTaJ9crzjIffTAXIFgxItp4Du30PlC4SUIpOuIaIDtKc1UU
	 7BKnTdIftSbdzkZ2GH2V4bdS9O9Ne9FpCqN9Q5sF+CiiqGhb++GAiGQWbSu/heveh0
	 cTwtao36bYUbXTIC4IkYOsqIZpFAzUu8YYZ9ZCYNwQJLoT91xRBuYGg6uBmg1P+VY0
	 nTg1sgyc7DzzEIMc/Uut9FUU7H72D9iJnOsngJHWiSaseYK3+fWpNgfyjl3dx+mpjw
	 RMFYu84nk63rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFE5C40C92;
	Mon, 16 Mar 2026 07:21:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7B69D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 07:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE20882965
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 07:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOTYWBhCzqY2 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Mar 2026 07:20:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0768882923
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0768882923
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0768882923
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 07:20:57 +0000 (UTC)
X-CSE-ConnectionGUID: aZv/140VTCihNWSvGaSTmA==
X-CSE-MsgGUID: SafIHXmzTySzemEeQZ0JVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="84970607"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="84970607"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 00:20:58 -0700
X-CSE-ConnectionGUID: 4zrcfXAoQZm+uBI43UVKrg==
X-CSE-MsgGUID: 2Jq7VfvHRVutPyfkT0S0fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="222030145"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa007.jf.intel.com with ESMTP; 16 Mar 2026 00:20:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com
Date: Mon, 16 Mar 2026 08:20:52 +0100
Message-ID: <20260316072053.1241987-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316072053.1241987-1-aleksandr.loktionov@intel.com>
References: <20260316072053.1241987-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773645658; x=1805181658;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jcgu0G4yFwmZlw8w+NTRKbolWpD1J9LZq4Y9zKRM4Gc=;
 b=e7ypEIe+gMoBMaR+WTI9DmFnX3ORvtzlMHblmzu3NASqUNHFxRPFa4zZ
 A8E1xu14iIM+i9TCU2lDsigB5BWpMMZjpxsUiV73b2OZ1uHi/+QJe5PUd
 +CnSDOMlxvUGdwXomQ73r7wfIDWn8S3fTjlqZAUyOUlzkQZTYItxDgphy
 j1Ks361q11lzzMbQl8QqjQofvG/nul3VSxpj3/bBBnMQyUyMVOB9OQLBS
 BUM6Un1iAnSruoiRpkWVRYzgLz7/HW8pNIv/hI/o5wEAai3zwuJo0b50r
 IGOF55gR95EXqoBeBPntnx/66n0awcYpnjnhL7TE47p0nDykh6U/5xS0Q
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e7ypEIe+
Subject: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ethtool: treat
 RXH_GTP_TEID as intrinsically symmetric
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

A GTP tunnel uses the same TEID value in both directions of a flow;
including TEID in the hash input does not break src/dst symmetry.

ethtool_rxfh_config_is_sym() currently rejects any hash field bitmap
that contains bits outside the four paired L3/L4 fields.  This causes
drivers that hash GTP flows on TEID to fail the kernel's preflight
validation in ethtool_check_flow_types(), making it impossible for
those drivers to support symmetric-xor transforms at all.

Strip RXH_GTP_TEID from the bitmap before the paired-field check so
that drivers may honestly report TEID hashing without blocking the
configuration of symmetric transforms.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 net/ethtool/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 5fae329..9a3fd76 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -911,6 +911,9 @@ int ethtool_rxfh_config_is_sym(u64 rxfh)
 {
 	bool sym;
 
+	/* Strip TEID before checking - it carries no src/dst asymmetry */
+	rxfh &= ~RXH_GTP_TEID;
+
 	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
 			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
 	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
-- 
2.52.0

