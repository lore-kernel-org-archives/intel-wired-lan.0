Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865C606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yGtxfuCS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjFLX0fP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1665380CF0;
	Mon,  2 Nov 2026 22:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCn946qVwVKQ; Mon,  2 Nov 2026 22:32:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 523F280CDA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658765;
	b=QJ7U6EVxYTnEUCZV11XruuBakI2ROQ/tjkUppe1DH1CTIymmjB6ytreLOuebjwrCqGWN
	 bntIURaCVs0DxD6OU9wBfQt8WBXuSGBWBjsRmcR0DKmJ+V/L6LBGdmAuhnlaWhAghl05a
	 JRRBabah6YSx9sPWWDMKc3UcOHcO9dH85MbxCCu4D3hq0VGcoBVFARhrEyw0YPRxG2Voe
	 y7x3d2hN+r9emTI9Z5g15SyRD7DH4OSrLPtH0f0BIi9I2/M+FMMBMDeBut8BtD3ASxndp
	 F2DxxMjOSYe06ka6W0dpty4SswqYdqrBX7qSEkHHxf5eN35KJ3KZvUPz75Pxcl9wlNg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
	b=Bywto41LanNVdqCIh8iSkVLRVkwPp33FDsLW09PTI4BDty0yFhqAZiStyVwCLEZ+Q3Hx
	 iDWey0Fr3E8fUkg+AcKCAJK8HBCEwmaB/j65cfB12zy0k+HIiJVunigSxB3jpc3j5q4Hy
	 PSCTXRJ19jZkxVIfXC8sXteuZM0Iqh358tRlldU6K+orFFBH6WYTQZKxIgqMuZPMV5/yP
	 h5mgNjbh0o7iJCys+nys1WkgY+NmWJg6DIDB/uh86cfyA+N6e9FdD2ETCBxPymd/ICBOX
	 vj+gBhURb6ZNUgQFa110vsYqAev3qCrIYPA19LuIS2XAV37OZJ4wIGXKA4f3ZM+F96g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658765;
	bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=yGtxfuCS08poLSh9cx+uryt6wR8Whu7NhuVLjDwnQXpVvsd94V78H3s7YYw112YA4
	 YNKVH6bL4fr1XH38VmQSwbFw9V4ZD563HukA3K8SjX0nuJaKO6o+y5tzlIRijOgHxz
	 cZaU1luHAaAZwYjuQM53bG68GNqP0AVgAQq53Jhjn4KXEif1mqfjIyBsY1QbD5gXEd
	 WaKmqeuagSdI3uzJtjkBN0KV+rDp5dTM8uvB5JRABuTd+8x3W0lMV1doxYJaQ++uOc
	 feiXLxNOXa1TNHUoFNVG4j3zANrPEFeNdvKBpa/RMhkc1hfFP8WNLZt/b2dlmioux6
	 oYoPeFDvGW3Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 523F280CDA;
	Mon,  2 Nov 2026 22:32:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD55712
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 01:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E67EC4051A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 01:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5bT5SAGZEdTd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 01:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F37C140518
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793322747;
 b=EfyMMSuZrEaK84m3l+P7jTwpmJZj2hglSe77/Wam2SV2l0lYd5hVjVEWm0KCST8umvqI
 6HKl1DNkyE3WjXfI3zHEnVld3NzVt1+flFaMAOfdxSRs2XW9Oul5UBJqO1EVCXqjPJLDv
 9HzTR96jJu/taYsQYnT21v1L5Y8bAHZ6UkVyMRHljKPYRSz3cd6azSmdyMu3u/j1zampt
 n2kjT1bJ4X19GF2SKJghLoHgGwEV6vVKZvCkTB+sFAzMrv/VH9qvk/IXMCrFQcFgcJ6m/
 MaN1KrFmsI+sqAOPlv8gjUyPjPuOtf/YBm3qSVR3vUfN78GjxN5PKhQDK7okpdJ2V/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793322747;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
 b=WswofdaYviQj+vp4wnYKNHXZDqhwH+NLpR/LdLAYMRm2cV+0KqAkdSjw1URnXnpkL7oC
 53v2S4vCbC6YZfedcbVVKQd73e5ZuPY0npRxyzjpOBrRwwC8k7A6RX+mzPRp/tIwiGVMs
 Agi9dREIBmWIkGV6MkboSOs4pOzXceQTHJoGHO6eV01co0CQQZ8xjMqFmHmbfxXqF2+VN
 8FoO/WihOoEWjGMrBFHZEwWL1yuSgaqPKclzHv5RN61SPHvmlePDupAH+i9losBmaltKK
 2cDJDeQL8/elZMhsXsdgmBdo01PV38oTeFHdf6hWl3NPPvOzykxtaWe8PlezGZw1Prg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KjFLX0fP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+zac.parker.parcosta.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KjFLX0fP
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F37C140518
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 01:12:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 113AF404F7;
 Fri, 30 Oct 2026 01:12:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793322744;
 b=fDVsTumCS5jpT9cl3X98D+mKCUdyyeE9+/IEI7P+DkOBwtlKGWyR1ZP+Hy2ZvbfyxMGD
 ygNB5SBYuGYG6q91OkQMNhe5toquIGyflV2xtabShFnt+lEm9sOHbVXfPQu22QCkFBIMy
 rwbRksisFvtNltlrnhN7b5nP0aSBaXnefwUS1vlgtLvT7img2jxkPfovY4fHbr+YW5pi/
 xGqXK5wpeFV4QymiWMbwPsX34QTgxRPVuxWZpmEDgKzPbWZ6ROtjnsAsH1IbtanvaJjoU
 dteBPdaJBYXcrdWrQuIIYLbKNkNB2tBhpx5Z3/9d+xZyR/wimlzROQd4JoSHhVvNPAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793322744;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
 b=f/9HjkbTGkfu0ex/ai+GMzXhwhx84fX3tf3fLfzMEG6vZgyE3QMA7ZVuOYAHtvZRMwXB
 i2kB8rW7fCNiXbelG1FUpGBRrUYrcMLsJsgBvAC4RQphaHWte2gHdildzCFbVaPWloQsj
 4s9ol2M8KF4DUC4BhNk+FfEZABNJLhF9OaxLFcNbaEuBdlAF2fi0TWz2qFqw3fBmNjYiz
 jX2dFN0RTXcysLpxp1/Woz2wyngbAlMlv48ZyYyHYoxbLaigxy48JBg+JIKLmP9nKkc/P
 EsXy1FRXSdC8SFU9yKxvZ5Zp0GdrTbk708CfPiMp4AcpF+TsSXFOGgX0TA3HPDSolTQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 650771F00919;
 Fri, 30 Oct 2026 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793322744;
 bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=KjFLX0fPhTG2U1AMiTs1d6cFFCLur3mS92YzWZ61oWZf/x2Xab/2xWcN2DH/sWnDM
 GUhieDBAGqia8ArEhmkPkN81V6aiDf+XErlkxTmSo7cPw7OlFMQTiWc4GKC27sxJK+
 quYWO2OtKP76DhduguNimu77DjWJMqHL1DwYnElB7T+lXtSClmceqJ9HOPDxwPQbfb
 iFqz32ckBgtUxPhDyOlMTSqw1d1H6MeoYNJCm6T/VIVZMUDEI4L1OdFb30LjA+eFGd
 AXlOkmGYKIQIbreLF7xq2uCF+IiDtvi93IWG5CZnHBXphxjNL5sFWCipZdki2OGAXM
 d2hgwZ2WVvv3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EA3144306D;
 Fri, 30 Oct 2026 01:12:23 +0000 (UTC)
From: Zac Parker via B4 Relay <devnull+zac.parker.parcosta.com@kernel.org>
Date: Thu, 29 Oct 2026 20:12:21 -0500
Subject: [PATCH iwl-net] ixgbe: fix swapped addr and devad in
 ixgbe_mii_bus_read_c45()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-ixgbe-c45-fix-v1-1-7eb38075a3d1@parcosta.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBREr1Jm7QfTpkW9inTRxLF+kShJ1ULp3
 f3qYhZvhnkLCrOy4FAtyHxp0XsycJsK8TKkkaInY9TbunMW0XkMlOhbOess3d4xcOdD23jY55F
 p9c93hL5vkjih/w/lGa6M09eGdf0A90QNOnoAAAA=
X-Change-ID: 20261026-ixgbe-c45-fix-691ebe84b534
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zac Parker <zac.parker@parcosta.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793322743; l=3232;
 i=zac.parker@parcosta.com; s=20261027; h=from:subject:message-id;
 bh=z0czBdN6SjMUZi5kUnXLmCozGwOhDcYhnx5BsNw9Jn4=;
 b=EkO7qzS2S3n8cCJx6iYzkYCq/lJ5zCgns+YJ+8yxWt/0k1fSpUkEXkCP0PAOFiDuQ5jI/GzA7
 Ku2KhlLJzKVANx1qOaM/6wXMF6PWzT/SwssYmpJwxi4TU54rwuumeeJ
X-Developer-Key: i=zac.parker@parcosta.com; a=ed25519;
 pk=G+DgShRR2xDJFWGYQ0W+5eRamZbUryODJ6T6/eQZeEc=
X-Endpoint-Received: by B4 Relay for zac.parker@parcosta.com/20261027 with
 auth_id=1361
X-Original-From: Zac Parker <zac.parker@parcosta.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:41 +0000
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
Reply-To: zac.parker@parcosta.com
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zac Parker <zac.parker@parcosta.com>

The MDIO core calls the read_c45 op of a struct mii_bus as
(bus, addr, devnum, regnum), but ixgbe_mii_bus_read_c45() declares its
parameters as (bus, devad, addr, regnum). The PHY address and the MMD
are therefore swapped on every clause 45 read through the ixgbe MDIO
bus. For example, a clause 45 SIOCGMIIREG read of register 1E.C820 on
PHY 0 (Global Thermal Status 1, the X550 junction temperature) is
issued to PHY 30, MMD 0 and returns 0. ixgbe_mii_bus_write_c45() and
the X550EM_a variants already use the order the core expects.

The generic ops are registered for every ixgbe device except X550EM_a,
so clause 45 SIOCGMIIREG requests on 82599, X540 and X550 devices are
affected. The driver's own PHY accesses go through hw->phy.ops.read_reg
rather than the MDIO bus, which is likely why this went unnoticed.

Fix the parameter order to match the mii_bus read_c45 prototype.

The bug was found by an AI coding assistant (Claude Opus 5.5) while
reading the junction temperature of an Intel X550-T2 (8086:1563, NVM
19.5.12) from user space on a Proxmox 7.0.14-based kernel. A clause 45
SIOCGMIIREG read of register 1.2 on PHY 0 returns 0, while the same
request with the PHY address and the MMD deliberately exchanged returns
the expected PHY identifier 0x0154, and register 1E.C820 then returns a
plausible temperature (about 45 C). Reproducing it needs no kernel
changes, only that user-space read.

The fix was build-tested on top of net-queue with allmodconfig and
allyesconfig at W=1, with no new warnings. It was also run-time tested
on the X550-T2 above, applied to the ixgbe driver of the Proxmox 7.0.14
kernel. With the fix, a clause 45 read of 1.2 on PHY 0 returns 0x0154
and 1E.C820 returns the temperature on both ports, while the exchanged
request now returns 0. The host then carried its normal traffic on the
patched driver for two hours at 2.5 Gbps, with no link drops, no driver
messages and no change in the receive drop rate.

Fixes: 308c8ffd5a7d ("ixgbe: Separate C22 and C45 transactions")
Signed-off-by: Zac Parker <zac.parker@parcosta.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 1e52f6221..516856b3a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -832,11 +832,11 @@ static int ixgbe_mii_bus_read_c22(struct mii_bus *bus, int addr, int regnum)
 /**
  *  ixgbe_mii_bus_read_c45 - Read a clause 45 register
  *  @bus: pointer to mii_bus structure which points to our driver private
- *  @devad: device address to read
  *  @addr: address
+ *  @devad: device address to read
  *  @regnum: register number
  **/
-static int ixgbe_mii_bus_read_c45(struct mii_bus *bus, int devad, int addr,
+static int ixgbe_mii_bus_read_c45(struct mii_bus *bus, int addr, int devad,
 				  int regnum)
 {
 	struct ixgbe_adapter *adapter = bus->priv;

---
base-commit: b7e46a73815485bc5deb94945e50594a8bf6b499
change-id: 20261026-ixgbe-c45-fix-691ebe84b534

Best regards,
--  
Zac Parker <zac.parker@parcosta.com>


