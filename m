Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9F4CD98C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Jun 2026 15:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2423181985;
	Thu, 11 Jun 2026 15:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pum8Qjyt83Lo; Thu, 11 Jun 2026 15:59:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 926138198A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781193552;
	bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oY3GMLYQoYnVdJLrN+3ltpDEZU7HG/tVb6G/revGNZEffaNPhj6KvLxvI8QtKxvIE
	 By1NOnRwb/yugrCl8YHK2aIWOrMcHeoi92GHaJsEjMzw6pTEd+o8WR8aT1ocTTIcEb
	 fpGu7OLmSz7vw7KtRXAjc5+30ZOzq34tUSqdmMQOlhpK/nOsR0dyEaJve0RAtOJNFK
	 ZUMtXqXH0PA1rUf6Hlf53OfkCCjywhbSguE44DyCIixKK43RX/AaxhCPRogEZ1FNdE
	 CJWriKbiuWZmiLvUuyffcS98wnPb84R/kves24PJtbvFAEh1VRs230MNbSMy3PC6zC
	 vbnbdqx+DP7Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 926138198A;
	Thu, 11 Jun 2026 15:59:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 863DD33C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 00:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C1E84055C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 00:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qo0OxtpyzIWH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Jun 2026 00:24:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1249; helo=mail-dl1-x1249.google.com;
 envelope-from=3wqaqaggkd1o5a8gfr2d8gg8d6.4geafl6d-oaj65-d2fdaklk.gkmgkd.gj8@flex--digonzal.bounces.google.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E56D4054B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E56D4054B
Received: from mail-dl1-x1249.google.com (mail-dl1-x1249.google.com
 [IPv6:2607:f8b0:4864:20::1249])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E56D4054B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 00:24:58 +0000 (UTC)
Received: by mail-dl1-x1249.google.com with SMTP id
 a92af1059eb24-13840d96f21so1406785c88.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 17:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781137497; x=1781742297;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
 b=PpyXdVujfrzWsGrPR1R/Sz5DnQwLD58y6LKxit/hlA25QawnOGc6zV3amLPdae92gG
 tXb/oZEv+I5Um+LoUxqxzYOiuEDpcU28h3Xe7VDefAOs56YT0NZ7fBSsnaEICne1QusM
 gU7xYLiI9fEdoUJu/vys/0UbjhFo+VdZe0Cl21gHtgkKb6xXa7dEBc9DozhN4ecSJgj7
 X4T3mkvv3qtDxwwmSyBEMJIPG/+zudJ2TJQ/0jr1M4dblRgRApPJWXglkJhIVrtyfcyH
 797uSwf3g+PwLEh37/yRGclkm92OqeKT4FY7cH7k+plYu53lX6zD7uBI7B9DMYf0U2BW
 9Jag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+q3/xOLkq0tt3zWRghvaEFblbDk5sZznjilbi4AljYY+OkZcEF9wQ8ESEOl2EKGxrpPsU+6hUIDLLRiklqbQw=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyCUzIKkM1y+McPh0D5gKf50ZQJRcto4WHuRryB0WW6l47jghKs
 EkaEWM9uIbPg42O1UJ7Uq11X4oPNLA0LlBkMC6rpkBm/MuuoQ99+MDD7bueYxRlbfIRM0JR7DDj
 4g/07xVIAsR+AYA==
X-Received: from dlbvv8.prod.google.com ([2002:a05:7022:5f08:b0:138:9f7:2b4a])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:50c:b0:137:ef8d:a58 with SMTP id
 a92af1059eb24-13842119f60mr288616c88.3.1781137497042; 
 Wed, 10 Jun 2026 17:24:57 -0700 (PDT)
Date: Thu, 11 Jun 2026 00:24:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260611002437.1671401-1-digonzal@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, 
 Li Li <boolli@google.com>, emil.s.tantilov@intel.com, stable@vger.kernel.org, 
 Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 11 Jun 2026 15:59:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781137497; x=1781742297; darn=lists.osuosl.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
 b=f1WX0JLEt4YwJ5HqPzE8uRdrP9x/Ew5ajg0pdvJfhz+R5tMQZNbnZrdjT0LEblWwcc
 YBRAb/q4PyO122w5HJiZVh3c7+ih5Bm5shkH1EbK2OVdCXqs/IrNBUR0R8V3+4in9g2L
 BHHWycLAfghEw3SKp/bE3cnDtLc2k4uzI9Wp7Ae0Vvtj7ySYfF1c5uoolEc0Mex+27sJ
 CeSvphPc1vZcf59ST9UXtXBQo9eQUW8A7UvnF5V9mAwNcbFluSbmZfCfSQ/T4lnMuOqY
 /g/1287Q57v7pfnL0PLfBnCW3cFrGMdER7rLtSVOgF28LFAt2He7zy99GsC0sRAglJYJ
 exIQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=f1WX0JLE
Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: decrease statistics refresh
 interval
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
From: Danny Gonzalez via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Danny Gonzalez <digonzal@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The default 10s statistics refresh interval is too slow for real-time
monitoring and causes network selftests (e.g., uso.py) to fail when
verifying traffic immediately after transmission.

A 10s delay also causes aliasing in telemetry tools polling at shorter
intervals (e.g., 5s), leading to inaccurate rate calculations on
high-throughput NICs.

Decrease the refresh interval to 250ms to ensure fresh stats and fix
test failures.

Tested: drivers/net/hw:uso.py now passes
Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Signed-off-by: Danny Gonzalez <digonzal@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..e2890d219431 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1364,7 +1364,7 @@ void idpf_statistics_task(struct work_struct *work)
 	}
 
 	queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
-			   msecs_to_jiffies(10000));
+			   msecs_to_jiffies(250));
 }
 
 /**
-- 
2.54.0.1099.g489fc7bff1-goog

