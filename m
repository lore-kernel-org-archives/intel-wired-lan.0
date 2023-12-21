Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB682C35274
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Dec 2023 10:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8321E60B42;
	Thu, 21 Dec 2023 10:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8321E60B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703153027;
	bh=5ZVWEnSweYS+Go//SlQEwqQucDR8WEfnzcx77tnJKFs=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=C7c5fn3q8u5Hh2m1lKRqkpnmafEICbLoJtSF8CYdtb9MOjR7xOyiozTaAEFU+oJwS
	 WqlFgqxeRxCS2cCo7wHir5whOkyFHaLMLpO2ssn/FOdyOcnZQkrkwHjMkavgsyqgfK
	 OsZOHlPGt4J7H+9HL+RU3OWY5BYZQS0okuKd9y9yu0Z+bovWEzFXa+VH6BNFvkFq4R
	 J9nmml2JDe+u4k/FphWzuGY+qp50IphlEdc86WHfY8RbKLyObNbQaCkxqT/ksZcI0s
	 NWygdvo8kw1nn3MM6PRUaYIreW3BwYbsfPSau04hQGF6eeLUnlII8MxfU8xN/CkeA+
	 mLwMo0urjstbg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6YMqCN-Y2-m; Thu, 21 Dec 2023 10:03:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EA0C615B1;
	Thu, 21 Dec 2023 10:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EA0C615B1
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 83E7D1BF3BF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 10:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AA96615B1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 10:03:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AA96615B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4jtylL41RSw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Dec 2023 10:03:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 552FA606F5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 10:03:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 552FA606F5
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482133661"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="482133661"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 02:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="949875380"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="949875380"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by orsmga005.jf.intel.com with ESMTP; 21 Dec 2023 02:03:40 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 21 Dec 2023 11:03:20 +0100
Message-Id: <20231221100326.1030761-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703153023; x=1734689023;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2pdqU/fhOSnNppi5YRr6U/bIHHK77ykrv+xLE5+YdNk=;
 b=C1Dkqgh3jaFRl5cEXAFrKyFGjI2i8T8bSUAueW5Wmtuc6XN0aj+aQtB3
 q+tKrGel0qQMnZhYL7IIsAH6ClNHXNfdQ05dLMhR1nZxiJ2pJiYvRiFjc
 HuKqsyAtRciPuOuAGhb6EBnbwJHrdkqcR6pgPinfXwyy6QRdjPnecUpf4
 +u0Mjb3CxJV7mhXBOOVBv71sfN+hesiD0oaNTKOUfmaqkxlnNgVzzIoSC
 8ERAgvR2dyDGtlSorx1vWoaONWph1hqf5TP40hLyL1DUkMqytJRPZTuFA
 rhi8K2NK+n1lN5epf9lUyOfV623ouzn83Hsmmzh6961YM5AwYR1Ru580J
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=C1Dkqgh3
Subject: [Intel-wired-lan] [PATCH v4 iwl-next 0/6] ice: fix timestamping in
 reset process
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.


Jacob Keller (5):
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

V2 -> V3: rebased the series fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 231 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 166 insertions(+), 106 deletions(-)


base-commit: 67b40ee196fd2fd6d9b7f9b58912587c837bdc39
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
