Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436B606A322
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mB44tbDY;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DLAT01C+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9186480D6F;
	Mon, 16 Nov 2026 16:31:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vzNoPd5BLM_0; Mon, 16 Nov 2026 16:31:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED83D81067
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846706;
	b=s50mvKYxoAcCLifonkHoSpoFXsvn6u7RC/lraVQux4ZRaU0LO8GKkJ7hz+l+UycWBFTo
	 v7vBRFkrK09MUdWsWEqxiwcVuyumn2VZuZ5H5dbTL8khjsTYUnJIqjov5yjV0sgVGG3SP
	 90F/rzrKksozpZTg35KiD+Q3aPsivVahzzfdjHwBX/09EcIvjsRtGzGmsninFHvpgzOpr
	 //zuQeFBSAlzECfCwp41OAbp/Jg2ecULuMIyD6FfCcj9A7sn9vzSCGlWnqQP3G4WtiHPq
	 fkwq9/QMNp2XEx61ty1MoS+mSUbx1AXEqV8L65G4+axyNosOWpOeSB9HEwW/AoWu4oA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J7s7ZCXFsAJ/68tVIVRVMwcbIk9BJS3ZXOj7V8rFsVo=;
	b=Y76ixlG/KZaUI2xS+DBHZwOaIH9DY1xpsnSRlC6OmT2ipOh+JAsGemvkupFhruxfM73C
	 VOqS2YYLkol4u6HL/gTgIHyHzYVIvw2l0xrJGLP4F3/5y7SyJTfKcau+CB6Xo9jkE+aiP
	 IHodna4gLvF15ygefrgi687xntvI0jXtHye4ZaoJTt/V7P726PexynTVGyPuHni0M+mkf
	 w6uDb1KEBcisMqeOwdj2VOT5gtMqbfqz0+YqcYfdTrYtqb+HWgPIie1UEhyx6JUVm6o/W
	 WcDWh6tpmdeBo27dM2b8HXKaVQYY4kkHA+P+h43etFgFhy9jiFGfWmKvwy3xgRNrkkQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DLAT01C+;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794846706;
	bh=J7s7ZCXFsAJ/68tVIVRVMwcbIk9BJS3ZXOj7V8rFsVo=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mB44tbDYWHepRquzc/tfAKdy062btjYJS8DzMRzXgKkU8Ga5b0UVS2rYPjWEWDAG3
	 aGkRszW+HvOKKlCxHuvx9awjOgIOXQ5xgM3mszMKnXoGvXuMDQ8HHtlqdl103vFSeb
	 WX/E+dPlYWSn9FOZRzrvUxDbBgPkV4sYakC6cMeX+HaFNdHewBdp+ZPAaxjgClJZg/
	 2usetLu0hleCCjrvRSNn1Ykp5h4odSWhsirG0vl/oeDjRwaAWDHgE6fSw2JGHtOPpj
	 QRYzStZjuPidbbpFij/WvexrVUlCKfRkvgzQWBng+VgiojafN+nwcgE7RZwlC/kmzb
	 sQEfRgopZS7MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED83D81067;
	Mon, 16 Nov 2026 16:31:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00C231A6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 01:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAAD4817A9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 01:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJonG5xasz8m for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 01:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42F7781771
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3vl_3aggkd3koxcxbizidlldib.zljfkqbi-tfoba-ixkifpqp.lprlpi.lod@flex--rafaelcl.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=DLAT01C+
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42F7781771
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 01:56:13 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2ed8aca9775so15257565ad.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 17:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794621373; x=1795226173; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J7s7ZCXFsAJ/68tVIVRVMwcbIk9BJS3ZXOj7V8rFsVo=;
 b=DLAT01C+eelI930ZEZvRsIdeZTHi3YK+WUYevJerUxLPloSc/XfTfMLsGMu0rrTxPU
 OWzKDEzjNhdvO86uw6wCOJgB4ZvoQobL86ySm/GOBHpuRE7zHNfsZCdA7IvqZ4IaAM0g
 PuX4YVsc4TSSRvG2PtfBeND7v0ygK8dBtikjth7mS2a//pmcK/bqEw0kA3Bxy/mBsR2w
 mHX0wYdC8NeF+mScpWJxv579VbXZj2anKRuxL+0tHxCrQar8Gksfr6Oviebt9e/itFE7
 +/6HRxtlte4sLCrdaDYI/Zsieyc0H5Li0Eh23Y6ctbVWkai2NibAllGK+7H/8tp6kdf8
 m0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794621373; x=1795226173;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J7s7ZCXFsAJ/68tVIVRVMwcbIk9BJS3ZXOj7V8rFsVo=;
 b=K0Wwn6si/Jgjf74RALaAZx/oIdRf2jnMnyIax+Pi3e7bZhYXpSHMIOyrxY4jdLDGAp
 SmUTjaJ9xT84Bsj9NPDkP676JYrGRrfdFCUJ27Se91Rp1jIyJhdIK1vXIIWu7blA7z+j
 +uvVWC5lp1ZLn40mnJbD/8oEU+fsB2Y6HlgdnBrF2R50Cyjg0juUYSLAOEPzS6MyXXaX
 M082N6KKlOrppuTU+gcGoF4MvQaHTO5DdzG9cQc+iOc7dn7XYfoxDXkX7fUAq+HdbQi0
 DVpncqG++nFxFgztVYaif8xsZUvPH/WYqjX3Zkm4L7BbiYLix6ulxmN6SO5iEQlEna0F
 Da2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEbgGc4LzQQtR7NMu1Bn5JfnMKRwNwllMZydW0dVHL5gIr0px9544Kn9I8mz1TPG2TZ9UMO3yw5O61hE7coyeA=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/k0Lh4l9K2RhiWUYynoym60ofDmb7yTbj29wbwftLKgX6v6650
 Bx1f9WbRlLrQnGbJAX247pbnx4OcLDLxvjUgUFOzkwHi1CTuokfCrmryzEj0fiPAg/02JOKFDXN
 5BcfpYd9kPfztWA==
X-Received: from plbku16.prod.google.com ([2002:a17:903:2890:b0:2ea:1d0b:962c])
 (user=rafaelcl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:189:b0:2e8:3a42:7edf with SMTP id
 d9443c01a7336-2edf1e7ab84mr54814245ad.12.1794621372849; 
 Fri, 13 Nov 2026 17:56:12 -0800 (PST)
Date: Sat, 14 Nov 2026 01:55:48 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114015548.42376-1-rafaelcl@google.com>
Subject: [PATCH iwl-net] idpf: check vport state instead of link_up in
 hwtstamp get/set
From: Rafael Castillo <rafaelcl@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, David Decotigny <decot@google.com>, 
 Madhu Chittim <madhu.chittim@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, 
 Li Li <boolli@google.com>, Naman Gulati <namangulati@google.com>, 
 Rafael Castillo <rafaelcl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:31:43 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vport->link_up is cleared on vport stop and only restored asynchronously
when the Control Plane delivers VIRTCHNL2_EVENT_LINK_CHANGE, causing
SIOCSHWTSTAMP and SIOCGHWTSTAMP to fail with -EPERM right after open or
soft reset or while physical link is down. Check test_bit(IDPF_VPORT_UP,
np->state) instead so hardware timestamping can be queried and configured
whenever the vport is administratively up.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Signed-off-by: Rafael Castillo <rafaelcl@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 523c0e0be884..bfe08f5f74a7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2598,13 +2598,14 @@ static int idpf_hwtstamp_set(struct net_device *netdev,
 			     struct kernel_hwtstamp_config *config,
 			     struct netlink_ext_ack *extack)
 {
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport *vport;
 	int err;
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (!vport->link_up) {
+	if (!test_bit(IDPF_VPORT_UP, np->state)) {
 		idpf_vport_ctrl_unlock(netdev);
 		return -EPERM;
 	}
@@ -2625,12 +2626,13 @@ static int idpf_hwtstamp_set(struct net_device *netdev,
 static int idpf_hwtstamp_get(struct net_device *netdev,
 			     struct kernel_hwtstamp_config *config)
 {
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport *vport;
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (!vport->link_up) {
+	if (!test_bit(IDPF_VPORT_UP, np->state)) {
 		idpf_vport_ctrl_unlock(netdev);
 		return -EPERM;
 	}
-- 
2.56.0.611.g1030f0b940-goog

