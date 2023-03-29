Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6A8C6FD18
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Mar 2023 17:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A9BA60C24;
	Wed, 29 Mar 2023 17:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A9BA60C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680110621;
	bh=QV+9voJFNhpRXe+QoHmE68Q2axncIlJ0CAOCwV3ofMw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=7mg8VY7Jks4Wzt7N2R5XR8qUB2j3UQ2/pOCZ5IjXSwq7ToqMAuKdp4y6IfolakXzo
	 7wRl9MZfDT7T/jXDAEnrI9jOp7gaqx7Fxms7GoS1bjQnG0wXfVzoKYwMkwbXfxbVxi
	 SoSKv1PAg2aEISOVhIfkYD2tXIoCzF16qGdbcGx+afVwCMyJJq1P3fQ6rBuHSA1aRp
	 nQlgcvB36Mx8d4loYiYq0EPxmROsAkubft2kDt5ZlM7NO4dI1AiMwNtJumErXoNhjr
	 j/44eLhFQAD/u375/vfbY1QDiTWfKhSmq4ZH4nHj7CBipIWM5Pc2DFazUAuMRSABXT
	 TvrS04m4DBuMQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C17SZ2Gi1GwR; Wed, 29 Mar 2023 17:23:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2783E60DFD;
	Wed, 29 Mar 2023 17:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2783E60DFD
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4F57B1BF584
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Mar 2023 17:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 255BC41E18
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Mar 2023 17:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 255BC41E18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DE9u0utLY-sQ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Mar 2023 17:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03DCE4151A
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03DCE4151A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Mar 2023 17:23:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339670178"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; d="scan'208";a="339670178"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2023 10:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="748855516"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; d="scan'208";a="748855516"
Received: from unknown (HELO anguy11-linux.jf.intel.com) ([10.166.241.12])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2023 10:23:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 29 Mar 2023 10:22:54 -0700
Message-Id: <20230329172256.41933-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680110616; x=1711646616;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CK28CBYiWvjz+4XXdcXQC8+4/SGcYYC5ZOgBnUfTTes=;
 b=B8QfaB/Sqyx6R0ilIPYptNCGD+L6maBBqn5qvhJkyVNsFnYxXJp1Z0B4
 hj3rVxNaNeR0b9c3wyYuWDI/g+ZcJo3F8SyhjPXOx6lSHqH114O8pW+/F
 6GkE9uLOAqwTH6vmXc0m4qqVABC1ZioAbe/EZZMfiG1i+CbeRZKfYdmDB
 zHLrWdc1/PTCsxQUudZAhKKDPto+UQUPhxz4srMmhFzkUxM9/qa73/ckn
 JYlwQO/Cbycqm838oSTxPMmnL5Oeto/KkZSpgM6KMFZ0UMxZ6pzQzuYLg
 b1CpK2Tao3uFZdK6I83hnCDSLMr1DJC+OUwfntwepl+2dpOBx8yMj9x24
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=B8QfaB/S
Subject: [Intel-wired-lan] [PATCH net-next 0/2] Documentation/eth/intel:
 Remove out-of-tree
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Update Intel ethernet documentation to remove to out-of-tree
related information.

Tony Nguyen (2):
  Documentation/eth/intel: Update address for driver support
  Documentation/eth/intel: Remove references to SourceForge

 .../networking/device_drivers/ethernet/intel/e100.rst    | 4 +---
 .../networking/device_drivers/ethernet/intel/e1000.rst   | 9 ++-------
 .../networking/device_drivers/ethernet/intel/e1000e.rst  | 7 +------
 .../networking/device_drivers/ethernet/intel/fm10k.rst   | 7 +------
 .../networking/device_drivers/ethernet/intel/i40e.rst    | 7 +------
 .../networking/device_drivers/ethernet/intel/iavf.rst    | 7 +------
 .../networking/device_drivers/ethernet/intel/ice.rst     | 5 +----
 .../networking/device_drivers/ethernet/intel/igb.rst     | 7 +------
 .../networking/device_drivers/ethernet/intel/igbvf.rst   | 7 +------
 .../networking/device_drivers/ethernet/intel/ixgbe.rst   | 7 +------
 .../networking/device_drivers/ethernet/intel/ixgbevf.rst | 7 +------
 11 files changed, 12 insertions(+), 62 deletions(-)

-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
