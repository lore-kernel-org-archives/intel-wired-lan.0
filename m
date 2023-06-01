Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173BC77B7E
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Jun 2023 21:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D87340499;
	Thu,  1 Jun 2023 21:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D87340499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685654120;
	bh=rYw8khwQGs/fQ9z1Fck0dN+mt/suJpOFD9JDML1OojY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O1Yr6F/QjLbxItA5IxL7bJOlsPsWpXJqMgaD6QHSvTtCKGSUezfpVUN2M1io069hM
	 pvFOwzovBfA4bmJfsMjXgDMZcxmgEOLYU+o/kzvqNpV5Baa7Q3pj/NQ1Bdj2QnrArl
	 KyQoFo0Ffw4DyA7kWDKuXzGFMF5U7OCXF5d22vI7b8LTdV4FMytXXdMSObhQ/huQvZ
	 hWcyIFyOoRGHL20HbYJFNia4IJSPVs0Fs/ilE7xX5F/0S2SaexoHHm1W3vFtPtuBfl
	 vBtBbdEs7dRL0KiezYa817QHlkdHWY4lpW77gJzEHCxh33omASA692hjpG7tNz5HMk
	 iv2Uu7BpST0pw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjYFyj8a_aiZ; Thu,  1 Jun 2023 21:15:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53A1C415B9;
	Thu,  1 Jun 2023 21:15:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53A1C415B9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 660F71BF573
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 21:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44DC94269A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 21:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44DC94269A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XpvXQTMQ0PVI for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Jun 2023 21:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B1B642587
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B1B642587
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Jun 2023 21:15:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421500833"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; d="scan'208";a="421500833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 14:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737249189"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; d="scan'208";a="737249189"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 14:15:13 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  1 Jun 2023 14:15:02 -0700
Message-ID: <20230601211507.707619-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.40.0.471.gbd7f14d9353b
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685654116; x=1717190116;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4rQW0IlRn+nb2dCPnlfTxk014W0B/s+C/5JgJQNBtyo=;
 b=Sei3aRh2/w18ZGiOFgD+h+zneWPPACKBHWat4jWglI+YcA3Ns2h135hE
 8qclDnFBFaUST5htwVKvtgkdeehSNcF9FhfVsWIuN9WbMVAnRSxPJ0i34
 VT2ClnvoV0TuKuZPp3YP2BR2+L0DPYJSnMRtHfccSdfwLWB0t6j1y8Dyv
 eUB88DuvCjNn9Qi+uV1uMLWzKNJxol5yah3QKwaTjdtopcT/b2uQTU6iy
 fiQCT/pS+U6l09mg/Qzy1ypxvDu8rCVYI67Ut103mmCt8AU8DiMIbVw1D
 daCTKcKd6YBplmXarPpDgWSIOmNsMybvvaQsNzPH66jeRuBYps5rr89j4
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Sei3aRh2
Subject: [Intel-wired-lan] [PATCH iwl-next v3 0/5] ice: Improve
 miscellaneous interrupt code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series improves the driver's use of the threaded IRQ and the
communication between ice_misc_intr() and the ice_misc_intr_thread_fn()
which was previously introduced by commit 1229b33973c7 ("ice: Add low
latency Tx timestamp read").

First, a new custom enumerated return value is used instead of a boolean for
ice_ptp_process_ts(). This significantly reduces the cognitive burden when
reviewing the logic for this function, as the expected action is clear from
the return value name.

Second, the unconditional loop in ice_misc_intr_thread_fn() is removed,
replacing it with a write to the Other Interrupt Cause register. This causes
the MAC to trigger the Tx timestamp interrupt again. This makes it possible
to safely use the ice_misc_intr_thread_fn() to handle other tasks beyond
just the Tx timestamps. It is also easier to reason about since the thread
function will exit cleanly if we do something like disable the interrupt and
call synchronize_irq().

Third, refactor the handling for external timestamp events to use the
miscellaneous thread function. This resolves an issue with the external
time stamps getting blocked while processing the periodic work function
task.

Fourth, a simplification of the ice_misc_intr() function to always return
IRQ_WAKE_THREAD, and schedule the ice service task in the
ice_misc_intr_thread_fn() instead.

Finally, the Other Interrupt Cause is kept disabled over the thread function
processing, rather than immediately re-enabled.

Special thanks to Michal Schmidt for the careful review of the series and
pointing out my misunderstandings of the kernel IRQ code. It has been
determined that the race outlined as being fixed in previous series was
actually introduced by this series itself, which I've since corrected.

Changes since v2:
* heavily re-ordered patches for clarity and a better flow of implementation
* used atomic bits when communicating between ice_misc_intr() and
  ice_misc_intr_thread_fn()
* re-wrote commit messages to improve clarity and remove mistakes about how
  threaded IRQs work.

Jacob Keller (3):
  ice: introduce ICE_TX_TSTAMP_WORK enumeration
  ice: trigger PFINT_OICR_TSYN_TX interrupt instead of polling
  ice: do not re-enable miscellaneous interrupt until thread_fn
    completes

Karol Kolacinski (2):
  ice: handle extts in the miscellaneous interrupt thread
  ice: always return IRQ_WAKE_THREAD in ice_misc_intr()

 drivers/net/ethernet/intel/ice/ice.h      |  7 +++
 drivers/net/ethernet/intel/ice/ice_main.c | 47 +++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 62 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  | 16 ++++--
 4 files changed, 84 insertions(+), 48 deletions(-)


base-commit: f08ff053a47a51d4f391d407bdda6adb4e7ed499
-- 
2.40.0.471.gbd7f14d9353b

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
