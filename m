Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0C6F589CB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Apr 2026 13:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20AF683B88;
	Thu, 23 Apr 2026 13:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cKAb1JZVMsZ; Thu, 23 Apr 2026 13:04:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98DC083B8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776949470;
	bh=VtiyJlvs5EwHGsCQK4dQU/qFxQZSwSancLkxNqodEyA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=msUAi4PbZcNoi0bem3oAEcSr88iHFQGdKCTOSeYgnnzXcLSLEtorqWcniexudXoFt
	 eLJZZmPkPVDpiQw8EbukDTswrRO33RUIqlMTvtJdvT+lX2RoNMusvMWIBnnXWMYJ0W
	 rfhz5h0zWGSTNUc8sCW5jbZxxfDLZYZKkL0IqAqNovdSEaZvermpGkRnzMx1pVfq1k
	 4RLWwK2mPLon2+M3S9nQ/ouuW1/D7rOTWgtt+QAKZ5ivU7DFQ/bKwgpygPCA4jTV8k
	 GrIcWzV+UuO2rZ2xehMbbHcUNww0NbSS8qF3lC3WkC4iDgkP91ZReG9KRUcbLdlPoF
	 LXUav6vi7vZcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98DC083B8B;
	Thu, 23 Apr 2026 13:04:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F26B24D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 13:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3076383B8A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 13:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ep8Lf7G7x21z for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Apr 2026 13:04:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 796AC83B87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 796AC83B87
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 796AC83B87
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Apr 2026 13:04:22 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-KVaxLk0AOguFjvtsdQIPoQ-1; Thu,
 23 Apr 2026 09:04:18 -0400
X-MC-Unique: KVaxLk0AOguFjvtsdQIPoQ-1
X-Mimecast-MFC-AGG-ID: KVaxLk0AOguFjvtsdQIPoQ_1776949456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88DF41954B0F; Thu, 23 Apr 2026 13:04:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B284A19560AB; Thu, 23 Apr 2026 13:04:09 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, horms@kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Thu, 23 Apr 2026 15:04:01 +0200
Message-ID: <20260423130405.139568-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: WIV9mAYN624bhPWa4MLUYaCoBN4Ef7027yB4ms2LA24_1776949456
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776949461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VtiyJlvs5EwHGsCQK4dQU/qFxQZSwSancLkxNqodEyA=;
 b=Of/wgQpFVFqiKFEp7xkQz3Q4lGSwtTpS1yI9ZItoDCJv8YWmIg5IZ2Uit2qya5ievydFw/
 slOJ2LfT4OsLt0RhscZ0BsPmIOfWe5pJ8TYpn9DEGAD2tzlhh42BCZQblzYbfl3fIdMH/E
 aBHPbgLEW6w29xWNmt82On01b68/T1Q=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Of/wgQpF
Subject: [Intel-wired-lan] [PATCH net v4 0/4] Fix i40e/ice/iavf VF bonding
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
2. Eliminates unnecessary VF reset when setting trust in i40e, resetting
   only when ADQ cloud filters need cleanup
3. Fixes lock contention by polling admin queue synchronously
4. Eliminates unnecessary VF reset when setting trust in ice, resetting
   only when MAC LLDP filters need cleanup

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

Note: The refactoring suggested in v2 review to unify polling functions
and call iavf_virtchnl_completion() for all messages will be submitted
separately to net-next after this fix merges.

Jose Ignacio Tornos Martinez (4):
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust
---
v4:
  - No changes to patch 1 from v3
  - Complete patch 2 with AI review (sashiko.dev) from Simon Horman.
  - Complete patch 3 with the comments from Przemek Kitszel and AI review
    from Simon Horman.
  - Complete patch 4 with AI review (sashiko.dev) from Simon Horman and
    issues addressed when comparing with i40e.
  - Drop patch 5 from v3 (refactoring is postponed)
v3: https://lore.kernel.org/netdev/20260414110006.124286-1-jtornosm@redhat.com/

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 42 ++++++++++++++++++++++++++++++++----------
 drivers/net/ethernet/intel/iavf/iavf.h             | 10 ++++++++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_sriov.c         | 41 +++++++++++++++++++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |  1 +
 7 files changed, 225 insertions(+), 43 deletions(-)
--
2.43.0

