Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514F0C88E75
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 15:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EFE54064A;
	Mon, 14 Sep 2026 15:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8flqNE8s5fcN; Mon, 14 Sep 2026 15:25:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CDC234057C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789399547;
	b=hBKjNXA3pHE6dbeVVXP/uBYyy9LCKglh6ryAFuDNya2aJU0psVFP4CF7aDbpg50AWGs+
	 Sj2t5H58yv87VE55RqUqomOE2Ow0K/k8F3WYKATeHgjuBUB/bby5ldQCX6csBFKpeVWAc
	 ND0N7VqSscH2tGSrM7LeQQ2mH/GcnEy3JyrbQD3YyG/1S+4skaD7704bKs2O23dJf9phX
	 FrOZcwM4a/QY2D5fyhvvXl4kDxRmUmyrffgNzeurwXjG27dcEClQ5eiACyvYY/zT+MI12
	 Gzu2ArnTrIW2zBmrLMdo7Gq46gg8Do9F6cD2AQUGpKbC0cmT3VYf9Kjj1RPd25/RJHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789399547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V40l4BEPJi0x3bSRqBmren6BviAFly+T5dJ5Wff1QSU=;
	b=MVDZLact0Lzk0Y/YjYDAy+9aMpdv9nezDKOrf6PocGVuLwini2uCZVna/Cgcz/C2QgP3
	 EXKwEj89zMjgbeVxzilyWqOW3KJjMiji2fDSlW4BGW8hf/peWua3OpcCNy8IOKiyxfGI6
	 3Z15H4IMGP78Dv6fKKBWQ6rYuQiOabqB/CGBTfUtc30AaJ84Jqs7WdFy/WWJIMm7tQ+YU
	 GiHMnrrXVj6WnzfLe7Z6Uwq8ByIXfDFWX/AH2Cx3yyAoMm4YAgLp8328zV6nb/aBp01v2
	 DorAI/VzGJuK6lXnrfO7A4sJlR0bc1bVydWEVc+N8aSSCjR0O+SZ1Htv/zAb+KcmLLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=CTYtwTSb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789399547;
	bh=V40l4BEPJi0x3bSRqBmren6BviAFly+T5dJ5Wff1QSU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XdMBz/2Z/MPWl/sydu9hP+LozwbREDPARK6Rw5xR5fPU2AUnyKM9NUyqxg5V2fv1G
	 6boZ+YxkW061Ccdl1sMZcsk36wCMs8d9S3bBEEhXoyQKCOG/LJq57zMGvTwS0LJtEu
	 psGAKIXpgNK6PcJ6xmltXBMhOiZNhRUPH033xwjnaKWqwNxu/EtZkTpwOtPhHXa4U0
	 IwHuf3wT/f7Oe7M9yIJBImIwtVnqNvCZG5jWJ9twPBwRfbc0hOdTXeQGoAyd3VkWKH
	 gNXzs8MhLwOpI03h9yjgHaCwr/dk4ujapLgi9kqJV6jSj9a8q7D8EUwS+7hDhDiOtO
	 RxiP0oY8iUXPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDC234057C;
	Mon, 14 Sep 2026 15:25:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CDF424D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F06840587
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bfkmxz83ORNg for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 09:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2737940582
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789378038;
 b=tL+GqEjhqHFVv0cH79Di9chf9IPHgxD1M7bBMgf84awwN9lZbWrrUSfHrz+bmndNcz11
 I4xX1mPrZRlXhSRrTIEVhoJ+yreyyWDjWvBmsIy7DbNMzt4wIWCjrBKQLeM2miCNXj0NA
 uTwMomF8qy3+5gAoWrP7fW6x9LTlkmTtanzSsPGOpiR1+g3U0rUqoY3plvyhzE3/W59l+
 Lsg8hC2J441zSkNVHUm+bGyJ7aNJoFTolDl+c6EsmmZXUHd/tK04dwTIplXPmddnaZe3g
 HyyJJkNU1kqp3pStm3m+hlvUuhO0N9gS7c2MW6Je4peCJ3/qFUlCiq7jBO7VVffeN9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789378038;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=V40l4BEPJi0x3bSRqBmren6BviAFly+T5dJ5Wff1QSU=;
 b=cuxvNi/NS9AP+JmHlt2tdHKaCYcL3U90gm4Eq5hkp1cjQCT7frv/kts5ZmfUeTKi0Vw9
 wyjqK8nzwZodeYBwnFwpYJuPqRGKk5jlWtXz2GYlbmPZeTZ/T0AcENC9EIi7TdRXqmX+B
 lWggSjRfYMamOMyaRAqTrms0+FqTJ4JeatEh8UzEhBXuV3ORLboMIzj68ikedQXN/10fk
 0sg9CdjKvzor2MvJOuBE5Sopu6KyPbO3qYQQ3c23M2KtwN/j7r6HR7SCSh72Y40o7OibI
 0KZx/fpeiCWbTlpAJa+gO0uIFOCfsXipREvuB4B4Y4IonXRYKRE63LfpffHVxgbaEww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=CTYtwTSb; 
 arc=none smtp.remote-ip=117.135.210.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=CTYtwTSb
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2737940582
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=V4
 0l4BEPJi0x3bSRqBmren6BviAFly+T5dJ5Wff1QSU=; b=CTYtwTSb/XrkAUZ6sT
 2oi6wGcZyRf7o/jJbigd/pfNqv5wATq2VvLjnL0XS1Oo7ZMXogW7ROfSp1Zw6Jb5
 M5vSFSE0AAANSuoHnLG4BjIcJHBFSX/BD1yhF4TnRm9TGXRaN89JhM3c9/C66GCF
 Ix+Xs5VuHqKTk7vxEmBPyTm08=
Received: from localhost.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCkvCgD337LEvadqgTuQFw--.32944S2;
 Mon, 14 Sep 2026 17:26:28 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] ixgbe: do not busy wait in ixgbe_devlink_reload_empr_finish()
Date: Mon, 14 Sep 2026 17:26:26 +0800
Message-Id: <20260914092626.263886-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCkvCgD337LEvadqgTuQFw--.32944S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7AryUuw13JF1rAr1fWFg_yoW8tFWrpF
 WUWasayw17Xr4Fg340vayUuF9xX3WagrW5GFyfK3y5C3Wktw1DKF1rtFyaqrWUArZ5Wr4I
 qr1Y9rZ5Aan8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAQl+2qnvcRXfwAA3S
X-Mailman-Approved-At: Mon, 14 Sep 2026 15:25:43 +0000
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
so it always runs in process context with the devlink instance lock held.
Its polling loop delays with mdelay(500), i.e. it busy waits for half a
second per iteration and, because the loop bound is 20 iterations, for up
to ten seconds with preemption and interrupts to the timer subsystem
effectively blocked on that CPU. That is long enough to trip the soft
lockup detector and to stall RCU grace periods, and it keeps a CPU fully
occupied while the firmware performs the EMP reset.

Use msleep() instead, the loop does not need to be atomic and nothing in
it holds a spinlock.

While at it, rename IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC to
IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS: the value counts 0.5 s tics, as the
comment right above it already explains, so the _SEC suffix is
misleading.

Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index cf8908b82f8a..7ce0a0cbf9d2 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
 }
 
 /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
-#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
+#define IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS	20
 
 /**
  * ixgbe_devlink_reload_empr_finish - finishes EMP reset
@@ -460,11 +460,11 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 		 * may be not cleared yet, so begin the loop with the delay
 		 * in order to not check the not updated register.
 		 */
-		mdelay(500);
+		msleep(500);
 
 		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
 
-		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
+		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_TICS)
 			return -ETIME;
 
 	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));
-- 
2.25.1

