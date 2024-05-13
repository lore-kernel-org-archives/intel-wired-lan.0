Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F342C25B10
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 May 2024 10:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A99183276;
	Mon, 13 May 2024 10:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdV-u5LXTBW2; Mon, 13 May 2024 10:38:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFFA383104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715596705;
	bh=18q33RwG6mqGF18aj/pavubMi5lsSQ+Ik+NXBAXPWQo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Lv1/1kEnCS4fTAcNazEbxdjDhtWobTTvkL/Azxi8azAF/M7ENHNRDf+yPdkaTzgiQ
	 Qv1fazhoXk8Xb0m2Sr7i/tU4kly8H5xADQQiQB5NDP8TQt8puO4J1qThwW1C1mD5lD
	 FQa5nvzrOcwlCtDTe3wA/UQN7YjV3HaHEAT73yD6pCFjej+ErZgIpZc2sS//rJiv+W
	 /8vELvwzWkGk5D4GOodVmceH5ciicvkcArJgnrLRoFkaldsEDkuL/qWcSGXSWLkTvk
	 fdlFAXtcpPTeNwcvFg/5rZbA8qHXxwMLw/h5L4iOBXU501Lp8J6juCVLctEIQGAhZ6
	 ow8AKkEFgZ9zA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFFA383104;
	Mon, 13 May 2024 10:38:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1E8CB1BF3B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 May 2024 10:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 094A540C94
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 May 2024 10:38:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_kJCcDuNxWt for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 May 2024 10:38:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lakshmi.sowjanya.d@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D9745405A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9745405A1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9745405A1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 May 2024 10:38:21 +0000 (UTC)
X-CSE-ConnectionGUID: lkn0OmR1SL6lzWK1QQ18rA==
X-CSE-MsgGUID: AvQIc2tyR1K96Iw5NWoVrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29038826"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="29038826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 03:38:20 -0700
X-CSE-ConnectionGUID: s6/CyCvhSPy2aJxepqg0dg==
X-CSE-MsgGUID: O2wwoNH0SsWgIoxZYnqIQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="61481684"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
 by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:38:14 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Date: Mon, 13 May 2024 16:08:01 +0530
Message-Id: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715596703; x=1747132703;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PnSf5QSmfUU+CTS4QGYrbzhcMfqC24X3tCBFndJHIx8=;
 b=MnlKMUdpZy5qfRG3DZXHx5+PbeAib5YZYYWc7RI3/VZavJeW7ZSGTwmL
 SeLwxiWdmS3zpALPHibfx8r73+sjM37WW53i+jGnPXA8SG8KyTJ+fLtwn
 fBVbHsMHzxcbjd1CFHuZ1R574ZCg1+K4Hw8ajx8T0U/m6HLaXUa+qD/8w
 TT+Rg/tsnVME03bOYQ4CPydnlpjzUJJ7dAlPcnkinaQjlUO/Zq+uLahAL
 BSzlhwV0h9ZaLzng5vfhNDET/NrpCz9cGkrTBxHgLfSEtkfWO6dH3vnLO
 KxzoVMuz4cptOd7up8p80PpFly1LC+2N+mVpwJq9sWZc1Wdv9rM85RGs0
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MnlKMUdp
Subject: [Intel-wired-lan] [PATCH v8 00/12] Add support for Intel PPS
 Generator
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
Cc: christopher.s.hall@intel.com, subramanian.mohan@intel.com,
 lakshmi.sowjanya.d@intel.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, pandith.n@intel.com, x86@kernel.org,
 eddie.dong@intel.com, linux-sound@vger.kernel.org,
 alexandre.torgue@foss.st.com, peter.hilber@opensynergy.com,
 joabreu@synopsys.com, intel-wired-lan@lists.osuosl.org,
 mcoquelin.stm32@gmail.com, thejesh.reddy.t.r@intel.com, perex@perex.cz,
 anthony.l.nguyen@intel.com, andriy.shevchenko@linux.intel.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The goal of the PPS (Pulse Per Second) hardware/software is to generate a
signal from the system on a wire so that some third-party hardware can
observe that signal and judge how close the system's time is to another
system or piece of hardware.

Existing methods (like parallel ports) require software to flip a bit at
just the right time to create a PPS signal. Many things can prevent
software from doing this precisely. This (Timed I/O) method is better
because software only "arms" the hardware in advance and then depends on
the hardware to "fire" and flip the signal at just the right time.

To generate a PPS signal with this new hardware, the kernel wakes up
twice a second, once for 1->0 edge and other for the 0->1 edge. It does
this shortly (~10ms) before the actual change in the signal needs to be
made. It computes the TSC value at which edge will happen, convert to a
value hardware understands and program this value to Timed I/O hardware.
The actual edge transition happens without any further action from the
kernel.

The result here is a signal coming out of the system that is roughly
1,000 times more accurate than the old methods. If the system is heavily
loaded, the difference in accuracy is larger in old methods.

Application Interface:
The API to use Timed I/O is very simple. It is enabled and disabled by
writing a '1' or '0' value to the sysfs enable attribute associated with
the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
device. When enabled, a pulse-per-second (PPS) synchronized with the
system clock is continuously produced on the Timed I/O pin, otherwise it
is pulled low.

The Timed I/O signal on the motherboard is enabled in the BIOS setup.
Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>

References:
https://en.wikipedia.org/wiki/Pulse-per-second_signal
https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
https://youtu.be/JLUTT-lrDqw

Patch 1 adds base clock properties in clocksource structure
Patch 2 updates tsc, art values in the base clock structure
Patch 3 - 7 removes reference to convert_art_to_tsc function across
drivers
Patch 8 removes the convert art to tsc functions which are no longer
used
Patch 9 adds function to convert realtime to base clock
Patch 10 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 11 documentation and usage of the pps tio generator module.
Patch 12 includes documentation for sysfs interface.

Please help to review the changes.

Thanks in advance,
Sowjanya

Changes from v2:
 - Split patch 1 to remove the functions in later stages.
 - Include required headers in pps_gen_tio.

Changes from v3:
 - Corrections in Documentation.
 - Introducing non-RFC version of the patch series.

Changes from v4:
 - Setting id in ice_ptp
 - Modified conversion logic in convert_base_to_cs.
 - Included the usage of the APIs in the commit message of 2nd patch.

Changes from v5:
 - Change nsecs variable to use_nsecs.
 - Change order of 1&2 patches and modify the commit message.
 - Add sysfs abi file entry in MAINTAINERS file.
 - Add check to find if any event is missed and disable hardware
   accordingly.

Changes from v6:
 - Split patch 1 into 1&2 patches.
 - Add check for overflow in convert_ns_to_cs().
 - Refine commit messages.

Changes from v7:
 - Split the if condition and return error if current time exceeds
   expire time.
 - Update kernel version and month in ABI file.

Lakshmi Sowjanya D (7):
  timekeeping: Add base clock properties in clocksource structure
  x86/tsc: Update tsc/art values in the base clock structure
  x86/tsc: Remove art to tsc conversion functions which are obsolete
  timekeeping: Add function to convert realtime to base clock
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

Thomas Gleixner (5):
  e1000e: remove convert_art_to_tsc()
  igc: remove convert_art_ns_to_tsc()
  stmmac: intel: remove convert_art_to_tsc()
  ALSA: hda: remove convert_art_to_tsc()
  ice/ptp: remove convert_art_to_tsc()

 .../ABI/testing/sysfs-platform-pps-tio        |   7 +
 Documentation/driver-api/pps.rst              |  22 ++
 MAINTAINERS                                   |   1 +
 arch/x86/include/asm/tsc.h                    |   3 -
 arch/x86/kernel/tsc.c                         |  92 ++-----
 drivers/net/ethernet/intel/e1000e/ptp.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |   6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |   3 +-
 drivers/pps/generators/Kconfig                |  16 ++
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 259 ++++++++++++++++++
 include/linux/clocksource.h                   |  27 ++
 include/linux/clocksource_ids.h               |   1 +
 include/linux/timekeeping.h                   |   6 +
 kernel/time/timekeeping.c                     | 124 ++++++++-
 sound/pci/hda/hda_controller.c                |   3 +-
 17 files changed, 495 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3

