Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E910BA431
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F8F083C66;
	Fri, 27 Mar 2026 07:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5-QK02WQJRr; Fri, 27 Mar 2026 07:22:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90EA783C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596165;
	bh=iD4873NpGb57fGco40CPEG6s5r3mNXzbht9v0CAKjTE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yS5f2LmsKio1x5rlQbtMpI1vOLbsUNu0JCep+j/urY0PbglaiYYhpv2c2rh9lvSMN
	 xrct0Hm/pQKxiDZ1ZOjexBJ6rMFXJmYmwbSiZcb8hEXtfzmAAGeJb/aEOcJIFxXB37
	 sNotfnu9f98eEis+O/Q91eRQjSN7YvYmUBwPx4VbdlUjp+9BNNytw5cM8fN/9T+JYm
	 Wi97IoGNp3JLktz19IGNDhqunxHsA971y3XqNN4Te+CQ6qPq1Am0oAWeXsBtnmY+vm
	 eTG533qNXOBCPOWGiykeJwQdupUvkVFEWzEjq/OXeKw88k+YTzxVtAu15LZR3WZFME
	 AGtIeiEPMiJQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90EA783C44;
	Fri, 27 Mar 2026 07:22:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D40FC249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5C3C61279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGysrMfPlSJ1 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:22:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CBF1A611DF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBF1A611DF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBF1A611DF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:22:42 +0000 (UTC)
X-CSE-ConnectionGUID: WMnhkDNZToKKCB65biiCVg==
X-CSE-MsgGUID: WPo7097BQHeLM5T8/3cWmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848620"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="74848620"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:22:42 -0700
X-CSE-ConnectionGUID: 955Bkq6PQkykoS+cUp64Ng==
X-CSE-MsgGUID: t9hH/tsHQxWCvK2Q9LqugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="222359563"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 00:22:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Date: Fri, 27 Mar 2026 08:22:35 +0100
Message-ID: <20260327072236.129802-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596162; x=1806132162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NPzE/oAt4YAyOSuZTJ7ABZ8cwWD0xhoFinLo3gs+8r8=;
 b=X85NKgmfVmy5G3E0xZu/QJLLtMZcuN7ZOxFHztOVpBPEt3q1ioQ6q2Mv
 aqgBygls8ukl8jv5v4AFuSufDKI4ZsSbYr8/glLLy0Zw3twmaIA3OHDOF
 Cr5CJ7A0FXpyKTjFxKHJAZfKvncYTkgb0jpQ96Seq5u9OSqSdFOQYP9IC
 KYtNTCtx6ajm8JlJ6dJcOoxKMXhgRM+qbVFPIhkzxCOCGU/XgNY1MZFJy
 7e0TtJGCGQpryRA/IFGrnkCYsNThJP64QV18ZGQFzjHMiOYtUDdGaWyYT
 Iw5Y1JpqpCEwJDcRHtSPSay4l9II5LcUbl/mL992I5W3XC+w0NBRHyrov
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=X85NKgmf
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: fix AQ error code
 comparison in ice_set_pauseparam()
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

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Fix unreachable code: the conditionals in ice_set_pauseparam() used
the bitwise-AND operator suggesting aq_failures is a bitmap, but it
is actually an enum, making the third condition logically unreachable.

Replace the if-else ladder with a switch statement.  Also move the
aq_failures initialization to the variable declaration and remove the
redundant zeroing from ice_set_fc().

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_common.c  |  1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ++++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f1a6601..6dad7d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3883,7 +3883,6 @@ ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 	if (!pi || !aq_failures)
 		return -EINVAL;
 
-	*aq_failures = 0;
 	hw = pi->hw;
 
 	pcaps = kzalloc_obj(*pcaps);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 2a4f06f..0cf064c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3501,7 +3501,7 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_port_info *pi;
-	u8 aq_failures;
+	u8 aq_failures = 0;
 	bool link_up;
 	u32 is_an;
 	int err;
@@ -3572,18 +3572,22 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 	/* Set the FC mode and only restart AN if link is up */
 	err = ice_set_fc(pi, &aq_failures, link_up);
 
-	if (aq_failures & ICE_SET_FC_AQ_FAIL_GET) {
+	switch (aq_failures) {
+	case ICE_SET_FC_AQ_FAIL_GET:
 		netdev_info(netdev, "Set fc failed on the get_phy_capabilities call with err %d aq_err %s\n",
 			    err, libie_aq_str(hw->adminq.sq_last_status));
 		err = -EAGAIN;
-	} else if (aq_failures & ICE_SET_FC_AQ_FAIL_SET) {
+		break;
+	case ICE_SET_FC_AQ_FAIL_SET:
 		netdev_info(netdev, "Set fc failed on the set_phy_config call with err %d aq_err %s\n",
 			    err, libie_aq_str(hw->adminq.sq_last_status));
 		err = -EAGAIN;
-	} else if (aq_failures & ICE_SET_FC_AQ_FAIL_UPDATE) {
+		break;
+	case ICE_SET_FC_AQ_FAIL_UPDATE:
 		netdev_info(netdev, "Set fc failed on the get_link_info call with err %d aq_err %s\n",
 			    err, libie_aq_str(hw->adminq.sq_last_status));
 		err = -EAGAIN;
+		break;
 	}
 
 	return err;
-- 
2.52.0

