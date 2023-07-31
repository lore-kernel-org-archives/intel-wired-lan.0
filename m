Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2F2C04FE1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Jul 2023 13:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 170F2408B6;
	Mon, 31 Jul 2023 13:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 170F2408B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690811972;
	bh=C0tbZAr0pJFiGmn48gzzX7LQtXHlY6NT8X7Iz/8Bvo4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=5Ubyeb1LhBZvtl1muKxWIwutsn1Lm9zyEOAqdSqdFhBH8w+Ux0w0AyHoGws9+RTkN
	 pErdS3rtdtQF68kV4gCtKr0HrIaiiBDHKDsHJrrSCa/aHL26Utb0dngsEzJSve7IRt
	 77Y2WFV0uPF2ZTUyUKNcHzAEL0SaCpuwFvSS/gIktFYWfv6C0ut30C+tCMpOeHYP//
	 W1dC4tDX7lEWVwj4OVlzK4QR6VqIKN6ERQr8H4iBOnXZGKioaIBBCDiKDjcvRF3BbJ
	 mGgJAIv88LmcZ9qOMN0GX0gIVQp6Bi/5H7hofZ4ihY3JetmQ0QgOjStiuMhHwcGI9W
	 U2maz1irGLYiw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MevMOJKh4U6j; Mon, 31 Jul 2023 13:59:31 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9EA140998;
	Mon, 31 Jul 2023 13:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9EA140998
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3237D1BF37F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 13:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07622403C4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 13:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07622403C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I5srx3EPzFHh for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Jul 2023 13:59:27 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCA7E401B7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 13:59:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCA7E401B7
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="348621035"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="348621035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 06:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757951536"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757951536"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 06:59:23 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 31 Jul 2023 15:52:18 +0200
Message-Id: <20230731135218.10051-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690811966; x=1722347966;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FLzU3pA/+0H8iLwjfinK0J+eRdmmpjynTV8LPGQR8c0=;
 b=N0T/QfJDYSK2JN5t1JGBM3znZZbv51WlNI4jRgZ9hIonqoC7ZV1y/pAo
 PNiLVLwkc17g3X+HEJ5XuvKCQXfHS6ums9I2dEZMZSdSEdX7fPCFrFoBa
 hE+N0m+u6UyOrmvB7QUgkVxFEHPl+nD0Z+FsFBsVLCS8h3UicqH1VyqUJ
 /Ln5Vuqg7ELzjcGyd0kvVHiSxQIj5k2S9Ue27+VrvSKiM4nniXCNpdiPC
 rptAVpIyoa4HIEpUN6qAiou7hVBaTxFQYzxxj0VNE33OFxc85DuIzxr08
 JbeJk4uwm40fGG8Xvhr1l+SH8KnzZcCxjEjKwW3siO/4J4IZGNjac5NmQ
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N0T/QfJD
Subject: [Intel-wired-lan] [PATCH iwl-next v3] i40e: Clear stats after
 deleting tc
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

There was an issue with ethtool stats that have not been cleared after tc
had been deleted. Stats printed by ethtool -S remained the same despite
qdisc had been removed, what is an unexpected behavior.
Stats should be reset once the qdisc is removed.

Fix this by resetting stats after deleting tc by calling
i40e_vsi_reset_stats() function after destroying qdisc.

Steps to reproduce:

1) Add ingress rule
tc qdisc add dev <ethX> ingress

2) Create qdisc and filter
tc qdisc add dev <ethX> root mqprio num_tc 4 map 0 0 0 0 1 2 2 3 queues 2@0 2@2 1@4 1@5 hw 1 mode channel
tc filter add dev <ethX> protocol ip parent ffff: prio 3 flower dst_ip <ip> ip_proto tcp dst_port 8300 skip_sw hw_tc 2

3) Run iperf between client and SUT
iperf3 -s -p 8300
iperf3 -c <ip> -p 8300

4) Check the ethtool stats
ethtool -S <ethX> | grep packets | column

5) Delete filter and qdisc
tc filter del dev <ethX> parent ffff:
tc qdisc del dev <ethX> root

6) Check the ethtool stats and see that they didn't change
ethtool -S <ethX> | grep packets | column

Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: Make the commit msg more detailed
v3: Correct the commit msg
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 29ad1797adce..e8e03ede1672 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5885,6 +5885,11 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 
 	/* Update the netdev TC setup */
 	i40e_vsi_config_netdev_tc(vsi, enabled_tc);
+
+	/* After destroying qdisc reset all stats of the vsi */
+	if (!vsi->mqprio_qopt.qopt.hw)
+		i40e_vsi_reset_stats(vsi);
+
 out:
 	return ret;
 }
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
