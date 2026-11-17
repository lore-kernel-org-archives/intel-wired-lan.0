Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDF606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bYZU9ylq;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QxKIUdvB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7C344094C;
	Tue, 17 Nov 2026 16:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5FKI5fIYqKI; Tue, 17 Nov 2026 16:29:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB9B54093B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932950;
	b=aV+E41ZakYB/rnqQNN+GE6eXkTpPQf9PgprIgGX6EA2DEcmLQM81mtYAClmn52JSUX9N
	 LH7+gSS1ZXGuAsflMrYy3VJff6tPSGCuxXCGYIn5OBq5OXTqAtBrxCfN/a1oSnW3laAXr
	 oY4V+8qzR7WhsavFQMBasQOzat9K4w3bkcXuW7wwJmrxnP5GxmChCWrwupL7ZEt9Mkwq0
	 /KmBN1n1nZTpjDOTekiXXKHhOIL9ngn9Kriur0w3tNj1BwSs1WccQ2c6EW3LSADpgP5+L
	 NO7ZRdC9YWihtX3vIxflRFmWhwdfZo227LMiS2Y24UiQJu52hNhEXG9fzy12pV3wOAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HotKHfm/wwBRMcvK7oxXp3xcdvVbDhxmIMVIjCZywAA=;
	b=FUwSxNM/UA4LOKkJhP6yVK2r3vi2Bju+ivrpCVu6KfBeOwHn4hogjR1FcsbnZVHqScEU
	 ZJuIf9FeYU2i7VOfAHLKcGj6nlVyyIf7jRDM4CuyuDxr38snLF6jjnBKKw6vYhysscv1d
	 tQc/BK7Cw9gxzZSogtNwb48aznHgfIcxfYcl+UJiUpwDSjw2KovOJcHAzidB0recpMu4a
	 FUjPCX4s4tTNNVV/wsEeNoif+t6az/CFlP422YMJ095t89RxHx43N1C9fkhdvXebMbvkp
	 Y6bJk0yM4sKpqWwvqFtZ6cn7C58ex8VzcGUVVgOV5TQxvxralIvhFhCETifBFWMJImA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QxKIUdvB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932950;
	bh=HotKHfm/wwBRMcvK7oxXp3xcdvVbDhxmIMVIjCZywAA=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bYZU9ylqH3J9XWCNI/uthC7Xx0ocWuENEtXs67RD9yb2I4PBPS9dHP510M03ZfNNg
	 CGR1PJCmw3zVxgRwrLqcJncObZv9xc3dtvlPCfBdsG1sjrRoVLxP+bWnmJphYpNHOi
	 rY3iqhJ3uloMZ3BPfaSR8/W5nsExJThnIZvnSYOV3zz8We4lvBh0e3pTOGDaot8yu1
	 R3970uCeLmSTw4HqKRa+aK3GcX6zRMzXohExe4QwyKSog4D7eaDmbck7nw6hn0Xhlt
	 oOxCgOpSMRyqQTajhYtJkBCbpIHoNEwhX+QKiZ2nQvvY4mcJXHnFTRBUaJWueywe1K
	 9tRm7ZR0Z7kyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB9B54093B;
	Tue, 17 Nov 2026 16:29:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64F5849B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 566B240897
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AexzNu5f9oPd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD016408BE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::846"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::846; helo=mail-qt1-x846.google.com;
 envelope-from=39mr8agukdx0lm3gb9hh9e7.5hfbgm7e-pbk76-e3geblml.hlnhle.hk9@flex--stani.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=QxKIUdvB
Received: from mail-qt1-x846.google.com (mail-qt1-x846.google.com
 [IPv6:2607:f8b0:4864:20::846])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD016408BE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:55:52 +0000 (UTC)
Received: by mail-qt1-x846.google.com with SMTP id
 d75a77b69052e-5363fa3d3e4so91025281cf.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 06:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794927351; x=1795532151; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HotKHfm/wwBRMcvK7oxXp3xcdvVbDhxmIMVIjCZywAA=;
 b=QxKIUdvBSkQUgk+uj7j3pdMRBEct+gCIZUAKPAqHgtJ6tvS/NSde8GgoEaLSeGt8v+
 7UHdPg1jTmTuWuGn7DADXb0n4fbjLl7VHaFLd0FY3lae2ctDorrbhKEOykK+0je825Ty
 sN80+mW9J3RS8oD072Xe/KYyUDxsptZHLlMak+wxQH9ojueEBSbqOXSw9wmYR+TCGkMV
 P81jqMAb69scWLBZLAyX0FgmnE7uqjs9x+yP1vlbiFD05JSJX/VS4C0OTu9ozBYJVt2c
 Y6LYxorneVzT2a528eNUlV8/t+D+PbPEdWrNmoKvylVr5SLFb6ffM+P4yoZLR/JqNrMH
 72XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927351; x=1795532151;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HotKHfm/wwBRMcvK7oxXp3xcdvVbDhxmIMVIjCZywAA=;
 b=NwsCSGhGne/XKV8bZIEd/QQsQFW/kLTm5kEagrDcq6bfpgjzqPtVzWY4k/EdnTZHZn
 xYTriZJAnE2mMHbFGxB5oP3LDem4Q8zsZtkWibZVF0AQLihXHF/vsHBOxIZLuriu3ubI
 MLEVK5cQRVN65hME/fWZTMzuVtkvbyaRjZWyw2lKgjh2R5qhe91X5l32hUfPaKY0UkjP
 MGG3kMa1xKGO6vtmpYkG6OGnqWYU3bzzdZ0CkHh4fUmH/GRiJgp2HorwKvDPRrSdVzlN
 hYlydnOxq+LulHsEpVVWUE9i41Yuz/Bo6ZNPfYE5d23UZi+JtRxG3hee/tmloD1h+uUR
 QDtA==
X-Forwarded-Encrypted: i=1;
 AL+hErHrBJgDrAg6dEYWtwWIkeqYrwj1ATSVE/VEBNcOdzE85Ojim9jYsaONpulHA9yGC63nDu+TopVLkql7jg4BP6Y=@lists.osuosl.org
X-Gm-Message-State: APuU4Z955TucUIfso0g6U0V9Dvosq9qa5RGfGCHNhwsT3JZh+SNVde8I
 c9EosLP+z5RF8IZRHNpv+U+9RKSuAJz9AaUat+AQViGXzDNl3mquSJenWCqNYEEY2ggIQXtW3KW
 MmQ==
X-Received: from qtrr4-n1.prod.google.com
 ([2002:a05:622a:a984:10b0:55d:38be:35af])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5b93:b0:536:8f5a:628
 with SMTP id d75a77b69052e-55ac908688bmr214064961cf.52.1794927350524; Tue, 17
 Nov 2026 06:55:50 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:19 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-14-stani@google.com>
Subject: [PATCH iwl-next 13/15] idpf: psp: add psp work and tx key insertion
 completion
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:29:00 +0000
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the PSP work and the completion of the asynchronous TX key
insertion requests:
- Add the PSP work on the PSP workqueue, allocated the first time PSP
  is negotiated, which sends the queued deletion requests. A request
  that couldn't be sent, e.g. because no mailbox transaction was free,
  is sent again after IDPF_PSP_RETRY_MSEC: the PSP work is a delayed
  work. It is cancelled during a reset and while a soft reset
  reallocates the queues, and queued again afterwards.
- Introduce VIRTCHNL2_OP_PSP_INSERT_KEYS (561) and
  struct virtchnl2_psp_insert_keys_response.
- Add struct idpf_psp_insert_req, the context of an insertion request,
  which holds a reference on its keys: it binds the response callback
  to the keys the request was sent for. At most one request is in
  flight.
- Implement idpf_psp_tx_key_inserted(), which publishes the SA index
  of an inserted key, and idpf_psp_tx_key_failed(). A key deleted
  while its insertion was pending gets its SA index deleted.
- libie calls the response callback of a request once, after the
  reply or the timeout, except on shutdown: idpf_psp_quiesce(), called
  after libie_ctlq_xn_shutdown() in idpf_vc_core_deinit(), fails the
  request in flight and drops the delete queue. libie only checks the
  timeouts in the mailbox task: a timer runs it once the request timed
  out, so that a lost reply in mailbox interrupt mode doesn't block the
  insertions.
- The SA indexes of late replies, passed by libie to
  idpf_recv_event_msg(), are queued for deletion.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  12 +
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 213 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  14 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    |  34 +++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   |  50 +++-
 .../intel/idpf/idpf_psp_virtchnl_def.h        |   3 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   3 +
 include/linux/net/intel/virtchnl2.h           |  16 ++
 8 files changed, 344 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 062753a62f59..18d484c1a2ca 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1458,6 +1458,9 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_up_complete(vport);
 
+	/* Send the PSP requests queued while the vport was down */
+	idpf_queue_psp_work(adapter);
+
 	if (rtnl)
 		rtnl_unlock();
 
@@ -1755,6 +1758,9 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 
 	dev_info(dev, "Device HW Reset initiated\n");
 
+	/* Stop sending PSP requests */
+	idpf_cancel_psp_work(adapter);
+
 	/* Prepare for reset */
 	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
 		reg_ops->trigger_reset(adapter, IDPF_HR_DRV_LOAD);
@@ -1882,6 +1888,11 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (!new_vport)
 		return -ENOMEM;
 
+	/* No PSP packet is sent while the queues are reallocated, the PSP
+	 * work is queued again below
+	 */
+	idpf_cancel_psp_work(adapter);
+
 	/* This purposely avoids copying the end of the struct because it
 	 * contains wait_queues and mutexes and other stuff we don't want to
 	 * mess with. Nothing below should use those variables from new_vport
@@ -1970,6 +1981,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 
 free_vport:
 	kfree(new_vport);
+	idpf_queue_psp_work(adapter);
 
 	if (reset_cause == IDPF_SR_MTU_CHANGE)
 		idpf_idc_vdev_mtu_event(vport->vdev_info,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index d2a0ba79c7ab..373edbef9a7e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -5,6 +5,101 @@
 #include "idpf_psp.h"
 #include "idpf_psp_virtchnl.h"
 
+/* Delay of the insert request timer after the request timeout */
+#define IDPF_PSP_INSERT_TIMER_SLACK_MSEC	1000
+
+/* Delay before the PSP work sends again a request that couldn't be sent */
+#define IDPF_PSP_RETRY_MSEC		100
+
+/**
+ * idpf_queue_psp_work - Queue the PSP work
+ * @adapter: private data struct
+ */
+void idpf_queue_psp_work(struct idpf_adapter *adapter)
+{
+	if (adapter->psp.wq)
+		mod_delayed_work(adapter->psp.wq, &adapter->psp.work, 0);
+}
+
+/**
+ * idpf_retry_psp_work - Queue the PSP work after a request couldn't be sent
+ * @adapter: private data struct
+ *
+ * The request is sent again after IDPF_PSP_RETRY_MSEC, unless the PSP work is
+ * queued earlier.
+ */
+void idpf_retry_psp_work(struct idpf_adapter *adapter)
+{
+	if (adapter->psp.wq)
+		queue_delayed_work(adapter->psp.wq, &adapter->psp.work,
+				   msecs_to_jiffies(IDPF_PSP_RETRY_MSEC));
+}
+
+/**
+ * idpf_cancel_psp_work - Cancel the PSP work and wait for it to finish
+ * @adapter: private data struct
+ */
+void idpf_cancel_psp_work(struct idpf_adapter *adapter)
+{
+	if (adapter->psp.wq)
+		cancel_delayed_work_sync(&adapter->psp.work);
+}
+
+/**
+ * idpf_psp_work - Send the PSP key insertion and deletion requests
+ * @work: work of struct idpf_adapter_psp
+ *
+ * Send
+ * at most one request of each kind. The work is queued again when there is
+ * more to do, or after a delay when a request couldn't be sent.
+ */
+static void idpf_psp_work(struct work_struct *work)
+{
+	struct idpf_adapter *adapter = container_of(to_delayed_work(work),
+						    struct idpf_adapter,
+						    psp.work);
+
+	/* The mailbox is initialized again on reset, and released on remove
+	 * and shutdown, see idpf_psp_quiesce()
+	 */
+	if (idpf_is_reset_in_prog(adapter) ||
+	    test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return;
+
+	if (idpf_send_delete_psp_keys(adapter))
+		idpf_queue_psp_work(adapter);
+}
+
+/**
+ * idpf_psp_insert_timeout - Insert request timer
+ * @t: insert_timer of struct idpf_adapter_psp
+ *
+ * libie times out asynchronous requests in the mailbox task, which only runs
+ * when the CP sends a message in mailbox interrupt mode. Run it once the insert
+ * request in flight timed out, so that a lost reply doesn't block the key
+ * insertions.
+ */
+static void idpf_psp_insert_timeout(struct timer_list *t)
+{
+	struct idpf_adapter_psp *psp = timer_container_of(psp, t, insert_timer);
+	struct idpf_adapter *adapter = container_of(psp, struct idpf_adapter,
+						    psp);
+
+	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+}
+
+/**
+ * idpf_psp_insert_timer_arm - Start the insert request timer
+ * @adapter: private data struct
+ * @timeout_ms: timeout of the insert request
+ */
+void idpf_psp_insert_timer_arm(struct idpf_adapter *adapter, u32 timeout_ms)
+{
+	mod_timer(&adapter->psp.insert_timer,
+		  jiffies + msecs_to_jiffies(timeout_ms +
+					     IDPF_PSP_INSERT_TIMER_SLACK_MSEC));
+}
+
 /**
  * idpf_psp_negotiate_caps - Negotiate the crypto and PSP capabilities
  * @adapter: private data struct
@@ -110,9 +205,23 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 	if (!psp->initialized) {
 		spin_lock_init(&psp->del_lock);
 		INIT_LIST_HEAD(&psp->del_list);
+		INIT_DELAYED_WORK(&psp->work, idpf_psp_work);
+		spin_lock_init(&psp->insert_lock);
+		timer_setup(&psp->insert_timer, idpf_psp_insert_timeout, 0);
 		psp->initialized = true;
 	}
 
+	if (!psp->wq) {
+		psp->wq = alloc_workqueue("%s-%s-psp",
+					  WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS,
+					  0, dev_driver_string(dev),
+					  dev_name(dev));
+		if (!psp->wq) {
+			dev_warn(dev, "PSP disabled, failed to allocate the workqueue\n");
+			return;
+		}
+	}
+
 	/* The master keys are tracked again for the new PSP device */
 	psp->generation = 0;
 	psp->rx_gen[0].gen = IDPF_PSP_GEN_UNKNOWN;
@@ -123,10 +232,60 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 	atomic_set(&psp->keys_removed, 0);
 	atomic_set(&psp->keys_lost, 0);
 	atomic_set(&psp->del_retries, 0);
+	atomic_set(&psp->keys_inserted, 0);
+	atomic_set(&psp->insert_errors, 0);
+	atomic_set(&psp->insert_late, 0);
 
 	WRITE_ONCE(psp->enabled, true);
 }
 
+/**
+ * idpf_psp_quiesce - Stop the PSP work and drop the pending requests
+ * @adapter: private data struct
+ *
+ * Called after libie_ctlq_xn_shutdown(), which discards the asynchronous
+ * transactions without calling their response callback: the keys of the
+ * insert request in flight are failed here. The SA indexes queued for deletion
+ * are dropped, as the SADB is flushed by the reset or remove that follows, see
+ * idpf_psp_queue_delete().
+ */
+void idpf_psp_quiesce(struct idpf_adapter *adapter)
+{
+	struct idpf_adapter_psp *psp = &adapter->psp;
+	struct idpf_psp_insert_req *req;
+	struct idpf_psp_tx_key *key, *tmp;
+	LIST_HEAD(keys);
+	u32 i;
+
+	if (!psp->wq)
+		return;
+
+	cancel_delayed_work_sync(&psp->work);
+	timer_delete_sync(&psp->insert_timer);
+
+	spin_lock_bh(&psp->insert_lock);
+	req = psp->insert_req;
+	psp->insert_req = NULL;
+	spin_unlock_bh(&psp->insert_lock);
+
+	if (req) {
+		for (i = 0; i < req->num_keys; i++) {
+			idpf_psp_tx_key_failed(adapter, req->keys[i]);
+			idpf_psp_tx_key_put(req->keys[i]);
+		}
+		kfree(req);
+	}
+
+	spin_lock_bh(&psp->del_lock);
+	list_splice_init(&psp->del_list, &keys);
+	spin_unlock_bh(&psp->del_lock);
+
+	list_for_each_entry_safe(key, tmp, &keys, del_node) {
+		list_del_init(&key->del_node);
+		idpf_psp_tx_key_put(key);
+	}
+}
+
 /**
  * idpf_psp_free - Release the PSP offload resources
  * @adapter: private data struct
@@ -136,6 +295,13 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 void idpf_psp_free(struct idpf_adapter *adapter)
 {
 	idpf_psp_unregister(adapter);
+
+	if (!adapter->psp.wq)
+		return;
+
+	idpf_psp_quiesce(adapter);
+	destroy_workqueue(adapter->psp.wq);
+	adapter->psp.wq = NULL;
 }
 
 /**
@@ -215,6 +381,53 @@ void idpf_psp_queue_delete(struct idpf_adapter *adapter,
 	spin_lock_bh(&psp->del_lock);
 	list_add_tail(&key->del_node, &psp->del_list);
 	spin_unlock_bh(&psp->del_lock);
+
+	idpf_queue_psp_work(adapter);
+}
+
+/**
+ * idpf_psp_tx_key_inserted - Complete the insertion of a TX key
+ * @adapter: private data struct
+ * @key: TX key of an insert request
+ * @saidx: SA index the key was inserted at, see idpf_psp_saidx_ok()
+ *
+ * Called from the insert response callback, must not sleep.
+ */
+void idpf_psp_tx_key_inserted(struct idpf_adapter *adapter,
+			      struct idpf_psp_tx_key *key, u32 saidx)
+{
+	bool deleted;
+
+	atomic_inc(&adapter->psp.keys_inserted);
+
+	spin_lock_bh(&key->lock);
+	key->hw_idx = saidx;
+	deleted = key->idx == IDPF_PSP_IDX_DELETED;
+	if (!deleted)
+		WRITE_ONCE(key->idx, saidx);
+	spin_unlock_bh(&key->lock);
+
+	/* The key was deleted while its insertion was pending */
+	if (deleted)
+		idpf_psp_queue_delete(adapter, key);
+}
+
+/**
+ * idpf_psp_tx_key_failed - Fail the insertion of a TX key
+ * @adapter: private data struct
+ * @key: TX key of an insert request
+ *
+ * Called from the insert response callback, must not sleep.
+ */
+void idpf_psp_tx_key_failed(struct idpf_adapter *adapter,
+			    struct idpf_psp_tx_key *key)
+{
+	atomic_inc(&adapter->psp.insert_errors);
+
+	spin_lock_bh(&key->lock);
+	if (key->idx == IDPF_PSP_IDX_IN_PROG)
+		WRITE_ONCE(key->idx, IDPF_PSP_IDX_ERROR);
+	spin_unlock_bh(&key->lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index b4f46e43cd83..0b2ae019b4a0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -50,6 +50,16 @@ static inline bool idpf_psp_idx_valid(u32 idx)
 void idpf_psp_queue_delete(struct idpf_adapter *adapter,
 			   struct idpf_psp_tx_key *key);
 
+void idpf_queue_psp_work(struct idpf_adapter *adapter);
+void idpf_retry_psp_work(struct idpf_adapter *adapter);
+void idpf_cancel_psp_work(struct idpf_adapter *adapter);
+void idpf_psp_quiesce(struct idpf_adapter *adapter);
+void idpf_psp_insert_timer_arm(struct idpf_adapter *adapter, u32 timeout_ms);
+void idpf_psp_tx_key_inserted(struct idpf_adapter *adapter,
+			      struct idpf_psp_tx_key *key, u32 saidx);
+void idpf_psp_tx_key_failed(struct idpf_adapter *adapter,
+			    struct idpf_psp_tx_key *key);
+
 #else /* !CONFIG_INET_PSP */
 
 static inline void idpf_psp_init(struct idpf_adapter *adapter) { }
@@ -65,6 +75,10 @@ static inline void
 idpf_psp_rotation_event(struct idpf_adapter *adapter,
 			const struct libie_ctlq_msg *ctlq_msg) { }
 
+static inline void idpf_queue_psp_work(struct idpf_adapter *adapter) { }
+static inline void idpf_cancel_psp_work(struct idpf_adapter *adapter) { }
+static inline void idpf_psp_quiesce(struct idpf_adapter *adapter) { }
+
 #endif /* CONFIG_INET_PSP */
 
 #endif /* !_IDPF_PSP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 3157b40006c1..4c42755615cb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -6,6 +6,8 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/net/intel/virtchnl2.h>
 #include <net/psp.h>
 
@@ -52,6 +54,21 @@ struct idpf_psp_tx_key {
 	struct rcu_head rcu;
 };
 
+/**
+ * struct idpf_psp_insert_req - VIRTCHNL2_OP_PSP_INSERT_KEYS request
+ * @adapter: adapter the request was sent for
+ * @num_keys: number of keys in the request
+ * @keys: keys of the request in request order, with a reference each
+ *
+ * The request is the context of the response callback: it binds the response
+ * to the keys it was sent for, see idpf_psp_insert_keys_cb().
+ */
+struct idpf_psp_insert_req {
+	struct idpf_adapter *adapter;
+	u32 num_keys;
+	struct idpf_psp_tx_key *keys[] __counted_by(num_keys);
+};
+
 /**
  * struct idpf_psp_rx_key - PSP RX key allocated by the CP
  * @spi: SPI of the key
@@ -103,7 +120,16 @@ struct idpf_psp_rx_gen {
  *		 PSP was negotiated
  * @del_lock: protects @del_list
  * @del_list: TX keys whose SA index is queued for deletion
+ * @wq: workqueue of @work
+ * @work: sends the insertion and deletion requests
+ * @insert_lock: protects @insert_req
+ * @insert_req: the VIRTCHNL2_OP_PSP_INSERT_KEYS request in flight, if any
+ * @insert_timer: makes the mailbox task time out a lost insert request,
+ *		  see idpf_psp_insert_timeout()
  * @keys_allocated: RX keys allocated
+ * @keys_inserted: TX keys inserted into the SADB
+ * @insert_errors: TX keys whose insertion failed
+ * @insert_late: SA indexes of late insertion replies, queued for deletion
  * @keys_removed: SA indexes deleted
  * @keys_lost: SA indexes that couldn't be deleted
  * @del_retries: SA indexes retried after a failed deletion request
@@ -131,7 +157,15 @@ struct idpf_adapter_psp {
 	bool initialized;
 	spinlock_t del_lock;		/* protects del_list */
 	struct list_head del_list;
+	struct workqueue_struct *wq;
+	struct delayed_work work;
+	spinlock_t insert_lock;		/* protects the insertions */
+	struct idpf_psp_insert_req *insert_req;
+	struct timer_list insert_timer;
 	atomic_t keys_allocated;
+	atomic_t keys_inserted;
+	atomic_t insert_errors;
+	atomic_t insert_late;
 	atomic_t keys_removed;
 	atomic_t keys_lost;
 	atomic_t del_retries;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index 42a7d74db232..e813dca8961d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -442,7 +442,8 @@ static void idpf_psp_delete_done(struct idpf_adapter *adapter,
  *   it and its SA indexes may be in use by new keys: they are counted as lost,
  *   a late reply moves the deleted ones to removed, see
  *   idpf_psp_recv_late_reply();
- * - a request that couldn't be sent is retried the next time the PSP work runs.
+ * - a request that couldn't be sent is sent again after a delay, see
+ *   idpf_retry_psp_work().
  *
  * Return: true if SA indexes are still queued for deletion, false otherwise.
  */
@@ -553,10 +554,52 @@ bool idpf_send_delete_psp_keys(struct idpf_adapter *adapter)
 	list_splice(&batch, &psp->del_list);
 	spin_unlock_bh(&psp->del_lock);
 	net_warn_ratelimited("%s: request not sent: %d\n", __func__, err);
+	idpf_retry_psp_work(adapter);
 
 	return false;
 }
 
+/**
+ * idpf_psp_insert_late - Delete the SA indexes of a late insertion reply
+ * @adapter: Driver specific private structure
+ * @buff: VIRTCHNL2_OP_PSP_INSERT_KEYS reply
+ *
+ * The keys of the request were failed when it timed out: delete the SA indexes
+ * they were inserted at.
+ */
+static void idpf_psp_insert_late(struct idpf_adapter *adapter,
+				 const struct kvec *buff)
+{
+	const struct virtchnl2_psp_insert_keys_response *resp = buff->iov_base;
+	struct idpf_psp_tx_key *key;
+	u32 i, num_sa_indexes;
+
+	if (!resp || buff->iov_len < sizeof(*resp))
+		return;
+
+	num_sa_indexes = min_t(size_t, le32_to_cpu(resp->num_sa_indexes),
+			       (buff->iov_len - sizeof(*resp)) /
+			       sizeof(resp->sa_indexes[0]));
+
+	for (i = 0; i < num_sa_indexes; i++) {
+		u32 saidx = le32_to_cpu(resp->sa_indexes[i]);
+
+		if (!idpf_psp_saidx_ok(adapter, saidx))
+			continue;
+
+		atomic_inc(&adapter->psp.insert_late);
+		key = idpf_psp_tx_key_alloc();
+		if (!key) {
+			atomic_inc(&adapter->psp.keys_lost);
+			continue;
+		}
+
+		key->hw_idx = saidx;
+		idpf_psp_queue_delete(adapter, key);
+		idpf_psp_tx_key_put(key);
+	}
+}
+
 /**
  * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
  * @adapter: Driver specific private structure
@@ -566,6 +609,7 @@ bool idpf_send_delete_psp_keys(struct idpf_adapter *adapter)
  * The RX key of an allocation reply is wiped. The SA indexes deleted by a
  * deletion reply were counted as lost, see idpf_send_delete_psp_keys(): they
  * are counted as removed.
+ * The SA indexes of an insertion reply are deleted, see idpf_psp_insert_late().
  */
 void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 			      const struct libie_ctlq_msg *ctlq_msg)
@@ -593,6 +637,10 @@ void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 		atomic_sub(deleted, &adapter->psp.keys_lost);
 		atomic_add(deleted, &adapter->psp.keys_removed);
 		break;
+	case VIRTCHNL2_OP_PSP_INSERT_KEYS:
+		if (idpf_is_psp_ena(adapter) && !ctlq_msg->chnl_retval)
+			idpf_psp_insert_late(adapter, buff);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h
index c2be65e541be..69a61fa421e0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl_def.h
@@ -6,6 +6,9 @@
 #include <linux/net/intel/libie/controlq.h>
 #include <linux/net/intel/virtchnl2.h>
 
+/* Timeout of the asynchronous VIRTCHNL2_OP_PSP_INSERT_KEYS requests */
+#define IDPF_VC_XN_PSP_RESPONSE_TIMEOUT_MSEC	(60 * 1000)
+
 /* PSP key insertion and deletion requests must fit in one mailbox buffer,
  * which limits the number of TX keys and SA indexes per request.
  */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 90fe5212095d..bff3b0f46113 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3281,6 +3281,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (remove_in_prog)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 
+	/* The mailbox transactions were shut down in both cases */
+	idpf_psp_quiesce(adapter);
+
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
 
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 903159235832..b8940e33fd04 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -86,6 +86,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
 	/* Crypto/PSP opcodes */
 	VIRTCHNL2_OP_PSP_ALLOCATE_KEYS			= 560,
+	VIRTCHNL2_OP_PSP_INSERT_KEYS			= 561,
 	VIRTCHNL2_OP_PSP_DELETE_KEYS			= 562,
 	VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST		= 563,
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
@@ -1991,6 +1992,21 @@ struct virtchnl2_psp_allocate_keys_response {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_allocate_keys_response);
 
+/**
+ * struct virtchnl2_psp_insert_keys_response - Insert PSP TX keys response
+ * @vport_id: Virtual port ID
+ * @num_sa_indexes: Number of allocated SA indexes, at most the number of keys
+ *		    requested. On partial success the insertion stops at the
+ *		    first failure.
+ * @sa_indexes: Flexible array of allocated SA indexes
+ */
+struct virtchnl2_psp_insert_keys_response {
+	__le32 vport_id;
+	__le32 num_sa_indexes;
+	__le32 sa_indexes[] __counted_by_le(num_sa_indexes);
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_psp_insert_keys_response);
+
 /**
  * struct virtchnl2_psp_delete_keys_request - Delete PSP TX keys request
  * @vport_id: Virtual port ID
-- 
2.56.0.679.gc527c65306-goog

