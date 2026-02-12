Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B929EDF053
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 07:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6B3641D24;
	Thu, 12 Feb 2026 07:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8Q7raLxV_ce; Thu, 12 Feb 2026 07:53:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C804141D2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770882812;
	bh=Ut8Fsw1R4tT50gfU2dQi99Xi0AipmBKvrl6DGwx0NTU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Xp8Feb7LUqkeQ5hB7CjHb3RCFlXmQVSxI59AgXH8KiJxp2qtqPWHa3PNWk1BpMkbX
	 rdWojq27S7fjY7cNeFNVht/WRRlPrRLiogzDibAWygXkuUfbQn+oP3EN3p2k3JeCXJ
	 +hFQcNsN8rYNsLE/3oWs/04Gu52Rx8qWVzvmweMJG3Zhv+YgBWNa8fSueDkOX8J8xg
	 gM+7PSFE0L6Vrj0POfFCHXeKjgHILLKRqG8ZK/+rWbn1drodw2pkgvok0irm6py/e4
	 D7wvYubgJ0AeVTvXPJYmuZoOwULP1cXHQrwdGKxft7JlnmZjW7n2+k536ibOtF139u
	 wwz7YeZUPBOhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C804141D2B;
	Thu, 12 Feb 2026 07:53:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F0951F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 07:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D813611F0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 07:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x00nmGofPxhE for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 07:53:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 20440608DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20440608DC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20440608DC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 07:53:29 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-g6NO0SaEPuKom6REr-TJUA-1; Thu,
 12 Feb 2026 02:53:27 -0500
X-MC-Unique: g6NO0SaEPuKom6REr-TJUA-1
X-Mimecast-MFC-AGG-ID: g6NO0SaEPuKom6REr-TJUA_1770882805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2DE118003F5; Thu, 12 Feb 2026 07:53:24 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.184])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B34A1956095; Thu, 12 Feb 2026 07:53:19 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Thu, 12 Feb 2026 08:53:10 +0100
Message-ID: <a76096058dd9b6d0cccaa5c2c699458351d02cec.1770882260.git.poros@redhat.com>
In-Reply-To: <cover.1770882260.git.poros@redhat.com>
References: <cover.1770882260.git.poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: lu8gutjcY3xA_ZS3zCVxAmOoQoO2b21umPJ9dntdDyk_1770882805
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1770882808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ut8Fsw1R4tT50gfU2dQi99Xi0AipmBKvrl6DGwx0NTU=;
 b=i5ypynOdd3aP1k3ZOyM0/1XQaCv9RkbiTVGdG2udoa4YEQm9JpSpfRlfpcrt6kI4AXC32C
 hDEakIQDa8UmrbfCNKREXG159PtVF93eZ70+c2GzPs7FMgRrJsXxFYsidyuT6T8RjK6g89
 D92ChDj7l8dNIf4+Yu5cszKKjBfISWE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=i5ypynOd
Subject: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: fix inverted ready check
 for VF representors
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
refactored the VF readiness check into a generic repr->ops.ready()
callback but implemented ice_repr_ready_vf() with inverted logic:

  return !ice_check_vf_ready_for_cfg(repr->vf);

ice_check_vf_ready_for_cfg() returns 0 on success, so the negation
makes ready() return non-zero when the VF is ready. All callers treat
non-zero as "not ready, skip", causing ndo_get_stats64, get_drvinfo,
get_strings and get_ethtool_stats to always bail out in switchdev mode.

Remove the erroneous negation. The SF variant ice_repr_ready_sf() is
already correct (returns !active, i.e. non-zero when not active).

Fixes: 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index cb08746556a670..2a84f656405828 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -315,7 +315,7 @@ ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
 
 static int ice_repr_ready_vf(struct ice_repr *repr)
 {
-	return !ice_check_vf_ready_for_cfg(repr->vf);
+	return ice_check_vf_ready_for_cfg(repr->vf);
 }
 
 static int ice_repr_ready_sf(struct ice_repr *repr)
-- 
2.52.0

