Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CCDCD98E6
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Jun 2026 06:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E6A28540D;
	Fri, 19 Jun 2026 06:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JuVWDid9YDm3; Fri, 19 Jun 2026 06:13:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A989B8540B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781849620;
	bh=09Af/p941u9vuXloa/4AdqYAv0ET6ySs46OyBq8hbRk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PZpujC+Y+4ZubJbW5fGSJSUkySFKCU26v7SefNUy6oytsquufCyU/MEnAzG9lOid9
	 q/lsMFQl2CetcPyQ/LF98ghlxcFNTveTekU5fYOdUmQzqc9WR6EJLvDv9p0Jg4XNez
	 7/UA5VlLIqzC6VtqtAIesMX6twhDu0IdJVZQu31frzg6sM8U7HXbYkPskcY1EFldi6
	 Ty+fP3F2AIKqJv9eXnA+PaoxjrQMh90+K1aPMauUUWLWtT5aT7b62hBaHqehWvolv5
	 tuHFaLwRWlAlLvPP8NX8+ld+F2w4bXJTaG3rIQYoZ8EbHssQ58RCImje+uEtrXzu56
	 TCfGcC7hUlE6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A989B8540B;
	Fri, 19 Jun 2026 06:13:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 292402D7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jun 2026 06:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ACD041E02
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jun 2026 06:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y1gO_MUdvtpk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Jun 2026 06:13:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E930D41DF2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E930D41DF2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E930D41DF2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jun 2026 06:13:36 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-a99EL2bdNLOUgcN9FN3MHA-1; Fri,
 19 Jun 2026 02:13:32 -0400
X-MC-Unique: a99EL2bdNLOUgcN9FN3MHA-1
X-Mimecast-MFC-AGG-ID: a99EL2bdNLOUgcN9FN3MHA_1781849610
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2A911805A10; Fri, 19 Jun 2026 06:13:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 003D81956088; Fri, 19 Jun 2026 06:13:24 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, horms@kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Fri, 19 Jun 2026 08:13:15 +0200
Message-ID: <20260619061321.8554-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: kEcOxbjFrMKqm02AI3gbNQtBL-RQSq4XH51V-kR4WBI_1781849610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1781849615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=09Af/p941u9vuXloa/4AdqYAv0ET6ySs46OyBq8hbRk=;
 b=ONq5lGO1uLge2xwSpLQJU+6k2p9IZC3kQpLOLi6hWOl6f43FTBQdXdl5y4Y5cvTe8almJv
 y2LZ1ZgyxTQaT6p0a+Lb6a3R003/s9qx+DHGXSEU732xKwnXZP0gCfNYI0wXb7nXz7B4Ko
 6Zjq20ckBxkuQhCEPVDGNWxeMeqz+u0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ONq5lGO1
Subject: [Intel-wired-lan] [PATCH net v6 0/4] Fix i40e/ice/iavf VF bonding
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
v6:
  - Patch 1/4 (iavf EBUSY): No changes from v5
  - Patch 2/4 (i40e trust): No code changes from v5. AI review comments covered
    design decisions and pre-existing issues, no bugs found in new code.
  - Patch 3/4 (iavf sync MAC): Address edge cases from AI review (Jakub Kicinski)
    - Allocate event buffer before sending to avoid state mismatch if allocation
      fails after message is sent to PF
    - Add loop to send all batches before polling (rare multi-batch scenario)
    - Conditional rollback: only rollback on send failure (ret != -EAGAIN), not on
      timeout where PF will eventually respond
  - Patch 4/4 (ice trust): Revert to original reset pattern based on AI review
    - AI review identified issues with v5's reset-before-cleanup approach
      (privilege bit not cleared, LLDP cleanup loop became dead code)
    - Restore proven cleanup → set trust → reset pattern from original code
    - Simpler implementation, no save/restore complexity
    - Maintains same goal: skip reset when VF has no advanced features
v5: https://lore.kernel.org/all/20260429102426.210750-1-jtornosm@redhat.com/

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 ++++++++++++++++++++++++++++----------
 drivers/net/ethernet/intel/iavf/iavf.h             |  10 ++++++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  33 +++++++++++++++++++++++++++++----
 5 files changed, 220 insertions(+), 35 deletions(-)
--
2.43.0

