Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BA6D3517A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Apr 2026 12:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FA4A80CCD;
	Wed,  1 Apr 2026 12:09:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njbCl5hoRgO9; Wed,  1 Apr 2026 12:09:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58F458095E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775045388;
	bh=JDlxxfJvdjrgRObVClm6fGkTKhFiMlDGrQADMOOu8ns=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oxiXZqNsof+FEMgDylQ3X+0RIpty6TQ5dtjAJFHBA7S5j4+qFtQHkGDzDyGWIOhy1
	 LauHB/A62cwRIbOq22pvGykjeCg6l+9uE7fDTwg1L5IZcteHm2YnMDKyDgcS7ryXag
	 66A4zz3zzjeDZgenHoHxgLNTQ7vZA9aohl2qGvdfUqp/cB5gvCEX7zWXG3UEvnyohA
	 rxxHRRu/HJ3LygVLCqndLix5vjX3wvFgPD/LVTBeVUNYQBEUyWmY3o5g/vF/+3yuQu
	 CtSkkAlgyQZ5INJx5XeQmEU+NYytJ/Sd5AQlVIY81WVOee9RLnWbCEomo1LpF6fxox
	 bTMzeYRGtmLkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58F458095E;
	Wed,  1 Apr 2026 12:09:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DFCB2A2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Apr 2026 12:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12319806F4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Apr 2026 12:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RobHzlDFaI_G for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Apr 2026 12:09:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.108.111.100;
 helo=mail.amicon.ru; envelope-from=ade@amicon.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2853681467
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2853681467
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2853681467
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Apr 2026 12:09:43 +0000 (UTC)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 1 Apr
 2026 15:09:37 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Date: Wed, 1 Apr 2026 15:08:22 +0300
Message-ID: <20260401120919.282668-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325151615.1407182-1-ade@amicon.ru>
References: <20260325151615.1407182-1-ade@amicon.ru>
MIME-Version: 1.0
X-Originating-IP: [172.16.2.46]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail;
 c=simple/simple; 
 t=1775045378; h=from:subject:to:date:message-id;
 bh=PlaAOt0ssCukJ7V+OLnR4/beOc5FHiklgNa9+yhyvr4=;
 b=SMCZinU7YdIlx6vXdse6mQDcjiESHnZRuK1jGXrJiu0sOzNxF3U53/sdQoG2oDAccGBi7IcLQse
 EyC2KvaBECt5XBEamdvI0ZXX1evaXPUkK2QM+Jssw8JV9iC4vUZaZODaqzEGPAjrxUUAZDrtlVzf3
 Tie00+KdRwRGeKUD4WWd264ove2hwsnLr2tgVdPetXHLgauRaXu+QgEIajK/QhjRK4TIQtvZnUS1V
 33+pxHm6yvSSEa1lrC5MjjC3QQ37EJdBYK3wqryeTXe3oOiNxmpSgnMmf0EbSsf9aFUE1wSPk7VIf
 G7Y/F89A90Ft42N2dMhUcxhC2lQl5djMomSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amicon.ru
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256
 header.s=mail header.b=SMCZinU7
Subject: [Intel-wired-lan] [PATCH net-next v3 0/2] e1000/e1000e: limit
 endianness conversion to boundary words
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

This series refactors the EEPROM write logic in e1000 and e1000e drivers
to avoid processing uninitialized memory. Instead of looping over the
entire buffer, we now only perform endianness conversion on the boundary
words that were actually read from the hardware.

Patch 1: e1000: limit endianness conversion to boundary words
Patch 2: e1000e: limit endianness conversion to boundary words
---
v3:
 - Reverted to v1's "check-then-convert" logic in patch for e1000e: the
   return value of e1000_read_nvm() is now checked before performing
   le16_to_cpus().
 - Removed the redundant full-buffer loops in patch for e1000e that
   caused double endianness conversion in v2.

v2:
 - Moved these improvements to the 'net-next' tree.
 - Improved commit description for clarity.

 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 11 +++++++----
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 19 ++++++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.51.0

