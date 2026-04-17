Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A747F436B5
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 14:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5380E81516;
	Fri, 17 Apr 2026 14:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QrjE_AM-WrK; Fri, 17 Apr 2026 14:59:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 864D781510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776437972;
	bh=5K+oeeXrE8xykNoFcyiPqhE8KgPg7MMpfj1docSwu6w=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=M+5Ox4+2QIQEbHDNzTobpoPOcWAgcoc1tiwwejU0RceMFQQB91oFNEGYtZMebS2CS
	 DhQzz0Iozj/j29F/68SfbdxEWbviEtpewaYAjyPr044E387Nj5avSgRv/VDGO7DcjJ
	 xS6Sfq/03WaJvsW3QiFR1eezD3HhwQNPhLPLA2tmgLXMjTI/VXzHEtblhyTUvWDOKc
	 LFjnkneG2LPwnTplgnXb+65RK9wGSgcNk8n/8uCNK7TyDNQDMWQFNz1IHfa4Aj6GWV
	 9qAJF+Z6VGUub06lZFjCmljaUnsMZgXWWQXCV2qiGTyF2WdvcS5QwaF4RnnNcKloI7
	 YN1DeOKN8V5rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 864D781510;
	Fri, 17 Apr 2026 14:59:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58263396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DD1C60E00
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lt_m_ET6IiS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 14:59:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 305ED60DFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 305ED60DFF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 305ED60DFF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:29 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-VBRlW-aeM8mSJhpR2IRytQ-1; Fri,
 17 Apr 2026 10:59:25 -0400
X-MC-Unique: VBRlW-aeM8mSJhpR2IRytQ-1
X-Mimecast-MFC-AGG-ID: VBRlW-aeM8mSJhpR2IRytQ_1776437963
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2313818001F8; Fri, 17 Apr 2026 14:59:23 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9CB73000C1D; Fri, 17 Apr 2026 14:59:17 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 17 Apr 2026 16:59:05 +0200
Message-ID: <20260417145907.696307-2-poros@redhat.com>
In-Reply-To: <20260417145907.696307-1-poros@redhat.com>
References: <20260417145907.696307-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ueZox7JpX1dB7pqtWtCkm3-cVi1N0vDBSUrQbb1zhKY_1776437963
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776437968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5K+oeeXrE8xykNoFcyiPqhE8KgPg7MMpfj1docSwu6w=;
 b=QsWeyqiKAxXq4cKhRApVjvXb/DWlJxxw+io61eB6qWUhP32bK9Bs6JlI1fzunrL/sbLfBh
 p8sSLYU8LWEvC/m2s23LuFKg1ml3BD/DEIXyUmlCpiMbJhIvAoJOD0PDsI/Q+tE/YW7h7b
 YjeORacFoZ3c8GPKBLJwtPlVXeZevCY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QsWeyqiK
Subject: [Intel-wired-lan] [PATCH iwl-net v7 1/3] dpll: export
 __dpll_pin_change_ntf() for use under dpll_lock
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
Cc: Ivan Vecera <ivecera@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Rinitha S <sx.rinitha@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Ivan Vecera <ivecera@redhat.com>

Export __dpll_pin_change_ntf() so that drivers can send pin change
notifications from within pin callbacks, which are already called
under dpll_lock. Using dpll_pin_change_ntf() in that context would
deadlock.

Add lockdep_assert_held() to catch misuse without the lock held.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++++
 drivers/dpll/dpll_netlink.h |  2 --
 include/linux/dpll.h        |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index af7ce62ec55ca8..0ff1658c2dc1ba 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -900,11 +900,21 @@ int dpll_pin_delete_ntf(struct dpll_pin *pin)
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
+/**
+ * __dpll_pin_change_ntf - notify that the pin has been changed
+ * @pin: registered pin pointer
+ *
+ * Context: caller must hold dpll_lock. Suitable for use inside pin
+ *          callbacks which are already invoked under dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
+	lockdep_assert_held(&dpll_lock);
 	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
+EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
 
 /**
  * dpll_pin_change_ntf - notify that the pin has been changed
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index dd28b56d27c56d..a9cfd55f57fc42 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -11,5 +11,3 @@ int dpll_device_delete_ntf(struct dpll_device *dpll);
 int dpll_pin_create_ntf(struct dpll_pin *pin);
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin);
-
-int __dpll_pin_change_ntf(struct dpll_pin *pin);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index b7277a8b484d26..f8037f1ab20b60 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -286,6 +286,7 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 
 int dpll_device_change_ntf(struct dpll_device *dpll);
 
+int __dpll_pin_change_ntf(struct dpll_pin *pin);
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
 int register_dpll_notifier(struct notifier_block *nb);
-- 
2.52.0

