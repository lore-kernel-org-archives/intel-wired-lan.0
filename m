Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB41C10F1D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Dec 2022 16:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9809813F5;
	Tue, 13 Dec 2022 16:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9809813F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670947289;
	bh=35E8PvC9L23YTOO5GhOvGiytUzzF/TBgZ2bQm1DW/hc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=P+jzQwQpDYNWRw1QcBm2ydz8hnU86A33PnRfqePMAWRAMfutEfJjrjHKkBk8f7h0o
	 xwJPIXPSUMeRzxHeXcwYFqkuFd6np+eUS2Iz4FoPF+TxOHvmvVZ6zK0dKi3bGWKZjZ
	 xd3p4zrTNLEkoNvzQFQq5bsPDcRH4sW7hIRrw9qR0QJlrzejeODyqh4JGVVImiiA8O
	 MqLxeP6+K/MHMbMj9nu7b3t5pgsxH+onjye/3WjDAk3uk0b8blHSx4aW1k95fbrJg9
	 AMde2xu0/r8Mrw83tK2gagTQVpu20swbIqEa1o9BA4MtvRTtCCq5Jy/xy6XHGJrMBP
	 MuqeKdxXOR55A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e8n7KbAk1Grq; Tue, 13 Dec 2022 16:01:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E42DA8143C;
	Tue, 13 Dec 2022 16:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E42DA8143C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 69A961BF29C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Dec 2022 11:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EEAA416C7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Dec 2022 11:04:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EEAA416C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fOaPeYNEF1Ql for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Dec 2022 11:04:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E538416C3
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E538416C3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Dec 2022 11:04:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="305744347"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; d="scan'208";a="305744347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 03:04:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="679263020"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; d="scan'208";a="679263020"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com)
 ([10.228.151.145])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 03:04:11 -0800
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: tirtha@gmail.com, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org
Date: Tue, 13 Dec 2022 16:20:18 +0530
Message-Id: <20221213105023.196409-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 13 Dec 2022 16:01:27 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670929454; x=1702465454;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qUgI9kJMyxfeIBUg1MqvWukhfpYdTN7aNnJshDSAb0o=;
 b=IPw/dRoPVE1aEQp0LPUWPHFQly03zqFLYB4zhoMg8AceZR0eqeaa1cKE
 LrmBpxsSlNAiQptWVgfDUGkUXv9NaQL8n64rvbUvdRkxjXcF791O0mK8X
 3GPSb4jkM0MVxbtNBNscVhEwSmhz1oZeQKmlYVMKjKWlU7YArwxHLbX3T
 NqZpp73vCZo1f9Pvz7wR99ai0Kn18NW6wDmFyLxaEGNCeH7JXH7Yn6yG4
 deXb/cm2jB0aYvLmc7Fa9ICULqTWh0S82IkhGi06G5efsYHnlRDaC+I1+
 RJz1J3exr9uM+GZ7UItAf3AWJ2xnXDVfwspuXHqCdURWWmFp22GthxuDD
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IPw/dRoP
Subject: [Intel-wired-lan] [PATCH intel-next 0/5] i40e: support XDP
 multi-buffer
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
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patchset adds multi-buffer support for XDP. The first four patches
are prepatory patches while the fifth one contains actual multi-buffer
changes. 

Tirthendu Sarkar (5):
  i40e: add pre-xdp page_count in rx_buffer
  i40e: avoid per buffer next_to_clean access from i40e_ring
  i40e: introduce next_to_process to i40e_ring
  i40e: pull out rx buffer allocation to end of i40e_clean_rx_irq()
  i40e: add support for XDP multi-buffer Rx

 drivers/net/ethernet/intel/i40e/i40e_main.c |  18 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 378 ++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  13 +-
 3 files changed, 280 insertions(+), 129 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
