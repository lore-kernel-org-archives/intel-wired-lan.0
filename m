Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143CCC48295
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Feb 2024 13:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA09060FE1;
	Mon,  5 Feb 2024 13:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA09060FE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707138785;
	bh=6x1soBIIq8Bgz77Vz10OLaC9+Cnq9C95fnodntW9JKE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=wEovq6EQtKu6TUL2RvxiIQkYybuVZw97xsvWWz+8XRwvlHhPWb7Sgc5oIQx5NtFw6
	 Gz3tXJy8ifsb9h8V8hDU+o9XgZskR52XNijp549eilfb+nQ/wDD87E7S2WuRjIZZuE
	 qRCbPE8tSOSNPhGUS5u8L24Qvqo9unulQ4QW5rZ9JYZfsHaxBfqdLn70xtHQJ69fJU
	 yde4xDhMlryLyinrcpV1LKn0QkJD7hgIA4X5Z885pkCM08Yy19PMzCuD6HdCGeSKIC
	 3LCpQQMFx8HXi52J5dZqLso57JVg+LcGj862W3Pi1yqLxE/2op921fkwLAF478XEa7
	 +7SapRICoKE8A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UocQ0oI1WdCC; Mon,  5 Feb 2024 13:13:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B24AD60F79;
	Mon,  5 Feb 2024 13:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B24AD60F79
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id EB7FC1BF3F0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 13:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C131860E32
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 13:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C131860E32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 65plRhASbrni for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Feb 2024 13:13:03 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 05 Feb 2024 13:13:02 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6D45605B3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6D45605B3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 13:13:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="407540"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="407540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2024 05:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933151690"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; d="scan'208";a="933151690"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2024 05:05:52 -0800
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id CA89227BB5;
 Mon,  5 Feb 2024 13:05:51 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  5 Feb 2024 14:03:55 +0100
Message-Id: <20240205130357.106665-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707138783; x=1738674783;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2rdPzuLvOoTXCtTQfHVwbzCqv+wEyRos/fJhSWXzhz4=;
 b=Mq7f5wzpdHil1nEbhQRlu6JvTn40tMhfpzcaZ4Oc+o/H+PY6eJh/2jVB
 WvzEhv5V6Mnp83XCxYXm1PPgri3AIsV1LDxDtBKaecEYgzBn19B7PiiLN
 z4YBHMv/z7pbSYhGXwCOqV0vPaeD1dMfEA24/t3GqE1HBXBiOeNCVEDaw
 x+UHw/0djxWmrHI0yAzLHPvI65VmpT2ZUO1RgWGk0rGC3UvC7sJpeefzd
 OexijcurgMsXjJdC/85qYidl3Xyw7/NGfzPgj3s+cLzQUJk1ybJ/8jhLb
 Y4f5DlCRHBSMplbsKM7nPaULqRNl9A5xtYErE1ZBOWj3gj/bDscHXFHyV
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Mq7f5wzp
Subject: [Intel-wired-lan] [PATCH iwl-next v5 0/2] ice devlink reload
 refactor
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
Cc: vadim.fedorenko@linux.dev, bcreeley@amd.com, netdev@vger.kernel.org,
 paul.m.stillwell.jr@intel.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Adjust ice driver to the recent devlink changes (commit 9b2348e2d6c9
("devlink: warn about existing entities during reload-reinit")).
According to the discussion[1], ice driver needs to remove and readd
netdev during devlink reload.

Patch 1: Refactor of ice init and deinit paths
Patch 2: Adjust debugfs to the previous changes

[1] https://lore.kernel.org/netdev/ZWdNm5pnmZsrO874@nanopsycho/

v5: Introduce the second patch.

Wojciech Drewek (2):
  ice: Remove and readd netdev during devlink reload
  ice: Fix debugfs with devlink reload

 drivers/net/ethernet/intel/ice/ice.h         |   3 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
 drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------
 5 files changed, 139 insertions(+), 133 deletions(-)

-- 
2.40.1

