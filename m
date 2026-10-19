Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF7ECCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 10:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 251E6605F3;
	Mon, 19 Oct 2026 10:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbrAtPbO0CBo; Mon, 19 Oct 2026 10:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15507606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407185;
	b=QTl0sYH/qalkdprJuXcazYzn2cobzLcfOKCXqdt5lnlvlVJ6YVunFFMtviHpeLKJ9Us7
	 ev68dAkiYWhvUtCjNRLKf2pXHDof9fYq5nYwnc/3+4xu+FG4V0SO1HMThaMQqT2uDNH1Y
	 hJ9lDWLiOh71DTjcwqACLJ1jhcQf5b5V/vmyBlEZK8KMZurfF8xMy3ChSiV3NORdZ1gge
	 CVm4db45sz1TQHPxMGJRF+UwZp8GmY+Olx/GOdn0x/qNnA8jpJCHK2Yah4v8oFZ6NdQVK
	 LNxSXTQjNmfIZWA5jC6rz5wJffr9qpm2pTOfBwTbeSqnX7imz2iF1lrr+FocN1lHwAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
	b=Ogpd3ncfQM81DnS4L8FkTh3m8jd6El+pBXlOusgkm3BLiilZcz0u/DXp1PP3qsk8uUQf
	 +jGAQCj56XbgdiQoJdKjjDWOO5S3F2N2oFn3jTZZJR3YGDx72DRd3xpkXtoAnSMYVBVHj
	 KUYW4+6VourM1AHZ7RlnbIU51cQDsoG131Js7PDsNNaA64nJ7IlypUloL2/AR9SWbH26D
	 3J5DbVID3MMA3/zm9bLNtDGd4QWHr9+nYtCzQVHfmS9uzSC2pBUIIaHxS3gzqFZ6GjW+p
	 nQugik4GNqS1nxh6eWsROjzheUNcapeuS8GoQAW6LzwGgvIxlb+NWg6kjK71YWY4zWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792407185;
	bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZVtJ+kW0m31KI1406nDUDxiPrGm6/bVLv5iyH/xpupybWm6+7a1VvLIVVbGcekMf
	 e4hLsXyVaIGdwWTQQAQAXM5XNKXmu4g0CH/YhPeLQykEr+Csm9CwVLO70LPcoH31/F
	 4ev5jopsYREz6okLxxHLAYsQx6UzkRYXeT8W7Wb0frGWu5152/u2fpvf/NfRWZTC7c
	 hvGqUI4nCbhqeTimR6LjeZ4V7zUIHKgWc8kyVPKEbOMCeSylnT58kgvpke6Dan5qnL
	 4Dxn2OZPvh22wccq9FFGJ+MRSybnMYSLttjNK/HmLSDw93L6fNPHQl1goh4+0p2xH/
	 Blhejc8W2I6lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15507606CF;
	Mon, 19 Oct 2026 10:53:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 071B41DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED15E406B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pV9nrYEa379s for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6411D405A9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407181;
 b=G8sTchtT2OAoCuMMMJCw/Bzy74WqrvMOA+w/2JRylRuuCwT42jyq+LTxf4fQjZdn3c/K
 ZiagwBdvmxCjT/Ryl7TLpO+95olmlRR1D1GZNzDkgNbw7oiVCLadv49RSXpF8O3xYCfRs
 Jb9u4hEcDV/wY3I/iPbtzXwJtDGMLm6l0X+b+3AnhWXN4glB5Y0AAJrWtTFuK7Sr4DAUd
 uJ3riZA7+L6ePJkFBH73J/PxwLksdR9UtXsaX3YzKlmyOEZFQtt1O3T0N74eUbUL6w3v4
 yg87nFsODjhY3u+bOqxQDowM1btL09m0cNU3T8Sn0loxSD3QS52KyBkRzeU65nABSyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407181;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
 b=GDOkdem+sGnGSI0V388ABAEFVvJTaOw6O5Cn8yFxDV53xcE4q0ixEVtEvRJfJCJ7BRPp
 jbHp4jSW8ccinz5yG+QJAYCK4NjiLzThKYa2S2Oh1UEuvC2e8iS7R3gGNWd4lcossSMjx
 i9lsLAWdsXKvrKW7MH0XHGZaInB9WfH16KjsDaRX+8cbQdxgYhuT87uUO9HjJfxkl6xU8
 J+84wc5ugR4pTj0wBQf85nDsf+x9HbxMS4q9gaiINhNhkP+6jbLUSKguwRoHVp0yBLrAm
 7Db3nm74cBsQb+UUN+flpliCEhHqPc1LNNPN8kBzuWJIRepVZpnFww8OqRqbmjRmLow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=ahqGaU97; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ahqGaU97
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6411D405A9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:59 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 798DE3F442
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792407178;
 bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ahqGaU97sO85OGJE6bWiU2p5YroU7+NO7J6f2XDod3G5b7e352w5h1i8WTUyKwkNb
 iGV++52CnYUV6jC8InYoUT8sqoI8xNMLtHsty8L3IYORqWcgpTg+0tZUrXGjAftq9l
 FJIW+p0yhKEgMiX5qebmYoXmT3ToUHlh7BhxLQKeL1rqZ8tOrULao20zDK4pVXosfI
 sDwq5DQyl+roQ5Wxtsz9i+SFUBNt8q58RIQ9gDGKjhiaU//kPFPV8AzCxlazIC13qR
 IUte1vq0Ws5JLmVIQpS9HAe9tAxZrRzxgVYVzpRabrbAmNMwCv4l8fIgIQ3+MfJ8E0
 sDKSo8u5UOUQxdMrBmbWKy6jdxfKe6zKYs7WegM8SWFtrX9UzdOjbFzeY7GHPhCv0S
 sTlHd21uGX3kRbgbh1vImz5UzbSaSkJSX/Ow6WoMPUnQlJh5Sr1fjyh95b0dvQg7/a
 eNkwgWzTS8y88QgbJmWL1n71h0Nxsp3UfvP0h9rPlPc5+m+ezWqTKuw9SG6TGtQlih
 QoxcpwAJJTGX1RajDA/SVpPw4SaZfJJETKOi0/vBuWzt6mKvFgs/i5Hg6Jj7yGPXy9
 TJikGsc7wC4z+JXO6WXgQBzO/02Psf9KS1KatgHO4MSX+ELALVB3bIcbsjHdrVfcC/
 sekkwQVoQfVEh7TwZMwxpTZ8=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4046a3bso1827959f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407178; x=1793011978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h86IyMUid2GM5Noch64kNmeW+U4IgmtnTp2NBhVlriI=;
 b=c9c3vALuPLDRazu8nwQwYVx3RYRC1ZaWAq8w7bUOQPZ7FStEmaqfJWcHlS/C0Sx7fA
 +zfBhEhsWYMmALB5D7EfmUzknviMt2NVMaZtv/2Dl8+WKBk/1Q+qV4Zri8ICHSx1mROw
 CAhoXnwOmW48ei8L2VG345eNY4r0e0sc0o/qtS4sql9OflSWzwWJPWpKebNDMXemHT79
 H8H88OJxsBGQNTkUBvdtvLn1drA1S/85fKAePvyG5lu/KXmInAMDpPsBBjU6CiQVAY1J
 0Xn3YM95QIm3uTDi2I8OGdm30bdZHStSqFeGkAYOPx3HyDs8vQWv2WmpUAZVJlvFcU5y
 ZTvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzflRMsiCaFdom+Bkt/UfsCmUZogb9AJCADeBrq8GdpfC2TCP6wJqOWDTdszWNlTsAIfsl/P53uIeA2xEyHrco=@lists.osuosl.org
X-Gm-Message-State: AFq9FYI/t6qgZ+e10mRCnsJJ4j1UuEZPlOZ6UdF9cnlLMWGYXxihyA4L
 xp9lYO7JGsHKm1JB5koI/MvBsvs1pkxt6CMinbJLO9B1CG8rtDf63pN+o7irZK96XPA95LAtBU5
 V4VjcmrlmviTjlsWek0D0UpwDxI8FU5Nkk4mOpJ05lIPE+5Vm5xgeJEApGjzlNIw0iuuFX+GwvI
 HFBuoC8x+AI2c=
X-Gm-Gg: AYBFou1XkpTiJdihbbVI1v9TJQgHw/JJ2UcBtVZIiOy41kDkXS2zyNomzeiaRiwzD5V
 eMc4TpMKZqRnDGfA/1xxEdUKEH+4CYlEe8m7mJvdjnT5bWqOw6j5jDgANaa0B9qfhfVgT51gn/M
 OGMtF1YrmPSoX6KXUUkN8CH3n8YKWZzvDQtnqxqZckLCU+OqkqaAdgFrE9WiZByrdBTJ2r9FaBX
 dUtuTVsiRcfDoFrUcGaqiW09thI3HASJLYCXUCFOTLbS7dCg8HkNHo6CGANbtM9IGm+tLRRVI7/
 KzVTrD/1L7tBf2WxOU7zarwNn/dIp+uPX+/YOs1nb5Gvzz94xLoSxoLytq4w13l5xA0roBAWTiZ
 EHj3hSeeuhjV9ggydqv42QqPPdomGRoZE4my809B2mC4dppuaRJtF7mzOkLGqXP4oUdiC6NOkVO
 76nl4bvg5bc5Zg/H9eXMxOQqb0OvGBuqUX4lvzM7/QJgKNPf5VhhvACbNqFczWqk6cKT4YG92+p
 w0BMAut5NyOGfqSocfutUX1qri5PQgto1xs7I4V
X-Received: by 2002:a05:6000:46cd:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e07bbc7d5mr9009290f8f.20.1792407178059; 
 Mon, 19 Oct 2026 03:52:58 -0700 (PDT)
X-Received: by 2002:a05:6000:46cd:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e07bbc7d5mr9009260f8f.20.1792407177636; 
 Mon, 19 Oct 2026 03:52:57 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:52:56 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley <brett.creeley@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 3/5] ice: scope global configuration lock to the adapter
Date: Mon, 19 Oct 2026 18:51:53 +0800
Message-ID: <20261019105155.3793063-4-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
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

ice_global_cfg_lock_sw is a module-global mutex, so a package download
on one E810 adapter blocks Admin Queue commands on unrelated adapters in
the same system. In addition, the mutex is acquired only after firmware
grants the Global Configuration Lock and dropped before firmware
releases it, while the opcode exemption list in ice_aq_send_cmd() does
not check whether the caller is the lock owner. Non-owning PFs on the
same adapter can therefore submit exempted Admin Queue commands or
sideband requests while another PF holds firmware ownership.

Move the software mutex to struct ice_adapter and record the owning task
across the entire Global Configuration Lock acquisition and release
sequence, including the core reset path in ice_cfg_tx_topo(). In
ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
while allowing the owning task to issue the permitted configuration
commands. Route the Admin Queue fallback in ice_sbq_send_cmd() through
ice_aq_send_cmd() as well.

This patch depends on the previous patch in this series.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
 drivers/net/ethernet/intel/ice/ice_common.c  | 63 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c     |  7 +--
 5 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 7de9223e971a7..17819c3a172fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -65,6 +65,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	mutex_init(&adapter->rebuild_lock);
+	mutex_init(&adapter->global_cfg_lock);
 	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
@@ -79,6 +80,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 	mutex_destroy(&adapter->rebuild_lock);
+	mutex_destroy(&adapter->global_cfg_lock);
 	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index f9265de973efc..6557fa0ee0ec3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -13,6 +13,7 @@
 
 struct pci_dev;
 struct ice_pf;
+struct task_struct;
 
 /**
  * struct ice_port_list - data used to store the list of adapter ports
@@ -38,6 +39,8 @@ struct ice_port_list {
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
+ * @global_cfg_lock: serialize AQ access during global configuration
+ * @global_cfg_owner: task holding the global configuration lock
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
  */
@@ -51,6 +54,9 @@ struct ice_adapter {
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 	/* Serialize PFR recovery touching shared FW global state */
 	struct mutex rebuild_lock;
+	/* Keep other PFs off the AQ until firmware releases ownership */
+	struct mutex global_cfg_lock;
+	struct task_struct *global_cfg_owner;
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 82b803e74aac0..1793abba8d2b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -7,6 +7,7 @@
 #include "ice_flow.h"
 #include "ice_ptp_hw.h"
 #include <linux/packing.h>
+#include <linux/sched.h>
 
 #define ICE_PF_RESET_WAIT_COUNT	300
 #define ICE_MAX_NETLIST_SIZE	10
@@ -1751,6 +1752,10 @@ static int
 ice_sbq_send_cmd(struct ice_hw *hw, struct ice_sbq_cmd_desc *desc,
 		 void *buf, u16 buf_size, struct ice_sq_cd *cd)
 {
+	if (!ice_is_sbq_supported(hw))
+		return ice_aq_send_cmd(hw, (struct libie_aq_desc *)desc,
+				       buf, buf_size, cd);
+
 	return ice_sq_send_cmd(hw, ice_get_sbq(hw),
 			       (struct libie_aq_desc *)desc, buf, buf_size, cd);
 }
@@ -1797,12 +1802,6 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 
 /* FW Admin Queue command wrappers */
 
-/* Software lock/mutex that is meant to be held while the Global Config Lock
- * in firmware is acquired by the software to prevent most (but not all) types
- * of AQ commands from being sent to FW
- */
-DEFINE_MUTEX(ice_global_cfg_lock_sw);
-
 /**
  * ice_should_retry_sq_send_cmd
  * @opcode: AQ opcode
@@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc, void *buf,
 		u16 buf_size, struct ice_sq_cd *cd)
 {
 	struct libie_aqc_req_res *cmd = libie_aq_raw(desc);
-	bool lock_acquired = false;
-	int status;
+	struct ice_pf *pf = hw->back;
+	struct ice_adapter *adapter = pf->adapter;
+
+	if (READ_ONCE(adapter->global_cfg_owner) != current) {
+		guard(mutex)(&adapter->global_cfg_lock);
+		return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
+					     buf_size, cd);
+	}
 
 	/* When a package download is in process (i.e. when the firmware's
 	 * Global Configuration Lock resource is held), only the Download
 	 * Package, Get Version, Get Package Info List, Upload Section,
 	 * Update Package, Set Port Parameters, Get/Set VLAN Mode Parameters,
-	 * Add Recipe, Set Recipes to Profile Association, Get Recipe, and Get
-	 * Recipes to Profile Association, and Release Resource (with resource
-	 * ID set to Global Config Lock) AdminQ commands are allowed; all others
-	 * must block until the package download completes and the Global Config
+	 * Get/Set Tx Scheduler Topology, Add Recipe, Set Recipes to Profile
+	 * Association, Get Recipe, Get Recipes to Profile Association, and
+	 * Request/Release Resource (with resource ID set to Global Config
+	 * Lock) AdminQ commands are allowed for the owner; all others must
+	 * block until the package download completes and the Global Config
 	 * Lock is released.  See also ice_acquire_global_cfg_lock().
 	 */
 	switch (le16_to_cpu(desc->opcode)) {
@@ -1924,21 +1930,16 @@ ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc, void *buf,
 	case ice_aqc_opc_get_recipe:
 	case ice_aqc_opc_get_recipe_to_profile:
 		break;
+	case ice_aqc_opc_req_res:
 	case ice_aqc_opc_release_res:
 		if (le16_to_cpu(cmd->res_id) == LIBIE_AQC_RES_ID_GLBL_LOCK)
 			break;
 		fallthrough;
 	default:
-		mutex_lock(&ice_global_cfg_lock_sw);
-		lock_acquired = true;
-		break;
+		return -EBUSY;
 	}
 
-	status = ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf, buf_size, cd);
-	if (lock_acquired)
-		mutex_unlock(&ice_global_cfg_lock_sw);
-
-	return status;
+	return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf, buf_size, cd);
 }
 
 /**
@@ -2161,10 +2162,17 @@ ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		enum ice_aq_res_access_type access, u32 timeout)
 {
 #define ICE_RES_POLLING_DELAY_MS	10
+	struct ice_pf *pf = hw->back;
+	struct ice_adapter *adapter = pf->adapter;
 	u32 delay = ICE_RES_POLLING_DELAY_MS;
 	u32 time_left = timeout;
 	int status;
 
+	if (res == ICE_GLOBAL_CFG_LOCK_RES_ID) {
+		mutex_lock(&adapter->global_cfg_lock);
+		WRITE_ONCE(adapter->global_cfg_owner, current);
+	}
+
 	status = ice_aq_req_res(hw, res, access, 0, &time_left, NULL);
 
 	/* A return code of -EALREADY means that another driver has
@@ -2197,6 +2205,9 @@ ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		ice_debug(hw, ICE_DBG_RES, "resource acquire timed out.\n");
 
 ice_acquire_res_exit:
+	if (res == ICE_GLOBAL_CFG_LOCK_RES_ID && status)
+		ice_global_cfg_unlock(hw);
+
 	if (status == -EALREADY) {
 		if (access == ICE_RES_WRITE)
 			ice_debug(hw, ICE_DBG_RES, "resource indicates no work to do.\n");
@@ -2228,6 +2239,18 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
 			break;
 		usleep_range(1000, 2000);
 	} while (time_before(jiffies, timeout));
+
+	if (res == ICE_GLOBAL_CFG_LOCK_RES_ID)
+		ice_global_cfg_unlock(hw);
+}
+
+void ice_global_cfg_unlock(struct ice_hw *hw)
+{
+	struct ice_pf *pf = hw->back;
+	struct ice_adapter *adapter = pf->adapter;
+
+	WRITE_ONCE(adapter->global_cfg_owner, NULL);
+	mutex_unlock(&adapter->global_cfg_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index d1d674ca644f6..48b53f83aed3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -98,6 +98,7 @@ int
 ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		enum ice_aq_res_access_type access, u32 timeout);
 void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res);
+void ice_global_cfg_unlock(struct ice_hw *hw);
 int
 ice_alloc_hw_res(struct ice_hw *hw, u16 type, u16 num, bool btm, u16 *res);
 int
@@ -142,8 +143,6 @@ void ice_fill_dflt_direct_cmd_desc(struct libie_aq_desc *desc, u16 opcode);
 
 void ice_pack_txq_ctx(const struct ice_tlan_ctx *ctx, ice_txq_ctx_buf_t *buf);
 
-extern struct mutex ice_global_cfg_lock_sw;
-
 int
 ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc,
 		void *buf, u16 buf_size, struct ice_sq_cd *cd);
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 3b2d9c4369792..b71f3fb791db7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1141,9 +1141,7 @@ static int ice_acquire_global_cfg_lock(struct ice_hw *hw,
 	status = ice_acquire_res(hw, ICE_GLOBAL_CFG_LOCK_RES_ID, access,
 				 ICE_GLOBAL_CFG_LOCK_TIMEOUT);
 
-	if (!status)
-		mutex_lock(&ice_global_cfg_lock_sw);
-	else if (status == -EALREADY)
+	if (status == -EALREADY)
 		ice_debug(hw, ICE_DBG_PKG,
 			  "Global config lock: No work to do\n");
 
@@ -1158,7 +1156,6 @@ static int ice_acquire_global_cfg_lock(struct ice_hw *hw,
  */
 static void ice_release_global_cfg_lock(struct ice_hw *hw)
 {
-	mutex_unlock(&ice_global_cfg_lock_sw);
 	ice_release_res(hw, ICE_GLOBAL_CFG_LOCK_RES_ID);
 }
 
@@ -2536,6 +2533,8 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 	ice_check_reset(hw);
 
 reinit_hw:
+	ice_global_cfg_unlock(hw);
+
 	/* Since we triggered a CORER, re-initialize hardware */
 	ice_deinit_hw(hw);
 	if (ice_init_hw(hw)) {
-- 
2.53.0

