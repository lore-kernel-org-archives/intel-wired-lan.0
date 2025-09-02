Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2B2CA1005
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Sep 2025 09:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4982481280;
	Tue,  2 Sep 2025 09:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5A-t_YoeV2gt; Tue,  2 Sep 2025 09:01:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A950F8451D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756803686;
	bh=xOqbVcEoX8z55OZXUBvPVT9o0iUHl1YSCy+0siyH5mQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eQKHXgjJlFGnRL3y7CmZ1V8gmBB7BUCTkHSziVYC+Jp/2GfvpW5n6jYHuIlNN1F/V
	 JBNpyTf0QVtXvXuN3YMBGjdBMZ/3e3748RD/fxQixdErOYhp+tciu7qXk5wI3kf+wF
	 CRKxxVKgrUKgZJanv+b9V03Y62LGdsxEkvqvO1r7Cwn1oq7UMNiOhPwMtE6INS1jAd
	 TyyLCnW+jlPQTbW/rgRq13EZBu1Z6w0BztsrWiM9p/65YOnp+ClrynABvaNstBNEC6
	 Dg3f4NurT9nY4gJziPltoGUADUXTT3fOfvywE+lJbrvQ0gS26qhP7vyt7jwmw72TLF
	 T5L74nZKG+bUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A950F8451D;
	Tue,  2 Sep 2025 09:01:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EDA8B10E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Sep 2025 09:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3CE140B48
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Sep 2025 09:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BeMPH8PltZTd for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Sep 2025 09:01:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=anton.nadezhdin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0F1A840920
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F1A840920
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F1A840920
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Sep 2025 09:01:23 +0000 (UTC)
X-CSE-ConnectionGUID: kWg1UlB7Qaaa4KyK7+nJpw==
X-CSE-MsgGUID: 30svK3sMS1a4/2vcINfaVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76666691"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="76666691"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 02:01:20 -0700
X-CSE-ConnectionGUID: NMHMv1t8Tquknduml+jNZA==
X-CSE-MsgGUID: LEAmQg/iTN2U6OzvcLu+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="176494110"
Received: from host59.igk.intel.com ([10.123.220.59])
 by fmviesa004.fm.intel.com with ESMTP; 02 Sep 2025 02:01:18 -0700
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 richardcochran@gmail.com, Anton Nadezhdin <anton.nadezhdin@intel.com>
Date: Tue,  2 Sep 2025 06:50:22 -0400
Message-ID: <20250902105321.5750-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756803684; x=1788339684;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2TpnP1AXNCPV0dg1xc5N/Ez8GtG6w45MaCkHZBvSIg4=;
 b=dypgPSQjdFyw+Q9MI3qPy3umJuJ6e+mZhL1Dbmn01MIa/P225/qkg47Q
 i7KyhCSaJWqopc/UNgBTmwkfagbLk90oCIc+FuNJvrnT1xmJ4cjj9YSk1
 Nc2p0A79QcLuh6oLB3xaWpfL1SVtgYVQ1Hycv3Bk+3YO2mRoroMe3/XfU
 zs6QdDVLlhDJoi4O6UBHZ/xhe9Ckl7dnwy9hd09+mo6hGuTObPPFeiV/h
 l3qGqpX8o0ZiVwFbN4JOjtcPpWC4oA/z0amK3PzjonUfEqCLxNH1PHH8b
 ehIPpNn7Ucx2fhh/X/8GMN6m24uB0N0CofGg+6j4JhZcHChC4vW8uQWHT
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dypgPSQj
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] idpf: add direct access for
 PHC control
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

IDPF allows to access the clock through virtchnl messages, or directly,
through PCI BAR registers. Registers offsets are negotiated with the
Control Plane during driver initialization process.
This series add support for direct operations to modify the clock as 
well as to read TX timestamp

Milena Olech (2):
  idpf: add direct access to discipline the main timer
  idpf: add direct method for disciplining Tx timestamping

 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 295 +++++++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 103 ++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  85 +++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   4 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   3 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 139 ++++-----
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |   6 +-
 8 files changed, 451 insertions(+), 188 deletions(-)


base-commit: 1235d14de922bc4367c24553bc6b278d56dc3433
-- 
2.42.0

