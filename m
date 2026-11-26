Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D7606A339
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CQVsBqtQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OPjDQpSJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC8DB409E4;
	Thu, 26 Nov 2026 20:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gi6zVYtwO1tl; Thu, 26 Nov 2026 20:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A686409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725235;
	b=M2kLoje7dii4sUiznddCFeGd4tF9Gwvd7TzTGhJx7iwzlndQKh18zDzyw2tUNd0kdML0
	 vkzWR6MkvAkNSYFNeQybGkkpezhYPsEhIjP3A6n3gcctaDwOjdIGrtUV0gT0awvIag3KE
	 zjY6dP4H+pzuCARA+4HMVCO7Ch5uz+qo4c0nYTModLnjnyCRTH0aWTs4Faxnmws6NrLhq
	 aYK9aeVEXucnuollSIfBIQ+e7H48AM7ToXHoqMvA8M+uT8Ke6ZqchCaAV2vz9zjAS3Hzn
	 5nNGBBoyOj6Ei7Y0Hd7JC/ZaJjWdn1CE2lOJOqBvshTcGD9NcoUX02Owv7r8cbXwVjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gybj3DkML2SufeUVzqzLs05OtQbk5JUJB/WPsJMqxF4=;
	b=ObGH3em6wHRtO5gK3rVxosxT+a/26lZsA9ZeWeOh5fl2hzFd+UCg7LWWEn9WAnfAeY3G
	 gBuPEAWgRXww8M8uMOe/Y0jT0coKbY3MjPrCZo24aDvNJK2Kzo0rVJs9jnndIq4jeQ2//
	 hpP+MclQjdYV0wY9K3aoJPcCCVMx9jGNEDPmw2+Eea5fMHtXrgTvy305U0OHKxI4i8qTX
	 cW+unhLRhg8RhMs64MzcwKsmsgSJyj+DA1/wLRfrCAP62i06ZXytIXqWmekvGxUZCSVe8
	 F6+3HOZKJcOIZbDFp6CzBJKPoAGd3DoQE7aPlQKVPq10wDpjUQJ4my0q7qnSvLe55oQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725235;
	bh=Gybj3DkML2SufeUVzqzLs05OtQbk5JUJB/WPsJMqxF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CQVsBqtQCIq9YPhlCv3kPLep4AXRYnjZZiFzS5dK/PZB5gB8odeciNXwwrT0WiLyj
	 fiaW/xA4qHEx636NLRv5y1ZggeHBLnICUOKtAS34RocL3F4dTlLPnc8t3x3U2bBcgO
	 V7wy66gdQUEjVGQ8i8cgPl78lunipwi13+GGorNvux87nSBlCH5Y9YE5PerFq+aHg4
	 EkYQS84Ae1LX7NP1Ru5oHzO6jfI9OQSTr1MILeqKwIM60Cb/DFxqRAOFhPUsko3bm4
	 BpYBczImoJ2oj0/CkkL+vhyVXkPBbbLKFiIFmLDl8hDT2ZJ0SHHZvg95hDiXHmTJGm
	 xkYKSaILlxkEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A686409EB;
	Thu, 26 Nov 2026 20:33:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F04C311
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 714A060B0C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9jF4kipIz6-r for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87D2860A68
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OPjDQpSJ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87D2860A68
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gybj3DkML2SufeUVzqzLs05OtQbk5JUJB/WPsJMqxF4=;
 b=OPjDQpSJJtEgRyg+LFdJgBuT+boCkiJpNtuxUQOkckp0kgS3r//6eGtDkc+JEhugbM9ESN
 N0fcWc6yJqFAjXxdMcuwUAkmjua7GWuB80otNwDuIieF6u1BUkzWqboul2KdqXdI5z0Fik
 DbJrK4eH3KE+o1Ljc8WNgZF1lVWd/0A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-310NCRwROjGas_BUZG6hWQ-1; Thu,
 26 Nov 2026 20:33:45 +0000
X-MC-Unique: 310NCRwROjGas_BUZG6hWQ-1
X-Mimecast-MFC-AGG-ID: 310NCRwROjGas_BUZG6hWQ_1795725222
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D73E91944AA6; Thu, 26 Nov 2026 20:33:41 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9182B1801977; Thu, 26 Nov 2026 20:33:35 +0000 (UTC)
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
Subject: [PATCH RFC net-next 09/19] dpll: drop the source clock id from pin
 notifications
Date: Thu, 26 Nov 2026 21:32:21 +0100
Message-ID: <20261126203231.934632-10-ivecera@redhat.com>
In-Reply-To: <20261126203231.934632-1-ivecera@redhat.com>
References: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: E0ivWyr90NXhos-yeSDIiwANLp6XW9cS_diNDl0tMMA_1795725222
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

Commit 0bf47f722fa9 ("dpll: extend pin notifier with notification source
ID") added src_clock_id to the pin notifier info, so that ice could
ignore the notifications caused by its own registrations of the zl3073x
pins with its TXC and TSPLL DPLLs. ice does not register those pins any
more and no other notifier user reads the field. Remove it.

The notifications are sent as before, only without the field.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 14 ++++++--------
 drivers/dpll/dpll_core.h    |  3 +--
 drivers/dpll/dpll_netlink.c | 10 +++++-----
 drivers/dpll/dpll_netlink.h |  4 ++--
 include/linux/dpll.h        |  1 -
 5 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 57eb4ff2c320e5..b1b76856c4a188 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -74,8 +74,7 @@ void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
 	call_dpll_notifiers(action, &info);
 }
 
-void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
-		     unsigned long action)
+void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
 {
 	struct dpll_pin_notifier_info info = {
 		.pin = pin,
@@ -84,7 +83,6 @@ void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
 		.clock_id = pin->clock_id,
 		.fwnode = pin->fwnode,
 		.prop = &pin->prop,
-		.src_clock_id = src_clock_id,
 	};
 
 	call_dpll_notifiers(action, &info);
@@ -965,7 +963,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		goto ref_pin_del;
 	registered = xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
 	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
-	dpll_pin_create_ntf(pin, dpll->clock_id);
+	dpll_pin_create_ntf(pin);
 	if (!registered)
 		dpll_pin_links_ntf(pin);
 
@@ -1054,7 +1052,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	ASSERT_DPLL_PIN_REGISTERED(pin);
-	dpll_pin_delete_ntf(pin, dpll->clock_id);
+	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
 	if (xa_empty(&pin->dpll_refs)) {
@@ -1128,7 +1126,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			stop = i;
 			goto dpll_unregister;
 		}
-		dpll_pin_create_ntf(pin, parent->clock_id);
+		dpll_pin_create_ntf(pin);
 	}
 	mutex_unlock(&dpll_lock);
 
@@ -1137,7 +1135,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 dpll_unregister:
 	xa_for_each(&parent->dpll_refs, i, ref)
 		if (i < stop) {
-			dpll_pin_delete_ntf(pin, parent->clock_id);
+			dpll_pin_delete_ntf(pin);
 			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
 					      parent);
 		}
@@ -1170,7 +1168,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 		reg = dpll_pin_registration_find(ref, ops, priv, parent);
 		if (!reg)
 			continue;
-		dpll_pin_delete_ntf(pin, parent->clock_id);
+		dpll_pin_delete_ntf(pin);
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index f158785bf401b6..eb33ae2d6080ab 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -114,7 +114,6 @@ extern struct xarray dpll_pin_xa;
 extern struct mutex dpll_lock;
 
 void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
-void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
-		     unsigned long action);
+void dpll_pin_notify(struct dpll_pin *pin, unsigned long action);
 
 #endif
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index fab234553b422a..7b9fadf3b3668a 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -969,15 +969,15 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 	return ret;
 }
 
-int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id)
+int dpll_pin_create_ntf(struct dpll_pin *pin)
 {
-	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_CREATED);
+	dpll_pin_notify(pin, DPLL_PIN_CREATED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
 }
 
-int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id)
+int dpll_pin_delete_ntf(struct dpll_pin *pin)
 {
-	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_DELETED);
+	dpll_pin_notify(pin, DPLL_PIN_DELETED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
@@ -992,7 +992,7 @@ int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id)
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
 	lockdep_assert_held(&dpll_lock);
-	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
+	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
 EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index bc20bcd248a512..ec7cace106c268 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -8,9 +8,9 @@ int dpll_device_create_ntf(struct dpll_device *dpll);
 
 int dpll_device_delete_ntf(struct dpll_device *dpll);
 
-int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id);
+int dpll_pin_create_ntf(struct dpll_pin *pin);
 
-int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id);
+int dpll_pin_delete_ntf(struct dpll_pin *pin);
 
 #if IS_ENABLED(CONFIG_KUNIT)
 /* For KUnit tests, call with dpll_lock held for a registered pin */
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index e252d3c6b4334a..99118dadb271e0 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -233,7 +233,6 @@ struct dpll_pin_notifier_info {
 	u64 clock_id;
 	const struct fwnode_handle *fwnode;
 	const struct dpll_pin_properties *prop;
-	u64 src_clock_id;
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
-- 
2.56.1

