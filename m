Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A17C48BF6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Feb 2024 00:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20393605D7;
	Tue, 27 Feb 2024 00:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OuBgQDoxOPkJ; Tue, 27 Feb 2024 00:15:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 831CC605E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708992904;
	bh=79FV3HI2R99syc+UrsQNNmc60NQ0krQEB/HhenqZOKQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=fTVRc2KqxOhdp91qU78wubdZnEOiVw6Y1oID4YD4M69chS7BiZS7eTVVSN5V9TxYt
	 q6V0WeiXCwA1zwmM3SULoiDFX9bzL8mGsTCVIIqptuT74V2rpV6Zs93BWZNknHdTeP
	 QKhkqSqKSdCAAPIOFI0a1+3YqGcWq97IicCgcxl/WY8TOe0ICe4OpQHPYcJX+ZoNpM
	 buQ+wrxaCPcv9Vf61z5ddd92CTr36fyyCUQrC6k8qZ6upDU7LQ7OyQJZkweyMypwN5
	 aMtlJbZ7t8lc8Bx/1sCFghwAsOSCWhMiD9SBE0Rc6iCPs9p56uQO1p6UNwzSxNM0Ns
	 ZLKmq+d5GDewA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 831CC605E3;
	Tue, 27 Feb 2024 00:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CA9521BF35D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Feb 2024 00:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF5FB40B32
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Feb 2024 00:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjASrjTprH0m for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Feb 2024 00:15:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 878E540497
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 878E540497
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 878E540497
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Feb 2024 00:15:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7128809"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7128809"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 16:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6816122"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 16:15:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Mon, 26 Feb 2024 16:14:53 -0800
Message-ID: <20240227001456.3858886-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708992902; x=1740528902;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bxDhr9OiTIBNvxEjk4FXrRTEuPr4y6L571AKTDBAbKk=;
 b=gV+d4Wk+8O7SPQ2++fCypSjc123Uow75hfdMBKLnSlQYojiOKltFGt+T
 jjusB2vKLWXrQhLSMCS69wnzDlpN0E5FTZvkZxUBvQXvx4HRVWSIXzsTU
 SaWlryOuie9XedxiARirFYgbImRL3ilbqNcF+8Do+4Q7C00IlDQT7yDVp
 rR0bsUFXUTd5s8/K+vuGV7NGYgmDbiLH38s9poAn9oktKzI15DyQtmYIh
 M3soN0zWwBacA8j8Nkx9AH4rduq5Y4bwkQb0QZlC0vAdrdRNnqnLa2Ysn
 eEpe/bzcT/gd3dOhmr8m1gCbajBn6LssVq4DWE1vY7jYjQsi9anOE0hL7
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gV+d4Wk+
Subject: [Intel-wired-lan] [PATCH iwl-next 0/3] ice: cleanup Tx/Rx context
 functions
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
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice driver has a handful of functions used for packing Tx and Rx context
data from the structured software layout to the bit-packed hardware layout.

The function names are uninformative, being named "ice_write_<size>". While
they are static to the file, it is still not a good idea to use such broad
names for specific functions.

In addition, the implementation of the functions use BIT() to generate
bitmasks, while the kernel provides a more robust GENMASK() for this
purpose.

This series cleans up these functions in preparation for the live migration
driver series that will extend the functions and add inverse operations for
unpacking the hardware data format into the software structure.

Jacob Keller (3):
  ice: rename ice_write_* functions to ice_pack_ctx_*
  ice: use GENMASK instead of BIT(n) - 1 in pack functions
  ice: cleanup line splitting for context set functions

 drivers/net/ethernet/intel/ice/ice_common.c | 112 +++++++-------------
 drivers/net/ethernet/intel/ice/ice_common.h |  10 +-
 2 files changed, 45 insertions(+), 77 deletions(-)


base-commit: c47bd2f22b2f457920138cacd3a53a403fa5cf92
-- 
2.41.0

