Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7847D2E00A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Oct 2024 02:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A35F4056C;
	Wed, 23 Oct 2024 02:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4e_gHiW5cdxx; Wed, 23 Oct 2024 02:39:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68B1F4056F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729651196;
	bh=FQxL9J5jMZutr6EcO7eYENMPmD4xorAeJFA0Q1waCZw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qerGFxqjMHF62KK9FeMlo8bO8k/JW/z4ldUpF11n9IEsiwaKZl3hjurHj+OgTtto/
	 WBZ4X506E694ajIKbEk3ihIBZVW3iYpZcxyZGc2YQZ7AeW7QSxAxblGquJs6WG5/eh
	 5W5M3VeUHwv5uxL8QCJKlqyfMsnNHlJrZdwX1NK/OSJ7cOIwOUxzd6jwJpMR6Tfx31
	 wCLFrhVZM7Z0kQ6xuHRiW4XELKiaTfYFCb5ISIxQ8emv3iqsF+670T/AOfkfKvMEDo
	 +76+bvcHKcFX97FecxVXpoPBiHqyovo9wf732wgO4hZ1hs/0haRsRWKZak71s3rhxJ
	 NhDdpDcuKgCYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68B1F4056F;
	Wed, 23 Oct 2024 02:39:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F56A59B4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 02:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C5904063C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 02:39:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y74BSWSoLeG7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Oct 2024 02:39:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=christopher.s.hall@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2BB07405F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BB07405F1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BB07405F1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 02:39:53 +0000 (UTC)
X-CSE-ConnectionGUID: AyPtSo0KQbaeMQa8+elygQ==
X-CSE-MsgGUID: rIzrc+ZERmuXHDgZ4ZJHig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32918031"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="32918031"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 19:39:53 -0700
X-CSE-ConnectionGUID: prLyHlcnQyydZLLa4LTxmg==
X-CSE-MsgGUID: FKILdsurRcG/+Tf5QWAbVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="80396816"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
 by fmviesa010.fm.intel.com with ESMTP; 22 Oct 2024 19:39:52 -0700
From: Chris H <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com, vinicius.gomes@intel.com, netdev@vger.kernel.org,
 rodrigo.cadore@l-acoustics.com, vinschen@redhat.com
Date: Wed, 23 Oct 2024 02:30:36 +0000
Message-Id: <20241023023040.111429-1-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729651195; x=1761187195;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qCAPd+EKjSnUO6a+dnDXRPZ6SLhdHJyhlvsnFzp6X3Y=;
 b=RA0m/Qutj8yCtpDGO7O5G7vldI5+hhhFHPMTGBiE/kABM1Fr0Q80LK5k
 YEHCCeFD6aBigQrmFz6Jsb/+7huR1y4hd2k9zp05vB4FiLhgcxVpIxXNv
 EGoQecL70wyasu3VgcRPlifzPMV8H8Jao7CeLCX/03CY/jr5gPXOhPjbx
 PCUphjc7DREaVeZjsbXAqS6q+dxKxDUFu0tQBUYKP7TWyIstD1okCnkrJ
 NVWRwI26pWl05J7MCamRs39syJAGc0TRDHnLA9C2+6wGX7dRtTHQsTAHu
 RJ3syaNB63p22dCkdCT6f0IsaAwikmLoHR99mRcT9ZQmjATBeNF5UU6AJ
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RA0m/Qut
Subject: [Intel-wired-lan] [PATCH iwl-net v2 0/4] igc: Fix PTM timeout
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

There have been sporadic reports of PTM timeouts using i225/i226 devices

These timeouts have been root caused to:

1) Manipulating the PTM status register while PTM is enabled and triggered
2) The hardware retrying too quickly when an inappropriate response is
   received from the upstream device

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Changelog:

v1 -> v2: -Removed patch modifying PTM retry loop count
      	  -Moved PTM mutex initialization from igc_reset() to igc_ptp_init()
	   called once in igc_probe()


Christopher S M Hall (4):
  igc: Ensure the PTM cycle is reliably triggered
  igc: Lengthen the hardware retry time to prevent timeouts
  igc: Move ktime snapshot into PTM retry loop
  igc: Add lock preventing multiple simultaneous PTM transactions

 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 98 ++++++++++++--------
 3 files changed, 62 insertions(+), 40 deletions(-)

-- 
2.34.1

