Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1B2C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 920E280BB6;
	Tue,  8 Sep 2026 15:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 470uw4W5POMr; Tue,  8 Sep 2026 15:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E770280BBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880437;
	b=SbCgamwdE5ld4q8o5B7Hj8B2Mj0k6EkRwvKSvQD+RGD+BpY/n1grq5N87cWto3t03CE1
	 BYEaILu+ksF4aSUMRtvJoJvXDmoy3jfaqJkBsedEqP6Ym19qirSl4agD2fDmjdIfcMnOj
	 5BJrcwYQFNcV3YKjRfEBn7QhNKwwRX1xWGF8riL95QBE+FZ4Uj7KApW2Hg9dkvsSLGC14
	 9R/7PzOXKFjlbmX0dDus6qKM6nr/I1NOtH9Nad4qe3wicEblUCFToXGcRt17k8q3+/1Dw
	 HtXfwqZoiTuTVNsHyYY6y5dW1ht5zp12DUNn42aNj2ctF0/s4uMkQxWhXKQDp4n68UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
	b=ogXMvBgzuw1X+BLd6OyHArTw92RN7biF+tn6uF2MzkoQBh3kOP3E9lbY0vhQCfy30nOg
	 qVVBg3XrDnKx57QfbX6VNU16Pb7wyKdSE1bJZCQEjyq7hlqh4/YJPaCe67MGuoyDVTxIf
	 PBDRZWkSU66qInQm4aHqMDZqXrPrrNrpGk6Sx8RKwvOnSVL6ixsNQ+fGFaff98d7Q0a+0
	 xb9vHfxRmsZxmqlDX14k1B5ohibz6ylZxfmZWKtV24VLGIsZSAwqNPfr9+s/EjgnVTrcb
	 DaFXuwo7cW4ybNYMHwkQhcPj4kHGazZ2PxHujxBTqGf3bVUFxeWHeRQM9LM6aiXE1JA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=muaPPkjV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880437;
	bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RuyU7bsNdCqZtiE3auEcq1sjwaEjmTpc0Zf6kdlOgg5u+gFvXrpV9xa7u7pakLjsA
	 RyoxqjhVykbKjO/AFo3EA10LcO96Qc7h32xMzar79vzVuO4+eGqR5JeUgnT07MK106
	 hKtA+1Ewq2vfpCQku+5F3jO7YcR2EyCHQ/aQwoGaGXxOh5nxlrukqlarAXTc3SLY43
	 TILaO0dEWzddMSYbfm5zQXs/QVpZXqDOI7lJ4qGsB0bfaBC9YabNO5yA8mL3Wvi7zs
	 PDWOxIOfZrhAPmcc0gBfgWZiM/Trr0NihIhCDxPmG438KmPFoRRX6tj+XhYKD5M9Iy
	 4Tj5R5bKGYWCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E770280BBC;
	Tue,  8 Sep 2026 15:13:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71565990
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 629BD80B9D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06IaobRf-O1z for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 06:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B805B80AC5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788763537;
 b=Vm2uOhL8cT+afy4bT9ZISInmHnCDFc8UjcRf05RdnKOs3/agD0EwjxbUOEIVIjq8pH7c
 L3WXfbk4+jy+pUK0LGWMavlRDbdM/2LSxHWO5iipTWLDYcCTQd8j04uC22s78R9PDQ0Y6
 4BKaGewjg3iTlnMFPdK+TYOhmDBgMTAXANwLw6NaQBN5H06WF2M2nXauOSgYwGVAdgLQu
 7eb3ntGpDr8z6Qu/OivYPLbjvXj2duJ+Iba8TRuLOujRVrVd/MbuLFJ7aTbFUwv38Nsod
 aAO3jQXRmunj8Df4sMTrQHSlEX8QbAaOLSwqW7z0dyVvW1Ea/a1hArVQkK0RJc4X+Mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788763537;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
 b=VHRV7KFg7nTP7Ae4s/nt1KHNx5toIOZygz97XTt6iy6z+SsdepcNGURFtDHTzK77cQgR
 ea7xZve2z2XQG0cRxBPB1OOQVMLovjNkhP8DC+bbqvi7fyHK0t/DwCCPu4343WasBqrfN
 72Rq3BnbNB+n9BM1uKwL9aTpvwOxksezP5h8GVVlTxMLZgFOpvp7t7HWzpP0myjSJ+xFf
 reT+UFQQRsUHG78tflUKkY4T7rnU5J7fFCLRzsTJgZQfTPDR0MfgEN+zimHFN0zcNAJkT
 puZXmDOIMMUbo/pDBxSqBBvtPPrmozKi3p9HI/hL7pMJeBRrELn5X+VLhGpCeVeAZGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=muaPPkjV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=muaPPkjV
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B805B80AC5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 06:45:37 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso2581589a12.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 06 Sep 2026 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763537; x=1789368337; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
 b=muaPPkjVOg4i6IX0Uctqv1fwyKt0AwDniakI0WLKbs8XjAfSSPKykg8Z6pnujFwM5v
 /w8jfQBnNz5qqoiXZXj3DvaDC/rFRbBarq7YjB+Kc9XSyu+HLOrHYPBohb4AlMfAAlWq
 2AVgEGWVCJqXBKDfhCWPg6sEcfGFPfJufJxURsNXggLWJz6IBJJN9/gIIph88UmzNU15
 E4ac0u4uniAq6zfUVKZlPwwv8Kl7Hz6PvL6sgxyPL/+j4+mmiV+uZIaQ5f2gcRnYKSRE
 8M+O6by/J5/VXIjrDI36h7vGmadGk//GEQj1vCS4ow1S9G6zSGGDC2DSF7rO75GCpE21
 Faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763537; x=1789368337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
 b=dYlqMo6D76xs5PPgiZUEz6wRG5JQn4kZZTdYFNSmmsRl8chVRPrAOb40We3FeWAuXx
 F+1ldBaSRkNBkRCCGf1peNEkW3jxxqQC1guNjJQQscAum6JcLzv++X9SYkvYX+J+nEn9
 aRcDqywkSeXGCPMh5I32os5+674vJHxukgYsQGO4bzE5XaK3yH4aIhvIRS9J+2hu51sU
 wz0+i2kovuKp7KQNhg8yjcp/YWZ9ij5PCHMWbTFM4SNWEKNIaSPji7Pj29uo/4jhL0Ig
 d9/RhjgEHzRHLGno9/kNGUK9iHkSsq8AIlgOxWy2WphHuNBGcHUq9eDt+fTSpY5eGloZ
 D6pg==
X-Gm-Message-State: AFuF++mIjad9MChf3MLV54XB+jXLCVm+48qgp8fqfW4F8DPjFbe2yaLL
 aAv55BcsIcClX/mPVKzvbjTMVtaLd7YzErss7KZK4p4uF8CNAQMRnuhX
X-Gm-Gg: AYBFou2bmSU0Qxzqfwl5RZWD/5BYH1KvOJnAFR97ZGE2BixXbBmxBeHbUkccxyNoHiK
 TA/mpeVZVwakuclFfZfjhOVZcUcYFzYBJtt/x34EhLTbKKk++r9Ljz4pbnngPqxS+W4m7YuQisJ
 xkDIDt1BrJNu73KsDD/3n8LqAhHRCYLJgYSAYutqrQBuLA4JFRy3VmjvxgqOT6mM1YGIDMRPGmC
 aWyefdbSnSRYt2onHFZQ8l2QoCyK0Pf20eRZc6SJDER7UtyoQlpct0rHLRrSaubV/leO2ZLnKsQ
 WTvHSXaNdn6yEIfwnk0+e9jy1jJojpD+9GTVJu/Jwe0a3/iPgFZ4YYUSYIlcxweY9XxUYRXpADH
 9s1RLxbhQef0DyuX+WUX4eRTh4NJyH5oOVuKTMgHcESpZhyqgsyCVX2FVqbRu6crwCuo1KoNknk
 EzamU3DYspkuzW2jgPS2bgrwmutG9L0spuSZPfVwnZke6QGd3oAlmIP/2DqddUQliXH2WQbkse2
 wfbf5KRiQrmsA==
X-Received: by 2002:a05:6a21:7484:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3da39bd47eamr40391539637.7.1788763536223; 
 Sun, 06 Sep 2026 23:45:36 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm17209594c88.8.2026.09.06.23.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:45:35 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] net: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:15:26 +0530
Message-ID: <20260907064528.6602-1-hemanth.selam@gmail.com>
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

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  net: intel: fix typos in comments
  Documentation/networking: fix repeated words in comments

 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.48.1

