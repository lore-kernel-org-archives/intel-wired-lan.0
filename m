Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2768C9831D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9086B40CD6;
	Thu, 24 Sep 2026 12:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9PyHwbp5dOS; Thu, 24 Sep 2026 12:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B6AB40CDC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254779;
	b=XfxCglUcdpIy6ckls0mH8mEEyeIMcb/KP2YJ+MZCrVRqE94pe+d7QMNZOtkT54Wkkg7v
	 tK0NdH3V4b6+y89GjEexyz6MLNPcJ4k51WF4qiDZgdb0bd1ar0Enr0/IR7C+eu7OYUXIB
	 SZZ45JIzAdQvisjly35uCPOSwhm3sAgDEdATb/gkDxg+j4/5bSfCjNMKtbdWbg8DaveKd
	 +RRwY8f76WMuTdMl2wl/NRXEgQNSm0apvX3G4Bs/MT9cxRMP50hnvxnT7tP9LZ13ejs/O
	 k6XXiNqxgHdDegekSwP969t1hVdxQZiVbeXb3Ho5zmCs9omYiH9kZAbhN5JMmzQbF2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254779;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NMJRkb5P21AHtDGDTdMDmbeEU2mqY4xrFAMSVB8Bw70=;
	b=tN4C9Rpc/WYTP2A2r43iF2MvQqE2cPS3Dj6bqpUUU854e9n7dAS1gznLw8inU0jN9ec8
	 Yni9WyQTtJNDcPUSijnKVnnDUlA7xkawy/vcRFz5ZTj/fF6p9adPVQv7ZnVyb0qWGYUmv
	 e7r+gImBoAKx7zYslb+BmO+38izIC4LoCy3dDlpVqoNW862rrRDHTNb2XwkcWjeiAAAV8
	 zIUqEafya3FMj/n2hj4S1kDQB8GrY/O6j4YKgcJeoTUf8hvC9PA72LTNK+PslGcGzyOEP
	 DbcH2WFDYaw0PUO2QfDHxVI8jbVsrRkr9MMV+NIMJfx3DVA4YniO2wyaBB6KUoNeBrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254779;
	bh=NMJRkb5P21AHtDGDTdMDmbeEU2mqY4xrFAMSVB8Bw70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bmYTfeMj8kOqxZJPfi6SVeT38B2IO1u6SnfQUAFPxhPKFnU1WdB2GBgCR53apDgjN
	 ovYS/UvIjW6+pa2H/yLx0QRHXAe0s16w4WenPZLmDoOgvrnMsHZLgxa6LZMfLjI0XX
	 wjmq/AUW5GpDQ0oRkBg7m9kNJQMkk0VWFeKgZnQ9zaxYHJ7X0b0NUbQ51McxLdCLMo
	 d805yDLRdssrSM1+GMY0S2VvgdoiVRgWD6vJyxgY/Ra8Oro7WSdm94t4hmPZOhk8eo
	 grAV3my5RFEPUeJvOvfyk2zyvHmDTTtOUCspB56olMXYmAPtsU1uu0aGUwWDstZbY6
	 D4pLLNE7Sv0pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B6AB40CDC;
	Thu, 24 Sep 2026 12:59:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60242194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5266660807
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtJJFoQlcs0x for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4261E6082D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254772;
 b=SxT8mKYaMZi1eLMvKzE5MDheJySwoMeA0xDuGSqQRy7SHJnOC4N1d+Q8L+X9iRGQLZZr
 /ILWBpIzmT5OZSg7ICRYqTRzhYuHcpSozHaDYjDPpHVHp6M0t5xqsKTibxmPNNjKY/z0w
 gogHC8B9F7ItyBYCTuC+7xJwMAQS8JJyoMKG4a4hImt1Ul56PAeZCo0qoJ7Th/j7vgWK6
 7k8Yj/YLW+kBTXRX3E84g/szlNjMiTOMsHrVZLhxAZFgYWHp3IjhH8EUHKFDkPymebfNi
 rgENsp0cGEu9syq7GaJFWNOTx6Q9MPxNVqphYASdxqbANAALaxpWtkwCWn1sphZBVkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254772;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NMJRkb5P21AHtDGDTdMDmbeEU2mqY4xrFAMSVB8Bw70=;
 b=A6kGAGFg3SiXZWX1e4Lon8Vulsf3gPNqv6rsrXOm9pVYjlzcb9+0jYYthmpXZYwY0JLj
 9u2RXF1+j0mo38IocoaN72hY2cu4tNEw4t+kP63z94enJyy3WwvMXQkKdVHs6Z11SO5To
 OBHhZP1YdFrRYbPceZr8s2efXOvRheRPAe4XNJl686KpUU7I4kVhktHne6E54k+MEU+e9
 +iaKcc69FxL5jo+cAeuW2YbzvQvzYQrglbXdoQrPKhUywyJDGwBoICREWBaYYxHfDyB5B
 R6/J3dFVNna8rzUzgvJ8JulfbEOgi5go28RO/Y5bi9lve9P7242P410s2VVRZjblGCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J+kshiA6; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J+kshiA6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4261E6082D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254772; x=1821790772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aaf1m91xnzH813tnvwtfaIyDWRoM2cZnDJhUGIqF7gc=;
 b=J+kshiA6h5l/TlJl39XeSg5oSYgSY9eeE0Tj/7VqE7nwx258qYdRMB2C
 AqSbblWEqvXsE16YJPhydbTzqkUvjVFN1KhRSEW77K/4RYGk+GWg1vnct
 HdbgDki3FoyjLTYhfWiKzROMWiGHv3aT3PtLqehMV2orvnABd35Hwne4c
 adTAJO4y3i1sO3+H7Z1wzx2583WUGItJLWrJ8HqgnvU6QXGoNroivVcXZ
 Z+Y0FlG6qFGC9F1PPSbkx/8NjlachyJIq2cn6KZ4esyS536jHP2oluABD
 vy2UHEo2jwb1hPQa5szoVPiKsJ1rfLfWxY3t1Dorer7uq+zx9vlerNAoJ A==;
X-CSE-ConnectionGUID: IK/m/ZCgSMSVaf6MtQe2sQ==
X-CSE-MsgGUID: TYKeHRMBRDCXmj3cVyfldA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249236"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249236"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:24 -0700
X-CSE-ConnectionGUID: Kstyg882R7m8s9+Ax42aHA==
X-CSE-MsgGUID: ZQ29WJM5QrKjOd03Hq5+gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934428"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:23 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v5 5/8] ice: Clear the control PF pointer when the
 control PF is removed
Date: Thu, 24 Sep 2026 12:59:13 +0000
Message-ID: <20260924125916.2796499-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Zero adapter->ctrl_pf when the PF owning it is removed and wait for
pre-existing RCU readers before its storage can be released. Without
this the pointer outlives the control PF, so sibling PFs keep
dereferencing it after it has been torn down.

The preceding patches make this safe to do: readers already resolve the
pointer once per critical section, and the PTP paths already reject a
missing control PF instead of falling back to the caller's own register
space.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Reported-by: Frederick Lawler <fred@cloudflare.com>
Closes: https://lore.kernel.org/all/aIKWoZzEPoa1omlw@CMGLRV3/
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3ee29c0cd726..3ed37bbae161 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3300,6 +3300,20 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
+static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
+{
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+	 * is being removed to prevent any secondary PFs from accessing
+	 * it after it is deleted.
+	 */
+	if (ice_get_ctrl_pf(pf) == pf) {
+		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+		synchronize_rcu();
+	}
+}
+
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
@@ -3656,6 +3670,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	mutex_destroy(&ptp->port.ps_lock);
 
 err_exit:
+	ice_ptp_cleanup_adapter(pf);
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3683,6 +3698,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	if (pf->ptp.state != ICE_PTP_READY) {
 		mutex_destroy(&pf->ptp.port.ps_lock);
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_cleanup_adapter(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
@@ -3697,6 +3713,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0

