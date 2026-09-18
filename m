Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D418AC982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B9EF60DF1;
	Fri, 18 Sep 2026 13:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4ABnEdpFHSM; Fri, 18 Sep 2026 13:32:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2DE660E3F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738363;
	b=NHWZQiIhOIHVULvTqjbsShyeqtmF3eSV20mxkVAItshSQrS8GzqADY44P1C8jatV6fBA
	 iekMNhXoWcER/7TzIH4vzeM5g37f0ThyLNG/P6LmJyEjQJpei43msRApVpuzOTjqTmY5s
	 07YONzDRtAUNHKZNfQY2wRXM4Z7f3sLOIMWr/W2XN6xuCUos1jZlVmcNR8cRQKWWHeHsl
	 Eb6dx9wVaC/NptaVHxnornKvd3SpEpA6ilnFM39NmRgUj6i0XM/vI4alnDtCB6gehc7D6
	 UVhyvZVmYseYpZR5+dgpz3NlcaiyYz9U100Wyjz6spcc6u1wl3z57x3QrYLe166b7SA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738363;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2amdIlBcUnmD+W8TT1ZYD1JibdQE72rUlEG8I1btosw=;
	b=U5EkLUnDzQ7AJQUqAW94jkMwwchj8VaoLS7CloqL0XmPoq95F9g3WZDXnDW8i8mIgODe
	 0QKY6k+MMfjmiTt1rrshqBXHl7elmG5CcB+00TQLtUUjNnvCvwp26MHLKH3Wf6//YNd/b
	 /tzDcbeobz5P0gENEvjjgBgKfGiVRn1PcII7pGBJ1AhoHvXoHiV8nPDl+U7yLbAf5iWN/
	 WQhiXz9yBv9fgMdpzD/niEVW2xaqAqeuAQHm0n1CIHNBzbgfTmzZ23rq3JLXvnjY+Kjjz
	 +rymmlRBNMrWgpMEKcSmPqn4OAs5E+C0XZobPPG1eSiLPeCooQVBO/0i7rEwjnjNbwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738363;
	bh=2amdIlBcUnmD+W8TT1ZYD1JibdQE72rUlEG8I1btosw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bKz1LmaYrVI6u7eIoIACXHGmh745wh1+1pHcCwIvoI0T36Xp5+AEk9/KH1VgK6R8I
	 s+jKEy0l4DrLX13vu1Nr/OYH03pQZqfbo7V7YXdv1Ud4VhMUfysQqJniwAOylt/JT9
	 hdbEBbQwgtrEkBUKD8HXtZxlVP7OmbM5gXZhYeba6EPfG5UXiLjq5sKardfvnw7Y9u
	 OofQOUaSUoWl+h4r4MObqTDRCxFq7s6k2aZiQNgt7os5FirX2/2s0tPCLsSzoIyVkm
	 ZSoyhck435XaSuO45tqlFPNL7bYNZtG0YK3uIQb+0M6D44ezsYmpf6byV1cRMrzFbs
	 u4aAZ572udgSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2DE660E3F;
	Fri, 18 Sep 2026 13:32:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2361B279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 218B740524
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHL-7Ez8-9F2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4E11940348
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738361;
 b=Fll4VLzai07dWDzFppOYnLB8n6cU18eyn5yLKXT4m0v11oQU0oRnyoyKq6s0Xsm+0AXl
 TC8uqkzBD8u1K8XYVkN7fZN4SeUdzjlVPPj7FDBUCBltRaMPwizdILvmFlWmm2WOMBd5a
 dMqDYjD/aYLp5vOOv6df3cIMaonEoBLB+kd7A8JqktiNZLSdE+OVoEfD0WKbmjPYnEbHD
 hM67z+4kmcOjUt+IrbSIHj/Gz1RwrTInqmzBoiPX1sSGOUYPotAdLGIro7brzMQL0CMbQ
 ATXrIvwiz9aQIfBJLozlO2NR4mjqGT63sAFhCTXgY7Cilbt8TLqS6yeQW5qwi8b9acA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738361;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2amdIlBcUnmD+W8TT1ZYD1JibdQE72rUlEG8I1btosw=;
 b=WDdGblhyDri7BefpMH9IpQsIvIBNAD0LbZ8PhQBKD2SpNBPCKU9FwsQGijzrrkINURZK
 mMIs2jiuHBhZgfzJmAr9XFL/tv9oHJ5xht6zvt71cfXaLPe6zC0AcddH74d5ykElU7zs5
 qlYtMOg0LadGMwznWIU4do/IF32GuvTeMZTkJXlbmFsVuXEq0+6vHlZA7vGnNX0OpJS4l
 r4X2CFoZEnpSbxDWlWQjdwc6tLYon12lrjVM2iW8wX/Mbwvj+gs2/ZmqRfWMpKlIkNNo/
 BDiFF6R9z4YwPvN2no6U8wGPjkKZRVK6DnY7auu3JyZMiN7UmF/1gBDyax4FfjH4hDw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=F2JVOfsH; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=F2JVOfsH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E11940348
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738361; x=1821274361;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BtwOBXqZ/1rbZ6xusRjG+PNwnS2FdwGYUBsaWILvJCc=;
 b=F2JVOfsHMvpvQeJ40ZPL1Jx5Enx1BOBxsXlIZawARO8ooBaud2Z0PlLv
 7Vm/+R899lOk91eFAZ7mcecDucdJVd5+gwV0NZ5DYajbDb6jEhcofM/9D
 edywagGKs2B86tIDEf4h6CUzKkm7Ef7KYO8uezOvQyX2lkH/iCaK7oQqE
 aMqkIM5R6AS0WlNHdS0XhnfDCJzB2x0LUjJxgPqxFVEjoAjmGkWvlQK6n
 OCpjB6MVRyDL5ElxRXariDdt5/qnRmCe329sdAOI5Pe7YoVBZx6OHXccD
 jdpMB2Q6qWO8fHoQ3YRPfrGluaeh2vYLceKWD0Ym58Nrm/VGhsBpYBikb A==;
X-CSE-ConnectionGUID: m+ICvcFMQbWFq++rJWhxOA==
X-CSE-MsgGUID: Zi8aaQ8iSMCdOIhOWkqXaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776420"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115776420"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:32:41 -0700
X-CSE-ConnectionGUID: FkIJlOAET6CCW+QR4Aw3YQ==
X-CSE-MsgGUID: IuzPXyZUT5ywZmvuHW07tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835252"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-net v3 3/3] ice: support RDMA on 4+-port E830 devices
Date: Fri, 18 Sep 2026 15:32:34 +0200
Message-ID: <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
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
Move the 'RDMA functionality is not available' notice inside that same
condition so it is only printed when RDMA is actually being disabled,
instead of unconditionally whenever num_funcs > 4 -- otherwise E830
would log a spurious warning even though RDMA stays enabled.

Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0463310..1c4421f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2510,16 +2510,16 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
 		caps->maxtc = 4;
 		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
 			  caps->maxtc);
-		if (caps->rdma) {
+		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
 			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
 			caps->rdma = 0;
-		}
 
-		/* print message only when processing device capabilities
-		 * during initialization.
-		 */
-		if (caps == &hw->dev_caps.common_cap)
-			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
+			/* print message only when processing device
+			 * capabilities during initialization.
+			 */
+			if (caps == &hw->dev_caps.common_cap)
+				dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
+		}
 	}
 }
 
-- 
2.52.0

