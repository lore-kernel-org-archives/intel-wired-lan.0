Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C54606A331
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yNkLykJi;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+8zgTGW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 902C44055C;
	Tue, 17 Nov 2026 16:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jcnE_k1p6q69; Tue, 17 Nov 2026 16:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06035408D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794932942;
	b=ReHC5zmttlSVBJ+e7QaCmNiqPlHZvgwuKNhmiR4pBOXSczckZAlLvOIY46xSDBiO6/RH
	 1yZp1bEn3P3nzts04NHHOUJz5V96kWBd5PNYUxKPnigLoK4Q/28UiY4IgE/sjn4H/b6dU
	 RBgy1u7M4x8T0E7SSYdDlpoBw8tDoAFMHiLbpHYInbC27i7oiWkCc8GpJtubghe/tODOt
	 YnFe7jogoAqZQ88ruSIHw8fo9LBA1mYWAkgBS7yF9FrM1VcZUJWD+mIAFrmgWs7sbgokx
	 CjktKkXpclZ0I67Ya5veLzYgpJd3pN7wA/Ttmg90zKd4Zakk4ajpFLh6SNYyLRefgOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794932942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hLTAdn75m/X1XOgHCTgJs4b9yJPhm3jmCX7SAzPgrq4=;
	b=n+90JR0+1zySkvjvu27x+Od3ygz0ZTpFFPjwlA6T1yzx+qN1UzInwTlNVXsCHGhqDSP6
	 seq7I+iB68oXqAL+ljzafnRC2ntFkEopn3qiQD9mJJgbTFxJaE2IyuE49eJJAPbzuyjGy
	 ljnGdj06stSNTF3GW+z/rGZUkIl1syhs7ABmUtWqy2j6ENR30cpLtjnaInJ3oGym3NY9q
	 rKPH87fyd/DEylMeGY5HFTE3sNcThLUlbjnyVkT5/B/k+X/5aHU56fSKWNjomOWh8GZvz
	 A693VGDtmZ04PcbWIhao/wfYznApOP0QI3G3xwItWHsqwtWaJaBPplKbaLI6OcUE6kA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794932942;
	bh=hLTAdn75m/X1XOgHCTgJs4b9yJPhm3jmCX7SAzPgrq4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yNkLykJiESEyKW4OI4FkN/988VbqroGjwcZo/lOIz+ZZ6Qzn6G5jYVU3KSHWdDQUm
	 VWStu9w/gHmiQVqH/eSLvtNj/jWCmN7xSpxJS7j+VbdCVgtIBuZ5L+Vi5dms8WEWUe
	 LNnMFX3fz8V6foo7XOF7gvVQpKFBvNUeTMb3c6qXmUXy7QdRNtqq5A5S9gN+skkLls
	 NS7uGNj2fVKjFURlgCpf9b2OIce0Qydb9tHMGT4emy9iGkX9+4hVvK3bgqOg2FsoG8
	 hTz8P1ttQxsNxf7dEsh7jcI2lyGnWOy639AxKSPgEFVf/yNHFDNopw9UcH5RtI3uJF
	 VqOtpBSEWLxUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06035408D1;
	Tue, 17 Nov 2026 16:29:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6414D13C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 03:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5615C400A2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 03:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfimXuKT-YDt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 03:15:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 85F0940048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com;
 envelope-from=lcy8047@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=C+8zgTGW
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85F0940048
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 03:15:58 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5366ae57896so49030111cf.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Nov 2026 19:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794885357; x=1795490157; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLTAdn75m/X1XOgHCTgJs4b9yJPhm3jmCX7SAzPgrq4=;
 b=C+8zgTGWmAYgnZoKg3WTLd0FFAIdHG2ruy6JrTjiMrKSztxhFWYB5Dod+yO53Bl8Ri
 ZweDY0MO3YFMuR2PYWhxjV7yRsVy3RUt7iaERhJGbcsac/KIix6/howK872lCWeqeLPD
 t7mWXeS5yS63kvBGhpKtXJkW1nB0WIC4w+0RbC96fWZhcQlul7SWPJb568wnty1qZ3+D
 RFom0qa/wmCutujyOPt39wMJuLvqK4ZqaMGWBeBIX5CZOmFQQpXkRbsryhVrHJKDlXZD
 s6k5Z8JNIO2LAvFnSHrf+I97eUDC8B1YZ0WCX2qAeSTT3Q+KaXWD9jGGAo2DurG++jmm
 rsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794885357; x=1795490157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLTAdn75m/X1XOgHCTgJs4b9yJPhm3jmCX7SAzPgrq4=;
 b=eZz1teN/LAyD8+mnF4aMSokP7AGRligoCdIq5M3hlrF89zBmMWBhFbDzXWdMhEwnT5
 SdL1WL0i5AVdjkpdRB8N+yWS5LiQqEgkYTeKhtPmdzNIxI5iot6CUtCpNtcCjK2OsxsG
 B+SWgft0GsnfWDVTEAkYJSs7vmxVK6puoDhA3v5xe3hYL4nD4v8dvNT4SXV46u9WYMIv
 p6qnjKd4/lt8rc7Gd1sR6g0TH3aMNSIAgl7RS1d+kap8ggDSuPNvUVmCv/dpnOvbRZgT
 i3KXmTo6r1SvEYvnyIINE20HNATIMtBz+CtK73p0eW2Btm1QjPKOQRVos2TaLiG47WjE
 SE+w==
X-Forwarded-Encrypted: i=1;
 AL+hErGHRqnFgR7rOI6HIUriQHXnIdB4qj5wOKlQ/JxaktDOdDMXf1US/asetQXWzlZmFDTzoAPDwTdXCirRQNax4Os=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+007ov1UfcNXEwEbUYWcquqSYQ4ROz5JRZOjYMDACMqLRrR7E/
 PLhx7lW9jzMgEpqdZlWhKoDrCG84yF0XumEUsLgI+ZeDyZRsfaTLJyDt
X-Gm-Gg: AYBFou0rjzkc2586KM5tLNikBuCvBnRuaIPlhtl7zpWerTuSkmlH1XcmSVEDU2aT1LS
 0pigVohT7yyMeHRnJ1e81XSF9bg6cGCeRAZGMVdKrJ1unnAn6eO3uXG/3dY/0YV/cEdb5qFcvAV
 X7RdG01AOtPQHGpV+4QIcSP4V5ot0dqc3ynqS3h/9TlbsvlWAWN3x+t4TDoPt1unsXWsVePjYED
 NUYPO4wt4TK3OrInfixr4XL9+RPotKaRGEwwgAIElGFHeVt1pS9f2GKQU3VyoI3Jp+7ByCiJ65z
 1UlAWAlLtuy903ZnzP73Uo4aRZSV6NXTYNOwl/jUbHuFu0J1FTZ0eBduI0L3CFNZGh/nAA+NZrD
 XPGMUpeFV96tVvCQrdIFsR5yD8kxS2eE6hxGxE/sCJLnHrTw7HEw45VB9nmfAHteP3ZlqdC9eyM
 62HJ2odcshk8CAKpbCvuYSWfGF9IwvaRFVKpCwJUG4+qXJ9aQp43KPWHDLAM2L40O1OW6wuuCxl
 rbE8GHW1TSp2eSKkXHRfv2rnI+/0UXbbKYsTwfjhgse0zY0+k1T/YSgkSsSpaG/GlL9dAESBHpv
 7X0728kxl7uuDJOksb+fcGpFJ8lWCl+Ort3Aq3QiY6eY7DJsWAMRwE3Uw1D9YgtMHLe/qIlrBI5
 FQ0L6qXE19JGjorCiDC2O
X-Received: by 2002:a05:622a:14c6:b0:55c:fa5a:b232 with SMTP id
 d75a77b69052e-55cfa5ab3b2mr121881541cf.4.1794885356928; 
 Mon, 16 Nov 2026 19:15:56 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23da64c1sm99291826d6.37.2026.11.16.19.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 19:15:56 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH iwl-net] i40e: hold mac_filter_hash_lock while validating VF
 cloud filters
Date: Mon, 16 Nov 2026 22:15:53 -0500
Message-ID: <20261117031553.1728084-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:29:00 +0000
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i40e_validate_cloud_filter() runs in the VF message path, which holds
neither RTNL nor vsi->mac_filter_hash_lock. It looks up the destination
MAC with i40e_find_mac() and walks vsi->mac_filter_hash for the VLAN
without the lock. Meanwhile the host can change the VF MAC or port VLAN
with i40e_ndo_set_vf_mac() or i40e_ndo_set_vf_port_vlan(), which delete
filters under the lock and free them in __i40e_del_filter() or
i40e_sync_vsi_filters(). The lookup and the walk can then read a freed
struct i40e_mac_filter.

Do the lookup and the walk under mac_filter_hash_lock, as
i40e_vc_add_mac_addr_msg() does, and do not use the filter after
dropping the lock.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus PCI_IOV, I40E and W=1.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 74b6c0ed8480..da1f1a9c4124 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3624,9 +3624,11 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	 */
 	if (mask.dst_mac[0] && !mask.dst_ip[0]) {
 		vsi = pf->vsi[vf->lan_vsi_idx];
+		spin_lock_bh(&vsi->mac_filter_hash_lock);
 		f = i40e_find_mac(vsi, data.dst_mac);
 
 		if (!f) {
+			spin_unlock_bh(&vsi->mac_filter_hash_lock);
 			dev_info(&pf->pdev->dev,
 				 "Destination MAC %pM doesn't belong to VF %d\n",
 				 data.dst_mac, vf->vf_id);
@@ -3641,6 +3643,10 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 					break;
 				}
 			}
+		}
+		spin_unlock_bh(&vsi->mac_filter_hash_lock);
+
+		if (mask.vlan_id) {
 			if (!found) {
 				dev_info(&pf->pdev->dev,
 					 "VF %d doesn't have any VLAN id %u\n",

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

