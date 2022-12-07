Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37356C352A1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Dec 2022 16:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF9DA81F80;
	Wed,  7 Dec 2022 16:42:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF9DA81F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670431362;
	bh=l11F1h8FjTnBVpy6IC3Frw9oGQhpKMwhZgs8kLl+smk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Cb43rUHdIZSEjqxWkQtlr+yET3aXVPr6L3z/ayJI08dPu5cd9URNYGwF+UuMX7iqZ
	 8Hapz/EFhc8CnrtvRidfgOxONzzC14yKnt05oJMTGMX5ZLsWhjhXQX6v4xNQz16XiU
	 awO2oYlEDaeTyG1OchkswfDZT5qzKdtNCC9jQDezsxKDw5b7U+aFNcnpjqeAqM0Xw/
	 a17YNp6udzy/WCpCvaS1skk6Vowr7q4vcvN87H3AZl4Mwsp1c6/JeWLi0yDlXDeDVL
	 e0z7KNOPjJOjCQKn4bKz09soL+B2MkeU1tpNJrP9c7icOjET4YkEm3K1+DSjSycLcR
	 HqtOZM71IotTA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgXSyUbLiPHx; Wed,  7 Dec 2022 16:42:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A15E81FA9;
	Wed,  7 Dec 2022 16:42:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A15E81FA9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0A7221BF82F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Dec 2022 08:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4072403C1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Dec 2022 08:57:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4072403C1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6UYYIYQV4if for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Dec 2022 08:57:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42F0440360
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42F0440360
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Dec 2022 08:57:33 +0000 (UTC)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRrgB5Hj2zJp8s;
 Wed,  7 Dec 2022 16:53:58 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 16:57:28 +0800
From: Yuan Can <yuancan@huawei.com>
To: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <karol.kolacinski@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Date: Wed, 7 Dec 2022 08:55:02 +0000
Message-ID: <20221207085502.124810-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 07 Dec 2022 16:42:35 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Fix potential memory leak in
 ice_gnss_tty_write()
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

The ice_gnss_tty_write() return directly if the write_buf alloc failed,
leaking the cmd_buf.

Fix by free cmd_buf if write_buf alloc failed.

Fixes: d6b98c8d242a ("ice: add write functionality for GNSS TTY")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index b5a7f246d230..a1915551c69a 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -363,6 +363,7 @@ ice_gnss_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
 	/* Send the data out to a hardware port */
 	write_buf = kzalloc(sizeof(*write_buf), GFP_KERNEL);
 	if (!write_buf) {
+		kfree(cmd_buf);
 		err = -ENOMEM;
 		goto exit;
 	}
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
