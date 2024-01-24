Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79170C46CD2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jan 2024 08:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A29342FCA;
	Wed, 24 Jan 2024 08:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A29342FCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706086579;
	bh=X4FuCdhJchif0ZdIzxnHwtgL8xgXCxtiB3b4x2qtgyw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=qGPdw2lSe/SHBtqpS3BIgo3wBpSgOmuqxM/4eAoZtwZJF0UVPw/tEm9bBpO/asrh1
	 GydJQxtqMuwwXwbFoeKDKDBfXC9le0fEuAROCmr6wDmc878IfZQ4chpQUyctR1bUIO
	 iWKGIkHv7cRml4io3HsbHfeJE997+j3QFXs7tO9J3oNlsqg85V+9AlY/jJk5p6efQ7
	 c0v4K0hiwifzbN1yq63Zi6uaZRRNtqHQmp16THEbyeCFIsrrSv/gJ32r8Iu/zayJE+
	 9MznazfMz7GbtUdEpan+4ytLbRSESYHaU8SaS5MmCsH0GMEj5Ljnhtc8zBDNEoCkI8
	 37pDIWMQHWVqw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCkkkOiwbwEZ; Wed, 24 Jan 2024 08:56:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F03B431C6;
	Wed, 24 Jan 2024 08:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F03B431C6
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 354AE1BF339
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 08:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C882A42FCB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 08:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C882A42FCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cf-SjWzx_qF7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jan 2024 08:56:05 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 704C442FCA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jan 2024 08:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 704C442FCA
From: Kurt Kanzenbach <kurt@linutronix.de>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 24 Jan 2024 09:55:29 +0100
Message-Id: <20240124085532.58841-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1706086561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X4FuCdhJchif0ZdIzxnHwtgL8xgXCxtiB3b4x2qtgyw=;
 b=viEav9YP9h95SvhqFWpPKp7flAZgvD728Hq8slaOP7HTnpvC467k3GxGGmaRNAIqGBJ6ea
 xMi+Q17RDjT4Nt3D+TveqOY79vG9LwIHBIDiPqTBG64Zk5H0gGnAJH2LIpptRPHeUTixKn
 OLy0Q5+KZC/6+HbGesRtDgWzJMVz0Xm+fVHDztKKeY2Rp0p70SDXmy1U//RX0VTXFEg1BF
 fP+m+2H9nJzqnrdggC+HOsEoVngeaCykHQt3Qxh0jmn7dgVGSfo/jVPIA+9xfKwYlKr30e
 LRqb7XEyxfk6xmX1cj+hMTJ0TtttjHTzdSL5irpEcMEm8glzjWvEIvC6XHkpig==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1706086561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X4FuCdhJchif0ZdIzxnHwtgL8xgXCxtiB3b4x2qtgyw=;
 b=H1QKrWg83OFrQteVHkRykToIvp18kfiD0+X0Q2GEqfCit2/9nkztWKhvauKGhC9QusYHCD
 D09Mw56cp5EqaLCQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=viEav9YP; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=H1QKrWg8
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 0/3] igc: ethtool: Flex filter
 cleanup
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
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

this series contains some cosmetics for the flex filter code. The fixes have
been merged separately via -net already.

Changes since v1:

 * Add Vinicius Ack
 * Rebase to v6.8-rc1
 * Wrap commit messages at 75 chars

Previous versions:

 * v1: https://lore.kernel.org/netdev/20231128074849.16863-1-kurt@linutronix.de/

Kurt Kanzenbach (3):
  igc: Use reverse xmas tree
  igc: Use netdev printing functions for flex filters
  igc: Unify filtering rule fields

 drivers/net/ethernet/intel/igc/igc.h         |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 21 ++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.39.2

