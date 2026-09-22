Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74647C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47CDB80E2C;
	Tue, 22 Sep 2026 18:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yi3yciFprBMo; Tue, 22 Sep 2026 18:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0702E80E30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100511;
	b=VWQiru2hMH8iPBKsDg0JZzbeHXLTMr1DnXlgnrpVvaaHIdPye9rzN1m+ci4Vvf3qfHiW
	 SZ0dYhcFoj50GRwhlu25P05Ti7P3hC5xo4tdauLJjyqLuCqCw6t1L3DS8n4lVF3pY2WWs
	 5TikiaQIgnFF75UTgQ8BYGBDzw+5/W5o26RxtC3qkcMVMpfZuV5twknUP05jo1T/2AkHN
	 3BapYkVuVL/HKByG/3YN5QW0ZdMgdmqfluh4scBd4aDY/PYTLQMazrIA16Ijjf+CyIk8b
	 95o92PEd4I8YX21kADC3k9HJIBxBdZOOc5NLrn/60gkm+9n5iWOOtpZY2e72/DhyEXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=brWuEK3RrZyE+gZNCBhKuPYvpBe5knc5GyLt31LT4Bc=;
	b=Gi3GOEIz3GDAo11YgyMlSGMtHipdA50fA68hUifmexwEWHv982C4gF81rpOwV5HngsZ6
	 QfwAAzexVXz8NrUN2xJPLGgsa+yB1UjBEKxXhfT+2/+8A2kAnmB0SD6uukfHWWojpv/08
	 2GgXL8SKDi5chJVTh6yc8vghic322FnCtuSJOr6j4yz3fQTlQNgH36+c0ryxGuSRZQNYM
	 VXXZ8VOQCq1ajdGWxFvnlQtnNWV1p6/ltTFPMsFw8qESvC4ZSB42zxJEO/kPnaU+lUXKt
	 zfrQr8ochOsV/D/4UvGcHEz9aGaUqhvmml/SOSSToagFlA4RXh0A5IRUfYgjceXwINQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100511;
	bh=brWuEK3RrZyE+gZNCBhKuPYvpBe5knc5GyLt31LT4Bc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FsyskImV/MQdXZCZFz3YfMgQmu6k5cKzJgV9CKifZtpf2qQEG73EHhwYXHaLmN5o9
	 ck/oI/+lqypi45bwp5f9bee4mdtDWeITu6Bkcaa6Kx73kqMwbCtpMvy/2vgTyfp+/E
	 RH2KQqiGJf85+NXdx1YtHXP+ft0YpctfX+IT9sRFGorA/kGT/jLkslsKu3nKs3V0fK
	 vn4x5vzNRZeDCFZ+LCI98pGcU07/c+4yo+u/lN+++7vMgurkFQz1bu/IlC49z2uUY9
	 zPDra6D4l4P71AKwq1IU7CJpLmQavt49wSl71bnmSeUzAZwsw+dZlS7sCDegKLud3z
	 ZIhEi/1wQeGhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0702E80E30;
	Tue, 22 Sep 2026 18:08:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56F7A4DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49096406FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSoKJ5tXDcf2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DDAA740738
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100506;
 b=MDBfqJomXXMz2VsQfK240szbxMGqbQW4PBqCD31qG4R5oKQNVYUJ3Q6oQzPls0lFFI/p
 SbSiQYQku863/HumXSB0l5yk1WVB6iuN4VtSji7ITh4I9qX/QdbaRAh8qul8q6CgCK+bI
 k7RZ/Yqaw8y+P7FWNLWv0B92AV/IkAJYWPTLrocRNb3kNzWga23VkIWU3mNW+AF52pAtg
 XJBkeZWHqW8QUKPB/BrRbSCSWAjsji7Y5gxrxKVHrYX16vYgqWIM/VJaByZcu+heEvtSS
 rx6V52dIC75ePnO2cMSpFecURljCruDQctJOLpdQcbJJWuvBVOTk0axhQIxZFMBTQvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100506;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=brWuEK3RrZyE+gZNCBhKuPYvpBe5knc5GyLt31LT4Bc=;
 b=QHbuh/pym0if40lQqHVWjDBeysMpnquXtbdL9t0nplKSG2MrS2yam41iHmezbbcTNSln
 EhG9R7NcQx81KvCp4kTnmQNsmesnSfg6kmqvP8GwbMFMYG+kBHeMW95VEj4yZNmmZwFv3
 HjV68EBCpy3KufakygntKVhAyFO/QltnzQy1EfuvqlqaCtKZp/8ihsUXciAGDYGMkm2B7
 sDOAtFOvcX91aOMWJWs8YiEbLwhKIKhRQNXHComnFdV+9oFRmbjiWcS6Y4K72ngEwg/Cn
 wudymuE7BjOtRH9RKgSQDMO5cQ1/8JLIYCjh3DTkCzN7Zwk38k6I/BpBOUH+ULpAtOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=apa+JANk; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=apa+JANk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDAA740738
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100506; x=1821636506;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=4wCDOyziBOu4gO18LdSrXmIWl11gETaRVITSib1xIL4=;
 b=apa+JANkqtQk59BcxYTybo/F+AP9dhw1A4rzvzNem1OEzXOWO+oABoR1
 QJpImzBMNGehFmM92amzEdb//xJeww67HPlG+pSk6qlRBUBhE3ejpdfRE
 Y1NZg3ZfzJcx7VPKKEvSEmQvNBrNQ4KA1A7xxC2yBqRUqMMU0+cKSTuX2
 r+L8UxneAaCuGSA0jBS2hSzUC6EyW9jRzx6JgfgNv1cq3u7C3rTGa1eW4
 dTyPT3rpFPAH+i1dhanskX+7XKGhLJ3+TmdkCsZs30KiHWiUIhmYs7G3G
 Q006yAV3MNDvVt1jxUVhblRKtdq9QZzTbMf6S+UnE6g7WZ3TTd8IaDi/U Q==;
X-CSE-ConnectionGUID: TfKsrbQeTtee9X+r+hY2uw==
X-CSE-MsgGUID: LSn3YhsFQIWdAeCaGCQcFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232027"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232027"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: R06FdyhSQqiT2hyD2DeKnA==
X-CSE-MsgGUID: P+8DZGTjTZCi/tJvFSSDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315295"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:35 -0700
Subject: [PATCH iwl-net v2 02/15] ice: fix PHY port restart serialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-2-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=11774;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=4wCDOyziBOu4gO18LdSrXmIWl11gETaRVITSib1xIL4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNhyWnLxaOfH/uRMqCXaq22yb+lXndn36zIqtj+eXNb
 36W2/1P7ShlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAiEcYMf4Uys+5+ZN15s6bW
 oy55WmrZqdkp7v+rFJIeabcxV6ZanGVkuB2W73Qu/fg9hlzFXXc3Obiftnj6Vvr+UbcDQklW9lY
 xvAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice_port_phy_restart() function is responsible for restarting a PHY
port, primarily after a link transition. PHY ports must also all be
restarted after a reset, and the E822 devices also restart the PHY after
the .settime64 operation.

If a PHY restart occurs concurrently with a link transition, it is possible
that the link state read could be re-ordered such that the link transition
would start the PHY but a concurrent restart (such as from .settime64)
could see the old link state and decide it must stop the PHY.

This occurs because the restart procedure depends on the link state value
but setting that value is not serialized with the per-port ps_lock. A
following fix for E825 is going to modify the .setttime64 to also correctly
restart the PHY timers, opening the E825 device to a race between
.settime64 and a concurrent link change.

To avoid this, we need to ensure that the port link_up field is set within
the same critical section as the restart procedure. This way we ensure that
the end result is the PHY programmed to the correct state.

Additionally note that the PHY restart procedure already cannot run
concurrently across two ports. The procedure requires executing timer
commands which in turn require the PTP hardware semaphore.

Thus, to simplify the locking behavior, convert the per-port ps_lock to a
single mutex in the ice_adapter. Acquire this in ice_ptp_restart_all_phy(),
and hold it while calling ice_ptp_port_phy_stop() and
ice_ptp_port_phy_restart(). Modify the ice_ptp_link_change() function so
that the ptp_port-link_up state is set under the lock.

The switch to a single lock for the adapter instead of one per port is
easier to reason about. It also could be a first step in a plan to replace
the PTP hardware semaphore completely, which is under investigation for the
future.

A final note, this does "delay" the assignment of the link_up field which
is used by the Tx timestamp flow to discard timestamps that were expected
to never complete. That entire flow is modified significantly in this
series. The potential delay in reporting link_up is safe, as it is used as
an indicator but the logic must be correct even if a new request comes in
just before we report that link is down. See the following changes for more
details.

This fixes one of the issues reported by Sashiko during a previous review
of this series, linked here as the Closes tag.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  2 -
 drivers/net/ethernet/intel/ice/ice_adapter.c |  3 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 66 ++++++++++++++++------------
 4 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 93f041943bdd..926918e9d98d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -40,6 +40,7 @@ struct ice_port_list {
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
+ * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -53,6 +54,9 @@ struct ice_adapter {
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
+	/* For serializing PHY port start/stop sequences */
+	struct mutex ps_lock;
+
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index da2003ba3bb0..27ea502b7576 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -143,7 +143,6 @@ struct ice_ptp_tx {
  * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
- * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
  * @tx_fifo_busy_cnt: number of times the Tx FIFO was busy
  * @port_num: the port number this structure represents
@@ -155,7 +154,6 @@ struct ice_ptp_port {
 	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
-	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
 	u8 tx_fifo_busy_cnt;
 	u8 port_num;
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 84ac5ee5a739..cdfca26e8631 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -71,6 +71,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	INIT_LIST_HEAD(&adapter->ports.list);
 	init_srcu_struct(&adapter->ports.srcu);
 
+	mutex_init(&adapter->ps_lock);
+
 	return adapter;
 }
 
@@ -81,6 +83,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
+	mutex_destroy(&adapter->ps_lock);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9881a7a9e570..4422588472d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1191,6 +1191,8 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
 /**
  * ice_ptp_port_phy_stop - Stop timestamping for a PHY port
  * @ptp_port: PTP port to stop
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
@@ -1200,7 +1202,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	mutex_lock(&ptp_port->ps_lock);
+	lockdep_assert_held(&pf->adapter->ps_lock);
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
@@ -1222,8 +1224,6 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d down, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1234,6 +1234,8 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
  * Start the PHY timestamping block, and initiate Vernier timestamping
  * calibration. If timestamping cannot be calibrated (such as if link is down)
  * then disable the timestamping block instead.
+ *
+ * Context: must hold the adapter ps_lock.
  */
 static int
 ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
@@ -1244,11 +1246,11 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 	unsigned long flags;
 	int err;
 
+	lockdep_assert_held(&pf->adapter->ps_lock);
+
 	if (!ptp_port->link_up)
 		return ice_ptp_port_phy_stop(ptp_port);
 
-	mutex_lock(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -1290,8 +1292,6 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
 			port, err);
 
-	mutex_unlock(&ptp_port->ps_lock);
-
 	return err;
 }
 
@@ -1310,12 +1310,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	ptp_port = &pf->ptp.port;
 
-	/* Update cached link status for this port immediately */
-	ptp_port->link_up = linkup;
-
 	/* Skip HW writes if reset is in progress */
-	if (pf->hw.reset_ongoing)
+	if (pf->hw.reset_ongoing) {
+		mutex_lock(&pf->adapter->ps_lock);
+		ptp_port->link_up = linkup;
+		mutex_unlock(&pf->adapter->ps_lock);
 		return;
+	}
 
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
@@ -1354,21 +1355,31 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 			ice_txclk_update_and_notify(pf);
 	}
 
+	mutex_lock(&pf->adapter->ps_lock);
+
+	/* Update link_up under lock to ensure a concurrent restart attempt
+	 * can't re-order the read and end up stopping the PHY after we start
+	 * it due to a link transition.
+	 */
+	ptp_port->link_up = linkup;
+
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
 		/* Do not reconfigure E810 or E830 PHY */
-		return;
+		break;
 	case ICE_MAC_GENERIC:
 		ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	case ICE_MAC_GENERIC_3K_E825:
 		if (linkup)
 			ice_ptp_port_phy_restart(ptp_port);
-		return;
+		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}
+
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -1434,18 +1445,11 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 	}
 }
 
-/**
- * ice_ptp_reset_phy_timestamping - Reset PHY timestamping block
- * @pf: Board private structure
- */
-static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
-{
-	ice_ptp_port_phy_restart(&pf->ptp.port);
-}
-
 /**
  * ice_ptp_restart_all_phy - Restart all PHYs to recalibrate timestamping
  * @pf: Board private structure
+ *
+ * Context: acquires the adapter ps_lock
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
@@ -1453,6 +1457,8 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 	struct ice_ptp_port *port;
 	int srcu_idx;
 
+	mutex_lock(&pf->adapter->ps_lock);
+
 	srcu_idx = srcu_read_lock(&ports->srcu);
 	list_for_each_entry_srcu(port, &ports->list, list_node,
 				 srcu_read_lock_held(&ports->srcu)) {
@@ -1465,6 +1471,8 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
 	srcu_read_unlock(&ports->srcu, srcu_idx);
+
+	mutex_unlock(&pf->adapter->ps_lock);
 }
 
 /**
@@ -3329,8 +3337,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	mutex_init(&ptp_port->ps_lock);
-
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -3437,7 +3443,9 @@ void ice_ptp_init(struct ice_pf *pf)
 		goto err_clean_pf;
 
 	/* Start the PHY timestamping block */
-	ice_ptp_reset_phy_timestamping(pf);
+	mutex_lock(&pf->adapter->ps_lock);
+	ice_ptp_port_phy_restart(&ptp->port);
+	mutex_unlock(&pf->adapter->ps_lock);
 
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
@@ -3452,7 +3460,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	return;
 
 err_clean_pf:
-	mutex_destroy(&ptp->port.ps_lock);
 	ice_ptp_cleanup_pf(pf);
 err_exit:
 	/* If we registered a PTP clock, release it */
@@ -3480,7 +3487,6 @@ void ice_ptp_release(struct ice_pf *pf)
 		return;
 
 	if (pf->ptp.state != ICE_PTP_READY) {
-		mutex_destroy(&pf->ptp.port.ps_lock);
 		ice_ptp_cleanup_pf(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
@@ -3502,8 +3508,10 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
+	mutex_lock(&pf->adapter->ps_lock);
 	ice_ptp_port_phy_stop(&pf->ptp.port);
-	mutex_destroy(&pf->ptp.port.ps_lock);
+	mutex_unlock(&pf->adapter->ps_lock);
+
 	if (pf->ptp.kworker) {
 		kthread_destroy_worker(pf->ptp.kworker);
 		pf->ptp.kworker = NULL;

-- 
2.56.0.rc0.395.gd1f3524e15dc

