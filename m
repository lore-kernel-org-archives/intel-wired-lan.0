Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4DAFF8867
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Apr 2026 10:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D02181992;
	Wed, 29 Apr 2026 10:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ei6hTKUitPQ0; Wed, 29 Apr 2026 10:25:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D19148195D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777458300;
	bh=tpyUAJUtCHhe5alI9H/Zi1O4ExcV+YlMS2VV68ITC3g=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JQ1piNiKEPAH8lrwZ8sXTTLRRQUU/maPFs+hnvKQX6Ek2UEdj+LOBlt2gAH76+Iqg
	 TZt9sM645dfJHPbB56QZgIVQZRF9y9zJpTyjHKLlLjOJIynlW+wXOi9C23EC5NEuEV
	 ZMrf8TBuB5pCt+jQ2QcTv0gRjHrVr8L8kcUsF9HIS29fW8wd0wCWfGlHeelgyp2Eb2
	 ZwDZ3rOHh9xzHBfogFMHmUW5BOO169e+Vj7WY52TPtYuNmuwN7sXH0Q/PZkfqpYscJ
	 d2XzQWVnzYrRiD+1/xXpapArT529CGRZs7lCEguipjUoUbSLOl4XuH3BVGfs66OgSF
	 2dmE1eRRE2D8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D19148195D;
	Wed, 29 Apr 2026 10:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C335E231
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 10:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5806408AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 10:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YNoyPVWqyaFV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Apr 2026 10:24:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 949F740798
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 949F740798
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 949F740798
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 10:24:56 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-TLKubJO3OZWRESIn86DlEw-1; Wed,
 29 Apr 2026 06:24:52 -0400
X-MC-Unique: TLKubJO3OZWRESIn86DlEw-1
X-Mimecast-MFC-AGG-ID: TLKubJO3OZWRESIn86DlEw_1777458290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CA1519560A3; Wed, 29 Apr 2026 10:24:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64B1C1800446; Wed, 29 Apr 2026 10:24:45 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, horms@kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Wed, 29 Apr 2026 12:24:23 +0200
Message-ID: <20260429102426.210750-2-jtornosm@redhat.com>
In-Reply-To: <20260429102426.210750-1-jtornosm@redhat.com>
References: <20260429102426.210750-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: cSew0mOvozctfNQI6vQf5FXCmZ9AWCHEgStA6fAwrlY_1777458290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1777458295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpyUAJUtCHhe5alI9H/Zi1O4ExcV+YlMS2VV68ITC3g=;
 b=do14ohoEu6eD/RAkjNNwDMPlo99HC6K1jrdglNtRZpC70Vdzaqw/4fDgtCjVMF84kA7S08
 E9ztlRIdjg0l8QMzekGTJ3Y8YYQtsIwKca/HLtY05x5KZNdbckd5GnigUe730tkiMAYpr/
 thh4dkCyW+222f4mGDMWdL9P86pP2K4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=do14ohoE
Subject: [Intel-wired-lan] [PATCH net v5 1/4] iavf: return EBUSY if reset in
 progress or not ready during MAC change
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

When a MAC address change is requested while the VF is resetting or still
initializing, return -EBUSY immediately instead of attempting the
operation.

Additionally, during early initialization states (before __IAVF_DOWN),
the PF may be slow to respond to MAC change requests, causing long
delays. Only allow MAC changes once the VF reaches __IAVF_DOWN state or
later, when the watchdog is running and the VF is ready for operations.

After commit ad7c7b2172c3 ("net: hold netdev instance lock
during sysfs operations"), MAC changes are called with the netdev lock
held, so we should not wait with the lock held during reset or
initialization. This allows the caller to retry or handle the busy state
appropriately without blocking other operations.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..67aa14350b1b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1060,6 +1060,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
+		return -EBUSY;
+
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-- 
2.53.0

