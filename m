Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77276CCF2D5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 10:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 463E46075F;
	Mon, 19 Oct 2026 10:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q08hzEi1tqHr; Mon, 19 Oct 2026 10:53:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A32DF6073D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407199;
	b=VS+wNTDEmv03AWa66YIC+l5Es6gaFJYIOncK6z52GRWQ6JrLDhmrWcdL3JO9Y3tyI4iA
	 eRXEFe448cTErELpyS/142seYZ+zqduHyzyzN81DBnhU1HslKdS82ekCwpU8ZS4Osdt/2
	 qxl82CNGaw6Y95ROFo8J84syOXSfxWLgOWzbcPUoMNaFJr4roTEI1nHfu1vclhxEstx+q
	 GkCjhUJBjqVN+hSBLfFGvlmwKju7VS+WJKWeRz/sXqu2U04uGnqGtvRCbsBKhqb9uvILf
	 Qm/wNFhxMYbEYJsb82w4JJCtLdP++01YuEjBRypkHYTKwNipXRmGq6Qskp6ezH/mYzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
	b=cLBQjjowJwWJt1fIdWHG+c/8BC6qtU9OSgEqFybvqnYHlSPJ+cvwHEKx2xIuLkjP4AXp
	 3JWEZEXL2r9/h//oruO3UyvzkY3Cv9c6hn8T9NMAV4UYhm+uAFGJvoeviMCWg6FWpYHlD
	 dhCXXF2oMKbbL8Morp3VIkbuFEUSfMfcFWEw2Gpg0OvdClUv3CU/UHuSq57MtgTL945MU
	 t6sa2wPGWT7xniQFbMW+VCXioUjAtDVbAY5XO2NsP8tYDAJpwhE4ac1FKoOJveF37x5/l
	 Li2tqUvQGr6eAb/9R17STA130kJNi3ilWz7PJ/Zf0gYcXE00wQo24YWq7xr9ou4sjfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792407199;
	bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d6ZyaHloOoEKcM1C1EU8gE58cqIcjoyKmNAUuQed+A/VlvsClWHa7TlAjch9bfLzo
	 WvedwsyQ3DNxYyEniKbJvbv0F1gDwiYKFQhz7qGfx1usmh/Zw6xZ8oWxpERvCFwCxX
	 z+kDyFnuTxZ9bjbFfet3zoJvNKsTcQVtxqM02pd7L9/tgvc1t/tDTT5QKTx3G6BU4H
	 5joOTwarB/caQF2w7HPnubrZRYRZYTYTReTTP4endTBUy0RG/DQHEdpop43h73Kekx
	 345E3+oeIN0ajjpoPAI9ZPXIcoWIZMaEGD7fNXbEk5o6/UG8NPd2ZBYKK4WP67WlsH
	 lPP2YHX33T0KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A32DF6073D;
	Mon, 19 Oct 2026 10:53:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E57F1DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3E8480F28
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60KS1IFztqtk for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15BFF80D9F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407197;
 b=AmdE/wkMRn5bZhira0n2tleHuv2KaGsWq7lXI9S/DvavnH3DFdU/8ru2CkUA+8UrZyDN
 dMDSq3j19KBYUc2Yedvv6tIcwCE75XrdN32r6t1ldeN09pMUVXBBJSJOnBMDwg1U6SfT6
 2A2TeocKNaoBp3Z5VzQNEx76D2skcpZ8iQcOwKaP/A5zEb2sS3byWrjRO2bgk5JqoAG78
 qtydlDdNE5TxVptO34nD1+yv547qoKhU+8uI6m5WMJ3Pb3afVqpedzbtFxXB1YTxfXHtA
 zqxyOD3lrkLBPk9tcUDwI0BBAsUEA33NRaJHnybb67b7TENwUPkisiVT5hy9ZGkISFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407197;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
 b=UG4FYfUGYXUkcTuF6Jad7lXJ+dx1zFyduTTt62TOx39uodsWKAKHKthedNpNclnyc38F
 pDQ9uYuvTWI2Ra13pn6KtltN8WXi1KV21NJjM9TyLdDiSxNpaL13iRkB80cTp2SUbGNnG
 B0GgO/ObJDiV3ubtJ0d/dPmnhL7InHo9v7GOSEUmu+A9SHdDenKHIaAxvOy2KLKXnEJ01
 UZ9tLFOVfZBnb+TrrKfe6khg15vXkSYwMOzuqsOFW1jYrpK6/up6jnL9BNGDvCz3L1OOJ
 k1EX8l9waqIuLLbJbXKoAtCJ/32T4txfttB7LCGV9a/SQ+l18jFG4Mgu9P7SSBpX0fg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=QkqkkEL8; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=QkqkkEL8
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15BFF80D9F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:16 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 252983F2CD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792407194;
 bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QkqkkEL8hbAJJUJshQykmTz+O3PFA7ITI0lgcL3ZvOYNA9h++Bz+zEhlJCF+OHIyK
 Gyzf8J1RGAwA6+SG8FgyHAUUexv2GsGuqvudZe2TemiRloiUddoX1d2dW5MEXaliKt
 rb3PF8TG4TRVbfq61CTo4HhwVthtc72hi+pEtuiSCfGc7evfdm6mS4fYS1KbHCObbo
 lDs2Ouek9RWtofOP9O4fbdTlZ+Q+DfTPSYS6hOhzBHfznWxs1pMXzbaFUp8xaR8LES
 WFdLTVE2/7mE7eCHloIS/2zbND6+mWDk6NClN1RiS3BEXNuR7qQlPaWZDBLzPikhWZ
 FSnJm2eLPViMA08nVpEfPu+4CqAOFhE5PUGOw0GkJNI5C449veNK9T8Om+6F3xCcuv
 QGpEtKZ2QGRP3kVEVhHCwYkhRhIQNa0DDmKLFhL3YjTxHZvgR1+2UJ2W2OITi5kuWq
 YIv4TMhujH5ZYLxe/rQ5hAQNFARGoVhy9hXsXWSLYH7NIQoPBLH4kX3ZfkxdFEIpPH
 DRTJ/mvN9LU+XuBjygw4hd3j/iM2pJ2RRwzt7ybCtFQ1j8sA0aZMTh+9H1dHPo8vC2
 QFCtEqJ+352ThVN14ww34KfneJUeJe+SMDsBoxEPf6+hPoLp45GH5QEyisWWSJs/80
 ZzLVgCMvASvAfYJJdJYFu68k=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so16246055e9.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407194; x=1793011994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
 b=o3SRxSfTesTcox7OaOOv5HbNdInSFYeKZDQaMnidoW8Dx421+rAt5rWQ13jt9Ik9ud
 NfcNMw3LqldTOQlefwuhJ3JT1b6q7MNes3YaXM1dJ7QL7n1RG7+wmk21KL0qRvjuLOH1
 e/DI+FTdCC1tZ5o9/CYeZeaOtT7zJ2+gqZpjrk3x/oVhfbe6vMy/Ip+S/PmFfOLjDzPe
 meeR+d6t64Av7oZt4y0YFjmul19yzKgAcVM9WiTuwz8sKgjq3+adINNKopC9TY4Ncaht
 ouuG/U5pBXNdh7oGehZLDP79Nphvrj598hlM82Kg7tSjIfQEQVtDQAu6WO4RubuJX7dX
 VWLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEZjNfXfGMmRR3h60MwmjzFqvKHLfOpLYl/OB9OFQS/+WRCEx1X2EJvOhp5VyPtUT7SdRgo+WnrW9yodoqmXA=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLOCZ0wGcbEltKQnSuY+h93fqIYcVjuz5bZZjqfOQJIPdIFHBof
 Gfj/PyAjn5IdIMsvX87uj+MLnSQnwixega+kzjZOhiUGW5eIOfZrXP+WLCrLzgf89g/S2i88EIb
 A+FuHV0Ttvvw2gFH91NcDmLG+YhHHyyg6oj6PnyABRTnv3d3vU8XKUXHuUm5a70zNGDDFHeStFI
 E+whbl2ETTTqE=
X-Gm-Gg: AYBFou0/cS17/NgiTdYFa/NxdR9mOGZB5p5V3rsKDGNfXlzDdGMHhZj4Xh5LH7W5Wp7
 7eCYxZIFoDuODi0yZOnwBLUBT6DJ4p2KBtYCK0dNR6+e0BsADzfVwJtgwGorSXNKFjsQ7Acw3mh
 1rGvzmtatjpXuA9rfXzJmfErOEI+Vfn7ZQwFXFzV8CIIRjIgask2W03rcHzMdT4p84+b85HRsi1
 8ikGi1POD3McT28gIhMm8oRMc01oG5HVlSWTnOcwPDk3PkBAngy9Duk++MTrgvHCpxfxwEuYX6j
 0vzBqa8MDcDjUKRxxXXoAfjnYhftmp/36Li/8H6kQcz7TAmzbElEYJC6NQjdRFbpzJnj127S0LH
 YOL0T7W+m0ZWsAki6GLzmYbSjWcWxu2TVDaHP486aVCtSvABtMJ4OmYGdnfk75R43MPoatQm8zJ
 eTSUb/MA5WKr4jxujI0i86PQzEL1zulAH+0U0tGoPdue2qaaX0URcI9V93yicshEhB2Ktc18BDd
 9fFvqWOmI2KDd53GwFForf8X9Gc+9VHGMk9rvOj
X-Received: by 2002:a05:600c:5250:b0:4a0:1c0e:b136 with SMTP id
 5b1f17b1804b1-4a1d7616bfdmr147460655e9.29.1792407193682; 
 Mon, 19 Oct 2026 03:53:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5250:b0:4a0:1c0e:b136 with SMTP id
 5b1f17b1804b1-4a1d7616bfdmr147460255e9.29.1792407193245; 
 Mon, 19 Oct 2026 03:53:13 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:53:12 -0700 (PDT)
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
Subject: [PATCH 5/5] ice: quiesce PTP periodic work before system suspend
Date: Mon, 19 Oct 2026 18:51:55 +0800
Message-ID: <20261019105155.3793063-6-aaron.ma@canonical.com>
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

ice_suspend() stops the main service task but leaves PTP work active.
The PTP kworker is not freezable, so it can continue issuing MMIO
accesses after the PCI function has entered D3hot. Both the periodic
work updating the cached PHC time and the E822 offset calibration work,
which reschedules itself while calibration is pending, are affected.

Synchronously cancel both works when PTP is ready, after disabling the
VSIs and before shutting down the control queues.

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Fixes: a69f1cb62aec ("ice: exit bypass mode once hardware finishes timestamp calibration")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ddebb28b2454f..3962910759067 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5450,6 +5450,12 @@ static void ice_prepare_for_shutdown(struct ice_pf *pf)
 	/* disable the VSIs and their queues that are not already DOWN */
 	ice_pf_dis_all_vsi(pf, false);
 
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
+	    pf->ptp.state == ICE_PTP_READY) {
+		kthread_cancel_delayed_work_sync(&pf->ptp.work);
+		kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
+	}
+
 	ice_for_each_vsi(pf, v)
 		if (pf->vsi[v])
 			pf->vsi[v]->vsi_num = 0;
-- 
2.53.0

