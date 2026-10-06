Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A8ACA5FFF
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C80F80BBD;
	Tue,  6 Oct 2026 10:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgeDdXS7M2b7; Tue,  6 Oct 2026 10:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 27D9280BB2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791281159;
	b=jcr6jQ1sDMuD9caDCsz+AEJ9t5A/g9oxFBdW420P0LQ/wEmOuxUczJLYuBDcqxY5zAa8
	 QRbx/W0UrfLq2WWOEPM0qM2/E8fwhjWbhmUwvUVhM2KP3l+XVttJLKi+kp0rBSaVIe/gh
	 Iuin0RFxnjabTLjQoraBRsGgYkH1vW1fuPs5QEmyb33Cx3o9rLJbnqV6E8whYA9TEA0HI
	 VXAP+n8XHKEetzb/lN4LZYpc+TttdRFih6JEg/8jZ1Stgfme9cEjHWoVIungzkhP5Ld+B
	 Xhts8opM5RZIEtLERD8xHvRhd2wjWqRYaE8tOJwrp+bxzBg5cCc1cvHqrq+Deq37j9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791281159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yUrtc8tbVuq8QvtAwZaFWgSF2UpVlSRSom6YbQaQiA=;
	b=YZ27PDJ64YyspxTZAfF8V71+VhTCDO/ZPI1BU77+5Ev1aWjSBGSDAYLxXQcmDDLRK75z
	 aII0RcNSoU/H8ZG+X49mcnNMpYn7mVKbD+6FqT4cqcvlxC2rhZNGE4co11mFPZRkQvfxz
	 VPI2bxwvpmSthsOjGWmdgPeGw9lgwxuKQ9f03OOppg+OnCF7GrgX9V6eAp4Fud0HeY1ro
	 4R+v1Xl70umUx8Jzoe6gemP2AoiwmI/vYza4Kt90AAEHMxsLXvuzotNdjCTNtYFBngBex
	 13eh7AHYX40fmbf9RLSt31BwCE++Ki8+kIPIWBjnlOBomJFNTg9MxGE8nxATL7yhqqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791281159;
	bh=6yUrtc8tbVuq8QvtAwZaFWgSF2UpVlSRSom6YbQaQiA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YHRcJm8BauSQLwxlC3zASk0Wf3homdiKvAldIuJO7AcO5D2dl6tCMh6RA9wjbGF48
	 FbSU30pFUNyBebAlwp79ztdsNNlUs6ueMMmx75uEpSJJnRyzh4qWzpD0YdSEYFFINq
	 eYMDHENOymbiP/4MjIHMZsBuoQ9zImbUKwhwxSskMLIH/BX+Ay8/hS9OwQu5Lmr6I3
	 XOY8WP/Nh7GG63VqfRZJ+Ixm9/+rlhgc0KBNM6CLg8b3IKGpGhnD7H9r6VMX8bqK47
	 2Ti2GhTHUkxOZjCvETJxjhvRK8AXcm75kx2AYUMa+sPJ/i1ukcmIXAVIxRgytg/L/S
	 ydp94QurKi+oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27D9280BB2;
	Tue,  6 Oct 2026 10:05:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBA5F32F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADD39605D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNHF1q4YuQhJ for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:45:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 79468605CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791279936;
 b=dHerK/QnOcm/Uin//4yb1rZbW7X97LzD8Pvrqb8aOXHMLRa3YD7iSMP6KxmM785WaZq0
 61ku5GAwAlKcVdeoBm0UunHu2HiD6dqlkT7xY3olgM9DPNv+5BNZJ2vjvSmcxZcpk52i8
 EFlP99QpQ5pCAJyO1R8E1skV7Ft1KjuWj5+1XSF6pSxBqMXeV/1dPvD52tS8hfB1TwQ36
 P2O5AihrcSIDFAksg4MfKBkZvqZXs9455AgatFlkowxmrFSG7o9c/Veg54igKJkv4zddQ
 dpto8Tg3v5ZgurxSM+pyyBV/tegOaIDB+2buLVXUUs5fkphr/HMkgd+SZxRWCe4h01w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791279936;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=6yUrtc8tbVuq8QvtAwZaFWgSF2UpVlSRSom6YbQaQiA=;
 b=ihv9wPKqRPL9+uwEpH+HNl4UINgcTeI8vfahBOBVdPkXtC3ME6ee4XtYY3mF1OQ0eaFT
 cJujDvdT1mnFB/mfzz16JB8KOOkZEcKw6SNnvrUgpcJ3vN/3AC+ws9HTGzczyol0yO+n8
 5MgsehHD/xcrCWSSkOwAyNvre+CaPY1FVUAETKnSAxcf0k2NdLPjHMt8wg8iaJd/MJxKC
 +RT9OkFLUCqK1ZT6OmFmTjqtDFV8kp3R7rBKB3LYbY9qkBT84hmzY+PXelspqeLNcel2/
 XEoZeCKn6H5GB3xeDMoOzRJoqwUTzoXcSgpNa1+MhNHyi9L8EuiPzVqtT45FJwIg8kA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c+PLBKR8; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c+PLBKR8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79468605CB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279937; x=1822815937;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0wbKZ456aJ+DOkbVkm3rG6IFaJYldv0POkGrTP7TvGU=;
 b=c+PLBKR81JqmOnPv/VPwLWXcRuXf/ztDJvPD/dQZDcflnCFzauHgP1IT
 YiTKm8BfMKOCf9MJbHztkRzG0PAlk1JCSi9ejD1cQ4SoBptrsDqQcKFPF
 EPqqqZfGjlVnIwZNwZLM88dttU0WEFGpBYEVObnbJ4QeomYwvw6P+po2M
 oC1Ec5uszsRKjNV22/olpXHlU2PvYVpSoxvjvjPHbHRuMGc0KVmYED3VY
 /lVbgexjJJPw+CbSOocg85fdeMKMqiXFDRv0o+4blA1/m7J3TVw1Oik39
 zkaEBp0IgmcVG0/+VfZIGAttGVeGqOZ2Y+wBn/Wc6ZWvjfbmuysW8mA3q w==;
X-CSE-ConnectionGUID: P3aewSrLTLu/KfeUVy1qvw==
X-CSE-MsgGUID: bQ7VBQckRJmtoi3ztRVpQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3206"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3206"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:45:36 -0700
X-CSE-ConnectionGUID: h+FVFeFYSqSemmVgBu7RlQ==
X-CSE-MsgGUID: VoaDZpOcSy2KGWUWIlMw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280350275"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 02:45:35 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net,
 iwl-next v3 0/5] ixgbe: fix FCoE/XDP issues and PCI reset handling
Date: Tue,  6 Oct 2026 09:45:29 +0000
Message-ID: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
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

This series fixes several ixgbe error and reset codepaths.

The first three patches are prerequisite fixes that make sure that
the driver does not access hardware during the reset time when it
is unavailable. These add the required availability checks etc.

The final patch adds missing handlers for PCI function reset through sysfs
in the manner that is safe for ixgbe. It implements the PCI reset prepare
and completion callbacks to quiesce and reinitialize the adapter. This
prevents TX queue timeouts and other related problems caused by
inconsistent hardware state after a sysfs-triggered PCI reset.

Previous version: 
https://lore.kernel.org/intel-wired-lan/20260922113558.2288111-1-sergey.temerkhanov@intel.com/
v1->v2: Almost complete rework of the series to ensure safe
	reset procedure
v2->v3: Split the netdev availability check refactoring into
	main and FCoE patches, tag -net and -next patches separately

Sergey Temerkhanov (5):
  ixgbe: Refactor device operations to check whether netdev is available
  ixgbe: Defer FCoE queue rebuild while netdev is unavailable
  ixgbe: Fix FCoE refcount taking for unsupported adapters
  ixgbe: Restore previous XDP program on ixgbe_setup_tc() failure
  ixgbe: Implement PCI reset handler

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   6 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  42 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 193 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   4 +-
 7 files changed, 262 insertions(+), 31 deletions(-)

-- 
2.53.0

