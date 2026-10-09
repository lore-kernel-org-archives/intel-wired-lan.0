Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C4FCA6019
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2085240949;
	Fri,  9 Oct 2026 12:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mk_RvH1kaQ2h; Fri,  9 Oct 2026 12:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 321FA40932
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548112;
	b=LYfgHOus89W1ovL9c/LaUCobSjcrk8NNdw0knYNceGi9Ju9TS6HxmTay3eKerynA74PQ
	 +CPaHpoBhXx7RzzG2OXk5EjCmtAI8zDY2aaWjlKyP2mJBkolx0X8qfGUqHe0VPvImVmNm
	 7Ukw0f5JJkF1ICp5z5sOP14ET2C1TL2dLEavXHV2etsCszQYVxRPeVSRvj5Ne4UKUhx5z
	 EixUO3IwxOcAQ8mhK3oPAXONHAqO/++8DWMjphzt4epZcao+0y/OGs8DtM/WibkNfHPzY
	 0tGdLYkcvfvVUuAmmtYSKkEni3GiGkn5PrYwSMVwddnqW9i5S3hjUap0HmGn941Z1zQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eCrBlxlgg/5jbIK9q40rro6J9FZtkbbm7GWaGtbbavM=;
	b=WmPxGSuRGdvi1gXj1noCIjhu7UVzGJgLZNMjesBU1gjSW+x85/7ZZHz8C54PuwOZAhEh
	 UIn8IV/zVnhW41T64iQyEHsVX0d+1Q17D0JAKK6uBBLnoibud/uTVFCp0J6raSyIhslBe
	 QtKvVuDMc2eN+JGQ9pCPkzlKBMQ56CYwzdH/+IdJnOtOl1juQQ2NywSiqgd0iBNKAijQW
	 w57ALahNEo0hF7+INpqqOuZqe0nrF9w4wLhv4jpbWy49GKZUb7rsGdVTGCESJeYVC3ngm
	 on2fqSW0+1R2AXhez/txmAmKwwVRlIzkuMkNgmE0JmS94QS7okiNEX+bxZtJRzmq6Ug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=foOFXhbR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548112;
	bh=eCrBlxlgg/5jbIK9q40rro6J9FZtkbbm7GWaGtbbavM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+vmceXIZ+FOYTk90jA9CurVgU2yaaIhTDzPGCyYVs05Y8Liiey7anbubm6R9xk0t
	 5+Vi+NWvjyeGZj568G4T0C/GHalOwzqbnEsBAY6zrV/LvBV9Hqf7/G4DlUsEMp6ey3
	 lkl7vVpPBpkNdzeYAQ7g+f7ytdElOsZ+AT/VR49d1h890UfB1aUXc8I9zuNnOe8Fp2
	 8Bp8/KYdBL/Ng+xwtAq530DwIzLYMtphOmZtmJHvFtXGDr5eCAV/YWV2bg7pINAV0a
	 R74lUHl4WHSOw8DcrH5FbsluE1adBpC8HAymGJ+kTVk/T16FUhC8J6Ad7g7Jh1uxBc
	 F5lmGW4P9oV9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 321FA40932;
	Fri,  9 Oct 2026 12:15:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2179317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84F5F40932
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJFn_OmbLS1O for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61E0B40923
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548109;
 b=VNyZGtuBDQMs1Vg2QEh0gcFe7w1xMyezIbFKYHlV0QModfSNOTb8Qa7yxnkgNfWTvAP2
 lIukDZSHEjx4v+UCQEDvIR18EOlCxf/jEiClVcg8OpmLfnS2W76fzPS+gQvUmlJMj47xA
 5q/PtNNrsNW7lFle/D34dHQfVn9059MK+vg5pSAw1wpYdlWYAoym2Vv2VJMG54wm5O/ES
 reUq96dUOaTfl9DNBKMBCTAGOy6vUIPeVP+KWhmNSTa7Iyq/28jKqEhuETVEs6boegOoQ
 2GfsWJSgHONYqmgtehkPdd7hgsT3MDnh1m+Fq/ymaGzU7sUCbPSHWMGO1weNzE8xtog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548109;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=eCrBlxlgg/5jbIK9q40rro6J9FZtkbbm7GWaGtbbavM=;
 b=j+RNF5Gjrj1V7+5L8/RPnGAiz4xXxrJvOYaQFmrf3J5Mv1zKxETh7Nhb2zivH1NSBxEO
 DQGEaf1/Bz+ghsqB0C8IyLdgdjmQqlD63cPKD8DfUYqzmkbzX5kAYgzIXMEpEcNVP0Akz
 iYX97es7eJx6pz6xCEWmLy18Z9IJbo3dWfio4sJHxC01920/1lvigeK8UKp8xUh/920lF
 SyumtWvO3edXhqRv/fl8rqXhLh+j74+ZpO2CbLgu8xz/qbGdDLPwos/wUhNoCT2fTBhPk
 EGhV9mT0QNXYd6K6rYEhpJpGwvd+zF+kwdqq5iCLHCRDt2enEfrthmybqxFO64ME60w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=foOFXhbR; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=foOFXhbR
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61E0B40923
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548109; x=1823084109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cAgUU3mssy27VlQMv6zXNVxU4BKbNugrl2rfr7YqrVM=;
 b=foOFXhbRMN3NWGQHszG7WTcGSADO7zqk5lH2XVx6pplE3UbKr5o0ELLf
 HZ0MxzCAaigid/5QP9U7W2xm1R026HYS/teC2Uzbmjzmle+O60sQeE9fZ
 TZh/6p+s3JjnePnGHaQ1rNQXpEbfEY7yMt57pnH9Njx6tEH680unHpI1B
 QoTsuXPCd5QtrleATGaT94fuKeui3Smf3k/emUkRgbH56M05Zy/xkHdP3
 WTCQsYct6XzTWrozfdUTTJfu4aFBDKLHVy0rk9BhrrXkYu6wvXMImYIgP
 9v6sI5Ul/j+c/IE1GdH4QcFXFwm9kxyG0kDivfbMtdSxIoOqyG+z3ZnLz w==;
X-CSE-ConnectionGUID: KHgCExA8TOa2n+ZQ/Iytsg==
X-CSE-MsgGUID: tmdmWiqvTnqIimQy2Kz3Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251232"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251232"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:15:07 -0700
X-CSE-ConnectionGUID: 140+3WLqRfqOaxCJNyWjUw==
X-CSE-MsgGUID: m2vYVG6bRA2x1EmjK4fVPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420517"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:15:00 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id ECA7F2FC44;
 Fri,  9 Oct 2026 13:14:57 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v2 10/14] iavf: use new opcodes to request more than
 16 queues
Date: Fri,  9 Oct 2026 14:04:21 +0200
Message-ID: <20261009121433.30347-11-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
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

From: Ahmed Zaki <ahmed.zaki@intel.com>

Legacy virtchnl opcodes select queues by fixed width bitmaps: u32 for
VIRTCHNL_OP_ENABLE_QUEUES and VIRTCHNL_OP_DISABLE_QUEUES, u16 for
VIRTCHNL_OP_CONFIG_IRQ_MAP. Define new OP codes in order to enable
the VF to use a variable number of queues.

First the new capability VIRTCHNL_VF_LARGE_NUM_QPAIRS is defined. Only
if this cap is negotiated, the VF is allowed to use the new OP codes.

The VIRTCHNL_OP_GET_MAX_RSS_QREGION is exchanged right after the VF
resource message is received. This is done similar to the PTP and other
extended cap exchanges.

Enabling and disabling queues, and mapping queues to vectors is done
through the new VIRTCHNL_OP_ENABLE_QUEUES_V2,
VIRTCHNL_OP_DISABLE_QUEUES_V2, and VIRTCHNL_OP_MAP_QUEUE_VECTOR messages.

Use the new iavf_request_queues() in the iavf_set_channels().
It's not only for elegance, but it enables our brittle handcoded state
machine to go through requesting the queues before PF driver reallocates
queue-related arrays.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * use proper IAVF_EXTENDED_CAP_SEND_RSS_QREGION flag when handling
   iavf_init_recv_max_rss_qregion() error (Sashiko)
 * update adapter->rss_{key,lut}_size and adapter->current_op only after
   successful allocation (Sashiko)
 * use the v2 opcodes to enable queues whenever
   VIRTCHNL_VF_LARGE_NUM_QPAIRS is negotiated, as for disabling (it was
   based on the queue count) (Sashiko)
 * set adapter->current_op in iavf_send_max_rss_qregion() (Sashiko)
 * iavf_set_channels(): stop clearing adapter->current_op before
   iavf_request_queues(), it was a debugging leftover (Sashiko)
 * iavf_request_queues(): undo current_op, num_req_queues and
   IAVF_FLAG_REINIT_ITR_NEEDED when sending the request fails (Sashiko)
 * iavf_map_queue_vector(): stop at the first send or poll error, and
   report it with dev_err()
 * replace rss key/lut krealloc() with simple kmalloc()s, to have an
   easier job on the error path
 * request RSS qregion again after reset, together with other extended
   caps: send it from iavf_process_aq_command() and handle the reply in
   iavf_virtchnl_completion()
 * auto-request queues at init only once, and only with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS (and VIRTCHNL_VF_OFFLOAD_REQ_QUEUES),
   where num_queue_pairs is the PF limit rather than the allocation;
   without it keep the previous behavior, with no extra VF reset
 * set channels locally (as before this series) unless
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, so ethtool -L down no longer lowers
   max_combined for good
 * reinit queues when the PF lowers num_queue_pairs below the number of
   active queues on reset (e.g. VF RSS LUT switched from GLOBAL back to
   VSI, so LARGE_NUM_QPAIRS is gone), instead of using legacy opcodes
   with too many queues
 * rebase over iavf_poll_virtchnl_response() changes
 * commit message: explain the limits of the legacy opcodes
 * iavf_map_queue_vector(): stop at PF NACK; on timeout keep current_op
   and IAVF_FLAG_AQ_MAP_VECTORS set until the late reply arrives, clear
   both on other errors (no retry), as in iavf_configure_queues()
   (Sashiko)

Sashiko suggestions I don't want to apply:
 S: iavf_fill_rss_lut() will crash if qregion->qregion_width >= 32
 me: value is coming from PF, which must be trusted
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  12 +
 include/linux/net/intel/virtchnl.h            | 136 +++++++++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   3 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 132 +++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 243 +++++++++++++++++-
 5 files changed, 510 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 47236d5f3961..5aaa337d5ffa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -345,13 +345,15 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS		BIT_ULL(42)
 #define IAVF_FLAG_AQ_GET_PTP_CAPS			BIT_ULL(43)
 #define IAVF_FLAG_AQ_SEND_PTP_CMD			BIT_ULL(44)
+#define IAVF_FLAG_AQ_GET_MAX_RSS_QREGION		BIT_ULL(45)
 
 	/* AQ messages that must be sent after IAVF_FLAG_AQ_GET_CONFIG, in
 	 * order to negotiated extended capabilities.
 	 */
 #define IAVF_FLAG_AQ_EXTENDED_CAPS			\
 	(IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS |	\
 	 IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS |		\
+	 IAVF_FLAG_AQ_GET_MAX_RSS_QREGION |		\
 	 IAVF_FLAG_AQ_GET_PTP_CAPS)
 
 	/* flags for processing extended capability messages during
@@ -368,12 +370,16 @@ struct iavf_adapter {
 #define IAVF_EXTENDED_CAP_RECV_RXDID			BIT_ULL(3)
 #define IAVF_EXTENDED_CAP_SEND_PTP			BIT_ULL(4)
 #define IAVF_EXTENDED_CAP_RECV_PTP			BIT_ULL(5)
+#define IAVF_EXTENDED_CAP_SEND_RSS_QREGION		BIT_ULL(6)
+#define IAVF_EXTENDED_CAP_RECV_RSS_QREGION		BIT_ULL(7)
 
 #define IAVF_EXTENDED_CAPS				\
 	(IAVF_EXTENDED_CAP_SEND_VLAN_V2 |		\
 	 IAVF_EXTENDED_CAP_RECV_VLAN_V2 |		\
 	 IAVF_EXTENDED_CAP_SEND_RXDID |			\
 	 IAVF_EXTENDED_CAP_RECV_RXDID |			\
+	 IAVF_EXTENDED_CAP_SEND_RSS_QREGION |		\
+	 IAVF_EXTENDED_CAP_RECV_RSS_QREGION |		\
 	 IAVF_EXTENDED_CAP_SEND_PTP |			\
 	 IAVF_EXTENDED_CAP_RECV_PTP)
 
@@ -413,6 +419,8 @@ struct iavf_adapter {
 #define RSS_REG(_a) (!((_a)->vf_res->vf_cap_flags & \
 		       (VIRTCHNL_VF_OFFLOAD_RSS_AQ | \
 			VIRTCHNL_VF_OFFLOAD_RSS_PF)))
+#define LARGE_NUM_QPAIRS_SUPPORT(_a) \
+	((_a)->vf_res->vf_cap_flags & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
 #define VLAN_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
 			  VIRTCHNL_VF_OFFLOAD_VLAN)
 #define VLAN_V2_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
@@ -447,6 +455,7 @@ struct iavf_adapter {
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	u64 supp_rxdids;
 	struct iavf_ptp ptp;
+	struct virtchnl_max_rss_qregion max_rss_qregion;
 	u16 msg_enable;
 	struct iavf_eth_stats current_stats;
 	struct virtchnl_qos_cap_list *qos_caps;
@@ -583,6 +592,8 @@ int iavf_send_vf_supported_rxdids_msg(struct iavf_adapter *adapter);
 int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter);
 int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter);
 int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter);
+int iavf_send_max_rss_qregion(struct iavf_adapter *adapter);
+int iavf_get_max_rss_qregion(struct iavf_adapter *adapter);
 void iavf_set_queue_vlan_tag_loc(struct iavf_adapter *adapter);
 u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter);
 void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
@@ -597,6 +608,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter);
 void iavf_del_vlans(struct iavf_adapter *adapter);
 void iavf_set_promiscuous(struct iavf_adapter *adapter);
 bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter);
+int iavf_request_queues(struct iavf_adapter *adapter, int num);
 void iavf_request_stats(struct iavf_adapter *adapter);
 int iavf_request_reset(struct iavf_adapter *adapter);
 void iavf_get_rss_hashcfg(struct iavf_adapter *adapter);
diff --git a/include/linux/net/intel/virtchnl.h b/include/linux/net/intel/virtchnl.h
index 11bdab5522fd..ffb7d3c21334 100644
--- a/include/linux/net/intel/virtchnl.h
+++ b/include/linux/net/intel/virtchnl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (c) 2013-2022, Intel Corporation. */
+/* Copyright (c) 2013-2026, Intel Corporation. */
 
 #ifndef _VIRTCHNL_H_
 #define _VIRTCHNL_H_
@@ -22,8 +22,7 @@
  * we must send all messages as "indirect", i.e. using an external buffer.
  *
  * All the VSI indexes are relative to the VF. Each VF can have maximum of
- * three VSIs. All the queue indexes are relative to the VSI.  Each VF can
- * have a maximum of sixteen queues for all of its VSIs.
+ * three VSIs. All the queue indexes are relative to the VSI.
  *
  * The PF is required to return a status code in v_retval for all messages
  * except RESET_VF, which does not require any response. The returned value
@@ -147,6 +146,7 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DEL_RSS_CFG = 46,
 	VIRTCHNL_OP_ADD_FDIR_FILTER = 47,
 	VIRTCHNL_OP_DEL_FDIR_FILTER = 48,
+	VIRTCHNL_OP_GET_MAX_RSS_QREGION = 50,
 	VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS = 51,
 	VIRTCHNL_OP_ADD_VLAN_V2 = 52,
 	VIRTCHNL_OP_DEL_VLAN_V2 = 53,
@@ -159,7 +159,11 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_1588_PTP_GET_TIME = 61,
 	/* opcode 62 - 65 are reserved */
 	VIRTCHNL_OP_GET_QOS_CAPS = 66,
-	/* opcode 68 through 111 are reserved */
+	/* opcodes 67 through 106 are reserved */
+	VIRTCHNL_OP_ENABLE_QUEUES_V2 = 107,
+	VIRTCHNL_OP_DISABLE_QUEUES_V2 = 108,
+	/* opcodes 109 and 110 are reserved */
+	VIRTCHNL_OP_MAP_QUEUE_VECTOR = 111,
 	VIRTCHNL_OP_CONFIG_QUEUE_BW = 112,
 	VIRTCHNL_OP_CONFIG_QUANTA = 113,
 	VIRTCHNL_OP_MAX,
@@ -257,6 +261,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_REQ_QUEUES		BIT(6)
 /* used to negotiate communicating link speeds in Mbps */
 #define VIRTCHNL_VF_CAP_ADV_LINK_SPEED		BIT(7)
+#define VIRTCHNL_VF_LARGE_NUM_QPAIRS		BIT(9)
 #define  VIRTCHNL_VF_OFFLOAD_CRC		BIT(10)
 #define VIRTCHNL_VF_OFFLOAD_TC_U32		BIT(11)
 #define VIRTCHNL_VF_OFFLOAD_VLAN_V2		BIT(15)
@@ -500,6 +505,34 @@ struct virtchnl_queue_select {
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_queue_select);
 
+/* VIRTCHNL_OP_GET_MAX_RSS_QREGION
+ *
+ * if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated in
+ * VIRTCHNL_OP_GET_VF_RESOURCES then this op must be supported.
+ *
+ * VF sends this message in order to query the max RSS queue region
+ * size supported by PF, when VIRTCHNL_VF_LARGE_NUM_QPAIRS is enabled.
+ * This information should be used when configuring the RSS LUT and/or
+ * configuring queue region based filters.
+ *
+ * The maximum RSS queue region is 2^qregion_width. So, a qregion_width of 6
+ * would inform the VF that the PF supports a maximum RSS queue region of 64.
+ *
+ * A queue region represents a range of queues that can be used to configure
+ * a RSS LUT. For example, if a VF is given 64 queues, but only a max queue
+ * region size of 16 (i.e. 2^qregion_width = 16) then it will only be able
+ * to configure the RSS LUT with queue indices from 0 to 15. However, other
+ * filters can be used to direct packets to queues >15 via specifying a queue
+ * base/offset and queue region width.
+ */
+struct virtchnl_max_rss_qregion {
+	u16 vport_id;
+	u16 qregion_width;
+	u8 pad[4];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_max_rss_qregion);
+
 /* VIRTCHNL_OP_ADD_ETH_ADDR
  * VF sends this message in order to add one or more unicast or multicast
  * address filters for the specified VSI.
@@ -1663,6 +1696,70 @@ struct virtchnl_queue_chunk {
 
 VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
 
+/* VIRTCHNL_OP_ENABLE_QUEUES_V2
+ * VIRTCHNL_OP_DISABLE_QUEUES_V2
+ *
+ * These opcodes can be used if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated in
+ * VIRTCHNL_OP_GET_VF_RESOURCES
+ *
+ * VF sends virtchnl_ena_dis_queues struct to specify the queues to be
+ * enabled/disabled in chunks. Also applicable to single queue RX or
+ * TX. PF performs requested action and returns status.
+ */
+struct virtchnl_del_ena_dis_queues {
+	u16 vport_id;
+	u16 pad;
+	u16 num_chunks;
+	u16 rsvd;
+	struct virtchnl_queue_chunk chunks[];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_del_ena_dis_queues);
+#define virtchnl_del_ena_dis_queues_LEGACY_SIZEOF	16
+
+/* Virtchannel interrupt throttling rate index */
+enum virtchnl_itr_idx {
+	VIRTCHNL_ITR_IDX_0	= 0,
+	VIRTCHNL_ITR_IDX_1	= 1,
+	VIRTCHNL_ITR_IDX_NO_ITR	= 3,
+};
+
+/* Queue to vector mapping */
+struct virtchnl_queue_vector {
+	u16 queue_id;
+	u16 vector_id;
+	u8 pad[4];
+
+	/* see enum virtchnl_itr_idx */
+	s32 itr_idx;
+
+	/* see enum virtchnl_queue_type */
+	s32 queue_type;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_queue_vector);
+
+/* VIRTCHNL_OP_MAP_QUEUE_VECTOR
+ *
+ * This opcode can be used only if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated
+ * in VIRTCHNL_OP_GET_VF_RESOURCES
+ *
+ * VF sends this message to map queues to vectors and ITR index registers.
+ * External data buffer contains virtchnl_queue_vector_maps structure
+ * that contains num_qv_maps of virtchnl_queue_vector structures.
+ * PF maps the requested queue vector maps after validating the queue and vector
+ * ids and returns a status code.
+ */
+struct virtchnl_queue_vector_maps {
+	u16 vport_id;
+	u16 num_qv_maps;
+	u8 pad[4];
+	struct virtchnl_queue_vector qv_maps[];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_vector_maps);
+#define virtchnl_queue_vector_maps_LEGACY_SIZEOF	24
+
 struct virtchnl_quanta_cfg {
 	u16 quanta_size;
 	u16 pad;
@@ -1695,6 +1792,8 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_quanta_cfg);
 		 __vss(virtchnl_rdma_qvlist_info, __vss_byelem, p, m, c),     \
 		 __vss(virtchnl_qos_cap_list, __vss_byelem, p, m, c),	      \
 		 __vss(virtchnl_queues_bw_cfg, __vss_byelem, p, m, c),	      \
+		 __vss(virtchnl_del_ena_dis_queues, __vss_byelem, p, m, c),   \
+		 __vss(virtchnl_queue_vector_maps, __vss_byelem, p, m, c),    \
 		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
 		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
 
@@ -1757,6 +1856,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_DISABLE_QUEUES:
 		valid_len = sizeof(struct virtchnl_queue_select);
 		break;
+	case VIRTCHNL_OP_GET_MAX_RSS_QREGION:
+		break;
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 	case VIRTCHNL_OP_DEL_ETH_ADDR:
 		valid_len = virtchnl_ether_addr_list_LEGACY_SIZEOF;
@@ -1929,7 +2030,32 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_1588_PTP_GET_TIME:
 		valid_len = sizeof(struct virtchnl_phc_time);
 		break;
-	/* These are always errors coming from the VF. */
+	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
+	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
+		valid_len = sizeof(struct virtchnl_del_ena_dis_queues);
+		if (msglen >= valid_len) {
+			struct virtchnl_del_ena_dis_queues *qs =
+				(struct virtchnl_del_ena_dis_queues *)msg;
+
+			if (!qs->num_chunks) {
+				err_msg_format = true;
+				break;
+			}
+			valid_len = virtchnl_struct_size(qs, chunks,
+							 qs->num_chunks);
+		}
+		break;
+	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
+		valid_len = virtchnl_queue_vector_maps_LEGACY_SIZEOF;
+		if (msglen >= valid_len) {
+			struct virtchnl_queue_vector_maps *v_qp = (void *)msg;
+
+			err_msg_format = !v_qp->num_qv_maps;
+			valid_len = virtchnl_struct_size(v_qp, qv_maps,
+							 v_qp->num_qv_maps);
+		}
+		break;
+	/* These are always errors when coming from the VF. */
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index e7cf12eaa268..83ab3e12b10a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1739,6 +1739,9 @@ static int iavf_set_channels(struct net_device *netdev,
 	if (ch->rx_count || ch->tx_count || ch->other_count != NONQ_VECS)
 		return -EINVAL;
 
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter))
+		return iavf_request_queues(adapter, num_req);
+
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8059e855dc09..f8193b0cae4a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1775,10 +1775,14 @@ int iavf_config_rss(struct iavf_adapter *adapter)
  **/
 static void iavf_fill_rss_lut(struct iavf_adapter *adapter)
 {
-	u16 i;
+	struct virtchnl_max_rss_qregion *qregion = &adapter->max_rss_qregion;
+	int max = adapter->num_active_queues;
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && qregion->qregion_width)
+		max = min(max, (int)BIT(qregion->qregion_width));
 
-	for (i = 0; i < adapter->rss_lut_size; i++)
-		adapter->rss_lut[i] = i % adapter->num_active_queues;
+	for (int i = 0; i < adapter->rss_lut_size; i++)
+		adapter->rss_lut[i] = i % max;
 }
 
 /**
@@ -2089,6 +2093,8 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 {
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_CONFIG)
 		return iavf_send_vf_config_msg(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_MAX_RSS_QREGION)
+		return iavf_send_max_rss_qregion(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS)
 		return iavf_send_vf_offload_vlan_v2_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS)
@@ -2458,8 +2464,9 @@ static void iavf_init_version_check(struct iavf_adapter *adapter)
  */
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 {
-	int i, num_req_queues = adapter->num_req_queues;
+	int i, qnum, num_req_queues = adapter->num_req_queues;
 	struct iavf_vsi *vsi = &adapter->vsi;
+	bool reconfig_rss = false;
 
 	for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 		if (adapter->vf_res->vsi_res[i].vsi_type == VIRTCHNL_VSI_SRIOV)
@@ -2486,21 +2493,65 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 
 		return -EAGAIN;
 	}
+	/* in LARGE mode num_queue_pairs is the PF limit, not our allocation */
+	if (!num_req_queues && LARGE_NUM_QPAIRS_SUPPORT(adapter) &&
+	    adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_REQ_QUEUES) {
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		qnum = min(adapter->vsi_res->num_queue_pairs,
+			   num_online_cpus());
+
+		return iavf_request_queues(adapter, qnum);
+	}
+	/* PF could lower the limit on reset, e.g. when RSS LUT got smaller */
+	if (adapter->num_active_queues > adapter->vsi_res->num_queue_pairs) {
+		adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
+		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+
+		return -EAGAIN;
+	}
 	adapter->num_req_queues = 0;
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
 	adapter->vsi.back = adapter;
 	adapter->vsi.base_vector = 1;
 	vsi->netdev = adapter->netdev;
 	vsi->qs_handle = adapter->vsi_res->qset_handle;
 	if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
-		adapter->rss_key_size = adapter->vf_res->rss_key_size;
-		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
+		if ((adapter->rss_key &&
+		     adapter->rss_key_size != adapter->vf_res->rss_key_size) ||
+		    (adapter->rss_lut &&
+		     adapter->rss_lut_size != adapter->vf_res->rss_lut_size)) {
+			reconfig_rss = true;
+		} else {
+			adapter->rss_key_size = adapter->vf_res->rss_key_size;
+			adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
+		}
 	} else {
 		adapter->rss_key_size = IAVF_HKEY_ARRAY_SIZE;
 		adapter->rss_lut_size = IAVF_HLUT_ARRAY_SIZE;
 	}
 
+	if (reconfig_rss) {
+		u8 *rss_key, *rss_lut;
+
+		rss_key = kmalloc(adapter->vf_res->rss_key_size, GFP_KERNEL);
+		rss_lut = kmalloc(adapter->vf_res->rss_lut_size, GFP_KERNEL);
+		if (!rss_lut || !rss_key) {
+			kfree(rss_key);
+			kfree(rss_lut);
+			return -ENOMEM;
+		}
+
+		kfree(adapter->rss_key);
+		kfree(adapter->rss_lut);
+		adapter->rss_key = rss_key;
+		adapter->rss_lut = rss_lut;
+		adapter->rss_key_size = adapter->vf_res->rss_key_size;
+		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
+		iavf_init_rss(adapter);
+	}
+
 	return 0;
 }
 
@@ -2626,6 +2677,65 @@ static void iavf_init_recv_offload_vlan_v2_caps(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+/*
+ * iavf_init_send_max_rss_qregion - part of querying for RSS max queue region
+ * @adapter: board private structure
+ *
+ * Function processes send of the VIRTCHNL_OP_GET_MAX_RSS_QREGION to the PF.
+ * Must clear IAVF_EXTENDED_CAP_RECV_RSS_QREGION if the message is not sent, e.g.
+ * due to the PF not negotiating VIRTCHNL_VF_LARGE_NUM_QPAIRS.
+ */
+static void iavf_init_send_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	int ret;
+
+	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RSS_QREGION));
+
+	ret = iavf_send_max_rss_qregion(adapter);
+	if (ret == -EOPNOTSUPP) {
+		/* PF does not support VIRTCHNL_VF_LARGE_NUM_QPAIRS. In this
+		 * case, we did not send the capability exchange message and do
+		 * not expect a response.
+		 */
+		adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RSS_QREGION;
+	}
+
+	/* We sent the message, so move on to the next step */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_SEND_RSS_QREGION;
+}
+
+/**
+ * iavf_init_recv_max_rss_qregion - part of querying for RSS max queue region
+ * @adapter: board private structure
+ *
+ * Function processes receipt of the RSS max qregion to be used for the LUT.
+ */
+static void iavf_init_recv_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	int ret;
+
+	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RSS_QREGION));
+
+	memset(&adapter->max_rss_qregion, 0, sizeof(adapter->max_rss_qregion));
+
+	ret = iavf_get_max_rss_qregion(adapter);
+	if (ret)
+		goto err;
+
+	/* We've processed the PF response to the VIRTCHNL_OP_GET_MAX_RSS_QREGION
+	 * message we sent previously.
+	 */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RSS_QREGION;
+	return;
+
+err:
+	/* We didn't receive a reply. Make sure we try sending again when
+	 * __IAVF_INIT_FAILED attempts to recover.
+	 */
+	adapter->extended_caps |= IAVF_EXTENDED_CAP_SEND_RSS_QREGION;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
+}
+
 /**
  * iavf_init_send_supported_rxdids - part of querying for supported RXDID
  * formats
@@ -2774,6 +2884,16 @@ static void iavf_init_process_extended_caps(struct iavf_adapter *adapter)
 		return;
 	}
 
+	/* Process capability exchange for RSS max qregion */
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RSS_QREGION) {
+		iavf_init_send_max_rss_qregion(adapter);
+		return;
+	}
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RSS_QREGION) {
+		iavf_init_recv_max_rss_qregion(adapter);
+		return;
+	}
+
 	/* When we reach here, no further extended capabilities exchanges are
 	 * necessary, so we finally transition into __IAVF_INIT_CONFIG_ADAPTER
 	 */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 3b9545d2c021..89d95d3b564c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -178,6 +178,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_VLAN_V2 |
 	       VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC |
 	       VIRTCHNL_VF_OFFLOAD_CRC |
+	       VIRTCHNL_VF_LARGE_NUM_QPAIRS |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM |
 	       VIRTCHNL_VF_OFFLOAD_REQ_QUEUES |
 	       VIRTCHNL_VF_CAP_PTP |
@@ -259,28 +260,45 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
 				(u8 *)&hw_caps, sizeof(hw_caps));
 }
 
+int iavf_send_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_MAX_RSS_QREGION;
+
+	if (!LARGE_NUM_QPAIRS_SUPPORT(adapter))
+		return -EOPNOTSUPP;
+
+	adapter->current_op = VIRTCHNL_OP_GET_MAX_RSS_QREGION;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_MAX_RSS_QREGION, NULL, 0);
+	return 0;
+}
+
 /**
  * iavf_validate_num_queues
  * @adapter: adapter structure
  *
  * Validate that the number of queues the PF has sent in
  * VIRTCHNL_OP_GET_VF_RESOURCES is not larger than the VF can handle.
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
+	u32 max_req_queues = IAVF_MAX_REQ_QUEUES;
+
+	if (!LARGE_NUM_QPAIRS_SUPPORT(adapter))
+		max_req_queues = IAVF_MAX_VSI_QP;
+
+	if (adapter->vf_res->num_queue_pairs > max_req_queues) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES);
+			 max_req_queues);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			 max_req_queues);
+		adapter->vf_res->num_queue_pairs = max_req_queues;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			vsi_res->num_queue_pairs = max_req_queues;
 		}
 	}
 }
@@ -379,6 +397,30 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
 	return err;
 }
 
+int iavf_get_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	struct iavf_arq_event_info event;
+	int err;
+	u16 len;
+
+	len = sizeof(struct virtchnl_max_rss_qregion);
+	event.buf_len = len;
+	event.msg_buf = kzalloc(len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
+				     VIRTCHNL_OP_GET_MAX_RSS_QREGION);
+	if (!err)
+		memcpy(&adapter->max_rss_qregion, event.msg_buf,
+		       min(event.msg_len, len));
+
+	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+
+	kfree(event.msg_buf);
+	return err;
+}
+
 /**
  * iavf_configure_queues
  * @adapter: adapter structure
@@ -495,6 +537,50 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	kfree(vqci);
 }
 
+/**
+ * iavf_enable_disable_queues_v2 - send V2 messages of ENABLE/DISABLE queues ops
+ * @adapter: private adapter structure
+ * @enable: true to enable and false to disable the queues
+ */
+static void iavf_enable_disable_queues_v2(struct iavf_adapter *adapter, bool enable)
+{
+	enum virtchnl_ops op = VIRTCHNL_OP_ENABLE_QUEUES_V2;
+	struct virtchnl_del_ena_dis_queues *msg;
+	u64 flag = IAVF_FLAG_AQ_ENABLE_QUEUES;
+	struct virtchnl_queue_chunk *chunk;
+	int len;
+
+	if (!enable) {
+		op = VIRTCHNL_OP_DISABLE_QUEUES_V2;
+		flag = IAVF_FLAG_AQ_DISABLE_QUEUES;
+	}
+
+	/* We need 2 chunks (one Tx and one Rx). */
+	len = virtchnl_struct_size(msg, chunks, 2);
+	msg = kzalloc(len, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	adapter->current_op = op;
+
+	msg->vport_id = adapter->vsi_res->vsi_id;
+	msg->num_chunks = 2;
+
+	chunk = &msg->chunks[0];
+	chunk->type = VIRTCHNL_QUEUE_TYPE_RX;
+	chunk->start_queue_id = 0;
+	chunk->num_queues = adapter->num_active_queues;
+
+	chunk++;
+	chunk->type = VIRTCHNL_QUEUE_TYPE_TX;
+	chunk->start_queue_id = 0;
+	chunk->num_queues = adapter->num_active_queues;
+
+	adapter->aq_required &= ~flag;
+	iavf_send_pf_msg(adapter, op, (u8 *)msg, len);
+	kfree(msg);
+}
+
 /**
  * iavf_enable_queues
  * @adapter: adapter structure
@@ -511,6 +597,12 @@ void iavf_enable_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		iavf_enable_disable_queues_v2(adapter, true);
+		return;
+	}
+
 	adapter->current_op = VIRTCHNL_OP_ENABLE_QUEUES;
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
@@ -536,15 +628,108 @@ void iavf_disable_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		iavf_enable_disable_queues_v2(adapter, false);
+		return;
+	}
+
 	adapter->current_op = VIRTCHNL_OP_DISABLE_QUEUES;
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
 	vqs.rx_queues = vqs.tx_queues;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_QUEUES;
 	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES,
 			 (u8 *)&vqs, sizeof(vqs));
 }
 
+static void iavf_map_queue_vector(struct iavf_adapter *adapter)
+{
+	struct virtchnl_queue_vector_maps *qvmaps;
+	int qnum = adapter->num_active_queues;
+	struct virtchnl_queue_vector *qv;
+	struct iavf_arq_event_info event;
+	int len, max_pairs, err = 0;
+
+	max_pairs = iavf_max_vc_entries(qvmaps, qv_maps) / 2;
+	len = virtchnl_struct_size(qvmaps, qv_maps, 2 * min(qnum, max_pairs));
+	qvmaps = kzalloc(len, GFP_KERNEL);
+	if (!qvmaps)
+		return;
+
+	/* any message may arrive while polling, not only the awaited one */
+	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
+	event.msg_buf = kzalloc(IAVF_MAX_AQ_BUF_SIZE, GFP_KERNEL);
+	if (!event.msg_buf) {
+		kfree(qvmaps);
+		return;
+	}
+
+	qvmaps->vport_id = adapter->vsi_res->vsi_id;
+	qv = qvmaps->qv_maps;
+	for (int qid = 0, in_msg = 0; qid < qnum; qid++) {
+		const bool last = qid + 1 == qnum;
+		struct iavf_q_vector *q_vector;
+
+		q_vector = adapter->tx_rings[qid].q_vector;
+		qv->queue_id = qid;
+		qv->vector_id = NONQ_VECS + q_vector->v_idx;
+		qv->itr_idx = IAVF_TX_ITR;
+		qv->queue_type = VIRTCHNL_QUEUE_TYPE_TX;
+		qv++;
+
+		q_vector = adapter->rx_rings[qid].q_vector;
+		qv->queue_id = qid;
+		qv->vector_id = NONQ_VECS + q_vector->v_idx;
+		qv->itr_idx = IAVF_RX_ITR;
+		qv->queue_type = VIRTCHNL_QUEUE_TYPE_RX;
+		qv++;
+
+		in_msg++;
+		if (last || in_msg == max_pairs) {
+			qvmaps->num_qv_maps = 2 * in_msg;
+			adapter->current_op = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
+			err = iavf_send_pf_msg(adapter,
+					       VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+					       (u8 *)qvmaps,
+					       virtchnl_struct_size(qvmaps, qv_maps,
+								    2 * in_msg));
+			if (err) {
+				dev_err(&adapter->pdev->dev,
+					"sending mapping queue vectors to PF failed, err: %d\n",
+					err);
+				break;
+			}
+			err = iavf_poll_virtchnl_response(adapter, &event,
+							  iavf_match_vc_op_cb,
+							  (void *)VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+							  1000);
+			if (err) {
+				dev_err(&adapter->pdev->dev,
+					"polling response of mapping queue vectors failed, err: %d\n",
+					err);
+				break;
+			}
+
+			/* PF NACK, iavf_virtchnl_completion() has logged it */
+			if (event.desc.cookie_low) {
+				err = -EIO;
+				break;
+			}
+
+			in_msg = 0;
+			qv = qvmaps->qv_maps;
+		}
+	}
+	/* on timeout keep the op pending, see iavf_configure_queues() */
+	if (err != -EAGAIN) {
+		adapter->aq_required &= ~IAVF_FLAG_AQ_MAP_VECTORS;
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	}
+	kfree(event.msg_buf);
+	kfree(qvmaps);
+}
+
 /**
  * iavf_map_queues
  * @adapter: adapter structure
@@ -566,6 +751,12 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		iavf_map_queue_vector(adapter);
+		return;
+	}
+
 	adapter->current_op = VIRTCHNL_OP_CONFIG_IRQ_MAP;
 
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
@@ -602,6 +793,40 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 	kfree(vimi);
 }
 
+/**
+ * iavf_request_queues - request queues via virtchnl
+ * @adapter: adapter structure
+ * @num: number of requested queues
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int iavf_request_queues(struct iavf_adapter *adapter, int num)
+{
+	struct virtchnl_vf_res_request vfres = { num };
+	int err;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot request queues, command %d pending\n",
+			adapter->current_op);
+		return -EBUSY;
+	}
+
+	adapter->current_op = VIRTCHNL_OP_REQUEST_QUEUES;
+	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
+	adapter->num_req_queues = num;
+
+	err = iavf_send_pf_msg(adapter, VIRTCHNL_OP_REQUEST_QUEUES,
+			       (u8 *)&vfres, sizeof(vfres));
+	if (err) {
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+		adapter->num_req_queues = 0;
+	}
+
+	return err;
+}
+
 /**
  * iavf_set_mac_addr_type - Set the correct request type from the filter type
  * @virtchnl_ether_addr: pointer to requested list element
@@ -2758,6 +2983,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			aq_required;
 		}
 		break;
+	case VIRTCHNL_OP_GET_MAX_RSS_QREGION:
+		if (!v_retval)
+			memcpy(&adapter->max_rss_qregion, msg,
+			       sizeof(adapter->max_rss_qregion));
+		break;
 	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
 		if (msglen != sizeof(u64))
 			return;
@@ -2778,20 +3008,23 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		iavf_virtchnl_ptp_get_time(adapter, msg, msglen);
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
+	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
+	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
 		iavf_free_all_tx_resources(adapter);
 		iavf_free_all_rx_resources(adapter);
 		if (adapter->state == __IAVF_DOWN_PENDING) {
 			iavf_change_state(adapter, __IAVF_DOWN);
 			wake_up(&adapter->down_waitqueue);
 		}
 		break;
 	case VIRTCHNL_OP_VERSION:
 	case VIRTCHNL_OP_CONFIG_IRQ_MAP:
+	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
 		/* Don't display an error if we get these out of sequence.
 		 * If the firmware needed to get kicked, we'll get these and
 		 * it's no problem.
-- 
2.51.1

