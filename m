Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83933D3C542
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Oct 2024 02:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11FB3813FF;
	Fri, 18 Oct 2024 02:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZIPYS7cm9ok; Fri, 18 Oct 2024 02:12:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E57581411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729217520;
	bh=ZRUnTmuVZVBpTwWnHCZ09yiDfY6uHwOPsuAH8r6P3lE=;
	h=From:To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SUSR+tekw0Ijq+LmKNCW+HQ8pOkDMiJqSn3i++2jkh3vlYlC7JDeFrFB19yi+pfJz
	 yGjHnAXA0OffOPZrPLbacEMTYvfCsrChjhUJY0G2kPDvXkKCTJXa1+M4gJVLR8U1XV
	 q8lz98ep16qzeHSItGTjFe6TpG+z0PafXU/H/e+FkAeaEc44LdlHyd316F/67FcysX
	 EBv5tyWzgtFFgS0zzJdCHvmfqFbmQKtQz+4saSPUzm+az/XYD8q5VGo3bzBFxotTox
	 0YIY7TamqPvYR3t74/PQIR5fC8NJvTspl6M03zFRMxDDc3Sx12QqWvqFjg59HnX/o8
	 /t38pgYw129Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E57581411;
	Fri, 18 Oct 2024 02:12:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98DC32072
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Oct 2024 02:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6794640252
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Oct 2024 02:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id caKblif7_GoS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Oct 2024 02:11:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35;
 helo=szxga07-in.huawei.com; envelope-from=yuehaibing@huawei.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DD08F40004
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD08F40004
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD08F40004
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Oct 2024 02:11:55 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XV7TN1v72z1SCfN;
 Fri, 18 Oct 2024 10:10:32 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
 by mail.maildlp.com (Postfix) with ESMTPS id 2D187140135;
 Fri, 18 Oct 2024 10:11:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 10:11:48 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
 <jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
 <jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
 <alexander.h.duyck@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <yuehaibing@huawei.com>
Date: Fri, 18 Oct 2024 10:29:22 +0800
Message-ID: <20241018022926.1911257-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=huawei.com
Subject: [Intel-wired-lan] [PATCH -next 0/4] Fix passing 0 to ERR_PTR in
 intel ether drivers
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

Fixing sparse error in xdp run code by introducing new variable xdp_res
instead of overloading this into the skb pointer as i40e drivers done
in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
commit ae4393dfd472 ("i40e: fix broken XDP support").

Yue Haibing (4):
  igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
  igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
  ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
  ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()

 drivers/net/ethernet/intel/igb/igb_main.c     | 22 +++++++-----------
 drivers/net/ethernet/intel/igc/igc_main.c     | 20 ++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
 4 files changed, 34 insertions(+), 54 deletions(-)

-- 
2.34.1

