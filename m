Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CACC43334
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jun 2022 14:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5814A8400D;
	Wed, 29 Jun 2022 14:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5814A8400D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656513643;
	bh=UYetqUPMasGfo1Xmm76dBixoUomVcsXGh9128GCvmAc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bRCm84zO9FpiGk2aUenh4IsuJZivyOXeKpSfalmHomzzFiU7ADJupDGhN/CG8wQBc
	 lWGw9nHdrveBTsm6TukjNVjQFXWI0tTlc+lHhuMKBusQGTc5Ni3a2zLbrBWIw8cowv
	 Q+G8SYvhiaba/MNA5SUAz74cFkJNv8iEoSVJuHY90g+b9N3uiCdz7U8u6BuPkKt6Rr
	 2Gn0AZYTRQXEzqFievf2MLUE9n3FHlI0RAzpk28fdfyjhMXNVVlTqi3mX+uo9WeiNJ
	 um/4+SbgLrkECF9+K7/gM3fEbosOmoykRhoAWp/P/3jS8uhaZ6XHO4CuTMaYilRzzP
	 VvIGhmabcNzhw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PSUgIIrvQb12; Wed, 29 Jun 2022 14:40:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7213D84090;
	Wed, 29 Jun 2022 14:40:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7213D84090
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1BC901BF28F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0448D41799
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0448D41799
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iadgnX113rtf for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jun 2022 14:40:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18889408CD
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18889408CD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jun 2022 14:40:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343734793"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; d="scan'208";a="343734793"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 07:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; d="scan'208";a="595255561"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
 by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 07:40:25 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
 by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id
 25TEeJ3a022901; Wed, 29 Jun 2022 15:40:23 +0100
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: netdev@vger.kernel.org
Date: Wed, 29 Jun 2022 16:38:58 +0200
Message-Id: <20220629143859.209028-4-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629143859.209028-1-marcin.szycik@linux.intel.com>
References: <20220629143859.209028-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656513630; x=1688049630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tHizgFNnSXkpG46Dn3nJDt/CPuSpOnuIsvpe7rCWWTo=;
 b=ZdMW3PvijoWkFt2ZHBTDP+zoHv5Gqo0BwgJw87tjKHa9mv4oYSOs6+y6
 wsz74DpU299NFBL9w8nNu00758FCymO0mZorC5avCX9EUHqWNTr9m1XwV
 UGQ6VV5MZP4Ceac3d0bvnAkU3ZOH4zLhYdbGEAVkge+ZOMfFfdtTB5HDz
 Mr7ctnRe89HbnDZg2hOEEqemHxO6JkPz4lIfEDeiwV8jBNaexTQlJufsu
 nW/tQjV4AqUEeDRfkIbbAdUp+sYN996p4nATru0Hed+ROpq6SLik5drtz
 188ajuSwbLb0+/edQuBJy6Sk2ZuHTfZzy6HBWQDzoP6Ba3p5fDzEaFwt5
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZdMW3Pvi
Subject: [Intel-wired-lan] [RFC PATCH net-next v3 3/4] flow_offload:
 Introduce flow_match_pppoe
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
Cc: simon.horman@corigine.com, kurt@linutronix.de, paulb@nvidia.com,
 edumazet@google.com, boris.sukholitko@broadcom.com, jiri@resnulli.us,
 paulus@samba.org, gnault@redhat.com, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, zhangkaiheb@126.com,
 pablo@netfilter.org, baowen.zheng@corigine.com, komachi.yoshiki@gmail.com,
 jhs@mojatatu.com, mostrows@earthlink.net, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, gustavoars@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>

Allow to offload PPPoE filters by adding flow_rule_match_pppoe.
Drivers can extract PPPoE specific fields from now on.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 include/net/flow_offload.h | 6 ++++++
 net/core/flow_offload.c    | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 6484095a8c01..50283a30b97b 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -72,6 +72,10 @@ struct flow_match_ct {
 	struct flow_dissector_key_ct *key, *mask;
 };
 
+struct flow_match_pppoe {
+	struct flow_dissector_key_pppoe *key, *mask;
+};
+
 struct flow_rule;
 
 void flow_rule_match_meta(const struct flow_rule *rule,
@@ -116,6 +120,8 @@ void flow_rule_match_enc_opts(const struct flow_rule *rule,
 			      struct flow_match_enc_opts *out);
 void flow_rule_match_ct(const struct flow_rule *rule,
 			struct flow_match_ct *out);
+void flow_rule_match_pppoe(const struct flow_rule *rule,
+			   struct flow_match_pppoe *out);
 
 enum flow_action_id {
 	FLOW_ACTION_ACCEPT		= 0,
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 929f6379a279..d13d293e3de2 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -223,6 +223,13 @@ void flow_rule_match_ct(const struct flow_rule *rule,
 }
 EXPORT_SYMBOL(flow_rule_match_ct);
 
+void flow_rule_match_pppoe(const struct flow_rule *rule,
+			   struct flow_match_pppoe *out)
+{
+	FLOW_DISSECTOR_MATCH(rule, FLOW_DISSECTOR_KEY_PPPOE, out);
+}
+EXPORT_SYMBOL(flow_rule_match_pppoe);
+
 struct flow_block_cb *flow_block_cb_alloc(flow_setup_cb_t *cb,
 					  void *cb_ident, void *cb_priv,
 					  void (*release)(void *cb_priv))
-- 
2.35.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
