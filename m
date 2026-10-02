Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90042CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 386A76080A;
	Fri,  2 Oct 2026 13:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aXh8MZm8E1PE; Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9F7DD606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946517;
	b=aaLhkcoPJZaWEAu0Q0ic9XNR6XZxPmrx0BL96kWNKd5Ms3GqIUyEl+3SKRMYLWRVgEoB
	 WeUmOtIUPv6F1m4o59zOsKwLVxwkE0A+9ZGPSDO93TeArgijewLzBkVzvzgxqI6nHWgl9
	 ElgsfN9uYOAWtRsALFuLKhcol3e+SE+zeS+uUj3riTORTTRUtkvU5MKAienMfTsNyCVhw
	 yAqzc7r1PXAwfloS03GEckHqa+Y5QuDRpQxdY8dfIWCJC/QsAzO3jWmA44XMLyYEPa7Vn
	 J6eKRtGwF/OomJTFmz9eRyP9TMQYBOTrI8BUkyQMfQRoo6o0Z/GVYdiE0UJAjg2S0cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=czBirh9gsxqopfneZqb59N/cedGnNYhxy5ysmWPWLCU=;
	b=AjqSk93hJOqVmNiC6QbgVufF6YRTImUE8qbr0YbBJDgzI0cBQpbjBhqoYRT2GGslMXZb
	 Bcckz+Nslg9Nu/Psd4ebzIF0aEC2YCXNoTMhd7qWBhftCukxLRchm0+5uNJ1ffGQKO0AM
	 2RPCv6o5+c1QW0C1AqurOT4UnjqtM1yOOOIa0Rg3nz/HBdg9CJ3RKuIpFpTjFIi/NH6Tu
	 KhKDvfilCEgUC5HbRcXwc4oDUAmlfzJElIKWkyCZlX1djunkJbSnQbzLwPztgM30QbZ3B
	 IAb7mIrSjSGotJJmxgrHnCpRnzSMNWaS7Yv4yMZJxEhxtwenwkWS3TT2nPmyfnMMjow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946517;
	bh=czBirh9gsxqopfneZqb59N/cedGnNYhxy5ysmWPWLCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JeAsXnP/8ZeMMNCJ9IVVLU/vwrzITmEyh7rh8o7CMEXHj0Fht0nUh2GMI0UAbOyNl
	 fqk2jCVFORjG/aXkcqQDvG5Hpci5UoD7JiH5Dm3oInRqO19Y2rx9zgTQrenUxKUcPv
	 kHZvfDICrBmRSqP3XKkp/pmfuvjtHoeOajBdXCwDUbhh5HCEA9vgjwuMFr0bBW4NOd
	 gz08u/3rGIEBJLYDmR3R0seuKzWQbW3CJcF62L1b83qFmonp/qNF/RDO75tBEgYUqE
	 Jyd6wNG1ymRVUX425+GBMPsZONAHuXFgShfF3eu0m/X5wwsm04Cg86tyrGyB4yQtRS
	 yF/ODEVrhYgXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F7DD606FD;
	Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E65E7282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC47881222
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPpRjZ-PtLZv for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F300E81221
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946515;
 b=Ow5nKR5DiyLJMAwVh16jj1ClOS6UwroZDBrDNCuw9yFkCoVNbQFWAudDnV7EfgBQbHXN
 YWZNaNgHJYWQ4b1koepEzg+/ovC76RbbZbnMk2BrmvqRrSVrnV+k4mB8hytASFWV8dtk0
 pjsb1Svq5FDIMeyNxH8crG5Q28sKjEGnxtf0iDRFWIibNGXA+IXsQjcIGML1nKRL5xZn+
 rO1Vuwt9+fe2QAxQEqy9/v5QnX5u7errhqBZLihF7kYV/jzBkwkmE5RniY4UwBMBzM+2T
 IKU7aJ2nxgH9XwLlX0koFTCxFpukefMCzSRIhRFDT4W8583F6bFfOeyDD1kwx3yZRaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946515;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=czBirh9gsxqopfneZqb59N/cedGnNYhxy5ysmWPWLCU=;
 b=UZCTYIXPuQqfnHyjgrSHlTKk+miVd/20idKkD1F1iVP1jpd+b9x4BexiaKpxAt6AOZ/2
 u7PvIMdc6IiRhsaFFIAUEDxBPlXkY8zjEnOC/qShiJk/segxfPtwkHHIEUTVN1FJBvdM6
 C4ySZ5u7oCSKsuzsaDnlCIVlvmOn6IjlKLSQ3iY972u0yzIwH/vdOd1B7HuRihVgNe+Yx
 rtzSVCmyxfflYx/EMkA7fEujGOwffnk6kM4YhfBBecmHwCy+e/OTC5LAmKsFCGH1192Ol
 Ah1eo4STxk7JcmOHtal97OqCNmplOl3Y2YRbZAxOoonFwwdaqCwWNA8tiMJcsWDI5PQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aDy28Nuz; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aDy28Nuz
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id F300E81221
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czBirh9gsxqopfneZqb59N/cedGnNYhxy5ysmWPWLCU=;
 b=aDy28NuzeSQiEr4+5T9Vbx+OvncomlQFZPE7XV+zCL0kEExGwzc5CcBcedXfjy791YmB+v
 WVf+T/YOhym9ZcULIVzY5F1Fkvi1DrOnadpq4IQ1CAR89C7Af+A7pvhyj/Tbgshq0qCnwh
 2g3SnG0krFiZecipgKE8xXoOXjEUmCg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-1JIUFIEjORuZQTPXb4QapQ-1; Fri,
 02 Oct 2026 09:08:29 -0400
X-MC-Unique: 1JIUFIEjORuZQTPXb4QapQ-1
X-Mimecast-MFC-AGG-ID: 1JIUFIEjORuZQTPXb4QapQ_1790946505
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60061954B30; Fri,  2 Oct 2026 13:08:24 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AFD2433; Fri,  2 Oct 2026 13:08:18 +0000 (UTC)
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
Subject: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when ice_vsi_open()
 fails
Date: Fri,  2 Oct 2026 15:07:45 +0200
Message-ID: <20261002130752.2597259-4-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: M6AvE6sF1uyh1Swu9Nh3fjAfAFheaTVQ-LNrgTw28lA_1790946505
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

ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and
enables them in hardware. If anything after it fails in ice_vsi_open(),
for example requesting the MSI-X vectors, the error path only frees the
ring memory and leaves the queues configured. Every following open then
fails to add the same queues again and the netdev can not be brought up
until the driver is reloaded:

  ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
  ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x0002

Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
The ice_up_complete() failure path already does it through ice_down(),
so let it skip the new step.

There is no i40e counterpart of this fix, i40e does not add its Tx
queues through the admin queue. It was found while verifying the
previous patch. With the IRQ unwind fixed the warnings were gone, but
the netdev still could not be opened again after the forced
request_irq failure.

Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d246cde36ae726..e62a8f544345a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7561,13 +7561,13 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	err = ice_vsi_cfg_lan(vsi);
 	if (err)
-		goto err_setup_rx;
+		goto err_stop_tx;
 
 	snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
 		 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
 	err = ice_vsi_req_irq_msix(vsi, int_name);
 	if (err)
-		goto err_setup_rx;
+		goto err_stop_tx;
 
 	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
 		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
@@ -7593,8 +7593,14 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 err_up_complete:
 	ice_down(vsi);
+	ice_vsi_free_irq(vsi);
+	goto err_setup_rx;
 err_set_qs:
 	ice_vsi_free_irq(vsi);
+err_stop_tx:
+	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+	if (vsi->xdp_rings)
+		ice_vsi_stop_xdp_tx_rings(vsi);
 err_setup_rx:
 	ice_vsi_free_rx_rings(vsi);
 err_setup_tx:
-- 
2.55.0

