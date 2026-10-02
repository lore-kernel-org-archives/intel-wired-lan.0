Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B7CA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AD4B40C03;
	Fri,  2 Oct 2026 13:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_BN5b2Z1S-U; Fri,  2 Oct 2026 13:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B06B40CAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946544;
	b=OgcyJNH3KsUvwcmhTeYgMUMG5bsCTTKonqEY/I3pMJ+LO76JIDrmWGn+rsdVXcjnFO3X
	 S9zKyDVvOC0bAewZWpAxuNZ7rhx9yrzxZiqXzK3V6ZEeTRF5f8BYkqQ9kB3VaOW0OEJT0
	 PiGm7wh0fCKRT4MEGK9O3RjiaeTC+2hIW3XGCL0Y27rqJ7IQvUZyUGsO63QxvdDHCLQiI
	 KfDoAfhFk6hesZ1guRwhvqQGZ6VGAM6abOJvNsJh6l1LI9mmP/itkIcFj/jeF+sxEALkW
	 MP3bpPri9OsBDJuzsWja61so1E/WNsa6106fejaR3OVKTWKGBXv3dK2hmtpb4mgzSxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RM9N9byrk/K2mhYiTQy1Gjh5yftd80iFuZlc/Uf09mM=;
	b=NlBOW0PXwKvsT9Jy9ELljIY+tUL6eJ1+wbPapMexJHaV9DlrRjguUu3KxQvbGGajv4kT
	 1s9/aMvgNt1CDvFCjkozMUEMTD3Rc3UOeB5C+ZAw5K11+w4ym9bDzOR7AWYjBtWHQIIj3
	 Qk65qo3sIsJRSE339AX+HpGgop16Hlcs9FYt9FeB03Xoi4i1Mg4WmMWhUybezTWB2Oo0/
	 ZCUkgJVxjYmUOl8UrV6z/5yIXrSTAmseGqtyzB5cbuHIR4cULTfrontfqCW7j41Byv6cG
	 CdNr7jYYpXbwpS/IaL1oYwpUbPWKtOP05EvkhSaTMsQKMZHjgaOF1/0cMKZiDbrWjzg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f54YH619;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946544;
	bh=RM9N9byrk/K2mhYiTQy1Gjh5yftd80iFuZlc/Uf09mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6xL1PxZC9mYDQfk9LlIm2UYsc2mKyOBbxuEYqBm9PRYQ2mc0BEn8CMloYg/ONLSak
	 yAysU8ILZyuTv4PjjmMqamWr3MQ611HOLlcEsNMlK6AQPiE+3DUSeLc5kbG5FJdSo7
	 cZGJJtWlS0piF/68BS4yinyYjayBqnNvUV4q279DpEJw9Aw6Al6rDsymluVFDvn7iW
	 uNwe1W25yCvXLtklWrQJjLTy40BYnNLrXvRrtx8FFK79EMC1FLjzBOv97e5WDbhiyu
	 fFvhYNwZatnNDPUCos73yNqgLnUbK7tp1xG+KLBe20zhZRhz4PVsCihb19dF7uVEm2
	 QTGXc4aIIDnjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B06B40CAC;
	Fri,  2 Oct 2026 13:09:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BBF5534D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADE3E40CAC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EhYZCLB1rUvB for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:09:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D9FE040C03
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946543;
 b=WuRK9+TzatvavWqk5t87jxiFUuWnTWAB9n6URUHQttXI/DuSvZ43m5fUXrjMpta28xr9
 E/0dFJE/+XropOh7y9n5G9aMyxrFCCGKdH8YwLSELRdiL1c290mTyRXZhegfbD/bn1r3w
 edB1ePzFQbsqm8Z6sTPhiyzS66VFgUIqCHBGurZIy1qCC5yAFyOwavw4xSZf7u+odRpoX
 c+cr46WcWkALdKwo/oV8qkw5CTAL10lju0UhrLApvwaa5agzJAtoUimrB+5yYQRSte+rm
 wKRXrM3unFQMzHZ2kIvyybZq16ecsAk7YVV0y97064qhvs1w2e+j6YCLHLLQ7/yhSSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946543;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=RM9N9byrk/K2mhYiTQy1Gjh5yftd80iFuZlc/Uf09mM=;
 b=eewHEdSNqaG/BEMSO0YPYanqwEGoqNnd5ubf9ZFgBW5WBbtEXOyjU0Aq5JLM8EBUlcyF
 lWTYkG2OSLRaZdm/9BDCJo7RyGf8lERn6h2coXJMpH7sAhu0exKaorhKFcddrCnNma0VB
 0yG1JbPLrw2yewp0j3ePXsT8YMCMF0W+0s1KKWfhrrVBkHzOxLI7RN2R7qbdxDfdYf0Pa
 YdqRiPUAIILXMGvURiZjr6ZgxV3WinV4gPtraFBjqJAs4ShRadpDln6whmqHgM5ULLR1/
 QPGoevzAjaIGQoYVXu5e1sh9F7wLAc7kbEvIv6wtdgOD/v9122n5As9cDizTlYkBFxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=f54YH619; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f54YH619
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9FE040C03
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RM9N9byrk/K2mhYiTQy1Gjh5yftd80iFuZlc/Uf09mM=;
 b=f54YH619Zwwk0Eq6yHvO2fDapHU4AqG+rNQMmrH6MlwHjWf0wyVNNOB7av0zf5QvnxVetE
 AGzf1JqLxHSQUglQZQ6r1gNxJZUpuV0IMkzXTrjq/eMHnSRngu87TnLFbTiPVdP1DxC2wg
 vGE89p/7EmoCQB/qorAc557Woj7kLEM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-QYC0D381NGqY5jFs4IjyXQ-1; Fri,
 02 Oct 2026 09:08:55 -0400
X-MC-Unique: QYC0D381NGqY5jFs4IjyXQ-1
X-Mimecast-MFC-AGG-ID: QYC0D381NGqY5jFs4IjyXQ_1790946531
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 331AD19560B9; Fri,  2 Oct 2026 13:08:51 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 105C7214; Fri,  2 Oct 2026 13:08:44 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the
 response descriptor
Date: Fri,  2 Oct 2026 15:07:49 +0200
Message-ID: <20261002130752.2597259-8-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 8bipLT4ButMuKO9m7Dei7RUSFTzc7D_YBAzihnSVeNo_1790946531
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by
reading hw->adminq.sq_last_status after ice_aq_send_cmd() returned. That
field is shared by every admin queue user and is only stable while the
send queue lock is held. Another AQ command completing in between can
overwrite it, so a failed removal is reported as a generic error, and a
successful one can even be turned into -ENOENT, because the check is
not limited to the failure case. A caller that sees -ENOENT keeps its
rule bookkeeping while the rule is gone from the hardware.

ice_vsi_sync_fltr() has the same problem with ENOSPC. It checks
sq_last_status only after it has freed the list of filters it tried to
add. Every entry is a separate devres allocation, so freeing a list of
thousands of entries takes seconds, and by then the value usually
belongs to a different command, so the MAC filter overflow handling is
never entered. With debug prints of the error and sq_last_status added
to both places:

  ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
  ice 0000:04:00.0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0

Use the retval of the descriptor that ice_aq_send_cmd() copies back,
only when the command failed, translate ENOSPC on add to -ENOSPC and
let ice_vsi_sync_fltr() check the return code instead of
sq_last_status.

i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race
condition while adding/deleting MAC/VLAN filters").

Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
 drivers/net/ethernet/intel/ice/ice_switch.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8a21f87eb6ca21..ceb9fec2af21e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -396,8 +396,6 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct net_device *netdev = vsi->netdev;
 	bool promisc_forced_on = false;
-	struct ice_pf *pf = vsi->back;
-	struct ice_hw *hw = &pf->hw;
 	u32 changed_flags = 0;
 	int err;
 
@@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 		 * should go into promiscuous mode. There should be some
 		 * space reserved for promiscuous filters.
 		 */
-		if (hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOSPC &&
+		if (err == -ENOSPC &&
 		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
 				      vsi->state)) {
 			promisc_forced_on = true;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 239d4d9633baa6..ae96a2003d5c5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1959,9 +1959,16 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16 rule_list_sz,
 	desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
 	cmd->num_rules_fltr_entry_index = cpu_to_le16(num_rules);
 	status = ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
-	if (opc != ice_aqc_opc_add_sw_rules &&
-	    hw->adminq.sq_last_status == LIBIE_AQ_RC_ENOENT)
-		status = -ENOENT;
+	if (status) {
+		enum libie_aq_err aq_err = le16_to_cpu(desc.retval) & 0xff;
+
+		if (opc != ice_aqc_opc_add_sw_rules &&
+		    aq_err == LIBIE_AQ_RC_ENOENT)
+			status = -ENOENT;
+		else if (opc == ice_aqc_opc_add_sw_rules &&
+			 aq_err == LIBIE_AQ_RC_ENOSPC)
+			status = -ENOSPC;
+	}
 
 	if (!status) {
 		if (opc == ice_aqc_opc_add_sw_rules)
-- 
2.55.0

