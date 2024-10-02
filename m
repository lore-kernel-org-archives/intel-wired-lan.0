Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23B7CF31B8
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Oct 2024 11:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5831D81F1F;
	Wed,  2 Oct 2024 11:53:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqV1EgBJFBoj; Wed,  2 Oct 2024 11:53:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA26381F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1727870001;
	bh=xCbBzyOojb+ajYCuFxxpK6KTKmYnDSTJfsothYH5B9s=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=WyxP7JJbEdrZA5r1D+yjCRymj5b7dgMnFuqCN1xi/4jMDhkQRGkLvgPzTDuSfhUfs
	 MsC4vzVrbBbkhM3ojic+5tUWBrU6ee/jPINcRCzhUaBiY3WEh24k9VXZ8DqKT0yrZ+
	 uP+rYVs3e+a4P4ylyr5miE2tsVkvRbxSUfvx5yZIY/LIRl8DQRVIFb081BsEMm21nq
	 YVSovcRUxAV1Ll+1PEDytlQp3SSoxx9L8HJIVICFdcM9142UMmRFbhqcWowB0H+Zah
	 Sly0BmgcUOBatwI5HnwMYc0iVC/MWrYxs3wgAepPon5yAF6rq/aDusaGw/1YA0NE1z
	 QXkq7ZF6i4RmQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA26381F15;
	Wed,  2 Oct 2024 11:53:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6B3FD1BF293
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Oct 2024 11:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5982181F15
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Oct 2024 11:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gnu8k2q1bojv for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Oct 2024 11:53:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5EDCA8128A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EDCA8128A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EDCA8128A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Oct 2024 11:53:18 +0000 (UTC)
X-CSE-ConnectionGUID: 8vMdBRNlTS29iFEC1gkQgg==
X-CSE-MsgGUID: vj+BY37ZTyih4u+BrPY7mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27183843"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; d="scan'208";a="27183843"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2024 04:53:18 -0700
X-CSE-ConnectionGUID: j4tzPV4sQ8auhekKuqpEpA==
X-CSE-MsgGUID: t9FGusYQQvOl22mERRm8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; d="scan'208";a="78396372"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 04:53:16 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.21])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 2944927BD5;
 Wed,  2 Oct 2024 12:53:14 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  2 Oct 2024 13:50:20 +0200
Message-ID: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727869999; x=1759405999;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kcPe5wu23W0KcN/YzSanoOP4+gck7fThbzZePZEyrsQ=;
 b=lWVtu1HexfgRHbjT5RWK1GcY5apCVnIDvDXAgjgiWeWZrGIxJ/O2A4xE
 erTud8D1uqK/ZKTo44Swe1XM9WyCASYDUZzmp5baYjVt/cpKoxqb+om20
 SKQmKVx3tQcwbaTAqGQiowLP9tCDaLODdW5SnJ0TReMMIrFAWT5YLL3SU
 B3Szge86KHTFQATmZadZqgOjXXsyUDx/8fvk8DoDWvjdb8vj8dHcXR0fE
 TP5YyrxZvkMLarb7+8bN7lvVDdy8l/NDNbyHqd9tifKTfBc2AuBzFq1+K
 DosawLsc87w89xFiAJd6rzABYSl4zhzDTePshR8MEhzwWkvCOACUqOgte
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lWVtu1He
Subject: [Intel-wired-lan] [PATCH iwl-next 0/4] ice: init HW before
 ice_adapter
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
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series moves ice_init_hw() call to be prior to ice_adapter init.
To do so we need:
 (patch 1) move waiting for FW into ice_init_hw();
 (patch 2) split ice_init_hw() out of ice_init_dev(), so it could be
           manually called in ice_init(). The change mandates similar
           split in ice_devlink_reinit_up(). To keep things consistent
           ice_deinit_hw() is also extracted to be called manually.

(Patch 4) finally changes the order in ice_probe() to move ice_adapter
          init past the ice_init_hw() call.
Patch 3 does minor cleanup after patch 2, to keep diffs more readable.

The whole motivation is to have ability to act on the number of PFs
in ice_adapter initialization. This series is not doing that (but I've
print-tested that such number is correct there).
Code is also a bit cleaner, so overall it's good to go in an incremental
fashion IMO.

Przemek Kitszel (4):
  ice: c827: move wait for FW to ice_init_hw()
  ice: split ice_init_hw() out from ice_init_dev()
  ice: minor: rename goto labels from err to unroll
  ice: ice_probe: init ice_adapter after HW init

 drivers/net/ethernet/intel/ice/ice_common.h   |   1 -
 .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 110 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |  88 +++++---------
 4 files changed, 110 insertions(+), 99 deletions(-)


base-commit: c94f1e05dfa83f1a8875111756c52955d721e60f
-- 
2.46.0

