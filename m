Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0631EC982DE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 10:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A246E6070D;
	Mon, 21 Sep 2026 10:00:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPOkCxQxDAPC; Mon, 21 Sep 2026 10:00:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F38BB606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789984830;
	b=thJ71bbSqqZcDnG545tRuJ6fGwXKbAMAkCdypSbCuPA8M9Hhuy87xjLBuDlU8k6IQSGR
	 kmTL8dt41PK5u1zQsBZLusLZRICgMXS3ggyoF3bzilGK5qGGfGDaxPoUuO4eQ/yua/Qph
	 OjWUGlnIOFULMYVCvZgEXnKIizUx6EUP/NXxvm5bWQLZNB+ct+9FQz9NLfLIXYMaScPed
	 /zzUBRdRa6PybhzyxlyHoTw3S1rHDU7xpCufJO7hk828g42zYUtH0KtaiJ1nMBUWLguQM
	 oBf0fGrrRqZmi4gpRjyIOflTTKjWUt5DaqQHa/U1q2CkPGmBIqBWW+7/Lxny9C/hRrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789984830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ajNNixQX6BV58KzbsrlG4634t7w42wShP27NzOztrV8=;
	b=Zeq8kTBi9vT7lMHP+pisu8Zq/pe2mN+wFdst6bYt8ZxIJRcda+pF/REJSjTqGMTXCWtx
	 zZYOsVMyyBTY7d2M6hubdGqm9G3ofqSo9QTe17Q7yDAdT5KIF3b98wgAGBfqzzJMaz+QQ
	 CxY1BXozTog02ICJFcV2iIAICmDcW0ONNRb8mtuKoawo11CybiizHnoQuKcHQr3PzOsLd
	 k+hnJrU7fMilfMD81uTddyMFl+0A5TE4fTBy2ZMuU//a4r3GZb2lXQEks22ph+RXkCcM0
	 KTT7woQ8Wupt8kOL8oQXdAbduYu7GsOPFRK0qzQkjMIkch73SXSj/6dj8HO3bkI5D/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i8hV1YkG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789984830;
	bh=ajNNixQX6BV58KzbsrlG4634t7w42wShP27NzOztrV8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dsgHYndBDHWjXJRK8ke9iJbHvjelSjjQYcDmu25Cn94+qkiXKqivZwtWx64eXN+QZ
	 QbjZygek4FDspuoU6k7pFN/27wdAf0bWGdu6wSRiDy+eRAP1K+4lVySE85d3SD1Of6
	 DaqPb8yE8iTkb+0n0YlCeKafEsjmaJwf+A40kiRu4S2wc/CfXuzs4MYKi+IH7jDenl
	 JV4d/Nepj0WcUxnxdpf7hWfWPRw6PDtUX4FyZ1Q2pyScHVZo1oKirpoLJUb5pplAVy
	 oc3dJIOpVBYLMGuCOuhxXuKFbY93DgqYmzxbf1ELRpm0XDLseAQOzWK2DPT/Ek8955
	 tbsiMe414VxFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F38BB606CE;
	Mon, 21 Sep 2026 10:00:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 211D2FEA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0710F60607
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2Q5jyhmf4N4 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 10:00:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 840FD606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789984828;
 b=XVYXaG0KK6KS+E3k9/1MYDHOwgtjCgSiz1jnINoheslN4yi3nxHpAXhrG7D1PQIuB13e
 lb+RWSWn+T/6pK8NG73GcRpinZ0mpDIfDItPS2mSdLP3iNnO55kMsXQv5ufAr/jWKLZ1J
 ovFUzk4EZmf2Pbbi2PoHONMhgZ2k12u0kPgCyZth3bvZxaN59aij9LMhUAqviSGX48P4l
 DlPZRBJi345UYQzg8vD/b8tEW2LvZoYI5mtNi3pA6y3a40sbBU1vap/ExO7Xf3vIsZSqZ
 95xzWfrFKMzbjqNs/d3Cl0DLHV6AMTE+ib3ofRvKU4tG0wgmdiCxqa1wXgjfUqNtxRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789984828;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=ajNNixQX6BV58KzbsrlG4634t7w42wShP27NzOztrV8=;
 b=QA/QAyk8KZgGZkOAzqHfTLDgaz9WWZO+Aalcl7Iu4MAWC+MKhxcaS9klhYW1GzAxwQHp
 0m2T2u+2ubqmRIamMXxqn6rNzl+rPkqUbzHDAP0/CNtkxU7cX0yq7pcu+TyCJxJ6oFEVn
 qYNtVI+Q+9NNCB5iYXAS9VkV6oReZemyuQp06nuQCfwvFO6D4TbME/oNvHtwMHcGoU02r
 1MW9g+iGWSiyCRB2401XQUT3o/nRW4fZoqIVzPL8uO4t6wI9Q7iLMn4mcYUvhst3YW+HN
 h/ajqzbtmfFeBIc2vqdxQ7ErlqqVlTIv25ORo58SzvB5Ss/abo/QaTrb86yoguFC4Jw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=i8hV1YkG; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i8hV1YkG
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 840FD606AA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789984823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ajNNixQX6BV58KzbsrlG4634t7w42wShP27NzOztrV8=;
 b=i8hV1YkGHAbqKQHgpfJ+2V+wv0/5aZgMS5SMG1earsAOaEGmvo4Fzh8bG6yf25kWdzHZgT
 KV31eq3vBfLl9FOTJSHWDwds6Nqj2PBF/uIycQfPPiFpnZTp9zuy8q6pHfNcG6sCVjxKxH
 o9ZsKJBAiIRl2SQQXzX5x6O/EY8jnSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-0I7bIq2YNmypL7FIiKE9kQ-1; Mon,
 21 Sep 2026 06:00:21 -0400
X-MC-Unique: 0I7bIq2YNmypL7FIiKE9kQ-1
X-Mimecast-MFC-AGG-ID: 0I7bIq2YNmypL7FIiKE9kQ_1789984819
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6619718007F7; Mon, 21 Sep 2026 10:00:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.56])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DF0B40E; Mon, 21 Sep 2026 10:00:15 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: restore double VLAN port parameters on devlink
 reload
Date: Mon, 21 Sep 2026 12:00:00 +0200
Message-ID: <20260921100000.1152575-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 6o6v1Y1S_gfOvG2K41Kuf1H62ORwB7jeVnHJlTesWGQ_1789984819
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

Set Port Parameters with the double VLAN flag is issued from probe and
from ice_rebuild(), but not from the devlink reinit path. ice_init_hw()
resets the PF there and the port ends up in single VLAN mode while the
driver keeps operating in DVM, so outer VLAN tags requested through the
Tx descriptor by the PF and by VFs are silently not inserted until the
next probe.

Move the call into ice_init_dev(), which is shared by probe and reinit.

Fixes: 31c8db2c4fa7 ("ice: implement devlink reinit action")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 423adc138dd67c..8c4b0fbc790644 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4766,6 +4766,14 @@ int ice_init_dev(struct ice_pf *pf)
 	int err;
 
 	ice_set_pf_caps(pf);
+
+	err = ice_aq_set_port_params(pf->hw.port_info, ice_is_dvm_ena(&pf->hw),
+				     NULL);
+	if (err) {
+		dev_err(dev, "ice_aq_set_port_params failed: %d\n", err);
+		return err;
+	}
+
 	err = ice_init_interrupt_scheme(pf);
 	if (err) {
 		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
@@ -4909,7 +4917,6 @@ static void ice_init_link(struct ice_pf *pf)
 
 static int ice_init_pf_sw(struct ice_pf *pf)
 {
-	bool dvm = ice_is_dvm_ena(&pf->hw);
 	struct ice_vsi *vsi;
 	int err;
 
@@ -4928,10 +4935,6 @@ static int ice_init_pf_sw(struct ice_pf *pf)
 	/* record the sw_id available for later use */
 	pf->first_sw->sw_id = pf->hw.port_info->sw_id;
 
-	err = ice_aq_set_port_params(pf->hw.port_info, dvm, NULL);
-	if (err)
-		goto err_aq_set_port_params;
-
 	vsi = ice_pf_vsi_setup(pf, pf->hw.port_info);
 	if (!vsi) {
 		err = -ENOMEM;
@@ -4941,7 +4944,6 @@ static int ice_init_pf_sw(struct ice_pf *pf)
 	return 0;
 
 err_pf_vsi_setup:
-err_aq_set_port_params:
 	kfree(pf->first_sw);
 	return err;
 }
-- 
2.55.0

