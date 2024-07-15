Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23EAC3DA4B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jul 2024 15:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A375E40334;
	Mon, 15 Jul 2024 15:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5M8Rrkj28Pvf; Mon, 15 Jul 2024 15:40:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C474B40448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721058041;
	bh=y90SQJ3f/4Vf90bl/GvfKstLe3DFMTZWqphMQakpOXw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=j27AxZq3gnfKMmjqhP9Rz9NdN04I/adV2xmnNPfUdyNdUP6tHZ/bseTRyGyN7noVL
	 UKns8cIAwXVgYrCADS0GnIbEOvPMkMzbAPvf8W/ki6W/Rhsa5g7TAvrRBppgRHI6i5
	 1VmSi1E58b+J/AQjOqutAdsSlORC1UQAO6KQIhe1cd2783DXTK+VXCCw2asSRqw/I+
	 pxWU+ypiUUYMTT1gdRJnSpFH5n0pcPycO1nmcF9E1beVI75j46BMLXsbYg6H9+nmm2
	 fnkc43U+hRhC5x2UzuDAtRNmbNJXImimC/KION8eqwDBqmbMbAKxoDESkRksBCrQ6C
	 ygE1M526smEMg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C474B40448;
	Mon, 15 Jul 2024 15:40:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 889C31BF3C0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jul 2024 15:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FFDA403A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jul 2024 15:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6H_rWn-j8WDO for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Jul 2024 15:40:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C838740334
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C838740334
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C838740334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jul 2024 15:40:39 +0000 (UTC)
X-CSE-ConnectionGUID: gspABBxXTgKwhFwgxP3tCA==
X-CSE-MsgGUID: cKjiQU/MQxmZXfeHmjWIxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35987669"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="35987669"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 08:40:38 -0700
X-CSE-ConnectionGUID: sVLwtx/1QgWd8g64ansT+A==
X-CSE-MsgGUID: 4nPAqMTeTbeN3XkwEaLAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="49408479"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
 by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2024 08:40:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 15 Jul 2024 17:39:09 +0200
Message-ID: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721058040; x=1752594040;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jo84ICaHy10UrO1fRMUDuSkAbckqXDDruDCEpkIxL3o=;
 b=E5WG4nkoAPMgK24X0OYimD/E4oRRKgqZBRflUFt6hu1Mw0Fo3Faf+I3A
 K6zSWGwLxPLnGOd8JyokPXNEKcRoyJq3gdiBvpXNzAFavjru9/ZrV4lB9
 NDxuojFwbwW7voq68ord1BeekI1C6hZxBCJyaTjZqXsGRBE8DYy+lHVc+
 +uSR3K+nitnhfQtjBrIXqJ51uKe47t+q5rQIZ5Zf36OrRyNhhKcriilei
 uQvlLshb7kemHKwifFFYSyNId2Qr/bCVub3SAW4dNoGd9Q5flZ3A1oWUv
 40LPgyLXf6Ec88abADTT3oaDF/29vTPhEWxHSlH83UUTuXa5T0+iiOiRK
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E5WG4nko
Subject: [Intel-wired-lan] [PATCH iwl-net v2 0/2] ice: Reset procedure fixes
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
Cc: Sergey Temerkhanov <sergey.temerkhanov@intel.com>, netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fixes preventing possible races between resets (CORER etc)
and OICR ISR invocation / PTP hardware access

v1->v2: Patch rebase

Grzegorz Nitka (2):
  ice: Fix reset handler
  ice: Skip PTP HW writes during PTP reset procedure

 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.43.0

