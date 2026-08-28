Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B3C61DC4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Aug 2026 02:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85041606C6;
	Fri, 28 Aug 2026 02:00:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5u7jXIQp8Sb; Fri, 28 Aug 2026 02:00:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787882424;
	bh=bgLSguRoX5jpC1NLPDzYsimm3icxqBoap0+Yv7haELs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NzUdZ/MmgR1xgDFt5zYZP0AP9UaXTge24saKc9f0SCj6HvHhzLjzPHG7YoJvs6WDJ
	 6w8ChCjuMQCW+Rrbwa9F4HVC+K6/mGB1myvKazla3n3tFa92Oec61FaGK3klp6hhD6
	 0RM3IT08cnrYEPBRivb9WCOQy4EOUMoUGEFpNtW8j/tELzxyffapfFl7SkO1/4Epd5
	 zgQywzY/hMdC1YNaJ0lwgS1BHtgyppJ/v+nvB0sLGGAUja8izIdAKCNgdWRgLOJLCq
	 6mHeXWzQ/5ir4J7r/rw876FquIHS2qix0Z2fDv0ZxGsDwXu1r/rIKzzea7Irla9ABU
	 qEXxhdYfGcVMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A61C9606CB;
	Fri, 28 Aug 2026 02:00:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32767334
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 02:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 187DD40820
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 02:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOkbfnzscLmy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Aug 2026 02:00:21 +0000 (UTC)
X-Greylist: delayed 77 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 28 Aug 2026 02:00:20 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=KmBNQtyJ
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::9c; helo=mta1.migadu.com;
 envelope-from=xuanqiang.luo@linux.dev; receiver=<UNKNOWN> 
Received: from mta1.migadu.com (out-156.mta1.migadu.com
 [IPv6:2001:41d0:203:375::9c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 686DB40804
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Aug 2026 02:00:19 +0000 (UTC)
X-Envelope-To: intel-wired-lan@lists.osuosl.org
DKIM-Signature: a=rsa-sha256; bh=AAcpEs2VGk20y3FAdUf8trsxmtZYFZ0VYb330q/Ah7w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787882417; v=1; x=1788487217;
 b=KmBNQtyJBsiGgbFAXqVA1IKGxzcbSse+Dt0ff9hclvv3ETJhtKMJHfNbu6P6rsKf0BONy57Y
 6umRtyIins+6as1s7HPa1GqcFill3tIb+fALzUuGIgOJlYvDkYJoBAx97i4EWUoqvRYKlqZMnTK
 iq2DfQhKriXFQunLr5l6mX84=
X-Envelope-To: intel-wired-lan@lists.osuosl.org
Received: by smtp.migadu.com with ESMTPS id a1430dc3be629d11;
 Fri, 28 Aug 2026 01:59:00 +0000
X-Mizu-Trace-ID: a1430dc3be629d11
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 ahmed.zaki@intel.com, mateusz.polchlopek@intel.com,
 saikrishnag@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: [PATCH net v1] iavf: add missing PTP adjustment callbacks
Date: Fri, 28 Aug 2026 09:58:37 +0800
Message-ID: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PTP hardware clock documentation requires drivers to implement all
callbacks and return -EOPNOTSUPP for unsupported features.

The iavf driver registers a PHC without adjtime or adjfine callbacks.
A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
callbacks can therefore cause a NULL dereference.

Provide both callbacks and return -EOPNOTSUPP for the unsupported
operations.

Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
Link: https://lore.kernel.org/all/20260826101004.100979-1-xuanqiang.luo@linux.dev/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 87b97e09df14a..fcb273828bc1b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+static int iavf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
 static int iavf_ptp_settime64(struct ptp_clock_info *info,
 			      const struct timespec64 *ts)
 {
@@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 KBUILD_MODNAME, dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->adjfine = iavf_ptp_adjfine;
+	ptp_info->adjtime = iavf_ptp_adjtime;
 	ptp_info->settime64 = iavf_ptp_settime64;
 	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
-- 
2.43.0

