Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07F2C77B7C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 May 2023 12:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3821F42782;
	Wed, 10 May 2023 12:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3821F42782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683721642;
	bh=3F1murEM0/Urs0DFqgJIyZiqDGlVC4yDKncgYPdXuNs=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=z03c6zjEo/1DG6kIUlO7+0Tt+hMafv+d2W2CoKqrF2HourILvvGgYmRabQSxA2enI
	 56gJmwGNuhjglCV7z4fg0GsHDHGq6iynrjqvfI9xMVZq46vBphnfNdovA2mMd8nOkf
	 8EsQipEp5HLMtJ6C3yyoAYCqJmvlSYK69roIgTfo19A5dMF/r3kqeP4g8i1MovkANq
	 dOUEsC6HJIVSjVLiFZrAGTnuHkTyG4W1lqTbqw62Z/+qkT8lx4nhHLrNJKNq39+lzg
	 z1Ggq61lpLNH1FlCsmp8HU5/BSv6JHerlpPbfSOAlXtCqLWQVOS8KX6a8CPCY4Ocb5
	 8Ap0XRruLMIXg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltCCTgALdYpS; Wed, 10 May 2023 12:27:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21DBE42784;
	Wed, 10 May 2023 12:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21DBE42784
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1A27D1BF2F3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 May 2023 12:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E658D41D9B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 May 2023 12:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E658D41D9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CT7rVUwfo2Jq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 May 2023 12:27:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AD27400CB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AD27400CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 May 2023 12:27:19 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Co_vYFcEOJ-zYuTgqzVMTQ-1; Wed, 10 May 2023 08:27:16 -0400
X-MC-Unique: Co_vYFcEOJ-zYuTgqzVMTQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a341ee4fcso895226066b.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 May 2023 05:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683721635; x=1686313635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9FhrSD1XrCjDumOnwPh62mqlGxc7OhmrfmRK8yiGd0=;
 b=X4xSLD/Pa06l5o5V/ZwBOMVy1TW+0x2+zAekkmXFRN9Cs9wDAY6/mztiHd4CRqxHpF
 +H4dRZU1zFjsIDS6Lsg4KMzxB1hzDzpn6UgdQd+sI95mZMWRdbpn92kVhX+IdfvffDZ1
 daCVFDQw6Y/uNw6WDtOLEFqeMJ7r4rqceFMzGXp71qjwMPQ2bujW76dIyzKtSZs/6qHf
 /gzYBUB6mp5Wjox8nWB/mAaIyiEe3Tw13zhmPpJCdYCUo6JpnzBcDshFm7qiUVaRGB1b
 VEbAeO+cV07g5BF283CwHiTlre/5lp2UqfmHryjVV985A2EgYmM2YwnQsb82nFj/1/m0
 D1bA==
X-Gm-Message-State: AC+VfDxZSHRj7bu0w+RkTFryQVt/qCFHUUFccfDY17j9J6DpmFek65fJ
 b7Psuh4Kv6RoqGCbseMEsOTyZ4FA6mHKIm7iRzf6jHvmHgVjv8LarWy2SUPp40QJDBmg57l3WWp
 UOynKB3KadHgsgPmn8lGI3wTGvodg6AlGJHGo9SmgUsHI4w==
X-Received: by 2002:a17:907:6eaa:b0:94f:81c:725e with SMTP id
 sh42-20020a1709076eaa00b0094f081c725emr18802760ejc.59.1683721635463; 
 Wed, 10 May 2023 05:27:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6R7ezDjKoh1PahDlTrTIkfBs638xEjh3Y9/f4K9M9srdkFG8nuPIKokn0b3/YP1AYxSCxsvKwn3ikY9kw4zVI=
X-Received: by 2002:a17:907:6eaa:b0:94f:81c:725e with SMTP id
 sh42-20020a1709076eaa00b0094f081c725emr18802744ejc.59.1683721635231; Wed, 10
 May 2023 05:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230509113943.27194-1-yochai.hagvi@intel.com>
In-Reply-To: <20230509113943.27194-1-yochai.hagvi@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 10 May 2023 14:27:04 +0200
Message-ID: <CADEbmW2QCdFUbZGEH-c058Br2dRwJXT=JHjAc72=M-Qps1SJgg@mail.gmail.com>
To: Yochai Hagvi <yochai.hagvi@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1683721638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9FhrSD1XrCjDumOnwPh62mqlGxc7OhmrfmRK8yiGd0=;
 b=gOwW0yiS+N45c+XXv4szHSooZx1L2wtnZw6k6fy27d6+UdM7ofPeZA5T3F6StNUoXtHo6v
 FvO7hgdZe8hm1k/ttn/cQbSGtGzVXdEWXAoLvSB2hwAacbEUSMeAKbS6Bwxsz68T4ZAgDK
 tIu5CnLfQ19nINhUMBltaTQDG1RqtQ4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOwW0yiS
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Schedule service task
 in IRQ thread_fn
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
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVHVlLCBNYXkgOSwgMjAyMyBhdCA1OjA44oCvUE0gWW9jaGFpIEhhZ3ZpIDx5b2NoYWkuaGFn
dmlAaW50ZWwuY29tPiB3cm90ZToKPiBPbiBzb21lIFJUIGtlcm5lbHMgKEUuZy46IE1vbnRhVmlz
dGEpLAoKVGhhdCdzIG5vdCByZWFsbHkgcmVsZXZhbnQgZm9yIHRoZSB1cHN0cmVhbSBrZXJuZWws
IGlzIGl0PwoKPiAgMy4xMC4wLTExNjAuMTEuMS5ydDU2LjExNDUubXZpc3RhLnRlc3QuNi5lbDcu
eDg2XzY0ICMxCgpDYW4geW91IHNob3cgdGhlIGJ1Z3MgZXhpc3RzIGluIHRoZSBjdXJyZW50IHVw
c3RyZWFtIGtlcm5lbD8KCj4gQ2FsbCBUcmFjZToKPiAgZHVtcF9zdGFjaysweDE5LzB4MWIKPiAg
X19zY2hlZHVsZV9idWcrMHg2NC8weDcyCj4gIF9fc2NoZWR1bGUrMHg3N2IvMHg5MjAKPiAgPyBj
aGVja19wcmVlbXB0X3dha2V1cCsweDE0Ni8weDIyMAo+ICBzY2hlZHVsZSsweDMwLzB4YTAKPiAg
cnRfc3Bpbl9sb2NrX3Nsb3dsb2NrX2xvY2tlZCsweGY1LzB4MmQwCj4gIHJ0X3NwaW5fbG9ja19z
bG93bG9jaysweDU3LzB4OTAKPiAgcnRfc3Bpbl9sb2NrKzB4MjUvMHgzMAo+ICBfX3F1ZXVlX3dv
cmsrMHhjZi8weDQ0MAo+ICBxdWV1ZV93b3JrX29uKzB4ZmUvMHgxMTAKPiAgaWNlX3NlcnZpY2Vf
dGFza19zY2hlZHVsZSsweDVjLzB4NjAgW2ljZV0KCkluIHRoZSBjdXJyZW50IHVwc3RyZWFtIGtl
cm5lbCwgSSBjYW4gc2VlIF9fcXVldWVfd29yayB1c2VzCnJhd19zcGluX2xvY2ssIHNvIEkgZG9u
J3QgZXhwZWN0IGl0IHRvIHNsZWVwIG9uIFBSRUVNUFRfUlQuCgpNaWNoYWwKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWls
aW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wu
b3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
