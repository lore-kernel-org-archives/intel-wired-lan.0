Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA20606D805
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LmN/05Ux;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cfYIEvs7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5759940993;
	Fri,  6 Nov 2026 12:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxumXAO5kgIH; Fri,  6 Nov 2026 12:10:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B82C540994
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967031;
	b=nWE7hLGqytAk/auyGwni+VX99VgafTh2A39SOQOHLv+eS/zOtl9JsWjQC8ZjIgH1vgWP
	 sDhKVGveKLlf4jtuZ4lSqiz2EqoW0oRDPanpupulwfZJzSMfmd0wNEJSGrkIdzsa7hLhg
	 GHYZ3Z+NhleTCeCCU8syzpy4YVXkMN6j/GiHhR8GQcPqi2aYKICSCZywqpgOF70xyD+Tz
	 JEKa+fcCpGi42G8M1G/0X8Lz4B8vlQeA70LwORCfYNwo0KA4O0EywwBxTlycLje4VabWO
	 sdCj7rPBzYBZuTpDKPIxO9FYvki1FMHNNAWrbtDVlVcPNgmuSfKvOT+X/azQinnOSlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f4YoYCSVK4gZhUunSADNV3O618EXpW3G+wBkhi6O/wU=;
	b=nD5TJVAblhxc6F42KUCR70V/E7xpchxITfo7nDO2kcYTkG7QOP90D6rzcefyNsUAyrsL
	 vxMs+yjNGWMzdMGEQe2NP0wtyTMN3IaiKIFopYzCOeKKtkZTdueA8StAyCveF30IES2cS
	 Kn1kJdmG6jIcepb56LXJlcuuqa/vzgBbQuKmlItpS6akVEMMXKzOXH2nssCUGpgM67Cbc
	 hRX8EkarDV3j7ms3ZlW7pMYVe0uc18YGd3uzD5WCKM9MU/hePHDawYfQm8lDa2dPb8GZL
	 b26OLZdBO4pazc3vOxJUo/ynhbmt/CihYwpqdTpZalAlTROB0vNQcnLtMVHrUBzfwCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967031;
	bh=f4YoYCSVK4gZhUunSADNV3O618EXpW3G+wBkhi6O/wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LmN/05Uxkv2ZWTlG5PqVSWOlC3RupVstZMBsJlD3M5JNI02q1NZD/pRzm8NKKcWDv
	 3KZxiX5TDGjEM6SMTPJHr9bSFQwEtJJeD6lmiq5G+n51cuWnkaorJnmWMS5jta9bBu
	 rayydLc7GQibWiUF/oqhC7U6Uwjy+/ds4RMjKzmuZ1n5MLjHUUS7jL1cP16Yb8ERWK
	 QlaklSF6jQf9CqdJRwxlz6bn+kDBx1j4NUEv7MSo6+woPpqOVvIkxc0G/t+F68qT/e
	 VV3WgEpKK541q7pKPtWUi6+XpaonT583MBYWqix/VFeYZt4JFdOylqaPXFHhxy0Kn5
	 vgfr8GqmtiB2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B82C540994;
	Fri,  6 Nov 2026 12:10:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B6A3235
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D37F81217
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOuw8XiIYqlC for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93F7681211
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cfYIEvs7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93F7681211
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4YoYCSVK4gZhUunSADNV3O618EXpW3G+wBkhi6O/wU=;
 b=cfYIEvs7Klnib2zPF9azdtO2qN9dgGNmnxqvMmZH1HFnLfufl5qcUI6zmer5qELf/9VEp2
 gB+oLil2rAzRcRZMOlfOguPcfbXAOZAlib9/K6LZSzNkGQHZzjoMQSZpERy2W9gdMcCSto
 zXfM6ke+ke8ssCD9c4IIjphrGGPyJ/c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-TerawikSOku60RoOmgG7pA-1; Fri,
 06 Nov 2026 07:10:23 -0500
X-MC-Unique: TerawikSOku60RoOmgG7pA-1
X-Mimecast-MFC-AGG-ID: TerawikSOku60RoOmgG7pA_1793967020
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ADE91956057; Fri,  6 Nov 2026 12:10:20 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2711318001CA; Fri,  6 Nov 2026 12:10:13 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from the
 periodic work only
Date: Fri,  6 Nov 2026 13:09:56 +0100
Message-ID: <20261106121005.1327603-2-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: r-HEvV6ZeV0NxF5IPGIe9v5xw4hFY22lYPn_hlGOJyo_1793967020
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_dpll_tspll_state_on_dpll_set() notifies the TSPLL device from a
callback of the TIME_REF pin. This pin belongs to an external DPLL and the
DPLL core is going to run its callbacks under a lock of the pin's owner,
which does not cover the TSPLL device.

Only update dpll_state in the callback, so a device get reports the new
state right away, and leave prev_dpll_state to
ice_dpll_periodic_work_e825(), which then sends the notification. It now
arrives up to 500 ms later and after the reply to the request.

Refresh dpll_state on every run of the work, as the state written by the
callback can be transient and the lock status can return to
prev_dpll_state before the next run. No notification is sent in this case.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..bdbcf7af296eb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2914,7 +2914,6 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	enum ice_clk_src clk_src;
-	bool changed = false;
 	struct ice_dpll *tp;
 	int ret;
 
@@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 		WRITE_ONCE(pf->ptp.tspll_locked,
 			   new_state == DPLL_LOCK_STATUS_LOCKED);
 
-		if (tp->prev_dpll_state != new_state) {
-			tp->dpll_state = new_state;
-			tp->prev_dpll_state = new_state;
-			changed = true;
-		}
+		/* ice_dpll_periodic_work_e825() compares the state with
+		 * prev_dpll_state and sends the notification.
+		 */
+		tp->dpll_state = new_state;
 	}
 	mutex_unlock(&pf->dplls.lock);
-	if (changed)
-		__dpll_device_change_ntf(tp->dpll);
 	/* TSPLL reconfiguration may complete before lock is reacquired.
 	 * PTP periodic monitoring tracks and restores the final lock state.
 	 */
@@ -3372,8 +3368,8 @@ static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
 	mutex_lock(&pf->dplls.lock);
 	new_state = ice_dpll_tspll_lock_status_get(pf, true);
 
+	tp->dpll_state = new_state;
 	if (tp->prev_dpll_state != new_state) {
-		tp->dpll_state = new_state;
 		tp->prev_dpll_state = new_state;
 		changed = true;
 	}
-- 
2.56.0

