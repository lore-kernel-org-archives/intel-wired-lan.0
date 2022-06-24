Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C226C43334
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jun 2022 10:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEA7E8418E;
	Fri, 24 Jun 2022 10:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEA7E8418E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656065790;
	bh=ioVLeiYeIsGZ7uinnNzWvfiL3AyHr4sNrSrJedd0hvM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=IQRr5N6v8C4awUDDtvyQtwWB1eLhVhjhiFSR2XKIEPnwl9hmSM7mAe0RUSg1ELmHc
	 48L9J/5OIrKHlKhXCRbMwZ2saFgXdhqovqcVOs47ls/20CsAq4l6muWGT+Ca8y5fba
	 pNmjscipfST3k+aG8jKXr6woqn9YxoIWeG2z2J7QlgZamZm6nIjqfYVAEUq6J/70ia
	 5VL0frnEzGoCMHP1HctP41Eg68R2n3cqiLZEwLCHDSqDsYohzoj7BWumiQPlJQ9NR7
	 Kt5YrhN/OV7qPzxTOQ03BjtwUPcaE+GGKTACsC2PHqX6zO4IsKtkGVYossiH4sNoXU
	 5FHpeUi1K/w6Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ykf-F9v9Y575; Fri, 24 Jun 2022 10:16:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0980848F1;
	Fri, 24 Jun 2022 10:16:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0980848F1
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id AD24D1BF2C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jun 2022 10:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85F4441747
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jun 2022 10:16:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85F4441747
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2UcXEvF1H-QE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jun 2022 10:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D5784170B
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D5784170B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jun 2022 10:16:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="282055014"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="282055014"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 03:16:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="678488563"
Received: from moradin.igk.intel.com ([10.123.220.12])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 03:16:24 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 24 Jun 2022 12:16:09 +0200
Message-Id: <20220624101611.1007933-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656065786; x=1687601786;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=elUKqJL1bkUAO5JOqGIrjNpv8PXPGYSIULmA//8v9Y0=;
 b=V8jN/OwsOgBOd+GDVIBXIhznXoUOWfxHyEHAF3w9R0th9n7/DVE4WPIb
 q/gQODWUDylr7YGadqWLB20ku0YJG72M1O6/ObUEEqvM7iGlDyTvsIQiQ
 DjKzjux5NuQcPlmuX24mFZsR5AU7BHfTWwAqnW345bB/5+nh6V+wMrD2+
 vfWGIN+dRo0+VxliyDyPTvbzpGWl0fxrdTZ91VG9ImCbR17Oy1/Wmabuk
 vyB4X2nYvFcQGCxeEvrmiqUUyTx5SpSEn2M5RoeTEpAuhBUFq7CM//aV5
 EILjb7uljzJv0PDeoOq0Q9Z+B2LnbITXqQoW8DYyE+dpYAS9Q8O3Fdr9e
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V8jN/Ows
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2] Improvements for default
 VSI filter handling
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
Cc: Michal Wilczynski <michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Currently when vf-true-promisc-support private flag is set to false, default VSI
switch filter is used instead of a proper promiscuous one. Unfortunately flow for
default VSI is a bit different, which leads to improper behavior like not being
able to enable promisc mode on multiple VF's, or filter not being removed in
'trust off' flow.

Michal Wilczynski (2):
  ice: Introduce enabling promiscuous mode on multiple VF's
  ice: Fix promiscuous mode not turning off

 drivers/net/ethernet/intel/ice/ice.h          |   2 -
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  59 ++++------
 drivers/net/ethernet/intel/ice/ice_lib.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  14 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   | 108 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h   |   4 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   4 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  88 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  51 +++++----
 12 files changed, 198 insertions(+), 157 deletions(-)

-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
