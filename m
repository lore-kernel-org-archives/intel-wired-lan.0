Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDB7C55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 06:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D2546079F;
	Wed,  5 Aug 2026 06:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkkFu4oouN4o; Wed,  5 Aug 2026 06:52:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8609E60770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785912760;
	bh=l8sT77sMLnvc5J/o1+o8LA24MkhuWIDVXohFcRV7hjQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U2wcsfMQnk9eZxZ5V4Cy5H63IoWAjCykkU8dYLtrAlrM4aKLHFZttmFJCat6BOflE
	 /7EUmMkTT4TKbZ8CjWk2RGLB4rWmx5Dva9wAQyWkI1QnPYnluwt3Q0dacr5D5xdaJG
	 m6Q71MHBJti2Ucd8JbSqMD9AB77TgVWxiO0Yzt17NEL2t/Dv9DJhmzar9bQgtvjVWO
	 f6DrlkZ4hFOicbFJ8Q4o96r6fscKW3pgVTM9Pq81N46/LbsegG47NieX7mI18PR32m
	 MDKXntMXf0y9KtVekwe7flRRpQRohNobpXM/DxhiWJPVyI6/Dg+XohGfhkh3Y0KI9a
	 vv57Bnjw51Q0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8609E60770;
	Wed,  5 Aug 2026 06:52:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51686218
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EE4260770
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Id0ZtYlS7CPB for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 06:52:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.179;
 helo=out-179.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0443960718
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0443960718
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0443960718
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:34 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <xuanqiang.luo@linux.dev>
Date: Wed,  5 Aug 2026 14:51:27 +0800
Message-ID: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785912750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l8sT77sMLnvc5J/o1+o8LA24MkhuWIDVXohFcRV7hjQ=;
 b=JWhfTo5gUt8sZIKav4D+kCj2CMwI6V9+P1vTNAQpkHJVmRBoeNmdoakzQ8am6mXv3XNm4t
 3D+/Hz+O0QjlCBQCgTtNfB3N4nBzDA+qv63kdLt6xTvPDCcjCf+KQ6nxWrW3UFO4ek35dS
 2w6NquGfIDGx8bq10rB0ETZJtjOrdB8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=JWhfTo5g
Subject: [Intel-wired-lan] [PATCH iwl-net v2 0/5] i40e: fix PTP work and
 teardown races
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

From: Xuanqiang Luo <xuanqiang.luo@linux.dev>

The i40e PTP paths have independent ownership and lifetime races. A Tx
timestamp skb can be released concurrently, timestamp configuration can
race PTP teardown, reset recovery can rebuild the device during removal,
and external timestamp work can outlive the PHC or PF.

Split the fixes by invariant so each patch remains independently
reviewable. The series is ordered so the external timestamp work fix can
rely on the configuration and reset teardown synchronization introduced
earlier.

---
Changes:
v2:
  Patch 1 (new):
  - Split Tx timestamp skb ownership into an independent patch and protect
    the slot across transmit, timeout, interrupt, error, and stop paths.
    (Simon Horman, Sashiko)
  - Use ptp_tx_skb as the single source of slot state and verify the skb
    owner before releasing it from the Tx error path.
  - Keep the existing enable checks outside ptp_tx_lock so the critical
    section only covers pending slot ownership.
  Patch 2 (new):
  - Serialize the PTP_ENA transition with hardware timestamp configuration
    so an ioctl cannot re-enable interrupts during teardown. (Sashiko)
  Patch 3 (new):
  - Split reset/recovery synchronization from the external timestamp work
    fix and stop service work before PTP and device teardown.
  Patch 4 (new):
  - Move the reset polling replacement into its own patch and use the
    wait-bit API for reset ownership. (Simon Horman, Sashiko)
  Patch 5:
  - Close the configuration gate, then disable external timestamp events
    and drain the work outside ptp_config_lock before unregistering the
    PHC.

v1: https://lore.kernel.org/all/20260724093448.63154-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (5):
  i40e: serialize Tx timestamp skb ownership
  i40e: serialize timestamp configuration with PTP teardown
  i40e: synchronize reset recovery with device removal
  i40e: replace reset polling with wait-bit synchronization
  i40e: fix races in PTP external timestamp work handling

 drivers/net/ethernet/intel/i40e/i40e.h      |  6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 37 ++++----
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 95 ++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 38 ++++++---
 4 files changed, 120 insertions(+), 56 deletions(-)


base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0
