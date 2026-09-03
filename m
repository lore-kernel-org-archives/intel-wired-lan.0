Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D686C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 07:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8B16608CA;
	Thu,  3 Sep 2026 07:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKBYUqRBYGh8; Thu,  3 Sep 2026 07:54:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2DC8608A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788422078;
	b=OCR6573ZKSiLKA8IA8F9CZT24+OZ9tjVZKg4QAWA3e6bsuz0gmEhOHKD2eraYIQA/XHG
	 TytVfesw0T7ZaOlnywI5rWg32csewMq6haItspvngGQ8pkEgtsKnd1ydQA2MgwxmbIw58
	 lWBIj7t59w/Chi9aKRFKhaOXZZdKcTM62Xmr8Eqe7Ze+IHSaHl+yTgtMmLbtif93LFbQJ
	 TbouKY32NELsiyOcSxAbyQXItVvgijFehryCHsiBwDsfBgr5+GUVLAeYFXafzvCwhEgLb
	 luUsiMBdFUQXrvVLpezT2PxytB2VGIr4Cnm/aLqvcKlzSSVxa3VdzmhUreNIZd3d9vA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788422078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
	b=sLj+bxtpDTrrajJ1mxpwr7tXzUQybakT9BZsd740n6rr1N6kjb/CkrNpdmjnggUJP1TM
	 6W/BXj4rc+V3fZw4hXYf5Fiekiyj8T5ENTZVGwtGuzzg1Hx+qB+8pV3K7T/n6rTDd81vT
	 pAoQjWUjh7b07LFT3THEPYpvRdtfhjnrxEd5RHj5AG5lrkYCSv07QF7lIzOhsfiNydOhI
	 ymrRwQwBEgRZRsfvwD4l/Gb5t0E1G0lB8rkn2429e0at71OVZFnN9fuCqZfy0GqtZ4cki
	 N2nWlh7JEz0lWnCrTBXvsrnUFKO4KpUHGGdhcJA8DffL16NNktu589tsoMpMpuT9QPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788422078;
	bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5ky8MJSJK8pkchXqNq7GJhymzVqXryUsostO9p6CZkZD3vy0Pao/QkNA9Tu18Y58B
	 ZzfubN5+wPV22w2q/uNN9P6WLnLllBiboxPaDOII2/k6d73MCO3UKPrBprW/IFK+SD
	 9uMhgfMDh+RIHRjoDvcaMyGSDA01/BzYcpkSFv7yQKUmeH2msgTYfr88D4+s7dsMe9
	 /TlnB7Rx05YQN11q1orUgP5J3kexoONHxR94pQIBJOq2fzpVGoLqs3hvE5tR8I0naI
	 JSiqUVK+0j5IMs2B+UDTVEERpAj2kXepGmYFLNIj8ugpRIR+ur2GSNw6fzHcXVbUf0
	 L4MvdhfSsV7Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2DC8608A4;
	Thu,  3 Sep 2026 07:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80CFA34E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63C2B40A92
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZA08RQZ4m-M0 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 07:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 31B9540A8F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788422075;
 b=jy9w1DVapUkG3yJJA/bwZN+zOwKSrq1vDOSxRXFKSsfVPPqGHVTvxonvbswiEhUUse4g
 LVWkykOQwcdwOaWH8zBXAMXuh5I6yWP2RXwvlnZBKehoUibThn/byBK/c2xPDMrnLyqQB
 wbPOyoixt1k0cdbEb0m80ZSPgEnbLuvem7IfC5UDX+xX+gt7v3lPyJf/X81JPwQmvYFvA
 mxdRgIOVA51tPtNfCS/39MPWJ9ohcIuO7aU9e/E2cQceO1WBfCLwWxvnX2/d8X3BM/cIL
 +MCm7h3VR2RNDmtMVHJ70KQVRO3UCRS/j+tPvXSG1pRB9XyPgPPXvyJj8kX3UpmF0BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788422075;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
 b=CFskl4hKu5nyPMvpdHXTu4kJBt1pm91WbrLsUgNL6qGPcQqMECQh6kX/K0EJzTQFhwdb
 wq2jfZfJWhvUYjyfGAK3kAtmy+Az8hN2BbmgiWcUkyL9LVjBEipqWaGPLsXOZaw8l20Th
 bWG4mCM8PtcgoeRFEV6eOzQK0PHldfl4vAZ26LPe0nqSabqmkLUkp0HP7sXtNBOTHKHlF
 4q/14a35bXZVs/rTD8vjtZHOnRnilkgIRZb8UVBUccDj95Gm0/l6c6cQKY4ecF07FJNme
 aEbqVa5hsZbvwv10Iw2YlT6K8O5FInuJbyZvS37uZIih8nh1krCTZbdT4b3JPLQ22hg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=LXwRqazc; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=LXwRqazc
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31B9540A8F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:54:34 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D9B83FC0F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788421653;
 bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LXwRqazc2lQwPP2vH5bo0Q3sPj2vvqAd8xz8y0DH9m/8MxB1wPXD5vXkt2u7+tmVG
 82keE0XeAOKGewLSDRxUFboJTkLIzKDQq+rWtkozelFg0neGVFjnSB5eR7Khx3VvKW
 XhKn6cRUJ6iBaTyl+a2DfOyybvouuOUAcDmU+MxNNeHO2R6TxbkxI1NbnjnlJBHrWz
 XKwWsZrqwgUTuvBZSYKZRMFFCyOceFDbhtvvVuBLar8HXQ3Z8YYR/+C+pz9WjPFxFw
 qqXyyWK8/RcVwKwKy8A0st7esZ4KhLIvOxhacg/6A/Wa12E0kC1rJMZiUA8QcM54Ld
 bzznJL506n1wTiXiAmQQseqZsBOYQ6j3p6jjEPS/8fN6Dgtbbqgf4AKELKZXEKejmj
 tsOhWnHFoRXaXYQJcmD1/CxgkLUF9FrnNTozyEbu55CSCT2KHaO4jT6rUjeDWix0ed
 dH/BJ7rXOcAFZiv0oJ9qijTzwgNAnObzPonwl6U26aTBEEntwhgHPwmylEo6DQU4is
 +UdqH2iHYLj+FxOI3XW29qZfVmKzfTKJ/41hLnJCBKKINGdC5lchZxSTdlCtC5Ayb+
 96TqV1Iby9WvWrI4AGZSQEvgGuDis+R7MeRkT7niMKel/Ant5IBJg2RYYLsyA2tDTZ
 fPOgwgjLXz6XGNK27qV2veqI=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so2722844a91.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 03 Sep 2026 00:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788421651; x=1789026451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
 b=VLwwzWt3voIQfZmZ3daZD5FFYNirXdJF85nLCohZqkO+c5u4AiE0DFAhoKXkE1OibD
 1fXdXZ1OZqFNTb+8ywy+0jEVNI4lUdJ8ZKah06eQeOwkRu2YcCHWYG2aoBK7pSbwrV+i
 mNsfWkKn2smJLQ/zUBQReX3gdQbEawDES0OoE2b+DedJRHxMSDH6/qQ23tg/9NFamETi
 adlkxzoSMTNrL6NAvkesFBKy+Xzv+fYx6eCXRAJBRSjDVR980/cOc3V5w7DA0ZlVbOqg
 pynTnuViAv8qWXRsK6vqLkLi5o6W5/m/776ehpg5oGC/kn2J0w/tTwgBqyQVODxh0Mnp
 VreQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSDUHawB79Gy/ymnE+1FzBWyGjBJpu7dUruG1f3KlEd/Q2eZ/psKh1MAi6B1PtjiG8TOspv/jKIkaxFMux+x0=@lists.osuosl.org
X-Gm-Message-State: AFuF++lpthTlMX3rGMrWiuda8P/2eTI3CE59IGpjp0ujwPvOmkuRf2n3
 aQHLgpwIWybWbFE/+JctX9wrkala8Z/tCUfuAl/RbmC2hMejgBAX+5VSrEPXOX4UuqX0cIUTgRA
 nA1tWhAdDmvjYRtEytAFD+vIQZ9BpaSO7sJev9Hjrk3/LsyjjK9OXCgyy1huT0+7TSBFzjSFGbV
 J1e7zLiaDtcmU=
X-Gm-Gg: AYBFou3qvNHqKXEZIZwfkf6KF4D3NjpnX7sza02ofpFCbX2FYSmr4oMpgGnQKyBCfoj
 FmIjrs3Xw7ztkGYf0vbHTUJkRAsXh4ZPMfW901wmn6SOUSgio9enxkGYJF6/JuJ6pa9gSYs3l4f
 ul8jB9+ys8+wzAJ0JBNlVacmWD45ZGX7wPl5c23bwnJ+Zt91lmNynQeEkqkA6DGrNmrKVQmLzMQ
 ZM36DE20eJHz8DIS1TqvswZ5ePoUosBMRyo4igDl4mcxqJJZ1HamIhGFn4CrhjygbYeJgBy+2LX
 J/L1l1P6zt/Nisg+NDcSEZN88utExJNdh+JZSDAaK93lRLcD97L8aAyPg02ElWGDQjM6xqM0+UO
 Pq2qqs7JbnsD8VMFc+xjxcecplcb+6ipowg0hsjOZoZCoISzDNzAs9wH2ozhXFc7Glw+8gWxV0c
 cjwnhy4vKcurDnm4NfKuuKkxavP57T5AbzRskFDw==
X-Received: by 2002:a17:90a:ec8c:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-39aee04ace5mr17634620a91.16.1788421651491; 
 Thu, 03 Sep 2026 00:47:31 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-39aee04ace5mr17634557a91.16.1788421651053; 
 Thu, 03 Sep 2026 00:47:31 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae62a54f6sm2991223a91.1.2026.09.03.00.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:47:30 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Henry Tieman <henry.w.tieman@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 2/2] ice: clear Flow Director entries before reset cleanup
Date: Thu,  3 Sep 2026 15:47:06 +0800
Message-ID: <20260903074706.602087-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903074706.602087-1-aaron.ma@canonical.com>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Flow Director profiles retain handles to generic flow entries. Reset calls
ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
handles unchanged until replay replaces them.

If rebuild fails before replay completes, later driver removal follows a
stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
KASAN reports a wild access to list poison from
ice_fdir_erase_flow_from_hw().

The failure is reported as:

  KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
  RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
  ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]

Clear the Flow Director handles before the hardware tables free their
entries. A successful replay installs new handles, while a failed rebuild
leaves them invalid for later cleanup.

Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 21 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c4..4739ff882b9ec 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs);
 void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
 void ice_fdir_release_flows(struct ice_hw *hw);
+void ice_fdir_clear_flow_handles(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index aceec184e89b2..faa16b5a12c0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -428,6 +428,27 @@ void ice_fdir_release_flows(struct ice_hw *hw)
 		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);
 }
 
+/**
+ * ice_fdir_clear_flow_handles - clear handles freed during reset
+ * @hw: pointer to HW instance
+ */
+void ice_fdir_clear_flow_handles(struct ice_hw *hw)
+{
+	int flow;
+
+	for (flow = 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
+		struct ice_fd_hw_prof *prof = hw->fdir_prof[flow];
+		int tun, i;
+
+		if (!prof)
+			continue;
+
+		for (tun = 0; tun < ICE_FD_HW_SEG_MAX; tun++)
+			for (i = 0; i < prof->cnt; i++)
+				prof->entry_h[i][tun] = 0;
+	}
+}
+
 /**
  * ice_fdir_replay_flows - replay HW Flow Director filter info
  * @hw: pointer to HW instance
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a97a1941cec6a..7aa1235447310 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 		netif_device_detach(vsi->netdev);
 skip:
 
+	if (hw->fdir_prof)
+		ice_fdir_clear_flow_handles(hw);
 	/* clear SW filtering DB */
 	ice_clear_hw_tbls(hw);
 	/* disable the VSIs and their queues that are not already DOWN */
-- 
2.43.0

