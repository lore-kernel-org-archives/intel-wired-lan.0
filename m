Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB7606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7VKJKQeh;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nuntu5qy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83CB3606C6;
	Wed,  4 Nov 2026 00:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehyXdZPKCGic; Wed,  4 Nov 2026 00:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7136E605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793751141;
	b=Zfk7w+5W4Bx6QWq4bgMWwv7WtAU/1y49In+EqLJ5AbE6krgQY/ejB4fdFHFAPg2NXo0F
	 IanMJyiUBG26+emBbZtQWagif9oYBuWR1JXAxJufvk1C1AzvlNIR8ondsCv4RMr9Q3ttM
	 rx9MRXyT85Xx9+AbCoIQFj2gCEH1ROULK3opiBmR2xoEh2/pgr1itM6zrwF+6Jhi+eDsC
	 aCVW829lJu99xW0wZWGHUESmy+AMpp8cB924od0Dpyt+fuAXsm2yXsb9QSI1WzjVlAAwQ
	 BsuGPhmDcEisDmddhHyKRhGnIRU/PmiWONqyPE/ozh0atkbE5izAiP7MxCxtWOLBq7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793751141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h+J6PRP0yWj/FLrdYopJqvXNhxuMc4p4xqFM5kKG8RM=;
	b=mvX6kwMkkk8CS9ObCjHq96nUO8oEJ4PZipsU1xPRp4PS0gr/YhEsx0X2mDpQOWOIKf/v
	 9UXSUFIVcx6WdjcIImmo4EXF7YN+Px9vRDwmolAlWvLznnuEGUL0M4Q7cQ7DQGSvGjvgg
	 of48gOm6jT8BcfOw7We7Jl5b9SRQqgUruDgc3uA/LMy5RglBtPx/8TgGA8BliErmx9JbU
	 I0rIu7NgPv8Cqi4rtzjZ+VC8z0oEUdxGC8euap/0JL3tGNTwKgvMaFfcu8nyL4QMf2eX/
	 JDkpFa2Zcw7Ndp3pdMGiymjIhVMqrCuK1yfVA/kaMfcxdmgbI4mtmtXiIHjMwJSd9LA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793751141;
	bh=h+J6PRP0yWj/FLrdYopJqvXNhxuMc4p4xqFM5kKG8RM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7VKJKQeh4zRsGjWE/si10lLzxeiBQOrf/SNRjSKvN3+ilB07AiMPpZdxdxUoLQqvO
	 hliuDd+cyJ6ijSC89kfHZUamGM5bto8kW1VxfNBT7wibPdskGobjAvdk2FskxUorzo
	 mx6+YV98tbzVAGYGQuzYopDH4zqoAiwbJe1Eu1MQVJB3sZs2aMpyAlRBMB1bc7JOAq
	 HRlOnIop/VzoEAtkixpv/ymPLJmmeJonYgVWbF6bsIbTJ6pYlvJMbM2OPKxvkss7qZ
	 6W9U489cqA0wD+TgdONGXo/qs11Z8eqWhONfG0mvdNufy2Bslc8ifZ3Wj/BO2PhSSK
	 OnByhBSz4bRmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7136E605EB;
	Wed,  4 Nov 2026 00:12:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1A212AC
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B37B340048
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqfZisKvZp7N for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 00:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BC93C40080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793751139;
 b=KeEYYc2f70rH2xzfa1T7uyQg8foCXF/ysjKpncG3XsY7xMdqntmYcU2AgNsLTzn2OcYi
 qN7XKjUDHBc8LHiig4yvEdeidM62VxxCJr90yeMoPq1c/RogyhzbpzKL2HDjWJFY9Jds7
 no8u7ys04060XO016AGtu6JWaEJSJbnBDbYx7fuN0Cp9y2BrPP9p0SHCTfvDxmWEo5+mw
 6Wl+ueVAChCoguqGP0AU4hiz5LtLIXFajm4axC1nC/yxmg8OirL+DdSJbmD5nPN7ALHQm
 ahJgtVl0rSOXBlu0gx0h9HyZUZUSnNeAkDIOjLyBPU3Yig3BRkALHIgLMnhyW5eSnRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793751139;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=h+J6PRP0yWj/FLrdYopJqvXNhxuMc4p4xqFM5kKG8RM=;
 b=p3ythtK1gVGiOO2yiBJ/6lqCq626ukZ++ayD9zO/1+3pNTwDO0H5ZINrqvr7nBY0a7qH
 el9sR3jS2egq0I9545jpDUTfNDd1yDToICAEH11eROCru2xbjt/iyyAMMSe3nI0NbCPZD
 tX453vVZDs3g8bcT+4J70lzPEIU35kNg568psasWcAaBAY+gq5za0RnkiZI2+gWk62EGA
 XhY8v1q0oNOqJHSKvYClObodc0FXIxPEitS+6kFd1VT2DbDi5bN80t2MeALmiKv5CgjLH
 BOGGxNHTY5wpr/2Ni1zY6JJ64Hkf9A/ib6VdHkC/XUzG6hnDH+JJclFUZW9kbErm/1w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nuntu5qy; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nuntu5qy
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC93C40080
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 00:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793751139; x=1825287139;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UbLKO/xvfkAxrweHbWXIZieZchc4Pu9Xcf4P9/J/oOw=;
 b=Nuntu5qylSWlWaR2B8zCXXQ4mIRwhJOsq9Wwq85PWpisvf+JZtHdnx2N
 1Llz5Bd1GADyADb+c2GFoLKUIBEBtU2hkKyq4/8hhJ+ho7a7vv0KSaYHj
 RU1Ftx2y93TX0zVWqglykd5d6GzngJkVmcBvF3jjRtuBK1pKo/n7iJXy9
 mwjUR77tY9NtxPcg3Zxh5ajDF6FUW4Ho4YPjjk9p7MYWwMXCdy8/sj8/s
 FqEg8BIOLIjneeScMMfxbaKM7Y3wO3QHwdkLorNFiWEHf10dQ7091FgFR
 Ldx1amUepZSP5Cpus6tMhuWg1RLT6+wW2b6arR7ki8khZMuSwLfsDCTNO Q==;
X-CSE-ConnectionGUID: Gy4aVw98ShKUrfP0OSh2pQ==
X-CSE-MsgGUID: AOfFR3SpTJi3S1WeUh2V/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2522928"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2522928"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 16:12:15 -0800
X-CSE-ConnectionGUID: jcEuMwmiTOu/WEzOAfJG7g==
X-CSE-MsgGUID: y4O3GjauQdaJPXU8I+gIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6904711"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2026 16:12:14 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org, brianvv@google.com, decot@google.com
Subject: [PATCH iwl-net v3 0/2] idpf: fix teardown races around reset and
 remove
Date: Tue,  3 Nov 2026 15:53:52 -0800
Message-Id: <20261103235354.1063721-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
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

Fixes for races between reset, remove and close in idpf.

Patch 1 lets a reset racing with remove tear NAPI down in
idpf_detach_and_close() by dropping the IDPF_REMOVE_IN_PROG early return
from idpf_stop(), and tests IDPF_VPORT_UP under RTNL. Seen in testing,
trace in the commit message.

Patch 2 skips empty netdev slots in idpf_detach_and_close(). Reproduced
on a reset with FW reporting more max vports than default vports.

Testing: Patches 1 and 2 reproduced as described. Both are not HW
specific.

Changes in v3:
- Removed patches 3 an 4 from the previous series as there were some
  issues discovered in testing and review that will require more work,
  and a likely a refactor more suitable for -next.

v2: https://lore.kernel.org/intel-wired-lan/20261026221908.24690-1-emil.s.tantilov@intel.com/

v1: https://lore.kernel.org/all/20260811171751.22165-1-emil.s.tantilov@intel.com/

Emil Tantilov (2):
  idpf: fix possible race on remove during a reset
  idpf: skip empty netdev slots when detaching for a reset

 drivers/net/ethernet/intel/idpf/idpf_lib.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.37.3

