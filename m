Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD18606A33D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0vgZI3AZ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J76/xc4t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E515E409E4;
	Thu, 26 Nov 2026 20:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id My7FFJNmDqjF; Thu, 26 Nov 2026 20:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A487409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725245;
	b=b9pu9W9BeJkc9AJ2KAIIhTFTLEz6Q/By3hSaYS5xWciK3pBMc4ilyE5dYaFO2CaqRU0a
	 2ryp1FPJFhPRh3hETb1GwS3OGkbs8zbdfLN2cDEhsuwxsKFr87AzjB2wfsrO17IreW3sN
	 e0yKGJG10X0socsIZj58hl7dCX3ew1LY0fF0JNBE8T5wp8FckvfiKQflWheyCkEx+0wBB
	 PhNg+UsfXPmDy51i/2piYxLAKCZWe9Sn49iBE5cKYJLM7wi7Io3rfI+yLKECwFAg/ulqr
	 pgKViBjiZvg3dqj/X34r/dbsLab2Y4B+cWTIPdbeyp2lqKc+V/9rjjQJiYPabTWJWOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nQh2wnVfC1ieRzwTg0A3RWd2OjYza/KrQTLhFoKiDso=;
	b=H1/KAiECpnCbcznh62YG61f91RYDb8NWyD+FjSIr8OTbM3cisW0MRmVKEYIUy7OTcKAh
	 IvoI3F8o70AjZ56Xiz42zv6fTo3MoRKQWt26CoEcQpwGJUJN4jN+uhOpc5zV0jJTMHPhT
	 XkJ05wwsoSjc6jQtbfOwwrF1BT/RxDtk19Smm+taWEsLRevoqSlR76ccUlsUoD14fRBkY
	 yIXge590+ngIZZjkUMTP/40jAvA6pCdfrny06al94ZJ/Xn37usnY5fF6uc+PHbC4jpvfT
	 4/bvy3zkGLIq47QaumVr6m+h3f0NBznd3c2CjRCuFcztRD2Cvm3+VXe3imPAf3sPR1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725245;
	bh=nQh2wnVfC1ieRzwTg0A3RWd2OjYza/KrQTLhFoKiDso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0vgZI3AZ0P8VGKGnbtq7eit2oqW6lYnhRhM2+Mmm2BzN10as74BrGRtFIkfZ8jMPL
	 q9DPICwe+nnpMj7KQn4a4rfQAeBiZTxpoMra2lEX+A7qf8/WcJeEpZpmIN2EN8VJ1d
	 bq0i5YbBg3qECIjZAobYZRWvD4qTs0d/ZLvEsFpy2j/oCSVx9P6IIEDEchevhc75OE
	 prLKJypXvlLPSQzsVW3Klvc4HsTRdE5Dz1qwzozUEFhPWr33xhRfgVWeI2RoIRpjTM
	 bfyC3xhB5AkOBw0bCBa+JPIaiwUn7GF8h/wcIqUklfwtL0wHZvbtlpuZB1jWuULtml
	 HA8GH2JrR66tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A487409EB;
	Thu, 26 Nov 2026 20:34:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 525FE1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44D9F60B0F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYdFqCOou5wR for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:34:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 732DE60AC8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J76/xc4t
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 732DE60AC8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQh2wnVfC1ieRzwTg0A3RWd2OjYza/KrQTLhFoKiDso=;
 b=J76/xc4t2u8EjjOBXsyWEF35J0vy5rXMR2RcwBnT9s2LIDVcKsQ65dWL+lEPy+grlcjrPY
 OJjw5l2eMNvgILzoRzzIl7NoE1gJT3MAp1rY4nKfBNj3IBaANU1I8BeMEYak/Cq7BF3woG
 xYPeuutmwBZrfy9efrtYdHLD9vJxYlI=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-Qlxq2nlVN4eJSyVNjQ9E_w-1; Thu,
 26 Nov 2026 20:33:58 +0000
X-MC-Unique: Qlxq2nlVN4eJSyVNjQ9E_w-1
X-Mimecast-MFC-AGG-ID: Qlxq2nlVN4eJSyVNjQ9E_w_1795725235
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 155841955F74; Thu, 26 Nov 2026 20:33:55 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAAE01801977; Thu, 26 Nov 2026 20:33:48 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Min Li <min.li@microchip.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH RFC net-next 11/19] dpll: drop the cached module name of a pin
Date: Thu, 26 Nov 2026 21:32:23 +0100
Message-ID: <20261126203231.934632-12-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5d1IUnTBXxGa2p3vIYCjl_Y25INaW0vs_kh5Uwoaih0_1795725235
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

Commit c191b319f208 ("dpll: allow registering FW-identified pin with a
different DPLL") cached the module name in the pin, because a pin that
another driver registered with its DPLL could stay registered after the
module that created the pin was removed. Every pin is now registered by
the driver that created it, with its DPLLs or under a parent pin, and a
driver unregisters its pins before its module goes away.

Read the module name from the module again.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 1 -
 drivers/dpll/dpll_core.h    | 2 --
 drivers/dpll/dpll_netlink.c | 6 +++---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 2371b81181471d..7440b174c3de2b 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -653,7 +653,6 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	pin->pin_idx = pin_idx;
 	pin->clock_id = clock_id;
 	pin->module = module;
-	strscpy(pin->module_name, module_name(module));
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 1b3c74ef4c1b42..3b7e0af7f7ee6f 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -45,7 +45,6 @@ struct dpll_device {
  * @pin_idx:		index of a pin given by dev driver
  * @clock_id:		clock_id of creator
  * @module:		module of creator
- * @module_name:	module name of creator
  * @fwnode:		optional reference to firmware node
  * @links:		links to other pins (struct dpll_pin_link)
  * @dpll_refs:		hold referencees to dplls pin was registered with
@@ -61,7 +60,6 @@ struct dpll_pin {
 	u32 pin_idx;
 	u64 clock_id;
 	struct module *module;
-	char module_name[MODULE_NAME_LEN];
 	struct fwnode_handle *fwnode;
 	struct list_head links;
 	struct xarray dpll_refs;
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 78017aae19a6f2..372de086a7eb3d 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -754,7 +754,7 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	if (nla_put_string(msg, DPLL_A_PIN_MODULE_NAME,
-			   pin->module_name))
+			   module_name(pin->module)))
 		return -EMSGSIZE;
 	if (nla_put_64bit(msg, DPLL_A_PIN_CLOCK_ID, sizeof(pin->clock_id),
 			  &pin->clock_id, DPLL_A_PIN_PAD))
@@ -1630,9 +1630,9 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
 		prop = &pin->prop;
 		cid_match = clock_id ? pin->clock_id == clock_id : true;
-		mod_match = mod_name_attr && pin->module_name[0] ?
+		mod_match = mod_name_attr && module_name(pin->module) ?
 			!nla_strcmp(mod_name_attr,
-				    pin->module_name) : true;
+				    module_name(pin->module)) : true;
 		type_match = type ? prop->type == type : true;
 		board_match = board_label ? (prop->board_label ?
 			!nla_strcmp(board_label, prop->board_label) : false) :
-- 
2.56.1

