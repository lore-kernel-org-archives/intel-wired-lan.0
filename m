Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF2606EEA8
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UjwiY+GG;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmQTiN4/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19752406AF;
	Fri,  6 Nov 2026 12:11:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2Gk8S4XAsAz; Fri,  6 Nov 2026 12:11:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7CBC0406CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967082;
	b=VCqNctatWxJkWNKKVr2Af7Q6UgNoUJkbDMDEOFrQFspV8fT1wxKURa/P7RpM7LpI/5mv
	 fnU1mONS9jfjk212o0htsJ3qgrmPBYClPp0FO6kAlKo4WZ/CQkaJNumezqiIBML7CzYc2
	 ZDrNP90TCS2RoJ4bO9PluQ/jtxrSVpsbZwtNlHUxoUN/ug0xm7sCB3a2tlwbdwz0Z4p4I
	 BoYHak9lg9XX8+Xr6xcbaRg2KSYU0KcL+3SaIQrEyE+9um88Amn4nU4qsYV+Y6H4a7CKK
	 P3p/AQ9v9cywtxic9JvNtqbolklBNCjvnnwxUf8LvcGFdX2A8G4O1ik6srf26YopQ+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vSoK9k8Jjl0Fge7FipT1654PSTW1jRBxZt2UfEkmOE8=;
	b=FUndSnGGRTYQae++rXmIBHl2UrvxW25nEV2xmOeG/Eh/El5YUjS32m0+xQVrrI5zVRZf
	 UyiDiiKgZYBq/IJ4VlNR/PqIRjUBs5iAERky58Sxispos50baHHeP4Uj71+EJCEyjxfD4
	 ryw/4WaIcc5S/qpVd1tuNPnPWPc4LX0A0/DZ10jCewdTZTFaJExtNE3iDT7UtUQXd6NuT
	 BOL4inxt8HHzjpkxqe4nPiOl1iSNfZge5UC4VmmZmpxQ0gUWzPyZ3Q4QEMI2YjSFCzh2O
	 fBXzPOd/2mxqfVr0uXrkFxq53Jz3qHSyE178x1moPAkgZ7/qmytmI+jdY3qEQ/+Om5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967082;
	bh=vSoK9k8Jjl0Fge7FipT1654PSTW1jRBxZt2UfEkmOE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UjwiY+GG+15xFPh99d9mFNIVA1JfREKZqrWAux7XBBPaDAcm21j9okPkerb6i0Dyc
	 6Ce+BbTJw62ZHQ3fxLckLFgbhg7ptLc8oZ4+mqePNwCvcBqfBA+lnoq7oJHPe+9Qwt
	 a3CKZkz6E3AlLENlYyMlB5onwDt1iiWj+/3pcanqiOO0JIrNSHmbjyv7ko6ynn0TQu
	 73WTb93o5vK9RjaP0ta66gllYqgjQaYNTwlCvaekiA9Jwg1P4itgvcVHHdxT/0LX/W
	 muSoNp5btO3wBhFV093wOOG949TaxW1yUtDWFiduM54xGhuzPptmLbo71ilanDMDiH
	 eiMlEV4ylmdEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CBC0406CF;
	Fri,  6 Nov 2026 12:11:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1196A362
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03DC381211
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZMTnFDXPWhwD for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:11:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3359F8118E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmQTiN4/
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3359F8118E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSoK9k8Jjl0Fge7FipT1654PSTW1jRBxZt2UfEkmOE8=;
 b=RmQTiN4/F8/Ol31oQRXQXwhEcdVdf2wqQQ9/67t7V1IvmpJUZ5Dd5RxFZ9tFofD4r+flQw
 hX4TFvDRf4cjvs5KU0J76LRMIMakxsl0ElHOenB6pK/6Q+JpO4LLLSDZ4Nmy27WSb9P03v
 GpfY0b/VO92KaqnCF8hdp1wCuRxeXwo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-C4dsfAmUOR6APzuVeSqlQQ-1; Fri,
 06 Nov 2026 07:11:14 -0500
X-MC-Unique: C4dsfAmUOR6APzuVeSqlQQ-1
X-Mimecast-MFC-AGG-ID: C4dsfAmUOR6APzuVeSqlQQ_1793967071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 783D21800576; Fri,  6 Nov 2026 12:11:11 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A537318001CA; Fri,  6 Nov 2026 12:11:05 +0000 (UTC)
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
Subject: [PATCH net-next 09/10] ice: dpll: update locking comments
Date: Fri,  6 Nov 2026 13:10:04 +0100
Message-ID: <20261106121005.1327603-10-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5uWdn8KCXKB3c7Ej8-yHqZxiowWz107NO7V5ArxIhLI_1793967071
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

Callbacks run under the DPLL core domain locks instead of dpll_lock. Note
that callbacks of pins of an external DPLL run under the domain of that
DPLL, so only pf->dplls.lock serializes them with the rest of the driver.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index d6302409a2dacf..07cbd4cf0160ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1178,8 +1178,8 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
  * peer via dpll netlink learn about the update.
  *
  * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
- *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
- *          still held by the dpll netlink layer.
+ *          released.  Uses __dpll_pin_change_ntf() because the domain lock
+ *          is still held by the dpll core.
  */
 static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
 					struct ice_dpll_pin *changed)
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 4ba76e2e2e0b01..39e041a30090d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -165,6 +165,9 @@ struct ice_dpll {
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
  *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
  *     to avoid recursive locking.
+ *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
+ *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
+ *     so only @lock serializes them with the callbacks of these DPLLs.
  *   - @txclk_notify_rwsem is held for read across
  *     ice_txclk_update_and_notify(), including the out-of-lock
  *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
-- 
2.56.0

