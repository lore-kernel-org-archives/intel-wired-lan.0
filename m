Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0197606A320
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qoHX28ej;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xqHrSu68
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90A3581135;
	Fri, 20 Nov 2026 16:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBSbW5kJgzir; Fri, 20 Nov 2026 16:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0351E80EA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192391;
	b=NzyKkGOSGltw0+DUdOz4Cq0mFaIBTgbvg2Z+BgXrKdQ0AjLP9ZwliNCxcAyda6OHhxOE
	 /9D5kf2PKgMaED8/9qYNYzkDNVDMlnBnwQ76LhkQ4vKKvlCB2T6AIHOgNeaqN5X41oZKx
	 0j4qTq2iYOTP0U3WcfSz+SuihtkGNJU2Z2hTgqzDCcl9lyJyAUQL97sAy50wco8D2bFlM
	 kj9FDe73xg/M5pquczua1eId6S1B5FUUn9hEEW2rZiTkEyA7lbTYOMf76QH9Blliqygnc
	 2qKySz6CkdA/nipQ0onWrJ49XO1arXe0lSxWSRsVLgz6W4w7SXlGR/g/yViQ2Y+d5PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
	b=JriZY+D0SDWYoLccbm7AARRH9cuqRu945qfPs/jBrvK8owLAkpROC420WVAH0dptsgmo
	 e3n+BrRdstFMON26JkAy7AUZvYXjO/4trUTL7dHtb9TxKaowJ6ZjeavGatIC4L++dopz8
	 VXU7ncYqIPcTEHWkvsbW4+FnO+AX+UOUP7ABAxkSIjcJwA7bc6k40vSjDl8PcyNkfh2+Q
	 Po2vNUthNgeJHyrMJg4bDslc8CwdrEtFfobOksPNMecWLjOlUw1ljRI/8/Iph0OkcZ5zI
	 T3UmrrTRxbI+uuNpyB9teGj4gA3qadF73Eaox8kusHzz2Qh81FlV4XMsHHu/uH0dXRg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795192391;
	bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qoHX28ejLmCPHB20WfPfLH4MyhoJJV0bFI2e0Pbgzy1q6o8wrUbftWppXKkSHJIxz
	 nuqg7tP7WzdYgMNl5AlcmFmNYviHKD6YGQrN5Vg3S2iF0TP3C7rz3Gzt5ddt7TpC9L
	 VDrDjD7Yre9UV5TolNw1qSPDNo8U8VkVWoyNyGJftbv7bctQ1UNXRS5TAQ0v28XfrD
	 RXYpBfBalMJvPas5XLVSzu9t0wCMouL8OYSH79rLdahVoYYqOwXbDmFL2IV958C5+f
	 xMI5oIcZjfrB3G/rPpIxpiuy747wj5zRGObtVlG/sIVLtBn7Geyu5aO2KNj+fXaYiD
	 +q7tCtXvqV9zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0351E80EA4;
	Fri, 20 Nov 2026 16:33:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B398715D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A531B6066A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjPCqxunbl9l for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 15:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3A6760679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=shital.gandhi45@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xqHrSu68
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3A6760679
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:07:01 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so1638661c88.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795187221; x=1795792021; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
 b=xqHrSu68wjrgvL778NXVKNN4RXZit0VyJMVTRfNp7Yotjgeelofzq5TlE4AybTQ/HV
 FhHZrYOQPdQ15B52isxMaavuWrelC2tUoyMli0Ksrr38FyGdI47E5OWY+tWWTUQSm0K6
 tNnCKu9ZZh8LjHm/h9tCqynrUdBtwoOj1v+75Oz9ZlgKOMfRC+Xf2gini+GgQ3ovKyjf
 SU7sQe/+9kX4TUn7mbomE3Uzd0f6/wnJj0I5M2N6pqV+xYxKtyLHDENzRlh/hxD9sl+s
 uOoyl/RQQtCz0nG22/BucD4udDaZTJTP3Qv4APFETpirYRNFiP3j5/T1qS8fh+QDqqfh
 YOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187221; x=1795792021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
 b=iRhUJ8+c0Onr2z0a8PWTGr0XqJ5pV/dvh/V6hqLxunfq2XpwLIzSKJfDBfWOG3968I
 B+hUchyeoh2Mp6uLVaLdef2G3ZrATXglR3APMbptIfRftdXvo/DQNoo2eq4S+mznBQKN
 xu9JL8Munl+UQ6eoEW+2FbdedJCsLq/z26fyNN/DEFIq2x+MHoTQOnBOUolABB7zr977
 EX+R96lLxzZ1RSIVzclIwGtPODZPJRzZhLPjUcPlCE/YdCFyT01iIrW5VysFErqOJac4
 1ZFn9TP41h1skaXLqNVygGDQrlhr8pDInDuJY1HzCulAXuWbYNWLuYl71itTi2raKVFo
 oyLQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFsyrTbZUH7QSTJgxLo/JHZ0OX9lPTiJ9iBlrC4P6RihJ4r3TqVxQ4wvv7zxhcOSzxayxBa47qavsEs9u56Q+8=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8160OSHDFutl1Up3AeqLDE7kLdCNj6pv42fOodb9n8e3rL9RUV
 um3w2Wn2hqHFtWrpdylWi9iRGKAeM8RPH4ArOcK3XgLIY4Lc7jPC8zsN
X-Gm-Gg: AYBFou1hdBLDsPqt/1NR9BqEkr1daiKwQq31UGtWvyj2axJEUzoClKH1Sw/HMfWVnMa
 psPVvCYNAH2gHndS3ynC0r36q3EBGEifY7VOyoGv4j3Sw/AJKa7wBwn9SXlIwUvEC7LW+ILBoFU
 RKoC+vkoOy+esiAr3GiGaugvOPCxnj0kG5pHz2yfnXUQksnyJyCqInmbj+xZbTtXBxdPDV/Hxp0
 TRyshOOPyYgIQWXJ1F6ycmWivNQZJ7ylAXvfEbB8YFptrdv+ezCbYcFObPvuWWT9afz1wNQu+c9
 /mz6MFw2a7vaIyAVm/EE8MUgffEMx2uPUHqOiTkuqDwNm9jRa/3ZOYDePSLKqvrnZYAtvK0VCWB
 nTivnKkq7G0D6btcfkxVw7GcI860Xi/yIzz2e8TOiMUA3ccsZvw47jmmgAoVcdcr6Zg3Zo3p9cy
 ZVn0+Q8bpZMOJFjfLsT1zQmw1XstiJ3dtPLrPIs8rQgupRQf4ve6Z8zaV8A6/xx0a4UiV92RtWm
 pygVIbt+B/FNuZ/XjLNHlYwKJRPjSrsU/Z4NjbQA8i7P++HR0yKtts9phMU/F/I6MZvool7G4Rf
 yaKAI9s8V5AGJaMdJPorjpiJ317d9mlBInZEv0O8+F8OmPFQzQuQqroG3U5DdBA2rc0I6We3mnw
 fH9RtV0s2
X-Received: by 2002:a05:7022:f907:b0:1b2:558a:d781 with SMTP id
 a92af1059eb24-1b5567b5788mr2642760c88.5.1795187220737; 
 Fri, 20 Nov 2026 07:07:00 -0800 (PST)
Received: from IN01-9QQVVV3.CAMNWK.COM ([171.76.82.79])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm7844902c88.12.2026.11.20.07.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:07:00 -0800 (PST)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Subject: [PATCH iwl-next 2/2] ice: wait for one RCU grace period when
 destroying XDP rings
Date: Fri, 20 Nov 2026 15:05:27 +0000
Message-ID: <20261120150527.14649-3-shital.gandhi45@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120150527.14649-1-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:33:05 +0000
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

ice_destroy_xdp_rings() calls synchronize_rcu() for every XDP Tx ring
before freeing it. num_xdp_txq is sized to the number of CPUs, so on a
large machine detaching an XDP program or rebuilding the VSI waits for
well over a hundred back-to-back grace periods.

The wait makes sure in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls
have left the ring. Both return early when ICE_VSI_DOWN is set.
ice_xdp_setup_prog() takes the VSI down before destroying the rings,
and ice_vsi_decfg() runs on release or rebuild after the VSI has been
closed, so a single grace period before the loop covers all rings. Do
that, and use synchronize_net() as ice_qp_dis() already does since
commit 405d9999aa0b ("ice: replace synchronize_rcu with
synchronize_net").

Signed-off-by: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c9..ed5103e8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2802,12 +2802,16 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 	}
 	mutex_unlock(&pf->avail_q_mutex);
 
+	/* Let in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls finish before
+	 * the rings they may be using are freed. The VSI is down at this
+	 * point, so one grace period is enough for all rings.
+	 */
+	synchronize_net();
+
 	ice_for_each_xdp_txq(vsi, i)
 		if (vsi->xdp_rings[i]) {
-			if (vsi->xdp_rings[i]->desc) {
-				synchronize_rcu();
+			if (vsi->xdp_rings[i]->desc)
 				ice_free_tx_ring(vsi->xdp_rings[i]);
-			}
 			kfree_rcu(vsi->xdp_rings[i]->ring_stats, rcu);
 			vsi->xdp_rings[i]->ring_stats = NULL;
 			kfree_rcu(vsi->xdp_rings[i], rcu);
-- 
2.53.0

