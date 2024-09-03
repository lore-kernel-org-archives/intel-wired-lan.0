Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C2CD37AB
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Sep 2024 18:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A983240A02;
	Tue,  3 Sep 2024 18:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GqYs20dhN0N; Tue,  3 Sep 2024 18:43:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A21DE40A1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1725388986;
	bh=/LVyIECu32f4UU8taso7jleG5ukvwJ7wskdqDimb/so=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=lCNpaxm6eTs2Duc6tKvcbAeNE8rex5XMpJ/FstlKjsccyq2I76cLucdnXXSMo4WFy
	 Fkk7Hk6o8sekMUo3w3FGEXgcike0r33AEE6K0B3jRJTlVYTzwZqSM9exQ++g3NDiRl
	 phgBYeYJdwWnixl4U2JFzQmp5CtKH0RtY1JEyTOHzbmDmF9f7QwgCLqrDbOukFP/bB
	 9pzuA/Fq2OhLTHC05ZF0s0qOVbaJVdjbrMJ9IqEUGO17M2gxxtTYZJs1J4nT6M/PXx
	 wSbw86gEeVfjkCtkSJsEmlWTXHafr8+X23Cmtw1K3DIN2sSwiAaOSCrkRsDBmm7KIv
	 u+ykTSgfXPsNw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id A21DE40A1A;
	Tue,  3 Sep 2024 18:43:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 305151BF59C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Sep 2024 18:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B3D940A1A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Sep 2024 18:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwbVWkBdSHzx for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Sep 2024 18:43:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=joshua.a.hay@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AED4640A02
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AED4640A02
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AED4640A02
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Sep 2024 18:43:03 +0000 (UTC)
X-CSE-ConnectionGUID: jvWUwQxgSQyGgcZkc5Dawg==
X-CSE-MsgGUID: h0Q6Tl/USI2MWCdxdLWMTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24148511"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; d="scan'208";a="24148511"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2024 11:43:03 -0700
X-CSE-ConnectionGUID: FAb18MeQSmqXZesO1LIS/w==
X-CSE-MsgGUID: zpRnkUTCT7uay3rrJ2F3Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; d="scan'208";a="64655220"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
 by fmviesa006.fm.intel.com with ESMTP; 03 Sep 2024 11:43:03 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  3 Sep 2024 11:49:56 -0700
Message-Id: <20240903184956.1572344-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725388984; x=1756924984;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ld9gagOa0fa1CJUN37/ZlIKkg9SRVVn3N2D0lHHCkzI=;
 b=jN7ALio7hIvZ1e5cYlNdbEwh5mfDAadrIbLAPQLvzcQjpfxRlZv4gyQI
 azlIN8T1sapMNYbuE8x2iZ3lV/YB5FfcXq1mi7Q4vQcK/YI+d6w9za/9k
 dKuO8Ym9mwqvTM83TOqQFEgHT/jvnthwzjfIw8zE++ndl6Qf385PR8D0a
 Kf2eB6EqSZ0iF/rCs4BTmKrc9tWbnbaKc8+ODZlZn/8rlXPwHVbhyrGz7
 wJ6YaNImH79ZYF5Kb+j788Cz74qD7wEkjU8KcTC1nJsbf9/Ol/UlZRC7N
 kIOR5Df9NFsgRah3mbCcFxPoomFdkHeMcdiap3jtGbjQQQanJ8XSO7IG8
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jN7ALio7
Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: use actual mbx receive
 payload length
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, stable@vger.kernel.org,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org, milena.olech@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When a mailbox message is received, the driver is checking for a non 0
datalen in the controlq descriptor. If it is valid, the payload is
attached to the ctlq message to give to the upper layer.  However, the
payload response size given to the upper layer was taken from the buffer
metadata which is _always_ the max buffer size. This meant the API was
returning 4K as the payload size for all messages.  This went unnoticed
since the virtchnl exchange response logic was checking for a response
size less than 0 (error), not less than exact size, or not greater than
or equal to the max mailbox buffer size (4K). All of these checks will
pass in the success case since the size provided is always 4K. However,
this breaks anyone that wants to validate the exact response size.

Fetch the actual payload length from the value provided in the
descriptor data_len field (instead of the buffer metadata).

Unfortunately, this means we lose some extra error parsing for variable
sized virtchnl responses such as create vport and get ptypes.  However,
the original checks weren't really helping anyways since the size was
_always_ 4K.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..3c0f97650d72 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -666,7 +666,7 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 
 	if (ctlq_msg->data_len) {
 		payload = ctlq_msg->ctx.indirect.payload->va;
-		payload_size = ctlq_msg->ctx.indirect.payload->size;
+		payload_size = ctlq_msg->data_len;
 	}
 
 	xn->reply_sz = payload_size;
@@ -1295,10 +1295,6 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		err = reply_sz;
 		goto free_vport_params;
 	}
-	if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN) {
-		err = -EIO;
-		goto free_vport_params;
-	}
 
 	return 0;
 
@@ -2602,9 +2598,6 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 		if (reply_sz < 0)
 			return reply_sz;
 
-		if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN)
-			return -EIO;
-
 		ptypes_recvd += le16_to_cpu(ptype_info->num_ptypes);
 		if (ptypes_recvd > max_ptype)
 			return -EINVAL;
-- 
2.39.2

