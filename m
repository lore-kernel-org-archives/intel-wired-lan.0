Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B4EC79FAE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73E0980BBD;
	Tue,  8 Sep 2026 15:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3Y7IamG7I2S; Tue,  8 Sep 2026 15:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BC85E80BCF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880439;
	b=esxQgn1L5ZxnokuHAPQog1g+/uzXvezdhzIoRk2+Ok99jph6V8ne0S/Bj9DTX+bAwxoR
	 c853gK9nFMMX2Gmzdam/iukdFzlfCJGCp/orryXuAhrRqszPR5F/bvxIPdtlpc1SwCpDv
	 qrxU1d7TFiDlzfHlIRab/NNGUx8L7rXdJMdV1U8JkgWGbc/reDc4iI16KBnRG4lNc574R
	 NdyZGOFe2/D/zAsT/Ml9Q5yaHGh1oTq3gNUtnshVWRjviDnekwoJDAjHSGG90O+9VTGej
	 3foYUqyLSMUcTeAh0KWjHAysVYfnowyoQjcqqEA9dFNnIL98BZ6WhDQczRw9PBlw97g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
	b=FqKpJd8SbjbGfgorlBjllE9SZfVVmMaXyTNEdX5XZK0ztN1IQ8jClWaw0+Mn0/yA7Eob
	 w4EFcYevDpx7wQ/B6tTlBvXP9SCNCfkP9RtBHsDc6hRYLQwt0uxHO1UazIOhOftQQwtxG
	 OYiqoU9C0OtOXzyxNKnJCSoTeh8pqK4o+YFI9wkI4p5ccIsJ+6RotMdYzFVsh+d79uIaT
	 7ZL48xjgb4VK6qfUIzaD5h+bcsExOQM8onuRetWR8R5arDPkh5HW9x1pkzBDXH8t5EJ/o
	 BzsraQPVJiE8HJAmENlntiHJSKyi5nXKEyclnaYxi0UbGRNdzHG4SORAzi3F++iiaBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880439;
	bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=brOP4HOKyJs6CZRM8+5VKBqhLAOm4RkuuQiiEQcsXjx9U4zijthS8MqqaEhkLbhAC
	 rnecPQ64aCUBzf2HEH5zKPrv+9naClyCy+toNfdVXC4oUcjY2LYbqKmklqGGf3bavD
	 OfAM74tIxgesiG0ZNcoiL5TubXqeFLoJfsq+XrkvX3A/ODpoCt6lH3IUuiTWXclMuu
	 ybYedjNdzDfqFrs911+j5i00zlJwgszbQV075I+Czrv+02nzI+1vAA7ZWipU5eBntR
	 DYLtdAKninpcNU6O7F6RU59CZsrG7GtiEzgo4II9kFmKd7d3b97BvIgKNOM7mFvZbY
	 m8qXeE0hy9NjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC85E80BCF;
	Tue,  8 Sep 2026 15:13:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BFFC49D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DD2240448
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vC5zp9DMXjjJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 09:54:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8FF6240435
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788774894;
 b=Sskev3Nth9LABp4a/W7luy3+/6sqFpwgYnopERYREhbZqkLyc8/LnmgthBMnWUgOufIY
 RK0DCwFbup70PWh6MYJV9Kd+4+ihNgJyosTch038/t99y8A0S30bihXIQYp/2ZXq3ZtzO
 mv5yjwC0do9kveaNnDLaVSZtYP6iSG3GfflgWc1xTvIdIm4FTExmUfrXAsgA7wg6UOCUp
 sCLa4u01hFNFjqxoqM9tAy1I4CqWsA2Fs1zvq5cIzgDWejIszuGJtlwbA8eSISfpu1s9T
 MNpxFAqf5IgbrLPcAXRyWp/EHHLMNnBPJrI2Oe454bTjQZO8zBlvK7WpSCTlmJ4fOfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788774894;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
 b=KofBMWMgIVfTTm3fFDQI++Jw8aIroDDhBboHlRI4VQMn1rcvWUToXjDAaoqQdWaqOg7o
 iRpegl3Msj+7UctyJ49kbP9634GfUa10BaTTHEh95n/SDFa2u2+0CsScJI5t2mA5bN1Xz
 XKR5+bYmWBGPMtmbG76Ey19zGTbS/Mb48m3X1DI0LbZN53Tg9y+8mbOELo80iiPnO2E6Q
 NLdSb7kOKwq2+oi1+wy8hybNTTSzoptx10JJoMeIxjV+NgnvFwHDACuIMBg6hhfNzihQL
 AzN7l2bdNpdYb2whn4c9qdj9+ooZmHzXoqwGRt7hpQGbxFhkK/s9XLEE2FXvHAevv8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DvDC1lDl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DvDC1lDl
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FF6240435
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:54:54 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-39647184c73so3964725a91.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 02:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788774893; x=1789379693; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
 b=DvDC1lDl3LLAtn1GEQMfQVTUrFtZi0RfVlr1ZBKZ+IQLCzneRKz9iaZa8Po2C+Mbrb
 aC0j9YtjYzhRYiU2DI5bphhVTtpsfJQD4DFmutljllg9kzaMu8LVrgMsGt1wXytUWbML
 lksPEoBz22Hx6ZTOVKMhwTXhcVHaJHFyBuHwOsEVFkkKVHDZGjBYt38wbdAlLui8fupq
 Qpw4og0qmTUu5yG5h7D79KtvaHfCfkTnUG33zS/csE1MaDad+xrQpvl/SLIVK7xSW8Zx
 GZMVVzB3LLwYo8/NK425y1tHfMpFIwF+pLar2xR87FWG9yVl76z7LjYbMnCbC6DpuUG/
 EPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774893; x=1789379693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tR97cmi0NkWDiEH0s6YYBJjyIYeR1zRd9pdLJfF85lM=;
 b=OinuEle8hKaCebg5m8BxQTFt22q7/+7tIhTOyOSBAGWYaRu2RTEdnwQSHwQZ0GqPeY
 Lenfr56Pt+MRIeJjuFPO3x6XIw8Qstt0cg6SuivjeJ98q4+WAh2JAhgsBZZSzLnUjVSn
 AFPCY96QBbERE0QUn/EmJR6TBK16gwgO5sbcQBpC+YiNAsoRrym7za65+SWgyzhfSQiE
 um/4yE6GOAz/kfvx/6tCX8MF4uKio7e6U0+XhGHzZJFGhmhziDieCg5E8Gt4ytc2vhIB
 HCoZ9ajEZmey+feMzjdlG+Is6VvJJMC7J+id89chV/0DOXb9p0ByZqCn/Rf8i7hpNfQp
 HIig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwahsd0luoIE9g8rsrv4w89R54Ma8+n4cDlk62OT2gFDrTH/23thYL12fJXxfpzH6ePo4IcyRZM9Hdcv6l+Vs=@lists.osuosl.org
X-Gm-Message-State: AFuF++lCllS1BPI3W74PY45H0lUFExl7DU5GyGMVKh9psORSRYsd/n3T
 2CM+kCpn9ij4H1dBw8PevjR+UK1ybcqJHXcbW1VZBuMd74kwqjyF2sCv
X-Gm-Gg: AYBFou0+Br114DkSYIM8pXD3eE+wEPkQ03IEBOqoFzyZdCHomH8k2IwtBK1jUmwg9oS
 UTOYdzUm4RmPzeI+WrRoYCxKizOir3N+3lTeFPXmDv45KEW2GsORwjxI5CqXa5tPaKfbF8bayfK
 DbGrFpuFf9zng29n/Rb55NzIi5CgqMbEaZGX855ptAZUYku1Gq0hkZkcXwaJ/BilR3wz88xASV7
 w4RZ8+kBmj30yGPwWg+x5X4sDbVjFX4RCEs49JOYaEmMIm9RUXQm8pwIN3GOWnzeQ+/vmKmcyBP
 tKHT8Q7QCq9BQjc9iLKvm5SJ76iUbJxGcfmhBkNTaKaEP9RQ6pjXk0ab5Ym6tO4txUujE4RoREx
 jxBgfxQX37iJzpJVGV+Cqfn3NOcxHb5W4QpeB9CPAUP8pviPrhl77J9xozwssQL9aqqQJi23X18
 jrj5A3u8tw7mF5CNtLTkuHFSQ2npOzX8HsyGfosXgvxvtGC+MJL9t9lzjr1/FBCeOpA1lA9OMt4
 yhnobGCwt3HOg==
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-39b07fed101mr30328985a91.10.1788774893379; 
 Mon, 07 Sep 2026 02:54:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:54:53 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 0/4] intel: fix typos in comments
Date: Mon,  7 Sep 2026 15:24:42 +0530
Message-ID: <20260907095446.27290-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
maintainer-netdev.rst asks, v2 designates the patches to a tree, and
each subject now names the component it touches instead of "net:".  The
series is rebased onto that tree; the diff is unchanged.

v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/


Hemanth Selam (4):
  i40e: fix typos in comments
  ice: fix typos in comments
  ixgbevf: fix typo "enble" in comment
  Documentation/eth/intel: fix repeated words in comments

 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

