Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72C8C636D6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Feb 2023 02:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EE04404A0;
	Wed,  8 Feb 2023 02:44:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EE04404A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675824257;
	bh=FwADyaxpcJ2cEjn/uzA42zz/Jn36fm3GvPQfH0C9z84=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cNZmC00Ylu0VVqMJaNbyAYfv2U5mn347EgR2jzTsb5EG1t8eJUXIxfmSYRsFAJwCK
	 Xa98Tp1NRziH4aBWtexbC7cWUI5iLcut2neD7ok4Zn81AnW1rPmBAZCSw/hV/f2o9Q
	 Nr7PDYfDLXisk9D29BzK6pp8cpIg0/nDVXvTotYHHROktkiP7sD8suD/L+zfFIVPKF
	 JaK9kR9KhJXyXIpibJxxy/6F7M08aWo7d4PpJmBifIvI6ByfE/E+W92S5oKCBZ+cQD
	 0qhfulMxDNi0HPlRa4I/w35j4A/wXNccHE63KEf22W823LtQ0e6nrhogKtCCkw/B4s
	 KjdDkweDKuiFw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5iMUcXPcUbLk; Wed,  8 Feb 2023 02:44:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A73C403FD;
	Wed,  8 Feb 2023 02:44:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A73C403FD
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id F242F1BF3D4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Feb 2023 02:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCACC403FD
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Feb 2023 02:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCACC403FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egNZOP74EGjI for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Feb 2023 02:44:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D357A404A0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D357A404A0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Feb 2023 02:44:12 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id pj3so17012550pjb.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 07 Feb 2023 18:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyqZcRW+GCugu4NS9vKOMBoBT0DqUhhKYXJJWlHHasM=;
 b=0vFcdY3yPunqyTlJMf6x2jaVSNKeIYcYTsR4UTsyqOI/b9Y1eNM/1ZZ7mWLqXEfK5Z
 NDoSlJ8fWzvm4PLeMM6RAdjd88c6PHcTTfH7iwfAD58FVBarrCI/1D0Niogd17qG+hxt
 bs3MiAuOgtbc8ZE5zBA4oIwi2XGLLTXa6H0efys3fEvvjDSbjn6aT8g3lReDGUzN/r2V
 UFf2EjquDYwMrAjUv8PALWeFjVBniYjtGE/CliRjgvMGWfkdmh1SToqIBP2zaRhKUGzb
 BL1MrKjCDSpzXwq5xMO0veoAYSSH5pb75CXIZ0QROL45ipfNRIzPd+KOmN/D2322RwH8
 8MZg==
X-Gm-Message-State: AO0yUKWkNMD9EJ6WdrEdNRyPHzQKBy9ODrMBgEBhNzA8AHTbyfIR4x7h
 SueYyB8yDVL8JsNfu+15/iM=
X-Google-Smtp-Source: AK7set/4oeTEli8Ax7aBRx/+c9c1lZQ8VN9xNA+XYH6H2dBDKz8nuyieM3SD3X+Z800o+WRlK8yd8g==
X-Received: by 2002:a05:6a21:2c98:b0:b6:40ae:823e with SMTP id
 ua24-20020a056a212c9800b000b640ae823emr4795213pzb.5.1675824252275; 
 Tue, 07 Feb 2023 18:44:12 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([103.7.29.31])
 by smtp.gmail.com with ESMTPSA id
 jk3-20020a170903330300b001960735c652sm9660835plb.169.2023.02.07.18.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Feb 2023 18:44:11 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 alexandr.lobakin@intel.com, maciej.fijalkowski@intel.com
Date: Wed,  8 Feb 2023 10:43:33 +0800
Message-Id: <20230208024333.10465-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230208024333.10465-1-kerneljasonxing@gmail.com>
References: <20230208024333.10465-1-kerneljasonxing@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyqZcRW+GCugu4NS9vKOMBoBT0DqUhhKYXJJWlHHasM=;
 b=mp2V3kKaJjudKsbJwyzaBVBQhDL9Aqv6JEFZT6bcipjH6W83zFCNQbMombS4raOmgo
 djL3OSU7Pl1auFWMed2zIzkXR2YOce439ls0lXCMuOHGkEkBVbtbouC8YHRUbdglcqh2
 nT441af3nzdyEZpLafy3zVNO3bS9e0ffV3wWpTQ6WZi3fJcwcZjdmTInTB8bZgCfUAJm
 K1/JCGsscz8L2MyJ8UfkcUztjZX4YyNZ+o0TasQQ5AENhRrwcwC9hnasnFrFTJXQDePX
 9kiEarkcvkpxSnxE4guYS+j+bqk+awaEFyYEJZkN8ocH6VANoTTPx1CPbxprKia+3J7j
 qH8w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=mp2V3kKa
Subject: [Intel-wired-lan] [PATCH net v2 2/3] i40e: add double of VLAN
 header when computing the max MTU
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jason Xing <kernelxing@tencent.com>

Include the second VLAN HLEN into account when computing the maximum
MTU size as other drivers do.

Fixes: 0c8493d90b6b ("i40e: add XDP support for pass and drop actions")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2: drop the duplicate definition
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 53d0083e35da..d039928f3646 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2921,7 +2921,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_pf *pf = vsi->back;
 
 	if (i40e_enabled_xdp_vsi(vsi)) {
-		int frame_size = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+		int frame_size = new_mtu + I40E_PACKET_HDR_PAD;
 
 		if (frame_size > i40e_max_xdp_frame_size(vsi))
 			return -EINVAL;
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
