Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98A2C021B3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Feb 2025 12:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71AA940C58;
	Fri, 21 Feb 2025 12:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5ZAxu4FDUYl; Fri, 21 Feb 2025 12:35:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A764409F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740141305;
	bh=ii0vyfsKRzaOSQd169b/fWid29XWFCzbuasLyq+2WKE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=dgU5btij6s1uurPVFciH0yQz0iNo8RJBwjq6ArEr0SwyRkPPMS+/9mCnc6VMit1jR
	 L3d6HSQHFd+5VW/NZB3XKJRRVV3F+1mmXyfVHvSTiPQRUAO+xlzSnI1mcCSFrg1iGI
	 JB4JUN27e621+ZXipk3GmTjt3spvoft27vgFjCZWz+L2GMjZVBPEaya2TMX+jSyXS3
	 ZMQX4kKrOsEc55d+owhZo39rhteEQLzD3RFLpW2qwaru3O9t+/KC9dyksbaSDGFzu3
	 ovNoEvrc335fqyyiCEvcU181JB3Mo+JsLFofbY4X+y5f7TumqSDZ5nuiR5Wylx7PTj
	 7ajH0aRhQ9pUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A764409F6;
	Fri, 21 Feb 2025 12:35:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4709D194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 12:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 367F760ABC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 12:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMSL8jMghgfH for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Feb 2025 12:35:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 65A7460A70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65A7460A70
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65A7460A70
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 12:35:02 +0000 (UTC)
X-CSE-ConnectionGUID: cgHa+5o5Ro2OU8pVoMKbGw==
X-CSE-MsgGUID: 6sivZSUfSKuvK26+ZKvy3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66321386"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="66321386"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 04:35:01 -0800
X-CSE-ConnectionGUID: jqfNv3xsQJeaJpeZMGLFAw==
X-CSE-MsgGUID: 0gmIV+uIRGeDaDns+h3u5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115862544"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
 by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 04:35:01 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 21 Feb 2025 13:31:20 +0100
Message-Id: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740141302; x=1771677302;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R/+7sPe6uNOKfySZ6Knz9K0A5nD2QRvniqLznl4Lung=;
 b=dwNQPBxSxCGH8DqMr/osneSFD5ZIgFf/GqKz6JMM0P8AWK01AMztA7tB
 fGJrFxz24mzBayCaH/aAdDrrmBiGgOMqGiL8LGFTDx4n+E1RvEz9S+UYz
 l9E0OEN+qKjwmaegnG0MyBoQjNkwirjfo1Pg2MLZNIqQGQ/2HJG+XSo7E
 VTgzigZXBTB+e2/ASVxIFdYSW5w7FNT5uYIubGgqcTnayklFie2qZJQxC
 YUt02Wvs0OW7a4jUwJReG9P6AKZG/vU2R2iFJezRYH1IDkKhgXprcC4QM
 LP43aH0Cwmy9xc1iZKK/xcBmFgrCG641ttcIS2LZkGwYQh9MRuZuqdtuI
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dwNQPBxS
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/3] E825C timesync dual NAC
 support
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
Cc: netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patch series adds full support for timesync operations for E8225C
devices which are configured in so called 2xNAC mode (Network
Acceleration Complex). 2xNAC mode is the mode in which IO die
is housing two complexes and each of them has its own PHY connected
to it. The complex which controls time transmitter is referred as
primary complex.

The series solves known configuration issues in dual config mode:
- side-band queue (SBQ) addressing when configuring the ports on the PHY
  on secondary NAC
- access to timesync config from the second NAC as only one PF in
  primary NAC controls time transmitter clock
Karol Kolacinski (3):
  ice: remove SW side band access workaround for E825
  ice: refactor ice_sbq_msg_dev enum
  ice: enable timesync operation on 2xNAC E825 devices

 drivers/net/ethernet/intel/ice/ice.h         | 60 +++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.c  |  8 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 49 +++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 82 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |  5 --
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 +--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 7 files changed, 149 insertions(+), 67 deletions(-)


base-commit: 692375ca2a4e6916ddc2ef0d73faa37c7a93cd1a
-- 
2.39.3

