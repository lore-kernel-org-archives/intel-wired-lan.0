Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BA7C88E7B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D4986077E;
	Tue, 15 Sep 2026 12:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUZ1sYVWz4se; Tue, 15 Sep 2026 12:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 759196075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476938;
	b=kdecz74a/NG804Kp/0u8Xkg1E/bmlGl8S1nTI/hI+5PZnOhMnN9RHTIP4g/SvQDf0eaw
	 +dPg9O2Y2iJOdhg/jil13WQfiX0Lm9jsgS5BqtOH/ZGxiK8JxPB2xp5avRKCfZCUTumVW
	 B+s5+8K4Ws4pv8xhmksCgHWCoteaGeURQk4puz7I37wcmt0S8cru9fY65kqDB82ckcABd
	 BA85ubviskPvc81K4l/uLk4sMXHgV4Bsw+rVqChFvqzCjzRbIRkbyQ9C8+0+vSrHnYR8C
	 RD0FhkookDpnlu4uS98kqdyLpGo/VPYxNc2Wjl01p/lsVYvMfPbMXEHAH+J2xmqNgKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zgi7CQbue79M/v+X+Xp/wsoPrjh6140nOaMOQIZ1a8M=;
	b=F/CbnQgfoVNcwWh1NgtkMEioCjeQl0WjAXD5YT+6kavijsXx1fcjHXy5rqwSHbmclxTJ
	 IT0pendlgOibaujjOljmQaxnST/BgwMB0rE0vg7z7AsQ3im0eNkoXOMa7OJJNMY+DP3eI
	 /8S92z3U/Yj5D9Iq8sXjXUvGZ2vkOQnq2cHUSzlNnYXqPtEOwn7zamNr9eA2XU0dm8Iz4
	 8/Cp9us9FAh6qiL/kmxnb6qX8oU4zmZA7z9oJ85Gr5e9YRsL2nhE3QK8kiZsDPcCIqlbH
	 ZdI5fL12uwzY8GJOtbc2Z1eJtsceEXDMYH3j9S2gYHCqofjPeHa9UwOcrn3EHEvCF0w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476938;
	bh=zgi7CQbue79M/v+X+Xp/wsoPrjh6140nOaMOQIZ1a8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gds6oq+v1ZlYE5YArFsJCICdHKX4Cy5CBqhdfoo83KnH7fvigP0jfap9zh87PLJzm
	 NaT8Apc7kbOWGUvk0X++h5r5Fba3PAhBQMGeQ1oXA2ShF2zBTbHzuzWB7va2/ObJUU
	 FYqaJt+QwHZ/m2hRjX1WjrnITTT4LXKyJ7Ti3XlIsLeRmUuhjCyKImBSpZd/4F7r56
	 iVvH84aj1+rpSghPAXCqtJP0D+U+Kz32lkqse+v6SjfMtQSDBv9Pc4cks4Sb2ZYX33
	 tHARNJ3EOSt09gXdR3VNx4MI6EIuPvy6mjEWie3yqBu6uZL/KtzGTwYvsicyE9bSCT
	 jdr+XGUVLWD2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 759196075A;
	Tue, 15 Sep 2026 12:55:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99C8F259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97B414009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Szv4wHVu4w9s for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C4ED4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476936;
 b=fvnFib/z0s9Kr3mgmNKxpxWuUBGQnD/PXO+OgNOt/FqLa8VVxK5KiyFlY0QxkK0A8HAu
 dUYChgVudSIbRS7+RVv3SbeWelifALG+EOMRhiiqKnHBjs3FAs4RipgY79Q4sP0F+AtLz
 iUjXkNy0YtuiJcomwAW9FpdeMJN61daH4pKjgsECedhmcqdIZTcusCpNozWi5hw8/9cop
 u2DFjSfAZXWEBCaRb+7tSENrDJfd/3b/6uWdoVT3GyJWL8f4Ndf1kozw3OHVyvO8/uwQ8
 uLZD+TgnKCg/fsFxSypp5T4zZ70Jd8GF+QpX731ptX3lqJ+lfOaLwq8Y89Eh/II8Wyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476936;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=zgi7CQbue79M/v+X+Xp/wsoPrjh6140nOaMOQIZ1a8M=;
 b=N9Q1c92/jkYPBa4LcvMrsR8pE0QzMeyNaZwIxfU1r8Uq4iqo1tN1ZTdzQyu0wP3k06nF
 yBwaepFo5yPWTavmTGm2fKrRFKE2Zy+fjgDvopSO425XyzLHqocKJ8GZrrnQMmDieSPZe
 F70t7UbS8sgWbB4ztF0rfiaW8fJHIIuIs0x0Eh2VxIPwu2GXDz9z8OylYhkrPO/+aAbOz
 hnsw51THnvRwp4ZjATPkYGrm5Z7PTV6y3JvNHN4s1rr4a79pz9otfrt9nkzHnxo0VN+dT
 EowIt1/O6iTzULXMNDblclS22ZC/Avzut+qNzTVUmedDBcekPj2WNQUtJigMdCW8tGA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cEiiNUc8; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cEiiNUc8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C4ED4002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476936; x=1821012936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wkYdKCahcYvuXtF/djytxmBw0lj6xW76BgT0HfFKymA=;
 b=cEiiNUc8QdyQ/lokJUs7fdwDHn12W/Qje+tjht3yk+KldofQpo+aahdi
 NsLXSz2EwgB3NoecS5Q2Ezy3F0+QHvQvpol5VGF0EMg2Id6kwkjkLsdhq
 ZwUigTebybxNv4pEnSjaDn1kKh3mY0WUjIFNGG4DJX125rDd1GEU0RxTY
 GruJChNGwI8jc0eEUbRfYoPZRpmwKZMRONxcnULCMOQ6znqa5wHdHrkto
 XQmMrHGJQHB1stZq/KW76KoMTxkznOO8WUjvAG6CVwatwl+/ivH3G/adN
 oPGCrDGMas3wn8/kyT1zp8DhXdWV+TWcL7ljagskaCvzm8E+bbu0PQ2Lr g==;
X-CSE-ConnectionGUID: lrQFmabgTJiTCKnq/NYqjg==
X-CSE-MsgGUID: uQbte2P7QrKHdrAnJjv1BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853107"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853107"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:36 -0700
X-CSE-ConnectionGUID: hfI6/nsQQNGXgmlMFhPb4w==
X-CSE-MsgGUID: brN35pjzTPS5gphhgPG8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225189"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-net v2 3/3] ice: support RDMA on 4+-port E830 devices
Date: Tue, 15 Sep 2026 14:55:29 +0200
Message-ID: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
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

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

E810 and E82X devices do not support RDMA on configurations with more
than 4 ports. This limitation does not apply to E830 devices, which
have a different hardware design and support RDMA regardless of the
port count.

Narrow the RDMA capability disable condition to skip E830 devices.

Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce10..d53307b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2507,7 +2507,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
 		caps->maxtc = 4;
 		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
 			  caps->maxtc);
-		if (caps->rdma) {
+		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
 			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
 			caps->rdma = 0;
 		}
-- 
2.52.0

