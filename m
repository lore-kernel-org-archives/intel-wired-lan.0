Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6283AECAAD4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Aug 2022 11:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C609B82B08;
	Fri, 26 Aug 2022 11:04:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C609B82B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661511863;
	bh=OYqtoBGkhg9hNBpo4d7e1O0ipa1eAWXhb/brRAnurH4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=gu5Y4Exfc7y28NyVdBoIag/nEzHSF3L6FR3gBTzDR828mE3BjLUkxo2Jdbno5rn68
	 JvROZEHHbplKLpMUOGpJJWFq/Wz/1znvdNvZUM+5d0SG6NpDRSEwGlFwJxyzDD+44u
	 dpLwgTYObWYquz2pQo+NtHoC1Aw7VI+I7sK7V69btQ4BKdLEF9Mh3EL3yVcjJMe8F+
	 7FFIxmMc+aCr10CGU95yzn8HtUbyNKIlY6z+XtfZz5K4BKD/VWFh21VxHdcOg3VbXC
	 XKNQTHeNOx3kxAOOcN/Igd6MvNRKuu8VjeorVhxJrqhXWk7dlGAUoxE88M7S0NCFIo
	 L6WB7Wp/SVc+Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rnin1EZkJufE; Fri, 26 Aug 2022 11:04:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7A5E82CFD;
	Fri, 26 Aug 2022 11:04:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7A5E82CFD
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 4BCA71BF289
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Aug 2022 11:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D8CB82CFD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Aug 2022 11:04:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D8CB82CFD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hTWxqmeOl5Hg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Aug 2022 11:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26CD182B08
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26CD182B08
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Aug 2022 11:04:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="358448429"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; d="scan'208";a="358448429"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 04:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; d="scan'208";a="678830889"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
 by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2022 04:04:14 -0700
Received: from switcheroo.igk.intel.com (switcheroo.igk.intel.com
 [172.22.229.137])
 by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id
 27QB4CLq024087; Fri, 26 Aug 2022 12:04:12 +0100
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Date: Fri, 26 Aug 2022 13:00:54 +0200
Message-Id: <20220826110059.119927-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661511860; x=1693047860;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mVfFXbHXdc5J9BNZWgXlaSHs05hfNO32943brAaakqA=;
 b=RitC7Zj9FYYnz7paxYZuBYlLzh8IBDlrIsZWuhEiBbOrxstEckqS0UTj
 /2AwHRQHJCQOUQ+IKLZ+GkUAd6cMdBld4w35xKg3qLdjHZ4oSaJLfsjzz
 3+qTYPIxz8LpN46ze0wiMoJYe6SvKpKAExu5aUkDnRjEqSiRdul/XSPUN
 6P4Ybx4ih2L8hwwePsMWjEpqIEz8eXYi4eI5S+HFpmU7UQlUa5N+4P7U8
 7aHu6lxvgILxChkndN7c8JB70FSlAcQhyBbuuk5IB9G5zbMYmZ1jUMog3
 yshttmsINe6GN2rNWIn4zBgPZvJBYCBRkPbq9PR1ME72zT/QaGMS1ExNf
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RitC7Zj9
Subject: [Intel-wired-lan] [RFC PATCH net-next 0/5] ice: L2TPv3 offload
 support
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
Cc: simon.horman@corigine.com, kurt@linutronix.de, komachi.yoshiki@gmail.com,
 jchapman@katalix.com, edumazet@google.com, boris.sukholitko@broadcom.com,
 louis.peens@corigine.com, gnault@redhat.com, intel-wired-lan@lists.osuosl.org,
 vladbu@nvidia.com, kuba@kernel.org, pabeni@redhat.com, pablo@netfilter.org,
 baowen.zheng@corigine.com, maksym.glubokiy@plvision.eu, jiri@resnulli.us,
 paulb@nvidia.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add support for dissecting L2TPv3 session id in flow dissector. Add support
for this field in tc-flower and support offloading L2TPv3. Finally, add
support for hardware offload of L2TPv3 packets based on session id in
switchdev mode in ice driver.

Example filter:
  # tc filter add dev $PF1 ingress prio 1 protocol ip \
      flower \
        ip_proto l2tp \
        l2tpv3_sid 1234 \
        skip_sw \
      action mirred egress redirect dev $VF1_PR

Changes in iproute2 are required to use the new fields.

ICE COMMS DDP package is required to create a filter in ice.

Marcin Szycik (1):
  ice: Add L2TPv3 hardware offload support

Wojciech Drewek (4):
  uapi: move IPPROTO_L2TP to in.h
  flow_dissector: Add L2TPv3 dissectors
  net/sched: flower: Add L2TPv3 filter
  flow_offload: Introduce flow_match_l2tpv3

 .../ethernet/intel/ice/ice_protocol_type.h    |  8 +++
 drivers/net/ethernet/intel/ice/ice_switch.c   | 70 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 27 ++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  6 ++
 include/net/flow_dissector.h                  |  9 +++
 include/net/flow_offload.h                    |  6 ++
 include/uapi/linux/in.h                       |  2 +
 include/uapi/linux/l2tp.h                     |  2 -
 include/uapi/linux/pkt_cls.h                  |  2 +
 net/core/flow_dissector.c                     | 28 ++++++++
 net/core/flow_offload.c                       |  7 ++
 net/sched/cls_flower.c                        | 16 +++++
 12 files changed, 179 insertions(+), 4 deletions(-)

-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
