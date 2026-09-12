Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180B4C88E75
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 15:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5DFA40462;
	Mon, 14 Sep 2026 15:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9jDqIf69yf3V; Mon, 14 Sep 2026 15:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 023B3404A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789399545;
	b=KLhkNdwQjKPdBMYOeZWGCg3f3zy9XaKS7k72g/1lN6nEXfj9nt04e5X638cwhNBu0vG9
	 5mAKxY1py8y7R7iLPCpwmUVIzV7jKlCCMG3t53WZ2epMd/FJNgVMkTJjErHljBKLgGkHr
	 /tvT9MGeD00/66Is23q+jfOD4NI6UeB/vSJhNjkpCr1KuOGma7h/rTfK4/9Wi9q/TZ2Vp
	 ZfWwLnklZsx1B9r9cqfma7aLwkMl++DX5d8DXTZxN+zhpeLWegaMF3cqV4yXr5lbRAxqh
	 6cucYjPSBeE/tr0atlBxl+szgeGMuk2fPayHcxwzd6AGmsfqvar0s8zprpQM0+sFagQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789399545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
	b=SneuruNCmPGSjfqUeiMomthz9IqCzUYY62GsAK4SkdnSY84I1wcQ6VM1s8eqTyzSz94F
	 Q493HkRoX9EvcSYF1wejST/Wob5ylEiTtw2wVqCivrGBRSB9ThOyaZuqR475VgbARdsp6
	 HWWvRZ9By0O51ZVtVIJzkUGa3NAtN71UiJC+ItrQMxgpMBK1kKo2T7b50ruvgifKXmMw6
	 U+V2ACBd5zanMPNqJ0hyf3TyByhGDaOMFKFwRVOwhklmcgPAYG3zgoW/Gp0ERwc28f/8B
	 M3iTSxkDIXaJF/s6tWA/O9/gk7GfaYh1CQuIU8+HeSEpGInkQ0LnNKxWARdf7/3vxog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789399545;
	bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w+ZRt+7NGCQK0MmYC8YSOrV17lVx/VOpgwwKubY7b0jJXbZjZR/QL9qcHmlVOF0+X
	 i3L0zYJppLqWf7/JyvSShrRnK2WJzu9LIaVeE/lgfqyOIKA2tO3hhwuNdpfjhd/C13
	 sxfYcJpcUqZVrqHHTnhuipH4kIlWBMU3uQGWJ7RY/vUfeheeTduxYhWFQqETgMosdP
	 Z+kyJKfimQfe/AjfMVAcnjk+hueidECREmqjdkHos61fBb1yC9ni6mPb6pyvgVxi03
	 5fyfV1TJvrv0nWWiiKeDdhIFJdraLUss3lYP5FLIj4zOLST8M++O0+djRHyAYRQXjA
	 8HuxrO78+cLQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 023B3404A8;
	Mon, 14 Sep 2026 15:25:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC384EB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B287E400BA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5ItAXv8tLMC for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Sep 2026 13:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 798C440068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789221039;
 b=bidXImiszK8BphiWgWEzHqCjuJDHRd/hx+qE9rpRLNoMbhKFpu+L008bemZye3FlaqPN
 7VQv4WnuJRuscVlKBXPN2NMoACwvSInPapXy8nHWgIYnas42JIpJZ80vzMnJXULXLfSy6
 q/k3VdKzNTRo3yKmEE3wVdgsYTfB/KtdFHj/wYOBMOFMovBodiil0J1BR6lMs8hwN3gfO
 fFRf1HQ6/JTl5ct3G83+5hEtD4SHtVfx7vtAJXCyxPbpZ1QRIkIgq/1pdpJ5CO5R9WhOE
 2c1v9bnfLX1lHVLofF8I5vZq6FrDIfQEmHIRlw/065Jy4kg5RKnFiws934Iqb/z6Rxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789221039;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
 b=m19ogbRBAdgGXj42PHHHKiNGWt3/TBwgDT5UVs+vXvwbx1YOLbFvSQWP8cMK8MStyYMI
 As8cnlgK4omyWOZhaobNUUe4byXpG0GstAr+CIYbgwDFv03V+T+d+MpFvabgmc86XgfEq
 OZvYr88RdTj2DUUS4Ci3/J+XVHpRNSPLmAxz8bsu4GMbF1HoXIa6O8Hoznml/kR1o1CrM
 r8/Z2fAUl9w0C7WPHwfpQfYxLAykxOO4dCDZH0wtIK5l9MSy9joFL+SR7V6V3u/B7NJb4
 WYXOoviELUy5XwvTCs2YJmPpiVm4/t8cV9Denbx+d5iFiSOrInl3DcfKVWVOh+CqksA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LREX+gsz; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=iprintercanon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LREX+gsz
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 798C440068
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 13:50:38 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b7be8dbabfso379810e87.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789221036; x=1789825836; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
 b=LREX+gszp8EmGatf5Rn1pCGkiw/mUilfj3AVb77Xsqp5fvAZVXsFc6l00WBEQajs2a
 4Fe47vyvaaMZrVsAsqjitev3raJvrfih2lq8RVQHuTETUjFtJ/zcpPpz2WNcYloOWSHM
 71d2a427UmkQtzgEOGvbnWOC2hls9iHxx0tT6SUFs9jTAsEs+qcelB2R1kzeSOZrnhJp
 0Mv3JMUwOrDNUHB4J5ZCY22nQe68gc16lK8ivE1V3cJyQZx3IP75KFm5q8aFVEq4URO9
 R48UIsFg3Xp01xVmHBdZbCGu3GnlAqDrRVd/PdDBElkuFMKL4y0mlCFOKP3dMaKJphwv
 QeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789221036; x=1789825836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
 b=GsWYyEdEp6lgF9Z3lxn7vCaVyKiY1bck+p9s5HVWaYibCv1CJDS9cTP7pukrkC26I+
 /+oB7fCqheyWsIyF/42+QdQoiYYeWzG+zMJFlCbF+Z8szbB9eLDfzoo225u+2rt9ah3v
 iF8t6JYK/fN/OHoVviQ1cXTGbGduvCNsFzT8sIMQ/rQ/C38KyXx0GaBER5dW2Wpo5/MG
 PETZiGF5bdDsc1Cl6kcFTINQnUL/RsAue+k4ly59SakSHy05rDF0Sx6/AtSZnpih8aGX
 VZ40IwNnbe68Ypp4e8hHOYD/z7RCgSarnKosbKw8O3meNKsJAvBCb2xqF3QzWN5/Xbpd
 KIFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8uRlDFcRZ8AtrbAcJPwOhVmjoVtCunGlU5yC5L38g68HlILROqbtXOHzxnS9RTR773kwSmdrAtzOrWBwQS4s=@lists.osuosl.org
X-Gm-Message-State: AFuF++mLnYCJLPT8xkcA3Bv3hAbY1mejmRpfE2FyxvJqyNdyk5DKaFjg
 Lt7pSgpME2fdzFeA3QjRpwjaq+61Xv49WTe1EkNCHeX3WOimi4bzgdT2
X-Gm-Gg: AYBFou25vI3K6/IWe+265zmGPAOUkcK5SzhpU7AnpNhEYZLrtq8p4GVTWnV4Ib/Rs6c
 1Ab90Wu+EvQJD4CRbSR+LoXYcaOdpA/ugnJkoDy17kShgbV3QNm3QBILr3QMVXjRDY1Lmtwk+uA
 Cvh6BmRqVwvj20HylVMVB2RfrMrfoUg1YvvesLydURJHJyaxJ2I5GvC0zFsGHZJdSSrH3YmKeMI
 RI/TIOGy5ZfrUTsCwVGcWrfu7g/zBsNfFbE1YaUKJSNSqXhKyFhd2xgVSm2HCEqgUOAx0T7EB9S
 SlgZSR4IziD3gFARnrgHiBtRIj76VJ2oM98Ry/DKNNUaV/iXZdQ8wKJ2YUGAxXiMNZj54N3AaWj
 BmtqoPqoGsjOcrSQjII0RVFXiuq8uuqwBSw1j9mnC3wElMPHe/k2uECvcL46Zyu2Hzqw6vla9G1
 aUxGl/Ko3lwHZn1pEqvHYzrycFemsTfCqBBCCqgE2JHvI4aJkXZiVMpSdgZtxUhmd8tqPDAEQkq
 gwmp4eeOMrzFVsVxJLXpouPtfZKGnGRZ+/CXcATPhkd2GM3hLyJLdrjCW1zPZCAjQCK
X-Received: by 2002:a05:6512:3e24:b0:5b2:e947:b3de with SMTP id
 2adb3069b0e04-5b8a8ebe72emr404733e87.7.1789221035331; 
 Sat, 12 Sep 2026 06:50:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru.
 [46.138.187.224]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 06:50:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/2] bridge: report an oversized IFLA_AF_SPEC nest
 instead of truncating
Date: Sat, 12 Sep 2026 16:50:20 +0300
Message-ID: <20260912135022.1701-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 15:25:43 +0000
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

v1 clamped the VLAN lists to keep the nest under the u16 nla_len.
Nikolay asked for an explicit error for both RTM_GETLINK and
notifications, with the extack set by the bridge itself. So patch 1
plumbs extack through ndo_bridge_getlink() and patch 2 returns -E2BIG
and points userspace at RTM_GETVLAN.

v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest

 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
 drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 drivers/s390/net/qeth_l2_main.c                |  4 ++--
 include/linux/netdevice.h                      |  5 +++--
 include/linux/rtnetlink.h                      |  3 ++-
 net/bridge/br_netlink.c                        | 16 ++++++++++++----
 net/bridge/br_private.h                        |  2 +-
 net/core/rtnetlink.c                           | 18 +++++++++++-------
 13 files changed, 50 insertions(+), 31 deletions(-)


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
-- 
2.43.0

