Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36B606A33E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KMGvc2a+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7+Lm41j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCD5C811A5;
	Fri, 27 Nov 2026 08:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgTkqfodWSzE; Fri, 27 Nov 2026 08:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38445811E3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769868;
	b=fsNaCVKO2BaKDMdqqntx9XPNjxfuIhtHMZqFQopu+Ryp36gd/TsNGug6X9h73Y1uMsh7
	 kA22rizkzrSdj1g5ikGeXBO6sXYO6cQTxeLwEKLRIWCV2B5AMnhkhnlc4dDT5GXInhcDL
	 lSHqv5dYww3VNv/XgAyGowfuAkwyjcUAR8geM9xiq9RS1Hu7ZxG4TZhyLNKQ+a7iGREsX
	 MhlnLRxqT/fbFYehXz4r1moUwTKyTd5kET3Tfl7w50W75TR5/22wyat0QY6ZfmoxPnEq3
	 QUfxw6gmIxA8A/ifW6CZ/LdAPO55BHXr8PKiNacwQWp5s22wT6mDfp9pPuvPM0ugf1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/CZufDeWEyoWh6oaF3NNHG6Jv0YRcvv/UprgE0HwBNU=;
	b=PX/DY+mAE0XulX+BSaVJNAsmOwWvwbOyOG35W+CouShLDosdJ48j8r+Uc3JwIQPLCdyG
	 NJr4ZMYhJJTMWjMwvdLMMTfCTQ2UwfaGOthlvYx4EbXlr2xlg7FBP76SOVaHKo9P+z6fx
	 08S8MSN1S4eTRiqbNergCde+HE4rEVR5iMh+iBGZeqfqWSsnFt/AgnMwqBKk5u6TtkO4+
	 jrZThb9R6GmJ40f1aBs8mxKgySPxNbYA42PEmhIJJ9gAzb9Fv3tGu6bBSMoNhkom3qnW7
	 jrOSz32knPUS43CXh0XolxuughJwYxT7Dg8ij6NJ50D8Ycx9fsS40OfTKMrC4hR2ZvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769868;
	bh=/CZufDeWEyoWh6oaF3NNHG6Jv0YRcvv/UprgE0HwBNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KMGvc2a+o62lL/VASUR+fKQHtK/AZMmVVyrw71uhRvla+1tYB1TQ9xHJ58iNmCHjS
	 3kZKnizaGtSRgb1eimVKgNamZmuh9rGCpLMieOAtoVsbT5jrC0i+bq0KqZJuOoc3Xz
	 daWoW63esMwJhTZHStDlLr89O0KJOrUZJgw6afVUjM8S5B4VfwlMDKjv9eENlvEWgy
	 G0EahsO+NaqGqfhtwExExj/2+1L4kQHZGgtdZ9OnuhBscS4+pwmF2Zrp8ipLn+HqWu
	 XCBB/O+lxp8BqtFWwISAwL/oaPJaaNgBRGg2OW+7MjB/m6uhTYEMvJySmw9c9rCCjV
	 EsIItu+QNlHXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38445811E3;
	Fri, 27 Nov 2026 08:57:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D303311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E55540A3B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYGSGL16AHQ2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E7CB40A36
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7+Lm41j
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E7CB40A36
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795769866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CZufDeWEyoWh6oaF3NNHG6Jv0YRcvv/UprgE0HwBNU=;
 b=h7+Lm41j8TiVxq+62qY57wzB4ZVBmcsEvnJZQJ0XnJ54dlF2eMZy95VBySkDjPUS5Kelud
 43qdohqdpWfDMYziGIHgRVnoTfc+jz/PvlWIQTm8c3T5C5DmDIFKhI9uGsJ2JWB6cxPG6P
 rF7ggLvlUc7Y8yJxOL0q3BQxUuOpqRo=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-JxyFEhGSMdWy6zwHoX7Xmg-1; Fri,
 27 Nov 2026 08:57:39 +0000
X-MC-Unique: JxyFEhGSMdWy6zwHoX7Xmg-1
X-Mimecast-MFC-AGG-ID: JxyFEhGSMdWy6zwHoX7Xmg_1795769856
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B45D1944AAF; Fri, 27 Nov 2026 08:57:32 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F21245B1; Fri, 27 Nov 2026 08:57:25 +0000 (UTC)
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
Subject: [PATCH net v5 1/4] ice: stop the service task before the PF is
 unloaded
Date: Fri, 27 Nov 2026 09:57:06 +0100
Message-ID: <20261127085714.1207361-2-poros@redhat.com>
In-Reply-To: <20261127085714.1207361-1-poros@redhat.com>
References: <20261127085714.1207361-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: ouvTtZzRJDipiJmPeuHmTpYkTmsH8kHHn-UOQlS_pqM_1795769856
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

Commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit
paths") moved the service task stop and the cancel of the AdminQ event
waiters from after ice_free_vfs() to the end of ice_remove(). Since then
a queued or running service task can still walk pf->vsi[] while
ice_remove_arfs(), ice_unload() and ice_deinit() free the aRFS filters,
the netdev, the LAG and the VSIs. A last run that takes longer than a
timer period also arms the service timer again after the stop at the
end has deleted it, and the timer then fires after the PF is freed.

Stop the service task and cancel the waiters after ice_free_vfs() again.
The stop in ice_deinit_dev() stays and deletes a timer armed by the last
run. As before that commit, a devlink flash that is still running when
the driver is removed fails, at the latest when its next AdminQ wait
times out.

Found by AI code review. Validated on an E810-C (FW 8.1.1, ICE COMMS
package 1.3.55.0) with a test-only 12 s delay in ice_sync_fltr_subtask()
after it took the VSI pointer, armed right before a promisc change and
rmmod ice. Without this patch KASAN reports a slab-use-after-free in
ice_vsi_fltr_changed() on the freed main VSI, and the kernel then faults
in call_timer_fn() on the timer function of the unloaded module. With it
rmmod waits for the run and nothing is reported. Also tested by removing
the driver during switchdev sessions and with four VFs bound to iavf. No
kernel selftests cover this.

Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v5:
- New patch. The uplink resync in patch 3 queues a filter sync when a
  switchdev session ends, and a session that still runs when the driver
  is removed ends in ice_remove().
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c97e8f1..6dede87b78944f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5387,6 +5387,9 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	}
 
+	ice_service_task_stop(pf);
+	ice_aq_cancel_waiting_tasks(pf);
+
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
@@ -5407,7 +5410,6 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
-	ice_aq_cancel_waiting_tasks(pf);
 	set_bit(ICE_DOWN, pf->state);
 }
 
-- 
2.56.1

