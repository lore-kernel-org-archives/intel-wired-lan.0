Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4B9EB64DA
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Jul 2023 09:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79CC64099D;
	Tue,  4 Jul 2023 09:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79CC64099D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688463633;
	bh=cYZGfekV34o5TG0fJgMrLC4JXRoqzXFaRjsoRfl/5pE=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zXLP/5DEQlglwIE1TtEm9UsU7sdIsY/aAfxXW1VD0I5HK2GivEoPZq8zW8bxlS4u5
	 zbiYRvot8FWQXQGGYcybvdX6yXEmTfMxjKXKO70CAR3ciI3J+dCUCyMJJAa42gD+kQ
	 4Azl8hB3sSOLR9GIulAo3lpDRYDB7Ux0bhxR69LbU/UodByEAKHBKoGBN8s578EFmW
	 HVLdO/xU7vdx2Y8pOPms0QhUb3i2FhZwygNCjBLa89PeYGPHYR3J/HdzK+dF1mtv9i
	 ywKapME9fWX+K4jp9WjEbQ0TiBzp38CpXxqLfdNJHGBWQW5Xpu0zrsYStR9U9BGdPb
	 kCJD6w6x194yg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FRf4G2ZrO7y8; Tue,  4 Jul 2023 09:40:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DA41409A3;
	Tue,  4 Jul 2023 09:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DA41409A3
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 39D311BF287
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jul 2023 09:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F4F1403C9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jul 2023 09:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F4F1403C9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYef7s1g5YoM for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Jul 2023 09:40:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 536C740391
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 536C740391
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jul 2023 09:40:29 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 150F461E5FE01;
 Tue,  4 Jul 2023 11:39:31 +0200 (CEST)
Message-ID: <0df64c1c-1902-574d-266a-79f63f38ac3a@molgen.mpg.de>
Date: Tue, 4 Jul 2023 11:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Florian Kauer <florian.kauer@linutronix.de>
References: <20230619100858.116286-1-florian.kauer@linutronix.de>
 <20230619100858.116286-5-florian.kauer@linutronix.de>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230619100858.116286-5-florian.kauer@linutronix.de>
Subject: Re: [Intel-wired-lan] [PATCH net v2 4/6] igc: No strict mode in
 pure launchtime/CBS offload
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
Cc: Tan Tee Min <tee.min.tan@linux.intel.com>,
 Malli C <mallikarjuna.chilakala@intel.com>, netdev@vger.kernel.org,
 kurt@linutronix.de, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

RGVhciBGbG9yaWFuLAoKClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4KCkFtIDE5LjA2LjIzIHVt
IDEyOjA4IHNjaHJpZWIgRmxvcmlhbiBLYXVlcjoKClvigKZdCgpGb3IgdGhlIGNvbW1pdCBzdW1t
YXJ5L3RpdGxlLCBtYXliZSBtYWtlIGl0IGEgc3RhdGVtZW50IGJ5IHVzaW5nIGEgdmVyYiAKKGlu
IGltcGVyYXRpdmUgbW9vZCk/IE1heWJlOgoKPiBGb3JiaWQgc3RyaWN0IG1vZGUgaW4gcHVyZSBs
YXVuY2h0aW1lL0NCUyBvZmZsb2FkCgoKS2luZCByZWdhcmRzLAoKUGF1bApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC13aXJlZC1sYW4gbWFpbGlu
ZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0dHBzOi8vbGlzdHMub3N1b3NsLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
