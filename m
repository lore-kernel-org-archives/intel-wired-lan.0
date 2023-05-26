Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66138C77B7A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 May 2023 22:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0084984D99;
	Fri, 26 May 2023 22:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0084984D99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685139777;
	bh=aF1KkD/2vbCXiEOIMsVXn65MftKCwOTgyQzjDTseLUg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xgm7Z74axwjxstp54ts01yqVgP6rpLj+yAfKmMer+ytwAyJZeWU9Hqk/EjU4Aor3x
	 qtzAVge8Z6/lSA7+Br2k60fTPnEIIiaYlZFiVyW75sefQbO/oLskaJmAXPaqj1QMQv
	 Ock/agg8t1z2gu1cCgni7pfqc/ZXqQ+kkUl5Y/AbinP1MDCioKsaERJ1fiof+1VEuf
	 kXJC95TVRqP/kuL2YsPLupaVx9xec8kO1rVLPbfuKp6p0gxFvdxzWLMPlcyz9G9yyx
	 Jl1v73Zvx/EdxrVa+KHz3ZPaP5RkZdu0WHxGwEFEwHMQhqCxqwXJPdluMNyb9DwZF8
	 ABHXjWN43Dsog==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XVmU0yrqzaug; Fri, 26 May 2023 22:22:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00C8E84D9E;
	Fri, 26 May 2023 22:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00C8E84D9E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0A70D1BF33D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 May 2023 22:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE4ED42A9A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 May 2023 22:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE4ED42A9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dw41xzizsvMw for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 May 2023 22:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A75A442A96
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A75A442A96
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 May 2023 22:22:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="338912475"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; d="scan'208";a="338912475"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 15:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="1035510104"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; d="scan'208";a="1035510104"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 15:22:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 26 May 2023 15:21:53 -0700
Message-ID: <20230526222158.2685796-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.40.0.471.gbd7f14d9353b
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685139772; x=1716675772;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wYe8lfMirOCc+65+gdcTHmOh2awoc3g0iT6CsnnBjoI=;
 b=OcosTjmMV+ZHbc4lw7859CLZ4Hw2HL+3Uk7XmPCkpcbNBzpysiSMhiOv
 vQ+yKhKf2b30mkB9exNaVsVerdRHoDk6Y3IyJDvZejn7U/jdHajbG2fXg
 zZeA9EqFWXQOrkdaBc6dio5G3nhZmTPRchSYbhMJ8yrMnrfMGaA4h5iBu
 IJeyev1GUcjXYS6ZIeglEBSF61HNMica2pV2wU33hp/4zTEYpKe2Gx9w0
 chgWXxEee/sw8f5BpBG0DvUNTAlc/AiaJrUfLThLRXXeWQ55JHsWcTlUa
 PsmB2Uq8hwFidsA4gtn6vqkraHN9v+A4oN619B+CwCgpm3by9kaBCEIxN
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OcosTjmM
Subject: [Intel-wired-lan] [PATCH iwl-next 0/5] ice: Improve miscellaneous
 interrupt code
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

This series fixes issues that occur due to the interaction with the hard IRQ
ice_misc_intr() function and the soft IRQ ice_misc_intr_thread_fn().

First, Karol fixes an issue with the external timestamp being handled by the
PTP kworker, resulting in a disruption of timestamping an input signal on
the external software defined pins with a frequency of 100Hz.

Second, Karol fixes an issue when running on PREEMPT_RT kernels due to such
kernels not allowing queue_work() inside of the hard IRQ. The scheduling of
the service task is moved into the soft IRQ thread function instead.

Following this, I have three patches intended to fix an issue with the
handling for E822 hardware involving a rather subtle and complicated race
between the hard IRQ function and the soft IRQ thread function. Ultimately
the code is refactored so that we stop polling in the thread function, and
ensure that the OICR (Other interrupt control register) is disabled for the
duration of the thread.

I think that while this does fix a race condition issue, the amount of
changes required to refactor the interrupt function is large enough that it
does not warrant going into net.

The race itself manifests only if multiple Tx timestamps are outstanding at
once. This is atypical behavior for most applications. For example, ptp4l
synchronously waits for timestamps before continuing processing.

Jacob Keller (3):
  ice: introduce ICE_TX_TSTAMP_WORK enumeration
  ice: trigger PFINT_OICR_TSYN_TX interrupt instead of polling
  ice: do not re-enable miscellaneous interrupt until thread_fn
    completes

Karol Kolacinski (2):
  ice: handle extts in the miscellaneous interrupt thread
  ice: schedule service task in IRQ thread_fn

 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 52 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 61 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h  | 16 ++++--
 4 files changed, 83 insertions(+), 47 deletions(-)


base-commit: 1e806efa4f2837a829044df27e1196a4fd520ba3
-- 
2.40.0.471.gbd7f14d9353b

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
