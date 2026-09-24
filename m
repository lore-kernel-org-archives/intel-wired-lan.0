Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA974C9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66E8E40CAA;
	Thu, 24 Sep 2026 12:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tq7JBKQeCyiw; Thu, 24 Sep 2026 12:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 955AB40CD1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254763;
	b=FAsmuGkdeHGczKhsiGlImWRb89d6DoxC8nMT73bNXNf41XIXnTOP+ByVCqcASrOD52rz
	 fdzYWkDjdE7rR1Xkk7rmUZhXWQUWxGLvyA+W7wCoTZGmv030HZ21ZM9TA4L27h8kV6MdC
	 1kIpRGUNvQMmrYLBfz0jMqTLqC9uuOZW8vmEBh+6K314QOU4cPXG3/NahI6YCz4657Aqs
	 tkYka3kfG4f+gd+nOAIndwgAYDmO9P6G2ulWQ9c+H0mEcFK2NaWoy9yaTFuyAYh8iuXSl
	 cjupt5eeiFHdLXx1zxI/fBwnAlsfpJnfZpAfgsOdeD3ppzmAVXEsfjZjiA/IwisVPsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ftg7FRtItBrVqmXmDoXOWRgQvR91j9e7tSuZDXftqMU=;
	b=OcgDPxglONgzrT22iN1hZdRABD8lWNyJdZcHXlPPF41CeGmd9BhDIna7+uZ6e2U2lOp7
	 xL48zGXjqc0T/xNLNqQOsTaqeOSBetopUm8ZlDFOrGcdOKbwsjPr4gvMu/v6Eq45C0Jer
	 TjGTLsNanuXqyRebSkMVytPR8YgTRmjbyREcq6QhXF/t9WdMxy+gXX4w6D8fTBHHxs6ua
	 YFaRsbI10WbqGwtapL/xEN2sSMHzAY19vOWh9u0zFf25JXs9JpzqYZnIyuwJU9/qgiSTI
	 oBGR9OTtlYd79Q65WNRfkLBGEfscpXiPmWZp/WavgloVtxwG09YJUf2mOIQIT4hLF0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254763;
	bh=Ftg7FRtItBrVqmXmDoXOWRgQvR91j9e7tSuZDXftqMU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bIc1Qg9PMZGMVkzlQ86c2LEMCeuMshpVAdR8VPubwepDjqdYG4CFFI7HUAAejbIYn
	 DHtaXJnt9aHcHh+ROYMfL1NHWh3wXulwSOBhnV4RdJAiggh7A2HPohN+uS6rU7xf9g
	 jHYkc4FjNx1hyhgZymDoGrplBSklLozWvm8ujKivgyQe81vitcUbJIKBTwgcn9W0pJ
	 MZ1Z8IUa4mtI2A/zorbQlECej413z666tRcV+uZSUL9vNpmxONdpSxsmyluQd9Vclp
	 dkkAaucItJ38AxhN+G77mhNKv36RMi92Pm3zl/sJKuk0mUxhY7SvI8FodHvFzfb+f3
	 nuQGjza5aa4aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 955AB40CD1;
	Thu, 24 Sep 2026 12:59:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F7E194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6281760824
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKX7QWGBBHtj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DA9E60807
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254759;
 b=KaUhyZnCE5R45ZsMWeGhnv8enPsubMmyqbXBIWS3uWdgJAzeqxM+Ehsur52w2JzN3a7D
 2gP2QaomY8812IyADJU6KmgViHRyjcwjo4r3jE3KZmy2QuJfCZnCpcG4xYNDgBLwliKqK
 An9ffa5OG9nWridw/51RNd1ULgl78tG+Pvg7L+0AdpFP52umQeyv144nPkshN0FCiWKQU
 i44sWm6FAgGlBYZKMOaAIv38m6YJHRObSd5KWsRFMPBca3pXdKtjAVgJVQDL4maeLeEHV
 humL0Nob1bE7qXCdfSvKTpLF6ZSh2a62qbD4x38FCQB9qozd0q4mQ6QKKkdWS+Z+OpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254759;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Ftg7FRtItBrVqmXmDoXOWRgQvR91j9e7tSuZDXftqMU=;
 b=J/fUBfJeVcY5FM78coGUKacn7IdovGCOizjPGb0rtzf0ttUU+MBmuwEJDjeVA/zuQVE2
 NmWhvzbFOIhQv5q5TkOJQV2NUcxrQ/SRDzWxN658AhB5JbgN7etC/N6lctWKoUppfmTEZ
 favroLiq8OHfedAUZWlvX8EmLC6C33obW57jwie3fPu2pftm+17DNPUVOUFIxGU/R8eYd
 jLYtHdJLnYaSu/tU+RrEvAeDkqRES826AX2TMf573Vu/0n05RHlQTz/htdrnpq0dxYOEB
 fG9K4F6//N1SOXs15cWEPgY+hwMKA9YoCQHXCKe/2ZicPQ1bWbnpX50TRGRMIS8d6LQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ay93KVwz; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ay93KVwz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DA9E60807
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254759; x=1821790759;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5QWVtlFUpytddrVPpZoEcE4zpXfuf6MyswnZ4U1BsKg=;
 b=ay93KVwzRc5fYUbbh3OgI8dYilhoTp/ng4QR/qf5VWL2o0cPncDgsRHV
 WprW7hFlYOQJJPLFn/W0N0MDe66XnULl8C4RhUeH//eVSA4vxgQdJNsct
 UliV7gVRNQET1vIlwbv12BHNh917fHOd2kg3HbSGpRiJmAFK4vU1tmH8/
 +8JcFDJcjNVoH5qrgIHWFpbxYi2ump7DKAO+TIWaS9dCLozMzpoorH4nl
 waLGnXaMaKtmmaQ7QHRQ9lQrPhRNSi8WYi6070Oy3Kuj4xyTIW78IfyOu
 xx2/SM1Gd4lidNdA1e0akea9RSnMSt0EW85PSmQI6NC75d5bNmNJ8NaFf g==;
X-CSE-ConnectionGUID: wAwAeiyeTj+wNRnYyrZ2ig==
X-CSE-MsgGUID: qyspUrm+ScaFUENdQoTM2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249208"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249208"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:18 -0700
X-CSE-ConnectionGUID: BD8xpVliR5Se0XDy65El+w==
X-CSE-MsgGUID: n2S/Cwm3StWqNl6EfhVr6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934422"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:17 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v5 0/8] Rework usage of the control PF pointer in
 struct ice_adapter
Date: Thu, 24 Sep 2026 12:59:08 +0000
Message-ID: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
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

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260831/056612.html

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes
v3->v4: Add the rw_semaphore to protect the ctrl_pf
v4->v5: Split patches into smaller self-contained parts, tighten potential race
        condition windows, annotate RCU-related code

Sergey Temerkhanov (8):
  ice: Unlink the PTP port before destroying its ps_lock
  ice: Protect the control PF pointer with RCU and a rwsem
  ice: Cache struct ice_hw pointer for split register reads
  ice: Reject PTP access without a control PF
  ice: Clear the control PF pointer when the control PF is removed
  ice: Document control PF lock ordering
  ice: Annotate PTP control PF lock handoff
  ice: Release control PF lock before RCU wait

 drivers/net/ethernet/intel/ice/ice.h          |  42 +++-
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  17 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 179 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  77 ++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    |  20 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |   5 +-
 10 files changed, 283 insertions(+), 80 deletions(-)

-- 
2.53.0

