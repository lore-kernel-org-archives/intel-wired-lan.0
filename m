Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500FF109316E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F5A041C5D;
	Fri, 20 Mar 2026 05:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9abknuMO-z2e; Fri, 20 Mar 2026 05:05:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4551C41C5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983127;
	bh=WAyIkV0cN+v4h+ykoCZODl1mHPabXxdtYigdGOsK8e8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wHrGxGr66Kbt6qMBwN7pi37cH331scykNxv36NEdyv6Mhm+jBtdGAcvqCYaVwg5kZ
	 W/rLr/lrkUOeiFGBeQ/g/Sue++faqPYNaKBavioGcxr4NM5POvAxVtZZPF5PqufaR7
	 d2E5/zuBmvjtkqf+40L+VzjEmF59dSn08oI/cQWe5pUpOShU/CWMgqQBZDsGx5Gex7
	 +DGjiwCjIQ6mcy0iXXk+1A0wlBjkMVziI6zG0/79C1/jsmKenal809Fv3XmoQVV+cz
	 Ir+4UEFjnt4jbYAZRH4WIQsn/qr9I2SNmaZ7baieiyOdqf/AgcjfsGEFFvUttO3YN/
	 i6VXU3/jq38ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4551C41C5A;
	Fri, 20 Mar 2026 05:05:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 833AF1B6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74D5F41398
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6UQ-5sS1vLd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:05:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 794FE40176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 794FE40176
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 794FE40176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:24 +0000 (UTC)
X-CSE-ConnectionGUID: HdDTv1eRQfC4sS9qd6wADw==
X-CSE-MsgGUID: mm6nCDIZQ0+XdBor5E7vfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522671"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100522671"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:05:24 -0700
X-CSE-ConnectionGUID: 69ID/x0OQ7qB4JF8LbFeeg==
X-CSE-MsgGUID: CDiNqmjpQcCprYMaXOC/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227307237"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
 Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Date: Fri, 20 Mar 2026 06:05:22 +0100
Message-ID: <20260320050522.422355-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983124; x=1805519124;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8ZWGNDi1aSVI1IuxFKpsRXwy8mPHZadPbWAw94yJHdg=;
 b=cp8XB1B/5fdUy3INeXM/BwtJgX5ixxMw0b30nGzn/3VWzn3z1vx9+tG0
 5qygAuUHMHV3862rh3+QERC0hL/NAEEeVGpXQq8+onEn+ru2lqKdqNgpu
 Cn1/Eo3I3MNRAz6j+33508J0TDQVVrkPdy7OOSk/j41947HGFwP+ATU3b
 EBCAd73kKrcpFsboCmS4wXnZap51J+DBCVN+CLinLObNY0cB5R6AM3XPy
 5Rxdeh3Svo2qgD9GM4AlrdirjxCl6RbMZYWaTgCrn6N7dvZbkMlzSp14z
 TGk+n1k+e0fNHvlIUPCQ8OlnF31dEXW42rwKKsMOJWyTlEoqV8I2X4BrO
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cp8XB1B/
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: call mutex_lock() before
 mutex_unlock() in ice_dcb_rebuild()
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

From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>

In ice_dcb_rebuild(), the first call to ice_query_port_ets() is checked
for error, and on failure jumps to the 'dcb_error' label. The error path
always calls mutex_unlock(&pf->tc_mutex), but at this point in the code
the mutex has never been locked -- mutex_lock() came after the check.

Releasing a mutex that was not locked is undefined behaviour and can
cause a deadlock or crash. Fix this by moving mutex_lock() to before
the error check, so that 'dcb_error' always pairs with a prior lock.

Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..d516734 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -538,12 +538,11 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	int ret;
 
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
+	mutex_lock(&pf->tc_mutex);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
 
-- 
2.52.0
