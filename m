Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7977BC5DF87
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C6F60896;
	Fri, 21 Aug 2026 13:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBEgpzmJSX5R; Fri, 21 Aug 2026 13:02:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787317324;
	bh=kgfYJ0OS3v9OVnlW4ghWV/utX1NlmQRbFaMq+u22tKk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cMeuhrJPX4E3uRfJNLIausPPzMewrekjh0T8uLjdqSI53QZ8NjYntswk8lZsVs2Ru
	 SY7N1CoCyG8pb6Zjj209e2FyYJPQoy3Xzfdc3bmDw0dhX+/9yEEor+qdmnZPBeKVqC
	 l9KU4j9Z19Ly2BNhUY9+c9yXgP5hI/lF3Bywd3PHa/AwIgY02ffz654mjtzZVfQLRu
	 9czYq1nGWsim9Iw6+Y3nZm+bYLVyd2Cew0TgC3ojneplpv5wmSYz9l4hRR+CGdrCzn
	 8CTRI4EeMZli2kDggFZP+jAuvouKas50FRsxrHBZB2vm7s53D708JrpAcjIexZh2kF
	 4jvhr6xvT8i2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 539AE606BD;
	Fri, 21 Aug 2026 13:02:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 06050EA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0B4540962
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tefrqo6bOFPc for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 13:02:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ub2bPqmP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00736405EB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787317322; x=1818853322;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nw3iUyLxXldjaUCaQJDPrq3oYRJPiB2mPDaxB+mHRck=;
 b=Ub2bPqmPVaG4XkggJjbOb32eowGtGU3Jmzf9mwkyW1H8w6aDNP1/G0AI
 xrgGm66rDKJI0yjx7eLl/XdAN1iRs8Tj36TzniqG/KYE/o8ddcR3K5Sxa
 ExzTKBRJUN4s9CRLrEPnyyYDMeUANsDYNTJdunP5vChQeG2JPzTSR5Yzr
 FOCAzqStS5FDxYiOasStrmrQgTLn5ZrZ3Ih3l3gh2VY8E5IO7q8lKJFeh
 d8PZBCyn88mO0LqvgLOixpI7puNYlLTbu14iPzkiWTVyy4jyL/7IA53me
 L0kQnF6ZBv0K0dGaozX05JrNBM7I86Kd2B+6Vvxa3XK6BxM671zBX5Qab w==;
X-CSE-ConnectionGUID: MU4C7Cm6TRuIRLOWSiKt1w==
X-CSE-MsgGUID: t5d9Ocq2So2Tb0AEVF0O6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="75400961"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="75400961"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 06:02:01 -0700
X-CSE-ConnectionGUID: USNqRBxKQ0OgKvCPieX+Ww==
X-CSE-MsgGUID: GOh2slfXSJeSDoOtm9AlAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="271568479"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 06:01:59 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2 0/2] i40e: fix set_ringparam error path crashes
Date: Fri, 21 Aug 2026 15:01:55 +0200
Message-ID: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

i40e_set_ringparam() has two independent ways to crash a live queue
while resizing descriptors. Both need a failure injected into the
middle of the resize to hit, but both are 100% reliable once you know
where.

Patch 1 is the reported bug: the free_tx: label frees vsi->tx_rings[i]
(the live, NAPI-active ring) instead of &tx_rings[i] (the staged copy),
on Rx allocation failure. desc/tx_bi go to NULL under a running NAPI,
next poll dereferences them. Reproduced by forcing an Rx alloc failure
right after a Tx descriptor count change; panic address matched the
original report exactly (CR2 == old_count * sizeof(desc)).

Patch 2 was found reviewing patch 1. The staged tx_rings[] copies are
shallow copies of the live rings, so they carry over the same
ring->netdev/queue_index. Freeing one of these copies before
i40e_down() has run - either from this same free_tx: label or from the
i40e_setup_tx_descriptors() failure unwind loop above it - resets BQL
state for the live queue it was copied from. dql_completed() then
BUG_ONs the next time the live ring reports a completion that was
queued before the reset. This one predates patch 1's bug by four
years (Fixes: 9f65e15b4f98, 2013) and doesn't need patch 1 applied to
be reachable via the setup_tx_descriptors() path.

Reproduced by forcing i40e_setup_tx_descriptors() to fail on a later
queue while flooding real Tx traffic on the earlier ones:

  kernel BUG at lib/dynamic_queue_limits.c:99!
  RIP: dql_completed+0x285/0x2a0
  Call Trace:
   <IRQ>
   i40e_napi_poll+0x74b/0x1700 [i40e]
   __napi_poll+0x10a/0x200
   net_rx_action+0x2f7/0x380
   handle_softirqs+0xcc/0x270

Confirmed clean with the fix applied, same traffic, repeated
resize cycles.

Patch 2 touches both error paths above, but only the free_tx: hunk
needs patch 1 applied first to match its diff context - the
setup_tx_descriptors() unwind hunk applies, and matters, on its own.

Cc: Simon Horman <horms@kernel.org>

Aleksandr Loktionov (2):
  i40e: fix set_ringparam error path freeing live Tx rings
  i40e: avoid resetting BQL state when freeing temporary Tx rings in
    set_ringparam

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.52.0
