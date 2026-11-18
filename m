Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07C606A332
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=r4iVAmx5;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=OlGon56e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B06D360A97;
	Wed, 18 Nov 2026 16:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ef6h_opiGrXs; Wed, 18 Nov 2026 16:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A88960711
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018988;
	b=hc5Jj+34On3HlKQ1a2gRhhTtEBkccWC7GxBGrnqbP45QSUzgV+7sThJXcFu9jPdMuLE4
	 ijDurTVR3qbGB680/tqFXCQdjlqOaAqEEXxF6uK1JAhzrazI6r1NDmTbJe2vtbwtrT6Es
	 H6JGTbTbhpxUT4MxR2rEX+CDwHuIVnlgcjIr0uQtC2dGfZ2zuPw1UU1JVZIgEuougGa19
	 dmjeiOc7gy+A5+XhGXLPDzIx17Zlm7I0xoWsgsQKEXCDuiw7kbZr0FhnsxFRpD7ypdDFn
	 A3FX9ZsqJZgrn9554KZmi2ZQnK2+bDaPAv+nbhZ3OTR3bEYppbHdhzxCCUTdx68YI2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b737YrD1Vuqp1UqKoujfmzIBpXH+TGHVeB6r5nqOeC8=;
	b=HmAs813T0U3fs5ix5pUkpctVPNQqcZBIgDe2p4a2Llgg3vkVaS4l8nIjgPoNHKe742nm
	 1UhnPByBxc5ZedPmXCeKL8oq0NwSVnceK0J39u7m0cGKR4oxCjpjwiiQE3d/vZdXEzUmy
	 VWZOuZ3ElBa9KYaYsKXgAPjF1IGm8kg6lDkg/XWKZbruvnyDyqRC8omSUX9yiWbqAnHrA
	 jvEW6gKY2ehvnJbkPJzJyAjha+zalwTVQy1a20wBL/pazoYO2Dq2DCSP3SphcKbHFLnSy
	 djwFVXKjt5uEHTnwZ4YFlNiDmHRYWA45qwsZxhO/eneJjEV6sYcu/NQaVt0+s17aXzw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795018988;
	bh=b737YrD1Vuqp1UqKoujfmzIBpXH+TGHVeB6r5nqOeC8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r4iVAmx5O8U61AqTfKApqFpbOwqyKohuSRbYaw7MHQAwKT1QqdWHzIlg2pgD/qnfR
	 Mi6Zj4XLsCg/18BaCwBef3xNYs+iEc17DqPTtojc8OIvqBd2qgUfJsvqRh2qSJZo4H
	 Zli0WdQESDfMxq8X/EUYzZJqEiYk7Vo6NeoKlcCTcHSvgtGaIRXPKjYsh0YxXiHLSh
	 650s/5h2b1BNeoK7N00uOcVnQC+Jne4Kg5+iYJngaJ4VpP7Cx9FmdCd2bGSuDmiVwB
	 SvYEARj5PCRcK8jznLa5Z9kI2CxbrF5GoiTjn/tXvqURtCFd0Fcjbj0rretOujxKGe
	 Q1Kcq9IuoMenA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A88960711;
	Wed, 18 Nov 2026 16:23:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D51F09F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA7B680E70
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WoP70BwECLjf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 07:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30AC480E5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=51.250.56.165
X-Greylist: delayed 335 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 18 Nov 2026 07:49:16 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ideco.ru
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256
 header.s=ics header.b=OlGon56e
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.250.56.165;
 helo=smtp.ideco.ru; envelope-from=a.kazinsky@ideco.ru; receiver=<UNKNOWN> 
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30AC480E5F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 07:49:15 +0000 (UTC)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id E6B1126BC2;
 Wed, 18 Nov 2026 12:43:36 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 6D97826BC0;
 Wed, 18 Nov 2026 12:43:34 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 6D97826BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794987816; bh=b737YrD1Vuqp1UqKoujfmzIBpXH+TGHVeB6r5nqOeC8=;
 h=From:To:Cc:Subject:Date;
 b=OlGon56eLuA3hxxuXUg/EEofiMCJVx7s7td7yv5E5/fOSwI40q7kSKBS6mAuBk/Ym
 bzkIXrbTes/dmu2fefJvees6SgRgB8FivU+RMqg6tYpLE5vGp3BA0ReEBBwk+d1Ukg
 LO7U6FqVg7D92aUWqzu732a/jtuYJ8cN46AuRra6mwMGHmGgH4Qz9w8M9c+ECYT09d
 bB+mwT0jeo4BJSDlEFU+6Brc4uvUOiXvHxDfO+s49J6LI0uLt3sVwLpwGx3/BrspqC
 ZM2Zz6aJRrKVemyzHA60ZXbClukilCzbzDd+JCSkG70jnaH4MVYwnPB8/IwbHKkGN0
 iNQMCzcTUjuCw==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
Subject: [PATCH net] ice: Avoid tracing bridge ports after initialization
 failure
Date: Wed, 18 Nov 2026 11:42:59 +0400
Message-ID: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 16:23:08 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_eswitch_br_port_link() traces representor and uplink bridge ports
before checking whether their initialization succeeded. If allocation
fails, the port pointer remains NULL. If xa_insert() fails, the cleanup
path clears the pointer and frees the port.

With the ice_eswitch_br_port_link trace event enabled, its handler
dereferences the NULL pointer while reading the port fields.

Call the tracepoint only after successful port initialization.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: d129c2a245bf ("ice: add tracepoints for the switchdev bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 1d8a6b95ccda..6d07c15ba9d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -1118,7 +1118,8 @@ ice_eswitch_br_port_link(struct ice_esw_br_offloads *br_offloads,
 		struct ice_repr *repr = ice_netdev_to_repr(dev);
 
 		err = ice_eswitch_br_vf_repr_port_init(bridge, repr);
-		trace_ice_eswitch_br_port_link(repr->br_port);
+		if (!err)
+			trace_ice_eswitch_br_port_link(repr->br_port);
 	} else {
 		struct net_device *ice_dev;
 		struct ice_pf *pf;
@@ -1134,7 +1135,8 @@ ice_eswitch_br_port_link(struct ice_esw_br_offloads *br_offloads,
 		pf = ice_netdev_to_pf(ice_dev);
 
 		err = ice_eswitch_br_uplink_port_init(bridge, pf);
-		trace_ice_eswitch_br_port_link(pf->br_port);
+		if (!err)
+			trace_ice_eswitch_br_port_link(pf->br_port);
 	}
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to init bridge port");
-- 
2.56.0


