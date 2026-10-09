Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE79CA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 18:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9B50812C2;
	Fri,  9 Oct 2026 18:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IrW9PdxCaTGP; Fri,  9 Oct 2026 18:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08DC5812D6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569786;
	b=gpoJ6WhkEfc5O9spPBm/gz0AW55qcNiIeDoPcH5hq+2fJurZvcb+84sy1Fa+sAKZ7GKG
	 EGDDMb1jXXXdEpcopviGFxV2oyYN9TW7C5MSn1SLRvrv9Q0ceP0abVWSULZRoS1++X/EL
	 mFXzHP/y4Cexf1qc/y8tvEN/TXzSMtTt/SOOaFRWnbK8nMjLtxU1vpJC+aR9mmIOlDeOY
	 B5ddMNEOPVi3xvWOGzQyocniBEW4xDZu8GsLEQ4iT7pHyZqK37WkluejMmkS+6JrxmTMD
	 wON4ZMxw5IIax2s3W/nRBxfqbYtnOPqYr75UW3XzsPXNirTpn+QYxgJmLOOdYLcmTOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
	b=RKZiv5AV3QAnfbOFkbKEKcoU2CFFM1JaOBvU5KZO8rUu65KgcJK2RPyNBQ5W3i76PLfg
	 jLLUtm+5taTrTy3BvDkft2VGLmLG18sfl+1sbWpTFan/50/LksPymdmCH+lVMwMdzOxgZ
	 5LEe6i8dAVyI+y4W/7ZfzPX04Z+CE4aTDV8iF7tUIcK7xKn++SLvwa+rlgQTpYY/zAus2
	 4D9jQWGjxVgC30bAyqNrqYqwMzJ+nTpdLqTtRHzvUG6Q8HXSxzl87tgctwKiZYEpFzEre
	 +ErPbJbvVpFKhslbxyXw+w8ru3Bu+1qj/5pdz5uUEazMrXfK/Sbyz9G8olz+8NYFpCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uzLiDWpH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791569786;
	bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E8C2nYdnWBH4/ZhFRd4bunh0OHPn5rueBhHM49AZ8yem1hfqLshj6fT7VU3vepHhP
	 VfCxlGDdwCsX5WrJCOAz9YwoQT1RscMklrE6BttKKPYticRfp4EHXzHNXZXmkxsHIR
	 vUPTwZaA4QemlivVLcncHiZHYbFp3iID1wsPkimPt8JHQUtXK4EKIEhwpOpD2fzkxM
	 xLullVRADN4eGhRic7zwdRvoLYMCUb2hhwxdCgvG2o1mxeGkYKHogqA0feBaInCYXN
	 MZnjU0DgprszZ7uUqGPMY/ql1A4ZDcENeG3Q4+uxgmEdScV3DDPy9Tw5Z/uFwMIS5C
	 WkUbgnEVgzXNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08DC5812D6;
	Fri,  9 Oct 2026 18:16:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 83E1E13B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 18:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A964812C2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 18:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m1s5AjM2WRne for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 18:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DE0B812D6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569783;
 b=NHyvPxTRFhiqiRo6QKJ3eDH3OjSNtVyq9r11rTPFaOX4pkR3za9HLQjFrBYauUaZoGe0
 yure3mhtkJOLJCO7wB8m8Lc9zLOlNNxVx/ZGtlYgIWmqR7h0g1T7XJYxXKEeYN5OM6rSD
 mqJO6EEF8nOnkM4Cs83I2Tr0Li3eIp5EkAYRevGbt0wEtgg1BOR95itHz9DiDvhQ178rA
 py0/Alg+wwAIp2odlqlRZVmFnmNcu6D4RgqcFb+8Vl4vskTO7eibXx2XjpRVpGacrqrXw
 7gvD5Kz+T9mN7vhKsxna+3erHl2KHNd3YuhVcx9pz86k03j8YRRG9YtaTTKLlbFhqAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569783;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
 b=SnD8jLv0j+6/BCL5soaY+GVvmP1J/j+q1k0VVK2PKpVG0Elgl+rNthW2rYq14Md/Wbp7
 t3kpbCk8EjIa/z8IKxGD/PN++KgPLrr0BBona+bTPEuNmsZjqlc5jCFBhLQYJmGu4lLAM
 8BSvUmpx/zj/ZdMfL6YFuCVljHL9TN+BiPRNq+9Jo+flykQUfRjTtrdFs4NxzGdMcfJsm
 p33e72U2uVLXpeUf/DFjAiselvIJnGbafWyvQ68ZeWhXCak6bq6LpSpWm9xdhk3ceSsd4
 niA86RffBt5ny/VV/SBkMxGka7pBLBR7CByw8x/AtibDi8UiE1NjP8U6p+68fpRy+rA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=uzLiDWpH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com;
 envelope-from=3di_jagckd1c0g7zckk5dd5a3.1db7ci3a-l7g32-azca7hih.dhjdha.dg5@flex--brianvv.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=uzLiDWpH
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com
 [IPv6:2607:f8b0:4864:20::647])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DE0B812D6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 18:16:22 +0000 (UTC)
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so68900425ad.3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 09 Oct 2026 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791569782; x=1792174582; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
 b=uzLiDWpHWT9UtQygEkb8IJwni0/Gcplrc0fVKnR9ZDpeW6a9AbbZmO47lf8sTX2bb6
 mrgRHBjlkm/CttciPwcPUtGi8TalXYRWpBHPj5AG5cHoOQzflb1o+n5wpBYLLgSHR4qd
 gAT9pyyBKp9nIeexoucFmubjRs+HCq0QHLSrwO5OlywwZwhb+iowsAa+qZAgf+Qw/7Rw
 f8QjaOsrWLn5Tl0c6aNv4RQvh4Qz++ikxz2Y+cg1IBFhxsmj4wTorl2IhGTXQLYS5DOO
 R8rDc+xQ0kpyckD9+Il4eOBVRts96wgHZ7kjwcIIaBwc86urw7sP7k5jxfQv/0cqvpyg
 XCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569782; x=1792174582;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
 b=AqXGlw0cHJcveLfo6z3nnTnU2Lx8398eoa55J2SHfoz0rb03IH/xKJHhdjRHZ6zjGp
 fmU26xifZnykr43Pp3T0OvubwEaiEVwk/lmuc0oqU4/GvGkORB9CrdrUhemUT2DGrmuS
 PCifFlSubmiduwUYOSkC5pljb3hLAFH97IsBo1BqMELr+2d9F/z5D7vzRF/Cpxkgkz5D
 4G8XhkOTJEbi1yw3EU4QCX/uOEx/RVPY9YekbP3KgEbOLqF8rUWDzJdeEpdgcEgQQ8aV
 AGfvgT1knS7s1poUXI90lGbLVMP5RfAc16TsKhVbfsZrvgK7W13zS1E0EieheGetqeax
 S6mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByzhJX9798NyPGiynFiD2G7f2dNnx59KVnKRZ12PWvCSYt2UQZ6lJpN1P/sBjDqb0mBW6UVGXwj3tUwwWycVgc=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLweR1rSxbGPyKTeiRE1ZqbrFzWCCREtx0iEgMSyrSWmotNJMoT
 D0wAU3KH4BH+frMW5qZgneY3tmxtmCkaTM1n30auCDWrk4oKNMbsnDwSA2kjXn4QPvN7PWV9pFr
 g8Vc5fEKqPw==
X-Received: from plcf10.prod.google.com ([2002:a17:903:104a:b0:2e5:6b23:1f55])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0d:b0:2e5:6af9:a745
 with SMTP id d9443c01a7336-2e842ac678amr21256985ad.23.1791569782074; Fri, 09
 Oct 2026 11:16:22 -0700 (PDT)
Date: Fri,  9 Oct 2026 18:15:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009181553.582029-1-brianvv@google.com>
Subject: [PATCH iwl-net v2] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, Brian Vazquez <brianvv@google.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
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

PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
function reset progress as a 2-bit state, not a flag. From the IDPF
specification [1], "PF Reset Status - PFGEN_RSTAT":

  00b - reset in progress
  01b - reset completed, written by the control plane
  10b - function active, written by the control plane once the function
        has completed VIRTCHNL2_OP_VERSION
  11b - reserved

The "Function Level Reset" chapter of the same document has the driver
poll the register until it reads 01b before re-initializing.

idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
although only 01b carries that meaning.

That only works if hardware moves the field to 00b as soon as the reset
is triggered. On the Intel IPU E2100 (8086:1452) it does not: PFSWR
transitions PFR_STATE to 00b only when the field currently reads 01b.
When the function is active (10b) the field keeps its value until the
control plane finishes the reset and writes 01b, which takes a few
hundred milliseconds.

Consequently, on a hard reset of an active function
(IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
reset is still being processed. The control plane tears the mailbox
down underneath it, VERSION is never answered, and the driver sits in a
60 second virtchnl timeout (-ETIME) before going through a second hard
reset which then succeeds.

An FLR on an active PF is enough to reproduce it:

  # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

  [  299.685030] idpf 0000:01:00.0: HW reset detected
  [  299.715710] idpf 0000:01:00.0: Device HW Reset initiated
  [  362.916087] idpf 0000:01:00.0: Device HW Reset initiated
  [  364.318246] eth0: (slave eth1): link status definitely up, ...

Nothing is logged during the 63 seconds; the timeout is silent on this
path.

Make idpf_check_reset_complete() wait for the state to be exactly 01b.
This is the stricter reading of the register definition and it does not
depend on how the field got to its current value: functions that are
still in progress (00b) or active (10b) keep polling until the control
plane reports completion.

With the change the same FLR results in a single reset and the link is
back after 1.5 seconds:

  [  206.856635] idpf 0000:01:00.0: HW reset detected
  [  206.887106] idpf 0000:01:00.0: Device HW Reset initiated
  [  208.368721] eth0: (slave eth1): link status definitely up, ...

[1]
https://github.com/oasis-tcs/idpf-specification/blob/main/idpf_specification.md

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Li Li <boolli@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
v2: reference the IDPF spec, name the device and add an FLR reproducer
    with before/after (Paul); collect Reviewed-by tags. No code change.

 drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..ce8a1bd0ec8b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -166,6 +166,8 @@ struct idpf_netdev_priv {
 	spinlock_t stats_lock;
 };
 
+#define IDPF_RSTAT_COMPLETE		0x01
+
 /**
  * struct idpf_reset_reg - Reset register offsets/masks
  * @rstat: Reset status register
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..92eb3e9de77c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1874,7 +1874,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
 		 * register for us yet and 0xFFFFFFFF is not a valid value for
 		 * the register, so treat that as invalid.
 		 */
-		if (reg_val != 0xFFFFFFFF && (reg_val & reset_reg->rstat_m))
+		if (reg_val != 0xFFFFFFFF &&
+		    (reg_val & reset_reg->rstat_m) == IDPF_RSTAT_COMPLETE)
 			return 0;
 
 		usleep_range(5000, 10000);
-- 
2.56.0.385.gd3acb90ef8-goog

