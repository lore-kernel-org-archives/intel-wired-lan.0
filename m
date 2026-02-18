Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7682E9A051
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B835040759;
	Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ZiP7lYgULq9; Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C1CE407DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409608;
	bh=K2MZ9Mdl5uBgJYO6GWAelelMTHvc+499gC9kY5J6w78=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HTTg1x66/Ij1lARlLxnZY3CgasdUUNZrtXkGOsw+xmeagEPvKMtfatpdArlwi890K
	 uugUI7+uXkIYmFmhfx2FUMSl19mLnLzaQbPmDwmK6Cg9tff//GnNzXyi0TV61iXCvl
	 7jcU7D0Rv4ucUz7KcXmcy2KHojkfJqonJZjpYUgpGfH75IMuadsYmZtEDsCS3kQvKV
	 LezvMANEzVYX5Nxtx01JwBkc8EfXirSO05qX2Z3DFeAbe0f4doaavRa/D+CaZLXV8f
	 sKrK6y47ZF9r9vsFEm8mcHOJ29pF870B6TsZfAyYfkiVkfcxa0mGp6kyc9kpM8ZiTd
	 bhKDg0HpHP50w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C1CE407DA;
	Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80931206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4143A605E9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kafZO7oPRxo for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B0E1F605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0E1F605D1
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0E1F605D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 759024456F;
 Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C01C2BC87;
 Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYZ-00000000LW4-2dI7; Wed, 18 Feb 2026 11:13:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:40 +0100
Message-ID: <b283bdb3073ad6396345dda5875571bc47dd6215.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409601;
 bh=4U9S92uLRAA+mWktHmpbTnn1LtPaRCq0xSK6dVoNpwE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rUD/rytUPezekhvGG4gguYlNKlT0NYLFimevTVRcd45FYlndGdTYGxw8bTV6Jdi2J
 Mt/PB5/+kNrEnS8Exwz5EhrewWnsXSmeWQl0YqWEnFaT++QZSgWXoQmi0G8KhzgeI3
 DRQavt8OfkLpJcZzzPPI6IrctkL0RM/8oqgVQHsrsAKv45NyjKZoi+OB9Ic/DoixTv
 LNl0/2H/4zpAIIq2w3y7cp7+j9JPs1Wr5ZDlHt4BGhbGWrG47oAqeilMOEaUyfHEFP
 ssHavLBu0u3s+iKiw2MMrbxl6KfBR9N9UmAtvdJTKgKgrLinVnjS0pp7TQ78wLgG9Y
 tIKQeBIymGc9w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rUD/rytU
Subject: [Intel-wired-lan] [PATCH 10/38] docs: kdoc_parser: don't exclude
 defaults from prototype
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

If we do that, the defaults won't be parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 9559cbfd5e4c..d8e96c6c4ebc 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -208,7 +208,6 @@ var_xforms = [
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-    (KernRe(r"=.*"), ""),
 ]
 
 #
-- 
2.52.0

