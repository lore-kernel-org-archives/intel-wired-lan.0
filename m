Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B04C5B572
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA30540720;
	Mon, 17 Aug 2026 15:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CcDJ6OnLX_7L; Mon, 17 Aug 2026 15:27:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D546D4073D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786980439;
	bh=BUYEVZhB6IjzU8iIkm7Fy+3Re1KgS2KX1bdxTPKKy6E=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vmV8+I/q0LHnl06sBjeIuhxUz7YpPzi2PBAcVp0d5u6L/oYD+wGiR0EOGJ75JmkGh
	 /U20MtecVQq1eu6fGv+TmLI2W2ER/On3btUsGhEXPF5rNpzbAsOWMJNBmXKrsMJjp0
	 9VHzmrrnDl8ruVvSqDnV4Axx9OW9F35nje/OJoJz89zxL9Q3dODbQqVOw+mgahU7SW
	 GuLdPMUwwuS5huOQRud8KwCs/NrDFlK48MN7NRHVsegK/ngdu6UcQEBgiQ+jqtmMEK
	 RYOehHzgEWSBdX3rWsJMjCbur2Y+wiid+vNf/nPy9iq5wk5TgEfP6WNUPsp0/i8psI
	 YfPQqoaUYr8lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D546D4073D;
	Mon, 17 Aug 2026 15:27:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39EA033B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 209E360AFB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rb7U7Uy1SUaz for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:08:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=shivani07g@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5331860AAE
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5331860AAE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pwmw9lWG
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5331860AAE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:32 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso1640834a34.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786756111; x=1787360911; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BUYEVZhB6IjzU8iIkm7Fy+3Re1KgS2KX1bdxTPKKy6E=;
 b=pwmw9lWGgyjoxFQcIaX/Kwb2K9MUwiIOTPJlmD1iVmb6p6WcoeC+Vxn9+pF2Dh+k7K
 f7/b+k42AQNorwEvrynCyziPRV1vDEW42Xq6feW2X/3Q18cUBblybEdlDEY9k5PYmMPy
 FQnh7lKzVrNt0gtknV+q4Lyo7jYNxpFyWiox7liu7iMEKl3StU/oBv4NZ6i93R47cAMg
 4vRsrTgHJcZy7GMrNh1cr2TUqOnG6ewN9GCerduuP6KFvkVCA2YJuLNRNhEJvXvILFE6
 dztu5oTjz5aFl11ie5hxpyJEBU5nFD2ZLruVGy51QVYpV2kJ8dygZEhKrxCWa1lNzhdG
 6+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786756111; x=1787360911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BUYEVZhB6IjzU8iIkm7Fy+3Re1KgS2KX1bdxTPKKy6E=;
 b=Kt1B2+FNcJELulbvPigWLI6MtwBGOcuJam/vehDaLMO2ZMr9Nsn/9CH4n9/SnLo/F6
 3pzsvPiulD3ntbQOVAHjyqrT+UNbPW1+3fFTPEZGjp6sxOUo5+QKo6bNUlfrsa/0Dvpi
 s/UTZ0V3nvcq4XqG3TkcA4MnzKy1art9I7VVSPcUoDHLgbS5Mmx2C9HNkLgcMQA2KqGd
 jaMuWj7pWa2bTLig7gaCqUtVRAQMh2lXAwrmfDKoiVu0iODotXZN7NgCFSJKV3NLJmAG
 yudusOKOxZ5ZKHaLecXIsWDjIlL5EO/gRScYdGSK7SQG9zag3MVjUTP127Ka9XG5jvJO
 ULWQ==
X-Gm-Message-State: AOJu0YydWIRHVCAUvAe7DaqFC0ScPIlVpsegj7apHUPfO2PaEY5SgktR
 /9xV+KwgFIoNH+aZnN6ki/nqwE/bqcukCyhLZWOmxEN6kjBJ20YH/Y03mp5ZVDV+
X-Gm-Gg: AR+sD10vYZF8B7gj7eb5787KG2+TCHlN9WRbKpDCaXG3rA7Hgpf0spEwKmrpdTsPKOm
 2szvCrJORp2/Hng/BVabba1A4Ns09xnwWgFjg62eakG1GZ2BLUPi0+r5s4geyAEYmLgU+OPNCMz
 YBB16kEQhqL6ACG+z92af8u2J0nMXDvMDwP0AyNcyK6uu3o3BG1sneMA+YfIz0z0MF1lqzPJJVv
 Nq1/HOkOoF34EW4MWJdsmTp0i4CZDiJGJmfvY/cT+zUfmCDqbnZNM2uG0v+3ktzO/7MEBXD51Sd
 8jEGHhyWYgZZz94n2rx5UuHbx0E32zmBic4rKyOlJYZ25mEcsyiR1iYjZsM6UGwrhvQ+FoyDiPv
 vlkDXcn/eqyphh29YeLU/0/4gJ9+C8gb1xr7C6q2Bcpvy+mgd3oJ+MbokMxns4m2XWvMMZfoitP
 nDJsVufE3unF5v2pv4yU6qaInWYLVuzPHiit2uQKMXyZH52NPhk/HhjqgLE2h/jzCuwD7ooPcLF
 BpAM9AA848gSER5oiAlJhY9io4IOpw=
X-Received: by 2002:a05:6830:441e:b0:7e9:dd7f:7a83 with SMTP id
 46e09a7af769-7f3de1e5583mr8902353a34.0.1786756111121; 
 Fri, 14 Aug 2026 18:08:31 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282fesm2232153a34.14.2026.08.14.18.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 18:08:30 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Matthew Vick <matthew.vick@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Sat, 15 Aug 2026 01:08:25 +0000
Message-Id: <20260815010827.91912-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 15:27:18 +0000
Subject: [Intel-wired-lan] [PATCH iwl-net 0/2] igb: PTP Tx timestamp state
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

The igb driver keeps a single outstanding Tx hardware timestamp
request in adapter->ptp_tx_skb, guarded only by the atomic
__IGB_PTP_TX_IN_PROGRESS bit. The fields around it (ptp_tx_skb,
ptp_tx_start) are accessed from the transmit path, the retrieval
worker, the watchdog and the teardown paths without any common
synchronization.

Patch 1 ports the fix igc received in commit 9c50e2b150c8 ("igc: Fix
race condition in PTP tx code") - which the igc series cover letter
already announced as intended for igb - to igb's single-timestamp
model: a new ptp_tx_lock protects the timestamp request state and is
initialized during software setup, before register_netdev() exposes any
consumer. The state bit is removed, and the unsafe cancel_work_sync()
calls in the watchdog path (deadlock with the new lock) and the
atomic-context transmit error path (sleeping while atomic) are dropped
in favor of the worker checking the request state under the lock.
igb-specific paths that do not exist in igc (the 82576 polling worker
with its timeout branch, and transmit error cleanup that verifies slot
ownership) are covered as well.

Patch 2 fixes a related lifecycle bug: disabling Tx timestamping with
a request outstanding strands the request. On re-enable, all new
requests are dropped until the stale one is flagged as a bogus
"Tx timestamp hang" by the watchdog up to 15 seconds later. Pending
requests are now dropped at disable time. The disabled mode and empty
slot are published atomically under the lock introduced by patch 1, so
the transmit path cannot admit a replacement request during cleanup
(which is why the two patches form one series).

Both issues were validated on QEMU's igb (82576) model. The unpatched
disable/re-enable blackout reproduces deterministically (recovery only
via the 15 s watchdog timeout); the final patches complete 100 cycles
without a blackout. A 60-second timestamp stress test with link flaps
delivered 6445 of 6469 requests and completed without a KASAN, lockdep,
DEBUG_ATOMIC_SLEEP, warning, or panic report. The race window itself is
nanoseconds wide and was not directly reproduced; it is identical in
structure to the igc bug fixed by 9c50e2b150c8.

Note: this series touches the same schedule_work() call sites as Kurt
Kanzenbach's pending "[PATCH iwl-next v5] igb: Retrieve Tx timestamp
from BH workqueue" (20260305-igb_irq_ts-v5-1-d3b96828ab5b@linutronix.de).
The overlap is textual only - that patch changes which workqueue runs
ptp_tx_work, this series changes the locking around the request state -
and either rebases trivially on the other.

Shivani Gupta (2):
  igb: Fix race condition in PTP tx code
  igb: Clear pending Tx timestamp requests when disabling Tx
    timestamping

 drivers/net/ethernet/intel/igb/igb.h      |   3 +-
 drivers/net/ethernet/intel/igb/igb_main.c |  49 +++++++-----
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 120 ++++++++++++++++++++----------
 3 files changed, 113 insertions(+), 59 deletions(-)


base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
