Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7A9C48BC3
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Feb 2024 10:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35689408F0;
	Mon, 19 Feb 2024 10:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dnxsbTdbmqkK; Mon, 19 Feb 2024 10:22:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF00B40A14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708338145;
	bh=IGnZuQAAnxyfkcuRXNmUQ9M9oh/by0HBvKdFxUnbr5o=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9BJQV0EI4W5qf2cAM0kFfCaZBaM8iSsNhIlYPoGMp/UdoPefzhlv8s0D/3vhkPrhy
	 CkeZ0G3RIjn2Jp6X4D52Ly9ftF9Rv+2SnjwUpx2wNvrzoOdQ/NdnU12UCUAOzSVZ8t
	 T9S+7DykOAySE2DcY0F1Xx7lP7sjIGfxrNXy2vLKdXOcAu3ZrdMVBA3+GZT6NjNjQT
	 HwzgQxiAf4wACjC9+FzOTB9ZQHe0ld+dEKt9Ax/zO4Ahu13h4OMaEkdQvPNJXF4AUw
	 4VI4y27NmxKG/nr+eo4A4YrpX32EMwH5KSLqkjbQz7w4P07GfLezFG85s5tL9syvmC
	 zPzg07R6MzRVg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF00B40A14;
	Mon, 19 Feb 2024 10:22:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 8745C1BF3DB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Feb 2024 10:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7358640797
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Feb 2024 10:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajhAJG8VNorK for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Feb 2024 10:22:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=mateusz.polchlopek@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9AE4D40794
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AE4D40794
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AE4D40794
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Feb 2024 10:22:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2514759"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2514759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 02:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="826984903"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; d="scan'208";a="826984903"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga001.jf.intel.com with ESMTP; 19 Feb 2024 02:15:05 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 84A2E135F0;
 Mon, 19 Feb 2024 10:15:04 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 19 Feb 2024 05:05:59 -0500
Message-Id: <20240219100555.7220-6-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708338137; x=1739874137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DT+HJ/MRBgBoch9D0gcN3G58vRVjIVWEk0CwB5FZWGk=;
 b=cquIF8H7gese1yXWFmUzfa4T9OQ+R8LaXKnPLSKe+5q6JNVtOAQMYpA+
 bJnR/3k3sYtgOD9y9y48wwzpNR5CpmTEPzEeV5Kjwcfj1PBIKdrZjDq3K
 vbVYIcNq7B5egd00qYM6b01Q/QQohIooqDwEIEHsRUMDGknT93FIJuWvZ
 y0gON/k7561qfoVhtlLBmqiKAH+6Gvp0AWLWfQ1PO3zS4zTIMq28PfOSL
 KCmf3E63p+X4uyqkeiSLgNpHbTrs7tuJID4xRy4dNfmGoUsADIURc66Js
 azHpMHz4p/ZEX1yb0aSTPNvgHQ93VZr0lhEEspTTypEVdZM6eNU3wFvhg
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cquIF8H7
Subject: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: Document
 tx_scheduling_layers parameter
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
Cc: netdev@vger.kernel.org, Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Michal Wilczynski <michal.wilczynski@intel.com>, horms@kernel.org,
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Michal Wilczynski <michal.wilczynski@intel.com>

New driver specific parameter 'tx_scheduling_layers' was introduced.
Describe parameter in the documentation.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 Documentation/networking/devlink/ice.rst | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index efc6be109dc3..1ae46dee0fd5 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -36,6 +36,47 @@ Parameters
        The latter allows for bandwidth higher than external port speed
        when looping back traffic between VFs. Works with 8x10G and 4x25G
        cards.
+   * - ``tx_scheduling_layers``
+     - permanent
+     - The ice hardware uses hierarchical scheduling for Tx with a fixed
+       number of layers in the scheduling tree. Root node is representing a
+       port, while all the leaves represents the queues. This way of
+       configuring Tx scheduler allows features like DCB or devlink-rate
+       (documented below) for fine-grained configuration how much BW is given
+       to any given queue or group of queues, as scheduling parameters can be
+       configured at any given layer of the tree. By default 9-layer tree
+       topology was deemed best for most workloads, as it gives optimal
+       performance to configurability ratio. However for some specific cases,
+       this might not be the case. A great example would be sending traffic to
+       queues that is not a multiple of 8. Since in 9-layer topology maximum
+       number of children is limited to 8, the 9th queue has a different parent
+       than the rest, and it's given more BW credits. This causes a problem
+       when the system is sending traffic to 9 queues:
+
+       | tx_queue_0_packets: 24163396
+       | tx_queue_1_packets: 24164623
+       | tx_queue_2_packets: 24163188
+       | tx_queue_3_packets: 24163701
+       | tx_queue_4_packets: 24163683
+       | tx_queue_5_packets: 24164668
+       | tx_queue_6_packets: 23327200
+       | tx_queue_7_packets: 24163853
+       | tx_queue_8_packets: 91101417 < Too much traffic is sent to 9th
+
+       Sometimes this might be a big concern, so the idea is to empower the
+       user to switch to 5-layer topology, enabling performance gains but
+       sacrificing configurability for features like DCB and devlink-rate.
+
+       This parameter gives user flexibility to choose the 5-layer transmit
+       scheduler topology. After switching parameter reboot is required for
+       the feature to start working.
+
+       User could choose 9 (the default) or 5 as a value of parameter, e.g.:
+       $ devlink dev param set pci/0000:16:00.0 name tx_scheduling_layers
+       value 5 cmode permanent
+
+       And verify that value has been set:
+       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
 
 Info versions
 =============
-- 
2.38.1

