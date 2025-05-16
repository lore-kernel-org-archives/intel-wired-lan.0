Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFD4C54754
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 May 2025 14:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 341986074D;
	Fri, 16 May 2025 14:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nDZtBabVX22; Fri, 16 May 2025 14:58:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 957F76114E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1747407527;
	bh=s23GV4JWa++Qz29kxbt+4ARsbWfrwKuZcj2tUTGPfbA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ti7cUWUxUfy4gSrQHvx73iZmVPj/QNKZbAZhnFaTi3saBaKeRv9y6UiHbnDK7wjN/
	 vCFl9TRwO28Hr3fLemsIqKnwXiLvmIT88TXfmcZSUoMsd129+xHm3zKFxAjXTm7/nA
	 AIiBCNpiS9SlWKlURPiMPccP3ywS2RW+w1QllAPnr4BhSKrBW0ehsCIWIOe14AP8re
	 1ye9DrtwbOORg58Tdq4ID5Q9cxB2d0+jkDpkxAR8yYJy2fjEA9qBYxxxw2cPZKBvS+
	 VXBMUFeoePZh8NUFvfOkHI6nVMdgq/HiKiw4PsWCJEtBmq4Nw1/9kHOUJbrBGAUH4l
	 DJEVTEAfJJdEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 957F76114E;
	Fri, 16 May 2025 14:58:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBDA61AB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 14:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD19D6074D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 14:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ev0QhikqCcZD for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 May 2025 14:58:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 445906114E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 445906114E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 445906114E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 May 2025 14:58:45 +0000 (UTC)
X-CSE-ConnectionGUID: P09j+3BQT0yjbBBvxja3WQ==
X-CSE-MsgGUID: tv0M8TbnTEeUFASnYK9pPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49308674"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; d="scan'208";a="49308674"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 07:58:44 -0700
X-CSE-ConnectionGUID: lVJ8m0bNQLiI5Cr7HTFzkw==
X-CSE-MsgGUID: SAulFrTzQ4COHP3ZyvXcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; d="scan'208";a="142717998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2025 07:58:38 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 93CFD34324;
 Fri, 16 May 2025 15:58:36 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Lee Trager <lee@trager.us>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
 Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
 "Singhai, Anjali" <anjali.singhai@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>
Date: Fri, 16 May 2025 16:58:07 +0200
Message-ID: <20250516145814.5422-11-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250516145814.5422-1-larysa.zaremba@intel.com>
References: <20250516145814.5422-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747407525; x=1778943525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9dzZPt2McHNB+lAA+rspaOyYpS5uTSMQtry3RSu+rVo=;
 b=IaOQaJHJ0LMhimaI83zn9aQerI1thFKpSS+NgnlW8TE7fOurL0zdn9Hv
 2xcL8AkEYlcaz2ZymEvoZ3657vXH+l0G7ej4py9BZIcScIqCC662Y923U
 TQ+bGDTTpUUblj2KDsWuLFE3YcOr4PnydEU3RlBv+1ng5iMfaGiX5wDp+
 pcjw3iFM8ckgdHSo6CS2A6OwW9XflXQQG5Gqek2gUE+QoniIlWqKwY41I
 toJmJ2CSRhcT82WDvydAKoIJwWvDx12v+6d9lWepdC8Pp6Ay/GCq7rv/m
 JfEj1V/had+9LxwEsMHAkt3sSBMpzAtiqDT1xI4SqcWf89NX1k3BIZuYv
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IaOQaJHJ
Subject: [Intel-wired-lan] [PATCH iwl-next v4 10/15] idpf: make mbx_task
 queueing and cancelling more consistent
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

As a consequence of refactoring idpf code to use libeth APIs,
idpf_vc_xn_shutdown was merged with and replaced by idpf_deinit_dflt_mbx.
This does not affect the Tx path, as it checked for a presence of an xn
manager anyway. Rx processing is handled by the mbx_task that is not always
cancelled before calling the new consolidated mailbox deinit function.
Moreover, in the reset path idpf_intr_rel() reschedules it after the deinit
is done. This leads to mbx_task referencing the freed mailbox and causing
KASAN warnings.

To remedy this, in the init path, do the first queueing of mbx_task in
idpf_init_dflt_mbx(), in deinit and reset, always cancel the task in
idpf_deinit_dflt_mbx() and in every flow first call idpf_mb_intr_rel_irq().

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          | 1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 9 ++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 6 +++++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index ff69d920d7d3..e84881307b99 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -880,6 +880,7 @@ void idpf_vc_event_task(struct work_struct *work);
 void idpf_dev_ops_init(struct idpf_adapter *adapter);
 void idpf_vf_dev_ops_init(struct idpf_adapter *adapter);
 int idpf_intr_req(struct idpf_adapter *adapter);
+void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter);
 void idpf_intr_rel(struct idpf_adapter *adapter);
 u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
 int idpf_initiate_soft_reset(struct idpf_vport *vport,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 500bff1091d9..f8a025cecac5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -66,9 +66,11 @@ static void idpf_deinit_vector_stack(struct idpf_adapter *adapter)
  * This will also disable interrupt mode and queue up mailbox task. Mailbox
  * task will reschedule itself if not in interrupt mode.
  */
-static void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
+void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
 {
-	clear_bit(IDPF_MB_INTR_MODE, adapter->flags);
+	if (!test_and_clear_bit(IDPF_MB_INTR_MODE, adapter->flags))
+		return;
+
 	kfree(free_irq(adapter->msix_entries[0].vector, adapter));
 	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
 }
@@ -1783,14 +1785,11 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
 		goto unlock_mutex;
 	}
 
-	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
-
 	/* Initialize the state machine, also allocate memory and request
 	 * resources
 	 */
 	err = idpf_vc_core_init(adapter);
 	if (err) {
-		cancel_delayed_work_sync(&adapter->mbx_task);
 		idpf_deinit_dflt_mbx(adapter);
 		goto unlock_mutex;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 021fac3850ad..31c7e1984f6c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2357,6 +2357,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 	adapter->xn_init_params.xnm = params.xnm;
 	adapter->state = __IDPF_VER_CHECK;
 
+	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -2366,6 +2368,9 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
  */
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
+	idpf_mb_intr_rel_irq(adapter);
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
 	if (adapter->arq && adapter->asq) {
 		idpf_mb_clean(adapter, adapter->asq);
 		libie_ctlq_xn_deinit(adapter->xn_init_params.xnm,
@@ -2605,7 +2610,6 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 		idpf_deinit_dflt_mbx(adapter);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
-	cancel_delayed_work_sync(&adapter->mbx_task);
 
 	idpf_vport_params_buf_rel(adapter);
 
-- 
2.47.0

