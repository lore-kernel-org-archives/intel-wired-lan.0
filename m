Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D156CA9ED5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 06:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F289F40637;
	Mon, 12 Oct 2026 06:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wmhX65cB2wTE; Mon, 12 Oct 2026 06:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6170140629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791786658;
	b=WzyJLyt2TS8aXaK7N3Sivthl/oDEKlDEi22wSoGBacbmGNiTA5Mh64Z975X7A5WS2SeR
	 MKMs8+9OnfPRL4nkg4dmYMM3V+mzBHJfzm1dTxZ8O4dKuT9LoQEIUc3sbWwzpRk/rmHsW
	 nBooEPG3tDv+yXRCwSaOXDZVrkWU987fmpeseWtztYciwk8bZkbDjV9k7w/gB8Ij/hSnn
	 W+9o7c20SyATYqrl1PtRO9eSBc+dvwSshTOIjtbnfXKm38jfsC4f4kqS3JsB7Gn4vS3Zl
	 8NqELXnpF/ikRj53rQQJBA+8bzA2B0p9YYdLPnNfz+Zw3pefZ2QFuvm5pXB977UTXoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791786658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
	b=JaOyD2Bq1ydaO8xpURmq5SLAY+/a+YJ5JztAihZkg836dVSvI+EpsH5sNIo7nYJC8Dy5
	 OUKLEfaGoZ3hf/rZiuV859Anp9u6aawCLMEw7qjcVzG/kezkqSQCCDtTfWOmYTjRpX3GY
	 Po7Uuy8DOlvJWTB/WmxGoLyuID6Y42WHMxwzxtc5OYsk1CaI4BE39gjeQdye96Y/QvAuD
	 dzyfnUDG22mo5N3qh6eRVGywH2egaWCqM4FLPavGInDvgxQxkZx6WmGJ4MXURmPEpx1bR
	 GkoOsOo0209TAPBu9Hn+BVtng+tlKLh582uDtQ/U6bNQFfO3vBvJojHiqNYQ+dMq6QA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791786658;
	bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2IUSuy2j8hO4Psu1RlRdnPh076iQl+jI1IasSyNbaH4UAKq51z/JRnTyZkdYdKXSZ
	 yF/aJNcd3Fla1d433e6cJBqZYiYS40xE30ZLni8VmYqnMLl4uC9WN4sVCpH2B1M5Oq
	 uAA5BFZwUlY+SnybmIpHEVE0zj/OQpN2Es7lROnoBfxaLBu0ZrOJ3IyHX3dsZqwwr4
	 TlFVLDIYDuXb2N66bQDRAMQqxb/MzoYo/mT3bnH61XPvlI9TD4WxhbCU/f/jo8oQI/
	 1mg8V2Uy0rq1oZxvQO+uEFSPD4OSJryLBpfEkXIrWxFMS/gtG/suYTyZvWklgGRAN4
	 e4cBvsNk1gf1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6170140629;
	Mon, 12 Oct 2026 06:30:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFD009CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D065380CEE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AR3GMVbYmz7u for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 06:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28C7E80CCC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791786656;
 b=fuzAydYW1Qc+1M7wKjhKRgSMDX1ovxwxH5/oLvLfYsMaAObMy57yewHYkqKIHl44We7s
 3v3zpBzEVhxIrKB3kC08Ol5XdjtuKNu/rcvlMjoogNpE98oQw21u3flxr8VkOPd7dn/9V
 UNKh8wyx+nrhp638Hv02dzONMBZRG5IEYS/H38f3WnrGjSDshyfJAvqzkk6/bgn10x/RB
 ZR5eXEpvtNjaxQhq4ZbDxr+NOH2w/h5fJHJKAloRzBfwNBkocMwkljnnsDf5OWeHO/TP2
 zkxP/51E3ooD3SQ8lBiPsQkTN/1PuhiyjkP2pRXJtBHa0K43hYHR+7RJ+auJSXJ5daQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791786656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
 b=iM7X56bX6J0bQr21NE4MqoU/sEC6qtcaTCJGc53AZMM5nQuUBRQ07Ui0FpDJ9rMjYhcA
 MKLwyh6iQsEkCLHXYzvGCQYhN6w/DJGaztY3u8dnAJRu35qL87aKjyUTpHXff/7ayTjMS
 8S4E4+qzw7J9js85D/BDXpgcTL+S0R5JgGmlQ6aMSducu1ZXL8UufrC/yERkNpYc/bkYk
 k3//bohdYA4ITVRoh3FxHzVnwMgxP7/T//o+xkKjzu+sfa5DRgI+tZO8OfOqjZkYrmVql
 npu775zwjgEVuworpLX/G+sjwrhid9vKHoqPOIn0mvwzUWp8cL5daH6cigv2DEY7wnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W6oTbqpi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=W6oTbqpi
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28C7E80CCC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:30:55 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e5378b281aso7639425ad.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791786655; x=1792391455; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
 b=W6oTbqpi24fe2cxPjIRmQLFXEXmKliLTOjiWkR/LKVC0qNEwMfu0bz4O41cq89MT0M
 xPzxE3aoxwPhT1rupsKp7KeZ7COqjCI91lEXyzj8ZmWlfcGqkJ9Kv+NYT5PogfWOTZXl
 CQaIBIBV6iO+lk3s6bwkjuZnv6g8HMEEk7AWLHff6Gcs2hTB6EWhODCokR+CphzgBOBl
 PArlK8qaczwiQ83xPeP9aSR15hwzX5cPQTSUVorltoWzmDLVsAqptNAK5w7PF9s39+CM
 gW5kL6k+aig0on4Et5jZGSWs1RsGfMQ/rQJ0JYxgV8it+kO0MZzvkDeFdZKwN6h27luO
 UB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791786655; x=1792391455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=seozyzMPcRgvoknCy8U1DFhAaYhZLfvbDoE5+Gd/ZQc=;
 b=NfcFk2PxjnwMhKL4KP3hqVljb932yGgiAjPiL84BLVm8VsFDHsdMB8ek2hMMue0FK5
 BsHJFv+Xn9Sa1WO3lK0lk5Y564l80qvjCaI2V/Pxx8cLVl4oHMVQx7Ij+r7YsDJcnvzk
 pGWKLK9M2Glc7CQwLFIe1PgcKU/ytWH0Vb4XWpKoqIDmql+hiC4HSnXKMXJ9HJYlpn2q
 XYeBqSK+n4vfLlm+9pjpZOz60SVoZIQgfW1WQ3aAeA1dVP2q2o/Bn9qjV14je+4S95OK
 n0GEuC1B0YetAk1VjFKqo1yUbpV+io1+lu7fFbOnoPq3FxB+txPif4e1o3x+5WkvD7bS
 9SHA==
X-Gm-Message-State: AFq9FYK2K8EW5FEAVtfQuJ4ng7yRmu6GIzg4CXGWrTyGi92sasaQfDNc
 A1TjKMQiQQZOwMEC5IpgNrnau1DMMBnXsmkuxyCyja4GIiyPXi7A1TILVfvhbtzuKeo=
X-Gm-Gg: AYBFou1gk3GVM4CRCzveLDKSML4aTAkNjW8p9U5nm+6534A3j8/WY/0rlVsxJ1UPbtb
 m0Zcyz6uP41lVGIm/aQbPEJ90r0Bd7B0C9oNn/rM46Eggq9/542kNwfsjoIf2TFnLWWC83XQq5T
 NJ4BIgZ+GReTfzgEfYMAxBWzgUh/gRctwLyJLskKKYlu9RDtxTeg+AFsCKF7RBQjZjZUZ9CQN3V
 5N6Rtbu9L0ZJyznj/nKC7L3ea7Lz5cGt1poAQizdqjjnr6RLpy84f9HEABltDhGyajA29Rfc7LB
 qDLvPYP1Pzw09SAq6Tojo8lSRKZ9Ih0uu2GX5WCIgWJuKbU9VpLTrxfiMtp+ZGk5IUPPqLNYPI/
 rLh9YpgSvfDEVzFm88IQO8Qlcp+lGBvffNNmXxkA7QGUFTtCaUfmMwN6jJvkMhHLPozI3cNd4wr
 Dhusf85zY3GhUy1oZs1xO6UqTpVrbdyDs0SFQubP7BUkW3ZHWBDOGwqChhok0S2c2TB9iDvjDlO
 ceykVSk8yII11BJhrSCjigJFGejgXJaTddpnyfZiMNuOm6D7GsfxAcx5oDWZzC/QyrZrUXrmkmD
 GnI=
X-Received: by 2002:a17:90b:3b84:b0:3aa:f4af:1e16 with SMTP id
 98e67ed59e1d1-3ab3a4871e5mr6638806a91.7.1791786655244; 
 Sun, 11 Oct 2026 23:30:55 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm14452767a91.16.2026.10.11.23.30.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Oct 2026 23:30:54 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v4 1/2] idpf: don't use the Tx timestamp trackers once
 removal has started
Date: Mon, 12 Oct 2026 14:30:26 +0800
Message-ID: <20261012063027.27750-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012063027.27750-1-luckilystar08@gmail.com>
References: <20261012063027.27750-1-luckilystar08@gmail.com>
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
up until the vports have been torn down, so mbx_task keeps processing
replies while idpf_ptp_release() frees the Tx timestamp trackers. An
async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
vport->tx_tstamp_caps and takes its lock after
idpf_ptp_release_vport_tstamp() may already have freed it.

Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
running a callback before releasing anything, and make the Tx timestamp
callback return when the bit is set. Matched replies to synchronous
transactions are not affected, so the vport teardown still receives
them; mbx_task is requeued straight away for that.

The next patch sets IDPF_REMOVE_IN_PROG on shutdown too, which would
otherwise expose shutdown to the same window.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     | 12 +++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..d0db60647 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3204,8 +3204,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	/* Avoid transaction timeouts when called during reset */
 	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
+	if (!remove_in_prog) {
 		libie_ctlq_xn_shutdown(adapter->xnm);
+	} else {
+		/* The transaction manager stays up for the teardown below, so
+		 * async replies can still arrive. Wait for a mailbox task that
+		 * may be running an async callback; callbacks that run later
+		 * see IDPF_REMOVE_IN_PROG and leave the state released below
+		 * alone.
+		 */
+		cancel_delayed_work_sync(&adapter->mbx_task);
+		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+	}
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 14dba40a9..1422b30d0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -550,7 +550,8 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
 	u16 num_latches;
 	u32 vport_id;
 
-	if (status)
+	/* The Tx timestamp trackers are released on remove and shutdown */
+	if (status || test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
 	recv_tx_tstamp_msg = mem->iov_base;
-- 
2.50.1 (Apple Git-155)

