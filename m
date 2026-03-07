Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D853F55104
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Mar 2026 18:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 335CF838E6;
	Sat,  7 Mar 2026 18:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZCIAr6pQ8IS; Sat,  7 Mar 2026 18:28:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BAC08315C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772908124;
	bh=xw4m4OYj1kiX/5z7U5EmezmMROr17D8a2T9m4a8VOEY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oMb1+5PfUPiE+19qNH+NGUhhJauvvv+zJ6sVvdMU27kXm4gwNpxLcLFjA+ToDm44e
	 VC/mS5jhXg2HCpNic1QfKKdqbIknfN6V7ZjpZnMCiFvv4c5W8iR1lB+3cXN+XNycWu
	 8Opi9GF0GcrF3WOcB5JumelQvZgL1nS6GY/VOrsW5BrNG6E+AHo5Za3vztx0XOTe2G
	 Tzl3Pw4zyuFUuZ67p5EK8dmXsIJEUv3bPreyySKHjNhxFAzPkp9Wy+F1c9hveSwA7w
	 N+FQPs5Uz/+KhiU7dvGJqAUUZI2rNa1jLucvpMzaQMSPQ7I0pfOFtt9qHfZQeFJEBE
	 cq4spSgkXkwtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BAC08315C;
	Sat,  7 Mar 2026 18:28:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01643223
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Mar 2026 18:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E730440453
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Mar 2026 18:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id je-d8fXbq-yq for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Mar 2026 18:28:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BFD144044B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFD144044B
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFD144044B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Mar 2026 18:28:41 +0000 (UTC)
Received: from ms-a2 (79.25.31.150.dy.iij4u.or.jp [150.31.25.79])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 627IS9o2043132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 8 Mar 2026 03:28:09 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>
Date: Sat,  7 Mar 2026 18:27:37 +0000
Message-ID: <20260307182808.155027-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=xw4m4OYj1kiX/5z7U5EmezmMROr17D8a2T9m4a8VOEY=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1772908090; v=1;
 b=ZmXtY5L4guy2PE3b7i0o8VcNXrDqgH0/Nbtbw6cj3XLFZPLCR4p6nP56Mv2ofxzM
 hRUnu3qCjhpjcB5SDTawK1ckoWGX9k/tlndBlO3/io0gvxK/usyejZagTpO+1FUU
 1O1pE6kqGzr1xPhCouV0f7GNZYYn+7xSdmICcDPPYM66DuEruXqma/IzNrapvw9r
 8JXX6fiTVvF9JhomYbDsid2M7X8d4zBcGhZTfkGyeXiFnbsP/Y6IquF6aN+enM3t
 99eH2q0M1t7kdgMpmVB2TSm8k9xxHxTAQ3MFEOpDuy93PgPQv6e7R/5ahaI2tJbg
 Xz7aUIbNOsux0/63RTCO2A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=ZmXtY5L4
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/2] igc: enable build_skb path
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

This series enables the build_skb RX path in igc, which is currently not
enabled in any configuration.

Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
path.
Patch 2/2 enables the build_skb path when XDP is inactive and other
conditions are met.

Tested on Intel Corporation Ethernet Controller I226-V (rev 04).

Kohei Enju (2):
  igc: set RX hardware timestamps in igc_build_skb()
  igc: enable build_skb on the non-XDP small-frame RX path

 drivers/net/ethernet/intel/igc/igc.h      |  4 ++++
 drivers/net/ethernet/intel/igc/igc_main.c | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.51.0

