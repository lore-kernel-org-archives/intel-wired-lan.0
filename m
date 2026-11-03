Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE61606EEBA
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MYp5D/EX;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AGecfi2V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AD796085C;
	Tue,  3 Nov 2026 14:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2gSDSE7v0O4l; Tue,  3 Nov 2026 14:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7269B60670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716809;
	b=loigVWwUcYZvbYKo8+n72iuLx2XPyq9aHYN72mx1Pqwt8xwpzfAb3jSWA1fbuIdKEst8
	 mOrI7tBI1mz9eYHSKHhfhSH/TFVmIj3RDZbfIF0qa4CCc7Bl1U04Q1iOLRAOUzb/+6GP9
	 cY/V1WOCwM945uwZvb7Zof1qAYud5k3Rw4tbgwfoT+kdE5BCx4BOiqzECF1SsTqLcSaa1
	 7Y0p7/1nKUt01dGXd+u9pAduf3lTFnznS5PsNER8GE5SRzOF2u58O45EugbT3iGRzLRgV
	 ZYhJbYCR1DyCG/izPWWl8pvw4dzgvYGOT41aaGw3V/jvVoYitZBM0XF3IKql5WGNFdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716809;
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
	bh=ziAQ0Malxn1wVO80oUYIuUS+AaGe6rngKSV0v0QLQxo=;
	b=G8eItrZOKYQ7B4c8IFKS3Xq/4t3cFWA2P3gm5y9AA35J6vlOTrHiD4Df1bcAR0bsHxyl
	 nC6JPv/I9Z/xTyReboen8E6ohu0GJXKhesYZf1KMCVYnavCu3S5q4WAbPrSr8+nGuMh7u
	 dGiacqPhu2eyEG49JSUVP9qMiThspdfzwyZODFtZgzfZsTqsQAhIgwnDo2liiM6EQEg1t
	 wb5K94pk7+nLE4O2r0RKSJJGSku5IlEZD5bCyQtYtaEnDmKqOk/OK6kuesahR/Gh8rkNq
	 sw6Lhz1KBe9UcwzUV8WXNBVBBXtn1wQxK21P5zuJaOsDp1T3/J+hUhNa7GAtGDk+ftQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716809;
	bh=ziAQ0Malxn1wVO80oUYIuUS+AaGe6rngKSV0v0QLQxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYp5D/EXhX0CpP7zCoVUtjWQxVkApdX9WaG44S35ej8hHKZAE4AxnMTDSfLUHQELo
	 Q9dK5BIp93A6+iKtrDZ6kusLx7nCt3vbBQH2Bq42MBHyWRFSt7BMa1BK2Hpyyw0Yo4
	 ogpxXviBrlw5rYJ5EpCfB6Ixs+hblsX9hge0H+3NdB3WdOMbv+RbqBB5JvkG9a9xJw
	 zjHhYp8MAOef0fw7Cirn6nzNtvtLlXsS9cY71fMrsWjwC68TCs9LcbHSWTwRI+Z4cK
	 FLV2uWvFLg5hOuKR/h8gufNhbqVIz2vy+BQq/HhXHVzmgA/zv1ur9qJ9ux6no0B9sp
	 r0Z4L7JDw2DVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7269B60670;
	Tue,  3 Nov 2026 14:40:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4E4D356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAF9A406FA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fiLKMik1dhXe for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 419CA4070A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716805;
 b=Sgd0OkcUcaNtZhKHWywDF0yhzoyL/wpOzZqTpE//oq02p04JeMeeb/tpVMsNxQvjrQt2
 cgnZzwt9hwVanklkwAq9scqaQV2Ljy8m+hsCZk2pKlLyEcXc+jP6lKGurPSn37aPYK6Ek
 fETJKtLXD/+mKhqs/K/PwbjNeZfMGlWi+/JteUOe2XVXJXUiRt/w7oVVt6/1PZ6ehfwum
 EKLh89eJVQisLFpDLxGGU/Z/jp9STukwFsHNZb+VvtwdRHaHNs/SfOc+/KnYVcRob6dw9
 QivVTOKnmQCvZXUjLk1kHWtV1U/bvaE7SMyb2dhrcwn81L7H4bxLWFXhggFe8Cyfq0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716805;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ziAQ0Malxn1wVO80oUYIuUS+AaGe6rngKSV0v0QLQxo=;
 b=forXLHLmXy2QVj7ivvittU4UOVaU3opcGUZ0bxqFR6JWmprQ+0iUswnutz4pQ6fi1muc
 BN1QU26AgCKZoFdlAp13ToswIJBBireWn9KFVFgRyMOZnZarNS/sDoY1oGU1ilUkYVn7r
 fJwwptgH89yVN10xrrhjpwIVQS/V73n5NIlb8UI5SQMbsqeDjNKXTm4i2OY9ZCT8SEauE
 5ntt0SQwlelO/N58ZtZwt+w2sGhvjRgO+nLR5y3TSVIZVq+vfbvCtjLYkR+u6l2hlJ1s8
 wiG/11ZF0qJxUEyGyl5+x0Gv3/sal59oX1xkDuKNYCENrpdZAmeinUtPq8Mab5sy6GQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AGecfi2V; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AGecfi2V
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 419CA4070A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716805; x=1825252805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Edfy2eOdXjwzLJOsK3Sm47Hf+KKnkOYzbak2QRKZiKA=;
 b=AGecfi2VwVxMq1vlVwM/kh/wrLBp7dKVUydxMC+ZyiufN8ZGi/5We+yS
 kRBSAzrHloYmyS4vLLknj/s+vIkiq1/jpyKnGwV/DKoC9S/MoIY+nZqFn
 h64VW6pafMhjyH9x0UhyWFT2HJ895JeEtw3YR4njeVD13NWss+cIjdgvh
 YrfXkqZo6/bRFJ8FaGBaeIZdfs6UQccuElBcIbsrNBlY3HcwkCla1Di6y
 I9QHT4BkTftsIoGN6Jgb3zlvDg9L5qVdJwkMuaYBWyqdsDW4rq7M6qCHz
 QFGkzbhUDCx8diUegWZXUzg/Gt8+MtY9UpQBle6Km46FrgTy0TvIXIHJu Q==;
X-CSE-ConnectionGUID: ZxRt1Z5rSbWqUYwz/m8p3w==
X-CSE-MsgGUID: FJENIFakQzSolqeQkIHORA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324095"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324095"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:40:04 -0800
X-CSE-ConnectionGUID: VI1O8Z8+QS6Zyl7a9IxVWQ==
X-CSE-MsgGUID: +nmQobBZQ8eExuwyhQScDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8290000"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:58 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 733B8312EB;
 Tue,  3 Nov 2026 14:39:54 +0000 (GMT)
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 10/15] iavf: use new opcodes to request more than
 16 queues
Date: Tue,  3 Nov 2026 15:14:51 +0100
Message-ID: <20261103141646.303620-11-przemyslaw.kitszel@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ahmed Zaki <ahmed.zaki@intel.com>

Legacy virtchnl opcodes select queues by fixed width bitmaps: u32 for
VIRTCHNL_OP_ENABLE_QUEUES and VIRTCHNL_OP_DISABLE_QUEUES, u16 for
VIRTCHNL_OP_CONFIG_IRQ_MAP. Define new OP codes in order to enable
the VF to use a variable number of queues.

First the new capability VIRTCHNL_VF_LARGE_NUM_QPAIRS is defined. Only
if this cap is negotiated, the VF is allowed to use the new OP codes.

The VIRTCHNL_OP_GET_MAX_RSS_QREGION is exchanged right after the VF
resource message is received. This is done similar to the PTP and other
extended cap exchanges.

Enabling and disabling queues, and mapping queues to vectors is done
through the new VIRTCHNL_OP_ENABLE_QUEUES_V2,
VIRTCHNL_OP_DISABLE_QUEUES_V2, and VIRTCHNL_OP_MAP_QUEUE_VECTOR messages.
The queue to vector map may not fit into one message, so it is sent in
parts, one per watchdog run, as done for VIRTCHNL_OP_CONFIG_VSI_QUEUES.

Use the new iavf_request_queues() for ethtool -L.
It's not only for elegance, but it enables our brittle handcoded state
machine to go through requesting the queues before PF driver reallocates
queue-related arrays. This is done only with VIRTCHNL_VF_LARGE_NUM_QPAIRS,
and ethtool -L returns right after queuing the request, the watchdog
sends it once no other op is in flight: PF resets the VF to grant it,
a denial is only logged.

Two changes in iavf_parse_vf_resource_msg() apply to every PF: when the
PF reports fewer queue pairs than the VF has in use (PF has lowered its
limit on reset), reinit queues and MSI-X with that count; when the RSS
key or LUT size changes across a reset, reallocate both and fill them
again. Every PF is also affected by resetting aq_wait_count when init
starts over after the PF stopped responding. It was never reset, so
once it reached IAVF_AQ_MAX_ERR, the first wait for a PF reply sent
init back to __IAVF_COMM_FAILED.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * iavf_map_queue_vector(): send one message per watchdog run, as
   iavf_configure_queues() does now, instead of polling for each reply
   with a 1s timeout (Sashiko)
 * stop sending the queue to vector map on a PF NACK, reported by
   iavf_virtchnl_completion()
 * refill the RSS LUT when the RSS region changes across a reset, as the
   LUT is filled before the VIRTCHNL_OP_GET_MAX_RSS_QREGION reply
   (Sashiko)
 * kzalloc() the RSS key and LUT on reallocation, as done at init
   (Sashiko)
 * ethtool -L: let the watchdog send the queue request, instead of
   failing with -EBUSY whenever another op is in flight (e.g. GET_STATS);
   return -EBUSY only while PF has not answered the previous request
   (Sashiko)
 * init: check IAVF_VF_ARQLEN1 while waiting for the queue request
   outcome, as the event of the PF reset that grants it can be lost;
   start over on an error reply, instead of taking the request for
   granted after the next reset (Sashiko)
 * forget the queue request when init starts over after the PF stopped
   responding, and reset aq_wait_count there, so init gets a full retry
   budget again (Sashiko)
 * treat an error reply to a runtime queue request as a denial; on a VF
   reset with the request not answered yet, use the smaller of the
   active and requested queue counts, as the reset can drop the PF
   answer, and that count fits whatever PF has decided (Sashiko)
 * ethtool -X: reject LUT entries outside of the PF RSS region, as
   iavf_fill_rss_lut() does; comment that qregion_width 0 means the
   region is not known yet (Sashiko)
 * commit message: describe the iavf_parse_vf_resource_msg() changes
   that apply to every PF, the aq_wait_count reset, and the async
   ethtool -L (Sashiko)
 * drop num_req_queues on a reset that does not reinit queues, as the
   previous reset has set them up already; when PF lowers the limit
   right after granting the request (VF RSS LUT taken away just after
   ethtool -L), reinit quietly instead of reporting "Requested 64
   queues, but PF only gave us 16."
 * wait for the outcome of the queue request sent at init before other
   extended caps, as their polling dropped a PF denial and VF went on
   with the denied queue count; on denial ask for as many queues as PF
   can give, and allocate the granted count after the PF reset (Sashiko)

v3:
 * auto-request queues in LARGE mode only at init, not on every reset,
   so ethtool -L setting is kept; do that after VSI and RSS fields are
   initialized, instead of returning early (Sashiko)
 * schedule a VF reset when RSS key/LUT reallocation fails, as the
   caller on the reset path ignores the error (Sashiko)

v2:
 * use proper IAVF_EXTENDED_CAP_SEND_RSS_QREGION flag when handling
   iavf_init_recv_max_rss_qregion() error (Sashiko)
 * update adapter->rss_{key,lut}_size and adapter->current_op only after
   successful allocation (Sashiko)
 * use the v2 opcodes to enable queues whenever
   VIRTCHNL_VF_LARGE_NUM_QPAIRS is negotiated, as for disabling (it was
   based on the queue count) (Sashiko)
 * set adapter->current_op in iavf_send_max_rss_qregion() (Sashiko)
 * iavf_set_channels(): stop clearing adapter->current_op before
   iavf_request_queues(), it was a debugging leftover (Sashiko)
 * iavf_request_queues(): undo current_op, num_req_queues and
   IAVF_FLAG_REINIT_ITR_NEEDED when sending the request fails (Sashiko)
 * iavf_map_queue_vector(): stop at the first send or poll error, and
   report it with dev_err()
 * replace rss key/lut krealloc() with simple kmalloc()s, to have an
   easier job on the error path
 * request RSS qregion again after reset, together with other extended
   caps: send it from iavf_process_aq_command() and handle the reply in
   iavf_virtchnl_completion()
 * auto-request queues at init only once, and only with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS (and VIRTCHNL_VF_OFFLOAD_REQ_QUEUES),
   where num_queue_pairs is the PF limit rather than the allocation;
   without it keep the previous behavior, with no extra VF reset
 * set channels locally (as before this series) unless
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, so ethtool -L down no longer lowers
   max_combined for good
 * reinit queues when the PF lowers num_queue_pairs below the number of
   active queues on reset (e.g. VF RSS LUT switched from GLOBAL back to
   VSI, so LARGE_NUM_QPAIRS is gone), instead of using legacy opcodes
   with too many queues
 * rebase over iavf_poll_virtchnl_response() changes
 * commit message: explain the limits of the legacy opcodes
 * iavf_map_queue_vector(): stop at PF NACK; on timeout keep current_op
   and IAVF_FLAG_AQ_MAP_VECTORS set until the late reply arrives, clear
   both on other errors (no retry), as in iavf_configure_queues()
   (Sashiko)

Sashiko suggestions I don't want to apply:
 S: iavf_fill_rss_lut() will crash if qregion->qregion_width >= 32
 me: value is coming from PF, which must be trusted

 S: non-atomic adapter->flags update in iavf_request_queues() races with
    lockless contexts like iavf_tx_timeout()
 me: pre-existing pattern in the whole iavf driver (iavf_set_channels()
     did the same before this series), out of scope here

v4:
 * num_queue_pairs is the VF allocation also with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, as in legacy mode and with the
   out-of-tree drivers; ethtool -L max is the PF RSS region (Sashiko)
 * init: ask for more queues, up to one per CPU, and take the request as
   granted only when PF gives us that many, so an unrelated reset before
   the answer is not taken for a grant; on a denial that offers no more
   than we have, or on an error reply, go on with what we have instead
   of starting over (Sashiko)
 * drop the cap of the requested queue count on a VF reset, the
   "Requested X queues, but PF only gave us Y" check handles a lost
   denial again (Sashiko)

v4:
 * clarify the qregion_width comment in iavf_fill_rss_lut()
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  20 ++
 include/linux/net/intel/virtchnl.h            | 136 +++++++++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  45 +++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 230 +++++++++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 251 +++++++++++++++++-
 5 files changed, 656 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 60ee3a195567..30a3759e5545 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -274,8 +274,11 @@ struct iavf_adapter {
 	u8 rxdid;
 	int num_active_queues;
 	int num_req_queues;
+	/* count for IAVF_FLAG_AQ_REQUEST_QUEUES */
+	int num_req_queues_next;
 	/* queue pairs sent so far, for ops that take more than one message */
 	int cfg_qps_sent;
+	int map_qps_sent;
 
 	/* TX */
 	struct iavf_ring *tx_rings;
@@ -349,13 +352,16 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS		BIT_ULL(42)
 #define IAVF_FLAG_AQ_GET_PTP_CAPS			BIT_ULL(43)
 #define IAVF_FLAG_AQ_SEND_PTP_CMD			BIT_ULL(44)
+#define IAVF_FLAG_AQ_GET_MAX_RSS_QREGION		BIT_ULL(45)
+#define IAVF_FLAG_AQ_REQUEST_QUEUES			BIT_ULL(46)
 
 	/* AQ messages that must be sent after IAVF_FLAG_AQ_GET_CONFIG, in
 	 * order to negotiated extended capabilities.
 	 */
 #define IAVF_FLAG_AQ_EXTENDED_CAPS			\
 	(IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS |	\
 	 IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS |		\
+	 IAVF_FLAG_AQ_GET_MAX_RSS_QREGION |		\
 	 IAVF_FLAG_AQ_GET_PTP_CAPS)
 
 	/* flags for processing extended capability messages during
@@ -372,12 +378,18 @@ struct iavf_adapter {
 #define IAVF_EXTENDED_CAP_RECV_RXDID			BIT_ULL(3)
 #define IAVF_EXTENDED_CAP_SEND_PTP			BIT_ULL(4)
 #define IAVF_EXTENDED_CAP_RECV_PTP			BIT_ULL(5)
+#define IAVF_EXTENDED_CAP_SEND_RSS_QREGION		BIT_ULL(6)
+#define IAVF_EXTENDED_CAP_RECV_RSS_QREGION		BIT_ULL(7)
+/* set only when iavf_parse_vf_resource_msg() requests queues */
+#define IAVF_EXTENDED_CAP_RECV_REQ_QUEUES		BIT_ULL(8)
 
 #define IAVF_EXTENDED_CAPS				\
 	(IAVF_EXTENDED_CAP_SEND_VLAN_V2 |		\
 	 IAVF_EXTENDED_CAP_RECV_VLAN_V2 |		\
 	 IAVF_EXTENDED_CAP_SEND_RXDID |			\
 	 IAVF_EXTENDED_CAP_RECV_RXDID |			\
+	 IAVF_EXTENDED_CAP_SEND_RSS_QREGION |		\
+	 IAVF_EXTENDED_CAP_RECV_RSS_QREGION |		\
 	 IAVF_EXTENDED_CAP_SEND_PTP |			\
 	 IAVF_EXTENDED_CAP_RECV_PTP)
 
@@ -417,6 +429,8 @@ struct iavf_adapter {
 #define RSS_REG(_a) (!((_a)->vf_res->vf_cap_flags & \
 		       (VIRTCHNL_VF_OFFLOAD_RSS_AQ | \
 			VIRTCHNL_VF_OFFLOAD_RSS_PF)))
+#define LARGE_NUM_QPAIRS_SUPPORT(_a) \
+	((_a)->vf_res->vf_cap_flags & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
 #define VLAN_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
 			  VIRTCHNL_VF_OFFLOAD_VLAN)
 #define VLAN_V2_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
@@ -451,6 +465,7 @@ struct iavf_adapter {
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	u64 supp_rxdids;
 	struct iavf_ptp ptp;
+	struct virtchnl_max_rss_qregion max_rss_qregion;
 	u16 msg_enable;
 	struct iavf_eth_stats current_stats;
 	struct virtchnl_qos_cap_list *qos_caps;
@@ -587,6 +602,9 @@ int iavf_send_vf_supported_rxdids_msg(struct iavf_adapter *adapter);
 int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter);
 int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter);
 int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter);
+int iavf_send_max_rss_qregion(struct iavf_adapter *adapter);
+int iavf_get_max_rss_qregion(struct iavf_adapter *adapter);
+int iavf_get_req_queues_reply(struct iavf_adapter *adapter);
 void iavf_set_queue_vlan_tag_loc(struct iavf_adapter *adapter);
 u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter);
 void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
@@ -601,6 +619,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter);
 void iavf_del_vlans(struct iavf_adapter *adapter);
 void iavf_set_promiscuous(struct iavf_adapter *adapter);
 bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter);
+int iavf_request_queues(struct iavf_adapter *adapter, int num);
 void iavf_request_stats(struct iavf_adapter *adapter);
 int iavf_request_reset(struct iavf_adapter *adapter);
 void iavf_get_rss_hashcfg(struct iavf_adapter *adapter);
@@ -621,6 +640,7 @@ int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
 				const void *cond_data,
 				unsigned int timeout_ms);
 int iavf_config_rss(struct iavf_adapter *adapter);
+void iavf_fill_rss_lut(struct iavf_adapter *adapter);
 void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
 void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter);
 void iavf_get_qos_caps(struct iavf_adapter *adapter);
diff --git a/include/linux/net/intel/virtchnl.h b/include/linux/net/intel/virtchnl.h
index 11bdab5522fd..ffb7d3c21334 100644
--- a/include/linux/net/intel/virtchnl.h
+++ b/include/linux/net/intel/virtchnl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (c) 2013-2022, Intel Corporation. */
+/* Copyright (c) 2013-2026, Intel Corporation. */
 
 #ifndef _VIRTCHNL_H_
 #define _VIRTCHNL_H_
@@ -22,8 +22,7 @@
  * we must send all messages as "indirect", i.e. using an external buffer.
  *
  * All the VSI indexes are relative to the VF. Each VF can have maximum of
- * three VSIs. All the queue indexes are relative to the VSI.  Each VF can
- * have a maximum of sixteen queues for all of its VSIs.
+ * three VSIs. All the queue indexes are relative to the VSI.
  *
  * The PF is required to return a status code in v_retval for all messages
  * except RESET_VF, which does not require any response. The returned value
@@ -147,6 +146,7 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DEL_RSS_CFG = 46,
 	VIRTCHNL_OP_ADD_FDIR_FILTER = 47,
 	VIRTCHNL_OP_DEL_FDIR_FILTER = 48,
+	VIRTCHNL_OP_GET_MAX_RSS_QREGION = 50,
 	VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS = 51,
 	VIRTCHNL_OP_ADD_VLAN_V2 = 52,
 	VIRTCHNL_OP_DEL_VLAN_V2 = 53,
@@ -159,7 +159,11 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_1588_PTP_GET_TIME = 61,
 	/* opcode 62 - 65 are reserved */
 	VIRTCHNL_OP_GET_QOS_CAPS = 66,
-	/* opcode 68 through 111 are reserved */
+	/* opcodes 67 through 106 are reserved */
+	VIRTCHNL_OP_ENABLE_QUEUES_V2 = 107,
+	VIRTCHNL_OP_DISABLE_QUEUES_V2 = 108,
+	/* opcodes 109 and 110 are reserved */
+	VIRTCHNL_OP_MAP_QUEUE_VECTOR = 111,
 	VIRTCHNL_OP_CONFIG_QUEUE_BW = 112,
 	VIRTCHNL_OP_CONFIG_QUANTA = 113,
 	VIRTCHNL_OP_MAX,
@@ -257,6 +261,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_REQ_QUEUES		BIT(6)
 /* used to negotiate communicating link speeds in Mbps */
 #define VIRTCHNL_VF_CAP_ADV_LINK_SPEED		BIT(7)
+#define VIRTCHNL_VF_LARGE_NUM_QPAIRS		BIT(9)
 #define  VIRTCHNL_VF_OFFLOAD_CRC		BIT(10)
 #define VIRTCHNL_VF_OFFLOAD_TC_U32		BIT(11)
 #define VIRTCHNL_VF_OFFLOAD_VLAN_V2		BIT(15)
@@ -500,6 +505,34 @@ struct virtchnl_queue_select {
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_queue_select);
 
+/* VIRTCHNL_OP_GET_MAX_RSS_QREGION
+ *
+ * if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated in
+ * VIRTCHNL_OP_GET_VF_RESOURCES then this op must be supported.
+ *
+ * VF sends this message in order to query the max RSS queue region
+ * size supported by PF, when VIRTCHNL_VF_LARGE_NUM_QPAIRS is enabled.
+ * This information should be used when configuring the RSS LUT and/or
+ * configuring queue region based filters.
+ *
+ * The maximum RSS queue region is 2^qregion_width. So, a qregion_width of 6
+ * would inform the VF that the PF supports a maximum RSS queue region of 64.
+ *
+ * A queue region represents a range of queues that can be used to configure
+ * a RSS LUT. For example, if a VF is given 64 queues, but only a max queue
+ * region size of 16 (i.e. 2^qregion_width = 16) then it will only be able
+ * to configure the RSS LUT with queue indices from 0 to 15. However, other
+ * filters can be used to direct packets to queues >15 via specifying a queue
+ * base/offset and queue region width.
+ */
+struct virtchnl_max_rss_qregion {
+	u16 vport_id;
+	u16 qregion_width;
+	u8 pad[4];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_max_rss_qregion);
+
 /* VIRTCHNL_OP_ADD_ETH_ADDR
  * VF sends this message in order to add one or more unicast or multicast
  * address filters for the specified VSI.
@@ -1663,6 +1696,70 @@ struct virtchnl_queue_chunk {
 
 VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
 
+/* VIRTCHNL_OP_ENABLE_QUEUES_V2
+ * VIRTCHNL_OP_DISABLE_QUEUES_V2
+ *
+ * These opcodes can be used if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated in
+ * VIRTCHNL_OP_GET_VF_RESOURCES
+ *
+ * VF sends virtchnl_ena_dis_queues struct to specify the queues to be
+ * enabled/disabled in chunks. Also applicable to single queue RX or
+ * TX. PF performs requested action and returns status.
+ */
+struct virtchnl_del_ena_dis_queues {
+	u16 vport_id;
+	u16 pad;
+	u16 num_chunks;
+	u16 rsvd;
+	struct virtchnl_queue_chunk chunks[];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_del_ena_dis_queues);
+#define virtchnl_del_ena_dis_queues_LEGACY_SIZEOF	16
+
+/* Virtchannel interrupt throttling rate index */
+enum virtchnl_itr_idx {
+	VIRTCHNL_ITR_IDX_0	= 0,
+	VIRTCHNL_ITR_IDX_1	= 1,
+	VIRTCHNL_ITR_IDX_NO_ITR	= 3,
+};
+
+/* Queue to vector mapping */
+struct virtchnl_queue_vector {
+	u16 queue_id;
+	u16 vector_id;
+	u8 pad[4];
+
+	/* see enum virtchnl_itr_idx */
+	s32 itr_idx;
+
+	/* see enum virtchnl_queue_type */
+	s32 queue_type;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_queue_vector);
+
+/* VIRTCHNL_OP_MAP_QUEUE_VECTOR
+ *
+ * This opcode can be used only if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated
+ * in VIRTCHNL_OP_GET_VF_RESOURCES
+ *
+ * VF sends this message to map queues to vectors and ITR index registers.
+ * External data buffer contains virtchnl_queue_vector_maps structure
+ * that contains num_qv_maps of virtchnl_queue_vector structures.
+ * PF maps the requested queue vector maps after validating the queue and vector
+ * ids and returns a status code.
+ */
+struct virtchnl_queue_vector_maps {
+	u16 vport_id;
+	u16 num_qv_maps;
+	u8 pad[4];
+	struct virtchnl_queue_vector qv_maps[];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_vector_maps);
+#define virtchnl_queue_vector_maps_LEGACY_SIZEOF	24
+
 struct virtchnl_quanta_cfg {
 	u16 quanta_size;
 	u16 pad;
@@ -1695,6 +1792,8 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_quanta_cfg);
 		 __vss(virtchnl_rdma_qvlist_info, __vss_byelem, p, m, c),     \
 		 __vss(virtchnl_qos_cap_list, __vss_byelem, p, m, c),	      \
 		 __vss(virtchnl_queues_bw_cfg, __vss_byelem, p, m, c),	      \
+		 __vss(virtchnl_del_ena_dis_queues, __vss_byelem, p, m, c),   \
+		 __vss(virtchnl_queue_vector_maps, __vss_byelem, p, m, c),    \
 		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
 		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
 
@@ -1757,6 +1856,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_DISABLE_QUEUES:
 		valid_len = sizeof(struct virtchnl_queue_select);
 		break;
+	case VIRTCHNL_OP_GET_MAX_RSS_QREGION:
+		break;
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 	case VIRTCHNL_OP_DEL_ETH_ADDR:
 		valid_len = virtchnl_ether_addr_list_LEGACY_SIZEOF;
@@ -1929,7 +2030,32 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_1588_PTP_GET_TIME:
 		valid_len = sizeof(struct virtchnl_phc_time);
 		break;
-	/* These are always errors coming from the VF. */
+	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
+	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
+		valid_len = sizeof(struct virtchnl_del_ena_dis_queues);
+		if (msglen >= valid_len) {
+			struct virtchnl_del_ena_dis_queues *qs =
+				(struct virtchnl_del_ena_dis_queues *)msg;
+
+			if (!qs->num_chunks) {
+				err_msg_format = true;
+				break;
+			}
+			valid_len = virtchnl_struct_size(qs, chunks,
+							 qs->num_chunks);
+		}
+		break;
+	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
+		valid_len = virtchnl_queue_vector_maps_LEGACY_SIZEOF;
+		if (msglen >= valid_len) {
+			struct virtchnl_queue_vector_maps *v_qp = (void *)msg;
+
+			err_msg_format = !v_qp->num_qv_maps;
+			valid_len = virtchnl_struct_size(v_qp, qv_maps,
+							 v_qp->num_qv_maps);
+		}
+		break;
+	/* These are always errors when coming from the VF. */
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index e7cf12eaa268..3938c78597cb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1683,6 +1683,18 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 
 	return ret;
 }
+
+/* in LARGE mode PF gives us up to its RSS region once it has told us that */
+static u32 iavf_max_channels(struct iavf_adapter *adapter)
+{
+	u16 width = adapter->max_rss_qregion.qregion_width;
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && width)
+		return BIT(width);
+
+	return adapter->vsi_res->num_queue_pairs;
+}
+
 /**
  * iavf_get_channels - get the number of channels supported by the device
  * @netdev: network interface device structure
@@ -1697,7 +1709,7 @@ static void iavf_get_channels(struct net_device *netdev,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	/* Report maximum channels */
-	ch->max_combined = adapter->vsi_res->num_queue_pairs;
+	ch->max_combined = iavf_max_channels(adapter);
 
 	ch->max_other = NONQ_VECS;
 	ch->other_count = NONQ_VECS;
@@ -1730,15 +1742,29 @@ static int iavf_set_channels(struct net_device *netdev,
 	/* All of these should have already been checked by ethtool before this
 	 * even gets to us, but just to be sure.
 	 */
-	if (num_req == 0 || num_req > adapter->vsi_res->num_queue_pairs)
+	if (num_req == 0 || num_req > iavf_max_channels(adapter))
 		return -EINVAL;
 
-	if (num_req == adapter->num_active_queues)
+	/* PF has not answered our previous request yet */
+	if (adapter->current_op == VIRTCHNL_OP_REQUEST_QUEUES)
+		return -EBUSY;
+
+	if (num_req == adapter->num_active_queues) {
+		/* drop a request that is not sent yet */
+		adapter->aq_required &= ~IAVF_FLAG_AQ_REQUEST_QUEUES;
 		return 0;
+	}
 
 	if (ch->rx_count || ch->tx_count || ch->other_count != NONQ_VECS)
 		return -EINVAL;
 
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		/* the watchdog sends it once no other op is in flight */
+		adapter->num_req_queues_next = num_req;
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_REQUEST_QUEUES);
+		return 0;
+	}
+
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	adapter->flags |= IAVF_FLAG_RESET_NEEDED;
@@ -1817,13 +1843,26 @@ static int iavf_set_rxfh(struct net_device *netdev,
 			 struct netlink_ext_ack *extack)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
+	u16 width = adapter->max_rss_qregion.qregion_width;
 	u16 i;
 
 	/* Only support toeplitz hash function */
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	/* PF takes only queues from its RSS region, see iavf_fill_rss_lut() */
+	if (rxfh->indir && LARGE_NUM_QPAIRS_SUPPORT(adapter) && width) {
+		for (i = 0; i < adapter->rss_lut_size; i++) {
+			if (rxfh->indir[i] < BIT(width))
+				continue;
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "RSS can use only the first %lu queues",
+					       BIT(width));
+			return -EINVAL;
+		}
+	}
+
 	if ((rxfh->input_xfrm & RXH_XFRM_SYM_XOR) &&
 	    adapter->hfunc != VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC) {
 		if (!ADV_RSS_SUPPORT(adapter))
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index db769eead68f..7285f665b4fb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -509,6 +509,7 @@ static void iavf_map_rings_to_vectors(struct iavf_adapter *adapter)
 			vidx = 0;
 	}
 
+	adapter->map_qps_sent = 0;
 	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 }
 
@@ -1783,12 +1784,17 @@ int iavf_config_rss(struct iavf_adapter *adapter)
  * iavf_fill_rss_lut - Fill the lut with default values
  * @adapter: board private structure
  **/
-static void iavf_fill_rss_lut(struct iavf_adapter *adapter)
+void iavf_fill_rss_lut(struct iavf_adapter *adapter)
 {
-	u16 i;
+	struct virtchnl_max_rss_qregion *qregion = &adapter->max_rss_qregion;
+	int max = adapter->num_active_queues;
+
+	/* width == 0: PF has not told us the region yet */
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && qregion->qregion_width)
+		max = min(max, (int)BIT(qregion->qregion_width));
 
-	for (i = 0; i < adapter->rss_lut_size; i++)
-		adapter->rss_lut[i] = i % adapter->num_active_queues;
+	for (int i = 0; i < adapter->rss_lut_size; i++)
+		adapter->rss_lut[i] = i % max;
 }
 
 /**
@@ -2099,6 +2105,8 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 {
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_CONFIG)
 		return iavf_send_vf_config_msg(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_MAX_RSS_QREGION)
+		return iavf_send_max_rss_qregion(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS)
 		return iavf_send_vf_offload_vlan_v2_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS)
@@ -2273,6 +2281,11 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_virtchnl_send_ptp_cmd(adapter);
 		return IAVF_SUCCESS;
 	}
+	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_QUEUES) {
+		adapter->aq_required &= ~IAVF_FLAG_AQ_REQUEST_QUEUES;
+		iavf_request_queues(adapter, adapter->num_req_queues_next);
+		return 0;
+	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_STATS) {
 		iavf_request_stats(adapter);
 		return 0;
@@ -2468,8 +2481,10 @@ static void iavf_init_version_check(struct iavf_adapter *adapter)
  */
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 {
-	int i, num_req_queues = adapter->num_req_queues;
+	int i, qnum, num_req_queues = adapter->num_req_queues;
 	struct iavf_vsi *vsi = &adapter->vsi;
+	bool reconfig_rss = false;
+	bool init_req = false;
 
 	for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 		if (adapter->vf_res->vsi_res[i].vsi_type == VIRTCHNL_VSI_SRIOV)
@@ -2480,6 +2495,18 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 		return -ENODEV;
 	}
 
+	/* in LARGE mode we ask PF at init for more queues, up to one per CPU */
+	if (adapter->state == __IAVF_INIT_GET_RESOURCES &&
+	    LARGE_NUM_QPAIRS_SUPPORT(adapter) &&
+	    adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_REQ_QUEUES)
+		init_req = true;
+
+	/* PF resets us to grant the request, but other resets could come
+	 * first, then we have a different count and need to ask again
+	 */
+	if (init_req && num_req_queues != adapter->vsi_res->num_queue_pairs)
+		num_req_queues = 0;
+
 	if (num_req_queues &&
 	    num_req_queues > adapter->vsi_res->num_queue_pairs) {
 		/* Problem.  The PF gave us fewer queues than what we had
@@ -2496,21 +2523,70 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 
 		return -EAGAIN;
 	}
+	/* PF could cut our queues on reset, e.g. when RSS LUT got smaller */
+	if (adapter->num_active_queues > adapter->vsi_res->num_queue_pairs) {
+		adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
+		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+
+		return -EAGAIN;
+	}
 	adapter->num_req_queues = 0;
 	adapter->vsi.id = adapter->vsi_res->vsi_id;
 
 	adapter->vsi.back = adapter;
 	adapter->vsi.base_vector = 1;
 	vsi->netdev = adapter->netdev;
 	vsi->qs_handle = adapter->vsi_res->qset_handle;
 	if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
-		adapter->rss_key_size = adapter->vf_res->rss_key_size;
-		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
+		if ((adapter->rss_key &&
+		     adapter->rss_key_size != adapter->vf_res->rss_key_size) ||
+		    (adapter->rss_lut &&
+		     adapter->rss_lut_size != adapter->vf_res->rss_lut_size)) {
+			reconfig_rss = true;
+		} else {
+			adapter->rss_key_size = adapter->vf_res->rss_key_size;
+			adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
+		}
 	} else {
 		adapter->rss_key_size = IAVF_HKEY_ARRAY_SIZE;
 		adapter->rss_lut_size = IAVF_HLUT_ARRAY_SIZE;
 	}
 
+	if (reconfig_rss) {
+		u8 *rss_key, *rss_lut;
+
+		rss_key = kzalloc(adapter->vf_res->rss_key_size, GFP_KERNEL);
+		rss_lut = kzalloc(adapter->vf_res->rss_lut_size, GFP_KERNEL);
+		if (!rss_lut || !rss_key) {
+			kfree(rss_key);
+			kfree(rss_lut);
+			/* old buffers and sizes are kept, retry via reset */
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+			return -ENOMEM;
+		}
+
+		kfree(adapter->rss_key);
+		kfree(adapter->rss_lut);
+		adapter->rss_key = rss_key;
+		adapter->rss_lut = rss_lut;
+		adapter->rss_key_size = adapter->vf_res->rss_key_size;
+		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
+		iavf_init_rss(adapter);
+	}
+
+	if (init_req) {
+		qnum = min_t(int, num_online_cpus(), IAVF_MAX_REQ_QUEUES);
+		/* granted, or we have enough */
+		if (num_req_queues || qnum <= adapter->vsi_res->num_queue_pairs)
+			return 0;
+
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		adapter->extended_caps |= IAVF_EXTENDED_CAP_RECV_REQ_QUEUES;
+
+		return iavf_request_queues(adapter, qnum);
+	}
+
 	return 0;
 }
 
@@ -2557,17 +2633,18 @@ static void iavf_init_get_resources(struct iavf_adapter *adapter)
 		goto err_alloc;
 	}
 
+	/* Some features require additional messages to negotiate extended
+	 * capabilities. These are processed in sequence by the
+	 * __IAVF_INIT_EXTENDED_CAPS driver state.
+	 */
+	adapter->extended_caps = IAVF_EXTENDED_CAPS;
+
 	err = iavf_parse_vf_resource_msg(adapter);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to parse VF resource message from PF (%d)\n",
 			err);
 		goto err_alloc;
 	}
-	/* Some features require additional messages to negotiate extended
-	 * capabilities. These are processed in sequence by the
-	 * __IAVF_INIT_EXTENDED_CAPS driver state.
-	 */
-	adapter->extended_caps = IAVF_EXTENDED_CAPS;
 
 	iavf_change_state(adapter, __IAVF_INIT_EXTENDED_CAPS);
 	return;
@@ -2579,6 +2656,47 @@ static void iavf_init_get_resources(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+/**
+ * iavf_init_recv_req_queues - part of requesting queues in LARGE mode
+ * @adapter: board private structure
+ *
+ * Function waits for the outcome of the queue request sent by
+ * iavf_parse_vf_resource_msg(). PF resets us when it grants the request and
+ * replies only to deny it, then we ask for as many queues as PF can give,
+ * unless we have that many already.
+ */
+static void iavf_init_recv_req_queues(struct iavf_adapter *adapter)
+{
+	int num = -EALREADY;
+
+	/* PF grants by resetting us, the event may be lost with the ARQ */
+	if (rd32(&adapter->hw, IAVF_VF_ARQLEN1) &
+	    IAVF_VF_ARQLEN1_ARQENABLE_MASK)
+		num = iavf_get_req_queues_reply(adapter);
+	else
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
+
+	if (num == -EALREADY || adapter->flags & IAVF_FLAG_RESET_PENDING) {
+		/* no reply yet, or PF reset us after granting */
+		iavf_change_state(adapter, __IAVF_INIT_FAILED);
+		return;
+	}
+
+	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+	if (num > 0) {
+		dev_info(&adapter->pdev->dev,
+			 "Requested %d queues, PF can support %d\n",
+			 adapter->num_req_queues, num);
+		if (num > adapter->vsi_res->num_queue_pairs &&
+		    !iavf_request_queues(adapter, num))
+			return;
+	}
+
+	/* go on with the queues PF has given us */
+	adapter->num_req_queues = 0;
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_REQ_QUEUES;
+}
+
 /**
  * iavf_init_send_offload_vlan_v2_caps - part of initializing VLAN V2 caps
  * @adapter: board private structure
@@ -2636,6 +2754,65 @@ static void iavf_init_recv_offload_vlan_v2_caps(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+/*
+ * iavf_init_send_max_rss_qregion - part of querying for RSS max queue region
+ * @adapter: board private structure
+ *
+ * Function processes send of the VIRTCHNL_OP_GET_MAX_RSS_QREGION to the PF.
+ * Must clear IAVF_EXTENDED_CAP_RECV_RSS_QREGION if the message is not sent, e.g.
+ * due to the PF not negotiating VIRTCHNL_VF_LARGE_NUM_QPAIRS.
+ */
+static void iavf_init_send_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	int ret;
+
+	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RSS_QREGION));
+
+	ret = iavf_send_max_rss_qregion(adapter);
+	if (ret == -EOPNOTSUPP) {
+		/* PF does not support VIRTCHNL_VF_LARGE_NUM_QPAIRS. In this
+		 * case, we did not send the capability exchange message and do
+		 * not expect a response.
+		 */
+		adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RSS_QREGION;
+	}
+
+	/* We sent the message, so move on to the next step */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_SEND_RSS_QREGION;
+}
+
+/**
+ * iavf_init_recv_max_rss_qregion - part of querying for RSS max queue region
+ * @adapter: board private structure
+ *
+ * Function processes receipt of the RSS max qregion to be used for the LUT.
+ */
+static void iavf_init_recv_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	int ret;
+
+	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RSS_QREGION));
+
+	memset(&adapter->max_rss_qregion, 0, sizeof(adapter->max_rss_qregion));
+
+	ret = iavf_get_max_rss_qregion(adapter);
+	if (ret)
+		goto err;
+
+	/* We've processed the PF response to the VIRTCHNL_OP_GET_MAX_RSS_QREGION
+	 * message we sent previously.
+	 */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RSS_QREGION;
+	return;
+
+err:
+	/* We didn't receive a reply. Make sure we try sending again when
+	 * __IAVF_INIT_FAILED attempts to recover.
+	 */
+	adapter->extended_caps |= IAVF_EXTENDED_CAP_SEND_RSS_QREGION;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
+}
+
 /**
  * iavf_init_send_supported_rxdids - part of querying for supported RXDID
  * formats
@@ -2757,6 +2934,12 @@ static void iavf_init_process_extended_caps(struct iavf_adapter *adapter)
 {
 	WARN_ON(adapter->state != __IAVF_INIT_EXTENDED_CAPS);
 
+	/* Must be first, other steps would drop the reply while polling */
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_REQ_QUEUES) {
+		iavf_init_recv_req_queues(adapter);
+		return;
+	}
+
 	/* Process capability exchange for VLAN V2 */
 	if (adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_VLAN_V2) {
 		iavf_init_send_offload_vlan_v2_caps(adapter);
@@ -2784,6 +2967,16 @@ static void iavf_init_process_extended_caps(struct iavf_adapter *adapter)
 		return;
 	}
 
+	/* Process capability exchange for RSS max qregion */
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RSS_QREGION) {
+		iavf_init_send_max_rss_qregion(adapter);
+		return;
+	}
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RSS_QREGION) {
+		iavf_init_recv_max_rss_qregion(adapter);
+		return;
+	}
+
 	/* When we reach here, no further extended capabilities exchanges are
 	 * necessary, so we finally transition into __IAVF_INIT_CONFIG_ADAPTER
 	 */
@@ -2893,6 +3086,10 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	/* Setup initial PTP configuration */
 	iavf_ptp_init(adapter);
 
+	/* queues requested at init are set up now */
+	adapter->num_req_queues = 0;
+	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+
 	iavf_schedule_finish_config(adapter);
 	return;
 
@@ -2977,6 +3174,9 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
 			 */
 			iavf_change_state(adapter, __IAVF_STARTUP);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
+			/* fresh retry budget, and init asks for queues again */
+			adapter->aq_wait_count = 0;
+			adapter->num_req_queues = 0;
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
@@ -3258,6 +3458,11 @@ void iavf_reset_step(struct iavf_adapter *adapter)
 		err = iavf_reinit_interrupt_scheme(adapter, running);
 		if (err)
 			goto reset_err;
+	} else {
+		/* queues we requested were set up by the previous reset, fewer
+		 * of them now is a config change, not a denial
+		 */
+		adapter->num_req_queues = 0;
 	}
 
 	if (RSS_AQ(adapter)) {
@@ -3269,6 +3474,7 @@ void iavf_reset_step(struct iavf_adapter *adapter)
 	}
 
 	adapter->aq_required |= IAVF_FLAG_AQ_GET_CONFIG;
+	adapter->map_qps_sent = 0;
 	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 
 	/* Certain capabilities require an extended negotiation process using
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 6555e8b10171..2036d9b058c4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -170,6 +170,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_VLAN_V2 |
 	       VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC |
 	       VIRTCHNL_VF_OFFLOAD_CRC |
+	       VIRTCHNL_VF_LARGE_NUM_QPAIRS |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM |
 	       VIRTCHNL_VF_OFFLOAD_REQ_QUEUES |
 	       VIRTCHNL_VF_CAP_PTP |
@@ -251,28 +252,45 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
 				(u8 *)&hw_caps, sizeof(hw_caps));
 }
 
+int iavf_send_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_MAX_RSS_QREGION;
+
+	if (!LARGE_NUM_QPAIRS_SUPPORT(adapter))
+		return -EOPNOTSUPP;
+
+	adapter->current_op = VIRTCHNL_OP_GET_MAX_RSS_QREGION;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_MAX_RSS_QREGION, NULL, 0);
+	return 0;
+}
+
 /**
  * iavf_validate_num_queues
  * @adapter: adapter structure
  *
  * Validate that the number of queues the PF has sent in
  * VIRTCHNL_OP_GET_VF_RESOURCES is not larger than the VF can handle.
  **/
 static void iavf_validate_num_queues(struct iavf_adapter *adapter)
 {
-	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
+	u32 max_req_queues = IAVF_MAX_REQ_QUEUES;
+
+	if (!LARGE_NUM_QPAIRS_SUPPORT(adapter))
+		max_req_queues = IAVF_MAX_VSI_QP;
+
+	if (adapter->vf_res->num_queue_pairs > max_req_queues) {
 		struct virtchnl_vsi_resource *vsi_res;
 		int i;
 
 		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
 			 adapter->vf_res->num_queue_pairs,
-			 IAVF_MAX_REQ_QUEUES);
+			 max_req_queues);
 		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
-			 IAVF_MAX_REQ_QUEUES);
-		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			 max_req_queues);
+		adapter->vf_res->num_queue_pairs = max_req_queues;
 		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
 			vsi_res = &adapter->vf_res->vsi_res[i];
-			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
+			vsi_res->num_queue_pairs = max_req_queues;
 		}
 	}
 }
@@ -371,6 +389,57 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
 	return err;
 }
 
+int iavf_get_max_rss_qregion(struct iavf_adapter *adapter)
+{
+	struct iavf_arq_event_info event;
+	int err;
+	u16 len;
+
+	len = sizeof(struct virtchnl_max_rss_qregion);
+	event.buf_len = len;
+	event.msg_buf = kzalloc(len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
+
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
+				     VIRTCHNL_OP_GET_MAX_RSS_QREGION);
+	if (!err)
+		memcpy(&adapter->max_rss_qregion, event.msg_buf,
+		       min(event.msg_len, len));
+
+	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+
+	kfree(event.msg_buf);
+	return err;
+}
+
+/**
+ * iavf_get_req_queues_reply - poll for PF reply to our queue request
+ * @adapter: private adapter structure
+ *
+ * PF resets us when it grants the request, so a reply means a denial.
+ *
+ * Return: number of queues PF can give us, or negative error code.
+ */
+int iavf_get_req_queues_reply(struct iavf_adapter *adapter)
+{
+	/* poll looks for the reset event in the same buffer */
+	union {
+		struct virtchnl_vf_res_request vfres;
+		struct virtchnl_pf_event vpe;
+	} msg = {};
+	struct iavf_arq_event_info event = {
+		.buf_len = sizeof(msg),
+		.msg_buf = (u8 *)&msg,
+	};
+	int err;
+
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
+				     VIRTCHNL_OP_REQUEST_QUEUES);
+
+	return err ?: msg.vfres.num_queue_pairs;
+}
+
 /**
  * iavf_configure_queues
  * @adapter: adapter structure
@@ -438,6 +507,50 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 	kfree(vqci);
 }
 
+/**
+ * iavf_enable_disable_queues_v2 - send V2 messages of ENABLE/DISABLE queues ops
+ * @adapter: private adapter structure
+ * @enable: true to enable and false to disable the queues
+ */
+static void iavf_enable_disable_queues_v2(struct iavf_adapter *adapter, bool enable)
+{
+	enum virtchnl_ops op = VIRTCHNL_OP_ENABLE_QUEUES_V2;
+	struct virtchnl_del_ena_dis_queues *msg;
+	u64 flag = IAVF_FLAG_AQ_ENABLE_QUEUES;
+	struct virtchnl_queue_chunk *chunk;
+	int len;
+
+	if (!enable) {
+		op = VIRTCHNL_OP_DISABLE_QUEUES_V2;
+		flag = IAVF_FLAG_AQ_DISABLE_QUEUES;
+	}
+
+	/* We need 2 chunks (one Tx and one Rx). */
+	len = virtchnl_struct_size(msg, chunks, 2);
+	msg = kzalloc(len, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	adapter->current_op = op;
+
+	msg->vport_id = adapter->vsi_res->vsi_id;
+	msg->num_chunks = 2;
+
+	chunk = &msg->chunks[0];
+	chunk->type = VIRTCHNL_QUEUE_TYPE_RX;
+	chunk->start_queue_id = 0;
+	chunk->num_queues = adapter->num_active_queues;
+
+	chunk++;
+	chunk->type = VIRTCHNL_QUEUE_TYPE_TX;
+	chunk->start_queue_id = 0;
+	chunk->num_queues = adapter->num_active_queues;
+
+	adapter->aq_required &= ~flag;
+	iavf_send_pf_msg(adapter, op, (u8 *)msg, len);
+	kfree(msg);
+}
+
 /**
  * iavf_enable_queues
  * @adapter: adapter structure
@@ -454,6 +567,12 @@ void iavf_enable_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		iavf_enable_disable_queues_v2(adapter, true);
+		return;
+	}
+
 	adapter->current_op = VIRTCHNL_OP_ENABLE_QUEUES;
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
@@ -479,15 +598,65 @@ void iavf_disable_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		iavf_enable_disable_queues_v2(adapter, false);
+		return;
+	}
+
 	adapter->current_op = VIRTCHNL_OP_DISABLE_QUEUES;
 	vqs.vsi_id = adapter->vsi_res->vsi_id;
 	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
 	vqs.rx_queues = vqs.tx_queues;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_DISABLE_QUEUES;
 	iavf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_QUEUES,
 			 (u8 *)&vqs, sizeof(vqs));
 }
 
+static void iavf_map_queue_vector(struct iavf_adapter *adapter)
+{
+	struct virtchnl_queue_vector_maps *qvmaps;
+	int first = adapter->map_qps_sent;
+	struct virtchnl_queue_vector *qv;
+	int len, qnum;
+
+	qnum = min_t(int, adapter->num_active_queues - first,
+		     iavf_max_vc_entries(qvmaps, qv_maps) / 2);
+	len = virtchnl_struct_size(qvmaps, qv_maps, 2 * qnum);
+	qvmaps = kzalloc(len, GFP_KERNEL);
+	if (!qvmaps)
+		return;
+
+	qvmaps->vport_id = adapter->vsi_res->vsi_id;
+	qvmaps->num_qv_maps = 2 * qnum;
+	qv = qvmaps->qv_maps;
+	for (int qid = first; qid < first + qnum; qid++) {
+		struct iavf_q_vector *q_vector;
+
+		q_vector = adapter->tx_rings[qid].q_vector;
+		qv->queue_id = qid;
+		qv->vector_id = NONQ_VECS + q_vector->v_idx;
+		qv->itr_idx = IAVF_TX_ITR;
+		qv->queue_type = VIRTCHNL_QUEUE_TYPE_TX;
+		qv++;
+
+		q_vector = adapter->rx_rings[qid].q_vector;
+		qv->queue_id = qid;
+		qv->vector_id = NONQ_VECS + q_vector->v_idx;
+		qv->itr_idx = IAVF_RX_ITR;
+		qv->queue_type = VIRTCHNL_QUEUE_TYPE_RX;
+		qv++;
+	}
+
+	adapter->current_op = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
+	adapter->map_qps_sent += qnum;
+	if (adapter->map_qps_sent == adapter->num_active_queues)
+		adapter->aq_required &= ~IAVF_FLAG_AQ_MAP_VECTORS;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+			 (u8 *)qvmaps, len);
+	kfree(qvmaps);
+}
+
 /**
  * iavf_map_queues
  * @adapter: adapter structure
@@ -509,6 +678,12 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
+		iavf_map_queue_vector(adapter);
+		return;
+	}
+
 	adapter->current_op = VIRTCHNL_OP_CONFIG_IRQ_MAP;
 
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
@@ -545,6 +720,40 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 	kfree(vimi);
 }
 
+/**
+ * iavf_request_queues - request queues via virtchnl
+ * @adapter: adapter structure
+ * @num: number of requested queues
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int iavf_request_queues(struct iavf_adapter *adapter, int num)
+{
+	struct virtchnl_vf_res_request vfres = { num };
+	int err;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot request queues, command %d pending\n",
+			adapter->current_op);
+		return -EBUSY;
+	}
+
+	adapter->current_op = VIRTCHNL_OP_REQUEST_QUEUES;
+	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
+	adapter->num_req_queues = num;
+
+	err = iavf_send_pf_msg(adapter, VIRTCHNL_OP_REQUEST_QUEUES,
+			       (u8 *)&vfres, sizeof(vfres));
+	if (err) {
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+		adapter->num_req_queues = 0;
+	}
+
+	return err;
+}
+
 /**
  * iavf_set_mac_addr_type - Set the correct request type from the filter type
  * @virtchnl_ether_addr: pointer to requested list element
@@ -2565,6 +2774,18 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			/* don't send the remaining queue pairs */
 			adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 			break;
+		case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
+			dev_err(&adapter->pdev->dev, "Failed to map queues to vectors, error %s\n",
+				iavf_stat_str(&adapter->hw, v_retval));
+			/* don't send the remaining queues */
+			adapter->aq_required &= ~IAVF_FLAG_AQ_MAP_VECTORS;
+			break;
+		case VIRTCHNL_OP_REQUEST_QUEUES:
+			dev_err(&adapter->pdev->dev, "Failed to request queues, error %s\n",
+				iavf_stat_str(&adapter->hw, v_retval));
+			adapter->num_req_queues = 0;
+			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval, iavf_stat_str(&adapter->hw, v_retval),
@@ -2707,6 +2928,20 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			aq_required;
 		}
 		break;
+	case VIRTCHNL_OP_GET_MAX_RSS_QREGION: {
+		u16 width = adapter->max_rss_qregion.qregion_width;
+
+		if (v_retval)
+			break;
+		memcpy(&adapter->max_rss_qregion, msg,
+		       sizeof(adapter->max_rss_qregion));
+		/* LUT was filled before this reply, for the old region */
+		if (adapter->max_rss_qregion.qregion_width != width) {
+			iavf_fill_rss_lut(adapter);
+			iavf_config_rss(adapter);
+		}
+		break;
+	}
 	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
 		if (msglen != sizeof(u64))
 			return;
@@ -2727,20 +2962,23 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		iavf_virtchnl_ptp_get_time(adapter, msg, msglen);
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
+	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
+	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
 		iavf_free_all_tx_resources(adapter);
 		iavf_free_all_rx_resources(adapter);
 		if (adapter->state == __IAVF_DOWN_PENDING) {
 			iavf_change_state(adapter, __IAVF_DOWN);
 			wake_up(&adapter->down_waitqueue);
 		}
 		break;
 	case VIRTCHNL_OP_VERSION:
 	case VIRTCHNL_OP_CONFIG_IRQ_MAP:
+	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
 		/* Don't display an error if we get these out of sequence.
 		 * If the firmware needed to get kicked, we'll get these and
 		 * it's no problem.
@@ -2763,7 +3001,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		struct virtchnl_vf_res_request *vfres =
 			(struct virtchnl_vf_res_request *)msg;
 
-		if (vfres->num_queue_pairs != adapter->num_req_queues) {
+		if (!v_retval &&
+		    vfres->num_queue_pairs != adapter->num_req_queues) {
 			dev_info(&adapter->pdev->dev,
 				 "Requested %d queues, PF can support %d\n",
 				 adapter->num_req_queues,
-- 
2.54.0

