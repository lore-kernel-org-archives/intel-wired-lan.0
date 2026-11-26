Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5835606A33D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=c5O7XeTH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UdNf3h8V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9BDB60A68;
	Thu, 26 Nov 2026 20:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uYpFem9i9mY6; Thu, 26 Nov 2026 20:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09D7660A8F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725242;
	b=Q5X48hNn+dKQEgbmEN6hj6RxAV0EJ1ayZWp9pVNPBllpwAqAQy2G8DQah4EFWllCHHA5
	 6SsNX7PhPYwJie0n2B4C3afoA/uUEA0YiY+Qnq4EGsosutVei8cO3yLWn1prpAqQW4n7p
	 /KZk0xbg9FOyXB9JxnMJXtArcmSS5GvlfyBbHi9t7StwT2tPgqvrKin1kuv+2mojCaLAx
	 XRz8qOhBFE+ZDriMpKmG1JmHw8hJflYfs5UfJnfhEC2eZCMwBwd6MLknVvbYuGj1HZQjv
	 VjJV7+ENZ/ZLeBLEfe7TPbO1Z7Km4JtXdd6GjlExKdWOe8mA7q2mSwvKevsI4uq9GWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EWNSn7/qGLe4P+MNmNuGL5nNMpUQ5CrgVDoViR4hYXc=;
	b=JXyEpxUsydi+KEG6BmNQQrw4rxl5xUiCChyHfb+Q/cluLJu7Wil2RSCrKBwPg9B31Dq0
	 ecc7W7eoww/gPMreNtJK1BMAcoT7hqZsLKopU7tU5uK1SD4CNKvP76l/7UO5wTtPoFTh0
	 /Cqn8qxYhOGTTftjoHl1n4/grUA9mIk55yusP6W07IoAs/8zTIkrJo+VMoaKDx4uvW5KA
	 YAdWcQvzHjnmvP8wOAiaeKtUyeZYgfgBMEJP+cMZPTyCCqbuMc8ltngEXeSdsG4i6xMc7
	 UFz2WRY9ovh1bF27/cLEhzhHJv05tKsHNeGxiDw5n0VrNnmJefs5UBg/XCqfJ+/5psA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UdNf3h8V;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725242;
	bh=EWNSn7/qGLe4P+MNmNuGL5nNMpUQ5CrgVDoViR4hYXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5O7XeTHT58hxL/xp9y69zfP9LxmNKZkuh35aRPcxMKrvKtZjWtzrnxhqJ4/+D9ZH
	 4mXX4qdf9XlZ9tctZJPnNkpfequKw2MW8IPYlXfp41dvdM2hxD+jexw2Zezc/sVN8e
	 g/CnnPPg/ujc8uXxWs5PHEYFK8NQL/sjD2RgADGOH/V19nS1I2MgQBxxa2yWdE+Sq+
	 sbYq/LfEd8HuBJtAdZBOJ6W6JHmRmFleMfbktuD0Dp12muNt8WQp3LssENQbex6jm8
	 46bxh6ui1rFB5kPMqPEzKco0lzOwqMcuYoXi+wdbYHLg0xb2BSc2WO0dT0g9voNBbo
	 kjtYKZcg9pt7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09D7660A8F;
	Thu, 26 Nov 2026 20:34:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8820B1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CE3C60A8F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLoYNTBsNZE6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6FB6F60A68
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UdNf3h8V
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FB6F60A68
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWNSn7/qGLe4P+MNmNuGL5nNMpUQ5CrgVDoViR4hYXc=;
 b=UdNf3h8VdQ5hnBAGjKlz2DvYS+1tPNMWi8enuBFxtg4cBXeNVFYmiFnJLZR0hafW/DtpQ+
 edKnkBVVfyW08octmra1ISFft77MFzuW7xyDZLSyrZ7p37Tif2+WvzIUnh1vNsSJAIk15q
 RFdZ8fWTnpdoMk/1n5n9GJDNKdsfKAg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-PPslup6RNDuO54EKJcimBg-1; Thu,
 26 Nov 2026 20:33:51 +0000
X-MC-Unique: PPslup6RNDuO54EKJcimBg-1
X-Mimecast-MFC-AGG-ID: PPslup6RNDuO54EKJcimBg_1795725228
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E85B18011CC; Thu, 26 Nov 2026 20:33:48 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 464341800286; Thu, 26 Nov 2026 20:33:42 +0000 (UTC)
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
Subject: [PATCH RFC net-next 10/19] dpll: drop device events from the
 in-kernel notifier
Date: Thu, 26 Nov 2026 21:32:22 +0100
Message-ID: <20261126203231.934632-11-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5tJ3JvsFs2vfMOMrPsBqdnTw4Z_nx7kNzDakqRr8fOM_1795725228
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

Commit 2be467588d6b ("dpll: Add notifier chain for dpll events") sends
device created, deleted and changed events to the in-kernel notifier
chain, but no driver ever handled them. The only driver that uses the
notifier, ice, waits for pins with a firmware node and ignores
everything else.

Keep the pin events and remove the device ones.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 13 -------------
 drivers/dpll/dpll_core.h    |  1 -
 drivers/dpll/dpll_netlink.c |  3 ---
 include/linux/dpll.h        | 11 -----------
 4 files changed, 28 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index b1b76856c4a188..2371b81181471d 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -61,19 +61,6 @@ static int call_dpll_notifiers(unsigned long action, void *info)
 	return raw_notifier_call_chain(&dpll_notifier_chain, action, info);
 }
 
-void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
-{
-	struct dpll_device_notifier_info info = {
-		.dpll = dpll,
-		.id = dpll->id,
-		.idx = dpll->device_idx,
-		.clock_id = dpll->clock_id,
-		.type = dpll->type,
-	};
-
-	call_dpll_notifiers(action, &info);
-}
-
 void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
 {
 	struct dpll_pin_notifier_info info = {
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index eb33ae2d6080ab..1b3c74ef4c1b42 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -113,7 +113,6 @@ extern struct xarray dpll_device_xa;
 extern struct xarray dpll_pin_xa;
 extern struct mutex dpll_lock;
 
-void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
 void dpll_pin_notify(struct dpll_pin *pin, unsigned long action);
 
 #endif
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 7b9fadf3b3668a..78017aae19a6f2 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -891,13 +891,11 @@ dpll_device_event_send(enum dpll_cmd event, struct dpll_device *dpll)
 
 int dpll_device_create_ntf(struct dpll_device *dpll)
 {
-	dpll_device_notify(dpll, DPLL_DEVICE_CREATED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
 }
 
 int dpll_device_delete_ntf(struct dpll_device *dpll)
 {
-	dpll_device_notify(dpll, DPLL_DEVICE_DELETED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
 }
 
@@ -912,7 +910,6 @@ int dpll_device_delete_ntf(struct dpll_device *dpll)
 int __dpll_device_change_ntf(struct dpll_device *dpll)
 {
 	lockdep_assert_held(&dpll_lock);
-	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
 }
 EXPORT_SYMBOL_GPL(__dpll_device_change_ntf);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 99118dadb271e0..9eccfe41240418 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -211,21 +211,10 @@ typedef struct ref_tracker *dpll_tracker;
 typedef struct {} dpll_tracker;
 #endif
 
-#define DPLL_DEVICE_CREATED	1
-#define DPLL_DEVICE_DELETED	2
-#define DPLL_DEVICE_CHANGED	3
 #define DPLL_PIN_CREATED	4
 #define DPLL_PIN_DELETED	5
 #define DPLL_PIN_CHANGED	6
 
-struct dpll_device_notifier_info {
-	struct dpll_device *dpll;
-	u32 id;
-	u32 idx;
-	u64 clock_id;
-	enum dpll_type type;
-};
-
 struct dpll_pin_notifier_info {
 	struct dpll_pin *pin;
 	u32 id;
-- 
2.56.1

