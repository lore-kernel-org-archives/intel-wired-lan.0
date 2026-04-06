Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F12F46C51
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Apr 2026 15:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE08A4072B;
	Mon,  6 Apr 2026 15:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGCijyCfnhwq; Mon,  6 Apr 2026 15:16:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C51A40752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775488597;
	bh=u5Wd/lsEYSYOEWcDhPq25pfRSzrdTb6REoIlPg9g2v4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6WqsuLQU6UZbCS3MMxzJKkJX4ULXrNNxscQsGZjbyZpHYooPcEyG2Cdcctcw8u+F
	 GUp4VdulxlBIAOCN7J5b7Px9gjCmjcrJpaD3V18u1EX9LL0jJJ56rH6qnDKVNzCnUM
	 MMSK6WFkFlkK/v2+dkb8JitbB7ma0zNa5k6tDgPYVU2wF7uccIQY2eW1UxbvkeXVYI
	 SRztP4p86U8LkGCFjPyibl2ZIvLWW+ya0j6gnWer0ORabDP0kvd6F1uMbSmT/n/Pjp
	 MMmvPcaLe90hJVHXhkWaBzue27rZteByLOVYuXjMTW+WhngTRpMGusOke9aIPsPxiC
	 nhaKMNyw76w5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C51A40752;
	Mon,  6 Apr 2026 15:16:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76099219
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 11:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4CBF4087D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 11:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0H4e9K5NtG3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Apr 2026 11:21:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A37A64081D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A37A64081D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A37A64081D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 11:21:23 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-BJz-17XSMfybIuNkWKOc8A-1; Mon,
 06 Apr 2026 07:21:19 -0400
X-MC-Unique: BJz-17XSMfybIuNkWKOc8A-1
X-Mimecast-MFC-AGG-ID: BJz-17XSMfybIuNkWKOc8A_1775474478
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECE38195608C; Mon,  6 Apr 2026 11:21:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7993300019F; Mon,  6 Apr 2026 11:21:13 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Mon,  6 Apr 2026 13:20:55 +0200
Message-ID: <20260406112057.906685-2-jtornosm@redhat.com>
In-Reply-To: <20260406112057.906685-1-jtornosm@redhat.com>
References: <20260406112057.906685-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: giOqumroprNMZ3tt2VntVnGxaLEi3lvm055rvu9h3Ww_1775474478
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 06 Apr 2026 15:16:35 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1775474482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5Wd/lsEYSYOEWcDhPq25pfRSzrdTb6REoIlPg9g2v4=;
 b=Hb8rSLWIfjYUB0YBfDgWWd8UPIbvpIZx/kxjeyiY1LFGHgD6Huwi3aIkOK364gwtcJSbUK
 zKA90atufwESMNqp7LCj4c7vbmzNraH48ghJwvrFexV1+XvW85dKd0RCg87e2/PREdS/az
 8PnKrnEDdwWn3lgchapn/O0sS3P16jo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hb8rSLWI
Subject: [Intel-wired-lan] [PATCH net 1/3] iavf: return EBUSY if reset in
 progress during MAC change
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

When bonding enslaves a VF shortly after creation/reset, the VF may still
be initializing. Instead of waiting (which holds locks), immediately return
-EBUSY if reset is in progress. This allows the caller to retry or handle
the busy state appropriately without blocking other operations.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..0ca4f9696a41 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1060,6 +1060,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (iavf_is_reset_in_progress(adapter))
+		return -EBUSY;
+
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-- 
2.53.0

