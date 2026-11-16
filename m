Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2C606A322
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PgfZ4nrY;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ghXpFYdM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC75E80EDC;
	Mon, 16 Nov 2026 15:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dliz6cvWPuhO; Mon, 16 Nov 2026 15:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EFC480F19
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794844124;
	b=GekwXxE6GNKZlI4QBgR3dDGD9lGWCkovPhzpxCDQuPBU5ana+M3n6RLYhgAChG1J8BC4
	 4Kw3d/w3N9v7Pl73XssJCB2XiXKV8an6dlOeTzKHyhh+crVDHAkGrIz5imTxnFFD+ARU0
	 O+7mQ6XHmG0BqQ4HJRW3INlznvDLtC+t4ci3NeUY2rbA4TV8vCNE7NY2s8scyH64NbSPK
	 usmxGUYtWfdCV+Jh9peYWvPnOngO7NA9ClAKHxDwuYrQKZ4cwDO321ZVzmQ9F0YNMKxro
	 7pnYp25b243VyByZLtSvRweyjIo9TKfj0GEMS5kN3hUhn6hfskJrXGhtlHPD/gNQsUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794844124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zd+njkDEidCnuNGjyH95WNcl76vhxLmnDb9mYrZFmRo=;
	b=AjZZ56NujDDd/m2w7iLnY97T9oC+uUIAgxVtfRtXzINs1M1gEnsn2TpseFulV5LJRDNQ
	 yQf496dPvLUvBmwbnCtqO3ixji0Fgwb7T21ZH9WMq1M8I2DXQs3hNOJkc45ETzQI0VE4S
	 /3HcZJrL6+vCzpDRT7rxAal3/kmGFFbqcoPct5ZFVEcWfK1OgSq8w9ox+UqXCRcowMJx2
	 iEmoXhjSGGVPjuQE5tm/dVXnZmkAaparwgMGrZoBVT5EjoiYFKYD/RGyyuXaS60xHo3g2
	 MXhl4i91/KWEIicQwB17Dpa5VcGYR/ksTinxKyhLf9Ja+TaB5cWiFhnphGPgSThVwNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794844124;
	bh=zd+njkDEidCnuNGjyH95WNcl76vhxLmnDb9mYrZFmRo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PgfZ4nrYcrJuQ9GNGNMY4uS6QOU2AxXKvbk0Pr7YOf67XqVVHtYTCdWyy17sfHVQg
	 IhO/GbQiVfHO5ye5rK6lUKNjhj9mF9tFy7L6aM744YJWnLJXmqMJrOUYz9T2if4LCt
	 U5ekhZMpi/ZrVwvP9tJQNeJpjM7vujjujy94Nk5/SsDTnvCc0mo06vpuXbnCpNiixI
	 Lz6QaLzsCIhpXetaTD/3PZBfR953Pl9gZ97Z29T/hopUxPMyqeYUmYPZvR/qRijfLJ
	 t3AOoq3U2XoqLuZnDJd+bC8TiZDbMWEVTsainw/FLykfpXXFZ1Wa0xMdngq/b02DRy
	 IG+bmpaxGhaMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EFC480F19;
	Mon, 16 Nov 2026 15:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F37C260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2445140848
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWAmJv-COubS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Nov 2026 15:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD8254083E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ghXpFYdM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD8254083E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794844122; x=1826380122;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/ADY6cf3PQwh4Uxvw16YJpNY+hhfr/dobtNeqBNg3Ck=;
 b=ghXpFYdM6Qdc10qaf8yFjomxZNPh9eeaEeby98x9H1KncZGhm/JrPrW4
 T1SeiOFPgd3G8xkxQzIwaAvBcVff+YwZvqUPNMo9jB6VyxBnaBSH+42mQ
 5KX7ry9mObkFJNyof2C1CeGfXa5pNY/sgFSf4O4jNIeHdcp5oWkN+kkLq
 bACdu8qc2et5Bgn+VqQz5Q5yk4CuusVSWOvsEztJyeRabfDg6SJP98oS+
 EGR/giOP6qOltOKc66bm7ef6NQIIJE9X400dLm9SjQUyc/GW/8drS9QfD
 MseXXIbO4rjv2F2+hhvbmBxmcH4a+j9bX2nvimi/4sniOzWKzKpiAJS5N Q==;
X-CSE-ConnectionGUID: DqaAfSTzT/aLULmQBnGV+w==
X-CSE-MsgGUID: fQVZbeBYROGMH461fJu0eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3475918"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3475918"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 07:48:41 -0800
X-CSE-ConnectionGUID: SCbuRJVNRL+mSvfd7Zr6pQ==
X-CSE-MsgGUID: kAmsQzK1Sxqex6rjrdi13A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9984318"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa007.fm.intel.com with ESMTP; 16 Nov 2026 07:48:40 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 2148E312DA;
 Mon, 16 Nov 2026 15:48:38 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH iwl-next] ixgbe: allow loading XDP program on hosts with > 128
 CPUs
Date: Mon, 16 Nov 2026 16:17:10 +0100
Message-ID: <20261116151713.3117437-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 4fe815850bdc ("ixgbe: let the xdpdrv work with more than 64 cpus")
added spinlocks that ensure that an XDP queue can be shared between
multiple CPUs, but the limitation of 64 CPUs was not lifted, and instead
was just doubled. So currently it is not possible to load an XDP program on
a system with e.g. 144 CPUs, despite there is nothing in the
synchronization model used that would support such limitation.

Remove the CPU number limitation for XDP entirely.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6c022f4ee6da..6562c95746df 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11001,12 +11001,6 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 			return -EINVAL;
 	}
 
-	/* if the number of cpus is much larger than the maximum of queues,
-	 * we should stop it and then return with ENOMEM like before.
-	 */
-	if (nr_cpu_ids > IXGBE_MAX_XDP_QS * 2)
-		return -ENOMEM;
-
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	need_reset = (!!prog != !!old_prog);
 
-- 
2.54.0

