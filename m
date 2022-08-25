Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85094ECAAA3
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Aug 2022 22:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E23DE41914;
	Thu, 25 Aug 2022 22:06:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E23DE41914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661465198;
	bh=IFC0Yv75m77EPzTX7C/Cx5lZwxX7BHm1m7L1HjkLGiA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gJO3N4HQuq9YdajjqQ92puwu4MlgDLpwtQ+YVvKZYZtEO6vdjFbU+v2i8PQezXudC
	 soKAuF1/s8xiVzLRG9eh79xP2M0UlRuDtNDkHHcoxHy8g7vg+fzalu8Qie4JemH+EQ
	 9trvI8sbcdzPZtnEQ+JEkZGhaqApfL2vbJWkZ8O3U1X49r8cRRs7SS18tefEsKMR+d
	 mEy3I9C6HrbRT5zZ2JJlS0wySnuOVYVLV4rJdqB7ReG74WbKtdp9dDsI+oMHfNOEUX
	 iyeJLpncFuBkN5p4BTdMYsn4JOLdwyodScCkhKtRr4SYdCcrcPaA8t6kGGwhh6tK64
	 waPeXA5VgNWXA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elqAnAfEmtgn; Thu, 25 Aug 2022 22:06:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCBAA41915;
	Thu, 25 Aug 2022 22:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCBAA41915
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7956B1BF3DE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 22:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F6C260746
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 22:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F6C260746
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DhPAzGrKVLYj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Aug 2022 22:06:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82E04600CD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82E04600CD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 22:06:35 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-Eyp385LrOX-P6lqWLjOxEw-1; Thu, 25 Aug 2022 18:06:33 -0400
X-MC-Unique: Eyp385LrOX-P6lqWLjOxEw-1
Received: by mail-ed1-f71.google.com with SMTP id
 f18-20020a056402355200b00446c8d2ed50so8158499edd.18
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 15:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:to:reply-to:from:subject:message-id
 :x-gm-message-state:from:to:cc;
 bh=TjOSetCyI28iAaE9wrPuq2JeFZsheOr59V7WzvY+0dg=;
 b=vpoNKQAJ7rOcgx8OtEoXaNUJZ1Ep+nKlOGpYgrA9R07bDLwbS4KozQ6FB2PxwtO1em
 1LLra6f4vMUtFNS9o59iNMhUbd1VW3860w3oIWGbdiMq95gjvKTy/P3HXHDeq5igIylO
 YgDnvgsI3lThUUU4Hsp5IZHmRU9vRkdSG2kAEL52U7d77uqLHLTOzUgtVjbBridYOpWD
 X0nn0I7QKNbyxe7EEghjzCIq+E2V1Q2qxA7pBEUwHE3pcV8SkFezXzTb/sAGLmbOicyQ
 seAqK3QYHb5vJcRQtM2bVKJtK646rTYZ9lb8mOyV7/hfypr68hP5xZXEVVULD75UCyKX
 0cfA==
X-Gm-Message-State: ACgBeo3oz3DMoeE+y0zuM8ZOneyJ4qVyDDe+XCutu1VrLwnqOuuSh5/I
 5iH/h3NAGHR2yvG0XwgG3q0uCfTJqFqXRk6JmwCTd+z+8iwmbug3ViPr8EDnNTYPoSdxD1cS/zT
 5+PdRxkueHLO/OBP/gRqGR9XVkyTY1g==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id
 fj8-20020a0564022b8800b0043a6c586c64mr4768645edb.348.1661465192016; 
 Thu, 25 Aug 2022 15:06:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Wh/c80+Etrx3epAgcTErJf8x8Hv4F8E7bPBcZj3L1XTVI4N6lOCgiXW61wuu+aldQre2e2Q==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id
 fj8-20020a0564022b8800b0043a6c586c64mr4768631edb.348.1661465191806; 
 Thu, 25 Aug 2022 15:06:31 -0700 (PDT)
Received: from [192.168.2.36] (ip4-46-175-183-46.net.iconn.cz. [46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a05640234d400b00447c2c1b9a0sm301107edc.91.2022.08.25.15.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 15:06:31 -0700 (PDT)
Message-ID: <b27d89a91183b60f2a4818174ac5041425abf97e.camel@redhat.com>
From: Petr Oros <poros@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Date: Fri, 26 Aug 2022 00:06:30 +0200
In-Reply-To: <20220822185654.59145-1-anthony.l.nguyen@intel.com>
References: <20220822185654.59145-1-anthony.l.nguyen@intel.com>
Organization: Red Hat
User-Agent: Evolution 3.44.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1661465194;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjOSetCyI28iAaE9wrPuq2JeFZsheOr59V7WzvY+0dg=;
 b=hHEfGJZQuvzA22P+GuuLGhH5l1xhJilLBmfAo9Pyq+7gkOTAIAGTKSQ2T8zVcjkZqVyObL
 af3eGLBqITLjTnoAcR89aGfvC44pXXSsxaoHBErNHme4MDsn+geeF0HQpPULMA+KtowrrQ
 G3cyvNkMi29v56I6xHDvbvfhnpDvgNo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hHEfGJZQ
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Allow operation with
 reduced device MSI-X
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
Reply-To: poros@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

VG9ueSBOZ3V5ZW4gcMOtxaFlIHYgUG8gMjIuIDA4LiAyMDIyIHYgMTE6NTYgLTA3MDA6Cj4gVGhl
IGRyaXZlciBjdXJyZW50bHkgdGFrZXMgYW4gYWxsIG9yIG5vdGhpbmcgYXBwcm9hY2ggZm9yIGRl
dmljZSBNU0ktCj4gWAo+IHZlY3RvcnMuIE1lYW5pbmcgaWYgaXQgZG9lcyBub3QgZ2V0IGl0cyBm
dWxsIGFsbG9jYXRpb24sIGl0IHdpbGwgZmFpbAo+IGFuZAo+IG5vdCBsb2FkLiBUaGVyZSBpcyBu
byByZWFzb24gaXQgY2FuJ3Qgd29yayB3aXRoIGEgcmVkdWNlZCBudW1iZXIgb2YKPiBNU0ktWAo+
IHZlY3RvcnMuIFRha2UgYSBzaW1pbGFyIGFwcHJvYWNoIGFzIGNvbW1pdCA3NDExMDZmN2JkOGQg
KCJpY2U6Cj4gSW1wcm92ZQo+IE1TSS1YIGZhbGxiYWNrIGxvZ2ljIikgYW5kLCBpbnN0ZWFkLCBh
ZGp1c3QgdGhlIE1TSS1YIHJlcXVlc3QgdG8gbWFrZQo+IHVzZQo+IG9mIHdoYXQgaXMgYXZhaWxh
YmxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRvbnkgTmd1eWVuIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbWFp
bi5jIHwgMTg3ICsrKysrKysrKysrKy0tLS0tLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
MDIgaW5zZXJ0aW9ucygrKSwgODUgZGVsZXRpb25zKC0pCj4gCgpUZXN0ZWQtYnk6IFBldHIgT3Jv
cyA8cG9yb3NAcmVkaGF0LmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFu
QG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50
ZWwtd2lyZWQtbGFuCg==
