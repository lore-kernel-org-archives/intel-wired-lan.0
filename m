Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5828FC5AC67
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB27408B5;
	Thu,  6 Aug 2026 23:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C69rr90J0nE5; Thu,  6 Aug 2026 23:29:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B799408B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786058962;
	bh=fsRb4NZXZerz1/aQRrjBTBFx3aPjqVLYX2/AtW7Pc8c=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HI7/tTuxTs6PtNTEeHJlS4XD//kL2liiXoOCERzQ7IA/Lx+OZ6LF88+pvYQHO/DRo
	 YUUUtbrPY7Q1bE0+INAfX8aWp1Cpx2JG09XiFem+6nwkXXOaGctf7o9sHYexuSLW0z
	 OZvvsAF9Umpk/vytpNlfE3D6+gSHWpSxpKftRZ1XuxQWUna6xTdMqtvK82QpBEomMO
	 47Bnq8GUJMvl0Fm+y0uW9lzalX5hvb9joEyjQgcW66gNcYuJCGaiw3TAaIH8Y/77eu
	 2UbaTJXGu11a9VelQ3RJqbuw2dd2MRD6K2MglLPbaIskASx9vv21so8nu2NH5Y8YfA
	 nBRaDT8hHaDug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B799408B7;
	Thu,  6 Aug 2026 23:29:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 560D6198
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47F3B80F74
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWudk2pO7ftC for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:29:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 56DD280B8C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56DD280B8C
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56DD280B8C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:20 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-667971437d6so3774954d50.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 16:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058959; x=1786663759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fsRb4NZXZerz1/aQRrjBTBFx3aPjqVLYX2/AtW7Pc8c=;
 b=iFA6GSFcZqw0S/sSksr7G22DnkPFpgmybqwCczuMU9rsWcGvFLc3V4JY0aEHYYBEGw
 H3OBivGjtMHN6ias/E4Ina5ev/bFlcJNUr+56meawF8sqVeioU4xJ3Sgakq2RISEfe8H
 D52ILpjQ+13Wun7KFfE+xG/kv/1WK1c1focHHFGr4nGcDtFfRwg8sdbd35DisSnETt3t
 G0hkBGg/y3U+Wd6sRh/cjD2GluXSHP/0+9lJFEaPXFRYFezeVrMdmd91Da/OCKbmZhXH
 HAPvQkBm0LPsvE/dXRZ/VSE6EawdjJJz/hg3062+eyv+F5rD1sE8iuJbOVihi8hmdAEq
 4ffg==
X-Gm-Message-State: AOJu0Yx+YK+RPZlu+s9QZurRhWysWY7d08SEmCQD3S5CI+WQopcuurKs
 cZsEfZ+Nl6aDk8Vgn0rMzyB3rOKhYLjGKAyUhScbTCZxzFmoEf/FJtEE
X-Gm-Gg: AR+sD125hIxfuGtD0MR1wRTHJHwOkUVWtEcMu1efcj0VXafHYDdwjmN9+fxZfKltoaD
 zSoYspAZVpLmTJcnm6/nLjkhXY8BO3+zkyvnEf+ds5El6WXKkNw7wU/Mgqz/qSYx8/K8RvyKUHA
 802na2y8GFXSQFLCL7DBx0PNXyeEiEmgly5efksHVLiVsPqDRKC2eTZSNPnkCjP7ToBH8O5JmbT
 1nRSx51ZniIduqSAKCsV1CTf78i7sIRsEq3N4wITmQ6wZn0y1ddlV9luH1i4EqOEYPoFiUYJv2B
 JdMtytJpOe5Z9aW1vAW8dvceKuvcQjByRL0wTLwVXnToykA5/imMApkolgQs+U5b3fj+fGZwu2U
 eem/EeGtk6MaIyB650gzWoMwIVoA6tCRJH3L/KRtugYBbJzxBnjHFAAyCPLP7ALeBmHb6ZFvRQC
 RFNhSxjrdZMGaHKCQ0W+AnJyqHoUhX3p0lPqbeMFcTjlumQ6VEc8PLhN4aLKHV6NioyJya1cXwB
 18o68NR6PXO2B2Wz8mi4mxFVZd+19hBw09h/fRjGEl9eIWUELs+3vDTIYsFhuJ5WhozeA==
X-Received: by 2002:a05:690e:43da:b0:665:a0c:6595 with SMTP id
 956f58d0204a3-6699abb1fd7mr9337721d50.54.1786058959039; 
 Thu, 06 Aug 2026 16:29:19 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:29:18 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Thu,  6 Aug 2026 19:25:57 -0400
Message-ID: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786058959; x=1786663759; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fsRb4NZXZerz1/aQRrjBTBFx3aPjqVLYX2/AtW7Pc8c=;
 b=Vf/Nx8tdpN58mPT3u5/o7efku2pFAWH1dV4FK92VZVlfEvPXulmHOfpY0Q7SQ12PjH
 uWhm6Or3Yms6R33b8ti7UtcgE5DP/qez2W4/NELHxA25rC2UMJ59Zlj+h9BNUun2gKtZ
 K/WRJgVz2ni/wdatlni0Oa7PmqHiHAoSFNRPwg+O/5xkcQ3bx4Ys0VRpFe4ljQfUyTpy
 hIZAlruIO0pp+OkxpdluOlCPO+BHN6BV60SJsFNAS+gs0F0XN1u2zic5nVDitjTOa8Dw
 eADszdxV+yfA0Q+O1OqWou2Cl2fe0sOiJgGASaWXaUkO2ERrIQKGpiiaZGuTX5DXsBeH
 YBzQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Vf/Nx8td
Subject: [Intel-wired-lan] [PATCH net-next v4 0/6] hardware pacing offload
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Willem de Bruijn <willemb@google.com>

Enable safe hardware pacing offload on a first device (idpf), plus support.

- Add rtnetlink support for admin control over the device feature
- Add device support to the idpf driver

Besides the main feature, also

- Small optimization to FQ offload: avoid unnecessary ktime_.._get().
- Expand so_txtime drv-net test with hw offload testcases.
- Expand pktgen with txtime feature.

Details and detailed changelog in the individual patches.

High level changes:
  v3 -> v4
    - Replace ethtool API with rtnetlink
    - Drop/defer pktgen patch: not essential

NOTE: the idpf patch will have a minor merge conflict with commit
"idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc"
(https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).
I expect that this series will need another revision, at which point
that fix will have made its way to net-next. There is also a fix to
so_txtime.py outstanding, but that is structured so that these do not
conflict.

v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (6):
  net: rtnetlink: add pacing_offload_horizon attribute to net_device
  net_sched: sch_fq: clear past skb->tstamp if offloading pacing
  idpf: support pacing offload
  selftests: drv-net: refactor so_txtime errqueue handling
  selftests: drv-net: in so_txtime tell apart sw from hw pacing
  selftests: drv-net: extend so_txtime with hw offload

 Documentation/netlink/specs/rt-link.yaml      |   6 +
 .../networking/net_cachelines/net_device.rst  |   3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  70 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  56 ++++++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  10 ++
 include/linux/netdevice.h                     |   4 +-
 include/linux/skbuff.h                        |  17 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/core/rtnetlink.c                          |  21 +++
 net/sched/sch_fq.c                            |  19 ++-
 .../testing/selftests/drivers/net/so_txtime.c | 157 +++++++++++++-----
 .../selftests/drivers/net/so_txtime.py        |  75 ++++++++-
 15 files changed, 385 insertions(+), 60 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

