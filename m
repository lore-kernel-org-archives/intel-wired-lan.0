Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF669109C029
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 15:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBB3A80DF8;
	Wed, 25 Mar 2026 15:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rA-geTsL5L5m; Wed, 25 Mar 2026 15:16:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E8CC80DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774451807;
	bh=8yFcGKXZVHw6Gr0JpMXg9Z8xFzRntVU3DC+4ZvscWtg=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TIoAAOYYeFNNPL2ohvCfj90MFNO/ftErTi+ultpRKmXms0IWFp+2aBVHt4FnJGalG
	 d/wY0h81EIPTMXMKIz/6zdhPeOu6vHLD/f33YPQBT35snaqcgaqUiyoqTVpi3b/PT+
	 Gi3gzP05ZLbaNImLbyhrm19Tp1G4AV3QBQZY87YAH80V3eIIWQsO5JvkkdWEeWAy0E
	 USuyo90aRRohIq1XC9gpde/k8xz06SPeV6FVYua18wdngQV0rJsyan7Klld6XPardW
	 O16hFUcTaokox3NAitAchomIGZruUSAKbrjrM8O+CC6xmNTgDUgckVSFiKUVd9hZ8n
	 6qaAFnnpsOUuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E8CC80DBB;
	Wed, 25 Mar 2026 15:16:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 192A01D3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16E5C4018E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUaGOec1130r for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 15:16:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.108.111.100;
 helo=mail.amicon.ru; envelope-from=ade@amicon.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D74AF4009E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D74AF4009E
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D74AF4009E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:16:44 +0000 (UTC)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 25 Mar
 2026 18:16:40 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Date: Wed, 25 Mar 2026 18:16:02 +0300
Message-ID: <20260325151615.1407182-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
References: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.2.46]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail;
 c=simple/simple; 
 t=1774451800; h=from:subject:to:date:message-id;
 bh=1i3NxWlICBbOFqtT7C9smmQo82RtasGv7L9o4l/iSIQ=;
 b=fi62UMQAn7pIMyPBSY9xt3ENVEbG81A5b1OvP0FhLHQdFE/5I1mf0gbT/Ho0t7h/6mTr/7CPZ51
 tiq8+mrZN7z6bOY1b0b5DxIHwCEClVYS3hNsAHiBhcyJdvucIVKp+T+HP0Nt9X/3kc2lUjHHOtoU0
 1nbpM+Q53Dftg3rg+7HB8ceeaQSw8kuN0APYQ2/ZrZsz5W0OgoO+TTNGjg4n8rzY4hYf1PKcaWO+o
 FvtiJk01ijCrEEaudjJVKlwqDgZfofx4sB9tPfrmXuBrNCTb0r16cXyKgytIQWCMeW3xlqK7dt5wx
 FYMKRLOP17J5YuE6wgdSGEaVZRgc01ikumZA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amicon.ru
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256
 header.s=mail header.b=fi62UMQA
Subject: [Intel-wired-lan] [PATCH net-next v2 0/2] e1000/e1000e: limit
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
v2:
 - Moved these improvements to the 'net-next' tree.
 - Improved commit description for clarity.

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 11 +++++++----
 drivers/net/ethernet/intel/e1000e/ethtool.c      | 10 +++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.51.0

