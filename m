Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73565C433EF
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jun 2022 00:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFA03607F9;
	Sat, 25 Jun 2022 00:33:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFA03607F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656117215;
	bh=ZgN32ka9s8+BOruTgLhVCEfbwu7vD8sIZzrVKtN1edw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=VzdsmOStkrWPLb5zc1t5j66q2eA7HKLkTK28kGSZgZvQGGeBmJS9mxxjC0h5IXvs9
	 KdmJ0bACwaqW4TX+AZSm+uhBX490auK3qFJnnAnWWNuI0tf8agizhAZidBtjt99DdG
	 DHwUNdBAaNsIPPODAX2kLg478MfIqaFW+jrvwtAFDgzIzX+liYC9c32M/BaX7zOE8w
	 Q14SahTYD1U0cdOi+vQG4TF8urWa3a98G2nfc5+eA/vm4ZoegzHpEaYDDCA943n4mr
	 YxR8eb3W8DSe026Y81ltqxP1UpO96j3+6ex9kf/EzDCuAlW0iXs1E5QuepzrM0bmlQ
	 /+Yl1KgInpjKQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W1DPeEc-iIWX; Sat, 25 Jun 2022 00:33:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAEA560B52;
	Sat, 25 Jun 2022 00:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAEA560B52
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1A8311BF423
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 00:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01A0D4154F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 00:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01A0D4154F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qzq_ZbOQwMPo for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jun 2022 00:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BED97410B4
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BED97410B4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 00:33:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="306593182"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; d="scan'208";a="306593182"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 17:33:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; d="scan'208";a="915886363"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 17:33:17 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 24 Jun 2022 17:33:00 -0700
Message-Id: <20220625003302.3501801-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656117209; x=1687653209;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YXebuJn4OamCSV3wVjWSCBDAGGdj0N8SjPDJ18ojJWo=;
 b=PvuYEPMqKATfXuVf7FNjIJa2lglTpt9GDBZJ72oedkCZ0OzQyJGcw9v/
 r1Iz1+AYHj5ssgHQPAHndLoQeYeHofozxkfhiYeFn7cvmXCEmla4hynC7
 wgQMha18q4L1drxIz5PF/LxofBlTC94CXw7jrGXZwqE7U/JwIWzA3vsZg
 gyR2BIezPwS0ZqViz/daTW5OuDldU3v4W1q85Lb+i1Osog+2uvMGZ8+xg
 fWBmtNV6s3lD1BC18LMBtIXnow2Ef0KeD2znU5X9RjKZI5/oKJU7qoVhP
 U7XJWtcE7wKUUSBIz1ezOYGal5kKF4sNjsjNbyWksLb70u4oq1wNOBvXF
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PvuYEPMq
Subject: [Intel-wired-lan] [PATCH net v1 0/2] fix bug and remove code
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
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fix a bug with dummy descriptor handling, and remove some
unused code.

Jesse Brandeburg (1):
  intel: remove unused macros

Przemyslaw Patynowski (1):
  iavf: Fix handling of dummy receive descriptors

 drivers/net/ethernet/intel/e100.c                | 1 -
 drivers/net/ethernet/intel/e1000/e1000_param.c   | 2 --
 drivers/net/ethernet/intel/e1000e/param.c        | 2 --
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 2 --
 drivers/net/ethernet/intel/i40e/i40e_ptp.c       | 1 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 1 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c      | 5 ++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c  | 4 ----
 drivers/net/ethernet/intel/igc/igc_ptp.c         | 1 -
 drivers/net/ethernet/intel/ixgb/ixgb_main.c      | 1 -
 drivers/net/ethernet/intel/ixgb/ixgb_param.c     | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c  | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     | 1 -
 drivers/net/ethernet/intel/ixgbevf/ethtool.c     | 4 ----
 15 files changed, 2 insertions(+), 29 deletions(-)

-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
