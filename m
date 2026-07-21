Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3477DC44520
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Jul 2026 01:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6D7580DC5;
	Tue, 21 Jul 2026 01:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J40xN_vn_MyO; Tue, 21 Jul 2026 01:58:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ED9180DC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784599100;
	bh=kkaXHXCYzlkxsMqu5aMpIsortni2YjoH/rB2+vAkVms=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWJFuBbyLc+1j4Q9e8DCzejKT9YwbsTppjqKmYhfMhEk9BaPtqJTXboMyl6t0zO4S
	 tA/TP0OtST1FbU2Hf78mPU7i2XtPyrRGmnlYPPDITOGPmnhyctAZWYbhdVly54goGN
	 Pfjeka24wbyrMkZsQUi3Bygvf9aaOY31M+CXCX7V+TTG6PrLptBnxMScMRA1AArix3
	 1thceq7V9yYf1H3BPY2v1CNOc/VHXpNHWpGi4WgX1j4RSxCJUFy3gM8km+VSgy0Q3X
	 hF3QpGS/XxF2GGpnXlfLAHJ6pBqB73DMPIWtYkK4zubT+BMQjCRFSBuO0Fm4p3eIUY
	 xABqGMtxOl0pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ED9180DC1;
	Tue, 21 Jul 2026 01:58:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2532896C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 01:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E6644019A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 01:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1bXQVc76WxB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Jul 2026 01:58:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.5;
 helo=m16.mail.163.com; envelope-from=xiongwm2026@163.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8711640024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8711640024
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8711640024
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Jul 2026 01:58:17 +0000 (UTC)
Received: from [127.0.1.1] (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfwa0l5qXCtEIw--.23396S2;
 Tue, 21 Jul 2026 09:57:46 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Weimin Xiong <xiongwm2026@163.com>
To: intel-wired-lan@lists.osuosl.org
Cc: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
In-Reply-To: <28460003-47ee-4706-ad95-7fba87d36509@intel.com>
References: <20260716025100.118145-1-xiongwm2026@163.com>
X-CM-TRANSID: PigvCgBXhfwa0l5qXCtEIw--.23396S2
Message-Id: <6A5ED21A.2B234A.06153@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr13Ar15ArW3Cr45GF1xKrg_yoW8ury5pF
 WkG340kF1Sq3Wxur4DX3WFkFZ8Xay8Gry5WFn8WFZ5Z3ZxAw48XwsxKryY9ry09ry5KFW3
 tF1jvF1SvryrXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jESoAUUUUU=
X-Originating-IP: [116.128.244.169]
Date: Tue, 21 Jul 2026 09:57:47 +0800 (CST)
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzhrsfGpe0hoz6AAA3j
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-Id:Date; bh=kkaXHXCYzlkxsMqu5aMpIsortni2YjoH/rB2+vAkVms=;
 b=pOubn6YiJmclF2Fo4qWD6EqR04VUJzVol7BL0qQp7+TTy4WnIGzOKeqRcWYX1P
 xKqhSPHT322ynkcUQ0vSA2PGhwqyFvPGeO5s4/u2vBLZfkYBrJ1dS+o/f1yqEwp/
 KS5agLKtgz6ORteMrtdGtIaawEoy4RN79PAKGYOdQJw3w=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=163.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=pOubn6Yi
Subject: [Intel-wired-lan] =?utf-8?q?=5BPATCH_v2=5D_ice=3A_parser=3A_use_?=
 =?utf-8?q?kcalloc_for_table_allocation?=
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

RnJvbSAzNzZkZmRmYzc4OGE4NTNjNzlhODdjNGJmZGQ5NGRjMWVhNjc4YzQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXZWltaW4gWGlvbmcgPHhpb25nd20yMDI2QDE2My5jb20+CkRh
dGU6IFR1ZSwgMjEgSnVsIDIwMjYgMDk6NDY6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIIHYyXSBp
Y2U6IHBhcnNlcjogdXNlIGtjYWxsb2MgZm9yIHRhYmxlIGFsbG9jYXRpb24KVG86IGludGVsLXdp
cmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnCkNjOiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRl
ci5sb2Jha2luQGludGVsLmNvbT4sCglUb255IE5ndXllbiA8YW50aG9ueS5sLm5ndXllbkBpbnRl
bC5jb20+LAoJUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPiwK
CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsCglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLAoJ
QW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD4sCgkiRGF2aWQgUy4gTWlsbGVyIiA8
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4sCgkiRXJpYyBEdW1hemV0IiA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT4sCglKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPiwKCVBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4KSW4tUmVwbHktVG86IDwyODQ2MDAwMy00N2VlLTQ3MDYtYWQ5NS03ZmJh
ODdkMzY1MDlAaW50ZWwuY29tPgpSZWZlcmVuY2VzOiA8MjAyNjA3MTYwMjUxMDAuMTE4MTQ1LTEt
eGlvbmd3bTIwMjZAMTYzLmNvbT4KClVzZSBrY2FsbG9jKCkgd2hlbiBjYWxjdWxhdGluZyB0aGUg
cGFyc2VyIHRhYmxlIGFsbG9jYXRpb24gc2l6ZSBzbyBhbgpvdmVyZmxvdyBpbiB0aGUgZmlybXdh
cmUtcHJvdmlkZWQgaXRlbSBkaW1lbnNpb25zIGlzIGRldGVjdGVkIGJlZm9yZQphbGxvY2F0aW9u
LgoKdjI6IFVzZSBrY2FsbG9jKCkgaW5zdGVhZCBvZiBremFsbG9jKGFycmF5X3NpemUoKSkgYXMg
c3VnZ2VzdGVkIGJ5CiAgICBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGlu
dGVsLmNvbT4KCi0tLQoKdjEtPnYyOgogIC0gUmVtb3ZlIHJlZHVuZGFudCBpbmNsdWRlIG9mIDxs
aW51eC9vdmVyZmxvdy5oPgogIC0gVXNlIGtjYWxsb2MoKSBpbnN0ZWFkIG9mIGt6YWxsb2MoYXJy
YXlfc2l6ZSgpKSBhcyBzdWdnZXN0ZWQgYnkKICAgIEFsZXhhbmRlciBMb2Jha2luIDxhbGVrc2Fu
ZGVyLmxvYmFraW5AaW50ZWwuY29tPgoKU2lnbmVkLW9mZi1ieTogV2VpbWluIFhpb25nIDx4aW9u
Z3dtMjAyNkAxNjMuY29tPgotLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
cGFyc2VyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3Bh
cnNlci5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wYXJzZXIuYwppbmRl
eCBmOGU2OTYzMGYuLmY1YWU2YzA3MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9wYXJzZXIuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3BhcnNlci5jCkBAIC0xMDIsNyArMTAyLDcgQEAgaWNlX3BhcnNlcl9jcmVhdGVfdGFi
bGUoc3RydWN0IGljZV9odyAqaHcsIHUzMiBzZWN0X3R5cGUsCiAJaWYgKCFzZWcpCiAJCXJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOwogCi0JdGFibGUgPSBremFsbG9jKGl0ZW1fc2l6ZSAqIGxlbmd0
aCwgR0ZQX0tFUk5FTCk7CisJdGFibGUgPSBrY2FsbG9jKGxlbmd0aCwgaXRlbV9zaXplLCBHRlBf
S0VSTkVMKTsKIAlpZiAoIXRhYmxlKQogCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKIAoKYmFz
ZS1jb21taXQ6IDk1ZTI0ZTkwYjU1Y2U2ZDlkMjY2ZWQ2ZjIwNTE0ZjM3YzkzMWM3NTEKLS0gCjIu
NDMuMAoK

