Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B4CD6E68
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Jun 2026 17:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88B8180B20;
	Tue,  2 Jun 2026 17:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TzFArI0b33Kv; Tue,  2 Jun 2026 17:09:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD50780766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780420174;
	bh=k+k8alVnyK9S8cPkhHz4Lu5Hmw3ypIs8UHodF0ib0O8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t+AGAbLNcSijh99m6EbBt/eJU+3NBwMZYDozqcQDIkFgY2whTlyIkeFeOZudNalSv
	 cff5cWusxAq/Ln+1jrma+wpT6VGbO3sHVVULDlcjN3IyMxpA+OtXWNpRyzPswelXWt
	 9tNcU/13e7SqnVR7u/ysrqVA9nqgBWnfgz4CAmLDMoPzlsbJDzOdGCipxW9Z9BN1y5
	 wRmz7Kw1kCcB+si7INt/8y5txnAzBnF2+AR7jQsRwqeBwGFyPORdCBtlRhHhijDd6o
	 5y92f37c9uM04eRHQ+Aw1UpO1d6tZ5Rog6A2U3tBVS4vucRdIAT45fsXWRBsQRfFe0
	 j1wBw0G3LKySQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD50780766;
	Tue,  2 Jun 2026 17:09:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 728042F5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 17:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58C02822D5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 17:09:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2CNkb8Rlm09V for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Jun 2026 17:09:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=joshua.a.hay@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 99CC4822D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99CC4822D1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99CC4822D1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Jun 2026 17:09:32 +0000 (UTC)
X-CSE-ConnectionGUID: 844S3qcdS+OblYy0h/2MNg==
X-CSE-MsgGUID: CgGc6ijFQOSjK2+EwKYrpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81074145"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81074145"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 10:09:32 -0700
X-CSE-ConnectionGUID: 96dHYEVyQCSSfybcPWMgKA==
X-CSE-MsgGUID: Q5t1NlO3Tf+ZAuzRdz3W0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="241475795"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
 by fmviesa008.fm.intel.com with ESMTP; 02 Jun 2026 10:09:31 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Tue,  2 Jun 2026 10:20:21 -0700
Message-Id: <20260602172024.2285947-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780420173; x=1811956173;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zV8mJg/ulwrxR+PEa19yPUKXBMuYknTDOr05srO4sXU=;
 b=eCH5oOBXs57DNV1PYYYADZkWm+D/eTk2iizEFcD+GQqa7U+mFXkSLNen
 zFFViZeVESX1u8D2VD625RBz84j+ILpxkAtP7+gpDFgCFhySsyZxkTMMv
 h/2EcHVPShH0qjeWfQqrwJ0GQOlr/V5CtLELR3cB52OxBtrEijmM3G6U/
 2t7kg0G0dAklTeTzGICAfCKRE13Lc/BMegsJtX9Yj9O1bxlvcgAwLkBTw
 Ukq+Al0Vg4u7mjHBqWRbVBqkbn51OKnLMeK3PCG5S9OP54VrzPC5VQiZN
 UGhaj37cUQT2o0aFNXlcaU+/1NsqyjUCi5EOAyhM+ZEFdeitcYM6MMly+
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eCH5oOBX
Subject: [Intel-wired-lan] [PATCH net v2 0/3] idpf: queue based scheduling
 fixes
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

This series fixes some TxQ scheduling mode issues exposed by recent FW
changes, as well as some issues reported by Sashiko.

Patch 1 prevents XDP from being enabled if queue based scheduling is not
supported by the firmware.

Patch 2 fixes a data race when accessing next_to_clean in
IDPF_DESC_UNUSED. 

Patch 3 fixes a NULL ptr dereference in the Tx path when queue based
scheduling is enabled, and also adds support to process both 4 and 8
byte completion descriptors to avoid timeouts in queue based scheduling
mode.


Joshua Hay (3):
  idpf: do not enable XDP if queue based scheduling is not supported
  idpf: fix next_to_clean data races
  idpf: fix skb datapath queue based scheduling crashes and timeouts

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 60 ++++++++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 15 +++--
 drivers/net/ethernet/intel/idpf/xdp.c         | 10 ++++
 4 files changed, 62 insertions(+), 26 deletions(-)

-- 
2.39.2

