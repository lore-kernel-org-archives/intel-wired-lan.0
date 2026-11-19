Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505D606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Xa7kOkra;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LLWxPYTc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 739844068F;
	Thu, 19 Nov 2026 15:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQ9OTAw8wESy; Thu, 19 Nov 2026 15:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C8E1405CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101888;
	b=kmQfPY/3lBbmXsiohky9nZlUmUk7qInCaUM6vHHK7LXu4cbXeyC+OL13Xj6C2BNRAHqs
	 1uHRWvgfmLL9OyJJHPzBTLJPJ7LaxEJLzCGKQXPlNc02p6J3gU9A+JPCcLQPLsbP3eXFT
	 SohnXTzwUn2+LpSMEskl1XEiNW6u7Gh1KlaME9TBKCik9Qxwyhog7fQ6FoPqIXiRMjeGA
	 X/D149CQMiiKptS4+ltsF+4Gc7yLobJ1+xLnL5KCXP4Nzwt0lq1OozczS3wgBwk3XNcBp
	 noSyiRFgdNkPIXb7lOn5BgipKVb5ulDiJkULpAMgaMm7VClR10eAkbCqd6kBdad/tOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tUbbPrpYOv58uVNR+mXEF7wc5VFgpq+1lHd3ZcFtAGU=;
	b=V7LJreQrTwdoiCjb/4tQqdXSgZBNuEsjJjQ6pvTQlqibi0hXZXj4UfZuIA4oEx63YBXb
	 zCpjTJUScPBy8fmyJlOwKHa8zcvvTSsgjGJb9cwNw6Xx6/Bg+wH5TPDt65Zln2TZhYDz5
	 yrcLrBgCscjlskAFqkApQoA/M3uo51YkH+Mn+0rqZ1pdthhb3toMi7gGqa5UFFxuS1qCe
	 ZckykMv/i9QtOqLc2LiLZYl5q6xFKptSu5v6VnXG29KA+zbKHf6K/SlGliuZaqNAEzMcK
	 peMmHKJPQ7SAW9DAbnUYxyIPrxDoJjNCTz/ZDcc37XpumnKigEGCfk7yBbFLVDvxtaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795101888;
	bh=tUbbPrpYOv58uVNR+mXEF7wc5VFgpq+1lHd3ZcFtAGU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xa7kOkraXqxzOGJAqqk0ADZPwcatB6ACne1wPF8ZoxcpdxvRZxV8yvcgLNbHoZQOC
	 OmMK8vv1u5C+Cb5d8GIaSH/jxXYZtpuQyJ+M/z8AfOUQJz2gAytiI/DpcrIYqj2SYm
	 PkKjo/NLrS61w02Rri1rF0lmk9ER8RfS6Eoj9Yk+hBkjrKzN9OWwb80byC9sG7Ow04
	 LFX6Ce/0yApc7tby+Gyg8x/cFf8/WXfed45XCgHjtqWgvBBUpoKnoklf9SKz6IL1PD
	 u6J6IyYlRhLCAdK4ZCNBi0PW/Zht90XwTUSLQL2jMsFw4Q/oE1MBAD7DQGDAu+C1lb
	 YlmJOJGqzXe4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C8E1405CB;
	Thu, 19 Nov 2026 15:24:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9B421E7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C038360658
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_15ebyPPJ7t for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22E4660686
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LLWxPYTc
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22E4660686
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795101884; x=1826637884;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o4tlLESgbnrnEccgclOrTMImAFfXT02f/IkdT0lS0oM=;
 b=LLWxPYTcrxytyj8/EIp7pCoVYI6m6Jwd9vvYRQmYNX839qTmwH+2mG/n
 blAJj/W9Dka59BkFaBfK1bOK/w+CY8lmPL4TKXkxBrxarc3Ocnx3q01BX
 bxuefr4JXBPiGN2KYCkTgmR2WXgJNawb0Sw78utBx+pHaC4ko2Sh5D7rv
 BH+u766ZHXbjjFpOhse0BVROGD/V/Ui+rh1XrfUl4xFNpRXZVirAleXSF
 QDryTTpKX0tdLlnRTwAzZM7qh8dPULnW9HORzRcgCTjl1P8Ql0LftLcbJ
 FfRq+IGtcDJ585dlBhDYeD2V5r/jeAEkALe65U6VWjfX+abR+w3toDjbK Q==;
X-CSE-ConnectionGUID: h52vUoN3Tzi+jud/WS3TDg==
X-CSE-MsgGUID: 1i1BgnHOR9m0cyTypHVyxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3848775"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3848775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:24:44 -0800
X-CSE-ConnectionGUID: G0GtUPepTCWx3ZaIdhoN7Q==
X-CSE-MsgGUID: gg38j33MS9+thkSwypQbYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10358792"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Nov 2026 07:24:43 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v3 3/4] ice: validate VF FDIR queue region action
Date: Thu, 19 Nov 2026 16:24:37 +0100
Message-ID: <20261119152438.3577165-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
 <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
 <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VIRTCHNL_ACTION_Q_REGION filter covers 2^region queues starting at
the index the VF supplies.  The index and the region go into the
programming descriptor (TO_Q), which the hardware interprets relative
to the VF's VSI, so a region extending past the VSI's Rx queues lets
the VF steer matched packets to queues belonging to another VF or to
the PF.

Reject a region that does not fit the 3-bit TO_Q field (it would be
silently truncated) and require the whole range to fit within the
VSI's Rx queues.  No alignment of the index is required for this to
hold: however the hardware combines the index with the hash bits, no
queue it selects from the region is at or above index + 2^region.
The rejected action fails the whole add request.

v2 -> v3:
 - split out from the single queue and queue-region validation
   commit of the v2 posting, one commit per Fixes tag
 - rewrap the dev_dbg() call to fit within 80 columns

Fixes: 346bf2504397 ("ice: Add new actions support for VF FDIR")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/fdir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index f3af7de..244da64 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -1192,6 +1192,17 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			break;
 		case VIRTCHNL_ACTION_Q_REGION:
 			dest_num++;
+			if (action->act_conf.queue.region >
+			    FIELD_MAX(ICE_FXD_FLTR_QW0_TO_Q_M) ||
+			    action->act_conf.queue.index +
+			    BIT(action->act_conf.queue.region) > vsi->num_rxq) {
+				dev_dbg(dev,
+					"Invalid queue region %u/%u for VF %d\n",
+					action->act_conf.queue.index,
+					action->act_conf.queue.region,
+					vf->vf_id);
+				return -EINVAL;
+			}
 			input->dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
 			input->q_index = action->act_conf.queue.index;
 			input->q_region = action->act_conf.queue.region;
-- 
2.56.0

