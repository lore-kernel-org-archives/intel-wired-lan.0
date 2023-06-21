Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC027EB64D7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Jun 2023 09:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AAC541815;
	Wed, 21 Jun 2023 09:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AAC541815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687338717;
	bh=lbVvx1IiWXKAmm7CE89ja4BG+cWl6nxq/qpS650NKsg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gn5y1W6AyTlQIkpXBWvWX6De4qF7GEvdbjBtpU8EAPyXgiex/3eGI+6ikq3XAInSx
	 y5Tve4AUJ5x5igZCENObTprA9rgYxaqiJC0K/3uXVxSPSPi+sbFXGq3VCDZO6cuv0D
	 gQivW0JU9f8BI0LBYlWnYCU+9qoVBG2BYf4OKqGYl8zpdoyv8+wafCWo6PqIWOamKo
	 kFsr5K136MO3dhnVBKAFn/w+P/kbu/v1J0w0w6CTUsAFRA4Qc8+Sig9cSRAvzDPFAF
	 v9ThBi8Liz3k7XrbROZnicnKGjHArrYUu7e4ZYShDrDNWWQl492s+L9vhxyNCq1t+j
	 fH9V9YERAzuow==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SSTu9WlBVHID; Wed, 21 Jun 2023 09:11:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8995541810;
	Wed, 21 Jun 2023 09:11:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8995541810
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A89F71BF4E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jun 2023 09:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8244783280
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jun 2023 09:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8244783280
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 84tq4dtscmED for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Jun 2023 09:11:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC13283276
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC13283276
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jun 2023 09:11:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357613686"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; d="scan'208";a="357613686"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 02:11:49 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="748570857"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; d="scan'208";a="748570857"
Received: from dpdk-liulingy-2.sh.intel.com ([10.67.119.34])
 by orsmga001.jf.intel.com with ESMTP; 21 Jun 2023 02:11:47 -0700
From: Lingyu Liu <lingyu.liu@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 21 Jun 2023 09:11:04 +0000
Message-Id: <20230621091112.44945-8-lingyu.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621091112.44945-1-lingyu.liu@intel.com>
References: <20230621091112.44945-1-lingyu.liu@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687338709; x=1718874709;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0SKLGKxWQMims7AJYT0r+CaMkK3rCfFgFvHgnlsBYCc=;
 b=nEpNkyNt7pBNtV9azmeSwWT5dhAyR/NOBc99sFaIE88fhWcH+LVZbJlw
 WdoVnSbKqtjtEuKpQSM/ZAgqXUEj4eLnobL7xAUDyljjxCoQpFjNt7kv/
 hZ2RVX6LIrhRNULW7/Ad6Y+oj4UeGqFy69hT4EQyat10+V2eKUfw1ft0Y
 SZLxNwoUVCPG+qFdJ66EHIHKhlxSfIqHn+gXCi4h+OjZxS5pEVmcj02Ir
 Pu3j+QPVA5bjvSGMo3sV95ZGIioTGbptDey5zdIrWjY7es4HpQ69yL0wC
 TuDvVd7LSnPX2KHx8pkc7Q9IXhGkPYZ35LcwGZggJ03QmJpdFEdW+/5gj
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nEpNkyNt
Subject: [Intel-wired-lan] [PATCH iwl-next V2 07/15] ice: do not notify VF
 link state during migration
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, phani.r.burra@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PF driver will notify VF link state when replaying virtual channel
commands GET_VF_RESOURCE and ENABLE_QUEUES.

Block PF driver to send message to VF if it is migrating.

Signed-off-by: Lingyu Liu <lingyu.liu@intel.com>
Signed-off-by: Yahui Cao <yahui.cao@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 6c99ad7ac2e0..0a10ea0b3b6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -233,6 +233,9 @@ void ice_vc_notify_vf_link_state(struct ice_vf *vf)
 	struct virtchnl_pf_event pfe = { 0 };
 	struct ice_hw *hw = &vf->pf->hw;
 
+	if (test_bit(ICE_VF_STATE_REPLAYING_VC, vf->vf_states))
+		return;
+
 	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
 	pfe.severity = PF_EVENT_SEVERITY_INFO;
 
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
