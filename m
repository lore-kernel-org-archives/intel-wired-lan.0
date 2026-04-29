Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87ACFF8867
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Apr 2026 06:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 846B6840CE;
	Wed, 29 Apr 2026 06:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWnkeRIXAFgF; Wed, 29 Apr 2026 06:51:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0116840AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777445516;
	bh=jUnzqF1b0jZfPUvpn/ylBvB7W/64BC9cpo6hVx+ffvE=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=u5YVCSxMR3BAWtE56TuS8ac1BGvgWrSaBzQ4pVkWs10He82Lti0SenfLCQcq2zzjb
	 y6GStGFyh2BxrZtFk+dRSpPTrEPxPHy4xFHfq5yaCndjXLZL7tI/5oP9sCzd240oTc
	 zvH1PIs1H0TDa4ighILYpcGf2PIaVFEyvJzRPaBx0pkMgk/08Zzh62C/82+Zv8uAe0
	 xmcD/Cz5SxcJKxsweWr41LiZINeGVtg4RgA63QKvp844gLiFnbahsSzio9BdEx2N39
	 tnzyxbjbo2tc8XRDsLwOGSiGdiPe3cLoClhC6oeiqcNU7a/8QQz+4Y3F7KeKOz2mb2
	 m7dVqx8B4wsCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0116840AB;
	Wed, 29 Apr 2026 06:51:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EF8F1B8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 06:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 240B7420A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 06:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFL7xBwauu3X for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Apr 2026 06:51:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=vincent.chen@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 804BB420A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 804BB420A3
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 804BB420A3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 06:51:54 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so116826795ad.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 23:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777445514; x=1778050314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUnzqF1b0jZfPUvpn/ylBvB7W/64BC9cpo6hVx+ffvE=;
 b=MwRjGYURiTjNpfvjyUpWpa3hNiTueJ4O4cUpFKxum8S8V7vObN8k7XFJXUyFe7f7dC
 8LJi7hKOwK0zteiYRV5XZZYBUQr4FIhBb6XSvNuncopWaXqNmqB+17+4VzyrlbjeAVmy
 cwvGELMnDwBbd/1uip76uOgDdpWW4+YKoESBtGajnYZx9VtLE3cUJ5NU8PjFQeudOHt6
 EecflDGSTitbV8G+Ra0Pyz7AcrghwyxoyErZnbb8N1cSrxfpKNZAgHkorMAGlZKjT35r
 cu3esp8eF3B46sqyhJmp0NPkuHKOihmivR+gwrGVu4KXY420gm5tWkYLDusnuQE/1S1n
 seNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Oz7iqMbYLbIQSVpK2SMCX6l4JAKQ5q2cDP2qOyVAW6GCaC/Q1vvXiP4pntrigSpgBDvklonog19xp1GEGpu4=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxjUeiWuibptSfKldeeJkOKJNSKp7RxaoQBcnxdhVHL/qI/FKHp
 u8ZubTpASoM/EE7zQP1NttIgdBUfuqjeUtDdlgYNCK7lARB1wcnbYEwBLogJmQqdPqk=
X-Gm-Gg: AeBDieu2evw4nGi7we7to9/oOZG4kv+v9tOjlJajv01AxtyUT5nCW+brzHixi7MekmR
 +5YH9Mjc1xY4qpvBJXjDowVEUGAdrsNN826ETgrlDI2W1BUMEFutWsUnhcTx4WGPjcU0RmIgk5I
 9UlWGasOYkhAFA4FL3QXXLZoqN0yohFpl16QWr5k47/gTiayA1VZHtaNsqOT/f7dwBmCXRTDPxI
 SPtpTQFNm3D6gE84maMbog8j7l3tsgjRzZLREqeUFZYlE+IMvQJFvaLa5OmkPtqIygoZ38KW9Br
 jysD8SCe0b3yJWTFg70KO3pmRo4npbjKhS+BuNPP8A2df2mbefs287DS5LpucwRKch72mYtNJem
 iQdRT/RxuLGQumJou6XOeRcwkEnN7Sh6qKxf0ab0gcDxiddfqlFISJIbmFaGvwc7/zFYYzpF2tJ
 D592tRWm2XvitZsL/ygf69WOUNA1+Qf8NLW9Ffmalp/1b2fPn4PMWW4f1aPkZgmsuiWFuKWZ+Pr
 cI97afOJDVqzAh4
X-Received: by 2002:a17:902:cec6:b0:2b4:5a2e:98d9 with SMTP id
 d9443c01a7336-2b97c49a59amr73951545ad.37.1777445513745; 
 Tue, 28 Apr 2026 23:51:53 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98895afaesm15038105ad.57.2026.04.28.23.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 23:51:53 -0700 (PDT)
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, vincent.chen@sifive.com
Date: Wed, 29 Apr 2026 14:51:27 +0800
Message-Id: <20260429065127.423949-3-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429065127.423949-1-vincent.chen@sifive.com>
References: <20260429065127.423949-1-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777445514; x=1778050314; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUnzqF1b0jZfPUvpn/ylBvB7W/64BC9cpo6hVx+ffvE=;
 b=Vr2DsWQ3cc2P2axP61wovl6xngsFngfGXNvyCLKsIaCXyjXmQTaoaL8AaskLIBvfsD
 GDszwqltB7FUiAoy3xl+ol113RbWpMRTHVuVmj79GAkC3Er6LW8MTSat4HYQIBnA0UrZ
 8WSHzCRt1mcULieTeYBSp78kbMym+WzL/4za8h6n2CPnG7AmFnyQOBrTDKGnaqccOlGa
 Ks/h5MmvTdLLJUsSLKS5ppmjPAFmh4KYKAP5QoTzaI/MuItdrlrMZLmOYexzv+vTp1h9
 uBrcv2k3FAxD28d4F4DxisSIVgHsQobddj12CaUzGHmSMYtZum2letQKvKQNUUrXgv6w
 VLHQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=Vr2DsWQ3
Subject: [Intel-wired-lan] [PATCH 2/2] ice: remove redundant switchdev check
 in ice_eswitch_attach_vf()
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
From: Vincent Chen via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Vincent Chen <vincent.chen@sifive.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

All callers of ice_eswitch_attach_vf() check the switchdev mode before
calling the function, the internal switchdev mode check in
ice_eswitch_attach_vf() is redundant. Remove this check to align with
the design pattern used for ice_eswitch_attach_sf(), where the caller is
responsible for checking switchdev mode before attachment.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..c709decb26d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	struct ice_repr *repr;
 	int err;
 
-	if (!ice_is_eswitch_mode_switchdev(pf))
-		return 0;
-
 	repr = ice_repr_create_vf(vf);
 	if (IS_ERR(repr))
 		return PTR_ERR(repr);
-- 
2.34.1

