Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA2CD98E2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 Jun 2026 07:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB75885314;
	Wed, 17 Jun 2026 07:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uO6QoXyhdq0Q; Wed, 17 Jun 2026 07:24:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E10B9853D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781681047;
	bh=XjmUPDClbDkPs/Q/gGvLbyNfztYl4Gq0Pvfi7sSSo90=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WSBCXA1ixBn4sT3UslEDZz7m3BkT24EO8evyMFEowhrokkqmrvp+OMmVnbE27ODWx
	 YxfRm6saPL4+miINyhxFVrnGIJ0OQYSFovNEAqvnDWsqjNzX/nTGNaz6sW5yHg+Puk
	 00YEUsuJOW+C6EnoLiqNNoo224KRl1MBgvdjZDsnia74tcZnjrMDvGPvUz3pwIktmA
	 6c/NEgjNbFl6fse8ME0PT6bm2+l1Ti1lQquxLem4JAHhGkRZIIGvBRaQG69UCG136a
	 UEn04E/ebhHoRlCadZAfFtGAXhZvQQq+8aGJaGrLn7uGzRRGYg7pMmg9J+GiyaTIRg
	 GV0rwGsYZT+5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E10B9853D1;
	Wed, 17 Jun 2026 07:24:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EAD333C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 07:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A9A06087B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 07:24:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJYwxf2fImhE for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 Jun 2026 07:24:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=nobodqwe@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 386D060852
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 386D060852
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 386D060852
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 07:24:05 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so780462966b.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 Jun 2026 00:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781681043; x=1782285843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjmUPDClbDkPs/Q/gGvLbyNfztYl4Gq0Pvfi7sSSo90=;
 b=bWjR26UKb3Cx2Qea5sMOMBVHSri6cYhhCDJMHabQkFEpzCOMRz4Vw/kRl6bBuub2Hs
 hvXFLbnokeC3/bCTTLT9lokoKN1gYDOiAh2SyqRfuPvghrp+27BkvGXFLP5JvjyujfzU
 5mrFvS1WzGwsR/YdcrKQ68OPXE2Ta0p4WUrpkFNdGgXj0rHXf7akVoheo+yEm9jeGfu1
 go5mFh+HW47Dhmof8vuHp+rmK05op9QWjKXIrwj6L3lWvYaMqswsR/RPP4Wf9GJ/xfyI
 bExNDyugHDQUEr/UNXkKr3QY/Yvw8b0+//Go1uoTqNwpZfqtBTY1wbE059+mBiykcjv5
 Krrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wtlmgi3XhD1/P+8IHSrL0bTyEXQCWS2uNPhBben7h6//+EaLRSLU43lBnMopeRW2/kylBglaNQ206fr8dHNw=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyxeaMkuu7ADKNUoN10ZJeyIwL/1F08yFf5CPl0GFaU4zfAqDxn
 RdVNLlaUaLZ5mgd75rwA4vJbvzyXyacWgvKvtE/YKjGlqqU8gUdkAEo=
X-Gm-Gg: Acq92OEcfLf9XzvZFZ+xjq2R5J8WrZ3KwsAYDwLpRQ/phErNGRvtG9C1c2P3zbiTJ3+
 AK17c6PmwMmc5PS3uRMiaRa5XEuNZNPpZczxJWdBBW8RPo0m2PsvRLkd8uih4g2us29u42+T0ae
 tOxhkQCZru/C8z5+NWRkVHe2Ad15t3CAkXov9XeNw3+T0FUvmgYFMD33dBYNxywtXARQirtcYAc
 5YJM8cN1BuWYufBfGg9nerGRfJEpGqZA55jOaKvXhjOLFAdg8dQgS4Ps19SN1c/ibeDcHYQnWRu
 PurlZAs16wxYnWKlv5h8/VUrnVQur05Ve5ZUANm7SVi9qvD8Vs9CHWCKWkw1GkClZJwhU4OaV1P
 dh5CsxBwpS23hiOED49NAmmwNREf3haDZ1vdnspfBRvAcOCj3aOk7UPBjERPI73xwabaqtwUhFI
 6m+m6GALuP1BKY60m9yLtwEX02DuQxqMSXjA==
X-Received: by 2002:a17:906:eec1:b0:bed:6e53:bb25 with SMTP id
 a640c23a62f3a-c05a73b168amr174284966b.40.1781681041227; 
 Wed, 17 Jun 2026 00:24:01 -0700 (PDT)
Received: from archlinux ([2.26.254.81]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb51007a9sm733539066b.21.2026.06.17.00.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:24:00 -0700 (PDT)
From: NeKon69 <nobodqwe@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 piotr.kwapulinski@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 NeKon69 <nobodqwe@gmail.com>
Date: Wed, 17 Jun 2026 10:21:55 +0300
Message-ID: <20260617072155.1172432-1-nobodqwe@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781681043; x=1782285843; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XjmUPDClbDkPs/Q/gGvLbyNfztYl4Gq0Pvfi7sSSo90=;
 b=aAKhnNhN7Zyg/cxiWoEuPSOl1xzJg/QZ5EHP2/bo/XUVS682nu31V94rgWKMNhHjCD
 cjwOBw8mwSu6VvW8Ttu/JzAVtCA+3xLKCQyMf6qKYilB4ySmxip2hjJwgg6dMH7AFi3K
 9v6tpPtwErY3vJORuEnDQqX8oYFdJfjhvCTttDo821EO7SiRbLppqb/g3X1JAOJETQLh
 kTN8Bs8iIhjdzu6lh1DPYmxznvYlMshaXJjcz31JIX/zSn1GD7kEI3pqhI5jDvDUL7NZ
 /M7KQCtWgR/p96/2xn9cD2H8mzheZz65IFwcNcbZs6gJ5A48NjP4BtEsq0AwjN3A7sLX
 aYVw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aAKhnNhN
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix use-after-scope in
 ice_sched_add_nodes_to_layer()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
changed ice_sched_add_nodes_to_layer() from recursive control flow to an
iterative loop.

Inside the loop, first_teid_ptr may be set to the address of a
block-local variable:

    u32 temp;
    ...
    if (num_added)
        first_teid_ptr = &temp;

On the next loop iteration, first_teid_ptr may be passed to
ice_sched_add_nodes_to_hw_layer(), after temp from the previous
iteration has gone out of scope.

Instead of keeping temporary storage for later calls, allow
first_node_teid to be NULL when the caller does not need the TEID.

This was found by Clang with LifetimeSafety enabled while testing C
language support on a Linux allmodconfig build.

Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
Link: https://github.com/llvm/llvm-project/pull/203270
Signed-off-by: NeKon69 <nobodqwe@gmail.com>
---
v2:
- Allow first_node_teid to be NULL when callers do not need the TEID.
- Pass NULL after the first TEID has already been returned instead of using
  temporary stack storage.
- Update kernel-doc for helpers accepting NULL.
- Link to v1: https://lore.kernel.org/netdev/20260613101440.80190-1-nobodqwe@gmail.com/
- Compile-tested with:
  make drivers/net/ethernet/intel/ice/ice_sched.o

 drivers/net/ethernet/intel/ice/ice_sched.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1afdb41..89e191c839b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -895,7 +895,8 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
  * @layer: layer number to add nodes
  * @num_nodes: number of nodes
  * @num_nodes_added: pointer to num nodes added
- * @first_node_teid: if new nodes are added then return the TEID of first node
+ * @first_node_teid: if new nodes are added then return the TEID of first node,
+ *                   may be NULL
  * @prealloc_nodes: preallocated nodes struct for software DB
  *
  * This function add nodes to HW as well as to SW DB for a given layer
@@ -1000,7 +1001,7 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 		if (!pi->sib_head[tc_node->tc_num][layer])
 			pi->sib_head[tc_node->tc_num][layer] = new_node;
 
-		if (i == 0)
+		if (first_node_teid && i == 0)
 			*first_node_teid = teid;
 	}
 
@@ -1015,7 +1016,7 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
  * @parent: pointer to parent node
  * @layer: layer number to add nodes
  * @num_nodes: number of nodes to be added
- * @first_node_teid: pointer to the first node TEID
+ * @first_node_teid: pointer to the first node TEID, may be NULL
  * @num_nodes_added: pointer to number of nodes added
  *
  * Add nodes into specific HW layer.
@@ -1078,7 +1079,6 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 	*num_nodes_added = 0;
 	while (*num_nodes_added < num_nodes) {
 		u16 max_child_nodes, num_added = 0;
-		u32 temp;
 
 		status = ice_sched_add_nodes_to_hw_layer(pi, tc_node, parent,
 							 layer,	new_num_nodes,
@@ -1109,13 +1109,11 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 			 * try the next available sibling.
 			 */
 			parent = ice_sched_find_next_vsi_node(parent);
-			/* Don't modify the first node TEID memory if the
-			 * first node was added already in the above call.
-			 * Instead send some temp memory for all other
-			 * recursive calls.
+			/* Don't modify the first node TEID memory if the first node
+			 * was added already in the above call.
 			 */
 			if (num_added)
-				first_teid_ptr = &temp;
+				first_teid_ptr = NULL;
 
 			new_num_nodes = num_nodes - *num_nodes_added;
 		}
-- 
2.54.0
