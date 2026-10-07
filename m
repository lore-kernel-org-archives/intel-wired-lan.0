Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3D7CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEE8360815;
	Wed,  7 Oct 2026 13:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bcCZzWONUlKU; Wed,  7 Oct 2026 13:17:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 82B6660803
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379023;
	b=hCqde/nOf+ST26gpsGvI6c3a/ofersau9ji3tJAPwvGjjn606bBXUyYzZak+TL4D4IIx
	 O3l0Ic8nsG6QkzoV49DnRuhnNrMzHR5DVjrZqekILfBgUph7IBz85qZt7QcVLSA29LpRd
	 o8p3TL9g96ILZR+oTFVkdiNI8wo4Frl5SAdSzgMPegMKARbi43l5coW6BtVykPC0ZakLw
	 5PEd2NS9DVyL3GLM2PV+v+4NOX6QdjNpnlVSXunX/920MzwFmETRxXVqj63H8I8nFvBsT
	 S2wWQ2PDLQk05xpQ608FL8ZMc0pI4jMgmodkp+aHYBaoxaaOCcHS+hPRqh6MfE6COsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j8Bvt6A659PFB5SIZRQpMhltXVU5K1BVOq+Lxzq93wk=;
	b=M6PagtcPhaZt3RwxGn6CPOLFhY3Cwhj9D81jBVoQTIPPRhusth4Wpm4qGEeiHo1+ml/t
	 dw7D/yhL5zD6/lzMMFS9Hlw/e35scHUT0r4Kr4YAEX3cc08xsk5KTMgAf5QKE2fYDqjbC
	 5lxlpkEW06Fl6k2RX5P04o9J886MSswzlRTwZFzBtzwwmh0PWQ4LnfLHD7zPxkqzYy6S3
	 dTHFfngOFo8xljQWlGUZRczgBMWtfsUr3xkWV2fKZPjT6v/40IbTWBDjoHkPLTj9xQB0C
	 eNOoHY6ZGmu8kgH+/YobvQ0xZ9YMUaTf4hDgS500exSJEMJwYw7a0fx/35Yi2rUaVHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379023;
	bh=j8Bvt6A659PFB5SIZRQpMhltXVU5K1BVOq+Lxzq93wk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rHABTfNdUwy0P1uYU6ydL6jiGMlevACqPhfzQU7jMW4evts4hmV6/u7X6SSbTgZKX
	 Nz/z1yr3Uc/BiOmm1qrXRUJxgI2N2pqWU65TjJJHKMw2EBeiGYGYjyDY03F7cflQ5Q
	 lwSPGuef3MMV1o/N6a6V2iEEfmG9IrDhsELay1y6j+mCe1EPYoM7ndjLKmr9OjymH6
	 l4blSzKwWA4GfaAiV0ty3HJNe0ZAd95Ehxll01XBrIAegMoGqESUOohVhS54YpEeSb
	 nEjGug+JK1b6oUe88FR2MFK4xUTa2ZhBKTjBam1ti4jjRiRsVmpZLrres5up32lJHl
	 vFUYjaVSlBRuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82B6660803;
	Wed,  7 Oct 2026 13:17:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BF6322B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E67EA80EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfpMb1Yl_quK for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 00FE080EE1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377302;
 b=q8RcnU0tzfGDZrzx6uVw50rl1K/EnLXH6pYIu3lnBPginKj8fD3YmkQ2Jwc58kWzfdh3
 L3oDiVhcrchnOqYyCPzRBxBFgdorw8sHidFnDDAAjWGvr5EWSP/vQty73hHh0JGGRMrf3
 5W92IBHYwALQ/9OIn9tzFpjJj1+cdqI1YEn9aTISL2u6ld7HUsPb6ONEoDYZJqJkk8cBT
 IuQjVHI4Xcp8WvVd8ptzI0o+2rzI4l4ZbMl4X/oL0GbdKTv4NT11SCz3W9loG9/VuoRp5
 YDyXwSQmwt3GEI2s+v872EF3raVLjnKDDalcyTI43JL/+i7LzEMw4excyJgoZEUeosw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377302;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=j8Bvt6A659PFB5SIZRQpMhltXVU5K1BVOq+Lxzq93wk=;
 b=qw3iEHMIVQHJ8m8D5kZaVT5AoMGR6idWfTreBsKb+tsQpJUyHPnW6lrvpyzJ/H8bNg5y
 AM92IjI93KvsdII/1YvvPAsd313AcBGWZnnShkcQ/X2+jXAnOu5/r1oqyXjzn6iA07N6h
 DNAC0yRKEINrqoLa2g2dnpQHD7nm4kkoI5NqmmeKKkkqj97VRNvXoxP6FY0ZWLTJ0DeWp
 GtNJT8g1OPM+anApXtN0pw/ZqJrXik5Rgz6Crtk5/FWh92pQK0blrsoL0NuvnKIZaCi2A
 zaxbeEEODNnO0jdQ8C6m70tuHr8X/0XKYpVCzEaGW3k13mmXZwDiG2ehBOa15wG4APg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kKOqs8ET; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kKOqs8ET
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00FE080EE1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377302; x=1822913302;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=na1Zj5btPW7hh2m7i2kxbaKXnHYTW4HpU2E24heWmZA=;
 b=kKOqs8ETxMPGk45lSAukeaEVPRR9ND004MTLno81q+LVDw0miPRpyuQa
 VdBOl2UDKYZguYfIcZyytfJuYukSlLUSourGYZ1xd5LHA+ygDApGIz2z4
 qAHSg59Pe/tYAOcKRprwRq7TOePT1QxXk/Gat9sd6fS89AlVQi4swPLG1
 yuWm/1DMDoa1kj0g4K4vWRAnZErUYtg3dIklHfTuOQ0M5bEwdz2+sPibR
 y6Z1n7yCiBlV9OP9utuy4Qgiyaxbv7nu6DJeB49FS3TEnD5BakjSrdE4e
 LrfUelAjv3bI5+5gInQ7WHsQ8rIaHcAevd+C/yoCpwCctMOrO1qp/Ge8e A==;
X-CSE-ConnectionGUID: p0rmV1blT8i9StimZhJFqw==
X-CSE-MsgGUID: L/jXfmAoToWV/AHnEiVRFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31573"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31573"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:21 -0700
X-CSE-ConnectionGUID: G0SZne5hT0WKSrQnWpkvfQ==
X-CSE-MsgGUID: EKhCy0kXR1iQ9Gnk6Cbnzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191688"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:20 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 0/7] Rework usage of the control PF pointer in
 struct ice_adapter
Date: Wed,  7 Oct 2026 12:48:12 +0000
Message-ID: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lore.kernel.org/intel-wired-lan/20260924125916.2796499-1-sergey.temerkhanov@intel.com/

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes
v3->v4: Add the rw_semaphore to protect the ctrl_pf
v4->v5: Split patches into smaller self-contained parts, tighten potential race
        condition windows, annotate RCU-related code
v5->v6: Rebase on top of the latest dev-queue, remove absorbed changes


Sergey Temerkhanov (7):
  ice: Protect the control PF pointer with RCU and a rwsem
  ice: Cache struct ice_hw pointer for split register reads
  ice: Reject PTP access without a control PF
  ice: Clear the control PF pointer when the control PF is removed
  ice: Document control PF lock ordering
  ice: Annotate PTP control PF lock handoff
  ice: Release control PF lock before RCU wait

 drivers/net/ethernet/intel/ice/ice.h          |  42 +++-
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 189 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  78 +++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    |  20 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |   5 +-
 10 files changed, 293 insertions(+), 82 deletions(-)

-- 
2.53.0

