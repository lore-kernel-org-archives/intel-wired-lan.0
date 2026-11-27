Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABF606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3XSZ0RwI;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLzKCjiq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15F0F60AC8;
	Fri, 27 Nov 2026 08:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pynac82JaeMy; Fri, 27 Nov 2026 08:57:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7DCDE60AC2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769872;
	b=LEsyzdWMhEfCrrzp8TTsj2GJ6asO0Ay7saBONeer4qM5DutRpXc8BK4rVLpupBKcgrZ/
	 EU6n8qP93uik8aHCa7z/K+GVxkd5e2+N3KmEfhLWFPP23BHhWKjgcoU6oiHbgpcKDllkW
	 ZhQC6rbpKgGAbXfv16mG1T9weuL9KcsuoNRktJ8S0+Ai4NstqHfGBquxQprMnIlDZ5gjZ
	 jFUKivJySvLJiECf9kH8BzS/MXSXw/pAxeaWODLGqgnDu9smtL8n14qvwUmiLFwBF6qv3
	 9+S3i58223OyOc6B5PhL9X59rFBmwthoMxDkkSYwupT9kg1D2Q69YQ7iifLHNqHFL9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769872;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8v8Ip+plxXN89vEKmV5QJRl4QCWxKVrwNkDboP/e/Tk=;
	b=rEOqi/Htu1DXRs8druhQzYxjNjyfmpJuadd1kEAygfTliHTh3NfbL9t2QdI8K1zhKZuS
	 0yXwqA6+Fb0a3/Br2W39fb42o/yB61EiNAkd2ZmxCPDPgzZTtPtpYgXL9H9U9aF85YRw7
	 QoZ7weWUQuHpXk4+PWmH4gk46uH9H8NMX3xWUIXW7ndahyq2rQgUPSIkoR0Ox9PsHGY/L
	 qHKnW7PtNcbQBHUqR9EDl5HVwtkzKiuaTuI57kKIKEQa6nAe3YTusXK13AkgWRW+YWgoV
	 Kj5h7+l+4AlZ96IrSAxHLuuaXimSjvD3vqIZJAqjxVgEG3LiLIZH0IkL8KdBFvv5PfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769872;
	bh=8v8Ip+plxXN89vEKmV5QJRl4QCWxKVrwNkDboP/e/Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3XSZ0RwIwC1qIxZHIqquX2WP5YkW6HyLK6nCcbEp+lONIuT3JoeQ/4yj1jAKH7XvR
	 3lB9zTNMGzkLMNx7BNCTZMfCjMVLkwyXnbJYR+wSUG4+RIVIOD3OYC1O7SxsUlYHE+
	 8dQRYtQ5yKnhuRvQuO/Gi+woAqiK4eXpV3IAoGehNVkKuUiZxqfKizfSnJChRpC3Lf
	 ZnhW9y2X3yeUuA3aR/z2n7INMaXI4wnial1UF3bAZsC6XD2HDWbCTa/P2R++IXWgCn
	 /6+S+yURRNjF2iDw3Iy0N4DpNUkTbADarSOD21B+V28HVGr52gA9sCNiIGZ9RGVMA7
	 pYUoHDYkAvSgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DCDE60AC2;
	Fri, 27 Nov 2026 08:57:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D177311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52FE081201
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0C41k3QBRf3y for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:57:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5407A80E45
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YLzKCjiq
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5407A80E45
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795769868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8v8Ip+plxXN89vEKmV5QJRl4QCWxKVrwNkDboP/e/Tk=;
 b=YLzKCjiqJjObnj1flJ3MnbpC6BiZyRDPSsuORHSMsFKaubyXxICmfRKQ3NdwBwLbxKRCnT
 eAP0VwbsagUgiuy9sSIUGj9CK3JzCZBzBH5utGy6Nn4xzV2IsUdjGXf0HrldhabGOXCPHs
 3+6YOg8qylmSDZiGYeNjdnt0brMEXuk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-rGpobC8YPeCwkelkffy9sQ-1; Fri,
 27 Nov 2026 08:57:42 +0000
X-MC-Unique: rGpobC8YPeCwkelkffy9sQ-1
X-Mimecast-MFC-AGG-ID: rGpobC8YPeCwkelkffy9sQ_1795769859
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC57F1955D8B; Fri, 27 Nov 2026 08:57:38 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB1B644B; Fri, 27 Nov 2026 08:57:32 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Ivan Vecera <ivecera@redhat.com>, Alice Michael <alice.michael@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Patryk Holda <patryk.holda@intel.com>, Rinitha S <sx.rinitha@intel.com>,
 Aaron Ma <aaron.ma@canonical.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v5 2/4] ice: do not leave switchdev mode while
 representors exist
Date: Fri, 27 Nov 2026 09:57:07 +0100
Message-ID: <20261127085714.1207361-3-poros@redhat.com>
In-Reply-To: <20261127085714.1207361-1-poros@redhat.com>
References: <20261127085714.1207361-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: Izboz4H8y0YOSvdkQP-_h_iXtUNWXNJEZKhlb3VUdsM_1795769859
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

ice_eswitch_mode_set() refuses a mode change only while VFs exist, but a
subfunction port has a representor and a switchdev session too. devlink
core usually refuses the change first, because of the devlink rate nodes
the representors export, but ice exports none while DCB is active. A
switch to legacy then destroys the representor xarray under the running
session, the representors leak, and the uplink stays in its switchdev
configuration.

Refuse the mode change while the representor xarray is not empty.

Found by AI code review. Reproduced on an E810-C (FW 8.1.1, ICE COMMS
package 1.3.55.0) with the firmware LLDP agent off, without kernel
changes:

  dcb ets set dev $PF tc-tsa all:ets tc-bw 0:50 1:50 prio-tc 1:1
  devlink dev eswitch set pci/$BDF mode switchdev
  devlink port add pci/$BDF flavour pcisf pfnum 0 sfnum 88
  devlink dev eswitch set pci/$BDF mode legacy

The last command succeeded, the representor netdev stayed registered
and promisc off no longer took effect on the PF. With this patch the
command fails with "Remove all subfunction ports before changing
eswitch mode". No kernel selftests cover this.

Fixes: 977514fb0fa8 ("ice: create port representor for SF")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v5:
- New patch. Without it a switch to legacy can orphan a switchdev
  session, and patch 3 resyncs the uplink only when a session ends.
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 6e7bba4738989b..c96b201901f48c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -354,6 +354,13 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		return -EOPNOTSUPP;
 	}
 
+	/* subfunction ports have representors too */
+	if (!xa_empty(&pf->eswitch.reprs)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Remove all subfunction ports before changing eswitch mode");
+		return -EOPNOTSUPP;
+	}
+
 	switch (mode) {
 	case DEVLINK_ESWITCH_MODE_LEGACY:
 		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to legacy",
-- 
2.56.1

