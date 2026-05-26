Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A113CCD5BDE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 26 May 2026 23:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1700F41DB9;
	Tue, 26 May 2026 23:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOh_ALGz63uN; Tue, 26 May 2026 23:25:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A26AA41DB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779837948;
	bh=apju2p0f/aWBx8V2W0fgLJ1MXEDYtaxRyrYFJTf0UCM=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U+7nOnLbGE/LOxOAQUHjKvARL4niabfURoqF9x2aMCN11/OafQvLp9Z5hbGJ2kwYX
	 wL8NfceTZIZPxo0F9NjMMUol+TP72iqpOgDRudcRMj0SmTVKx6gfLC0x3rEh7Zeuqb
	 /PNt1whSYQwddTwPjdSDJRDCxtUyxyyo1rHYmML2RnYdxRYqe8j0wL/G/us3OcV2ct
	 i1al6Nje560jW24Y8p7IxozclEJp+K3Pc4PvvXkQncE0vGDyclDXGey6bOWpepUUN2
	 UOCsyq8F/Yr/80INvqMQ+ruPkhmwNFXcfj8SzvhGjrjeqNHH5udpe+fLK+rB7xqJwb
	 +xdDqDcC/476g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A26AA41DB8;
	Tue, 26 May 2026 23:25:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA91B21F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 23:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC90940B3E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 23:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKMIpj9vALSQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 26 May 2026 23:25:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F00E440B3B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F00E440B3B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F00E440B3B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 26 May 2026 23:25:46 +0000 (UTC)
X-CSE-ConnectionGUID: zH6/YcylSI6R2McPyLGAbQ==
X-CSE-MsgGUID: MPqnJfwuQ4WOHFa6yBfeZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80648855"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80648855"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 16:25:46 -0700
X-CSE-ConnectionGUID: kn057v1DQc6PS2R4wGJ14w==
X-CSE-MsgGUID: FRLt+nZBTK2o7V7DOriE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="265930282"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa001.fm.intel.com with ESMTP; 26 May 2026 16:25:45 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Tue, 26 May 2026 11:47:55 -0400
Message-ID: <20260526154755.362476-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779837947; x=1811373947;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VZ7qMkv43v9yuBsep5hGA52TxAa1wLYHlGWublICJb4=;
 b=EN/ZihuKZeC7Zs0hwqnqBKKyHbMXkkfuzW2/oMhCYz21ZDuGdPkguWGX
 Ab4WCFqRJvEponmHBlHZwZ0qcXXvnTeqAl5mXT3jTfsuznZJ3PxUwAnBc
 yEHu5lyE4686LbCSoDNzIVNOFJy4NmhYDIfJM7/ATGExgfuirygTBzj/Y
 FWBeQ/rkaIVJXfkCxKSoYQPa6GXyRFJqgp3/PGR76oTk53YsGig2sxO1Q
 l2kSYUCjxMdxDfJMZihZy//IDrfSUYtGhWjkSEg6hSVdUJ2eLOzO9joPO
 YTF5tmrcOuCm/jX3DP4sI7gWwhJQtmwQvAUC/lLZdVu82pFsqBgV5WdFT
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EN/ZihuK
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: prevent tstamp ring
 allocation for non-PF VSI types
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

The pf->txtime_txqs bitmap tracks which Tx queues have ETF (Earliest
TxTime First) offload enabled. This bitmap is indexed by queue number
and is set by ice_offload_txtime(), which only operates on PF VSI
queues.

However, ice_is_txtime_ena() does not check the VSI type before
consulting the bitmap. When ETF offload is enabled on PF Tx queue 0,
bit 0 is set in pf->txtime_txqs. During a subsequent PCI reset
rebuild, the CTRL VSI's Tx queue 0 is reconfigured and
ice_is_txtime_ena() is called for that ring. Since it only checks
pf->txtime_txqs by queue index without distinguishing VSI type, it
finds bit 0 set and returns true, matching the PF VSI's ETF queue,
not the CTRL VSI's. This causes ice_vsi_cfg_txq() to spuriously
allocate a tstamp_ring for the CTRL VSI ring.

Since CTRL VSI rings have no associated netdev, ice_clean_tx_ring()
takes an early return at the !netdev check before reaching
ice_free_tx_tstamp_ring(), leaking the allocation. Each PCI reset
leaks one 64-byte tstamp_ring.

Fix this by restricting ice_is_txtime_ena() to return true only for
PF VSI rings, since txtime_txqs is only meaningful for PF VSI queues.

Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 725b130dd3a2..f6671a653f21 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -767,6 +767,9 @@ static inline bool ice_is_txtime_ena(const struct ice_tx_ring *ring)
 	struct ice_vsi *vsi = ring->vsi;
 	struct ice_pf *pf = vsi->back;
 
+	if (vsi->type != ICE_VSI_PF)
+		return false;
+
 	return test_bit(ring->q_index,  pf->txtime_txqs);
 }
 
-- 
2.52.0

