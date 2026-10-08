Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF4CA6011
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 17:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B114C60808;
	Thu,  8 Oct 2026 17:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPATxDMblwvv; Thu,  8 Oct 2026 17:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0197B6072E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791480841;
	b=GpepylNbyGXrb85N/GfSMa7ZuyCVpbaA7wesQCeoVetNYU7W//USP0DgyltJFUVqpDUW
	 39q56RbYx+lto5rmJnI+AHkEw7dtreGRZeb5oe2Z8WFhTSQ6prLAVX6804eKs5ZzTqn4t
	 6kZKybkdTF+PFN44GOGJFx1mUOKQQdCOtZhDYewOKf6Bs9nn5GBq/jqXokcER+47TC8ZO
	 nY8fxlNWUhOnHU7RmvfggCRB9FUGpBK1zV/tOfPPvJVzeQAmneNF2RQ96VvyyMUSP4hfp
	 UI1ZSEk8HO4S7p+LY8gKojQKA62ePd0pz1tKgVIOLhMYwnLFEuaMF5GsUpxuBcWPrvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791480841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oL7DYN1cPQUBG7i6wjoO+oNk4/EoYeE3qdEtA4etZEc=;
	b=SLntbTWYiZm7YP+E41mJQN7uv+a0HAIrIXAxHsmloamGT+GgZ6Mdg/qLDVolnQ/SKPWm
	 O0dJjzzfFGehHiEe4zmrlCqGSN7aZamTgBCPgW7fGg19cCzrBo/9UQY4YzkBPBbcIkobi
	 YSL9oL26ZBtWYrUzp5zm1xwQ3lYVMCCQRY3cE4C/eXgOXtkuK4BWua9QsVNcfWKXCFpen
	 kEghA4Gl1hmdv02cJvxvBgBzcAdeCzpv1jW0DQtuZqnh+MpIC9Cgkf9rOW4rh+DMrfjJE
	 E7Uzi7widVolMIxUHHw4KVrABNSZnw9GSzysVi0G5wwvgb/WvUXefbHvHLrBGU2S4mg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791480841;
	bh=oL7DYN1cPQUBG7i6wjoO+oNk4/EoYeE3qdEtA4etZEc=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eju8TknZlYKBDSG4yK68G5/vaROqBznNjsXEuW8dWd2K4E7d92ZRjdATBok5KKgIT
	 YIb1zesVpBN+W9+vH9+bfjLU9935KrBTO5Dftk+buEf2MTlecUzuXjZk6i1Z++TzwY
	 5pc7sCdfGfCOsjks/9TJ9D4z94M+p4dtHJSjBYU3jD/gBrdySnQVr4pl00YcwyZYK/
	 5M13AO3/KaIlIeCvbhsIOKkg9ch2dlMuukvDhIZmuLTNj4LGMcTmFjX+ltQHOSzZz0
	 076FHes4JFs92h1cwAwl51YCsOpKknVxyeD8RKAYr9iN+6H8xJ/1WWrSrp0TVHSHoc
	 2DBL/Ng3JHxlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0197B6072E;
	Thu,  8 Oct 2026 17:34:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1B151A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7F804016F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIafobAPAJgX for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 17:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0B6D24008F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791480839;
 b=Rxj2qIefGlf9SJ/mjfah3MRmjTvQRjxV/+k4/D6KOR5SZ/5HdG5qy+ppES0usHPekLhC
 MO/JbRXdLz21OzI3H6S2ASIU/yYy2/T/PYRgDoLw8y7mmUwtwqe4foxhNVeVlKMhN39u3
 XPpc+QGl789gcthokz/OXBXdnfa4RzGY+X/3buhvGmRhyXse807Ad3yKdqF4PsSZLU4Ny
 Im2RGSpBrD5FK+3MO6QeSmyp19xNe/uU38MyMD07AL4kfjpUOKmuspsZyovN05sMRYhTl
 ZO7D4Ys31Ap1XV0/uxSj3JaKy1FZ60oj1NQjsXn6rshOaLW5QVvE1SLIWucHu95RLmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791480839;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=oL7DYN1cPQUBG7i6wjoO+oNk4/EoYeE3qdEtA4etZEc=;
 b=oKQ3V+hYVv5GF/rPCAChC4EQQm9FzKy0eSCCQ87abrmiJy3s4aDHo3ai/3ADNqZ4YydG
 ENJ2NsKmrl7lkI4/zDBrTUX2KDGrTYVxupWGOl+CdNnREZ8w0bwnknI45ld/j5LkQRxM0
 LO4jEhlKQ2gq4Ev9Wq/vp4zcvsxUENxeqew/GH+FFyE9JShrUV6kCgKrVLWvzG2r0OZVX
 XU0zOm+iQIdrqtyglL895R2h6NWc7ErhyEvSx+UlO9KFv9CWXJ9XZBhaTPIRHCmpKSm3K
 yrche5kgFO9lzM0syl0HA0Yjw1Ij0tcBv77qQg6b3063R/I+eeuWxl3HjaYPFAVoiYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=pzRd5L0Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com;
 envelope-from=3bdthagckdyohxogtbbmuumrk.iusotzkr-coxkj-rgtroyzy.uyauyr.uxm@flex--brianvv.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=pzRd5L0Q
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com
 [IPv6:2607:f8b0:4864:20::547])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B6D24008F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:33:58 +0000 (UTC)
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cd0bb99c975so1174303a12.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791480838; x=1792085638; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oL7DYN1cPQUBG7i6wjoO+oNk4/EoYeE3qdEtA4etZEc=;
 b=pzRd5L0QJVWPg28/tHtqLTA5BkT3nc5bX5iI9NBnK1B2dXxN9b0aHqFjLPhxVoJx/I
 j122YdHnNCMK1P5cELUgMKQSdjWDyhV473OnfYn0LbGCn/N9aZJeD+2/yOPd9M8fZWQ1
 8srKmcw4KKIsgrUHKCf08Tk9PWhN/lInQuYcZHrvNtmX3/5hQVi6aD2Wscr8Q00jn8t1
 HjR/jcPcY81UN0yTuwf1mPVyU/UXgDr1cNuXKa+vOtli5c9kobErEqFcvomCrwZ4SZw6
 I5+Ud2II7gIRjAw1HALq+JMu+oHoIQufBsJhumC3NxDdKUYHEU1s5YowbHZt4tqN26Zt
 gyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480838; x=1792085638;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oL7DYN1cPQUBG7i6wjoO+oNk4/EoYeE3qdEtA4etZEc=;
 b=ppA31KQFo4e0qPDx0Jg8fjuQDJaE3o26nqHACpwiY48R1CJIwVC0KABIbAJe57jpu5
 QOy4ZZw5J3lUFlj+TEHesfwhDmJfxZYINCmczRDFnG9cxTT86U2I/3JWJ8dE4GFseQkq
 JknJEyH+5574L/7Qq9gUzz7rJBuRhjpOR2X5Bu1zQVHB/GDk811J1/DZxBgf9BZ4SyUt
 /E08T96fqt640m08TPIjmF2DjebrC9ziF1KEU/kWvmcPUuW1TkpgPr+ScVjaChurULHu
 Jxrtjx4dkNpo/y1EVLKHwjFGQapYjCIKHVTrGqXXuONE0UTTI/acWFMA+cZ34rxjdgM2
 Bt7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWsxhoBFNyxmt6N2gdfe9IcwPwv8jt6eoT05fC2Tl8SnAS/36yz0WrE3vcATiovjrFswu2o3lXk9IBJ8x4ciA=@lists.osuosl.org
X-Gm-Message-State: AFq9FYK0ew6PrHkcqzQ9M/ugfGWy2as2l3XDOZU4ARcYi2BL0vEWEgjm
 Xjlx0jFRkCojoqArDNLeh9hvbRpppd8+zOg4rWo9nGNAwOH3tcvnC4GQemGA20ww2QGFdeKVz3F
 QhbKZUFusZg==
X-Received: from plrs9.prod.google.com ([2002:a17:902:b189:b0:2e2:f2a4:dd99])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d983:b0:2e5:4604:c375
 with SMTP id d9443c01a7336-2e60056530amr54905285ad.48.1791480837419; Thu, 08
 Oct 2026 10:33:57 -0700 (PDT)
Date: Thu,  8 Oct 2026 17:33:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008173334.2881475-1-brianvv@google.com>
Subject: [iwl-net PATCH] idpf: wait for the reset completed state in
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
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, 
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
 David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, Brian Vazquez <brianvv@google.com>
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
function reset progress as a 2-bit state, not a flag:

  00b - reset in progress
  01b - reset completed, written by the control plane
  10b - function active, written by the control plane once the function
        has completed VIRTCHNL2_OP_VERSION
  11b - reserved

idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
although only 01b carries that meaning.

That only works if hardware moves the field to 00b as soon as the reset
is triggered. On the devices tested it does not: PFSWR transitions
PFR_STATE to 00b only when the field currently reads 01b. When the
function is active (10b) the field keeps its value until the control
plane finishes the reset and writes 01b, which takes a few hundred
milliseconds.

Consequently, on a hard reset of an active function
(IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
reset is still being processed. The control plane tears the mailbox
down underneath it, VERSION is never answered, and the driver sits in a
60 second virtchnl timeout (-ETIME) before going through a second hard
reset which then succeeds.

Make idpf_check_reset_complete() wait for the state to be exactly 01b.
This is the stricter reading of the register definition and it does not
depend on how the field got to its current value: functions that are
still in progress (00b) or active (10b) keep polling until the control
plane reports completion.

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
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
index 2c148377540c..a827e0fa67c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
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

