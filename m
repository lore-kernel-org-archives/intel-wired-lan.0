Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5180606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CV4QthVl;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FQTnEpbF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79612605F3;
	Mon,  2 Nov 2026 11:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qO-llcDDoUVU; Mon,  2 Nov 2026 11:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B533E6068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793618224;
	b=dvfYcgRzGQ/yzrEuPwIpiK1jaMcjNytkw7wj1rNdffF8wATlx/7T9H4pFZZgYtZMCc9E
	 MOOJIJfISpKsrR/+7qMrfrmoRk3Jus4EgYxkxhCR/3oz3uUGL20Ny8mlu77j0gRB5Y0OV
	 Cx9q3T4fUNv4a0fWxQfR18CiPKQ0Iipq/2Gm7+K50MNxJLbszHu2Iur1gP7w3cBsXF0zR
	 khzRuIaPzoyU6THO6O1Hd0NxmRyLYMOuqMb6IWWQeCuq5Ag3DecpByfwoXA7MLoDXm/Q9
	 chyqhT6zxr3wB6k8YZBPi153luB7Gw3NN1/yFTHQ7sUyptO7ARBG/+9ydVyKW+9Guwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793618224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jwhHZjp0a9JhCPgd1y/e7wXjR1NgfzKai26Rodx1eVA=;
	b=pwlz2qzzNRAaHGAkE+XCiRUdYB/0snaz1Z+qIRv18G3hIigOmIe1uWXuP1VOiNwJBE9D
	 8pCUF33xDjHbit8kStE7HgyZwgBmw4RCfFu0BrY2SAZ2rFEOdkWx32A+Ay5UDM24Aw1gO
	 EiRONW/+WtpW65aViofl1elRlNAicg4aeslD0EzTdZE6Iy6JV4/zWr2UlvblUV0c+srB+
	 PtA4lNeCLmi2Y1YbsEZtSyrbifweG5Rm3eHohb79istzX6q3bLvet1P23Q91aIztZ0MoV
	 CJ7W7KC2gBJmoEYXTNKxxSOntGpETXFC2cCHHiu36PImPA1XqKrtNML5XJy1VKJ4TIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793618224;
	bh=jwhHZjp0a9JhCPgd1y/e7wXjR1NgfzKai26Rodx1eVA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CV4QthVlgA00lB9cpgpRGt9bbXZ57JEAEAWFHjYn5eVbyfN1pNo0GuF4PupycB1k5
	 AWoOqR2WD6NL4jpFBPR8fPzHLeRXp5z1XwYMsdw3SoeoeSoV9QwWgJQ+xZnOBdUOY3
	 ZzMHdAmZ+jyORxbiXVOO1mEULj0iBpLWd2QybkF2LYHrPuYUvjhq713Y9pkP+V9ZK+
	 qVluY8MUGKfitU03o54u5kx4ZfqgfezJNCeEouwQM7vzDCzQnMpa1csZqWfAR8bZGR
	 vnxrcVlwCz24gFB3+k4R0itQXEee95x/FT1ipUo3f+ygaS7AP9CW7sRx2cvBDtXLYA
	 BdLPGl9CbHTGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B533E6068B;
	Mon,  2 Nov 2026 11:17:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C5BF4BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D9C480F58
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQe6tHeOfIDK for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 11:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 007D180D39
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793618222;
 b=tATqtTNSldbxe6n7iBA2cQBKHd8vSjA7tDTLqC2i0dwgOxuWDC67XgIBkh1WB2HjkuiM
 RP8VIYY2QUEr2UtzmktLKpkS4GNpMnEwXL2XDe0BTlCsuGpIsbtne5Gd+Ln7PR0s7sSyW
 77GtjvRQ+N5ocad+Yt6mNDgEGrciCNk85ZzclsfCDLggYwIEbpzb2kw8c5F7ChQRPjXEn
 VdujgcTROMoOMmStpViGiuksje+0DWPT7ULRnMo6sAGc/di/CP8eORW62T1N/W5PxPTWj
 ZNVWDL1DqXpjPv1y9dmtyCT4Gd4BilqgHJ6moRWW6xOFWFO1HuFvVYDQFGsz1GQXBxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793618222;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=jwhHZjp0a9JhCPgd1y/e7wXjR1NgfzKai26Rodx1eVA=;
 b=OH2Xky/uwEejW3kdpbguEP5ohEVZnRMvXnSabadt3cNKRIEtxgJQuSAC7jrettvxphUs
 1HnjjWSI8KG5MP6KjX0Gm+755guZ1Ud2Nrxlb9/bPjN1pm5AvQjhp6t7c7GEyawcIz757
 mnDQX3i9KNM7vjPk5gCwU45pv0oWAsNh6j9QgYPkQ4cbNyA7JkFoosrXzJ5E31Z1DJWOv
 MNyUURvPOyMRXo5JUaBUNau637+csKSJDU6wgQAuBVmBiU8hCSUkU11n5PcO40fYK11qT
 AluuREsR+Y147b5nw9S/CrD0FFy/iudS+/MG9WbbuAH0BkVF8CjlbS4XsOgsZOe3QCQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FQTnEpbF; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FQTnEpbF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 007D180D39
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793618222; x=1825154222;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/C+JGEBfRdPiGhY98Aenky2vfWXBoQRaaxGCCGVkaI8=;
 b=FQTnEpbFh4D3ur1K+qX54FGgLhkCynairqMvQrC88sa4ofcvuwY9sX1I
 XZ7kok7NX8l/hogfEKW3O13tG374Rc8BmUBsehjw2achy8C06NnL06eYD
 nHWeppuAIInHQk8HsjK4j3ZoEonYzr4I2cnNrpAB628BLhaHSG+ocXIM+
 rQYVNh08yr1TAqfM18A+PVerFCl5ZmgFTBR9P8/JzlvD7JTh5rp4R4nc0
 uC7qsY6gh9sWu91ifxN17DtHonsi7AYzPU7zbU2Uhrw7T+MqPfdWTNO+A
 EVvctVMvRXY2Xo0xG0GqQh0Q1OC+EI6CCPEDeZKVTzZ3XG6ygw8xISm6a w==;
X-CSE-ConnectionGUID: R1y1A91FSJ+YpTuV+SarmA==
X-CSE-MsgGUID: OeayxHPFRo6sAyhVGTcWeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2199283"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2199283"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 03:17:00 -0800
X-CSE-ConnectionGUID: 1OFrseWYTzeO2hqemdWCZw==
X-CSE-MsgGUID: zmOvRxezTDaYffWZwGXlFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7872825"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 03:16:54 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, sreedevi.joshi@intel.com
Subject: [PATCH iwl-next 0/2] idpf: add direct access for PHC control
Date: Mon,  2 Nov 2026 12:07:09 +0100
Message-ID: <20261102110717.77800-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IDPF allows to access the clock through virtchnl messages, or directly,
through PCI BAR registers. Registers offsets are negotiated with the
Control Plane during driver initialization process.

This series adds support for the direct mode, in which the main timer is
disciplined and the Tx timestamps are read straight from the BAR
registers, instead of sending a virtchnl message to the Control Plane.

Patch 1 adds the direct access to discipline the main timer.

Patch 2 adds the direct readout of the Tx timestamps. The latches are
collected by a timer that runs for as long as the Tx timestamping is
enabled, so no register access is added to the Tx and the Tx completion
paths. Latches whose timestamp does not show up within 500 ms are
reclaimed and counted as lost in the HW timestamping statistics.

Przemyslaw Korba (2):
  idpf: add direct access to discipline the main timer
  idpf: add direct Tx timestamp readout

 drivers/net/ethernet/intel/idpf/idpf.h        |   6 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   9 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   8 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 597 ++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 124 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  24 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  12 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 191 +++++-
 include/linux/net/intel/virtchnl2.h           |   6 +-
 10 files changed, 843 insertions(+), 137 deletions(-)

-- 
2.47.3

