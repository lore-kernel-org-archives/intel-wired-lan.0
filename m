Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FCFC4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 14 Dec 2023 11:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3B9E60792;
	Thu, 14 Dec 2023 11:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3B9E60792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702553125;
	bh=r0jFMbN1/DCRqdXSplPqdruPTu2TFkbOQubhdLuO9rg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=U0ILr9yse063OEYkHXuqrfyyKTFoXPOqnXMft/auqWodurL33GkASYo7R1eOKGnZj
	 h8O3ryK2atyGIZPnEPiETrWXjo6uYz3XIdTLPARSbvkNuQc3FfpFprShqj4KZ4MAQD
	 vjxaxFL3c7eV4m9Xe1Sim15ioeqYgx9ytIE2OHgSriZeU47//+ffJuMRYEwnFNdlr5
	 YHWiUdIyaJ/1WVOBNZZAHx+GDM12HzE/vBRYM8gKKDCTgwEyod5GlZddAzCzpiLXjU
	 d84qtoR1C1t2e5iUXSYOpgx3aXrxrKwps+ZuaErEi5To9O/ct/BA3czaTh9piGrUGq
	 nOle2e03XGVBQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HoUKpoLiYL7b; Thu, 14 Dec 2023 11:25:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF206F614;
	Thu, 14 Dec 2023 11:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFF206F614
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id AF5971BF2F0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Dec 2023 11:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F129436F2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Dec 2023 11:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F129436F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dqGXi5l4ngPU for <intel-wired-lan@lists.osuosl.org>;
 Thu, 14 Dec 2023 11:25:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 944DE4013C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Dec 2023 11:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 944DE4013C
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393977387"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; d="scan'208";a="393977387"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 03:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750503271"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; d="scan'208";a="750503271"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 03:25:02 -0800
Received: from lplachno-mobl.ger.corp.intel.com
 (lplachno-mobl.ger.corp.intel.com [10.249.145.51])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 2D0313A3C8;
 Thu, 14 Dec 2023 11:25:01 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 14 Dec 2023 05:34:47 +0100
Message-Id: <20231214043449.15835-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702553105; x=1734089105;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qWNU/qKUCy72Z2wZf+28srtB/TxNz/lfvuv54u997mQ=;
 b=mmnc/aKskNsxDUpqfyZL5N4mTrU9LVp1+zW9r7lgJ6e2KCqZERgtzENm
 0zMhrm4Bu7wj+4cGYiosSXQjKFr+MKt3FcMnHpkFHoT9Di9UUgdfr9egK
 EmFWfTwMnG3IRpr1gfhvo+OwFyEU/KpJxQcWfkGfbRSyb7uZ3C1B0qZv4
 OH6ZeZx22KX0U+D50K5m4FaoHKOHp7lZBz8sjkYUyDFUQSdSlxhB/Rg+U
 ej2+d3npEUzkOXQvm4JHyCY4c6joTBCo5UO+tz1PiuZSteVmdk0EeTxwk
 AqKnZxe+FMrzn4ZdQ2NZCgA0Ak/zRoUnE/tWkiZWNdA5Cl3YGGdhavke4
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mmnc/aKs
Subject: [Intel-wired-lan] [PATCH iwl-next v3 0/2] ice: Support flow
 director ether type filters
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
Cc: netdev@vger.kernel.org, Lukasz Plachno <lukasz.plachno@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 128 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 205 insertions(+), 47 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
