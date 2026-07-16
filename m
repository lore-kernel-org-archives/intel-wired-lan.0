Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D4CC44501
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6E8B60853;
	Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CutnKFV90mPe; Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 720636083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784195357;
	bh=v+9CdqGExDMkmUTUN9Cc3taizMZYSyitiPvzHv+UV9E=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U8ECwnFLR7vIqI9twvgpL/V4LGK9rxm0zZXGNdt921hTSbioEfr8sv7pu8DdSsCK0
	 UkMbhWYZ/CKxWi0XmznNPfrBEFBfaWXk30xs4sVJTc5ZalkuPDDmsRSv1/BdhceMs6
	 XSJ6I3DUs74q6yn4eroSR2EUEDICfUiWvrbKutz9hoGvIIR/WsgiYcjKR15pXLVUNg
	 pTWX6OxMN9iv7DRJU0I4PC9xb8ODoHFsSur6FSnVg8lS2iphltreaVDg2YhKkx6tMS
	 vNthO+A3yMyoAhy3ycyuyXg+Q/idMR8WL4lAmAe/urir1bNhvRCxBeZujKmymQBvz0
	 /zEw3oKDTrfFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 720636083F;
	Thu, 16 Jul 2026 09:49:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAF37426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85EFD80E59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Es7ycn6MYFhQ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 09:49:15 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D5C7C80E57
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5C7C80E57
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5C7C80E57
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 09:49:14 +0000 (UTC)
X-CSE-ConnectionGUID: aokNStguQ2G959Atmy+BhA==
X-CSE-MsgGUID: yyt6kj8QR3iMXga/IG0gmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963874"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84963874"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 02:49:14 -0700
X-CSE-ConnectionGUID: xNnUz+eMQ4iFSB5pYsv2Xw==
X-CSE-MsgGUID: fTo6yVdnSuCZmTiA/Fgtfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="256501621"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa007.jf.intel.com with ESMTP; 16 Jul 2026 02:49:13 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Thu, 16 Jul 2026 09:49:07 +0000
Message-ID: <20260716094912.1210865-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784195355; x=1815731355;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dVeFNYKVg+1XMkICLe7KlD3H7IplzJfaKfK3j0AbkdU=;
 b=lF1Pv+knPJtdv8ZknpXtKOKTgMc02536LKhY79HkhhzQfpoqSmxQWDWL
 fKeZDDdfoW75Mh3be/CWt41+hOHDtgfpfDjMq94oFzfRblemRY2UzVG3n
 288nA3L472P08JX1ju7tdzAVp5w8DFUib84J/jneT7OzoFgwMC5nGmtSc
 OXXnE9L9pzt9cJWWQ9O0FkFBsEcrCBtib6uDwrHc/sGILIciBi0XY2Hux
 cbF4j46TyXDsFY8xrcGgWq0NPGGBsvliY7zcANGpIdlq0Mn00XO0U1Z1F
 xwaKQvXE3w/HSQHIU0UXJ9hKgE2vV1jneoRnrjxJYcDhqDzV6fvb0rIkP
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lF1Pv+kn
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/4] Rework and fix ice dpll
 pin control
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

This series reworks and clarifies ice DPLL control logic.
Contains refactoring changes for better readability and
maintainability as well as the changes making the pin
controls compliant to design requirements.

Sergey Temerkhanov (4):
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 248 +++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 193 insertions(+), 56 deletions(-)


base-commit: bf696cf19d64727a5a95126733603269ed8c42c2
-- 
2.53.0

