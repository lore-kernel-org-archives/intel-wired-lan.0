Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419F60A3811
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=B9rAyULw;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ADkhd6Xp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D52E60760;
	Tue, 10 Nov 2026 09:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oM8qnSDx5p0w; Tue, 10 Nov 2026 09:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5082060768
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794303856;
	b=Uh6AvUKwTq7KM/ZmRGqqNjLZ2oSH4FM8qOXCBpwd1FT6hTT0Fzko9SHcVH4RLLICs2i4
	 rdabKAfsor+91tAZh2RvjBUULSspSEgOK8rJEuk7slfs+f2h3lK9wYQHK1Smj9OImuYOA
	 6tTmRcEhqyPqpMFK7U0x09lI/S4i0UX8SxDxRMLc3p8ibKDi6kcYVzEB0EgqL1HGQjk6H
	 zakeRD8cUAASDYfXaceNOBYgs/gsKfUDtkJk5/S9/ItXL9gobH3dmQKqmclW/O+JYQe8P
	 OddzpHv3sr1wWqxHuPiKs8G0/5xcehVHW1/qd891D5WvDuR/mhq84nUZZWez8sD7eUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794303856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o4T17MbHTeQzZp8NC0qUA3fYEjHxMSXAptJLm7Ag5Fs=;
	b=pJsdUYAVwJ3MY1rna6DzIJ233KCwkx6x2bK4tTfEr/CRu9MeW2aVeSDZ6eCeauo8GS2P
	 mrrHX+Pwas2FCbCllx4mz6aHPikNUSGJlaWd0tDFARM0N9bcd3NYSLT7t8RzxI+fy0OvZ
	 I8OebDTSbGt3ZTtpo9VO7ViaDXURRKYSTfUpJDogu159YLxkNu6jKPefi+7x+5jhr1lby
	 0ELz8sMuZ9SmUrW9geYFD6qPJ3EUwAlnRLtqGK6/FaFCk3P3yl/0belDjT+/LOGOylNsH
	 ssdMnk+ERqOAXMP+gW96PHqzw/LhRKf8XBmEwXx0cK9FT5eUZQWTV0/lZqPFwG7EINQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794303856;
	bh=o4T17MbHTeQzZp8NC0qUA3fYEjHxMSXAptJLm7Ag5Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9rAyULwMRMsI2NPyom2RjtsPNRqqwyAo/8JxeHfHehCfmbg1Joc6EezLmOYs4+mo
	 oq3z45dswHWTm8IExzIIsL9xDy8cp/cIXg9nof7N6dYSFDxh2HArRclSkmIkMEEmGk
	 6yULIzgg6A4R8muR7Yw+SbpHXgFgjXHLUneo5DF3iU45L0ol2EbpYucXUH71WmUS0z
	 MVvZG+5PIhNFJoG3QWz/pOk0GtaDpKCyo/qwveq+czTrkrh/XLBUvMVgAuUNnm3EiB
	 ZC/vk7nEIl8HEfpcbNA8gvw75X2n3fch37ts3qITHcu9RCUKLW/8WG34RD6+P4RgbP
	 xlWqOS1Zm+GMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5082060768;
	Tue, 10 Nov 2026 09:44:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D70F4B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13EB5810F2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbQycpuvObc2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 09:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D59D80DCE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ADkhd6Xp
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D59D80DCE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794303852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4T17MbHTeQzZp8NC0qUA3fYEjHxMSXAptJLm7Ag5Fs=;
 b=ADkhd6XpnwkkoQshXS3eZ7F8WNHD5ZaOZFXLpOdOv+GuCwSF9pA6VhpVGnSBbP1dpiHs2c
 qFbVnI7nkWlXJkBV9GFk9Ixs/PPJV1vIe6FscsTnduYPuV6Jr2DdsZxPhb6k3HWs0EZATi
 ARPrltZEpIJNPYSEPZ4fgTsx/uByJtc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-baJkrLcjPzezrI-Y_vi9wg-1; Tue,
 10 Nov 2026 04:44:07 -0500
X-MC-Unique: baJkrLcjPzezrI-Y_vi9wg-1
X-Mimecast-MFC-AGG-ID: baJkrLcjPzezrI-Y_vi9wg_1794303845
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AD841956089; Tue, 10 Nov 2026 09:44:05 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E33E3920B; Tue, 10 Nov 2026 09:44:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Petr Oros <poros@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Jakub Ramaseuski <jramaseu@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] ice: dpll: set the SyncE divider only for the port
 driving the output
Date: Tue, 10 Nov 2026 10:43:50 +0100
Message-ID: <20261110094350.184185-3-ivecera@redhat.com>
In-Reply-To: <20261110094350.184185-1-ivecera@redhat.com>
References: <20261110094350.184185-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: wK1u4Q0fjOV3jTkcenFmbZLKowp-3r5McgJLR8_xbgI_1794303845
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

R10 holds one divider for each recovered clock output, shared by all
ports. ice_ptp_link_change() sets it from the link speed of its own port
even when another port drives the output, and checks the mux only to
decide whether an error is worth reporting. With ports running at
different speeds, a link change on one port leaves the output of another
port with a wrong divider.

Skip the outputs that the port does not drive, and check the mux under
cgu_synce_lock, so that another PF cannot select its port in between.

The check computes the mux value as port % ports_per_phy + 3, while
ice_tspll_cfg_bypass_mux_e825c() and ice_dpll_rclk_update_e825c() use
port + 3. With the skip, a port from ports_per_phy up would never update
the divider, so use port + 3 as they do.

Tested on GNR-D with dual complex E825. With the RCLK pin of one port
connected, five down and up cycles of another port of the same complex
called ice_tspll_cfg_synce_ethdiv_e825c() 20 times without this patch
and never with it. Five cycles of the port driving the output still
called it 10 times. Both ports ran at 25 Gb/s, so the divider value did
not change on this setup.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 10 +++++++---
 drivers/net/ethernet/intel/ice/ice_tspll.c |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 449819cf8c8791..81565bbb692e9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1350,6 +1350,7 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 		int pin, err;
 
 		mutex_lock(&pf->dplls.lock);
+		mutex_lock(&pf->adapter->cgu_synce_lock);
 		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
 			enum ice_synce_clk clk_pin;
 			bool active;
@@ -1368,16 +1369,19 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 				break;
 			}
 
-			mutex_lock(&pf->adapter->cgu_synce_lock);
+			/* The divider is shared, set it only for our port */
+			if (!active)
+				continue;
+
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
-			mutex_unlock(&pf->adapter->cgu_synce_lock);
-			if (active && err) {
+			if (err) {
 				dev_err_once(ice_pf_to_dev(pf),
 					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
 					     pin, err);
 				break;
 			}
 		}
+		mutex_unlock(&pf->adapter->cgu_synce_lock);
 		mutex_unlock(&pf->dplls.lock);
 
 		if (linkup)
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index b99e02cfe559bd..0bfbea43529523 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -746,6 +746,7 @@ int ice_tspll_init(struct ice_hw *hw)
  *
  * Check if given port is selected as recovered clock source for given output.
  *
+ * Context: Called under pf->dplls.lock and adapter->cgu_synce_lock
  * Return:
  * * 0 - success
  * * negative - error
@@ -774,8 +775,7 @@ int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
 		return -EINVAL;
 	}
 
-	if (active_clk == port % hw->ptp.ports_per_phy +
-			  ICE_CGU_BYPASS_MUX_OFFSET_E825C)
+	if (active_clk == port + ICE_CGU_BYPASS_MUX_OFFSET_E825C)
 		*active = true;
 	else
 		*active = false;
-- 
2.56.0

