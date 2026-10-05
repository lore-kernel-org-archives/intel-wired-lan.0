Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A87CA6001
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 15:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB53240604;
	Tue,  6 Oct 2026 15:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xU4K8Rr9_iQ1; Tue,  6 Oct 2026 15:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 68AA440519
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299954;
	b=bFFrrFpWu6gRiZuK1KQ1n918Bz4z6Tp6ZjUCrr3vOSuTZ1uLMCECP/8TygG0b5KbykG1
	 PQFLAWiGcHfYSW1JgGVlaQNHUzSdd0Y6whnEanty8BTTFj47VzUmYn0FT8JmRB59XUEen
	 ok0thtOveEG6GBjLc14Wj0u2eX4XkYhgjErPulgFmXxJpfzx5UNJs8j7iB729U5i01K6H
	 CC+cdCRNhG/Kh0Rax/EdxXDG2tj9Ta1o2U6AX3QVMFfZGaaVFanWxH+SpTr2TFXLEawWt
	 xdWNtc3o+mD4IBZHcMyf3eOf8lIUFxrSoPBCZRN9sr7PAmMSZk1OYvHjMSyybgg3Sxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1c7E4TNR3FgmLg/dW68RX19B3YDyGYoWUchSNWou5iU=;
	b=ZVXW0KUYqn1L9RhhN0W11C+qqX8+Gftc0P7h66UfIwxx6JbGJW6bESqCx4f0ce53YpXa
	 BCSl6KqSlFT0CEY+GcRj45q3/YdTMUGxlmki0fo09TYCW8WuHItaK6NF+4hyakVW1ymkw
	 xZ5KksaUc5uxBRT0bERksATX1Jr4yG117mcCeFxgDcdKI5dh3dE/QFvGCos2mhnxslrnd
	 V2wJQkqkDvXDImulxwZww1BDGgBfWwMnmoc+eEgYB6u9nsnlJs5bYHBMG8MrXOQ/zfFJY
	 usF+8dyfC7CF75pZdb8iB0HRWH6K5JSPcTaNHLqOktNn/s+LKd3ZrBhU7SafGC+Xf5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791299954;
	bh=1c7E4TNR3FgmLg/dW68RX19B3YDyGYoWUchSNWou5iU=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6xBWjlp/tDLd0rm/PgBdcYH8MyOk0YkU3G7sF8/jjnsAfG/XN7Uz/+LsQ96UDzYGj
	 RuGhaqVZ+o2Q09ep/o9niMhvCdGSyqVKPQ8U+TMoQ02ekUoaV1yUHIr2/50K70renJ
	 LdRIXvMNVAqVk7mnXBMX2Ky0XnJyUJ5KbpIAPqOSmw815J5jFd9VXpbQpD48EigBXU
	 /T5YxHcvsnDPRbqiGU8+gbC6/hKGR6DhZ2QZ22BM36CnUC4uG6k0V9mKKS1nbwj5vN
	 o88WhmIn+7uONly7lXYMDhU4DNpUBixRgiRioIHpoIWc70G1dDF4Fy7uq8BShB+Srf
	 Zs+sLao8mHYtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68AA440519;
	Tue,  6 Oct 2026 15:19:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F7E9338
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 153CF809C0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRKZmBdG7IKK for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 19:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8EB080CA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.109
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791226815;
 b=YUnJAlNGuc5XAVVxxwvLOh94HZePIVmkeTREaskjt0ZEYFYg+uimF3uBgTIXnc+7Mmtv
 PxOFhVSQ7FLHwCQWFLOHzCBj9z0EqWhXvVUXWTIKcKvo9Ps9f45UpxzLo30zBFE9FtE6t
 M/6WiMTHUNQgonZ47obid2ToF8FppYW6P7rc0ILB/nvC8jZvOZzU9VcYUQfHqbVK0wmfF
 ghdOO14/QxLs0+/rOC26c8NjQpVLAuIBSS5Bz8zutfIWBB7VAnf0kAIG7fMZmHenAExta
 OY1kieW88nwN2FYNgLaoJp+TlJGv7IrBcC7jZCHER+xWI7bapOtMElIDqdcIrHDZmKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791226815;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
 bh=1c7E4TNR3FgmLg/dW68RX19B3YDyGYoWUchSNWou5iU=;
 b=chzzwRuy/LVJWecWxnZCsOG4Y7+HmkHiyHn21SigipPhAhVsbEye1ZlTVxPgugzU94d0
 TE7amljN7rV8nm7fBxotXMf0v5Pvyy/A1CAXfRPOgWNwZBDYmnbNE3JSNncZzrWVydmTx
 dyg9s+QnmQbxQYjMLkBrOm/1mXQDYxz+Atd5fyqtZ/5Be9XiEIpbvsm4Fx2y0I+PDgeuO
 oDP4AKbnH8gcB/Y2ZBTht/2sPK5B+NgS7ckMCpEr3m+b5BAHKaaaX/GzAq8AzigH/rIc+
 xmtLGZ/uoqU66nIjRPJhTHMOcJ9uRtNGbeUbNADUXPvh+aVoL10Pd1tX1Z0+a0CjuMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=5l5lyxbu2ncodewjokpvx55fgu.protonmail2 header.b=sJKNRBlS; 
 arc=none smtp.remote-ip=79.135.106.109
X-Greylist: delayed 464 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 05 Oct 2026 19:00:14 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=5l5lyxbu2ncodewjokpvx55fgu.protonmail2 header.b=sJKNRBlS
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.109;
 helo=mail-106109.protonmail.ch; envelope-from=ghrafn@proton.me;
 receiver=<UNKNOWN> 
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8EB080CA6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=5l5lyxbu2ncodewjokpvx55fgu.protonmail2; t=1791226334;
 x=1791485534; bh=1c7E4TNR3FgmLg/dW68RX19B3YDyGYoWUchSNWou5iU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=sJKNRBlSryeY0Be9rbaPg5GetpPhe/0Xhg0PEUuMbBcPcd0XkSGZ5yCCHWBNt9j1X
 GI6iYMjWijargcPQhL85wKLVdfx7uAGV7tOiReIcJllLbKxghZe6l9hb0q9q2akyqa
 G8eroPjkvPoswuWtxtUTGnCqLRdCY0+8E1TOjgEq8D68fKv1CXSLK/46D57t4KPdUJ
 vgWF6MQC3bNu/e8GvrDwke+ft6g2gJnug6eBC0oaT4jLNRowuizLpZdSGYkiPLrNq2
 5amemALGY9gsC1+LH97IgqGa8k7KRVHiLQaFhk8okkSm0q1dhTq0m2S8MQeDYTG0x/
 +w4Q2qFPrr1Bw==
Date: Mon, 05 Oct 2026 18:52:08 +0000
To: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>
From: ghrafn <ghrafn@proton.me>
Cc: "dima.ruinskiy@intel.com" <dima.ruinskiy@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s
 Gen 5 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
Message-ID: <_kB6DUeC6oOmJnK0FobVVJHADewewO3wzeFw_GrempgMu6s5CUwHpkT16Bwn8tXRq0k_CN4b2NY6API37M6mVciEpH6DKbTqK7f13KMpmgI=@proton.me>
Feedback-ID: 206853795:user:proton
X-Pm-Message-ID: 91f0185fe9051c7baf7bc19a3cd65128fa483646
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk"
X-Mailman-Approved-At: Tue, 06 Oct 2026 15:18:33 +0000
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

--b1=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk
Content-Type: multipart/alternative;
 boundary="b2=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk"

--b2=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

KEZvbGxvd2luZyB1cCBvbiB0aGlzIHJlZ3Jlc3Npb24gcmVwb3J0OiBbaHR0cHM6Ly9saXN0cy5v
cGVud2FsbC5uZXQvbmV0ZGV2LzIwMjYvMDkvMTUvMjUzXShodHRwczovL2xpc3RzLm9wZW53YWxs
Lm5ldC9uZXRkZXYvMjAyNi8wOS8xNS8yNTM/dXRtX3NvdXJjZT1jaGF0Z3B0LmNvbSkpCgpIaSwK
CkkgYXBwZWFyIHRvIGJlIHNlZWluZyB0aGUgc2FtZSBpc3N1ZSBvbiBhIExlbm92byBUaGlua1Bh
ZCBUMTQgR2VuIDYsIHdpdGggYW4gSW50ZWwgRXRoZXJuZXQgQ29ubmVjdGlvbiAoMjQpIEkyMTkt
TE0gWzgwODY6NTdhMF0uCgpXaXRoIHRoZSBkZWZhdWx0IGUxMDAwZSBjb25maWd1cmF0aW9uIChk
aXNhYmxlLWsxOiBvZmYpLCB3aXJlZCBFdGhlcm5ldCBleHBlcmllbmNlcyBzZXZlcmUgcGFja2V0
IGxvc3MgZXZlbiB0byB0aGUgbG9jYWwgZ2F0ZXdheS4gVGhlIGludGVyZmFjZSBzdGlsbCBuZWdv
dGlhdGVzIG5vcm1hbGx5IGF0IDEwMDAgTWIvcywgZnVsbCBkdXBsZXgsIGFuZCB0aGUgZTEwMDBl
IHN0YXRpc3RpY3MgZG8gbm90IHJlcG9ydCBDUkMsIGZyYW1lLCBETUEsIG9yIG90aGVyIFJYIGVy
cm9ycy4KCkZvciBleGFtcGxlOgoKJCBwaW5nIC1jIDEwIDE5Mi4xNjguMC4xCjEwIHBhY2tldHMg
dHJhbnNtaXR0ZWQsIDMgcmVjZWl2ZWQsIDcwJSBwYWNrZXQgbG9zcwoKQVJQIHRyYWZmaWMgaXMg
YWZmZWN0ZWQgYXMgd2VsbDoKCiQgc3VkbyBhcnBpbmcgLUkgZW5wMHMzMWY2IC1jIDIwIDE5Mi4x
NjguMC4xCjIwIHBhY2tldHMgdHJhbnNtaXR0ZWQsIDExIHBhY2tldHMgcmVjZWl2ZWQsIDQ1JSB1
bmFuc3dlcmVkCgpBIHRjcGR1bXAgb24gZW5wMHMzMWY2IHNob3dlZCB0aGUgb3V0Z29pbmcgSUNN
UCBlY2hvIHJlcXVlc3RzLCBidXQgcmVwbGllcyB3ZXJlIGFic2VudCBmb3IgdGhlIGxvc3QgcGFj
a2V0cy4KClRoZSBOSUMgaWRlbnRpZmllcyBhczoKCkludGVsIENvcnBvcmF0aW9uIEV0aGVybmV0
IENvbm5lY3Rpb24gKDI0KSBJMjE5LUxNIFs4MDg2OjU3YTBdCgphbmQgdXNlcyBlMTAwMGUuCgpT
ZXR0aW5nIHRoZSBleGlzdGluZyBwcml2YXRlIGZsYWc6CgojIGV0aHRvb2wgLS1zZXQtcHJpdi1m
bGFncyBlbnAwczMxZjYgZGlzYWJsZS1rMSBvbgoKaW1tZWRpYXRlbHkgZWxpbWluYXRlcyB0aGUg
cHJvYmxlbS4KCkFmdGVyIHNldHRpbmcgZGlzYWJsZS1rMToKCiQgcGluZyAtYyAzMCAxOTIuMTY4
LjAuMQozMCBwYWNrZXRzIHRyYW5zbWl0dGVkLCAzMCByZWNlaXZlZCwgMCUgcGFja2V0IGxvc3MK
cnR0IG1pbi9hdmcvbWF4L21kZXYgPSAwLjM4NC8wLjUzOC8wLjg4NS8wLjA5OCBtcwoKYW5kOgoK
JCBzdWRvIGFycGluZyAtSSBlbnAwczMxZjYgLWMgMjAgMTkyLjE2OC4wLjEKMjAgcGFja2V0cyB0
cmFuc21pdHRlZCwgMjAgcGFja2V0cyByZWNlaXZlZCwgMCUgdW5hbnN3ZXJlZAoKVGhlIHJlc3Vs
dCBpcyByZXBlYXRhYmxlIHdpdGhpbiB0aGUgc2FtZSBzZXNzaW9uOiB0aGUgc2V2ZXJlIGxvY2Fs
IHBhY2tldCBsb3NzIGRpc2FwcGVhcmVkIGltbWVkaWF0ZWx5IGFmdGVyIGRpc2FibGluZyBLMS4K
ClN5c3RlbSBpbmZvcm1hdGlvbjoKCkxhcHRvcDoKCkxlbm92byBUaGlua1BhZCBUMTQgR2VuIDYK
CkRNSSBzeXNfdmVuZG9yOgoKTEVOT1ZPCgpETUkgcHJvZHVjdF9uYW1lOgoKMjFRQ1MwMTYwMAoK
RE1JIHByb2R1Y3RfdmVyc2lvbjoKClRoaW5rUGFkIFQxNCBHZW4gNgoKRE1JIGJvYXJkX25hbWU6
CgoyMVFDUzAxNjAwCgpCSU9TOgoKTjRKRVQyOFcgKDEuMTggKSAoZGF0ZToKCjA2LzE2LzIwMjYK
CikKCkNQVToKCkludGVsKFIpIENvcmUoVE0pIFVsdHJhIDUgMjM1VQoKS2VybmVsOgoKTGludXgg
Ny4wLjAtMzgtZ2VuZXJpYwoKTklDOgoKMDA6MWYuNiBJbnRlbCBFdGhlcm5ldCBDb25uZWN0aW9u
ICgyNCkgSTIxOS1MTSBbODA4Njo1N2EwXQoKZTEwMDBlIGZpcm13YXJlOgoKMC4xLTQKCkxpbms6
CgoxMDAwIE1iL3MgRnVsbCBEdXBsZXgKCk9TOgoKVWJ1bnR1IDI2LjA0LjEgTFRTCgpJIGFtIGN1
cnJlbnRseSB3b3JraW5nIGFyb3VuZCB0aGUgaXNzdWUgYnkgc2V0dGluZyBkaXNhYmxlLWsxIG9u
LgoKVGhpcyBsb29rcyBzdWZmaWNpZW50bHkgc2ltaWxhciB0byB0aGUgcmVwb3J0ZWQgUDE0cyBH
ZW4gNSBpc3N1ZSB0aGF0IEkgd2FudGVkIHRvIHJlcG9ydCB0aGUgYWRkaXRpb25hbCBhZmZlY3Rl
ZCBwbGF0Zm9ybSBpbiBjYXNlIHRoZSBUMTQgR2VuIDYgYWxzbyBuZWVkcyB0byBiZSBhZGRlZCB0
byBkaXNhYmxlX2sxX2xpc3QuCgpJJ20gaGFwcHkgdG8gdGVzdCBhIHBhdGNoIG9yIHByb3ZpZGUg
YWRkaXRpb25hbCBkaWFnbm9zdGljcyBpZiB1c2VmdWwuCgpUaGFua3MsCkfDrXNsaQ==

--b2=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PHAgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4
OyBjb2xvcjogcmdiKDAsIDAsIDApOyBiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1
NSk7Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyI+KDwvc3Bh
bj48c3Bhbj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyI+Rm9s
bG93aW5nIHVwIG9uIHRoaXMgcmVncmVzc2lvbiByZXBvcnQ6IDwvc3Bhbj48YSBocmVmPSJodHRw
czovL2xpc3RzLm9wZW53YWxsLm5ldC9uZXRkZXYvMjAyNi8wOS8xNS8yNTM/dXRtX3NvdXJjZT1j
aGF0Z3B0LmNvbSI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsi
Pmh0dHBzOi8vbGlzdHMub3BlbndhbGwubmV0L25ldGRldi8yMDI2LzA5LzE1LzI1Mzwvc3Bhbj48
L2E+PC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7Ij4p
PC9zcGFuPjwvcD48cD48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyI+SGksPC9zcGFuPjwvcD48cD48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5z
LXNlcmlmOyI+SSBhcHBlYXIgdG8gYmUgc2VlaW5nIHRoZSBzYW1lIGlzc3VlIG9uIGEgTGVub3Zv
IFRoaW5rUGFkIFQxNCBHZW4gNiwgd2l0aCBhbiBJbnRlbCBFdGhlcm5ldCBDb25uZWN0aW9uICgy
NCkgSTIxOS1MTSBbODA4Njo1N2EwXS48L3NwYW4+PC9wPjxwPjxzcGFuPldpdGggdGhlIGRlZmF1
bHQgZTEwMDBlIGNvbmZpZ3VyYXRpb24gKDwvc3Bhbj48Y29kZT48c3Bhbj5kaXNhYmxlLWsxOiBv
ZmY8L3NwYW4+PC9jb2RlPjxzcGFuPiksIHdpcmVkIEV0aGVybmV0IGV4cGVyaWVuY2VzIHNldmVy
ZSBwYWNrZXQgbG9zcyBldmVuIHRvIHRoZSBsb2NhbCBnYXRld2F5LiBUaGUgaW50ZXJmYWNlIHN0
aWxsIG5lZ290aWF0ZXMgbm9ybWFsbHkgYXQgMTAwMCBNYi9zLCBmdWxsIGR1cGxleCwgYW5kIHRo
ZSBlMTAwMGUgc3RhdGlzdGljcyBkbyBub3QgcmVwb3J0IENSQywgZnJhbWUsIERNQSwgb3Igb3Ro
ZXIgUlggZXJyb3JzLjwvc3Bhbj48L3A+PHA+PHNwYW4+Rm9yIGV4YW1wbGU6PC9zcGFuPjwvcD48
cHJlPjxjb2RlPjxzcGFuPiQgcGluZyAtYyAxMCAxOTIuMTY4LjAuMQ0KMTAgcGFja2V0cyB0cmFu
c21pdHRlZCwgMyByZWNlaXZlZCwgNzAlIHBhY2tldCBsb3NzPC9zcGFuPjwvY29kZT48L3ByZT48
cD48c3Bhbj5BUlAgdHJhZmZpYyBpcyBhZmZlY3RlZCBhcyB3ZWxsOjwvc3Bhbj48L3A+PHByZT48
Y29kZT48c3Bhbj4kIHN1ZG8gYXJwaW5nIC1JIGVucDBzMzFmNiAtYyAyMCAxOTIuMTY4LjAuMQ0K
MjAgcGFja2V0cyB0cmFuc21pdHRlZCwgMTEgcGFja2V0cyByZWNlaXZlZCwgNDUlIHVuYW5zd2Vy
ZWQ8L3NwYW4+PC9jb2RlPjwvcHJlPjxwPjxzcGFuPkEgPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250
LWZhbWlseTogTWVubG8sIENvbnNvbGFzLCBDb3VyaWVyIE5ldywgbW9ub3NwYWNlOyI+dGNwZHVt
cDwvc3Bhbj48c3Bhbj4gb24gZW5wMHMzMWY2IHNob3dlZCB0aGUgb3V0Z29pbmcgSUNNUCBlY2hv
IHJlcXVlc3RzLCBidXQgcmVwbGllcyB3ZXJlIGFic2VudCBmb3IgdGhlIGxvc3QgcGFja2V0cy48
L3NwYW4+PC9wPjxwPjxzcGFuPlRoZSBOSUMgaWRlbnRpZmllcyBhczo8L3NwYW4+PC9wPjxwcmU+
PGNvZGU+PHNwYW4+SW50ZWwgQ29ycG9yYXRpb24gRXRoZXJuZXQgQ29ubmVjdGlvbiAoMjQpIEky
MTktTE0gWzgwODY6NTdhMF08L3NwYW4+PC9jb2RlPjwvcHJlPjxwPjxzcGFuPmFuZCB1c2VzIGUx
MDAwZS48L3NwYW4+PC9wPjxwPjxzcGFuPlNldHRpbmcgdGhlIGV4aXN0aW5nIHByaXZhdGUgZmxh
Zzo8L3NwYW4+PC9wPjxwcmU+PGNvZGU+PHNwYW4+IyBldGh0b29sIC0tc2V0LXByaXYtZmxhZ3Mg
ZW5wMHMzMWY2IGRpc2FibGUtazEgb248L3NwYW4+PC9jb2RlPjwvcHJlPjxwPjxzcGFuPmltbWVk
aWF0ZWx5IGVsaW1pbmF0ZXMgdGhlIHByb2JsZW0uPC9zcGFuPjwvcD48cD48c3Bhbj5BZnRlciBz
ZXR0aW5nIGRpc2FibGUtazE6PC9zcGFuPjwvcD48cHJlPjxjb2RlPjxzcGFuPiQgcGluZyAtYyAz
MCAxOTIuMTY4LjAuMQ0KMzAgcGFja2V0cyB0cmFuc21pdHRlZCwgMzAgcmVjZWl2ZWQsIDAlIHBh
Y2tldCBsb3NzDQpydHQgbWluL2F2Zy9tYXgvbWRldiA9IDAuMzg0LzAuNTM4LzAuODg1LzAuMDk4
IG1zPC9zcGFuPjwvY29kZT48L3ByZT48cD48c3Bhbj5hbmQ6PC9zcGFuPjwvcD48cHJlPjxjb2Rl
PjxzcGFuPiQgc3VkbyBhcnBpbmcgLUkgZW5wMHMzMWY2IC1jIDIwIDE5Mi4xNjguMC4xDQoyMCBw
YWNrZXRzIHRyYW5zbWl0dGVkLCAyMCBwYWNrZXRzIHJlY2VpdmVkLCAwJSB1bmFuc3dlcmVkPC9z
cGFuPjwvY29kZT48L3ByZT48cD48c3Bhbj5UaGUgcmVzdWx0IGlzIHJlcGVhdGFibGUgd2l0aGlu
IHRoZSBzYW1lIHNlc3Npb246IHRoZSBzZXZlcmUgbG9jYWwgcGFja2V0IGxvc3MgZGlzYXBwZWFy
ZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgZGlzYWJsaW5nIEsxLjwvc3Bhbj48L3A+PHA+PHNwYW4+U3lz
dGVtIGluZm9ybWF0aW9uOjwvc3Bhbj48L3A+PHByZT48Y29kZT48c3Bhbj48Yj5MYXB0b3A6PC9i
PiAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICAgIExlbm92byBUaGlua1BhZCBU
MTQgR2VuIDYNCjxiPkRNSSBzeXNfdmVuZG9yOjwvYj4gJm5ic3A7ICAgIDxzcGFuPkxFTk9WTzwv
c3Bhbj4NCjxiPkRNSSBwcm9kdWN0X25hbWU6PC9iPiAgICA8c3Bhbj4yMVFDUzAxNjAwPC9zcGFu
Pg0KPGI+RE1JIHByb2R1Y3RfdmVyc2lvbjo8L2I+IDxzcGFuPlRoaW5rUGFkIFQxNCBHZW4gNjwv
c3Bhbj4NCjxiPkRNSSBib2FyZF9uYW1lOjwvYj4gJm5ic3A7ICAgIDxzcGFuPjIxUUNTMDE2MDA8
L3NwYW4+DQo8Yj5CSU9TOjwvYj4gJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgICAgPHNwYW4+TjRKRVQyOFcgKDEuMTggKSAoZGF0ZTogPHNwYW4+MDYvMTYvMjAyNjwv
c3Bhbj4pPC9zcGFuPg0KPGI+Q1BVOjwvYj4gJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgICAgIDxzcGFuPkludGVsKFIpIENvcmUoVE0pIFVsdHJhIDUgMjM1VTwvc3Bh
bj4NCjxiPktlcm5lbDo8L2I+ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgICAg
PHNwYW4+TGludXggNy4wLjAtMzgtZ2VuZXJpYzwvc3Bhbj4NCjxiPk5JQzo8L2I+ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICAgICAwMDoxZi42IEludGVsIEV0aGVy
bmV0IENvbm5lY3Rpb24gKDI0KSBJMjE5LUxNIFs4MDg2OjU3YTBdDQo8Yj5lMTAwMGUgZmlybXdh
cmU6PC9iPiAgICAgMC4xLTQNCjxiPkxpbms6PC9iPiAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAgICAxMDAwIE1iL3MgRnVsbCBEdXBsZXg8YnI+PGI+T1M6PC9iPiA8
c3Bhbj4gICAgICAgICAgICAgICAgIFVidW50dSAyNi4wNC4xIExUUzwvc3Bhbj4gPC9zcGFuPjwv
Y29kZT48L3ByZT48cD48c3Bhbj5JIGFtIGN1cnJlbnRseSB3b3JraW5nIGFyb3VuZCB0aGUgaXNz
dWUgYnkgc2V0dGluZyA8L3NwYW4+PGNvZGU+PHNwYW4+ZGlzYWJsZS1rMTwvc3Bhbj48L2NvZGU+
PHNwYW4+IG9uLjwvc3Bhbj48L3A+PHA+PHNwYW4+VGhpcyBsb29rcyBzdWZmaWNpZW50bHkgc2lt
aWxhciB0byB0aGUgcmVwb3J0ZWQgUDE0cyBHZW4gNSBpc3N1ZSB0aGF0IEkgd2FudGVkIHRvIHJl
cG9ydCB0aGUgYWRkaXRpb25hbCBhZmZlY3RlZCBwbGF0Zm9ybSBpbiBjYXNlIHRoZSBUMTQgR2Vu
IDYgYWxzbyBuZWVkcyB0byBiZSBhZGRlZCB0byA8L3NwYW4+PGNvZGU+PHNwYW4+ZGlzYWJsZV9r
MV9saXN0PC9zcGFuPjwvY29kZT48c3Bhbj4uPC9zcGFuPjwvcD48cD48c3Bhbj5JJ20gaGFwcHkg
dG8gdGVzdCBhIHBhdGNoIG9yIHByb3ZpZGUgYWRkaXRpb25hbCBkaWFnbm9zdGljcyBpZiB1c2Vm
dWwuPC9zcGFuPjwvcD48cD48c3Bhbj5UaGFua3MsPGJyPkfDrXNsaTwvc3Bhbj48L3A+


--b2=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk--

--b1=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk
Content-Type: application/pgp-keys; name="publickey - ghrafn@proton.me - 0xBDFBA7A8.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ghrafn@proton.me - 0xBDFBA7A8.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYWtXSlN4WUpLd1lCQkFI
YVJ3OEJBUWRBL0lGcXUwS2hkbHFoWFdFV1RUN1U5dlNISEVQcG10NVYKQ1hEQmVmcHhrbDdOSTJk
b2NtRm1ia0J3Y205MGIyNHViV1VnUEdkb2NtRm1ia0J3Y205MGIyNHViV1UrCndzQVJCQk1XQ2dD
REJZSnFSWWxMQXdzSkJ3a1FUTzFsNXFPdy9sdEZGQUFBQUFBQUhBQWdjMkZzZEVCdQpiM1JoZEds
dmJuTXViM0JsYm5CbmNHcHpMbTl5WjBySVVkK2o4RzRDcFBkWjRxOGJzOFhZMGxaWFlVV20KQXVN
aFBIY3FZc2xhQXhVS0NBUVdBQUlCQWhrQkFwc0RBaDRCRmlFRXZmdW5xRTVMYmtwUjNhL2FUTzFs
CjVxT3cvbHNBQUlBK0FRQ3RleVk2eXhZb1UyMm9YZlkyN1l0TFJJeDg3WjRiV0prSEk1N2xpYU9N
REFFQQp2QTFsQVFyaldGNHcrb0xadzF3RnNxaDc3Qy9FR0VQWVBHQi9mMG54UkFMT09BUnFSWWxM
RWdvckJnRUUKQVpkVkFRVUJBUWRBN1JyQmJWcFFxUEhpOXQwVEFoNUtMZzRaZUhZT0lHZEoweE1B
N2VLKzJoUURBUWdICndyNEVHQllLQUhBRmdtcEZpVXNKRUV6dFplYWpzUDViUlJRQUFBQUFBQndB
SUhOaGJIUkFibTkwWVhScApiMjV6TG05d1pXNXdaM0JxY3k1dmNtZVZTZEVNSm9hRGJCeGtoN0Y1
ajBOWDNUVlY5OEdSQTkyVFA0dFoKYkEvK3hRS2JEQlloQkwzN3A2aE9TMjVLVWQydjJrenRaZWFq
c1A1YkFBQ212Z0VBaXZuUkVzbHhhM2lHCnVtb0lUYlJWTVFWcHlZTEVhV3dQSUFwTks0Uk1kTjhC
QUpjKzhvU0FOOTg4aGRlV0lsSTF0SkMrSHVuWgpUd01DbjI0eHFXandxTDhFCj16VlZJCi0tLS0t
RU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K

--b1=_VWVH8wuGEEL49m243DEGbDFj6TrN8oxkHyt52za6pk--

