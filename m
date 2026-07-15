Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BCDC4450B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 06:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C7BE406D7;
	Wed, 15 Jul 2026 06:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7qwyMi0gd4So; Wed, 15 Jul 2026 06:18:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BA27406D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784096332;
	bh=RWpJTHJ8TyXGkDWqsB7xYyZHeqa3pjiQY10iz6i5Vhg=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GZWC7tybkuAo48IB0G6M/vqTvLoa96OBWnBGoOoAEyimJ8HuXiy/ZaQxMe9uTn6OE
	 xVqEzK3uOMW36uJHC15I6ErIheBH927ucVQ1UnY8B2uXGdmVvzUTT74gv8nfgIPptW
	 iKqONJGHQcE8vC8WajQr6P3efeE/S4hjjVLY36Cn3mzXvWr+mbvjRGEnDAySbeTJuu
	 QkxqKUVaBOLp2+CnAriXhXcjHN53YwqAIKoWfceVy1DtQFlEvAjVer9fuDfHbiXsDZ
	 agMok5eVbuEVlX0nfdtvtnJL2f/bVlfzalA1UTx19MSOz2rubzU2y1dvqSgGUdMEhq
	 ODo9h/AT2radQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BA27406D9;
	Wed, 15 Jul 2026 06:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0809B499
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 06:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E28216063F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 06:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dd1gXuxdMdXa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 06:18:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.182;
 helo=out-182.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6CC9F605E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CC9F605E4
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CC9F605E4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 06:18:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Wed, 15 Jul 2026 14:11:29 +0800
Message-ID: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784095983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RWpJTHJ8TyXGkDWqsB7xYyZHeqa3pjiQY10iz6i5Vhg=;
 b=koTyQ5rODfYlsV3CszwR0yZKArLEfwxG/IevGon6Bq25lCYwM5e+ehyL8vIXm0qwyLmbWN
 Nhbb7dCPR7giThL5KIzUTOsVo1VYia+rvnwVX1KkZ3/h6lEDvBTKQ0gomvHOeGaX9B28HJ
 wIvmlStPK4t3wI+/wv/xKEYpDL6tJCM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=koTyQ5rO
Subject: [Intel-wired-lan] [PATCH iwl-net v1 0/2] iavf: fix two memory leaks
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This series fixes two memory leaks found by inspection in iavf. Release
the ASQ command buffer when initialization fails and the QoS capabilities
buffer when the device is removed.

Xuanqiang Luo (2):
  iavf: fix ASQ command buffer leak on init failure
  iavf: fix QoS capabilities memory leak

 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 1 +
 2 files changed, 2 insertions(+)


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.43.0
