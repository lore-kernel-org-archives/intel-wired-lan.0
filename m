Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09124C5B572
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Aug 2026 01:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F3346065E;
	Sat, 15 Aug 2026 01:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QztcegihkQeo; Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 162AF605FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786757174;
	bh=w5cN4SVFW/0eS5UWS6giC5YzXWx78jzgbam76dIjCYQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CHt1RRjUM6R2eLQCasvzAJTE6LVfFbIZvft8tVjJO+AlInx3zn8QwN7UIUxJExxiI
	 +9OKQsj0qoty78mYspiuDh6qrlSbW7L0r886Q9Zw8JPzdaHZtlN4FSv3bVfIvUaz61
	 4yVJiSOh9zDSb64zuGl7cQjPiIQsi+Ys+U8ThiqNd7Ru5EZYQnoRbp8GmoPKuIy8jZ
	 NbQZ/33ZabUge+9bTLoJyGlqn807l1bdNObS5wYJ1GeiZG/o+xUq0GcdoIJYyedu/1
	 3LN21/WKvKZezW6gi0C2bjJAsUm/Pp34gQ2LOhCQxbHckHi4WBUo/nI7UsJIgIVdhw
	 C8A9UEI8gTeFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 162AF605FC;
	Sat, 15 Aug 2026 01:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0043333B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDD7D40BD2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZlsOVR-WULz for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:26:12 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E71EE40BC0
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E71EE40BC0
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ol26tb1G
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E71EE40BC0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786757172; x=1818293172;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dcsgQrkver+q/4LGCAlK3SVRW0F7/9cy9Twe0HOK0Jk=;
 b=Ol26tb1Gt34S+0AAZxBE7sTgcfqLOjldWsHcxVhA7RpqX9bObgAurvFk
 XV7q2t44PFzRxUoAIdD68xgh4bFGGXy3kQYPEr9ncVCdwKutatqR+UP4u
 zyiTCwn/hj0hi8i+YnE64v2kdBNt2sEwl1KGEHHuPSM1UuXPLhU0EfKVg
 uNLLkLAhgwkfAg8R5FMKN3GVz57R4iOExhNSHPuLAlzvJfymbP0PjBLU+
 1OpcTW/C3gC9+eDgFTB8PB/+CFYUSancsfq1bTTEeWJDf+AfNSzWhSZ1G
 /OtVRp09ON+4KPGvXK56SpGVERSwF+AYQ1re5op28rohf7nfbN1jCqiPf A==;
X-CSE-ConnectionGUID: IZCVoFsWSIqZ4NCq1ewarw==
X-CSE-MsgGUID: r1kCZ4MdRjSVvR2IfW0YRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194376"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="87194376"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 18:26:11 -0700
X-CSE-ConnectionGUID: j+d/s5SIR3qjRJW8f6QWtQ==
X-CSE-MsgGUID: XvHn7fRvRouF8IgOWc5+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="287844719"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:11 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Date: Fri, 14 Aug 2026 13:49:16 -0400
Message-ID: <20260814174919.4177289-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH iwl-next 0/3] idpf: add devlink info
 support with selftest
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

Add initial devlink info support for idpf and a matching selftest.

Patch 1 fixes probe unwind by clearing drvdata on the error path.

Patch 2 introduces an idpf devlink instance and reports:
  - serial_number: device serial number for NIPA CI identification
  - fw.mgmt.api (running): driver-device communication protocol version

This follows a phased approach and reports stable, readily-available
information. Firmware version support will be added in future patches as it
becomes available through virtchnl.

Patch 3 adds a hardware selftest that validates basic devlink info
reporting and matches test patterns used by NIPA CI.

Paul Greenwalt (3):
  idpf: clear drvdata on probe error path
  idpf: add devlink info support
  selftests: net: hw: add devlink info test

 Documentation/networking/devlink/idpf.rst     |  29 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 .../net/ethernet/intel/idpf/idpf_devlink.c    |  79 ++++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    |  45 +++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  13 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 119 ++++++++++++++++++
 8 files changed, 285 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

-- 
2.52.0

