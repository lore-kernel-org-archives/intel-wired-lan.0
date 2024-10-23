Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAD2D2E03B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Oct 2024 09:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BEE1606AE;
	Wed, 23 Oct 2024 09:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSHJYNmMQ18W; Wed, 23 Oct 2024 09:54:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A735F60728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729677273;
	bh=6mNNA6YJmfkO0XA+F+ucI6lQB2hh6MDHggmuvaVTMV0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D6a5lc1Xto7IQghyhk1uFey011EjyfH7uawa7I8Jdq/QHcxZ6oiwZeRnMidly68cb
	 fnuzmZI2IEb5zsJVzQmW6X3s7xFz2gy8Vcn9lh1mTRemJaearf7Fw7+IBy59KkaIq0
	 p1mKDtBpsdju59jyPNdcNjCxjTx7NQvi6ju4NGbTNPzaX2RsdUBNSF5qEk2NfKQSP0
	 egWxkqCXMYX+ODARtSM1K3Pz52t9fJd4uDtvXFRsdl1vTu6TQgbQtIT8ASJ/VvvbPH
	 8DGvF8pOtRfPuZNGwpofoQ1/+gQZUtMAfi2GL9qzlDecFy5E4VbDyjoSd1UwxaCSxz
	 f68M0sqlc33xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A735F60728;
	Wed, 23 Oct 2024 09:54:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41CC74C2A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 09:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C3F340557
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 09:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYaloJPcV0uX for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Oct 2024 09:54:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=konrad.knitter@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2C00840506
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C00840506
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C00840506
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 09:54:30 +0000 (UTC)
X-CSE-ConnectionGUID: 4OFRDgRtQu6bp2kFrv8gvw==
X-CSE-MsgGUID: EgIISoBjRlerp6MOgH0APg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54658335"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; d="scan'208";a="54658335"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 02:54:30 -0700
X-CSE-ConnectionGUID: YrjIHI14TiqqUnxNvuOkSw==
X-CSE-MsgGUID: nz862BU8S+qyczgxZaIMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; d="scan'208";a="84771104"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 02:54:27 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 3B8EB27BD9;
 Wed, 23 Oct 2024 10:54:26 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com, netdev@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Konrad Knitter <konrad.knitter@intel.com>
Date: Wed, 23 Oct 2024 12:07:00 +0200
Message-Id: <20241023100702.12606-1-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729677271; x=1761213271;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nu9GAOSS/x9sYmn0ZM2+b58Z0TGVtwLfkOauMH3gYrI=;
 b=V2LdmbBusi0omMB247hLGS1v87MceYaSchT7mXLRQhA6RKPBnLDWfFlo
 PfMYWWJ/RURbq930/nxUnpGGyzvhY0nnK4+JtWBXmM6QB1utoIcMRQ1xS
 Tva/I9/xq+j0eQ+w/080LPKr3W+Zymx8S4S1oerOKXYz03qfb4tOCi8qW
 675mg6AHqRtcLpMsXby++5jWulbvHl7HboP0bA5vhnZvFT68qjZoFhFH+
 tF+DsWimaxw/TwDJJp50nQvaBfIJevJ79Qtx1cRPjbIgY1775XMH052bw
 iHPF38kdmAwkwxCKou30wZAiuT3D1rg/huweKgAFdgFnlVQAfbsAH2gyN
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V2LdmbBu
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/3] support FW Recovery Mode
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

Enable update of card in FW Recovery Mode

Konrad Knitter (3):
  pldmfw: selected component update
  devlink: add devl guard
  ice: support FW Recovery Mode

 .../net/ethernet/intel/ice/devlink/devlink.c  |  8 ++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  6 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 +++++++++++++++++++
 include/linux/pldmfw.h                        |  8 +++
 include/net/devlink.h                         |  1 +
 lib/pldmfw/pldmfw.c                           |  8 +++
 9 files changed, 97 insertions(+), 3 deletions(-)

-- 
2.38.1

