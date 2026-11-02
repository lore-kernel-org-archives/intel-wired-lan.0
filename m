Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6E606A337
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Cp8pqR+y;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h4QRBTcq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33F8840730;
	Mon,  2 Nov 2026 10:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yzvoCndjS4EZ; Mon,  2 Nov 2026 10:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F84A40752
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793616396;
	b=kh5SrEIIVljiaWSa7Tzqc9CR/rEDuY+i3HFqMrWXC4SpgjsVvAhvEIm+D4tQ9JM2mt2Z
	 9Q2j4rZXf17nA5slyc6vZFhu1SJL2ob4T3U1yhi1kVLxKKwyhxNy5ufJcAN8hmGKavF5Y
	 GiC6CkHdckrdpBSSwtT21QYF+LRASs4jA3YgW7kK6Pz4sCzcDz/ZbLca1ONvPjCJM0LOh
	 vvNVFpMUOx7BjjFWza4L0AkjbHMhTyf5SWgGn+UdPVer9gxQ3T0rxwDjcJx1I60v1hK70
	 jzvMeWsdJHBo1zUIE4noqgyjm3C0w5lEUtKkBOiyctVgDlfwrhmPsrlkeL/F+BZLgRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EpbIBsCL2Gelwm0gnFKEDFKVP67syfArtemZZbQZRac=;
	b=Qgbi2loIJiCGDLOYuG+PfcyAV+Qllkibwo1LiJiaiyERwiaE3S+QVWBLjMVCSSbrkae3
	 AEhdVZ1Dx8gwOFmMOvfLWilcyt/+Q8UNFgE6QLM6PDkmBqIEbFxdX2iZBPhzOcBj059r8
	 L/yDt/kWcDH9ZBRyjHBa+Pf0HApmt+DGAkSH56cK3pdFK0T1euOh9Hw8Wj6ZjEADH/5Ds
	 1HX69NJlyaESgCFjII05MAgierl7g7iV2hlbGDbUe2yWu8dWiLjOjZRvBRvPPJt3vK7nj
	 bOVg9S8eZB2MP585CxlN+VOiBo5UjWSzs/mFtpScix+ilpkhYq5MQHl3m4bWUv+XiaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h4QRBTcq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793616396;
	bh=EpbIBsCL2Gelwm0gnFKEDFKVP67syfArtemZZbQZRac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cp8pqR+ygHzrdGRCleGyg15CSZchzHoci4F/enCvVYrT58TDObni5SHwRrBcXnLLm
	 Bi99jtRod48kolDPkT6BO4u7AwNj8wjOSWpNR1v0AN45GJoF5AP7LGvsKtOD4/nJDa
	 ec8GNN/7opt1+29gA3lWok2UTI8qy3ySN0Q5euMYEMPzZ+sp9hW+WFik2JHEa/bUJg
	 XowgoeihQOHJkTrWezLn0inwH+NeIvRphmG+GGF1qXnODIXSzRwGs+nDeuzRvOZB5l
	 8mnRbENBx/ngMtv4iT9/cRWHpnsodnq9rZtWUQc5DfBqSb5jpZk2GF7Qfxuwb3FfsN
	 IHK7pO1Z6j7dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F84A40752;
	Mon,  2 Nov 2026 10:46:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D3FFD3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F66440730
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJdlHDf94zBV for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 10:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6276340719
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793616393;
 b=amZ916i2esZKamoBPWtVLFtgdvpSzJMMlNNW2e84E1hYV+yfSoQ6rt8yVka1ThTR58rp
 ifepKd1B1DBA5Wt73R8ZNWRgdYTtoVbQXybbISu6TXLOmane46ey1bWaFdwiYhMJBTS0J
 NvoIZPStXYdNrDtuP+AIKh1rfoftceMxQmH8sB0toqoNxV4zkh6K/5tZVjW2NJLhE/7Vv
 V9URV0YTJlCnqbF3AJ0w3ua9JylW9rkdgqNbJkL2ex4DMZKWw9ZpTaPY3dKhZ4ueSOcTw
 X/pkarzw1g0gQFTvgLovrBwCDtSwPdeFwCM5U7QoaTCxyP/rqyIY8o91yHoXUbG63jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793616393;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EpbIBsCL2Gelwm0gnFKEDFKVP67syfArtemZZbQZRac=;
 b=H/9SFXMv1Ha0Jn5nSmL6bQm427xCU0mo2TMqjsGtNUE1LRxyDIxWl+hXSDm1sENIuFm5
 I7onn6jjUBgsO5LH72P+vBhk5VCVMZdSefVr87MH1uVRTaVwm1d4w0YcktyfX9wsX6FXS
 MT858Vv33rvASNKG8o0jlfiCOHGq4gRTUsMHxZ3ykgv4byyvjug8/FAhoTJsrYQ+PQKFr
 tobEaMIpFiDz0M6Q5tpn3uU2DaCdyzEdgqBXn1l1FnDD/qfvYLtCD8X3TGl4ls9Zc5vD2
 0s6Z5PriO5no9G/6QfAc1DC1xI37ery5pw0/cq7ETCiygtFZ/RSnW9SrPGoqIyDSypg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=h4QRBTcq; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=h4QRBTcq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6276340719
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793616393; x=1825152393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZZ31yo5800+JACi9OIQacH893m5RVhuD/0Qx7nxKPVY=;
 b=h4QRBTcqcqLTVt4afdDYzbZlZrcoFydUk3Q5RM2RuJKUvJWHlPqwxxlJ
 Zvh+dH7gp8odL9+i7GzVvmjDpn+gIKBUdqQrBxWtxiJxOBthB+ty7GRkj
 DyLWhTU1+WGTYX8uee4i9rouz8M5V93PmtmkpjYfv43kJX6aMEcMoEXvF
 YNxrVBNWIoe8SXqxPvGx78f6pDx0+5Tg+SODS2oTInIKlY0p5k8bykj88
 V6jijjxQ9ORUoaQd4NDkoj7knPlYqwWlveqIaKdNCyXEffcLqSIm2D9Zy
 I8UvJblRRzQsd2+dZax+Gel2E1hea+6P0TGhWeVn2xWaifC+9lupBZHFU Q==;
X-CSE-ConnectionGUID: 9SgOhRyWRVO1AzLqkUCW/g==
X-CSE-MsgGUID: UR6M5DTHTO2JIhiSZl7LNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305031"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305031"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:46:31 -0800
X-CSE-ConnectionGUID: 90pEQXsLSIK9ChzcXryxbg==
X-CSE-MsgGUID: kmT0w3QZTj+bplELH8X9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012005"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:30 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com
 [10.217.184.18])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 4B1612876C;
 Mon,  2 Nov 2026 10:46:29 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 3/6] ice: clear stale rate_node pointers in
 ice_tear_down_devlink_rate_tree()
Date: Mon,  2 Nov 2026 11:50:18 +0100
Message-ID: <20261102105346.30739-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_tear_down_devlink_rate_tree() frees the devlink rate nodes with
devl_rate_nodes_destroy(), but leaves ice_sched_node::rate_node pointing at
them. The pointers are only reset when the last representor goes away, in
ice_eswitch_detach().

If DCB is turned on and off again while representors exist, the next
ice_devlink_rate_init_tx_topology() (e.g. on adding an SF port) sees the
stale pointers as already exported nodes and passes one of them as the
parent to devl_rate_leaf_create(), which writes to freed memory.

Clear the pointers before destroying the nodes, as ice_eswitch_detach() does.

dcbnl ops can call ice_tear_down_devlink_rate_tree() while a reset is in
flight, or after a failed one, when the Tx scheduler tree is gone. Make
ice_devlink_rate_clear_tx_topology() skip the clearing then, as other Tx
scheduler helpers do when the port is not ready.

Reproducer:
  PF=eth3
  BDF=$(basename $(readlink /sys/class/net/$PF/device))
  ethtool --set-priv-flags $PF fw-lldp-agent off
  devlink dev eswitch set pci/$BDF mode switchdev
  echo 1 > /sys/class/net/$PF/device/sriov_numvfs
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:50 1:50 prio-tc all:0 4:1
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:100 prio-tc all:0
  devlink port add pci/$BDF flavour pcisf pfnum 0 sfnum 1

  BUG: KASAN: slab-use-after-free in devl_rate_leaf_create+0x109/0x390

Fixes: 86197ad5800b ("ice: set Tx topology every time new repr is added")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 8c2b63eef82b..044aa62be473 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -705,6 +705,7 @@ void ice_tear_down_devlink_rate_tree(struct ice_pf *pf)
 	}
 	mutex_unlock(&pf->vfs.table_lock);
 
+	ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
 	devl_rate_nodes_destroy(devlink);
 	devl_unlock(devlink);
 }
@@ -842,6 +843,10 @@ void ice_devlink_rate_clear_tx_topology(struct ice_vsi *vsi)
 {
 	struct ice_port_info *pi = vsi->port_info;
 
+	/* the Tx scheduler tree is gone during a reset */
+	if (pi->port_state != ICE_SCHED_PORT_STATE_READY)
+		return;
+
 	mutex_lock(&pi->sched_lock);
 	ice_clear_rate_nodes(pi->root->children[0]);
 	mutex_unlock(&pi->sched_lock);
-- 
2.54.0

