Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A2CC982D8
	for <intel-wired-lan@archiver.kernel.org>; Sat, 19 Sep 2026 13:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68989405F9;
	Sat, 19 Sep 2026 13:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aitxOrk7mDw1; Sat, 19 Sep 2026 13:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9D22340606
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789825435;
	b=pEoHuJq6ySR66189Ts7V+81LpNG58So5q40BLSfkeWR7iqV6d4gYgQG+UTwwbskJgY+p
	 Z/0JtgbnBJDpDNGtNmybkTf4SovJ5EcZPVmDYoW5G2MeCnBOEhs4/8xQczfz5d2AHtPPE
	 pGvK0F/9wYg/XUMkpvhFKJ784TmzJLRFC9V8kRk4gdP+BQQXv23KXit2dUTRRTlasrm15
	 3KrTkWM6B39idvuaRQICN/u2rl8wu4/zQ75LDBEVOLSscKTI2E7yswTISc0PuV7urSQ6y
	 I+PGyVIgl42peO86EwrflG3BI4P5BcFdOqYB/zKy3YTNP0z8b97zasYd9feZLczpYDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789825435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
	b=bQg1uocQAQJxABI3dCgYUH9xHHKC6DH2kLo79PiOw7yI+XHDLj/IQBO6r8bBSVUgxGBt
	 ioGN/gXJN0KWpF7YTRDgt+kVku5iGHA4DqhLNGLZ/FYxeTfbL1eqEmTNe/usrY7tBH3aS
	 yrK2uYfzdmUNNhjoLrwD0+OeXSF+EAthJocpdcCCIXfg5lKBNt9Ij+b9xmuOUNotHGuOO
	 PXmkNTyYSDbvrBtRDggbFD2cc7br+zDl7OJTnF/uO/7CgcX6TWKLQ2DxI+6wA5Cl6kvH5
	 eOmqZO4ZDPjqlW8B5bcQLqtzCKJudQuPxJ1rMz7fiEKb/Zr/thFeShkkxMbY7eCgC0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789825435;
	bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mZXdn9xq+M4CeZmGqLjnhTEwcZZEcBQVb1LAmThBh2OTeWbo/ejFCo/LQj1U/Nl6F
	 BK2N0cdRiyjL49/J8QOjmA9rYDgfEBu7xzv2TK9/3GQtk52rEfcutnmqHTEyfE7GFA
	 nJsLqAK0Dh9V/LY8oqlpxy23UFza5zg8A/dwiflAOx2gHRXQ+9X/IojOeDwoYZGJk8
	 VMboOLxjFhkr+7tpDb02TpaIHj6qQmXxGtQJxj/ntTr/nuiG3K2XVZJ4or7nsYePpB
	 xDYKRjIu7ldqqTtHclNs9tN2ONDRHmIVB4xj/eabgcSqN06PjqRaIrnogMcGkIEtcV
	 jAxirZAtg07Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D22340606;
	Sat, 19 Sep 2026 13:43:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59AE713D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C4936066F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3IPvEj-D6FC for <intel-wired-lan@lists.osuosl.org>;
 Sat, 19 Sep 2026 13:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E16276066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:38::1d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789825431;
 b=P/pjP5019gLzpRf7TzZth0ICIYyZgdinQ1Ao7mLd4J4NJ4mjs4CM7764YPG5rmc+kY6D
 ofweh4LBj17UgKp8QoH51qDYgQRdtc3aqpw1IYkprbRUhs1hhKPqP+nELXcSqJUOSmKAB
 GpZgx0PPUxmDqWQfzO3w15wJUIRvXS6xmdQQ12CzM6iwjZ3rRx8ed6etjJi7yFlTCIQO0
 EWu5gX/JTlmWoMvRb3N6FjCWzNLIp21fp7fGckVzJ2r059VAKwhjE8QraO75MCPjbWVzP
 heGm8S7cF+qhSDJMqOmiFuIbuHFdC+6B4kDQ/5PBYWdAHYXdECO5qxqoGw15GI+Q5Hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789825431;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
 b=lTuafAr/mdrhACmDyEyBt+BPzioRl7zo6rvg9J3az0fQ3PlPgA1fqkUCpZWUOUBvcPD6
 /GNouz+MQrKvrSvt5TzYF5+Q/tCsB6GVD4fu2DNkLG2DWnBpoLMoLUOadosjQj1L4cujE
 jsA0zp0Kbdlw2jkI6S7l+vMhEJ4xANykgs0uxdIwGJKSPZMbNouzRIbVf436t4dGfL2GE
 Y1Sw2AYhj1vDNq0vw92DWLo3qrDLhZ+NYW6N+5NKauGQrR91BmBFj+H1z2qSON6ONbPCp
 XJa/y8NzegQePNRHhTX9+kMJoBoqyjb0//8p79ap+HBiF6IXJ6VdjXibXhipBx0hiig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m5TFadvF; 
 arc=none smtp.remote-ip="2a00:1450:4864:38::1d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:38::1d; helo=mail-lr2-x1d.google.com;
 envelope-from=iprintercanon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m5TFadvF
Received: from mail-lr2-x1d.google.com (mail-lr2-x1d.google.com
 [IPv6:2a00:1450:4864:38::1d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E16276066D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 13:43:50 +0000 (UTC)
Received: by mail-lr2-x1d.google.com with SMTP id
 38308e7fff4ca-3a5d4688decso16488001fa.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789825428; x=1790430228; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
 b=m5TFadvFtXBB/gM4eMWOUgmLzfhcYLBa1GktBhwoC8CF7mJJA+lcIklyA470s6flTn
 lXDAd5NMjmo3zjvlmANoCCBCF3ST5Trpwouop9htLzsLytEbr2nmTermeK2lHyekjc/j
 dvZaqMB8wxD66aPxxFGMQU7ICdVgZ0XfFcx2zKn9MyuhyOysg86h1d1q0o45m22FwsmK
 ddjczA6oHYESHUCT0UQcFPIRdIoIlmNgWFaF4+/HiYY6P2Etc5YIoV6EDQjblR0EUWUS
 7cmnv2fIlsX6firwQsV7IvZiVFjqYXKXO8I+XN0AhuK0r6Whr7uFwM8pYwI8XJgd7wG1
 ekqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789825428; x=1790430228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
 b=qtcrE4gqVJwUagRsw82xuYnkmu5xqyQLGNL3u97jicXcNnX+Oy92OsSqBNcUsL1IKF
 Laewipb91/pn6Udk3v8Y4kFWwSxkixyssb7pUkaxzHxrC1uatTUpBPRvI+RfNMoznXva
 CONKcH08zf0QdCbyFg3al5LomQiEr+prOwCsxZDkXawGb+iwPp5K+lAcxH7ATaVjDlMk
 wGAk4HL6kEef99yVU41BI1vYpWmV3SScpgYq/r+NujitbvEpSXOcDHDdA80I3qr9mG1f
 QOLupjVfaAx1cvuK1vCDtKEltUp93qL8K0J4yQGqSH0s2/wbEqvTQLFi40dWr8BtAl8Y
 MD1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi00NH621TRx39YXkCSndlwvLYaTAkdCUUTpEscn7KV3wKjQVppdDzC7VEmrTjj7plaJwoBwjnFfCfbC5e5GM=@lists.osuosl.org
X-Gm-Message-State: AFuF++mNLitnQv6ZKFkgT16YX6pqgo6G9/Gcs4Ysc+7gqxTS26/Dyr+k
 e6f+emTfnvm8hJzcSY/ghSZnoy/KgTNdniT4lyVv42kiwrQxjkDewzJw
X-Gm-Gg: AYBFou37vm6m8RCPbcnn9Zidn1kC7sQAIeGh+0g0yzhJx+cq7fqz8gXn9eAaxeWu4Ip
 K0+f6ctU9jqEnW3bBhbPL/GVq8PZHzpcbvn4/qwZ4rXZcgTg3TAX6Ts3sfplyRBw/+eEWivB0yp
 sQYTkFoHSfVxjRmvuSUFWrrhxSP7FaUYYLJ1pa5rfJHzxLJFm3bfNeHT9h6uijm4DfXVi1skoTF
 scDJNEpoLZzu//I+dA1xeBe6eZFxRmJuyAkEt3Mio0yB5Ew4WBj9q7RFmFODpIJzsi5XTEvGEsH
 +HkK5Dt7MAkeTkOJnicunGlZGkjESFhrbDkBBS8h7aGcE+8vE2fAIw4sNB9G3k8dOu3PaRiY6jl
 fJjIaW0Tcn28aiETzP/yHeBpqC92FHp88zOdc5agYc18D+AUREyPxJHAeW7+p9e5hKkTyNgJcaI
 FOjFmJg5zJg7e6d6sZW+90ErnAjXYpmxWJQQibMQiroQ+0LOK/gUcNYPrrv3i1w6z13Y9IWxtZB
 MNc5xKijsHUHwL9bf2c0asFQr3JXuKx69owJSWIA70iHiV3DpMfCXsXh8x0XWuWFaYn
X-Received: by 2002:a05:651c:2213:b0:3a3:314d:1169 with SMTP id
 38308e7fff4ca-3a5fbf05908mr10726771fa.1.1789825427681; 
 Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru.
 [46.138.187.224]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 kuniyu@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, oss-drivers@corigine.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 0/2] bridge: report an oversized IFLA_AF_SPEC nest
 instead of truncating
Date: Sat, 19 Sep 2026 16:43:31 +0300
Message-ID: <20260919134333.49379-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Patch 1 adds extack to ndo_bridge_getlink(), patch 2 returns -E2BIG
when the AF_SPEC nest, or the MST/CFM nest inside it, overflows nla_len.

v3: handle the MST and CFM nests too, use nla_nest_end_safe() (Nikolay)
v2: https://lore.kernel.org/netdev/20260912135022.1701-1-iprintercanon@gmail.com/
v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit in a netlink attribute

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +--
 drivers/s390/net/qeth_l2_main.c               |  4 +--
 include/linux/netdevice.h                     |  5 ++--
 include/linux/rtnetlink.h                     |  3 +-
 net/bridge/br_netlink.c                       | 28 +++++++++++++------
 net/bridge/br_private.h                       |  2 +-
 net/core/rtnetlink.c                          | 18 +++++++-----
 13 files changed, 57 insertions(+), 36 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.43.0

