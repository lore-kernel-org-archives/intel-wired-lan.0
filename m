Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CC2CA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40A3E8130F;
	Fri,  2 Oct 2026 13:25:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW9-ADxAK6jM; Fri,  2 Oct 2026 13:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9CFC8812FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947547;
	b=hCjLl9d/ypn5DCF1UXpXeETwyWJ+vpPCs1nD4YYIxRXAtuF89NcimtiG1M5RcCiX/gj1
	 2mwC2gmQeqTpDAfx/rShbRqXr7hAs2PQktb7aQHZO92yZfebgBCLSVvCe1+ig7zcomAzr
	 xgNl0ts6GJqKEYjQd4ycTyjBmZHMRHDam15wjycMIWMfVzdpWs5BXK5HcFd6kWn85nwKO
	 Y87gjXstjMyUdnmycGg3ig9jGZJzeT1G5oiKGUhn+roPzobgIED2VHEO636UqmYBGDQM1
	 Gp4phtbOxlYpXf27ALeZKTqaTMLtT9o3VHz9YzIWNdiSKVd0Nm54IWRkQPCvdG1ucjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LQtzdWNTV0tMfsyTkPk+NOiHXf+br2RgeU5G2y5qWNg=;
	b=LMMDJgNJoJupgzzQeMi+KwvgBNH5MZx2PZwZZhBpLxUACEqDNCHPq82vuOvISlZfQ6d1
	 EeB0xZcray57IA0W9e/52AhPqQSn6WlR4PqMxOsGE+/gpROVh5y6kYLQtwu925iRRVJwN
	 WlErMih9Vhe+WOudih4qGP2Y+biX5kYacoyeOg40TO8qOzEQqzUTCNaqISgDvxdA7bpFv
	 9t+8EwrsoOI2cF/XAH0xgGIiz1gbmN7Agb02uQ1UbCq5ZrcWjNiuFZXDjG7Qwf0R54y0O
	 DwunYf8b9phNIwXBIMbPoqYj482kCDNnWCCuCtIOtaaH83437j5MNjKZM/pK1gmwIPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790947547;
	bh=LQtzdWNTV0tMfsyTkPk+NOiHXf+br2RgeU5G2y5qWNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UI9CK3CvPnZ+djinBW44qEQgacNG3VHgmf41r5xLS29ZO4rTiE89JLtCrnIs+b+ff
	 s1E2AQHlpLC0Ys50PIeTaGo2+JcqnvI68g9hb2vzeHCoCy7k4k5Si6X2DdGTENsxWK
	 DTymDbz6G/haNuRYg2I8sj5WrXUIgfLXtaE968zQDUrT2HkX5/4JDxXI7dl1g503Xz
	 6Cvn1OBMRzMXlzsZdY325ARQPHv/RXaejh4WY2i5ZdXXyb4Ai9/eektRcU0BSIbwnA
	 59oZSxdhwtegN2NUCP8zNHLNFIqKskL/9waQfkDaxRJlN+J3MSZJWTh6kpwv7YmLAM
	 detheeKjwK74g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CFC8812FD;
	Fri,  2 Oct 2026 13:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A786282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C5E1400D1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFs4ZW65AELg for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E5E334004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947545;
 b=DkLbcNQGCU/0rlOAz2HPJdYyF1TaGcAEgFOAYvvCTW8qSF1Qzw9FfKrmiZ2ibz1nCGAd
 9xlTRRhwhm8PWiC27mhdLPlHKo86sKH6wrpV3xDTZAZBSU6chCEY2iiSoZLF0WqlIN8KV
 Uaru2tdEw14er3XFt8Uv/maMxe9SUc32zlcCvrIItGh66u9wOTzFTBBxPJw6EG9bMHcgm
 hAUX9F1Gvd2ifB1GfmOW1cjsm9FYqFmtrYNYzitW/C92TrnuH2qd3VzlBrTUKJwhM5dUk
 b5JJZD/GuVR2eJRmFRpXkcOp4urQDlnjgz0r6yN9PiLBc3BammCe0/dhRA3ccdplxZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947545;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=LQtzdWNTV0tMfsyTkPk+NOiHXf+br2RgeU5G2y5qWNg=;
 b=enpht+G+2Q1DEFwyqGjN2pZ5c9BA8JE6dRFTC7B3PWRTFbi/OiyqNW4gs8gzj7w8NiyS
 4yV3VqVspMzviftK9ezla8Qkll8rM6HowbNXM7dpQD3SiJpjCcSXHLlxyA8N1ySavAxn7
 Xk3IFYB1r7DrRBFXTNJAr8KVb5ziMoCSmUys7hN3jckIf0f01hrFwebw+VgMAa1u3HvDJ
 bY8XAWUN2BYSsSSjyck3KJwY0ElzsyTJ2DSefcCrCmq15yRI+HZmO/ev2nr07htqeRbZk
 FzKHX3cF44S9Cq3UOS3mSTx1vCE8Lz3Y0iSmKL5rwU7IcjjJxryzj7wbtZIAQoi/xEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YzVVM9Dg; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YzVVM9Dg
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5E334004A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790947542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQtzdWNTV0tMfsyTkPk+NOiHXf+br2RgeU5G2y5qWNg=;
 b=YzVVM9DgBYkjoxselYUw4N4d1On/xKZxUji1jGbXk7IQv2HZBO3Of3vqKOeNM8zo5DdBFI
 p1uv5Kjk25fvK5udUfDRYWUg4G4iudjmtdP5PXIxibycoQ9D/bvn/wDpHV2OmN+Qkz9qK3
 KN76VwdYQ9bL3t74n65WvEMFExa8HtI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-ax1nOW4_OsmLAF3LTgxXcg-1; Fri,
 02 Oct 2026 09:09:08 -0400
X-MC-Unique: ax1nOW4_OsmLAF3LTgxXcg-1
X-Mimecast-MFC-AGG-ID: ax1nOW4_OsmLAF3LTgxXcg_1790946544
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06DA618F5292; Fri,  2 Oct 2026 13:09:04 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4825433; Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Date: Fri,  2 Oct 2026 15:07:51 +0200
Message-ID: <20261002130752.2597259-10-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: V_VwUraf3cCSN4rRvrpAzmAQ-ZsZXG9gF8LeTmotd1Y_1790946544
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Since commit 5b246e533d01 ("ice: split probe into smaller functions")
ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
frees pf->vsi. ice_get_main_vsi() then returns NULL and the function
returns before it sends the Manage MAC Write command, so multicast magic
packet wake and keeping a locally administered address across the PF
reset are never set up on shutdown with WoL enabled.

Program it before the netdev and the VSIs are torn down, as it was done
before that commit, so the current netdev address is used again.

i40e had a similar problem, where the multicast magic wake setup ran
after the admin queue had already been shut down, and fixed it in
commit e661414c98df ("i40e: Remove duplicated prepare call in
i40e_shutdown").

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ceb9fec2af21e7..a885b3e0baaa5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
+	ice_setup_mc_magic_wake(pf);
+
 	devl_lock(priv_to_devlink(pf));
 	ice_dealloc_all_dynamic_ports(pf);
 	ice_deinit_devlink(pf);
@@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_deinit(pf);
 	ice_vsi_release_all(pf);
 
-	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
-- 
2.55.0

