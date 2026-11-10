Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830F60A261A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=F9HC5VDD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EeIvCcTn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E882B60690;
	Tue, 10 Nov 2026 14:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4fp14d8RKip; Tue, 10 Nov 2026 14:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2601D6083E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794321111;
	b=mS/4fumzXaEuVgI6IqsAmX+2XHXqePdw//jzPccg75aKOZ2qa1Ya9Fu1HrHsSmibVJqt
	 T3ZDRw/uedJOKnkahyFbbLNedmEXrheTj1PcJE2GKcQ6lqVEu8g8T5EYcvXzhhGV2MKly
	 7bV55rY711wuF1oFKbsAAsF0WS9POBZ92wbuOCFdrNuMSwaq7Z/xlSkp2darbYBDTJ3Nd
	 jcvrFGGwBKZVO98qF4AUkKxBb7XEvBSgpVq4m0lDY1M0sVYKyu/1P2w629F81lwAEOiAM
	 5uFI1F6WhvI1qtumigoKM3zef2vrPLr5mb2LTkhx8yO3+mD5r028GVRB88P/8xuoVlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794321111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OlTyX/eRdkd2ub5ISBF1y4LBYRbIgdGhTfqDORaDu3k=;
	b=L67jjwpKwZAxne1g7sVCA0l9F563adF4wZV9+1gbAm6ZKgnnrElvWIPFkoHhe0EGMwEl
	 lLd28O4hLvmIXR+N5A8/jNhX/HM6u6dLkn1jp+0X3+2GZzOwLHkDmpBoAsN4g8aglF0nr
	 AB2cGqJt1GbDAajQi8Zaw3oYwAIcQt9c9vzSsLiRIQSY6NiYBE7Sj6zrZOtbVwlXZ7D1I
	 kbRjckPw53dsE/C558Zv2+Wccs1yTorS+s+Z8sf4K8aGS4CzFICvvL/9CGhB29Xeg8SgN
	 VoemKb1miIFbGA7i22O+ynT0ybC4QNH/pV5tXbGWCnxnXcSmicgVP9wDI0Bke0eNN8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794321111;
	bh=OlTyX/eRdkd2ub5ISBF1y4LBYRbIgdGhTfqDORaDu3k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F9HC5VDDOrk+hzb+id+D1rEXWvrKrJMGsj4oRolgdSI6LSMR29Z5Gm5j0w+N2H259
	 4hYnYCt+q/iWwZFIRRH98XZCgR9zgBsqNf0BqbF6TAcEa5l4Zu0rZkEhU6Gxs899w6
	 JKS59SiOmV7KohizuOWhZC1DBD1uCT9GJ4NdaxtM80JwwuXEdbO/wbJyx3qmoF4B8i
	 aOPI/tcnOuazww2STCYx+flFzoRHbYW+B7Q6R7fXRB5KhfvsEXexthVgckxnZNCji0
	 20oyX7WaeMShPOTXDFp918+eusQmIji+sR8eGH5FpWR24YvfWZTrK/1ZGn+qdGRL+v
	 4XXCGlSChnmHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2601D6083E;
	Tue, 10 Nov 2026 14:31:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D9D11A6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43C2F40822
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aH3ps_5EgqzW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 14:31:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B17CD40812
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EeIvCcTn
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id B17CD40812
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794321105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OlTyX/eRdkd2ub5ISBF1y4LBYRbIgdGhTfqDORaDu3k=;
 b=EeIvCcTnmKo8M8me0+CIroPUXBuGusxgGNVPM64wHesOMHbxuooGQasSoaqVtovRkh6R6t
 tRWb3yJM5o/ZRFnUBD9HJ7x28R96005X7DKieXZlT1LAU+BZG8t5c63vi10XEuJLa3D4Zm
 ovLtSOE9uBznl3oXSm98yj1EIkBIrkA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-a_fOVax3NlS4GWkOWJXNng-1; Tue,
 10 Nov 2026 09:31:42 -0500
X-MC-Unique: a_fOVax3NlS4GWkOWJXNng-1
X-Mimecast-MFC-AGG-ID: a_fOVax3NlS4GWkOWJXNng_1794321100
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CC261956049; Tue, 10 Nov 2026 14:31:39 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 719A4180034C; Tue, 10 Nov 2026 14:31:32 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Milena Olech <milena.olech@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: dpll: refuse pin states that are not valid for
 the pin
Date: Tue, 10 Nov 2026 15:31:19 +0100
Message-ID: <20261110143119.2313907-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 3d4xxy55Ja26iTY47ZOzYMfchiireOHMxcWF4cM-Q9c_1794321100
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DPLL core checks only that a pin may change its state, which states
a pin accepts is left to the driver. The ice callbacks turn the
requested state into an enable flag by comparing it with the one state
that enables the pin, so every other state disables it, including the
one that has no meaning for the pin.

The inputs of the EEC and PPS DPLLs are enabled by selectable, as these
DPLLs select their reference automatically. A request for connected,
which Documentation/driver-api/dpll.rst reserves for manual mode and
for pins with the state-connected-override capability, disables the
input. On an E810:

  # dpll pin set id 1 parent-device 0 state connected
  # dpll pin show id 1
  ... state disconnected on both DPLLs

A recovered clock pin is connected to or disconnected from its parent
pin, and a request for selectable disconnects it:

  # dpll pin set id 2109 parent-pin 2094 state selectable
  # dpll pin show id 2109
  ... state disconnected on parent 2094

Add a helper that translates the state for a pin given the state that
enables it. Disconnected disables the pin and anything else is refused
with -EINVAL and an extack message. Use it for the input and recovered
clock pins, and for the output pins, which already refused selectable
and now tell the user why.

The SMA pins have the same problem. It is left out here, as the rework
of the SMA and U.FL pin control that is queued for net-next refuses the
states these pins cannot serve.

Found with the pin state selftest of the dpllsim series running against
an ice E810.

Fixes: d7999f5ea64bb1 ("ice: implement dpll interface to control cgu")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 61 ++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..b2b515420bc8cd 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -961,6 +961,40 @@ static int ice_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
 	return 0;
 }
 
+/**
+ * ice_dpll_pin_state_to_enable - translate a requested pin state
+ * @state: pin state requested by the user
+ * @on_state: the state that enables the pin
+ * @enable: on success true to enable the pin, false to disable it
+ * @extack: error reporting
+ *
+ * A pin is enabled by exactly one state: selectable for an input of the
+ * EEC and PPS DPLLs, which select their reference automatically, and
+ * connected for an output and for a recovered clock on its parent pin.
+ * Disconnected disables the pin. No other state has a meaning for the
+ * pin, so it is refused rather than taken for one of the two.
+ *
+ * Return:
+ * * 0 - success, @enable is set
+ * * -EINVAL - @state is not valid for the pin
+ */
+static int
+ice_dpll_pin_state_to_enable(enum dpll_pin_state state,
+			     enum dpll_pin_state on_state, bool *enable,
+			     struct netlink_ext_ack *extack)
+{
+	if (state != on_state && state != DPLL_PIN_STATE_DISCONNECTED) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "pin state must be %s or disconnected",
+				   on_state == DPLL_PIN_STATE_SELECTABLE ?
+				   "selectable" : "connected");
+		return -EINVAL;
+	}
+	*enable = state == on_state;
+
+	return 0;
+}
+
 /**
  * ice_dpll_pin_state_set - set pin's state on dpll
  * @pin: pointer to a pin
@@ -1027,12 +1061,15 @@ ice_dpll_output_state_set(const struct dpll_pin *pin, void *pin_priv,
 			  enum dpll_pin_state state,
 			  struct netlink_ext_ack *extack)
 {
-	bool enable = state == DPLL_PIN_STATE_CONNECTED;
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_dpll *d = dpll_priv;
+	bool enable;
+	int ret;
 
-	if (state == DPLL_PIN_STATE_SELECTABLE)
-		return -EINVAL;
+	ret = ice_dpll_pin_state_to_enable(state, DPLL_PIN_STATE_CONNECTED,
+					   &enable, extack);
+	if (ret)
+		return ret;
 	if (!enable && p->state[d->dpll_idx] == DPLL_PIN_STATE_DISCONNECTED)
 		return 0;
 
@@ -1062,7 +1099,13 @@ ice_dpll_input_state_set(const struct dpll_pin *pin, void *pin_priv,
 			 enum dpll_pin_state state,
 			 struct netlink_ext_ack *extack)
 {
-	bool enable = state == DPLL_PIN_STATE_SELECTABLE;
+	bool enable;
+	int ret;
+
+	ret = ice_dpll_pin_state_to_enable(state, DPLL_PIN_STATE_SELECTABLE,
+					   &enable, extack);
+	if (ret)
+		return ret;
 
 	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
@@ -2518,18 +2561,24 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 			       enum dpll_pin_state state,
 			       struct netlink_ext_ack *extack)
 {
-	bool enable = state == DPLL_PIN_STATE_CONNECTED;
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	struct ice_hw *hw;
-	int ret = -EINVAL;
+	bool enable;
 	int hw_idx;
+	int ret;
 
 	hw = &pf->hw;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
 
+	ret = ice_dpll_pin_state_to_enable(state, DPLL_PIN_STATE_CONNECTED,
+					   &enable, extack);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	mutex_lock(&pf->dplls.lock);
 	hw_idx = ice_dpll_pin_get_parent_idx(p, parent_pin);
 	if (hw_idx < 0)
-- 
2.56.0

