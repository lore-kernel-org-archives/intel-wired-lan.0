Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B89C433F5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Oct 2022 19:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EF4460E66;
	Mon, 10 Oct 2022 19:29:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EF4460E66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1665430169;
	bh=gkmMKBZbZYYo1FNipSgqDTx0w+evnOSpHHYTdOM0g0c=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=kMZQsUQvbfZzvNWBdFbbFvUeZaYlqDW+toCLVE/6j8G7uBaoK+Nz4nCakbAASTy1f
	 +E7opvUFGveGacKaHHjmKZxsrvHODc/5qYFbKL0Q05WivGbNycoMIyAjVRYXtpR1Ao
	 jDwz3jFgbhthnojuT8ygQVVErdAoejwsYATuSSuti+YY6Yg0uXlP1zfZcG4AunvuGQ
	 PhRsNKN963tbdA4VSwUIf/hTX17P5rvtgRoIeynvAM0SSgYBJS94Q9jDw7CGFC5H5S
	 mlo2bRZTpMPQLNdN8Wwnhus4q+gAhGXhN86IzF7jgcBVmYDc/f0Mu6z1a0oc4kBYtK
	 OgNQipMGULB/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dmNDKPuCzjM; Mon, 10 Oct 2022 19:29:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 498D860EFE;
	Mon, 10 Oct 2022 19:29:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 498D860EFE
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 668BC1BF28F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Oct 2022 19:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4148E81774
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Oct 2022 19:29:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4148E81774
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hShtzEkt8Dko for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Oct 2022 19:29:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDE588175B
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDE588175B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Oct 2022 19:29:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303057147"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="303057147"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2022 12:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="659265723"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="659265723"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.232.13])
 by orsmga001.jf.intel.com with ESMTP; 10 Oct 2022 12:29:23 -0700
From: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 10 Oct 2022 15:22:21 -0400
Message-Id: <20221010192223.916578-1-benjamin.mikailenko@intel.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665430164; x=1696966164;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8ukBsexHK8ukQ9iXIV6U7BEAoQgFUi67z8qV/JaztGI=;
 b=j5L4I+Vb9vc07oS66S8ehQycoaWYVbyI//Ili1ybBFa1zrpx1wfsv/j8
 RcvrZgmoMIe52Bfm0vY6UdnjA7r0lnj/ZWhxZJGAK9eAibUn/EqBuWdFH
 w2W8hsECs1dGSy9e+IuVjEa28ZF6+bLfBx2G+5THBDcfSefvhoArMHZV8
 GwplcEk382BXyZCJgh0wJuSPL31Do+tiXTYjaPMOCQx+WFDbhXt2AfxOM
 94z0iB5Hr/PfHp+cOeUjo8LaeLxfBu/92dOnGBWDoKMxCkVdu1sYsjkIu
 iQaDhQs4OA3/D9OIQvbK66CkVlOOuKlGNkfs9tywCW7TQaLL0Cb6wfTFi
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=j5L4I+Vb
Subject: [Intel-wired-lan] [net-next,
 v2 0/2] ice: Accumulate statistics over reset
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
Cc: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Resets happen with or without user interaction. For example, incidents
such as TX hang or a reconfiguration of parameters will result in a reset.
During reset, hardware and software statistics were set to zero. This
created an issue for the user where a reset happens in the background,
statistics set to zero, and the user checks statistics expecting them to
be populated.

Accumulate statistics over reset so the above doesn't happen.

Change is divided in two patches:
1. Accumulate HW and netdev statistics over reset
2. Accumulate ring statistics over reset

Benjamin Mikailenko (2):
  ice: Accumulate HW and Netdev statistics over reset
  ice: Accumulate ring statistics over reset

 drivers/net/ethernet/intel/ice/ice.h          |   7 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   3 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  12 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 263 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  78 ++++--
 drivers/net/ethernet/intel/ice/ice_repr.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  40 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  25 +-
 10 files changed, 396 insertions(+), 62 deletions(-)

-- 
2.34.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
