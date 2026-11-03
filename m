Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BC606EE85
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LYL1beQU;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+42ZTuG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2220460830;
	Tue,  3 Nov 2026 14:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LqU7jgch_ZtS; Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1629E6083F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716805;
	b=Z5ZHbAdCykv7MyCtuJgULe/BUl4xKegIfZVE9rOmx0D1n68zH/CqBPDGsRRWcUtuXGxs
	 UM2hboRZjuYHNdcU7ExCnOhydTaiI+NqJcpUlPrpvQO/8vI8lelZ3dcBOk4+5le0jscas
	 Ni9+AZZPsvHOItogBsuwMjxxe8+FSCp0gcVz7a0z1wtAoRDQDXgWAc8iyHS0JSC9jUl2a
	 tjn64KeqghQt/KzwAczQ+BFSYbPU+vK0uEKQbyhJCfNNSujfAX4uvx+WbjxXraV/BIg7V
	 9XG4fYpJ/9xaVkYclqYCrSHwypM8+QRDi6Mtm9J3b1WeeJWKOuI3HAU2foDnbH/tiYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716805;
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
	bh=6kTVfuUhbdsbM+LLqVWSVh6IMXw8iPu+yfHFxb6lm+E=;
	b=VTNeb+38Npncmrap/CBk8OcOgI1onYbJ6I/4u6RkA3ljHk7EJQZYMbLg3pvqIaXQxycA
	 huf0YVHuDUhVivn3yntx3a5BV9+T5lzKP/gkwTq/LWctqOZycnNwE/45Uk8+TLHdNb0el
	 c1m4ux/ftdaXOm5ZYpPU1NuJgFsOcWDDyAGSL/Js27tJ8LlEsXiMPKesiNVyLqW6yJQiH
	 /gJx4DYN1gx3qSQ8J7RmEWQjd1ku7VdRcAHEgiFAIvvM6dfknxlfTjgdPuNr8rr8Zw0oT
	 CxrnFV11aDNPJr87QN8UYPEtjYkBCax/eUJvrIrq4iPMab2trSCorci6zL9vn8V7Rvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716805;
	bh=6kTVfuUhbdsbM+LLqVWSVh6IMXw8iPu+yfHFxb6lm+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYL1beQU/zoXrl+J5fw01z+77pH3oDksXCnci3wulQL3H6NW9xb20HmVi3ASzYWyj
	 9KMHZV4A7EDBeRa959BN2cxLIhCyQuglVX+jhigbnBZxbREeExFRYujRN49ldvgP+h
	 NtrZVPxAAjyemnZGI7M/bpUxEnBlpsvebdtrRGgcvnl4qJX13lsm4hk0ziyM/mO2ib
	 //qVPbnQexpN824+gHIwr/LvxQ2Vrv7vitpGlL4P6VzvjuX2u0Y1lA/qxsSSdKaaF/
	 pDna3djEs380ByeEp+5lSBGL3QBMOCvvYjRKUzfj1TCA+5hqIoDjwMH7uM9ul1C53Q
	 u7KItfGQMn5NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1629E6083F;
	Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F240356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80D00406FA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7soqz37R6nGE for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:40:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8775040704
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716800;
 b=Diu/Qjmc6eAWhh0oUgyubiH4TGUpW3vtK9QeyrWLO6DeUVxZd1s2YGtyivgFu5co52KZ
 Ljs0LG5Cok5LgTwvbqeiu8PSRiE11gtEbIkV5owbj3JlHE/TmpmzlnK4UAz3RT84ydQLK
 HJg7slG5+qe7rAlSSM4qrwd5iO+cM5XSziF0onJDlkz5T2nzfBiYEaxWtj8LKhHRna35Y
 RaYRGKHUI7rUjKF2qlDKk7tqTCBXYkIAOOhm75F9jlcfanMGHTKarskDuJfzR08+jIkTx
 4rBQimMVvbQsif7OZjyhYn2ZMQN0ArWm8bXu+RUP0zzKPV/b49fbsMnL4yhaiKT+AiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716800;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6kTVfuUhbdsbM+LLqVWSVh6IMXw8iPu+yfHFxb6lm+E=;
 b=ozHelbZ9Dd9Pjh/v0OnRFsZOwaX9bCiankWs7k1aUMA4ewYm2/BkqSAX3pe3ZWE8XXoF
 iGI8z86ITJiYOVGkM0CZTX/fv/w1O5uJoi1diyJbjgom2Rj0o8L3n7yb+GY8ujS6FteFm
 TN4E4JyiJ9Sh9LUnBQLNamt9budzz0mtmmH0QueUzwmehQewm4kuVw5SfenqBsIYsHCB/
 cM8Ybv0uNzfwYHBvrBm7fOoRQ95PcfQECFTP/+sJlTL+EIwkKXOPLyARk7LRgHIONG4Z/
 BPBeRUuyWnJeX1fFoRdhHJGHf24Ajf9DowXbuQUgJq0UsJfuDDyiAevkBxJwHhOd54A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=W+42ZTuG; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=W+42ZTuG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8775040704
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716800; x=1825252800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tr9VEmpJjfxjN7vqujBo9YzKiv7dcq81i+Ms4xvENf4=;
 b=W+42ZTuGJprgkwhYybqCus3zQkjK4L3/r7x37mmTd0G51TYAEdvXWI2A
 0iHUERsdNN3MdJ4z0c3c59ZUoHB9YWj/EPZ/J3gbvUiC4wqp7mFkyPSwt
 mYCeZORop21TZIlDWpcNTdrkB0I6T6eJLHsvdkHn4Wg2gFQ8JCY83PyeV
 AWYqxlsMCiKd2BC8Gcj3GhPBP2Hscd2Ly+d6kFyEtEXzrF9C6GOZCic5D
 CFMZo4fR/4B6QNhrjRt/CRFCHgiaQnp0oiIkrttiIU5fMJnTXIMfNxz8n
 ExtuFnqH9SeqASmi2xMesYEq5NwZnBLIc/t8nhuP38L17Jo/Yl8r/zyyJ Q==;
X-CSE-ConnectionGUID: oHqgH5t5QQqUltqaypPUEw==
X-CSE-MsgGUID: 1P7GgeenQ9qqHoBbnEi/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324073"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324073"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:40:00 -0800
X-CSE-ConnectionGUID: bY9OcGsVT6aZfJapL3JdEQ==
X-CSE-MsgGUID: D/Rp9GLmTEmNzd5w7DmqRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289964"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:55 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id BEA68312E9;
 Tue,  3 Nov 2026 14:39:51 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 09/15] iavf: increase max number of queues to 256
Date: Tue,  3 Nov 2026 15:14:50 +0100
Message-ID: <20261103141646.303620-10-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Increase the max number of queues that driver will handle to 256.
Use old legacy limit in the virtchnl handling of iavf_map_queues().
Limit the number of queue vectors to 64, as VF interrupt registers
cover no more.

The netdev is allocated at probe, before the PF tells the VF how many
queues it may use, so it now always has 256 Tx and Rx queues. Whatever
is sized by num_tx_queues grows 16 times: the default qdisc of an up VF
has a child per Tx queue (about 6 MB with pfifo_fast, 17 MB with
fq_codel), and ethtool -S lists 256 queue pairs, unused ones as zeros.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * limit MSI-X budget to 64 queue vectors, VFINT_ITRN_64 and
   VFINT_DYN_CTLN1 have no room for more (Sashiko)
 * change ADQ total_qps to u16, a sum of 256 queues wrapped to 0 in u8
   (Sashiko)
 * commit message: mention the cost of the netdev sized for 256 queues
   (Sashiko)
 * program ITR of vectors 16..63 via VFINT_ITRN_64, VFINT_ITRN1 has room
   for 16 vectors only (Sashiko)
 * revert dropping of "_i=0...15" from IAVF_Q{R,T}X_TAIL1() comments

v2:
 * change iavf_q_vector::num_ringpairs to u16 (Sashiko)
 * drop the stale "_i=0...15" range from IAVF_Q{R,T}X_TAIL1()
---
 drivers/net/ethernet/intel/iavf/iavf.h        | 10 +++++---
 .../net/ethernet/intel/iavf/iavf_register.h   |  2 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 24 +++++++++++++------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 15 ++++++------
 4 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 053f34c4f710..60ee3a195567 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -87,8 +87,10 @@ struct iavf_vsi {
 #define IAVF_TX_DESC(R, i) (&(((struct iavf_tx_desc *)((R)->desc))[i]))
 #define IAVF_TX_CTXTDESC(R, i) \
 	(&(((struct iavf_tx_context_desc *)((R)->desc))[i]))
+
 /* for "old" virtchnl opcodes that accept up to 16 queues */
 #define IAVF_MAX_REQ_QUEUES_VCV1	16
+#define IAVF_MAX_REQ_QUEUES		256
 
 #define IAVF_HKEY_ARRAY_SIZE ((IAVF_VFQF_HKEY_MAX_INDEX + 1) * 4)
 #define IAVF_HLUT_ARRAY_SIZE ((IAVF_VFQF_HLUT_MAX_INDEX + 1) * 4)
@@ -108,9 +110,9 @@ struct iavf_q_vector {
 	struct napi_struct napi;
 	struct iavf_ring_container rx;
 	struct iavf_ring_container tx;
-	u32 ring_mask;
+	DECLARE_BITMAP(ring_mask, IAVF_MAX_REQ_QUEUES);
 	u8 itr_countdown;	/* when 0 should adjust adaptive ITR */
-	u8 num_ringpairs;	/* total number of ring pairs in vector */
+	u16 num_ringpairs;	/* total number of ring pairs in vector */
 	u16 v_idx;		/* index in the vsi->q_vector array. */
 	u16 reg_idx;		/* register index of the interrupt */
 	char name[IFNAMSIZ + 15];
@@ -134,6 +136,8 @@ struct iavf_q_vector {
 
 #define MIN_MSIX_Q_VECTORS 1
 #define MIN_MSIX_COUNT (MIN_MSIX_Q_VECTORS + NONQ_VECS)
+/* VF interrupt registers cover 64 queue vectors */
+#define MAX_MSIX_Q_VECTORS 64
 
 #define IAVF_QUEUE_END_OF_LIST 0x7FF
 #define IAVF_FREE_VECTOR 0x7FFF
@@ -182,7 +186,7 @@ enum iavf_tc_state_t {
 struct iavf_channel_config {
 	struct virtchnl_channel_info ch_info[IAVF_MAX_TRAFFIC_CLASS];
 	enum iavf_tc_state_t state;
-	u8 total_qps;
+	u16 total_qps;
 };
 
 /* State of cloud filter */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
index a19e88898a0b..47fd2d3f5e4b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_register.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_register.h
@@ -56,6 +56,8 @@
 #define IAVF_VFINT_ICR0_ENA1_RSVD_SHIFT 31
 #define IAVF_VFINT_ICR01 0x00004800 /* Reset: CORER */
 #define IAVF_VFINT_ITRN1(_i, _INTVF) (0x00002800 + ((_i) * 64 + (_INTVF) * 4)) /* _i=0...2, _INTVF=0...15 */ /* Reset: VFR */
+#define IAVF_VFINT_ITRN_64(_i, _INTVF) \
+	(0x00002C00 + ((_i) * 256 + (_INTVF) * 4)) /* _i=0...2, _INTVF=0...63 */
 #define IAVF_QRX_TAIL1(_Q) (0x00002000 + ((_Q) * 4)) /* _i=0...15 */ /* Reset: CORER */
 #define IAVF_QTX_TAIL1(_Q) (0x00000000 + ((_Q) * 4)) /* _i=0...15 */ /* Reset: PFR */
 #define IAVF_VFQF_HENA(_i) (0x0000C400 + ((_i) * 4)) /* _i=0...1 */ /* Reset: CORER */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 822d6e692d49..db769eead68f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -419,6 +419,15 @@ static irqreturn_t iavf_msix_clean_rings(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* VFINT_ITRN1 fits 16 vectors only, VFINT_ITRN_64 aliases it for up to 64 */
+static u32 iavf_itrn_reg(enum iavf_dyn_idx_t itr_idx, u16 reg_idx)
+{
+	if (reg_idx < 16)
+		return IAVF_VFINT_ITRN1(itr_idx, reg_idx);
+
+	return IAVF_VFINT_ITRN_64(itr_idx, reg_idx);
+}
+
 /**
  * iavf_map_vector_to_rxq - associate irqs with rx queues
  * @adapter: board private structure
@@ -439,8 +448,8 @@ iavf_map_vector_to_rxq(struct iavf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.count++;
 	q_vector->rx.next_update = jiffies + 1;
 	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
-	q_vector->ring_mask |= BIT(r_idx);
-	wr32(hw, IAVF_VFINT_ITRN1(IAVF_RX_ITR, q_vector->reg_idx),
+	set_bit(r_idx, q_vector->ring_mask);
+	wr32(hw, iavf_itrn_reg(IAVF_RX_ITR, q_vector->reg_idx),
 	     q_vector->rx.current_itr >> 1);
 	q_vector->rx.current_itr = q_vector->rx.target_itr;
 }
@@ -466,7 +475,7 @@ iavf_map_vector_to_txq(struct iavf_adapter *adapter, int v_idx, int t_idx)
 	q_vector->tx.next_update = jiffies + 1;
 	q_vector->tx.target_itr = ITR_TO_REG(tx_ring->itr_setting);
 	q_vector->num_ringpairs++;
-	wr32(hw, IAVF_VFINT_ITRN1(IAVF_TX_ITR, q_vector->reg_idx),
+	wr32(hw, iavf_itrn_reg(IAVF_TX_ITR, q_vector->reg_idx),
 	     q_vector->tx.target_itr >> 1);
 	q_vector->tx.current_itr = q_vector->tx.target_itr;
 }
@@ -1661,9 +1670,9 @@ static int iavf_set_interrupt_capability(struct iavf_adapter *adapter)
 	/* It's easy to be greedy for MSI-X vectors, but it really doesn't do
 	 * us much good if we have more vectors than CPUs. However, we already
 	 * limit the total number of queues by the number of CPUs so we do not
-	 * need any further limiting here.
+	 * need any further limiting here, except for the VF registers.
 	 */
-	v_budget = min_t(int, pairs + NONQ_VECS,
+	v_budget = min_t(int, min(pairs, MAX_MSIX_Q_VECTORS) + NONQ_VECS,
 			 (int)adapter->vf_res->max_vectors);
 
 	adapter->msix_entries = kzalloc_objs(struct msix_entry, v_budget);
@@ -3734,9 +3743,10 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 	struct tc_mqprio_qopt_offload *mqprio_qopt = type_data;
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
-	u8 num_tc = 0, total_qps = 0;
 	int ret = 0, netdev_tc = 0;
+	u16 total_qps = 0;
 	u64 max_tx_rate;
+	u8 num_tc = 0;
 	u16 mode;
 	int i;
 
@@ -5371,7 +5381,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	netdev = alloc_etherdev_mq(sizeof(struct iavf_adapter),
-				   IAVF_MAX_REQ_QUEUES_VCV1);
+				   IAVF_MAX_REQ_QUEUES);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 69241cb146e0..6555e8b10171 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -260,19 +260,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
+	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES_VCV1);
+			 IAVF_MAX_REQ_QUEUES);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES_VCV1);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
+			 IAVF_MAX_REQ_QUEUES);
+		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
+			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
 		}
 	}
 }
@@ -526,8 +526,9 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 
 		vecmap->vsi_id = adapter->vsi_res->vsi_id;
 		vecmap->vector_id = v_idx + NONQ_VECS;
-		vecmap->txq_map = q_vector->ring_mask;
-		vecmap->rxq_map = q_vector->ring_mask;
+		vecmap->txq_map = bitmap_read(q_vector->ring_mask, 0,
+					      IAVF_MAX_REQ_QUEUES_VCV1);
+		vecmap->rxq_map = vecmap->txq_map;
 		vecmap->rxitr_idx = IAVF_RX_ITR;
 		vecmap->txitr_idx = IAVF_TX_ITR;
 	}
-- 
2.54.0

