Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8903C5478C
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Mar 2024 07:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8745540147;
	Fri,  1 Mar 2024 07:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpXglB25g8I3; Fri,  1 Mar 2024 07:03:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B346640165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1709276591;
	bh=DBGS+7TE+sHG8XLrjLgkehvfYUznlWRjgAWf85jfVCk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=U3it1t5eSFmLQ96fDrUUSvm9VCvX7psB8hajt50mStgjrn775bSJfwDSH3nygSNay
	 wiTM8za+OCfq75A3MmRXA0L7jb/qzMFVOl944llbtlqQ4a0OCBALDzbg7h8a3fHinj
	 rCXE22oGco8BKYrXw8mts5eLd9yEQ1MxJhCgl7Q9nphCh3T+yFVwkCvV+/p2fs4sjM
	 luqqJ4I1MOMsklloAqRuAqytLX2q7q1BDNsT8/TDD9aT0SdDLPCeXNjCdcAqwLWdKH
	 /nlUinhSwILURDlw9BaCNdK/XU3gOmnHc3u24NcqgUh2t1q8+4uOvuDrhL5S3TLRg+
	 wq5u5fonz3yag==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B346640165;
	Fri,  1 Mar 2024 07:03:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D48991BF35E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Mar 2024 07:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7289409A6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Mar 2024 07:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BW6yykG2jswJ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Mar 2024 07:03:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ED13840165
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED13840165
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED13840165
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Mar 2024 07:03:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E8FED61411;
 Fri,  1 Mar 2024 07:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B7C433C7;
 Fri,  1 Mar 2024 07:03:06 +0000 (UTC)
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Date: Thu, 29 Feb 2024 23:02:55 -0800
Message-ID: <20240301070255.3108375-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1709276586;
 bh=5WmlDNkYeMKnLcSIkP4v8rKpr9XupluTVCy4xLASi+0=;
 h=From:To:Cc:Subject:Date:From;
 b=oRAD6tUMrARhLdBa3uyjmkfhm7OU9nbToqq16vkszJMpR+c1ZwOyVjX7g5dSJQy5i
 sagyuDqd6NMtoWTpyzuueJl+0hngD9xH7slgId63rpVQWM1Bc1+xL8bQZ8KcRLxbNo
 QskCCK7i4st5Ul6RVrl8yje27tJLGEITndaRU3MxjqQkSyu2d8lYvmk5NhFqt5JV95
 l7oTqlXiBQNlBZN64JLZ262VqP+Sopn2hJxgtA2LAmxEaeHKhNEouG+XdtV4b2MoQc
 NsQGEe9ra8SwANUAvxJC51WMn334b3Vajn5at7ZBXszXpq3nuSkQpo67pcyyJCISAZ
 V/csbwOkijUpg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oRAD6tUM
Subject: [Intel-wired-lan] [PATCH net-next] eth: igc: remove unused embedded
 struct net_device
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
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

struct net_device poll_dev in struct igc_q_vector was added
in one of the initial commits, but never used.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jesse.brandeburg@intel.com
CC: anthony.l.nguyen@intel.com
---
 drivers/net/ethernet/intel/igc/igc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cfa6baccec55..90316dc58630 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -570,7 +570,6 @@ struct igc_q_vector {
 
 	struct rcu_head rcu;    /* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
-	struct net_device poll_dev;
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct igc_ring ring[] ____cacheline_internodealigned_in_smp;
-- 
2.43.2

