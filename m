Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86352C04A94
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Jul 2023 21:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CA94607F0;
	Mon, 31 Jul 2023 21:17:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CA94607F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690838226;
	bh=+rzDgqeHtEEGFMEf8vRUKfIS8FVR9TaRRx3T893fut8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4WLJOCzIj2VciRx8W/vKxmS56ieTHxRFOwjbofy5PdC2y5JxdrjAmRSHAK0u951KI
	 pCUQw/uxBfnbzhAZq6e4IA0v4qmLmvR0VEAxLV0RqNd8TCaKwnLBp/VAx+/jZjQAF3
	 IQHP+F6Hmd/JoPFag7fD+y2ZJi+OZjTSPcwYbWKYn5GrZ/dQOr+gcl7uMKMWvQiB15
	 Mfh5WeiyaDOt4ZLweupyNiss0zZafStCVBmLJmxVbCBb34pNiAF3Vi4ELkZzlm1DxQ
	 5Jbn9+F8vRkyPMhPSOmCwe6fKWSXAPFW/h87+sqDSPCHU30PJWsyzAGJ+nG//Z9p5Z
	 SfGU12+2kEJXQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4XUu5AkLdiJ; Mon, 31 Jul 2023 21:17:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 032A4610D7;
	Mon, 31 Jul 2023 21:17:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 032A4610D7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 0FBB61BF2B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 18:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16DD442F85
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 18:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16DD442F85
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjNDBofyOfAc for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Jul 2023 18:44:51 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AAFF42F73
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 18:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AAFF42F73
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC2761265;
 Mon, 31 Jul 2023 18:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA0C433C7;
 Mon, 31 Jul 2023 18:44:45 +0000 (UTC)
Date: Mon, 31 Jul 2023 20:44:43 +0200
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <ZMgBG2ZpXnsvZ07p@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
 <ZMdfznpH44i34QNw@kernel.org> <20230731085405.7e61b348@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230731085405.7e61b348@kernel.org>
X-Mailman-Approved-At: Mon, 31 Jul 2023 21:17:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690829089;
 bh=g3Lr/Shj430AcLy3upoQKrQHWCX0lvtJx+HQZMenFUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s13XF2bE9SNSwkihwKJPwAXxWY8t23Ytmp7/dTxr2PoDBRRtavEX2dHXVdYkXudmw
 PHTjB+dzBaIZVM6nh033Kqy06tkT8+1NIyMZST3l9gvEOVgIy94AZa20X9UpZBKqLd
 sFIsJxFGr9FKu19AJHmUCOLc7ICFDOt/7DzD5HiSeWsVaHDI8XTGaBcvLkqT50HTE/
 VGlNiX/P2nVuCDgweh8EH67VwcNbs/xclJdLa1Z2tB7bi+bOzWYgvyiPh/WCLqWwxG
 C2ZJp7uM4AwM4Q1S1Pi46yKyr8DaJbI+JZztrAQYwxq+jbEC72yvdGu2ylFO+0NO6p
 Bze6WlJNJZ2+Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=s13XF2bE
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] rtnetlink: remove
 redundant checks for nlattr IFLA_BRIDGE_MODE
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
Cc: ajit.khaparde@broadcom.com, simon.horman@corigine.com,
 bigeasy@linutronix.de, somnath.kotur@broadcom.com, edumazet@google.com,
 anthony.l.nguyen@intel.com, michael.chan@broadcom.com,
 louis.peens@corigine.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, huanhuan.wang@corigine.com, tglx@linutronix.de,
 yinjun.zhang@corigine.com, Lin Ma <linma@zju.edu.cn>, na.wang@corigine.com,
 sriharsha.basavapatna@broadcom.com, netdev@vger.kernel.org,
 oss-drivers@corigine.com, linux-kernel@vger.kernel.org, saeedm@nvidia.com,
 davem@davemloft.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gTW9uLCBKdWwgMzEsIDIwMjMgYXQgMDg6NTQ6MDVBTSAtMDcwMCwgSmFrdWIgS2ljaW5za2kg
d3JvdGU6Cj4gT24gTW9uLCAzMSBKdWwgMjAyMyAwOToxNjozMCArMDIwMCBTaW1vbiBIb3JtYW4g
d3JvdGU6Cj4gPiA+IFBsZWFzZSBhcHBseSB0aGUgZml4IGRpc2N1c3NlZCBhdCB0aGUgbGluazoK
PiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwNzI2MDc1MzE0LjEwNTkyMjQt
MS1saW5tYUB6anUuZWR1LmNuLwo+ID4gPiBmaXJzdCBiZWZvcmUgdGhpcyBvbmUuICAKPiA+IAo+
ID4gRldJSVcsIHRoZSBwYXRjaCBhdCB0aGUgbGluayBhYm92ZSBzZWVtcyB0byBiZSBpbiBuZXQt
bmV4dCBub3cuCj4gCj4gSSBkb24ndCB0aGluayBpdCBpcy4uIPCfp5DvuI8KClNvcnJ5LCBteSBi
YWQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVs
LXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6
Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
