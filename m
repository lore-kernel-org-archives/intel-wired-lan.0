Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79875606A320
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=j3WEleis;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x4CgwkLn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58C446063A;
	Sat, 21 Nov 2026 10:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y13c_-wVSpLT; Sat, 21 Nov 2026 10:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A23D46069D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795257393;
	b=bkji/DuMQz8xH8NbRINbTUJfshZwsQpKQBwdSPlqlVNhh/LFDuanWUlq7zA0PKpofMWK
	 MA53OOonJud+fZaPtMic3pV3vXxSbKs86BdpEB8xQBggR1xT+v3Z1dX1EOxJ26fe0Jj9q
	 8CUY+8yNzkMmA7Vcj7aEt4ZD+UX/6wVkruYmg8tbKIS55LMLU5NdvMPKaLxl9kWzj34LS
	 fay2Kuy0YnC0myrdHqYCkCnexIxr0xImR68AdesuVpfofocQaAW70it4Z65fUI/SVdS1v
	 FWMOW04uSgecV+GpEB5L6HfdtZ0ZItYi0PknudmBhWAqFQfRjcDmcTJLBlzeljiBI1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795257393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2PnAaJY3xQ06KzTzfLuIgzUmp8vGuLD/Gl6uWYVbERs=;
	b=ObjB0pruQAI2nGV0yLAbMSiLmgSNXHqGrnKd8OUbAD8HhYN+rgVpMnA1BnewUmLM5sVu
	 9vDMA9vkdTltBaBlJ5gd7fJY9B1LvJDyrmDFqAgL3YtpWPS4ifNS+lkdMT1wjwqrCWEJg
	 c85Bq59Du6RIFBqZQjhmZwyJiS7Vx+PL258eKnN3kz5gsyAM+sSL7+Yp8hwHZu7VletvD
	 lxe7EzyKW2EARtC51h1aG1QKxXU0q8tKsQmyNTiPzIiSycUqLVUuUaemi6WJInQveAEJK
	 rN+sNwOWnuaIAIRtC15OpsrxbdxdoUTy8sQ0NDBPxVpNSeTNVv9kBI+l+4j0yz0v3Gg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795257393;
	bh=2PnAaJY3xQ06KzTzfLuIgzUmp8vGuLD/Gl6uWYVbERs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j3WEleisuApzi0lBwhR+IYJV7sQxFFfPXUlC6h1GA6s1XhsGWqvCGfpDWVNNsCDEo
	 acyNknLZ5YCXLNND+me1QJy05shfz//AVLyLuB83iZrY1+zjI1G0BsKKan871o1FHd
	 2oSflC1SLrrI1PlaNwLCULmG8uHD1FkrhFotaMO9n9oeUMxEdqW4Ak1uv/0/WoIOqF
	 7R6M9t+OrFM/VWirxHCxRgeyybVfbtaB1NM/MlttFGCAxkqitjnd5zDrtFKY9gSRbm
	 aPD8ZOnJ5fnIxlmFDmTO76Lm8F+Z23u0CelD+ggh3cOFqQ1fJJgAYrFP7p4Q6iq7Uw
	 E+MkDrQxPvOpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A23D46069D;
	Sat, 21 Nov 2026 10:36:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5A071AB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77D5C409D2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRb5k-BCx1_q for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 10:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6DAA4084B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=maxime.chevallier@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=x4CgwkLn
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6DAA4084B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 10:36:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C41B34E4168A;
 Sat, 21 Nov 2026 10:36:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8096D603CF;
 Sat, 21 Nov 2026 10:36:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 75B9F11BC0F2B; Sat, 21 Nov 2026 11:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795257382; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=2PnAaJY3xQ06KzTzfLuIgzUmp8vGuLD/Gl6uWYVbERs=;
 b=x4CgwkLnpZhHGfYIl2UpOuphU1Nb+OVN0YgA/jw/iytwSRX7gydU7GYxq2mR1XLUO3ahGX
 disr4B1ZLiRPo8Zhfljt+oEiWiZDcxwgBnc8TfSCBBps3RVkBXhvfSVfqr92Sc40SEwycw
 iWgRi1DPzVkqr4SZ8pm1KmFTp7JpMmupmgS6jngNz9Z41bITp2cq1RzqbQ5ddxU5+e7FDi
 l/MfvkJtoupgDgLgrQLejwyca+wQZflYZQVyEbAl7lOhhiLPKXWgiiuFr9SVt3llnvHDRM
 qJZFzxt3ZImVYNTtSpUJbRpRP4KxlhKhl5yHJkpesyorFchxRN8K9ul1uUmpnQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 matttbe@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: [PATCH iwl-next 0/3] igb: Align the flow-control behaviour with
 ethtool's specs
Date: Sat, 21 Nov 2026 11:36:09 +0100
Message-ID: <20261121103613.166611-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series makes a few changes in IGB's ethtool flow-control
configuration to align it with the ethtool expectations.

This was found while upgrading the board farm that runs the stmmac netdev
CI tests. I've upgraded the HW and I'm now using a bunch of I350-T4 PCIe
cards (running igb) as peers for my tests. Since then, the flow-control
tests have started failing:

https://netdevci.bootlin.com/stmmac/outputs/920328-bootlin-stmmac-sun7i-a20/test-outputs/18-pause-py/stdout

This shows 2 things. First, the Pause test is weak to the test peer not
behaving as expected, but we can't do much but assume that kselftest
peers can be trusted.

Second, the igb driver doesn't behave as we expect w.r.t pause:

 - It overrides the pause configuration when we toggle link autoneg
 - It doesn't take the FC user intent (rx on/off tx on/off) into account
   when pause aneg in on,
 - It advertises Pause + Asym when we have "rx on tx on", where it
   should be just Pause (it's not an asym config).

This series addresses that in igb. I think e100e and igc have the same
class of issues, but I don't have any HW to test that on.

Also, this behaviour has been in igb for quite a while (2008 it seems
?) and this is a user-visible change so it may just be too late for
these patches to land, I'll let the Intel folks decide on that, anyways
I'll have these 3 patches running locally in the stmmac farm.

Thanks,

Maxime

Maxime Chevallier (3):
  igb: don't change the pause config when changing the link ksettings
  igb: take the user intent into account when pause autoneg is on
  igb: advertise symmetric pause only for full flow control

 drivers/net/ethernet/intel/igb/e1000_phy.c   |  3 ++-
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 21 +++++++++-----------
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.56.1

