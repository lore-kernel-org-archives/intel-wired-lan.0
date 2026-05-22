Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C530CD4F5B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 22 May 2026 06:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DCB885291;
	Fri, 22 May 2026 06:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZWVB8PlLRbm; Fri, 22 May 2026 06:53:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCCAF85290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779432817;
	bh=BjQT+YwVFJIg+6eKHraFXkbmCcLFw8BYQEDz4dPV4Q0=;
	h=Date:To:Cc:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=aUXtqyru1c9D7+SXWsAszXfHVKRWKPF+u9gUevUWIMN+YNnu2HXhM1ZuWrDGGwJpI
	 hokSU5jwvTVUcq/A2N7ZiYbuqkap15puybeVkJl/nis3BwydWweeBLwHwE6Ymbir8/
	 llet78qbSdaYgBNo2AwMe90yjLuRbS8T6NTMTuuBalJjMxE6XjtxzvrsCAmd9lvbgO
	 I1yuCNgPMK4yAvZTQkcrBoR8KfiNU0P86oRe/8DXCHtCO2ofSYZI96SbvtY0Ym3Uou
	 u+G4wUAFOp89Cn1F0qvcA6vKJwtKMqw+sI+Xl9vutjxSnlGemNxmEpLMhKiYXJnqDW
	 7l2RbAmbs7Wtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCCAF85290;
	Fri, 22 May 2026 06:53:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A8403B9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 06:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C1C2429A1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 06:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-xzDDen8WoN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 22 May 2026 06:53:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.117.158.93;
 helo=sender-pp-o93.zoho.in; envelope-from=linuxuser509@zohomail.in;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9EC484299E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EC484299E
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EC484299E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 06:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779432756; cv=none; d=zohomail.in; s=zohoarc; 
 b=UkXkWLLdEfqXd6g0Ptcz/gbq5B435B2CfehOEPGruFLBmSjNJTb8NQGdkFmSVkGab/1hzHICaKxIkV5Y5vlZYABlVXkKLeaAzjMuScE7aj8z6VXm+l0M2q5QCLcRJ3pKpP8JWDijTseFhemviOa4APjfds6dugmILgQlOiG19JU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1779432756;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BjQT+YwVFJIg+6eKHraFXkbmCcLFw8BYQEDz4dPV4Q0=; 
 b=ZpT85IrCGhWvMjEAbGJwJGMMKGpR74koJVZOSR53bJXr1yciwsqYR038e9DDU/CoMGhuysuJfGK79+jKOfUIUhgoPCYvDYA3L8f9NPaF/LQH4eVNdE2IFlVfOu7/b78sBaW9EVjmnknSC9YLw05jGJGkWnH2p2c7fndxYKOeVPM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
 dmarc=pass header.from=<linuxuser509@zohomail.in>
Received: from mail.zoho.in by mx.zoho.in
 with SMTP id 1779432750919223.90762740528305;
 Fri, 22 May 2026 12:22:30 +0530 (IST)
Received: from  [106.219.3.73] by mail.zoho.in
 with HTTP;Fri, 22 May 2026 12:22:30 +0530 (IST)
Date: Fri, 22 May 2026 12:22:30 +0530
To: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrewnetdev" <andrew+netdev@lunn.ch>,
 "davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
 "kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>
Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
 "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
In-Reply-To: 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1779432756; 
 s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=BjQT+YwVFJIg+6eKHraFXkbmCcLFw8BYQEDz4dPV4Q0=;
 b=SERrZCjKWlOwIRVbfVlEMRC8feZEUXmFrX7G53TCbsZqVbsJXhF5Tsk4zwlGySct
 M0X2T0iSNezGvnlRqqo91qJllJthK3QzRy6NPRjdXjfY2dwMQ8J3CE2eXllQ+DgDZS5
 mZomb58PTsHkpCK7/BeGWZH4IbhMS2p8V6Hvv7QI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.in
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.in header.i=linuxuser509@zohomail.in
 header.a=rsa-sha256 header.s=zoho header.b=SERrZCjK
Subject: [Intel-wired-lan] [PATCH net-next] net: e100: remove redundant
 static variable initializations
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
From: Ashwin Gundarapu via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Fri, 22 May 2026 12:20:23 +0530
Subject: [PATCH] net: e100: remove redundant static variable initializations

Remove '= 0' from static variables eeprom_bad_csum_allow and use_io.
Static variables are zero-initialized by default.

Found by checkpatch.pl

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/ethernet/intel/e100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index bfacf877ca40..bdddd4315cbb 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -167,8 +167,8 @@ MODULE_FIRMWARE(FIRMWARE_D101S);
 MODULE_FIRMWARE(FIRMWARE_D102E);

 static int debug = 3;
-static int eeprom_bad_csum_allow = 0;
-static int use_io = 0;
+static int eeprom_bad_csum_allow;
+static int use_io;
 module_param(debug, int, 0);
 module_param(eeprom_bad_csum_allow, int, 0444);
 module_param(use_io, int, 0444);
--
2.43.0
