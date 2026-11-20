Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B03606A320
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9p87hEQO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jyM/coJ3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 392BA40DB5;
	Fri, 20 Nov 2026 03:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPSSte59ZUv4; Fri, 20 Nov 2026 03:39:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9598340DB6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795145957;
	b=K5ScYfCiiT4+krun+sTbuSen92Zy2ViupOuFMMnuYQHVH8Z28KV15D9I0Mq3I/Ng8p9Y
	 Sqcvy/HER+5Cy/WkHnVdOnZ9575Kn+tAV8teQrUR9mzZ0h1Hmh1CF6wutkTNRzAFWymx/
	 dAnssE1YqqbFEnGSWloJFuH+3bozDbHBu6T1sFje/6HhyHYWwVxrd6v0SKnXNb5yQaz5e
	 imsuygbEZmn0Dq/lYcHO43i/yP/EhabWvoVjOwVHmmjWUy9dz3wFRcoMgL7nHsTMpDTai
	 XS1gcdolKQ2pdO5vpHPO/Dbaquqxre94YrSj7rauV5RcQjI+Gs1BkGNuUmOQjHEVZBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795145957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BmL15il61u4HjD5Xp8Z160Kx1ZRWIG5s4ZIJmdF45ZY=;
	b=aHI0N8ORoLBBW6ysEDXWnaA29QjjqwUIubNtFr7Z8VlTq509/jaIOcwgyGiplp/LL54n
	 iBRZQD2cGKya339B+o0xezHI23QvXZ7W5lOqoysYXkK+DmIReTRhendMW0EDu5kgL6Viq
	 2tpYPx89SV6rjJel0KXgflID9FuK6+jgMYKcUthhC5s30gPszxvNNrP8qcuhHDLznwm14
	 cRNEhsiA2W1pKMrlBJL8gWaswI+C9dwjYYSQGacBEheHMTXF5CEuebuE0C4MlBrccXB/V
	 HB+Bb5pjjBpY6BNJ+ALGk3V4Hb4cu2pBi43F+oATvr+a+qosUjwe3uDECrJd9rim9/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795145957;
	bh=BmL15il61u4HjD5Xp8Z160Kx1ZRWIG5s4ZIJmdF45ZY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9p87hEQOXQAfEB+v9KR4hKzYFffY/5TjE5OYtfhTTBgXDuy5L08Eh/n+VWFyc2Kuz
	 dRoE8H3qL08TAPI9uGGkPYrTDoA44C8cppA83rP63OnONvikioKrXX9I/nJl1u071O
	 avAItr9WKa7f7944M5CD5JJviPmMBUeslp9XnqgiijBoHrsr8qgqSjVyo+nVKn4WIG
	 ZPjRGklr5+n5L9f191H1xfFuMqNw+5wNCqn0STAUkC26BoKFQge8hhFIr33Jp8EL9J
	 pL3d2KhapmQHnfDillmqXK6Hghzn+7TTKbPcy2ElhnUbw6QzV7c9Q7vduLqr1bEMJv
	 mQpF/L52TOYKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9598340DB6;
	Fri, 20 Nov 2026 03:39:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B30D169
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 03:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8163840122
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 03:39:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BH50No2-eZLv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 03:39:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD99F40064
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=lcy8047@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jyM/coJ3
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD99F40064
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 03:39:15 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5430f70c827so6629561cf.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 19:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795145954; x=1795750754; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BmL15il61u4HjD5Xp8Z160Kx1ZRWIG5s4ZIJmdF45ZY=;
 b=jyM/coJ3plYokfSjiNM2yJn3uWTP8WXDzKT/eYdAOsYNPtDvZYPtgat6fHfbaDkzYg
 BkNczjahq9rn9FkiE+2SDQVYGS+RynN6cK8mpRl81NzSom/GenDY1y/rdO5sBaTHawQa
 ddGDbYp183zSn1/S/4bXB+J/GaNPR6ow6n2HorV/2wCEPmdutR4qIxwHn5LU+qdGX1EC
 USUoQ7WRRcxo//t5GoIZ3AYSwvaK0xCeIvlXsYZcr2XAe0oO3X81qOiUjI/cCT0Bp+BI
 GW2724fkJu/W/CuVpnczkYoyqf5V37SMO+9xlRGY54rqHyag2Whyhm9J49beGdCAlc3D
 4vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795145954; x=1795750754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BmL15il61u4HjD5Xp8Z160Kx1ZRWIG5s4ZIJmdF45ZY=;
 b=ITKPfr2T1FZaN7z5fRvklTxFNq02Ja8H7ZED8QCjZCPBs+H9ze+SGMFXgWDy1EJBMT
 xrgWzLqegQ3WF97mV1jSTKFzqabl75gi1ySCZpkl2jdHdwg7dSUbSXU5Jrfusw+tx/vs
 jvCj/2w2qqv34khsme3NlNVyWXv+wmKUJhu2MsQopj8fZyrdSNwSf2UmMeSs7uOcvcBa
 2ObIfX6IUa0vqRuXMxtZRaIDaISmNOuu7JIUSIvjDSjmy/kw1lAkbiKKGNgT+7cKG1TP
 ArS6QNGYx7k/ee1vZnB9yNw5XjFsXrjK5KgWSwWm1vK5wd5vqz8HZFJ/Ir+TFZ1mSv/s
 pXiw==
X-Forwarded-Encrypted: i=1;
 AL+hErFo9TkHbvYAPkeAoHi1eaYwm8l6ORX0PfdNEXFOQ0f8DG7Z+n/R9IuD7PKeKmyS1mr9hVTDqTMe4s+xhrbw02k=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+rqU0d8ryJ2Vv7/cl+Y8Mu7+VVc5HdPEf2E7PZhuHkgjm7TyIA
 3hN80kaDL9s8uC2k3zW73N9SqLo3o9Eg5h3t9384tWCDqRIa4Dlu7j8d
X-Gm-Gg: AYBFou0MX0Kj2oG8JquRIuA4wcE/3wOZOZeugPmg2gcDrBLpeKRhQ9nUyJKoZG93V4O
 vyTSK/6GD6Vi1TTwTlWH10Hm4o5TBBWGCjUxMVw9LWe/tpm6ccHY//HnscOprUGpd/xvui5xrg+
 p16O0VtqNKmu1zrB6vkdBFae/b2LyyNCBRN0LHEW5OMT5LRm9K0t49PCkE4EjhMz1/rqxleKQsU
 GAyb60upZ9QU1WFU6+svXbd3ufFF8k/SEEv4WEeuTnKYGxwPmaSJ9815WqgenX3xRiFMmhMxsna
 g3qhHVv7SLp3D7nszNe355MasCrNsjxJoT8gqO4QaOBAKDui2bF+telkyydycNP6KPmCo4EBBis
 OC5me/zR4ozyrUHJII5+LgJ9qTBuY69/M/c2mLyI5WrF3JG8i3RNXIMLluZNK3a7G9sEYTqK4bv
 epRweOIMavl5NNd4+trHzkMPRS3UIW+t2zsn5U58ERY6YTJ1KBKOvHcFWA8HIKbsZB+y2K8SiHt
 YmfLQVKlHqJ/seswVY6kWAXIR9EDm1vWYGMhbVqwUCOPArD3XzIMhfBa3WvZ1NTL3FWiaTBOGwO
 k9udtjm2+qbUV21kvADt4J5GybIt5yGQo/T5osyoJw16z5sStYgAJR+RTNJWZPyiwjATMzARaMA
 =
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr35213321cf.49.1795145953682; 
 Thu, 19 Nov 2026 19:39:13 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7888fb27sm11535941cf.25.2026.11.19.19.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:39:13 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH iwl-net] ice: hold a VF reference while creating LAG
 placeholder VSIs
Date: Thu, 19 Nov 2026 22:39:10 -0500
Message-ID: <20261120033910.1731258-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the secondary port of an active-active bond comes up, the driver
creates a placeholder VSI for each VF. It walks the VF table with
ice_for_each_vf() while holding only pf->lag_mutex. If SR-IOV is disabled
during the walk, ice_free_vfs() can remove a VF and drop its last
reference while the walk still uses it.

Taking table_lock or vf->cfg_lock here would reverse the lock order used
by VF reset, which can hold both locks before taking pf->lag_mutex.

Iterate over VF IDs and look up each VF with ice_get_vf_by_id(). This
holds a reference until ice_put_vf(), keeping the VF alive through
placeholder VSI setup, even if ice_vsi_setup() sleeps.

Fixes: 28f073b38372 ("ice: Implement support for SRIOV VFs across Active/Active bonds")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus PCI_IOV, ICE and W=1.

 drivers/net/ethernet/intel/ice/ice_lag.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index c4b8af01e2af..e0803c2a3e8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -1913,18 +1913,24 @@ static void ice_lag_monitor_act_act(struct ice_lag *lag,
 				struct ice_vsi_cfg_params params = {};
 				struct ice_vsi *nvsi;
 				struct ice_vf *vf;
-				unsigned int bkt;
 
 				params.type = ICE_VSI_VF;
 				params.port_info = event_pf->hw.port_info;
 				params.flags = ICE_VSI_FLAG_INIT;
 
-				ice_for_each_vf(lag->pf, bkt, vf) {
+				for (u16 vf_id = 0;
+				     vf_id < lag->pf->vfs.num_supported;
+				     vf_id++) {
+					vf = ice_get_vf_by_id(lag->pf, vf_id);
+					if (!vf)
+						continue;
+
 					params.vf = vf;
 					nvsi = ice_vsi_setup(event_pf,
 							     &params);
 					ice_lag_aa_clear_spoof(nvsi);
 					lag->sec_vf[vf->vf_id] = nvsi;
+					ice_put_vf(vf);
 				}
 			}
 

base-commit: bf9edda440e747a4a9b351656a395f0b77cc1fef
-- 
2.43.0

