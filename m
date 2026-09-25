Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA3C9832A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4877881248;
	Fri, 25 Sep 2026 23:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xFrYrfdxx-85; Fri, 25 Sep 2026 23:58:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5DAF3811DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380696;
	b=iJGuKIYSJABzLoasUzGjpNss7VIhYI4EfVUyWlF00QwebK1Hkl1rQVR+sCayad8rqFrK
	 zrIrb/neW+5R7QHo7N7lJlcMwwFFdK3JEkqPNIKZV7mzhbEQOJn0uC2zs4JDC+gC/5N3b
	 0S0GLOi0SUaBc6wZYsn9yeG4AJschDNGxbGV7tn8sresg569DOIrPLyLyI8OFJd85kt4h
	 eAhX94E/uZERTxw0xbrjAC2gdNLiN58c0k8a3hDJah3vEbtQXHpwpLyH6iqS/uNPXkG/P
	 LAGfZdUEkbpBi+xex7Y/oaqpuH2DK8G0JPIV+AOo8j3mVdfiGCN6g8KZqca1Q9mOEZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380696;
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
	bh=zZZgKuC6ohRpqttRLlVHSdvJZYUrgNdAOosuc0UwsqM=;
	b=jBkgUgWHrXlclzD+JUjslMozyIfRfoQR3Ro7SWkb62ldKC0Rn1WvRDjX+QsBQxdxkBie
	 8gM3qSdgON0gPVOFQronu1oykVj9I+17AWd+7X+yFLirVCcpy6j+LapHhBHm60aIh6bAW
	 jBPo3z76yWxUNuJhWe1tQxeKk9K83O4GMwT58KHmzq38lwf92Vf4pNng36hxiMxPq1qG2
	 JAVVvbkie8JJXF0dAf5hFCsyzWWn9YCaFhSBzUU0eh5z6q4yDwIeMozC0ldhFB62xSdg4
	 ncPeIisqha+tfVNaDxT65Dmw9FEApaXBSCjSLHp1guup8hekVLA+LM6YOxhEKXtBmfA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvp4pF+A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380696;
	bh=zZZgKuC6ohRpqttRLlVHSdvJZYUrgNdAOosuc0UwsqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g2xtY4NzrH5X4d3+1ah9mMJHGzeVlogFhPoMwpKgBUO/iBIM45HS/aExRHXpoIA4P
	 mm2NJBvS8iWz2GM2u9oM3h9fK5VGxHHYrxAjlyoBAqh9JQwQMncAWZnanfUfx7rDJR
	 iEC0QJXT7ILDiD3goteScoNQE+aHPWflJMUs+Q5dj57w8Vcf6DFhFElPs9wT1wLaEG
	 1YTRX9tfHeeYX8kwCoTsmqEOjc9cRD0JWxHyu42gE37SuiwCqBS7EPqIRC/2c2rWph
	 QIHsaOUkUDwIYdRBJvotntnq7oFIwiLd3XqXM/nQ5N9HjlqY0mkLFfdpucKjRKuZTa
	 2ck6gx6lCCzfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DAF3811DF;
	Fri, 25 Sep 2026 23:58:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43682194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2815D81179
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPIjyLOiuNp4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C201981104
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380685;
 b=cYTeYYWJDD1pOMkJq94XQBkyKutFfUWCSKTT7eX03MUM9szSwqz5FCYDKmYNsDpv/xSS
 gOBEn7/sGetdGAjrNDwMRfFGEqEo94NIn/lUnY8PjJFMK9Hn5+eUpNvWt6VNOBSYcqhy4
 IvNnGEQFjwT2UBbruncrsohJV8BMJfXDycUxkzEFyT83uLYtTYx28C0r2wlic3FoQzDUK
 qoZEHniUu0sy6/+dUcGiAAKknyJTBTuJhn7fGfLuOKHbDABktjh5IPOLahk/x9eWfx83A
 7WSSNPN1jKslmTtpZvq8Vqn+t1+Q4dEWZtdr0UIOZZn5tJyH60FbJzFf04YMvkjoxMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380685;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=zZZgKuC6ohRpqttRLlVHSdvJZYUrgNdAOosuc0UwsqM=;
 b=W9HsMgYRF0eZ2XSGLy9e21V1KC3sr2FOyRGTLzWMQ1btGo69Za2G0gWo15LcZIKkeg1O
 pJIBYXpk3N9d6yroMRh51xRFupF8QaxLrdtyRqlcccvR75mkCWng/WdKIkwbBnNRNL0V8
 UT5JgAJK3WMaqbxSEv5MD/dM1SzxQdEQ7LTuw65AZrVK8Ya81kyiikLAZjMLowTgoWkQ3
 Q0OkmqGVuSBl6BYCXqOFYNKCWkRJlWNM6Mfrb7LdvoMph3h1m0nAAyNihkyIIy7/y36zd
 IXIss8JeB/tr8x8MbR41ysRY2LxXfHb7GiSh2MpjYT5APF0TNQFa5lrM0AGj2/qxmSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kvp4pF+A; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kvp4pF+A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C201981104
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=h9TjwUyfTbtJLKpm3DxxQ9qNLPlPng6stPIVcDAsPC0=;
 b=kvp4pF+Ae2GYcI0pj6UzoymGHlPDlSWKfZ5Og/Fv4YK6oODCrc0oex1d
 VMz2XibqbQ1ltYwtmOYpephDl7QCDexpOARZ4wWX/32Le+If0oyouL4mF
 fe7+wolRSvBAZQjKyKdHTxHh5Te/CF0TALp+gwMbL3lkCze6HpNe1scNz
 zxGbgEQF5FyO9iptc54fmksigQB52/y3KHe+PMCCIwh42F1iOEyUiRXBx
 RShteeHTyNowRZtHiCkUFd+SdXEetd8/NSfVCec17P8olVvXHJ8m6w2fV
 rAdwYstQ1ibbS8VBEpWkO1Ouo2VP3PXNMwX9vYU6/mvZJ4GXi9RQZI3q0 w==;
X-CSE-ConnectionGUID: k8n2bQfpRPyjGg8MqFKEXA==
X-CSE-MsgGUID: 9omAvvHUQGyeMRYCnXD1NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212808"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212808"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: 2entu8KLQheyb+dqc9H5Xw==
X-CSE-MsgGUID: Nhw5+RKtRSCUD4GeSGMAew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731114"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:37 -0700
Subject: [PATCH iwl-net v3 05/15] ice: call PTP link change only from link
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-5-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=7006;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=AR00dmMz48LkNzIdG/7vAa3q1RC3voeFBCTn4GLW1WI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXJWGGa+4mfe2+164sjeA5d6OpL8XF965VT5l1W6rH
 1bG89Z4d5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCR6PuMDJMDZ6UynK4UjJu/
 5f3l+sSewpdbnhqe+y28xkN3p/hU72aGv8K8grx3H7X2F/aVRLR+MlQQqJ4nvJC5ceVO2dzzFTo
 iTAA=
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

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Remove redundant ice_ptp_link_change() calls from ice_up_complete() and
ice_down(). These duplicate the call already made from
ice_handle_link_event(), resulting in four problems:

1. Double initialization on link-up: ice_handle_link_event() calls
   ice_ptp_link_change(true), then ice_up_complete() calls it again.
   The second call re-enters ice_ptp_port_phy_restart(), re-setting the
   calibrating flag and restarting the PHY timer while the first
   invocation's offset verification work (ov_work) may still be running.

2. Premature cleanup on administrative down: ice_down() calls
   ice_ptp_link_change(false) during ifconfig down or reset preparation,
   even when the physical link is still up. This clears timestamp state
   unnecessarily and can interfere with ongoing PTP operations.

3. Ordering dependency: ice_down()/ice_up_complete() are called during
   reset sequences where PTP may not be fully initialized, creating
   edge cases with partially configured state.

4. Administrative commands such as changing MTU trigger ice_down_up() which
   then forced a PHY restart that is destructive to outstanding timestamp
   processing that is otherwise unaffected by the administrative actions.

The link event handler is the correct and sufficient place to drive PTP
link state changes, as it reflects actual physical link transitions. Remove
the calls of ice_ptp_link_change from the ice_down()/ice_up() flows.

Initialize the link_up in ice_ptp_init() and ensure that we check and
restore the link status at the end of the rebuild flow, ensuring that we
initialize the PHY timer appropriately after a reset.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 41 ++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..f32041dd8b27 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6745,7 +6745,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7273,7 +7272,6 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
@@ -7794,6 +7792,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_update_pf_netdev_link(pf);
 
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
+		bool link_up;
+
+		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
+			     ICE_AQ_LINK_UP);
+		ice_ptp_link_change(pf, link_up);
+	}
+
 	/* tell the firmware we are up */
 	err = ice_send_version(pf);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index bbb57edcec0f..220d174397ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -583,7 +583,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	}
 
 	/* Drop packets if the link went down */
-	link_up = ptp_port->link_up;
+	link_up = READ_ONCE(ptp_port->link_up);
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
@@ -1251,7 +1251,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
 
-	if (!ptp_port->link_up)
+	if (!READ_ONCE(ptp_port->link_up))
 		return ice_ptp_port_phy_stop(ptp_port);
 
 	switch (hw->mac_type) {
@@ -1315,7 +1315,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	mutex_lock(&pf->adapter->ps_lock);
 
-	ptp_port->link_up = linkup;
+	WRITE_ONCE(ptp_port->link_up, linkup);
 
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
@@ -1461,7 +1461,7 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (port->link_up)
+		if (READ_ONCE(port->link_up))
 			ice_ptp_port_phy_restart(port);
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -3271,9 +3271,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 }
 
 /**
- * ice_ptp_init_work - Initialize PTP work threads
+ * ice_ptp_init_work - Initialize the PTP kworker
  * @pf: Board private structure
  * @ptp: PF PTP structure
+ *
+ * Allocate the kworker and initialize the periodic work function. The
+ * periodic work is not queued here; the caller starts it once the PTP
+ * state is ICE_PTP_READY.
  */
 static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 {
@@ -3292,9 +3296,6 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
 
 	ptp->kworker = kworker;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	return 0;
 }
 
@@ -3414,8 +3415,23 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err_release_tx_tracker;
 
-	/* Start the PHY timestamping block */
+	/* Create the kworker before restarting the PHY, which queues work on
+	 * it in the E82x restart path.
+	 */
+	err = ice_ptp_init_work(pf, ptp);
+	if (err)
+		goto err_clean_pf;
+
+	/* Seed link_up from current PHY status, since link may already be up
+	 * (e.g. after PXE boot) with no link-change edge to catch it later.
+	 */
 	mutex_lock(&pf->adapter->ps_lock);
+	if (pf->hw.port_info)
+		WRITE_ONCE(ptp->port.link_up,
+			   !!(pf->hw.port_info->phy.link_info.link_info &
+			      ICE_AQ_LINK_UP));
+
+	/* Start the PHY timestamping block */
 	ice_ptp_port_phy_restart(&ptp->port);
 	mutex_unlock(&pf->adapter->ps_lock);
 
@@ -3424,9 +3440,10 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_READY;
 
-	err = ice_ptp_init_work(pf, ptp);
-	if (err)
-		goto err_clean_pf;
+	/* Start periodic work only after the state is READY; the worker
+	 * returns without rescheduling while the state is not READY.
+	 */
+	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;

-- 
2.56.0.rc0.395.gd1f3524e15dc

