Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F5C433FE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Nov 2022 16:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E17B8400D1;
	Mon, 14 Nov 2022 16:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E17B8400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668442154;
	bh=Zrq7f2F+kheJoESFYmNRi3kYIDrK+v8ZNUvkTEg1fRk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=49WqW+3uO37yU2Ug8M7BumHFN5oT38u0T4RsPh4C5cxkCNTm7Hlo/uvs1bxhjTyJQ
	 m1S6d3gmzisOhVKAJA5BUgdEmfy5nmzPRASr1gfgD88kG1fxEFutyhxgqWv/rDqYpc
	 fCxQ371kIGWXCpXBxQ7UwxVSPwEP5rFAdnscqHZ4AXPO9nFQOT/2kwN3QaDaPcW2H+
	 TorFRCToVwiGrMzUxjyuIKMvg+6d8FbL/hQkFKHFtwy8VkKL+NS7AunT3ZawpEKbXw
	 6lL4pWw+kObXqw74wfuRBMQK7fUgIN2KSnFwf/VaUuPJ59J+SnNMEGPs6kXZk2uYuc
	 JW3fH/vMRXcrA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wK1O3c4PbyUm; Mon, 14 Nov 2022 16:09:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B605B40113;
	Mon, 14 Nov 2022 16:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B605B40113
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 0E7371BF8A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 08:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE17E40A01
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 08:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE17E40A01
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OVlGmPIql6W8 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Nov 2022 08:28:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C0B9409D3
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C0B9409D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Nov 2022 08:28:27 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9j5x6C0jzqSPB;
 Mon, 14 Nov 2022 16:24:37 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 16:28:23 +0800
From: Yuan Can <yuancan@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <alexander.h.duyck@intel.com>,
 <jeffrey.t.kirsher@intel.com>, <matthew.vick@intel.com>,
 <jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>
Date: Mon, 14 Nov 2022 08:26:38 +0000
Message-ID: <20221114082640.91128-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 14 Nov 2022 16:09:00 +0000
Subject: [Intel-wired-lan] [PATCH 0/2] Fix error handling path
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
Cc: yuancan@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series contains two missing error handling related bugfixes.

Yuan Can (2):
  fm10k: Fix error handling in fm10k_init_module()
  iavf: Fix error handling in iavf_init_module()

 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 10 +++++++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  9 ++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
