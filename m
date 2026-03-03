Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A312EDEBF9
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Mar 2026 21:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B94974099A;
	Tue,  3 Mar 2026 21:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Id6JljL97fFy; Tue,  3 Mar 2026 21:39:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62F8240979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772573983;
	bh=igp784OHO+635oJ50fvODP220soAAGHkDuzEsTE/GF8=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=F+17KYm15NdXtKSeqPRdzaG27y0M0X3GQXsxbwopuDyWoPMA9yLd6cOEv/RQuaRHj
	 eOXlt5u/qE12PZUT1kIcrC6bDcw4UWdupzCFyetrIC1QfR/pOZsBuBLmHYj2mRWcaf
	 tmwXsNUzBJiEUjll6Eyci92sy9PRD+unWqlQDgezRc7kC7rpofYI43GKFticmgeJq9
	 dlZbhwjoI7poVQr31iH/Xntfl9AJnWLKQoTeHzuVzGoIV8HzW2mQE5cmuqCtEFz5sZ
	 3IpjVdmn2Y6XJTWJGhDX9Km3b3lU6oQnrlc8yPWSjn2vabEgBfKuOxCLzW0+q+4O21
	 3ubQh/RlNnbQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F8240979;
	Tue,  3 Mar 2026 21:39:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7D4B1EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 21:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E51F840223
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 21:38:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EKeBLboNtNin for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Mar 2026 21:38:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+maximilianpezzullo.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5133C4021E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5133C4021E
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5133C4021E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 21:38:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB24F60097;
 Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF2AC116C6;
 Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E0EDEBED;
 Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay
 <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Tue, 03 Mar 2026 22:38:19 +0100
Message-Id: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3dzE4pLUIl3DVEtLSwMLSwvDpGQloOKCotS0zAqwQdGxtbUAojo
 o1lgAAAA=
X-Change-ID: 20260303-master-1e99908981bc
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772573919; l=656;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=AjH7WLa9bAhWMALSAH3NuMvfF6ECbIBSXWNf/e4MfJg=;
 b=L/lPOvYciaiOzmbZFaB9ATg9XQKiN5iExZe8cRlu0nHygPOjY8Zq026P5Nt/nThTqABdnRJ0g
 Jt6S6R0m4IIDygn/0pWWTORonyao+CMPl5iUbD3KSErd876dkCdcEuE
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailman-Approved-At: Tue, 03 Mar 2026 21:39:42 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772573920;
 bh=AjH7WLa9bAhWMALSAH3NuMvfF6ECbIBSXWNf/e4MfJg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=rn087zihY75Rgf6dJNfes7sHjzjTudtvvIhJssC0bBLqQZz5LZEwh5H9/94J9j3ph
 5ROujE48IFsVEGemtSYZB2Fadxbs/ADGiyLG/ng/90LwYK5pBHsuuNcIBhqCFfH9s8
 U37PifeiziEAFNt9CL8zAEiohEpyTizE7CUIlMAV8a7XNBq3PGmNm2MHUwl33dIecR
 vKqT4RVIjcxOnnVYp60I6jbEVoRs2obqpnA0gRAr1cE5LvlUl1J5Bt1To8zhkGbM9Z
 Z2JNkcqeQyR2Yl7YSUOFb5AMOrGZK7EB1Xr83XAwPpxmU0SFAi9FIRHNsRkiidTpkD
 kNJdbdsYezYpA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rn087zih
Subject: [Intel-wired-lan] [PATCH 0/2] Fix typos in comments in Intel
 Ethernet drivers (igb, igc)
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
Reply-To: maximilianpezzullo@gmail.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
Maximilian Pezzullo (2):
      igb: fix typos in comments
      igc: fix typos in comments

 drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_diag.c  | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c  | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 4258db5c0acd08e795c78c7cd59f05860b7cb769
change-id: 20260303-master-1e99908981bc

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>


