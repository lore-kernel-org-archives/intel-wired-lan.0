Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90720C4167B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Dec 2023 11:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CBCD82400;
	Tue,  5 Dec 2023 11:37:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CBCD82400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701776271;
	bh=OI4Nk+0sbPzo23wRZ8mMirRzKx4ntQjmxRpCs4o0OvY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6IPn78hzd6qy1RL6I1PXgf5rn9l6IYKsiex095fbdFkafwuxqEVawELRQ+oLpm6x6
	 6y2xVP+Fjeqa7ot6niXPmGHB+M8DQsH8Hb+7KxBC//3tUHZZDqzgnCDObi0JO0OZcZ
	 HGqavQDm4HGhu9QXgr2cMRZS0e5M9tRuLKzGe20bnS+kP48tpAqL6GnuKji5NHGRuD
	 1DKN0iYc9rUtA8a1yNfsLIXtRNmjiW25sM4aBKEkbiejOXbz5A3n+73o0n7o+Bv4wS
	 dcSASE/m5BeODeeKaA6e0SsQ+9E+zfjgiM0mzJNKcph2wAYyeFVrKX2M0b6yPhjbUF
	 yZVLUAFidRjcw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwLz6bM1Ucxa; Tue,  5 Dec 2023 11:37:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37E4282404;
	Tue,  5 Dec 2023 11:37:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37E4282404
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C89611BF2B0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 11:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9607961087
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 11:37:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9607961087
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjchwExggOBU for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Dec 2023 11:37:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B55DB61082
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Dec 2023 11:37:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B55DB61082
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15429376"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; d="scan'208";a="15429376"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 03:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="747196964"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; d="scan'208";a="747196964"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by orsmga006.jf.intel.com with ESMTP; 05 Dec 2023 03:37:44 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  5 Dec 2023 12:28:38 +0100
Message-Id: <20231205112840.149813-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701776268; x=1733312268;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AIUHmhEmwcOCgMt2++sCNVhBbRepohu8MlTc7aJci5o=;
 b=UvTt3c0F2U9p0dQtqycq29edEFhGbJcvrp01kysYv0XBlvWUtI5msmC0
 m6RgDOCEvvQt5rkUMezrPfvBwSTMzghcS0Jrx+KBLxM452kyu0ek/IGt1
 ozPnkvGSc1lyk9kk9p7dI12PG+rM51le3EP7/VlXvIl8hwdoKg++SDPXc
 ptxEht2P2yVobs906T6cGsbiKZtYRO5uXPV/MvrYe+Guy+ex2wPIi0q3U
 AuPXWJNLoC4UzNRIfcJgD7u7xyV/6wdJQG14pqMXd+2miAKU8x7/jBRu/
 I2QaP1v74UWkWWYWtA7NDwm8xDcZqmO74IJYlECvBi/pfdLmVQ0FW+Xi6
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UvTt3c0F
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/2] ixgbe: Refactor ixgbe
 internal status
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
Cc: anthony.l.nguyen@intel.com, Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

A small 2 patches series removing currently used internal status codes in
ixgbe driver and converting them to the regular ones.

1st patch deals specifically with overtemp error code, the 2nd one
refactors the rest of the error codes.

Jedrzej Jagielski (2):
  ixgbe: Refactor overtemp event handling
  ixgbe: Refactor returning internal error codes

 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  36 ++--
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  61 ++++---
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 145 ++++++++--------
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  46 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |  34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 117 +++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  43 +----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  44 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 156 ++++++++++--------
 13 files changed, 333 insertions(+), 356 deletions(-)

-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
