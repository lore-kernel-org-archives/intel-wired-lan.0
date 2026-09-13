Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523CFC88E63
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Sep 2026 17:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E82EF80D2B;
	Sun, 13 Sep 2026 17:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gdS4tq0H3aea; Sun, 13 Sep 2026 17:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 66CCD80D63
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789319783;
	b=ItcOh7FxOp/urZbmyZugrd6nIYPIJdeMy9Q+H8vr0yvX1kRLpBzVzoRrIowPlTzIrvd8
	 8gJcoj5JiMHmX2cm775DlAoeloaXoXJwS4TM3+SU4d4R3ahCfy7sOh6nvLYV89dPZenwP
	 SoGqpbqi/LlmwlVnNGMBjSzrwOWJVaHfNuFdC2AIqNe3jvRREXCHj8WyvX3KzrshDFga5
	 NgktZ1O3zENeif27YZNDx26YYiUFKY2Y9JTpJoZkLoJaTfRliSsPjOx2hM+yC/k4DIXab
	 kVP6dAz+yZ7n5zoaz1FGVX4bZUagEATWYdZpqpzOKFMaZ2YgSX/sNG0t6wWQNgcnknA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789319783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
	b=aiDiy+0AIvrfI6g4IasgufCodZuQt3+HmIyBdjb9+KByHRcKAcLKhEJw61zRsiPlLS+V
	 u2oKGu/8I/E/ekx+MlxsvtA/LPJqa5+ZdJXbw35QYAwCxFSVAAHCtQ8+n/LON1uk30M5k
	 fgpXvM9J/4eHU2SyP898ME7sCBnenzC4y/8mNHKe1re9AMaSNAYmaygI8/cZeJgtvCeGb
	 n6J5ZbQG1SktQA4wo0iTS+smBNJUGy/dGdU5WeroDKMVbuscnUQTXuvav8p0VKj1zijSw
	 J91+yw3meQ8hJZv5qd2wWb8iORkUO/6eDilCgk8ozG24L+yE6jB6QhW2LXSfN9NNZfw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="l5KC/43R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789319783;
	bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TLPgW/fbtLJG6mJzWupHZc/+R9BEws4vuRU68/YEpswk6qtXw8q07GNR/K2BKYCvn
	 CEkYoDh6q7XUL9XF15t6+4mNrZWuhJhYJPg9mxWEHsokDEjZWzEW6pGqUJtNi7Gysq
	 uANb/Las5ALXg0BDtppkxoM9EMtsyIfsKUjh3T8ogVck8QwEFQr7DR37oTeX3WVAFR
	 3yhfo6TjYEd/+McG9Tv9M5zGutfSssDOpcS1DN2ypuehK1+PVxOxtC5eON5bP3CD8d
	 30Gw7rnWAoRmZk9XGAoXp1Wn5fnvhJ0uJnlxE9mnLa4CdMmFr4Hfiyz62qYiYmKDwR
	 TKCNYoxAQT69w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66CCD80D63;
	Sun, 13 Sep 2026 17:16:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A871F3AF
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99DEE80D63
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbegWXktcIXJ for <intel-wired-lan@lists.osuosl.org>;
 Sun, 13 Sep 2026 17:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C6CB780D2B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789319781;
 b=W07Y1aX5tH6+gOl56M8kbZxiuqYJNm3A4/23xX+yWukw7j3ndBu3UsrOMealXGeXJ7/u
 v/RCs51d3yU/6q568DWm5pBIJOqLoc36if4M529cmI1i5YH1ILyHvYUjWzUYx9oI/tZYx
 9fm7ap5b1J+khetupcTm/RBXln88bV1IejfPnpXQA2fCagYSZHaeNytB9xInxLG6gLLGA
 CSE7jHxl334+fcP3F2NZW7UWT2W0/JZNDPdswdFgtua+K2Rm1WdQE27EBel53+TrhgtEC
 Udzw1b/5PoPx7cZmNOcSOw3Ql2Jkz/ob7Y4U3ZigQwTSrhK/RsvcOS9w5iA5CFTZiSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789319781;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
 b=MBdtIFnUFOezR90k2LEthVLdhZolQ2LmFiUvQCb/GsEdAaOVJ5bCEAt0vctQIueDJ71r
 PFLLFfvCTEss7680wmf2g15DLwjoReMC7Kytx5GBg+NxK5LHQsYHdpXFd9roL2wUJ/WHj
 /GTs0qm0o4+53zRw/iQim9sTClrR/MoEO4/Ml8wMFcS6xZ6ufWiCrBVUs4ULEpwTMWKjE
 XL1IBmucZ9gwmbFCgmw2PKtaewMmMh7+Q59K7AvCfHyT+YUfR7UA22m8AzHyk6FEN9C+1
 1At5SwtJeO5z/eMr6I3NeIPwtgxLWjua3cjbs6S8cD5gxxZBJ3zkgTNvQqNMBC9NpqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="l5KC/43R"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=l5KC/43R
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6CB780D2B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:20 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 00721157ae682-85d4eb63f0aso4202367b3.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789319779; x=1789924579; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
 b=l5KC/43RYi6qSXPnaHaVGDYSYKYO+c1uhx+TsJ5PyUHoeToSudVenXNXGBc00h9WZm
 Edipa7RTgsJys3nSmvCaSIXw0JNIenkmALCZ1MPyrI35xl960Lon2ERw+IonJ5+hEcbp
 VXTXO1iFWqivLzGpuI80orTjErJG/rluINCnkOiSgjbF2alar6ecFtyQ87ffh8J38GAr
 v7PQ+vWSRwaNGtMmxAMwxHm8rLn6NgzqH8L+gBRFdaHFRlbLbgnt57PQY6YldO+w0C7i
 ic6REWBq6lnCx2xstvALRz0zs3ugt52E2WPyV634Xt5hdx+Wx67//EIBQdAtXaGw+RoD
 Yrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789319779; x=1789924579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gqTg4s+n4SjPh/18VLqNSc11mHpOLMKDJqGb8N0vbEM=;
 b=rm4gmUF3rK9z9300WeDiKYvLfMVhR8H8vKuxzlVnXa90wz7zVh1Yjf2S5JB4GV2j8r
 sr9uM7s4oeo4QnjK35FD/VbzXjA+Dk6AiM1Bf3O0o9wbVKUPpnv9Y6QBic9luyoPmzaV
 f1n59qv4k4ujwsosttxDh8B7AOXhcVEuAopiIIJjw3dLxJdr08yvFcyBXlPHnq4rBRnA
 L+u02zlyBXWR0O11QLNN64g+lONUOpGS2kkePaQVWB3EqpLoe+t9QGa+dMVa+bt446MS
 pynAFxuoH3VcXeevM30w6oDKL270rFbA4S4jJDcYTkwG0aox088NbKpCdzZz+FSAuOR0
 XSzw==
X-Gm-Message-State: AFuF++m5RMSpxyJJ2FVNv8yFhYm8tXdcyPU37aE64ZAziHcn0zlDKmmh
 21IV+6v6yv/Tzrxmo3IYf/r+gU7QNXP/ukO369DIY2M50KH6CZFsSIDafmSM9p5OOOc=
X-Gm-Gg: AYBFou3ervHgf7PPK0KWaMk4zD1/1WpNf4727YEjTJ3gKtnxohvAdaVdFG75UFyX2DB
 jD6ciEI7gGwIjL8KT5qj08eVJr0nSs/nx1S8zFSCs1vIU3oiaVOUjI3PQFY1zzzgK1/BEGCu/LV
 hNU6BzntC8PyWshghzNQEyPKoEScHTf/j5eBClxURdC5oNx0c/M1sRCsoZvxfNtUz1IWvhwM0Zm
 1XndhgAOH7+ocKnKIvKIGbP4n3a5nSK63s7FhaTZm2OENSC6QcEpWUKw5WPg2Sx7oVK8uOpoCtA
 8fQ0eM3/1kMUD/fhIl3sGzcfjXv9Bh/QZfda2UqCYRcj/WoGVM8ExtnNmJ034doshDQpMia5cMa
 /g/Mkpi2ujpnd6ThqQQmwOJuOP6vhoIrwCMkzSDsO4BAGPILqUysEFSYsqDFaE59O7fGPkqZ2Fb
 ZeRmtc6Z3o20+5ckxvKQle6VQR8pg/MmJNNwCADPH6oSL1vpSRY3EEk+9FJ8oP4w==
X-Received: by 2002:a05:690c:dc5:b0:81e:d001:e0ca with SMTP id
 00721157ae682-88a8d2cc57dmr4418897b3.17.1789319779206; 
 Sun, 13 Sep 2026 10:16:19 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8847db4476bsm29210607b3.5.2026.09.13.10.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 10:16:18 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net v2 0/2] e1000e: fix Rx DMA error handling
Date: Sun, 13 Sep 2026 13:15:53 -0400
Message-ID: <20260913171555.89537-1-tactii@gmail.com>
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

Fix some longstanding bugs in Rx DMA error handling.

These two patches eliminate some conditions which would result in
DMA_MAPPING_ERROR being sent to h/w or to dma_unmap_page() or
dma_unmap_single(). A teardown leak in the packet-splitting path is also
fixed by a necessary refactor.

v2:
* Renamed series from "e1000e: fix Rx bugs"
* Removed RXALL buffer overrun fix from the series.
  RXALL bugs will be fixed in a separate series.
* Reworded patch commit messages.

Matt Vollrath (2):
  e1000e: fix Rx skb DMA map error sentinel
  e1000e: fix ps_pages DMA map error sentinel

 drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)


base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.43.0

