Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063BDC88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC40B80D45;
	Tue, 15 Sep 2026 17:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVTd9UY9e1Z8; Tue, 15 Sep 2026 17:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1B20E80C6D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492689;
	b=ghz1ahx4FGClSLFgBcLV7maU/fs2ibNffM5UryZS7rQUHNz8R6mfd3GejpLCkRu1o99J
	 yru3vDRYQPIvfpvvwU1/kIZa8fAwcJJ2pYGeLOJP8xLspOZ+i2j6wlTKPftmRQJY01soj
	 uCXDge+l4tupixaTyM7YjdGI08YbkhDnXvBnY57fo11IwhbrRtpfrQ3udM4+Ptka5vS6L
	 HDN0Vx9NVqASsLyz2zwaJ1AwLCtszhFAwmMJTXrR4FZ3Gp47I2iFj0AE6jZPIQyU9xt2b
	 45ZCdpc2jGopq0JrO59RB+K0cHreYCdQAV7rctXm5Vz/VZ/WesoZ+F6EuQYYdqcn8vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 From:To:Cc:Subject:Date:Message-ID:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Pyaor3OexTPbvVE2eALaC6NSiFgHwqvaYEtSZvsceZA=;
	b=K0VjqBrwqxqoKqGkbTeluagFHSL/0dc2k3ZqquhKxaZujSQzq1VqISIMYTD3hUiuGXad
	 OcN5NoM5ApXFWWHvYM7UbbIC/b28x8QJW5l9dYr1EE6ixJIySJbNPxuhio6zUdjSb4u2B
	 0CkS/Hcek7UfDD+ElYJZFkPHDkHkKU0jRZHu6NpsGj6oII7MfqEBtrDOcZZwEk0C2lohG
	 B4q7aW823We1j6M/4Y0QqpsE0++vWLJGbDhRmeRGLxyijw/Us78Tw3eAUvmsr3ZLdKCO8
	 xUaglOC7AsLzgCls9ayRV9szaBLN67M716/N+aiWVEQbzf04nYMGm8LS6hc38dXvxiw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492689;
	bh=Pyaor3OexTPbvVE2eALaC6NSiFgHwqvaYEtSZvsceZA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=voZYNCrcfXzhIQbNon4pvsYqijpcYIdqIS6cOWJkrle7aPWeNPOqIJYuiqcxJwUKN
	 4qJpwHhtmrl+AoX1GvcUCdZ/fvK/22Ovz8D/LsAtZ3BXvJibwu2Wgfk97KzC9MOmfe
	 Sshag6WAKB9NxAruP/79ktPPengITj8xI64oIHRKGYELOiwfsQkA3W2uBe3CGqf2f5
	 T6b1Xd9r/etu5+1BZVhn/UxdCvbNYQMIvgjTRVWpKEH9n0B6KjJG5F33r2HVuOXBLO
	 rgaFg25JPOTZfap3RYLkjFQ5rSIhrkctvJqWR3SkYIZ9r6u5S5eUqN41agJ0HylHZv
	 R1V675UoWeKdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B20E80C6D;
	Tue, 15 Sep 2026 17:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C0352E3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 198F240462
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v3P1yscHcc-h for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 10:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7A485403CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789467277;
 b=khW7N2466w42m9huBh8tD6FMsKbmqF+9KU9+l1QBJMHUp8Wwo4Vx7Ezb5Ioq1mAz4tb0
 baSOrP88GkPpEKszwNCi4w6WOsMgOgwGn6AkqUvsg8hYMp8k0WjCh9ORfWTQYlBuGYkOf
 MIRa6ALT2/6U86T0S3N2BECNJt03ObE1wEXcjR50GX8zrQUBFplMTp8pMAZinUggmIcUV
 JUNkO86RNRkrl3E3KczkKN9SnzW+ru88SDpRbCM5mw/lD7h8dhBz2fW50lJ50LMv2kbAH
 /00bC6w5REo037KV4AjUdnDX/N045rEQ1WjVavWefNzRXws98QYA7pAuRBYzTg47A+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789467277;
 h=X-Greylist:Received-SPF:DKIM-Signature:Content-Type:MIME-Version:
 Content-Transfer-Encoding:From:To:Cc:Subject:Date:Message-ID:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=Pyaor3OexTPbvVE2eALaC6NSiFgHwqvaYEtSZvsceZA=;
 b=asdB7diu9GeVsZjA9uEZp7xb3+oaJqim+UZdIvIN9z+2gkYX/enqdKkvRyQyOryF1pTY
 f0F9gKOBKTkbecZrFzPJkrU4yv0cF7Wa0HFKMk1uMxkkWwYCCXLEhAEVEcJQhRz21Kv0x
 W8P1oGmOaTFfGOvrySfOafId2Id9D8mUB1aLqDw5ZLwoWYg/WYpzkYfTxohoGvFjiWMGh
 oBZUXFh7MaEaeJDgO3SY4M2Sx4c1o1qFCsJPzJo4Wd9BIRgZACuZrUZve+LLqK3pv+jui
 JaSHR7Qld4GrOVviPdutGm4IjY39SDPZl5JEv1YHMyeRX5j2y+6Rj2MICOYBL3Nnrfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=DwmM9Wkw; 
 arc=none smtp.remote-ip=117.135.210.4
X-Greylist: delayed 155 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 15 Sep 2026 10:14:36 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=DwmM9Wkw
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.4;
 helo=m16.mail.163.com; envelope-from=15503232150@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A485403CE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:Date:
 Message-ID; bh=Pyaor3OexTPbvVE2eALaC6NSiFgHwqvaYEtSZvsceZA=; b=D
 wmM9WkwbqD6wf+DfxVcx/AiH0NUxH820D/BT0haRQXWkDRBjvjM8JDck/wzDVFtV
 FPkOvqnsxkAe8g0wOYQDhL1puByb7XnZdMSebxQE2zjMbpQtVZxD44xk3m5ttVXn
 E0lbfpRPup0bcDMlZZuaIfPQR7KgjdZtOjPlAEDl4M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Tian Run <15503232150@163.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] i40e: fix VF queue mapping collision with PF queue 0
Date: Tue, 15 Sep 2026 18:11:18 +0800
Message-ID: <178946707899.849053.3626754711268331752@bigrain>
X-CM-TRANSID: _____wBn+6vHGalqxkDoAg--.261S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDWF15WrWxtry5Wr1xXwb_yoW8urW3pr
 WUCryYk34kXF4rW3yjga109Fn3Awn5KrW5WF4ftwn09a9IkF4UXF1UKayagry8ArZ5ta13
 tFZrArW7Cr4DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb189UUUUU=
X-CM-SenderInfo: jprvkiqtstjiivq6il2tof0z/xtbC4Ap9cmqpGco7ggAA3M
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:36 +0000
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

aTQwZV92c2lfc2V0dXAoKSBsaW1pdHMgdGhlIHF1ZXVlIHBhaXJzIG9mIGFuIFNSSU9WIFZTSSB0
bwpwZi0+bnVtX2xhbl9tc2l4IGFuZCBmaWxscyBpbmZvLnF1ZXVlX21hcHBpbmdbXSBvbmx5IGZv
ciB0aGF0IG1hbnkKZW50cmllcywgbGVhdmluZyB0aGUgcmVzdCB6ZXJvZWQuIGk0MGVfdmNfZ2V0
X3BmX3F1ZXVlX2lkKCkgcmVzb2x2ZXMKc3VjaCBhbiBlbnRyeSB0byBhYnNvbHV0ZSBxdWV1ZSAw
LCB3aGljaCBiZWxvbmdzIHRvIHRoZSBQRiBpdHNlbGYuCgppNDBlX2NvbmZpZ192c2lfdHhfcXVl
dWUoKSB0aGVuIG92ZXJ3cml0ZXMgdGhlIFBGJ3MgcXVldWUgMCBjb250ZXh0CndpdGggdGhlIFZG
J3MgcmluZyBhbmQgcmUtcHJvZ3JhbXMgUVRYX0NUTCgwKSBpbnRvIFZGIG1vZGUuIFRoZSBQRidz
Cm5leHQgdHJhbnNtaXQgb24gcXVldWUgMCB3ZWRnZXMgdGhlIHF1ZXVlOiB0aGUgZGV2aWNlIHN0
b3BzIGl0LApyZXBvcnRzIGEgTWFsaWNpb3VzIERyaXZlciBEZXRlY3Rpb24gZXZlbnQgd2l0aG91
dCBhIHZhbGlkIGV2ZW50IElELApzZXRzIGJvdGggUEZfTURFVF9UWCBhbmQgVlBfTURFVF9UWCBh
bmQgdGhlIFBGIGVudGVycyBhIE5FVERFVgpXQVRDSERPRyAvIHJlc2V0IGxvb3AuCgphbGxvY19x
dWV1ZV9wYWlycyBpcyBzZXQgdG8gcGYtPm51bV92Zl9xcHMsIHNvIEdFVF9WRl9SRVNPVVJDRVMK
YWR2ZXJ0aXNlcyB0aGUgZnVsbCBjb3VudCBhbmQgYSBWRiB3aXRoIG1vcmUgb25saW5lIENQVXMg
dGhhbiB0aGUKUEYncyBudW1fbGFuX21zaXggKGUuZy4gYSA0LUNQVSBndWVzdCBvbiBhIDMtQ1BV
IGhvc3QpIGNvbmZpZ3VyZXMKdGhlIGV4dHJhIHF1ZXVlIHBhaXIgYW5kIGhpdHMgdGhlIHVucHJv
Z3JhbW1lZCBtYXBwaW5nIGVudHJ5LgoKQ2xhbXAgYWxsb2NfcXVldWVfcGFpcnMgYnkgbnVtX2xh
bl9tc2l4IGxpa2UgaTQwZV92c2lfc2V0dXAoKSBkb2VzLApzbyB0aGUgVkYgaXMgb25seSBvZmZl
cmVkIHF1ZXVlIHBhaXJzIHdob3NlIG1hcHBpbmcgd2FzIHByb2dyYW1tZWQuCgpGaXhlczogMTU2
M2YyZDJlMDEyICgiaTQwZTogRG8gbm90IGFsbG93IHVzZSBtb3JlIFRDIHF1ZXVlIHBhaXJzIHRo
YW4gTVNJLVggdmVjdG9ycyBleGlzdCIpClNpZ25lZC1vZmYtYnk6IFRpYW4gUnVuIDwxNTUwMzIz
MjE1MEAxNjMuY29tPgotLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9t
YWluLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jCmluZGV4IGFiYmM3MWU4MS4u
MjkzNDg2MmRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0
MGVfbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWlu
LmMKQEAgLTExNDQzLDYgKzExNDQzLDEyIEBAIHN0YXRpYyBpbnQgaTQwZV9zZXRfbnVtX3Jpbmdz
X2luX3ZzaShzdHJ1Y3QgaTQwZV92c2kgKnZzaSkKIAogCWNhc2UgSTQwRV9WU0lfU1JJT1Y6CiAJ
CXZzaS0+YWxsb2NfcXVldWVfcGFpcnMgPSBwZi0+bnVtX3ZmX3FwczsKKwkJLyogaTQwZV92c2lf
c2V0dXAoKSBsaW1pdHMgcXVldWUgcGFpcnMgdG8gbnVtX2xhbl9tc2l4OworCQkgKiBrZWVwIGFs
bG9jX3F1ZXVlX3BhaXJzIGNvbnNpc3RlbnQgd2l0aCB0aGF0IGxpbWl0LgorCQkgKi8KKwkJaWYg
KHRlc3RfYml0KEk0MEVfRkxBR19NU0lYX0VOQSwgcGYtPmZsYWdzKSkKKwkJCXZzaS0+YWxsb2Nf
cXVldWVfcGFpcnMgPQorCQkJCW1pbl90KHUxNiwgcGYtPm51bV92Zl9xcHMsIHBmLT5udW1fbGFu
X21zaXgpOwogCQlpZiAoIXZzaS0+bnVtX3R4X2Rlc2MpCiAJCQl2c2ktPm51bV90eF9kZXNjID0g
QUxJR04oSTQwRV9ERUZBVUxUX05VTV9ERVNDUklQVE9SUywKIAkJCQkJCSBJNDBFX1JFUV9ERVND
UklQVE9SX01VTFRJUExFKTsKLS0gCjIuNDMuMAoK

