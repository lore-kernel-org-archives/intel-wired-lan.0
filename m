Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF6606BA43
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rGiigySu;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lbaC94BG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43532606D0;
	Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azXySx2vKOmr; Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10B0A60661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633719;
	b=k710fiJuq8r63H3TWDiROvLOZlFRngW7IIFBPQ7HQ/YXsgi8XXkNzVWJ2aiRqTQ58Rnn
	 Y5LrMQhmfbXaUgo4TeBhxeFl3yC6yRc/kC+Ql7lgeA16tt3oHKBAGgJbbaejW0cxmMKhD
	 5oXiSsPgHAVdSEoZiRmtqmfXMy16rqh0iCFcRXWzPyNXvfomnygex2JMga59rcKKcwyag
	 koV8pPz8fZl/jLHqqen8yEOrKOrvGlonb5RrMD2/GcAEMSQ87wBLQqwCayV8gFJbEt3CH
	 0f7zAHVnkQkJoLG+SVFH8Nkj7I2iMzFFdtr8ORSVYRVNVLvAbEHvdoIP07gppxV5+uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8UMCvmIrYcfQbfHBAmpzjnogsRSDYxj5tv1KHY5Wxks=;
	b=Zeb0eNwxzdPP0uujAIbKrEx17Y6OBYjJYEFMAW+f/AcxCcuPShfWx6tEczVXy4A9NnoU
	 eGlxjaS0RlDvzdT5J/ip6WXTj8rE3lIGcU+bTIZglJzGPCiHEUFe+MJcn5LVgUqNk17ar
	 cEyqNtjwIHnu5qtIxFth15qF1Yf5OeWmM8wPzyWelHqK+N3CLy/tef0TvCcSNBAMqZb6Y
	 j2r2fjQaadexpJfA+3volcyrfYfIqbtmDaDQa2zg9ymN/2erIwAvvk/qbeVn/nKViQcEA
	 RoB+WwxZTruCGl0/2yHqGjvO722OYOzJ5p94lyKzbHTuchrkEudZ6fOkG9zfK04TEqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793633719;
	bh=8UMCvmIrYcfQbfHBAmpzjnogsRSDYxj5tv1KHY5Wxks=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rGiigySu9ffME8L3wfqGXXQX5+yszCDWAJbfTTGO8r6cPBMLUeFEw7a58w/iALaM4
	 rPav7iipJaJQt3Xj9n2HcE4gOjQjDpyT7Q2DLUs1W7D3W23+pv8uPK8ivX8/+xb4io
	 AyAag3e1JaPLtnssbLSJPAKIUIlDU1EBEimfN1AZ8VpnsF/tiVwtxhwCJqNjGh40PB
	 iSLZ8p4iAloIJlCUC605uwUtlj8Mn1hbew7yRiqaxuwrRs5prfe/n6yEMZklA6Ye99
	 8w4FD5ZQsL0S2uzUSMVM4dvvSmJoBD32k4J5ICn3/Ih/C/CDqDdIFFB66gObWT2i1Y
	 IeMqIYhmhgb+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10B0A60661;
	Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71C3F411
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57155406B3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRJZTnP_AmZD for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 15:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B08E540695
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633716;
 b=CRbsWFH7y764afwmiSYjCL3dbzET00tToEqtYS0SZJQOM+C3frarQRmTnx9Rvp83mzNB
 uS51IOwTojf5giD7B5wOZO2qCanXeXdnp/bJLXj2kY/pYqa0LyNHvK9yVqC3wYWE+Ob4S
 GhOImWHRtBgVZMP7wseD20uxhl6wIggkX7m9Hw1/cQgX5J/UaqcrDdeKgxucdLvR3+2iE
 m1sfIYdFZPcxrmGZJTjzwNJvL9FU0XH9Zhq5LucUgTr5m03+bjlleXxiLLjq79TTYEQE2
 4AjtCzPXVkQr1AsS7MgFT2YOMREiEjU1PtGZDpCcMY9VTs00c3ZJR0I1R32QKQwt+HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633716;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8UMCvmIrYcfQbfHBAmpzjnogsRSDYxj5tv1KHY5Wxks=;
 b=jmv5GKoufwTP55HTWWTpzcBHS55Wq56Eswlisnj3155YpEhHBYakio1X+0AI2R+XW+c4
 pBLIdlosX996ZLY5EpAO50nVrDAfLDDpf6pIeIhP+RlKr/mVRW6quJes35Yc4kAPX/a0J
 Q669VxPpGSoiCq4vdAfVSzZzCFyBQqO9DgFjAQc8k6V+VOq+Br1xShm/SZU2DrOloC04x
 sbHfyRc0aqNAxi08/zF29TobYKgHNtUZxRftOu1SzM8SuRBicQaeUO0kSTSZvSTU1LlXz
 QWP6G8nJw7kE4PXJxTPG2vorHQ3POLfHYheGpH1JOlf9M7KVU06WYDZeidKDjJOv4rA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lbaC94BG; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lbaC94BG
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B08E540695
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633717; x=1825169717;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=114Eb1e2wd034eH6NHBrD+HODBSKf0u8ltTsmLb3DMc=;
 b=lbaC94BG3DHHP07a8JoNTSaCCxCa09kWw836OpK/K2yszqMFLRntB+2G
 p3Yb995j29EomAZS7pTLuD38uE2kYJKL3DGQock0Uw28dsvptoXm55Bl5
 t6BA2+u/dRy4j5V/ahsaC9rmtt3fquGqo1lkIE61GunD2Vn9YhssBm/F0
 BLeIiehkc5iOyaJBdgIYEkP8iqyyyKacrrjUrIXNzIc3Mm1DnglxHgjrH
 E579womhL+VSTspD5f0iOKZ5dAHmTZVYRWxCVI7oO75dEn8tfEGv72JPi
 XjtYIckB541Fu3J6Y6D+bPFW1gOnVbButVemm9AdRr/rYOUlDjp4UK6Ms g==;
X-CSE-ConnectionGUID: NgnYmHP4RJGf/jj07C2Xng==
X-CSE-MsgGUID: EIjRlNUYQoCeV9Z+CItXPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2210848"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210848"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:14 -0800
X-CSE-ConnectionGUID: WQmeP4bXR5WGAI9Cf9NqUg==
X-CSE-MsgGUID: Z9r+PgSjTJWfND2z6zflxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5999746"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 07:35:14 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v1 0/4] docs: fix minor issues with Flow Director
 flow types
Date: Mon,  2 Nov 2026 16:35:07 +0100
Message-ID: <20261102153512.1601855-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Flow Director sections of the i40e, ice and ixgbe docs are stale.
The examples use ip4 where the driver needs tcp4, and the flow type
lists do not match what the drivers accept. There seems to be no docs
for what a raw ip4 or ip6 flow actually matches, and the semantics are
confusing to newcomers. Document it.

Patches 1 and 2 update the i40e docs: the first lists the flow types
the driver accepts, the second documents what the raw ip4/ip6 flows
match and fixes the examples. Patch 3 does the same for ice. Patch 4
documents the raw ip4 match on ixgbe.

Docs only, no code changes.

Aleksandr Loktionov (4):
  i40e: list accepted Flow Director flow types
  i40e: fix raw ip4/ip6 flow match docs
  ice: fix raw ip4/ip6 flow match docs
  ixgbe: document raw ip4 flow match

 .../device_drivers/ethernet/intel/i40e.rst    | 37 +++++++++-----
 .../device_drivers/ethernet/intel/ice.rst     | 41 ++++++++++-----
 .../device_drivers/ethernet/intel/ixgbe.rst   | 54 ++++++++++++++++---
 3 files changed, 99 insertions(+), 33 deletions(-)

-- 
2.56.0
