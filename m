Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AD606A31A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=r253u3wq;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KeHakpj/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27FD060A75;
	Sat, 24 Oct 2026 01:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24d6FK9jRyfa; Sat, 24 Oct 2026 01:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1148960A66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792805158;
	b=HG4/7JkqpfBcLBdlSUZey/eJt3JSbzRMP4LFXk05YNt2c/4guy2mCOLBMV/nAc/NT4r5
	 adjhX+rCT4B2xFVYX8T2AUwht6CvoPwtj02ZNBZi/lNZOwf/5Ch4G1JvgWH82rtRScqrn
	 wYkHxJSEDiHsKU9zo0e0X72wINOnJLGXIwCV7MzkfUM2htBnR2on1M57v0B46hiII/hZU
	 L5/mhTelL7kVVSurJzXvsjEp7tdmdSw/HUUGxVR3NVI0+NVo+gJonlb4UckDAHwvsNkGF
	 /kpMOOLdK2No2PQRgqzrohdjfL67hC5haEwUoJAigsYcPbha6r3H7ppTm6nIeOxBitg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792805158;
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
	bh=jRHv/e4WO/rq2gDMk5Yw/C9mFPsYKXuhjATi3YJXnKw=;
	b=ppDO0nTvwzixt3VbRnVPdT+4yilpEeAfsorMwDPX8yWmN9jhHGCaOUrtc+EgtBI3rSUG
	 iKn42g/2RryK7tSCRoZWvWhdgfRZMLVnc/xxO+Pfyad+9d2aOTJyFs13dyCPo6scQkEHN
	 h6kiBnZ/UTYoQGRaaB//HvwW5bj9bGEnew3D6GI84GEsQ8pht3odXH/0PvVu4PHqD54aj
	 yCo0x4RtLnDfqHr88d3VHb6bHiu1Y7ggcUNeqEZd5PY4ERu93Y7jPz8eZqvYBXkVLxXZy
	 5RMnQhDAGGFi0cuE9mGutDKpmWk25aZklIUghO5WsRaq9kb+ODn9H7XZeKjdZyAZqtg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792805158;
	bh=jRHv/e4WO/rq2gDMk5Yw/C9mFPsYKXuhjATi3YJXnKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r253u3wqD4AnhWlTUlh03pRhOGCSE/NKG44r0+JLz5t0QTkAw00pMd86r0f46Yoe+
	 JxF+SoV3rEf5zG3I3pX7lhmUPgwLNoH3/45MrCRXnJB/WK3gfrFiEg1YAFK0G47fIh
	 /22dp31pQ2jOg8aeX9KIktUoCbVUV/WXHGIsHSiXR8y+rffkcgmt/S6eUDrTF4pFuq
	 sd86pu8SFnomAU4ddElU1kSlncTOuanoOPZRo70afWRS/eLbnpcui2Tzg2pkGm+4Jr
	 OU0sXr0ziDoebbSBPi2J4pU5E2xf4eDkYOyhv59iKkcwKn5KdbTfOqLb3REeI8qPhf
	 YI5uY/usAplyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1148960A66;
	Sat, 24 Oct 2026 01:25:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F7F943
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 258AF40068
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKQCe2S7p_0O for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 01:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 952EB400AF
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792805154;
 b=IqMSNyw2l9BXOnj4mClhjMP+Ejw94web+15sQSiqItZHZWuH6C5wuApZpRi9siWbS/vt
 PYZeW8fIWvZ9BY+aDbyHYYDjyLUaTr/4OJWWC0BLI9mK+gDLCc+mcZQ+XEVO9pNbqjsQ3
 vW816tNaEG7lhPWmQ4N6ghO8BMcXx6HaI0B5Vfbqm5naJKmzECraKrxFBNGy0i33auySH
 dqe9XElKpOntFhBblK5mY5kWtjumb+hY7SzKLl7sU9W1xltfvR53mVmi1cDfOIlWOe/tR
 /RBbwyXTCH5kAH+luUpK41088NOuDy1yuVFvrtUinoCNQzyTk8wiWGZ31ZkNJYcwRTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792805154;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=jRHv/e4WO/rq2gDMk5Yw/C9mFPsYKXuhjATi3YJXnKw=;
 b=nx9USuKdTXoKxRaTH94h67RrLZDcswF0Ar0NUifjCHl62MhxSxYGEOGIyTOf74+oRDWH
 FJ4r6WNHwUJCtnxgFMUq0usuGhctLwTGHMomUJS8cjrP2AbBeieoECXJAg9j233jvxffm
 FgQoQ/CeOR+807ZBXITc5ri6HEupt/OTT4DcBInqG2MVCeoQqxERPAhDXvTF/qt5X8Sno
 +qDMvIU2Z9OK4vX7X/xNq4DKPvUzOn2LiFQgdXYBgkwk19XihRYka+poEmnjH4ZCIWanI
 VzLdC1kHyYw9I4oICceHygOAV369jO09ANd+lsBVBg4QZuS07x/DpPdvrp7fwQEkoEA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="KeHakpj/"; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KeHakpj/
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 952EB400AF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792805155; x=1824341155;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=P/HKAdXPo/m38pII1fnIaC/ZhL9kKFXm2Ee9B0GG+8k=;
 b=KeHakpj/iGcYyQRGAUY7f2Ma6X6+qx2PH3Om6w+SAypLq+FThjGLtmfI
 i4DcfH9eOfvPU5GacnQSQJM8WfVjJgYE9xQYcBjSaDobqkMQHVAEQ1PFJ
 73u5DanRcdjWYuM5QDIgVPdSe9g9rJndsbREnD5OoiRuFNXYCQO+FQ6Hi
 DtTLx+G2u4fNWCWMgThRkIEQj9vqRVLo9ncAzSf6wiclCHKG9At6Ye0Ru
 yvpRCllwqEmwbvQyufqjwkQHD0oFcNe3LkzR9hsNnKMQrbPP/rVgPFXZP
 0Em9lA7GiGqInvjfsWUIs4edLVE61EBXkYWPqZNuAq+V5gc4mi9OGoIO2 w==;
X-CSE-ConnectionGUID: h/aTB4QXQ/65vN6znEne5w==
X-CSE-MsgGUID: kyZ/AyxNTS2kDKrxcDR7ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1579037"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1579037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 18:25:53 -0700
X-CSE-ConnectionGUID: 2dd9ILQYQhyegDgsCjLZmQ==
X-CSE-MsgGUID: cCavcZgkTUWTzHJM5eePLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3890848"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 18:25:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 23 Oct 2026 18:24:29 -0700
Subject: [PATCH iwl-net 1/2] ice: store cached PHC time in ice_adapter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-jk-e825-e830-timecounter-v1-1-e932602f0d16@intel.com>
References: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
In-Reply-To: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=18886;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=P/HKAdXPo/m38pII1fnIaC/ZhL9kKFXm2Ee9B0GG+8k=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw7nFJBDc8t7rIXuOu2z5eaxMj6pi83a/o/wcLLK+Zt6
 v34M8yjo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlcv8TIcNBa0DTtasvR1uJo
 70UPY0/vrVZ58bc0N/1C7HY/h7vWlxgZlgixvzg/dX3MskmXz/aGXDhYpBm6+3RrYtOXrJbgOvZ
 mVgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ice driver uses a cached copy of the PTP Hardware Clock time for its
timestamp extension algorithm implemented in ice_ptp_extend_32b_ts(). This
algorithm is based on work originally from struct timecounter, and relies
on a cached copy of the PTP time used to extend 32-bit snapshots of the PTP
time into full 64-bit time values.

The driver currently stores this cache once in the ice_ptp structure for
each PF and once per each Rx ring on each PF. Each PF is then responsible
for calling ice_ptp_update_cached_phctime() at least once every 2 seconds.
This is handled by the per-PF periodic work task that runs on a per-PF
kthread. Each Rx ring must be updated, which requires looping the VSI and
ring structures, and might fail due to the rings being reconfigured.

In order to fix some device-specific bugs, a following change is going to
refactor the driver to support using a timecounter structure to avoid
needing to perform direct time adjustments in hardware on E825 and E830.

Use of a timecounter will require the that the Rx path have a reference to
that structure. To ensure that all PFs on the same device have the same
time domain, the structure must be part of the whole adapter, making
ice_adapter the best place to store it. The initial implementation will
focus only on migrating the E825 and E830 devices, to minimize impact and
potential regression.

Since the Rx path will need to reference a structure anyways, it makes
little sense to maintain both a cached copy of the PHC time in addition to
a pointer to the adapter.

As a first step, refactor to store the existing cached PHC time in
ice_adapter, instead of per-PF in each ice_ptp structure and the Rx rings.

Create a struct ice_phc structure to store the PTP Hardware Clock fields,
and embed it in ice_adapter. Store a pointer to the PHC structure in the Rx
rings, replacing the cached_phctime.

Pass a pointer to the PHC structure to ice_ptp_extend_32b_ts() and obtain
the cached time from that structure.

Modify the ice_ptp_update_cached_phctime(), removing logic to update the
cached time within the Rx rings. Convert it to a void function since it can
no longer fail in a meaningful way. Note that the previous logic could
return -ENODEV if ice_ptp_read_src_clk_reg() couldn't access the PHC.
However, the existing callers do not meaningfully respond to this error.

Change ice_ptp_periodic_work() to check ice_pf_src_tmr_owned() and only
call ice_ptp_update_cached_phctime() for the clock owner.

Separate the PHC reset time from the cached time value in
ice_ptp_rebuild_owner(), rather than relying on the cached_phc_time. Read
the value of the PHC time near the same time that we save ptp->reset_time.

This eliminates the failure point on updating the cached PHC time, and
reduces needlessly duplicated work of having each PF update its own cached
time copy. The Rx path now requires accessing the PHC structure via a
dereference and this may theoretically impact performance due to changes
in caching. However, the timecounter refactor will require doing at least
this much anyways.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  13 +++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   6 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 145 +++++++++------------------
 6 files changed, 64 insertions(+), 108 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index a91f99f4ce30..a56dc5306541 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -34,6 +34,16 @@ struct ice_port_list {
 	struct srcu_struct srcu;
 };
 
+/**
+ * struct ice_phc - PTP Hardware Clock fields
+ * @cached_time: Cached copy of the PHC time for timestamp extension
+ * @update_jiffies: Jiffies when PHC was last updated
+ */
+struct ice_phc {
+	u64 cached_time;
+	unsigned long update_jiffies;
+};
+
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @refcount: Reference count. struct ice_pf objects hold the references.
@@ -43,6 +53,7 @@ struct ice_port_list {
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
+ * @phc: PTP Hardware Clock fields
  * @ctrl_pf_lock: Protect control PF lifetime for sleepable users
  * @ctrl_pf: Control PF of the adapter
  * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
@@ -63,6 +74,8 @@ struct ice_adapter {
 	/* For serializing PHY port start/stop sequences */
 	struct mutex ps_lock;
 
+	struct ice_phc phc;
+
 	struct rw_semaphore ctrl_pf_lock;
 	struct ice_pf __rcu *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 40a0e654c2c6..430441b43150 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -235,8 +235,6 @@ struct ice_ptp_pin_desc {
  * @tx_interrupt_mode: the TX interrupt mode for the PTP clock
  * @port: data for the PHY port initialization procedure
  * @work: delayed work function for periodic tasks
- * @cached_phc_time: a cached copy of the PHC time for timestamp extension
- * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
  * @kworker: kwork thread for handling periodic work
  * @ext_ts_irq: the external timestamp IRQ in use
  * @pin_desc: structure defining pins
@@ -248,6 +246,7 @@ struct ice_ptp_pin_desc {
  * @tstamp_config: hardware timestamping configuration
  * @tx_refclks: bitmaps table to store the information about TX reference clocks
  * @reset_time: kernel time after clock stop on reset
+ * @phc_reset_time: PHC time at clock stop on reset
  * @tx_hwtstamp_good: number of completed Tx timestamp requests
  * @tx_hwtstamp_skipped: number of Tx time stamp requests skipped
  * @tx_hwtstamp_timeouts: number of Tx skbs discarded with no time stamp
@@ -270,8 +269,6 @@ struct ice_ptp {
 	enum ice_ptp_tx_interrupt tx_interrupt_mode;
 	struct ice_ptp_port port;
 	struct kthread_delayed_work work;
-	u64 cached_phc_time;
-	unsigned long cached_phc_jiffies;
 	struct kthread_worker *kworker;
 	u8 ext_ts_irq;
 	struct ptp_pin_desc pin_desc[ICE_N_PINS_MAX];
@@ -283,6 +280,7 @@ struct ice_ptp {
 	struct kernel_hwtstamp_config tstamp_config;
 	unsigned long tx_refclks[ICE_E825_MAX_PHYS][ICE_REF_CLK_MAX];
 	u64 reset_time;
+	u64 phc_reset_time;
 	u64 tx_hwtstamp_good;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5e517f219379..83a34322e0d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -221,7 +221,7 @@ enum ice_tx_ring_flags {
 };
 
 struct ice_pkt_ctx {
-	u64 cached_phctime;
+	struct ice_phc *phc;
 	__be16 vlan_proto;
 };
 
@@ -321,7 +321,7 @@ struct ice_rx_ring {
 	union {
 		struct ice_pkt_ctx pkt_ctx;
 		struct {
-			u64 cached_phctime;
+			struct ice_phc *phc;
 			__be16 vlan_proto;
 		};
 	};
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 90fa11b22820..35dff5e93740 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3338,7 +3338,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		/* clone ring and setup updated count */
 		rx_rings[i] = *vsi->rx_rings[i];
 		rx_rings[i].count = new_rx_cnt;
-		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
+		rx_rings[i].phc = &pf->adapter->phc;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].xdp_buf = NULL;
 		rx_rings[i].xdp_rxq = (struct xdp_rxq_info){ };
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5bd9deca53e7..d4d97e3acc3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1533,7 +1533,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->count = vsi->num_rx_desc;
-		ring->cached_phctime = pf->ptp.cached_phc_time;
+		ring->phc = &pf->adapter->phc;
 
 		if (ice_is_feature_supported(pf, ICE_F_GCS))
 			ring->flags |= ICE_RX_FLAGS_RING_GCS;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ec24c0928078..4b4a00beadd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -274,7 +274,7 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 
 /**
  * ice_ptp_extend_32b_ts - Convert a 32b nanoseconds timestamp to 64b
- * @cached_phc_time: recently cached copy of PHC time
+ * @phc: PTP Hardware Clock structure
  * @in_tstamp: Ingress/egress 32b nanoseconds timestamp value
  *
  * Hardware captures timestamps which contain only 32 bits of nominal
@@ -310,13 +310,17 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
  * a second, and (b) discarding any Tx timestamp packet if it has waited for
  * a timestamp for more than one second.
  */
-static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
+static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc, u32 in_tstamp)
 {
 	u32 delta, phc_time_lo;
-	u64 ns;
+	u64 ns, cached_time;
 
-	/* Extract the lower 32 bits of the PHC time */
-	phc_time_lo = (u32)cached_phc_time;
+	cached_time = READ_ONCE(phc->cached_time);
+	/* Do not report a timestamp if we don't have a cached PHC time */
+	if (!cached_time)
+		return 0;
+
+	phc_time_lo = (u32)cached_time;
 
 	/* Calculate the delta between the lower 32bits of the cached PHC
 	 * time and the in_tstamp value
@@ -331,9 +335,9 @@ static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
 	if (delta > (U32_MAX / 2)) {
 		/* reverse the delta calculation here */
 		delta = (phc_time_lo - in_tstamp);
-		ns = cached_phc_time - delta;
+		ns = cached_time - delta;
 	} else {
-		ns = cached_phc_time + delta;
+		ns = cached_time + delta;
 	}
 
 	return ns;
@@ -372,7 +376,7 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 	u64 cached_time;
 
 	/* Discard the hardware timestamp if the cached PHC time is too old */
-	discard_time = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
+	discard_time = pf->adapter->phc.update_jiffies + msecs_to_jiffies(2000);
 	if (time_is_before_jiffies(discard_time)) {
 		pf->ptp.tx_hwtstamp_discarded++;
 		return 0;
@@ -382,13 +386,14 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 	 * how ice_ptp_update_cached_phctime() reports that the source clock
 	 * has become unreachable.
 	 */
-	cached_time = READ_ONCE(pf->ptp.cached_phc_time);
+	cached_time = READ_ONCE(pf->adapter->phc.cached_time);
 	if (!cached_time) {
 		pf->ptp.tx_hwtstamp_discarded++;
 		return 0;
 	}
 
-	return ice_ptp_extend_32b_ts(cached_time, (in_tstamp >> 8) & mask);
+	return ice_ptp_extend_32b_ts(&pf->adapter->phc,
+				     (in_tstamp >> 8) & mask);
 }
 
 /**
@@ -987,35 +992,26 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 }
 
 /**
- * ice_ptp_update_cached_phctime - Update the cached PHC time values
+ * ice_ptp_update_cached_phctime - Update the cached PHC time value
  * @pf: Board specific private structure
  *
- * This function updates the system time values which are cached in the PF
- * structure and the Rx rings.
+ * Update the PTP hardware clock time values which are cached in the PHC
+ * structure.
  *
- * This function must be called periodically to ensure that the cached value
- * is never more than 2 seconds old.
- *
- * Note that the cached copy in the PF PTP structure is always updated, even
- * if we can't update the copy in the Rx rings.
- *
- * Return:
- * * 0 - OK, successfully updated
- * * -EAGAIN - PF was busy, need to reschedule the update
- * * -ENODEV - no control PF owns the source clock register space
- * * -EOPNOTSUPP - PTP support is not compiled in
+ * This function must be called periodically by the clock owner to ensure that
+ * the cached value is never more than 2 seconds old.
  */
-static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
+static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct device *dev = ice_pf_to_dev(pf);
 	unsigned long update_before;
 	u64 systime;
-	int err, i;
+	int err;
 
-	update_before = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
-	if (pf->ptp.cached_phc_time &&
-	    time_is_before_jiffies(update_before)) {
-		unsigned long time_taken = jiffies - pf->ptp.cached_phc_jiffies;
+	update_before = phc->update_jiffies + msecs_to_jiffies(2000);
+	if (phc->cached_time && time_is_before_jiffies(update_before)) {
+		unsigned long time_taken = jiffies - phc->update_jiffies;
 
 		dev_warn(dev, "%u msecs passed between update to cached PHC time\n",
 			 jiffies_to_msecs(time_taken));
@@ -1032,36 +1028,12 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 		 * longer tracks the PHC, and both treat a zero cache as
 		 * "no timestamp".
 		 */
-		systime = 0;
-		WRITE_ONCE(pf->ptp.cached_phc_time, 0);
+		WRITE_ONCE(phc->cached_time, 0);
 	} else {
-		/* Update the cached PHC time stored in the PF structure */
-		WRITE_ONCE(pf->ptp.cached_phc_time, systime);
-		WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
+		/* Update the cached PHC time stored in the PHC structure */
+		WRITE_ONCE(phc->cached_time, systime);
+		WRITE_ONCE(phc->update_jiffies, jiffies);
 	}
-
-	if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
-		return -EAGAIN;
-
-	ice_for_each_vsi(pf, i) {
-		struct ice_vsi *vsi = pf->vsi[i];
-		int j;
-
-		if (!vsi)
-			continue;
-
-		if (vsi->type != ICE_VSI_PF)
-			continue;
-
-		ice_for_each_rxq(vsi, j) {
-			if (!vsi->rx_rings[j])
-				continue;
-			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
-		}
-	}
-	clear_bit(ICE_CFG_BUSY, pf->state);
-
-	return err;
 }
 
 /**
@@ -1070,34 +1042,11 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
  *
  * This function must be called when the cached PHC time is no longer valid,
  * such as after a time adjustment. It marks any currently outstanding Tx
- * timestamps as stale and updates the cached PHC time for both the PF and Rx
- * rings.
- *
- * If updating the PHC time cannot be done immediately, a warning message is
- * logged and the work item is scheduled immediately to minimize the window
- * with a wrong cached timestamp.
+ * timestamps as stale and updates the cached PHC time.
  */
 static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	int err;
-
-	/* Update the cached PHC time immediately if possible, otherwise
-	 * schedule the work item to execute soon.
-	 */
-	err = ice_ptp_update_cached_phctime(pf);
-	if (err) {
-		/* If another thread is updating the Rx rings, we won't
-		 * properly reset them here. This could lead to reporting of
-		 * invalid timestamps, but there isn't much we can do.
-		 */
-		dev_warn(dev, "%s: unable to immediately update cached PHC time, err %d\n",
-			 __func__, err);
-
-		/* Queue the work item to update the Rx rings when possible */
-		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
-					   msecs_to_jiffies(10));
-	}
+	ice_ptp_update_cached_phctime(pf);
 
 	/* Mark any outstanding timestamps as stale, since they might have
 	 * been captured in hardware before the time update. This could lead
@@ -2464,9 +2413,7 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
 		return 0;
 
-	cached_time = READ_ONCE(pkt_ctx->cached_phctime);
-
-	/* Do not report a timestamp if we don't have a cached PHC time */
+	cached_time = READ_ONCE(pkt_ctx->phc->cached_time);
 	if (!cached_time)
 		return 0;
 
@@ -2477,7 +2424,7 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	 * bits itself.
 	 */
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
-	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
+	ts_ns = ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high);
 
 	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
 
@@ -3078,24 +3025,20 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 {
 	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
 	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
-	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
 	ice_ptp_tspll_monitor(pf);
 
-	err = ice_ptp_update_cached_phctime(pf);
+	if (ice_pf_src_tmr_owned(pf))
+		ice_ptp_update_cached_phctime(pf);
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
 
-	/* Run twice a second, or retry soon if another thread was busy
-	 * updating the Rx rings. Other errors, such as a missing control PF,
-	 * do not clear up on their own and must not turn the periodic worker
-	 * into a busy loop.
-	 */
+	/* Run twice a second */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
-				   msecs_to_jiffies(err == -EAGAIN ? 10 : 500));
+				   msecs_to_jiffies(500));
 }
 
 /**
@@ -3190,6 +3133,8 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	/* Acquire PHC and system timer to restore after reset */
 	ptp->reset_time = ktime_get_real_ns();
+	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
+		ptp->phc_reset_time = 0;
 }
 
 /**
@@ -3229,13 +3174,13 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	if (err)
 		goto err_unlock;
 
-	/* Write the initial Time value to PHY and LAN using the cached PHC
-	 * time before the reset and time difference between stopping and
-	 * starting the clock.
+	/* Write the initial Time value to PHY and LAN using the PHC time
+	 * before the reset and time difference between stopping and starting
+	 * the clock.
 	 */
-	if (ptp->cached_phc_time) {
+	if (ptp->phc_reset_time) {
 		time_diff = ktime_get_real_ns() - ptp->reset_time;
-		ts = ns_to_timespec64(ptp->cached_phc_time + time_diff);
+		ts = ns_to_timespec64(ptp->phc_reset_time + time_diff);
 	} else {
 		ts = ktime_to_timespec64(ktime_get_real());
 	}

-- 
2.56.0.215.g47fdf2208c5b

