Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A868ACCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 10:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6850D60743;
	Mon, 19 Oct 2026 10:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3B20VhcJitfJ; Mon, 19 Oct 2026 10:52:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1277606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407162;
	b=HaRLdhFB7OYLLXSBysdDMQ3czXV2/UiSGtq4eehDXdXjIBnrqnJD/1ipq2+ZCEHzyuqD
	 xrbdk0no+L5tdLi5DPV2DuclqdUzONhNLmGs5/9ejcHOOUA3RWwfI1iD4CQn0QqLN4V8S
	 Q+/KWfQN7hLGK56qV/fHdWmtSunlx8n+V0CwFs4tRN8gvUy+YsdlMikDGsmlwSgF4Mtio
	 f3AWJs89sX54ixoksXGjVzhx6ni+6mQ3RPBK0/dq74mW0XEqITI8KqGwzv5YAooV08OEn
	 YqVlbsHlSnX36qffD5d8LNkFODOzwDiiQqx5AIFhVi18GntYR5A3FImRKU88Pfis1RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
	b=YCO1o/yJLfoE2t4G262yH5i6XJRbwap2loPBfUiz04wno+ePiwNj9HhbHAdQ170lGPuY
	 CIqx631/SVqmnxgt8k0yR5t5/r10yZpg+uda4JpJBUayqhEQPQ6suk2x8IwuSedQ+i8RN
	 EgcQyMZ6qCyXlEo9gup9Rn4L+6v7Xvo+U9GDcncilHpSRySd1cgPX2ggLVH7cpOB4/yc1
	 FNOSKhLfBPDZU/K+Qs4mI3oWN7SME0EB6Hs0bV/W21Jyyc66xMUywok/MgfDzL3HKFyH9
	 yNx+8Z3TyQbodYmHnDgBJ9/6vRwYvooqGdELTFscJWDeHu7gJgDTST54IOd/2ZVhVJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=flfPEtlO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792407162;
	bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KRtuwiv8k0QO48cDvFdnF8Iox+h64FOncX9SuXdrnkYthNSQNjMAcs8fHEDBMmnB8
	 jIEj2kMkNVI4BsKYO2HabYCJ80vav3qe5SHco+oCuloCm+oPlLPsrxUyyqegu10i3m
	 YSwfYn/AWYggDUTygwEaoGDhljOSNDsJ0PAF7HswmRUspZdM4aM2a0j6Iq2B6+p1B0
	 W5ytSKhwLTwpb6ugOklaDYJG8zIqEDMU3xz0gEAAmMUPNtmZkkr81M+fthX0wWwFDa
	 kI0KmctExi5zwoyHxdDfgoysSgif/NYESlXlKe4tcGTF3cooPiMRHbnZF+Xf1z3V3T
	 dLDvx8Ey8mFiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1277606CF;
	Mon, 19 Oct 2026 10:52:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7DCD1E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A557E60714
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hX-4hmh7_djz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F022605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407158;
 b=PNooU3M6owPYO1jmyK/XLx9mhYUwJZYGrL073sUjYq6TXTur+5JCY7dnLsNhRGmjZqPo
 j/oLBECo78OhCSW1LRobgRFwGyafEBHg3efR5db4CuQg1swRIikts93DjaiXTRPnROkms
 5ouLJcX5cst4xX8Qb4knwmjIjz6yzI+h7eN1EpGsu5qHsBMluqeMyqgnCit3pg8EE1hdW
 0BeCOYR915xSD+LzlB8qzzFKui6+sp1HCH8m2OKwFvOlLO2XbMV/T926U7Dae4gfk2Yrh
 Bz79TAWrO4pLPqmiYhzC0EYVVTvV7HvOvo4MGajipeXgMtOasWQxuWvo+RJEEkUAQeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407158;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
 b=cEpE3JfHyxI8QodRW+p73gqMXUDKmtFHrAXesbjUSV20/H577nXmQfMPReP3AqrHsm3b
 y5+pvBM4o7MtKqHGJ+RXZtp9/QrioiVqkatWA4IjEjtn+ZQrhvfoCRp4mwo8QeJzH24eE
 yccQsr1imX+m8BBrlCGr7GfOTlen0it4hKa4E4FHFAQv7++FLiUPtmYuDNCfQaIVpnpzK
 rpe4vvkxvaoObvSKbfAQqE4uQPhloN1PHLirMKnOnmF5sBFN8qRGcUPnsWAepDhksNetF
 eogA2GtdK/sWbCwZsZO8DLBLwLSFc1XPYVBoELf9Fi5oom416LQ30dyLYj2ZoTE9lwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=flfPEtlO; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=flfPEtlO
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F022605F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:37 +0000 (UTC)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8C5923F442
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792407154;
 bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=flfPEtlOpqeAEx1FPUBhErVNqoil4hRtlbVj/6sSWzfDI6WujJCcwfMw+T0EH+e2k
 sDczt0fMMdrl7rmB2O3pFPyFWaImbcoiSxdtUNh10nJQ0Za0M/xLuW6D/Gw57+jJ9C
 dzCpXdl/GyOq/tji6ftO3TkMYt8Pd29M5BhVJwRrWhVieFj8mA/YfaErO+2+LsuICt
 11YeA19NPXV3f4jaF5pXczxOWxKun6+sTgi8TE6g1xZbtAhTSFJoDqGWnD94gXNQz0
 7LbIGgGYEaKG0hJkbSh+KUs46Hv7DNs966Ils69/PelaGSr5BTNs4ds5qYCs3IiTAL
 HVOhRrfAB2/oeBZZoBhZ7shXPFmPtscM1WuaeW2GG64FDGm4wvF55Rj3U3YulxoxGx
 lxoELZijC882/A/Hf2cWzI8fbfOJDJAnPlBfPn3nOTVCXm4uqwHtqVVgDoFydE56AC
 hm6qZvrl8UDpQKRNNhK1PP6eRGSXkhEOBsgcOZkZ93DE/pWmbX4kxtjc+VPOIL6hFW
 8qp61wy3551iUPa/7o/0Md/k0Lwazi3yrLZTRxBjl6eU2yRFE8ZVpz3EMFvKAf9RRN
 jYEkcysFByAGfOV8n8atMPFtUsT3NyU33gBsBEq5qu/xceJu6XA+cO1eohFB8tUKSP
 epYIDkDYLeGYKm6J4Efr+GaQ=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48df5b058ddso1219376f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407154; x=1793011954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oLogmVGlJ6B8L+VB4rQSHuGOeONrwssRUu0KT4NlTo=;
 b=MVFTPGXH+1NXru8q5P7n3o4WJZ9I7xCHvQPqMwS1VYf3E0B8ZyBrZH37y1rKIRg5T2
 bBO7uZYeSUwhlaHLTc7bZ7g8LZByPVumPYYM6wp3iAsETXoDnc4GOS0XYq4N6/YZqlEv
 6mvaQYDRqaCDFVqLkEVE0YQpWIdytrnZXvK/NPDcYdcxgzEDoFjhKAJr3iFHcXweN7ZA
 bSQuyO1ae9pwiJjNtaLlJpPpzwMpo8NyK72SK2h/hIc4RuwSS1X5P5/UyVPIF2GMohub
 ANDcHVb5SGpSSS1PHeuFt9ds3EKvq6EL88SP7Kp1Bg+pWV1/IzaMqdvLT155pDJOvJ2I
 2Z4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+kI9eeB4YeI4aTqx/LZxZbfR5k+qOwARmKdZd1y1vMICEZNAZy+Ey2topY2Pe+lElijE4soeulXA5ddm8fNA=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIm9VcLus7Rsk4piwgoqlO12Xwh057dHFfLeLXfqUuCLP7LFIhC
 /xPuapqwJaKAoBQZAJl4etCugVTp5udzsekDicKE27PYr77exz0XurbDqgZx6m4lTdVk4dtKacV
 8YsnZdjHv1AANmRSabVu0UPTyVrVdTTWMm8EAwGcFF9Ju/8ns0h0mDOWxK3vXadcXERsUlC8RNM
 dgDn6M4Rtxcow=
X-Gm-Gg: AYBFou0UNIPeC2ReWPAZan9S0XnALEb29EwnfoCk4N7YIz+KbtxCJlXK2xGM6/2w65x
 7hMYuR00wdvkuMRXciP/EGUz1h5nJmhnXxveO0REDau7Ksi/Q11ibawvQd5mNsQvFrCztqcR04v
 r8RGLKDgSfsYqHfS3axnGMS9GqfRdx8XgFCLwhTBD++pAXo/9A5HL7h+au29FlFaU0EEBpaLYfR
 AMUuqf26goqVxdld0qANQjFahLPLVLPbjq2u1n2Q6IJ3vpPNyLzRe8ceIdfkNfO/2LEjuzuTx0l
 4nsF/ozYXSOilFX4Uu8uHO13KUZ9yKTG8Rm/cfMoYL/+dwqS6VLZ+AaRGGV5hPj7nO8se7dM8vx
 B8u0Pzw4awxbXGwey3s8zD7r02r+UY6C+MAqfsIZUZTE6hjvTRBD4nBVIOuiNcwVB/Vm5lENSJT
 +QfFawBvSNuWhHh+xyV4woKbnILBAFrJkJAjX7exwGJsLNIEoIXpAiT2xLeK8h908MKLtPFRYPG
 d8n8o6tgqSvrRMe9OHt2LQF7cUYHM+xqBqgrdtv
X-Received: by 2002:a5d:61ca:0:b0:48b:10af:f85c with SMTP id
 ffacd0b85a97d-48e07fcda0dmr8499739f8f.37.1792407154216; 
 Mon, 19 Oct 2026 03:52:34 -0700 (PDT)
X-Received: by 2002:a5d:61ca:0:b0:48b:10af:f85c with SMTP id
 ffacd0b85a97d-48e07fcda0dmr8499702f8f.37.1792407153808; 
 Mon, 19 Oct 2026 03:52:33 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:52:33 -0700 (PDT)
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
Subject: [PATCH 0/5] ice: fix reset and suspend paths
Date: Mon, 19 Oct 2026 18:51:50 +0800
Message-ID: <20261019105155.3793063-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
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

These fixes address failures seen while validating reset
recovery and suspend/resume on a system with two E830 PFs and
two E810 PFs, with KASAN enabled.  With several PFs probing,
downloading DDP packages and rebuilding after resets at the
same time, the logs filled up with:

    ice 0000:38:00.0: Control Send Queue Writeback timeout.
    ice 0000:38:00.0: Failed to get VLAN mode, status -5
    ice 0000:38:00.0: Pkg download failed: err -5 off 267124737 inf 96
    ice 0000:38:00.0: package load failed, -12
    ice 0000:38:00.0: probe with driver ice failed with error -5
    ice 0000:c8:00.1: clear PF configuration failed -5
    ice 0000:c8:00.0: Rebuild failed, unload and reload driver

Patch 2 has no Fixes tag on purpose; it is a prerequisite for
patch 3, so stable backports of patch 3 must include patch 2.

Aaron Ma (5):
  ice: check the full PF reset polling limit
  ice: retain the adapter throughout hardware initialization and
    teardown
  ice: scope global configuration lock to the adapter
  ice: clear DVM boost table before scanning package hints
  ice: quiesce PTP periodic work before system suspend

 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
 drivers/net/ethernet/intel/ice/ice_common.c  | 65 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c     |  8 +--
 drivers/net/ethernet/intel/ice/ice_main.c    | 37 ++++++-----
 6 files changed, 80 insertions(+), 41 deletions(-)

-- 
2.53.0

