Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ACBCDB46F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jun 2026 10:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13B3660891;
	Tue, 23 Jun 2026 10:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BuclVvYE9jd1; Tue, 23 Jun 2026 10:18:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0ABAD60851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782209898;
	bh=qx6g68unrdRQVtSYPAZf1nYu6kY6LgtEicHSfdsFgYg=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ks4khBKkCyt5ShkzlKYew5LAx0DnA9NFA6+vVgRhvKPEE3pSX1KqL6jnD4U+0071I
	 dE04UdgcZAVsGpSJnhvjZepYkcyI+vTv07BS+ZPFDz/+wISGuQsrXdlqsA5iPv6h66
	 0OxAqCBPXlbDIwyzsmjDowJeHM93k5phV20EZTwQ6A72dFynJZn0iLEIr5w5VJTM0z
	 HMS6l1vG7dbZ+ZVwBKLrHIzRnJtpeSIqSqlUib6J0lCdQNKaVsWGxbrw6tOrnJE/jF
	 XF6Co4BplWdFeoK9q6Y57d6Njyyw9fAk55jLLQb9iLZsz70RljVXBaOXtNaR7fDC73
	 p/W7qRZ47sKMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ABAD60851;
	Tue, 23 Jun 2026 10:18:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADBEC367
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93EBE40266
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:18:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EtT2XOTY8gg2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jun 2026 10:18:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8678040252
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8678040252
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8678040252
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:18:15 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-39ACVkMmNMmDCjs1Ie7Dvw-1; Tue,
 23 Jun 2026 06:18:10 -0400
X-MC-Unique: 39ACVkMmNMmDCjs1Ie7Dvw-1
X-Mimecast-MFC-AGG-ID: 39ACVkMmNMmDCjs1Ie7Dvw_1782209889
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7DC31955F73; Tue, 23 Jun 2026 10:18:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AA80180059C; Tue, 23 Jun 2026 10:18:04 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, horms@kernel.org,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Tue, 23 Jun 2026 12:17:56 +0200
Message-ID: <20260623101800.991293-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: oqGAP4kzfC_oqDBM-M6YGrzE0XPianPVFR6T3kW7yrw_1782209889
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1782209894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qx6g68unrdRQVtSYPAZf1nYu6kY6LgtEicHSfdsFgYg=;
 b=baGpcH140HnG9rWxwoRReWQwqLVOFWFyPhiprm9GXFa6/DH2W3ejON0av1y6SImnQU7i0S
 T8/srnak2laInG9Z00jpt3SQt/E3BqxcA6xtP/nDgzCawR+OPeR8Fym4UCcScgYB5Mz1tU
 uvc2W4uz/r66sd16cRHAczT439gcwtQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=baGpcH14
Subject: [Intel-wired-lan] [PATCH net v7 0/4] Fix i40e/ice/iavf VF bonding
 after netdev lock changes
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

This series fixes VF bonding failures introduced by commit ad7c7b2172c3
("net: hold netdev instance lock during sysfs operations").

When adding VFs to a bond immediately after setting trust mode, MAC
address changes fail with -EAGAIN, preventing bonding setup. This
affects both i40e (700-series) and ice (800-series) Intel NICs.

The core issue is lock contention: iavf_set_mac() is now called with the
netdev lock held and waits for MAC change completion while holding it.
However, both the watchdog task that sends the request and the adminq_task
that processes PF responses also need this lock, creating a deadlock where
neither can run, causing timeouts.

Additionally, setting VF trust triggers an unnecessary ~10 second VF reset
in i40e driver that delays bonding setup, even though filter
synchronization happens naturally during normal VF operation. For ice
driver, the delay is not so big, but in the same way the operation is not
necessary.

This series:
1. Adds safety guard to prevent MAC changes during reset or early
   initialization (before VF is ready)
2. Eliminates unnecessary VF reset when setting trust in i40e (reset only
   if revoking trust and VF has advanced features configured).
3. Fixes lock contention by polling admin queue synchronously
4. Eliminates unnecessary VF reset when setting trust in ice, (reset only
   if revoking trust and VF has advanced features configured).

The key fix (patch 3/4) implements a synchronous MAC change operation
similar to the approach used for ndo_change_mtu deadlock fix:
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/
Instead of scheduling work and waiting, it:

- Sends the virtchnl message directly (not via watchdog)
- Polls the admin queue hardware directly for responses
- Processes all messages inline (including non-MAC messages)
- Returns when complete or times out

This allows the operation to complete synchronously while holding
netdev_lock, without relying on watchdog or adminq_task.

The function can sleep for up to 2.5 seconds polling hardware, but this
is acceptable since netdev_lock is per-device and only serializes
operations on the same interface.

Testing shows VF bonding now works reliably in ~5 seconds vs 15+ seconds
before (i40e), without timeouts or errors (i40e and ice).

Tested on Intel 700-series (i40e) and 800-series (ice) dual-port NICs
with iavf driver.

Thanks to Jan Tluka <jtluka@redhat.com> and Yuying Ma <yuma@redhat.com> for
reporting the issues.

Jose Ignacio Tornos Martinez (4):
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

All patches tested successfully with bonding setup.
---
v7:
  - Patches 1/4, 2/4 and 4/4: No changes from v6
  - Patch 3/4:
    Rebase on current net tree
    Remove the multi-batch processing loop from version 6 according to Przemek
    Kitszel review: the loop cannot work without polling between iterations
    since the second call would fail the current_op check. Multi-batch scenario
    is extremely rare; send first batch and let watchdog handle remainder as v5
    did
v6: https://lore.kernel.org/all/20260619061321.8554-1-jtornosm@redhat.com/

--
2.43.0

