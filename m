Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C5BD3E773
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Nov 2024 21:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47F0F4067A;
	Tue,  5 Nov 2024 21:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8RFh9FPHEcj; Tue,  5 Nov 2024 21:49:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AE8A4067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730843359;
	bh=6SJO7mZZkEfTDpPD4DnpZqSA+5+l4Yeb/R+bd7qYnsw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=acMkjBa4+t9EfvrFmpS2Vp7um55w0sgCB9h0p4zF0ZsxQTRE7Kc1a9L2CxKZyA9xS
	 OqboO+/R0pbpOxaAAdiLrL0gc3b2NQrGNAdlfrc/AWGgxKtdu48+ZDv3zEn19PU/G0
	 C0mkOcjYXJl47Cd8M1TsDRpnIVapXyhb6BlYBFkmrh5ogOz4MX92f0boxcZOvzI1qa
	 oxC4hEKxHMcB9ZxRpFxgXr1op+E4QnCPql1gvf/v4u8nZn5nwEmhN/Jlhaaq4HXMxY
	 4SOrxOm208q/rtQqkycRS3ro3Gk1ANo97R15JKvI7nJDh2W+HL8JTe5RdMtWZ6WzdN
	 lNWH0keyvV8Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AE8A4067F;
	Tue,  5 Nov 2024 21:49:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E96611DE2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Nov 2024 21:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C91984067B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Nov 2024 21:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_PRF-IiCpB3 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Nov 2024 21:49:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=tarun.k.singh@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2E4F4067A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2E4F4067A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2E4F4067A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Nov 2024 21:49:15 +0000 (UTC)
X-CSE-ConnectionGUID: HMAzWUTbS2O+qmyzrGmunQ==
X-CSE-MsgGUID: 1VnCKYTeSQGBhYIkI9cBhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30735919"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="30735919"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 13:49:15 -0800
X-CSE-ConnectionGUID: aaefivJLS/OSLxacnZ/nXg==
X-CSE-MsgGUID: M2CB1TofTCeOdfc8/RSqLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="85010407"
Received: from coyotepass-34596-p1.jf.intel.com ([10.166.80.48])
 by orviesa008.jf.intel.com with ESMTP; 05 Nov 2024 13:49:02 -0800
From: Tarun K Singh <tarun.k.singh@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Tue,  5 Nov 2024 13:48:55 -0500
Message-ID: <20241105184859.741473-1-tarun.k.singh@intel.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730843357; x=1762379357;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6PdbRlg5M3fLbSsWfS7ryObuGd7lsNLIQHOn0mAGD3c=;
 b=G35C2T8pQjQEpNx+uSL9jzQJ25MW2sZyRYmxnZfcA00uCJSprfVTeEDC
 5PnwTNNIWoPYgS3X/ipuDS98SXI3x0qUtr788PDlKVfuaH+OOY4x55SHa
 HEIv20+n4HvYVaQrjIBuwkS3DErGkxUq/GihZtBItxL6PMfJpOZeDkbzx
 z9iCy6RWuRTHWWRky3KOhntXSUT0eiAvcqjJilqSxtRoYvWpNjn054/Gj
 Jngn5xiyQ1tKg1TDKRSBwcX4lRmmEZ41Z6MbEsdRer/qqwzABrw+8RMIE
 Fwm8CSqUzOect4GO0WfTyc7VvlIoQWZaRHH7ipmNkz9wUZdwaBgN2SCqV
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G35C2T8p
Subject: [Intel-wired-lan] [PATCH iwl-net v1 0/4] fix locking issue
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

This series fix deadlock issues in the driver. The first patch changes
argument of function 'idpf_vport_ctrl_lock' to adapter. The second patch
renames 'vport_ctrl_lock' to 'vport_cfg_lock'. The first 2 patches make the
third patch easier to review. The third patch fixes the locking issue,
and the fourth patch prevents lockdep from complaining.

Ahmed Zaki (1):
  idpf: add lock class key

Tarun K Singh (3):
  idpf: Change function argument
  idpf: rename vport_ctrl_lock
  idpf: Add init, reinit, and deinit control lock

 drivers/net/ethernet/intel/idpf/idpf.h        | 49 ++++++++----
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 59 +++++++-------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 80 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 39 ++++++---
 4 files changed, 149 insertions(+), 78 deletions(-)

-- 
2.46.0

