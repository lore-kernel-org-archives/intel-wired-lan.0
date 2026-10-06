Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE26CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB088605D0;
	Tue,  6 Oct 2026 14:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBIqp-6HLPK0; Tue,  6 Oct 2026 14:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 364C9607D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297202;
	b=fSTtesKdFCGkDvPTBl0NSKRGe6jaBoeqoXd1fNo+ttf1xbDzm+2p2ACBsoECqKL+ZVpa
	 wkb8uMk5WguE58EvAYR+sRfLygQWwMoQdsz3w5/EvBgDHOAbpUzp3nFBru39RcB/N2AzT
	 fE1WepoFNxz1joPjQZY10824wyN6jprdv2Q95vWBzQUh78h3ed+IZ7tq1XcVv5ZIvt3Ie
	 /PGJ6BgrAadDFMF89mdUejB7OB4PV0JvWMab23ZIJq0SJq+/mNbkwuSYyvTDY9npOIgEj
	 Q+L6qN9/6Wl4GtIwBqyvOL/aDShuV4cT5AYqJ9eebJIbKng0r6y0J/xAo/CAWK9KxuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JLQnrdA+hOE61tkxcf91z1IZx2PlNPF/Y0t9sgJDweE=;
	b=tDdycnekxYd1zYBSlcp6VW4FRIaLs+xu60BW6yN1FhGOZY6rXzmKmWiY5SgMRSsM3POi
	 duH64vpAGp6ufujjXtty7dRbOvFGGOHFD1oWHvM0iWqUf9U7oKvqm7u5kbxoYBY/JzCDI
	 qXrUDvZvKbVfQnWagd/AD/P9G588wURNOd3LPkdZBnjJui33DpIV6c78/NHvq+xa9QRFu
	 oAvdVT7yZbsJmDGIexJt+TdT4A/9IGvkMwHja921d/PGE6hje62wn3mWndOBZS2f8SiCD
	 shK6KIa4Ns9N/RFzbtZMvmvB8/bXPNN94tZWisj/eMBGBn670ws3fm3TSzwKWIDmJPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NdSS9VBC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297202;
	bh=JLQnrdA+hOE61tkxcf91z1IZx2PlNPF/Y0t9sgJDweE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7cxT7umlIC0xaSNVb+1kSOzidfSz3M8BJdLYJlc4Vib07XrSbTqMjk/AiUJe+jR9D
	 eq02zniFTOgr1m/KfQCbtGv+3anD4CFOaD2SHUSKusHBqtNaZetJgRkXiX3rqdQ9Xr
	 FeRKH+RfBMmMjcsIuPKhOFW2C2XZqXQCJOXL9eUKNH4cpp7rwxw5P2/w4QMZhpTXKm
	 CoAT6zEFDp9389hSNkIdBdi5r6uIWoJ9vFGDPyf+D5UmMkWFCDes1hUjdbCdBptKe9
	 X590cdYB1mZombHyxwhM0lpUY3jwveKRSck5YYaKdgMWUEU7saJhIr27mkjpmF9qYV
	 Re/mBQ/Nv4heA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 364C9607D9;
	Tue,  6 Oct 2026 14:33:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 151C3317
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF2FF607D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YoUxvJd0RcpS for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:24:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D9A8607CA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791296692;
 b=XesnL+v+CA3eMwPS6pGH4wfkZadm8XQPhsizk67wieUC8l96c1lHocK5RCYrYOyQ9gZw
 nITxX6MCjhGsZTLdDkUXLe2qYxG9JOmcvTGzA59fLfSAJ9z13EN+Y4xNsoAutkdGShw5B
 9YQOZg7pC4t8CuxutfjQJ0B14kf2W8mnRKYtqUesS2YymDvR6csSQvmnBZBWLqjg9pDMr
 kkBSr7246+RRtuO1KEsJQ6nargFWlICjXIURNCRjLddbdZBoIKGEjBhVQh7xAHNL1H15h
 9O4ucNOmHJr7d2f7XViZrYGg4nHFjL9RSQKGWXvyobsgnjOLifHOVZGODo6BGtoMoXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791296692;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JLQnrdA+hOE61tkxcf91z1IZx2PlNPF/Y0t9sgJDweE=;
 b=Edj60gEz4ED+OEdXLNwKFkQBP323OeS2h5cR04NhtCAYTfrb1r9h33gwi66qE2OLlC61
 WpNe2yw09GxdzhpAoHMlY6jM3zA6IigIrCuAvUTjLOUpAxNVoCNXJ7B0qLXXoCHJ8Prb9
 t+JIMRnGIeFkdaCa8QJp9wXXaOMNv0eltHtUoSrzAJysZ748AaZ0H8FckuUplphitToAs
 mARnX+5L5b6og8EuuM/2sf9vscSW1p/w6K6xNdmkBCMbahGzAX2KXHBVyph34Djw3rPs9
 3IAwLIm28nUgaduJ/gYvfaWCNCUKHxM7qARXzjflmwmRY/ZC9jFJNOyrpWUOdELhJZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NdSS9VBC; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NdSS9VBC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D9A8607CA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791296692; x=1822832692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RMo68fl420udOF93WAO5RGTWrBg2Vb5OYhNlumVhqxE=;
 b=NdSS9VBChHMys7UFWoQQAn9YPOWILREodAwFDQOpcaPoXsECycWYVXcW
 NEcCECx5gl+eho8b8GnucnYzEFY2e80czAEkcoFny/ovwdNYry/rDSkfu
 nCIqgxxOhtXw3wsTWSJJkrJfknnPMPaYsGeRB4V6CPU2ocEyMG4ut40gF
 BKSfB0p0ONyxUtxNoTpcHa4BzdH6z3pIVNUcdKiQJBjstFajoPJvVa9J/
 L9qbE0bKQ9FYXutZsCtD1AIn/j5Xl3aMSKQnaHLF2CNU86ghC/rhmzJmr
 Q3KAvA9GBLmcM9k2XeBK18F2IVw+9hmuLVTvhVNpgy7mFA5vXO6wd8eb5 w==;
X-CSE-ConnectionGUID: 535CBB7TRvSMDtvBWxIwFw==
X-CSE-MsgGUID: GyRBlwZhT/Gg1Hs2Odlo+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117507491"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="117507491"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:24:52 -0700
X-CSE-ConnectionGUID: UZb9HIDFQd+LkQPN2aNo7w==
X-CSE-MsgGUID: ghqgmYxPSQ2AFh2H31a1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="305105881"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa001.fm.intel.com with ESMTP; 06 Oct 2026 07:24:50 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v4 3/3] ice: support RDMA on 4+-port E830 devices
Date: Tue,  6 Oct 2026 16:24:45 +0200
Message-ID: <20261006142445.2867917-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
References: <20261006142445.2867917-1-aleksandr.loktionov@intel.com>
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
Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2396ae6..3e81ebc 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2512,16 +2512,16 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
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

