Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3301FC88E75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F33F980E05;
	Tue, 15 Sep 2026 12:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruOQ7fxTNBLD; Tue, 15 Sep 2026 12:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4AB3A80E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476973;
	b=tOAj2CxRkS3q2kCq0IJKUtHn6+wMlUH8iv3drW435dGNNXdJjmxt26bnHzRoOWEo9cSm
	 1+jKON1pMijgyurxVlDXTooGI/MTXwduuUsGvg0v/pR7eUfU5zh48ZFAfpVCPu/hhJcRD
	 Oepc25wVq6IRXLcewKO/nPZRzOnqsPUsV/87gAqH9yZRBReVjVkgG5zSDEmJrYIWRVBx2
	 fkcohzf4VyRqToda4Af5WO/FoeNFnq3z2k0CAy9QCbsCecmvYb4yDwKPQ/9keuacl87/1
	 F86pUGDpaV/SBiEHH3Te7vmDPzogIk04IsRbPxwNlZAYMSukqK1a8P9gcT05ghkoR1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mdDzrSguDKr5HtLuweex4U/m61Fieu2g+gL3DbCEZTk=;
	b=qx3H1Ry1yLgOpH7hlC9G1VETwj23AlRLvvPvEnqlREWYYX1xE90Ox5bXcPVmRARr8qsP
	 XlqDQoZVWVY8ofYKSREA2uaxfwXI2CvMutqoZN2QcZ1DLnAK1qgHAbiHffcDbsFs4e0o4
	 3enKTd7v+Fc12hANyHjfcNqwqqHAUsroLKjmLFlxsZzwtR78R2LxUO+3uzQWNk2YtLLBk
	 bbMzTMyLuOwNztqVm0GTJVvRIgXiaRKyo6+UXb/Fi2ZLYB3VdAHXJ+hUCUwQzt0aOA82k
	 kL9XSFGR5CtCHoC7zlQymiftTmtzTH1blVzNrSsaLwE49bqpBM8HG6TeNQ923KDxs/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476973;
	bh=mdDzrSguDKr5HtLuweex4U/m61Fieu2g+gL3DbCEZTk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MfXa9zDRwSEr/2am7Qdsr4D5IaMcJ7DR3/DEkNFjt4vb3WzqkQnxdw7vBeDuttr3V
	 QC0Qzr17iVbDzbAMjwKi/tlbfytM8jcDGmCQZrHUKzfjPOBVtctmijb5umzOU6gUH9
	 goa5d9DExn++P0/jbX/m0dYXNbp7hWK9DxLZzckdebX7W5jBZXm+7BAh+PPrEGe0Br
	 djcPW3ybYZMemlw4MBXrbEpo3+flat9gyl8cHd0NK7VtkTSJOe1/CC1hoyhj+srxYl
	 CiZkNQQQ+YGu8WJiZiacL5Qh5/RFWGtgz9kZWLtlMsJnyLReJFCGXP30T069o5RNOR
	 C8m7wQYYLCKIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AB3A80E0D;
	Tue, 15 Sep 2026 12:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F895493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4655B6077E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IrxGFfnl0eh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 846B1605E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476969;
 b=H+jTowCCu6v4zpdp3sgENmi4zvVP05bomcFGdHZ0DxA0KohdmodznMEL/fooaBwEjI5O
 VDrXjhoa8sxQdN4KKyoasVr520/C5U1DG8kGxtOGyjnVnvm2qzA8Yf8ai29cjTWUp13ld
 XyiGWrf/qK/Q8pIJIL8AGOT4zFRqxzCGmQiJJRW3tjqb3dtsvbc+etUs976B53xaTJThu
 VUh7POqin4JWq3Bus+mh0ixMFHzSBDUtcddekqGQB8oWJQ2i+s3eunum7u+SDpAjp4Pxq
 vkOI9BJGkWfjEN+osd7S48lIV+7VUNLHHMs4iTwvUfk7UtNXWY8kt0JrdTjEUoitTyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476969;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=mdDzrSguDKr5HtLuweex4U/m61Fieu2g+gL3DbCEZTk=;
 b=mOljkr/SxJt2tJIwp29DAC0g3OtzVAgkBpM4y/cx37uAIVmmnLS7wvPnXC14xYvKwGji
 FOR06owe4bXqiWvmOO4pOVZizTbc4Y9bEyFRgTeXwUSqFupZIurCXiKd/4Py8W9R9pwqo
 BwO3J+PFSWB3cK/8YMR9kdxhSpE5aMpfCTO97FQRW0J2mp4AGWY6esZg9ojuY+NtjbOCb
 AQPaD10lo5Nm0arGnRPaPuFO4NkkJI8ZoGStiTJJDIAms8e9easOYnIun130YSgNhn/SL
 axWTerjpWqFgMbWteyTZ6a+x6v5Q7McmoQedX+ckIWO6hnMPZI+eMjhUTxpl2vbnzLA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=b0a+TH6d; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b0a+TH6d
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 846B1605E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476970; x=1821012970;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=edb5eoknSPUq1qK19ORid7e1f+At9ujZ549j/v/oJaM=;
 b=b0a+TH6dDItRnL8CnEUkoPm3EQWYTsNxPoAFi1GTZ6zU1JZamRMDsHom
 Hxv5a1n9jLz9VliIUoi7P0kiV/Tvl1bnLisOLVbAZ+fc642lvJDAb5vnO
 DPNFAjUYUJ8ojNnaQCpQbmpLdpsWRmDmRHWJ0z0AWwSlWcmaDpqG9k1uA
 4c4eyMht/C/ZMmCk9XDiJMRDcokwmbkgZitd7Geup0SdTV3O6+o/y27sS
 nXPTIFulQt/fH6U+tws/SstworQYK6I7Fg7/4j/MWTtQyLSYsTaf4SYC7
 mKHbSleifLTOfLoURLNqZpwQsdChFTMjickiCd/J2bfUBfe+z7LyXqBx/ Q==;
X-CSE-ConnectionGUID: BFJAfK/SRxKw4iZxTIIzcA==
X-CSE-MsgGUID: 9/WsdRR4T0+WKMKEwmChWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607069"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112607069"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:53 -0700
X-CSE-ConnectionGUID: HIJuEqdDSCOJCqsILxWGTQ==
X-CSE-MsgGUID: 0OeayaWfQmyBVdXIQwr/cA==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:52 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 0/5] iavf: five correctness fixes
Date: Tue, 15 Sep 2026 14:55:46 +0200
Message-ID: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Small batch of iavf bug fixes. Patches address a NULL-pointer dereference
crash in the hung-tx detector, a spurious free_irq() call in the misc-IRQ
error path, a VSI-state-corruption race when ethtool changes ring
parameters during an active reset, an inverted TC-boundary comparison
that silently steered frames to non-existing traffic classes, and an
-EINVAL that confused upper layers when a TC flower filter was looked up
after its qdisc had already been torn down.

All five are genuine correctness fixes with no functional changes for the
common path. All five are marked for stable given the crash/corruption/
kernel-warning/misdirection/error-reporting impact on shipping kernels.

This series was originally posted in April without a version tag and
stalled without being picked up. Re-posting as v2 with the fixes Simon
Horman requested in review, carrying forward the Tested-by tags collected
on the unchanged patches.

Changes since v1:
- Patch 1: Fixed the Fixes tag, which pointed at an unrelated i40e-only
  commit (9c6c12595b73); the function was actually introduced into the
  iavf lineage by 07d44190a389. Simplified the misleading NULL check on
  tx_ring (an array-element address, never NULL) to a check on
  tx_ring->q_vector instead, and read it with READ_ONCE() so the watchdog
  can't observe a torn/re-read value while a concurrent reset swaps it.
- Patch 4: Reworked the boundary comparison. `tc > adapter->num_tc` still
  let every in-range tc skip the destination-port requirement and let an
  out-of-range tc with a destination port fall through and return 0.
  Now explicitly rejects tc >= adapter->num_tc before checking for a
  destination port.
- Patches 2, 3 and 5 are unchanged from v1.
- Added Cc: stable@vger.kernel.org to all five patches.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Kiran Patil (2):
  iavf: fix null pointer dereference in iavf_detect_recover_hung
  iavf: return 0 when TC flower filter not found after qdisc teardown

Piotr Gardocki (1):
  iavf: fix error path in iavf_request_misc_irq

Sylwester Dziedziuch (1):
  iavf: prevent VSI corruption when ring params changed during reset

Avinash Dayanand (1):
  iavf: fix TC boundary check in iavf_handle_tclass

 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  5 +++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 19 ++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.c    | 50 +++++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.52.0

