Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F2ECA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BCF481283;
	Fri,  9 Oct 2026 12:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ldDI3rliIBM; Fri,  9 Oct 2026 12:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2ADA3813CA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548110;
	b=ogqsKFpl3SFjL+ne56oAJIE55FHmqmbQ+ExT3gLgrTNZF30f+5pcSbdz3BPwioj5cnTe
	 iIVlD/osW/wTG2OZLeLEy1w5J5aPfXxBQvMx/VDQjz9mOzqnYD5stRoVq+m8mh0UCn31g
	 YsGfJkBxe0dWJXOG0LkDDjYSWTVH8NZ7TqeGvb5z2/kGGCZhyETubaFIGXyKWgvxUa20b
	 DUwEqtfbH0ypfimUHrL401axyq+QnIrgbePZj/Ls4MnfOQN5kRpg4SLnPFwsyE98DG0es
	 acW8S/KIw7wkPlhzzdMCeBOlWPSTyP+CdknZ+AbbA1f6hIaF2haRCTCMU+1VXT1xZ+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548110;
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
	bh=4ErkaZLZIYh0WLapPKzXImXBq1feDOnkxsW1lTQxatI=;
	b=op9pgpyFhXSJm29Tzu/alwl5sIRfDQ8UKxUP13ypoGPcqsJbMblabMHC2VXCatF3XEv0
	 WfbhYgRUTUPS+XCy95K+EBpg8Dz1K75J+NRG+zmpbCmFHQYUGLIQBT7QbwUXJlSZ8uBn9
	 cn/p+rZg+VXBzUmcZ4gIcxTpRAVGyBulycyYzukrWJTdObc62tjS9xIPJlmjK06hPYpSs
	 4zyQbGJOCxZrJDU4kbzdIvlPQKLnptEWn4hfKJFLkdOaZDaXVtoAHuoFS/PE4MyQe6iSW
	 77Oc9yjYq5aQpFOthzE6Xh75fN3yk/bEYKLfq7BMzF+aAxreHHGDdfoumyG8+UkMVUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548110;
	bh=4ErkaZLZIYh0WLapPKzXImXBq1feDOnkxsW1lTQxatI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p6/dXDpKA8WhvNLXWKlwwxRFzf+oFJ0upJZcFUTwF9Jv2en5JDEay1DiNT1z5N239
	 NON2K9s3l5Bh8tZCpcONcc3P4B4zAdKvBQc2IEecIj3oIs8knVK1OTTAIZRbl9aChf
	 kghvZnXk8RLmRTiUl4MJtmVHcCy2SWqEFn+Smt4X7hHY4OB/yBV1V+GZn7j3EQG2kN
	 Ul7L5tkOBZxf9Z1iZ2BI0I55Fl1qVthA2Qjt6nmjEgh4L0S274VtVKTSS1m73VLMBS
	 87b4an3UqHPUT0w1CkbauOr+vTCbL4U7encc1SXwPoAVVtap5QoQDczHOrYQWQVBhf
	 x5crPuiOha2Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ADA3813CA;
	Fri,  9 Oct 2026 12:15:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 015752AA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7ED040919
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xe7ZX2AFdqpc for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C63BA40902
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548107;
 b=P5jmWDFfjF7ksUU+LWPQRx6iC5xnuJjTYucgNJpRFPPn8/TSOJs6k/EkNwp+DtIVL/iI
 0O40McIW8ggg7I7+shyHT52H586PIfw8WTwE1RsohY0yFuwiyEgGavacEktZdFgqVITuo
 5jM9em3chjm6pBYqm2bPTcoFSZsuPOaT2jslDvoYK/cUHD9M8wqX6wj/uXVaLg2ZRQGoG
 b68y6tih6TGielbGRhdbL9/KoA5bUotRzYxPJmU53JGrAQIkvdAFdUehyhCozzpBaWep6
 VidibkU6/1Dubf0G6rfYYw2ZBJLra2qw3dKBL5kHJXf7mzwQlZLs48dO0WUdAm/Goyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548107;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4ErkaZLZIYh0WLapPKzXImXBq1feDOnkxsW1lTQxatI=;
 b=Kei3MYY5XZKVdILbR7+qAZqy2aZjaZRxnNoTgydHLzS91nfnCWH/m7PMHcMyLxlipRQd
 SrD1B2uLtCoedmxrMgRLLFEzeVF0VAR/ODi4p8G5k7z+6TVG/nqtalCNMZoll1BTll59y
 nWPRE9DY53kalVChMNl6Szb16lpIm+gADHUn4QJyiMoAHjiCgtRyzf5EQZ/DlnSjPz4z7
 fwLGKyIDFEpgTpiDSjBOyz9OGx8BsEwAXs+BIghVghd/+zjfQ+3suUm4JaJXq3OQK2gQD
 LUojCH7+l2A2HUsm0DB99XqoXj6XyPXpz5Heo8XwP1knyraq17UHgNap/4f9uCyJMRA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="ZlDY/C2r"; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZlDY/C2r
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C63BA40902
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548107; x=1823084107;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EMeTgTsinc9/+2MpzePQG4G6wNE7NpbV+NFkvOhtwN4=;
 b=ZlDY/C2rrpMJ/+Zuygz7v95GDkopDwXK/N/g3x3hO3usdXp0UUj4RaPa
 89DW45iDE/XsShw3aJvthIMwvf5Mk85oqji//r7LCdfWyPJpHIlD7QB1d
 SiJnxCjk/vqSGoLFk7c1+aBaF8vQ9ICNFiM7w4e7YABCRMz9Kwn5BpJfZ
 r/xHFCJ7b22yEO+ZQz/aEU2L3iwoqIMf+yWA6TcFOC3o7P16+ne50eoOu
 lQTyzdCsBbz81ge+6oRyl23zfaXaUSOcSqODXmn5MTokGHBzKdz0bH8nm
 eU75/rposiOlMdGy98BfZnoEhkwUgv7NdN2sxuQVwiiqZImJD1go5mMZz w==;
X-CSE-ConnectionGUID: xlmMS3M7Q2mSHvIakbYX4Q==
X-CSE-MsgGUID: niYybvkMRpinPKvcNvwHVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251219"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251219"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:15:07 -0700
X-CSE-ConnectionGUID: VjOv4ZY2QqyNG4bg5j3pWw==
X-CSE-MsgGUID: FUPQZaXSQIyFQRZz6sIBnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420513"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:15:03 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 0F9AE2FC45;
 Fri,  9 Oct 2026 13:15:00 +0100 (IST)
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 11/14] ice: introduce handling of virtchnl LARGE
 VF opcodes
Date: Fri,  9 Oct 2026 14:04:22 +0200
Message-ID: <20261009121433.30347-12-przemyslaw.kitszel@intel.com>
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

From: Brett Creeley <brett.creeley@intel.com>

With new virtchnl offload/capability VFs are able to make use of more than
16 queues. But the old opcodes were designed with a max of 16 queues,
so new ones were added (by iavf/virtchnl commit of this series).
Handle VIRTCHNL_OP_ENABLE_QUEUES_V2, VIRTCHNL_OP_DISABLE_QUEUES_V2 and
VIRTCHNL_OP_MAP_QUEUE_VECTOR here. VIRTCHNL_OP_GET_MAX_RSS_QREGION is
only allowlisted, its handler comes with bigger RSS LUT support later
in the series.

If a VF wishes to request >16 queues it should first make sure that the
PF supports the VIRTCHNL_VF_LARGE_NUM_QPAIRS capability.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com> # msglen val
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * fix error response in one case of ice_vc_map_q_vector_msg() (Alex)
 * use ice_get_vf_vsi() instead of plain array access (Sashiko)
 * return VIRTCHNL_STATUS_ERR_PARAM on error (Sashiko)
 * commit message: GET_MAX_RSS_QREGION is handled only later
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   1 +
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 314 ++++++++++++++++++
 4 files changed, 326 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index a9e95c85bc98..396dfb2b2d97 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -125,6 +125,7 @@ struct ice_vf_ops {
 	void (*clear_reset_trigger)(struct ice_vf *vf);
 	void (*irq_close)(struct ice_vf *vf);
 	void (*post_vsi_rebuild)(struct ice_vf *vf);
+	struct ice_q_vector *(*get_q_vector)(struct ice_vsi *vsi, u16 vec_id);
 };
 
 /* Virtchnl/SR-IOV config info */
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.h b/drivers/net/ethernet/intel/ice/virt/queues.h
index c4a792cecea1..223f609dd4f3 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.h
+++ b/drivers/net/ethernet/intel/ice/virt/queues.h
@@ -16,5 +16,8 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg);
 int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg);
 int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg);
 int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg);
+int ice_vc_ena_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
+int ice_vc_dis_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
+int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
 
 #endif /* _ICE_VIRT_QUEUES_H_ */
diff --git a/drivers/net/ethernet/intel/ice/virt/allowlist.c b/drivers/net/ethernet/intel/ice/virt/allowlist.c
index a07efec19c45..ef769b843c6f 100644
--- a/drivers/net/ethernet/intel/ice/virt/allowlist.c
+++ b/drivers/net/ethernet/intel/ice/virt/allowlist.c
@@ -95,6 +95,13 @@ static const u32 tc_allowlist_opcodes[] = {
 	VIRTCHNL_OP_CONFIG_QUANTA,
 };
 
+static const u32 large_num_qpairs_allowlist_opcodes[] = {
+	VIRTCHNL_OP_GET_MAX_RSS_QREGION,
+	VIRTCHNL_OP_ENABLE_QUEUES_V2,
+	VIRTCHNL_OP_DISABLE_QUEUES_V2,
+	VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+};
+
 struct allowlist_opcode_info {
 	const u32 *opcodes;
 	size_t size;
@@ -117,6 +124,7 @@ static const struct allowlist_opcode_info allowlist_opcodes[] = {
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_VLAN_V2, vlan_v2_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_QOS, tc_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_CAP_PTP, ptp_allowlist_opcodes),
+	ALLOW_ITEM(VIRTCHNL_VF_LARGE_NUM_QPAIRS, large_num_qpairs_allowlist_opcodes),
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 61304493af34..3c5c5099a73d 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -1044,3 +1044,317 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, (u8 *)vfres, sizeof(*vfres));
 }
 
+static bool ice_vc_supported_queue_type(s32 queue_type)
+{
+	return queue_type == VIRTCHNL_QUEUE_TYPE_RX ||
+	       queue_type == VIRTCHNL_QUEUE_TYPE_TX;
+}
+
+/**
+ * ice_vc_validate_qs_v2_msg - validate all qs_msg parameters
+ * @vf: VF the message was received from
+ * @qs_msg: contents of the message from the VF
+ * @msglen: length of @qs_msg
+ *
+ * Used to validate both the VIRTCHNL_OP_ENABLE_QUEUES_V2 and
+ * VIRTCHNL_OP_DISABLE_QUEUES_V2 messages. This should always be called before
+ * attempting to enable and/or disable queues on behalf of a VF in response to
+ * the previously mentioned opcodes.
+ *
+ * Return: If all checks succeed, then return true. Otherwise return
+ *         false, indicating to the caller that the qs_msg is invalid.
+ */
+static bool ice_vc_validate_qs_v2_msg(struct ice_vf *vf,
+				      struct virtchnl_del_ena_dis_queues *qs_msg,
+				      u16 msglen)
+{
+	if (msglen < virtchnl_struct_size(qs_msg, chunks, 0))
+		return false;
+
+	if (msglen < virtchnl_struct_size(qs_msg, chunks, qs_msg->num_chunks))
+		return false;
+
+	if (!qs_msg->num_chunks)
+		return false;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		return false;
+
+	if (!ice_vc_isvalid_vsi_id(vf, qs_msg->vport_id))
+		return false;
+
+	for (int i = 0; i < qs_msg->num_chunks; i++) {
+		u32 max_queue_in_chunk;
+
+		if (!ice_vc_supported_queue_type(qs_msg->chunks[i].type))
+			return false;
+
+		if (!qs_msg->chunks[i].num_queues)
+			return false;
+
+		max_queue_in_chunk = qs_msg->chunks[i].start_queue_id +
+				     qs_msg->chunks[i].num_queues;
+		if (max_queue_in_chunk > vf->num_vf_qs)
+			return false;
+	}
+
+	return true;
+}
+
+#define ice_for_each_q_in_chunk(chunk, q_id) \
+	for ((q_id) = (chunk)->start_queue_id; \
+	     (q_id) < (chunk)->start_queue_id + (chunk)->num_queues; \
+	     (q_id)++)
+
+static int
+ice_vc_ena_rxq_chunk(struct ice_vf *vf, struct virtchnl_queue_chunk *chunk)
+{
+	struct ice_vsi *vsi;
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		vsi = ice_get_vf_vsi(vf);
+		err = ice_vf_vsi_ena_single_rxq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+ice_vc_ena_txq_chunk(struct ice_vf *vf, struct virtchnl_queue_chunk *chunk)
+{
+	struct ice_vsi *vsi;
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		vsi = ice_get_vf_vsi(vf);
+		ice_vf_vsi_ena_single_txq(vf, vsi, vf_qid);
+	}
+
+	return 0;
+}
+
+/**
+ * ice_vc_ena_qs_v2_msg - message handling for VIRTCHNL_OP_ENABLE_QUEUES_V2
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of the @msg
+ *
+ * Return: 0 on success or negative on error.
+ */
+int ice_vc_ena_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	struct virtchnl_del_ena_dis_queues *ena_qs_msg =
+			(struct virtchnl_del_ena_dis_queues *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+
+	if (!ice_vc_validate_qs_v2_msg(vf, ena_qs_msg, msglen))
+		goto error_param;
+
+	for (int i = 0; i < ena_qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &ena_qs_msg->chunks[i];
+
+		if (chunk->type == VIRTCHNL_QUEUE_TYPE_RX &&
+		    ice_vc_ena_rxq_chunk(vf, chunk))
+			goto error_param;
+		else if (chunk->type == VIRTCHNL_QUEUE_TYPE_TX &&
+			 ice_vc_ena_txq_chunk(vf, chunk))
+			goto error_param;
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+	set_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ENABLE_QUEUES_V2,
+				     v_ret, NULL, 0);
+}
+
+static int
+ice_vc_dis_rxq_chunk(struct ice_vf *vf, struct virtchnl_queue_chunk *chunk)
+{
+	struct ice_vsi *vsi;
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		vsi = ice_get_vf_vsi(vf);
+		err = ice_vf_vsi_dis_single_rxq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+ice_vc_dis_txq_chunk(struct ice_vf *vf, struct virtchnl_queue_chunk *chunk)
+{
+	struct ice_vsi *vsi;
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		vsi = ice_get_vf_vsi(vf);
+		err = ice_vf_vsi_dis_single_txq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_vc_dis_qs_v2_msg - message handling for VIRTCHNL_OP_DISABLE_QUEUES_V2
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of @msg
+ *
+ * Return: 0 on success or negative on error.
+ */
+int ice_vc_dis_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	struct virtchnl_del_ena_dis_queues *dis_qs_msg =
+			(struct virtchnl_del_ena_dis_queues *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+
+	if (!ice_vc_validate_qs_v2_msg(vf, dis_qs_msg, msglen))
+		goto error_param;
+
+	for (int i = 0; i < dis_qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &dis_qs_msg->chunks[i];
+
+		if (chunk->type == VIRTCHNL_QUEUE_TYPE_RX &&
+		    ice_vc_dis_rxq_chunk(vf, chunk))
+			goto error_param;
+		else if (chunk->type == VIRTCHNL_QUEUE_TYPE_TX &&
+			 ice_vc_dis_txq_chunk(vf, chunk))
+			goto error_param;
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+	if (ice_vf_has_no_qs_ena(vf))
+		clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DISABLE_QUEUES_V2,
+				     v_ret, NULL, 0);
+}
+
+/**
+ * ice_vc_validate_qv_maps - validate parameters sent in the qs_msg structure
+ * @vf: VF the message was received from
+ * @qv_maps: contents of the message from the VF
+ * @msglen: length of the @qv_maps
+ *
+ * Used to validate VIRTCHNL_OP_MAP_QUEUE_VECTOR messages. This should always
+ * be called before attempting map interrupts to queues. If all checks succeed,
+ * then return success indicating to the caller that the qv_maps are valid.
+ * Otherwise return false, indicating to the caller that the qv_maps are
+ * invalid.
+ *
+ * Return: true if parameters are valid, false otherwise.
+ */
+static bool ice_vc_validate_qv_maps(struct ice_vf *vf,
+				    struct virtchnl_queue_vector_maps *qv_maps,
+				    u16 msglen)
+{
+	struct ice_vsi *vsi;
+	int total_vectors;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return false;
+
+	if (msglen < virtchnl_struct_size(qv_maps, qv_maps, 0))
+		return false;
+
+	if (msglen < virtchnl_struct_size(qv_maps, qv_maps, qv_maps->num_qv_maps))
+		return false;
+
+	if (!qv_maps->num_qv_maps)
+		return false;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		return false;
+
+	if (!ice_vc_isvalid_vsi_id(vf, qv_maps->vport_id))
+		return false;
+
+	total_vectors = vsi->num_q_vectors + ICE_NONQ_VECS_VF;
+
+	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
+		if (!ice_vc_supported_queue_type(qv_maps->qv_maps[i].queue_type))
+			return false;
+
+		if (qv_maps->qv_maps[i].queue_id >= vf->num_vf_qs)
+			return false;
+
+		if (qv_maps->qv_maps[i].vector_id >= total_vectors ||
+		    qv_maps->qv_maps[i].vector_id < ICE_NONQ_VECS_VF)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * ice_vc_map_q_vector_msg - message handling for VIRTCHNL_OP_MAP_QUEUE_VECTOR
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of @msg
+ *
+ * Return: 0 on success or negative on error
+ */
+int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct virtchnl_queue_vector_maps *qv_maps;
+	struct ice_vsi *vsi;
+
+	qv_maps = (struct virtchnl_queue_vector_maps *)msg;
+
+	if (!ice_vc_validate_qv_maps(vf, qv_maps, msglen))
+		goto error_param;
+
+	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
+		struct virtchnl_queue_vector *qv_map = &qv_maps->qv_maps[i];
+		struct ice_q_vector *q_vector;
+		u16 vector_id;
+		int vsi_q_id;
+
+		vsi_q_id = qv_map->queue_id;
+		vector_id = qv_map->vector_id;
+		vsi = ice_get_vf_vsi(vf);
+		if (!vsi)
+			goto error_param;
+
+		q_vector = vf->vf_ops->get_q_vector(vsi, vector_id);
+		if (!q_vector)
+			goto error_param;
+
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
+			goto error_param;
+
+		if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_RX)
+			ice_cfg_rxq_interrupt(vsi, vsi_q_id,
+					      q_vector->vf_reg_idx,
+					      qv_map->itr_idx);
+		else if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_TX)
+			ice_cfg_txq_interrupt(vsi, vsi_q_id,
+					      q_vector->vf_reg_idx,
+					      qv_map->itr_idx);
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+				     v_ret, NULL, 0);
+}
-- 
2.51.1

