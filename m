Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF97C67861
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Apr 2024 15:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1269B60E31;
	Tue,  9 Apr 2024 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXMdH8YEFTn6; Tue,  9 Apr 2024 15:45:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A04C960E18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712677504;
	bh=wIu9nlxNyHix6925uh+XaLMg2BU50WVWcmBdXHu7Lxw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=9WqTErGwtUk8El0vDPF0gU/7Ia+vXHXYvejUDPeMaYIXlAy+1urESY7zkmMFvkC55
	 XokYDCc6m3exIzYAJUNyaIv2kO5W0ISEwQZUc2SKaxwwuOwTxZ9wfWCtqKckJMqgum
	 jP8Szczw83WGbRisG39sd6PLNWXmd6nJQYafyyL2fVVZasiAqti6BuVLkuSEWvUX9I
	 IwCpSF9kBMIxEmju6Q5BzG7GC7BO5Vo7/Aeu0TzwTI0Ou76TRM161o0ItYC2x7yAYW
	 uncaHgcaMddNihZpnUNrkNBfSxzAc2I/fJTCRsQQfxHXvVDW35hO5GJrzbxTLpotkH
	 LbGVtAbo3Sc1g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A04C960E18;
	Tue,  9 Apr 2024 15:45:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 48A3D1BF344
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Apr 2024 15:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 322C38177C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Apr 2024 15:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSiPU6kkv9wE for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Apr 2024 15:45:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DAC1C81747
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAC1C81747
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAC1C81747
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Apr 2024 15:45:01 +0000 (UTC)
X-CSE-ConnectionGUID: naQCiX0PQ5qtDV5DLu2apg==
X-CSE-MsgGUID: qBJJVr/qQ0mcQgYGIHgd0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19427719"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; d="scan'208";a="19427719"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2024 08:44:29 -0700
X-CSE-ConnectionGUID: mGOUQNrFQPSC6FcLlUWIeg==
X-CSE-MsgGUID: 74zR2XfmQz+G2ZnCNS+ogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; d="scan'208";a="20303003"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa009.fm.intel.com with ESMTP; 09 Apr 2024 08:44:28 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 9E9F428199;
 Tue,  9 Apr 2024 16:44:20 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  9 Apr 2024 17:45:44 +0200
Message-ID: <20240409154543.8181-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712677502; x=1744213502;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K7xBs4xpIv+5qSMwNv/cpdYuxUrRNfSRUXsK1NN2ZDY=;
 b=N5p5ZtuVVheGhkoMJkNi1/25wbbz41xmb5QWbyWuykBvXK93h+oso2hd
 gTlKgvITki2CHYkbE+ZfOw9GjEkU/VBoMyML3czV2etZP9VGf3Ba2y82d
 CQBAZflYMGNiwvrn1A+PBUXNoB6r7cRt3o9o+hB7HcIZGrAdoS0iYGZ99
 Hc5ZgM+itwS3XRWiXTHWUye3dXI37fOXD1IVyVHRB5cB/qFAVPOQb6wPq
 BIyBHPQZlFNPNkDwYVk77zqbFZyUJS412iNRM5d38zJzvl+55Dpy79T7C
 rCdFP0KV56IvqnjaYCVq7NwDsAYHsG0z+nY5HbobDy0FB1LVmNoAJfDas
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N5p5ZtuV
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix checking for unsupported
 keys on non-tunnel device
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
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add missing FLOW_DISSECTOR_KEY_ENC_* checks to TC flower filter parsing.
Without these checks, it would be possible to add filters with tunnel
options on non-tunnel devices. enc_* options are only valid for tunnel
devices.

Example:
  devlink dev eswitch set $PF1_PCI mode switchdev
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
  tc qdisc add dev $VF1_PR ingress
  ethtool -K $PF1 hw-tc-offload on
  tc filter add dev $VF1_PR ingress flower enc_ttl 12 skip_sw action drop

Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index f8df93e1a9de..b49aa6554024 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1489,7 +1489,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		  (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL))) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Tunnel key used, but device isn't a tunnel");
 		return -EOPNOTSUPP;
 	} else {
-- 
2.41.0

