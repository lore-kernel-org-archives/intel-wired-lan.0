Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9FAE8FDC0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Oct 2023 23:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB63940646;
	Tue,  3 Oct 2023 23:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB63940646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696375535;
	bh=Kr4kshURYcR3BE3HYjc+VKkxIq2yvjVXcJrb3PJi6kc=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6n71CnDtwPYeVQ145U3UMSJriuBDwvCaygfDu7t7JjMlZxZwAPjgYwrHieQxwxxsN
	 SyrxhLUPNPffgJsEjqjXsUxPkbAEDh4e+l7kRupW2hGoGmWU7JwbsI63C9EM/XePgS
	 4C20F9+IA8jvL9kEDeXS+jVpjLQsaBPRp0SQU9944NjQW5GvPNNYxHSpHTQTtbm3Fx
	 r8G0ENRua0Djb6kTczGsuEjwHW1u03lm6SqcR5VU44ZVp7s4LtOHPr//yjuK9pZ3s9
	 Xj1ewABduSYRT9x9NxiFeZBoudDSpOR2HJJbwaqtRdSN7ovm2MQzEBWT2evGdoFLtc
	 w2gk8Tsbxr3tQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxsWeJWi0wmp; Tue,  3 Oct 2023 23:25:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE1104183F;
	Tue,  3 Oct 2023 23:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE1104183F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9B1731BF42D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 23:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7278F82214
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 23:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7278F82214
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LXPDOmZhcjf for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Oct 2023 23:25:31 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1202C82176
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 23:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1202C82176
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id EC23E5C03D2;
 Tue,  3 Oct 2023 19:25:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 03 Oct 2023 19:25:29 -0400
X-ME-Sender: <xms:6aIcZfBzWctnAPA2yTGQBe1QCulvmjiUW7CTURet0z2h3zpMYhYbwA>
 <xme:6aIcZVgZdjx0QkJCTzWmI5EkwGIp0s5KWdgrzNnLbtJBaAvomHfaQX7Qqmwe4xY6s
 7ohjpWKP4b8aSsDWv4>
X-ME-Received: <xmr:6aIcZakyjn0RVfJboq7A5042w1GbUti0Z9dq2i6M8JtjXAgsims8RZbFy1xibkxv3U1P5J8COBkoKRw0aoEr5zaGt1DkxPCmvbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeekgddvudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvfevhffutgfgsehtkeertd
 dtfeejnecuhfhrohhmpefukhihlhgvrhcuofomnhhthihsrggrrhhiuceoshhmodhlihhs
 thhssehskhihmhdrfhhiqeenucggtffrrghtthgvrhhnpeffkeetvdfhjeeitdejvdeive
 ekvdffheefuefhheejveefhedvudevvdffieeiueenucffohhmrghinhepvhihohhsrdhi
 ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsmh
 dolhhishhtshesshhkhihmrdhfih
X-ME-Proxy: <xmx:6aIcZRzUvr0CffIcGYFwB4LdQEwYXkqDq4fDaiLN5Pr-lNySSIkvVg>
 <xmx:6aIcZUQ85UogpruNyRqMpJJd2H1rN0C6-6viYL9goqnyDxe4wmfCGA>
 <xmx:6aIcZUZdVt8vrAWL1hj87z6DcXSVke9RbaEt8iauOTZF3E0WSJWFAg>
 <xmx:6aIcZd6bhfJztTis7cpci2udxkeIheda0e2KgM7YYjkHrVNBVts1mw>
Feedback-ID: i1cc947c0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 19:25:29 -0400 (EDT)
Message-ID: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
Date: Wed, 4 Oct 2023 02:25:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: netdev@vger.kernel.org
From: =?UTF-8?Q?Skyler_M=c3=a4ntysaari?= <sm+lists@skym.fi>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skym.fi; h=cc:cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1696375529; x=1696461929; bh=oM
 6U6gMaV7UCPCFtR8zAHE/UJ2iRKBWMiyAlX2N9yBM=; b=PvhZofSmI+jXB+D076
 DEdzL2gzlq2RORBZVUBHs23Fea4OQfrDfO/TN3af60pKQEu4PgccwqSNOBcPCtvj
 i+GxGk1WQV/Ds94kORLEKDdKCU3aK2t2i9ESure/JPVeNHk+Jpt+CqSi7FiXWB5E
 vxN5Cw1JcdNFVQ/NocZQqDW/mPqQ1D0pmaJcuwuZCcU4Ya+KM1TzHDTBnwEhtNXp
 fWNzeAjbEPrlGK3SPGXuVpGsbWu2Cs48uNUn2RdvnlhVN6IZ/Y85uhemQ5OTSjaF
 oSe9RjAvUvZFIv1udFsQ1COdC8c3Tfzx3xTkiCCQazE4DfB0sFMAyDV9uzCsO2o+
 liRw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1696375529; x=1696461929; bh=o
 M6U6gMaV7UCPCFtR8zAHE/UJ2iRKBWMiyAlX2N9yBM=; b=n/NYqMuQ3/Gh2TKDH
 NiTNblp77tUbd9Js63PVGO6eXclJ6XZVurTlU812qkqhx9EI4OFFNNsGZKTSkJVR
 1u3EAEZD7I3hG2KUpaZCygS9fh3H2GrDD6PPVDw7zAF59diMn4GVzcxh4WvsVyaJ
 aagq4OXjvVtdq+/1JXombXEK/dhhLQXI5dnu0EHVYYWOlph49UORWTIDjTtZAjN7
 6/5bxWHQmOEfTtrmPU4HtVZZfECVfHkq5CGIzrV2LjxtKNshM/MfDzzKJNVd0L0O
 iBuOUe9N4/pz5ZPoZQ7/oTobpb7GeL87XcPFb/pjo4qD/hY58nqCWORRX8xN8Tvl
 HXXDw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=skym.fi header.i=@skym.fi
 header.a=rsa-sha256 header.s=fm3 header.b=PvhZofSm; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=n/NYqMuQ
Subject: [Intel-wired-lan] The difference between linux kernel driver and
 FreeBSD's with Intel X533
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

SGkgdGhlcmUsCgpJdCBzZWVtcyB0aGF0IGZvciByZWFzb25zIHVua25vd24gdG8gbWUsIG15IElu
dGVsIFg1MzMgYmFzZWQgMTBHIFNGUCsgCmRvZXNuJ3Qgd2FudCB0byB3b3JrIHdpdGgga2VybmVs
IDYuMS41NSBpbiBWeU9TIDEuNCBub3IgRGViaWFuIDEyIGJ1dCBpdCAKZG9lcyBpbiBPUE5zZW5z
ZSB3aGljaCBpcyBiYXNlZCBvbiBGcmVlQlNEIDEzLjIuCgpIb3cgd291bGQgSSBnbyBhYm91dCBk
ZWJ1Z2dpbmcgdGhpcyBwcm9wZXJseT8gQm90aCBzaWRlcyBzZWUgbGlnaHQsIGJ1dCAKbm8gbGlu
ayB1bmxlc3MgSSdtIHVzaW5nIEZyZWVCU0QuCgpGb3IgcmVmZXJlbmNlIHRoZSB0aHJlYWQgb24g
VnlPUyBmb3J1bXMgcmVnYXJkaW5nIHRoaXM6IApodHRwczovL2ZvcnVtLnZ5b3MuaW8vdC8xMGct
c2ZwLXRyb3VibGUtd2l0aC1saW5raW5nLWludGVsLXg1NTMvMTIyNTMKClAuUyBTb3JyeSBmb3Ig
dGhlIGRvdWJsZSBwb3N0aW5nLCBidXQgbm93IGl0IHNob3VsZCBnbyB0byB0aGUgSW50ZWwgbGlz
dCAKdG9vIHByb3Blcmx5LgoKQmVzdCByZWdhcmRzLApTa3lsZXIgTcOkbnR5c2FhcmkKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdpcmVkLWxh
biBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5v
c3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
