Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AD2CDE001
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jun 2026 15:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BB0661030;
	Thu, 25 Jun 2026 15:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6n5N5Mi3OWR; Thu, 25 Jun 2026 15:14:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA0EB61029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782400484;
	bh=kOZWZLTwJKIdHT7jLyzTjV7Z/94vZkCMFP3r800w+mY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KnY8IRdge3BXRYsHJCdBePo7X269TCp5teQk3g/0e5krrfOXw2ntamWcS2frfQH4H
	 eS9JKtTWz5zNkigW3oHBLsuT33yyYoDUvXwdkf68vX31U7zNN8QuC+4Gx3rp98k5tF
	 NSvnYCn2UsDqx90SnbPdFLn+TcyisvE9tjTG7AA/ZUimm7Y/y+SypcSTR2+I6Yw6RO
	 uzZD5DSUAbfIOahqIpeux+/HdS3hxBC4psONstZgfAFvlCsfaq3OH/eVD4zPfJyPk5
	 2ZKvYm5tuo+qsBEOJHzDpnTPKbRpyZSEQgedEuOsycV9ISz2D7gPlkrQRTjbCKz61W
	 vtzpiI0Kj7hJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA0EB61029;
	Thu, 25 Jun 2026 15:14:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C9A0254
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jun 2026 15:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4228241110
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jun 2026 15:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0H2OSgUAGNm for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jun 2026 15:14:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 86E7E4110D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86E7E4110D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86E7E4110D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jun 2026 15:14:43 +0000 (UTC)
X-CSE-ConnectionGUID: aRsiFtdYQcmzlMeCccHM6w==
X-CSE-MsgGUID: obTjW/kNRP6dL51jqqV13A==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83304520"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83304520"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:14:42 -0700
X-CSE-ConnectionGUID: 3Js0l7x8Tk2OZU5axmxEfg==
X-CSE-MsgGUID: zVX3tQDURWapNRg7P3Cvdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="254866926"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa004.jf.intel.com with ESMTP; 25 Jun 2026 08:14:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 25 Jun 2026 17:14:28 +0200
Message-Id: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782400483; x=1813936483;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qcsBNcZnHyQgCK+3BSI8JZB02DcVgc0h2SEbrwsRgh4=;
 b=YHbHDMfSemQoPiLUPK8g6WIZgXJpAYLKWPnog/gowAts93+DBxi3FnQq
 UuynlEtBw90BdCO9iDCuQADYv3akVRCg9OMGe5noqBWnSty1M7DXN86/M
 eUWrqLHM6kEoUk2im/coDTWZIF4VZCCBKC+ZkE5k7/z3oIZLOczQ+XvMw
 b5UOiwzPlaoWGnB/lvcO4pBCzwU5bYjPF0TunfuIjz1IUWdWkFzXlk40B
 XPvi7V91iWBJUSBjXtM/qiCPxUqVqq06B45R9JW76X3nflN4jxsi8FEt9
 MD2trUpz4DwsOgTvNJ4qcudSx7KJLWklvoHB5Q+wT8YT/PoyHIlstpwrv
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YHbHDMfS
Subject: [Intel-wired-lan] [PATCH v4 net 0/3] i40e: re-init and UAF fixes
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

v4:
- add preceding patch that fixes a case when some of re-init allocations
  failed and we missed de-registering netdev at failure path
- pull out i40e_vsi_setup() changes onto separate patch
v3:
- address UAF when ring arrays were freed before q_vector's ring
  containers (Sashiko, Jacob)
- remove bool params from alloc/free array routines (Simon)
v2:
- NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)

Maciej Fijalkowski (3):
  i40e: unregister netdev before clearing VSI on reinit failure
  i40e: fix potential UAF in i40e_vsi_setup()'s error path
  i40e: keep q_vectors array in sync with channel count changes

 drivers/net/ethernet/intel/i40e/i40e_main.c | 76 ++++++++++++---------
 1 file changed, 45 insertions(+), 31 deletions(-)

-- 
2.43.0

