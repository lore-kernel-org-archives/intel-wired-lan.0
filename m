Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4524FC197A0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Nov 2023 14:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE315402F3;
	Thu, 16 Nov 2023 14:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE315402F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700145979;
	bh=zM9xUJmypNX43MAVSXrnO8BejtJTQFi2M+T+AtYw9cw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=uoQHVxNzGJNY8yFtQoejJZQJ03cCP1h+DD4QBpfyj65InlcEszmlbXphYrVdAHdUd
	 zNlIVGMq9IMmcQC6DYSgn1JzInK54lSI6P2/6qt0OWgXyI0OqLDeae2lCBBbEO1kSV
	 OlCC0Zfhj8BeIJIu/zZCefx7xRVDZzNFDYBP8kocTHXmuHNkXv9xFygm2PwWMXmjB/
	 Pp01Qh/X7pWSMDSE0TbRIaEdo7yXPeCq1nFP4KJ+IoMZQji4q4VOiL20x8fY+kdgQ4
	 sTmXsJE+FxNIy7XCfJRXzvZIS7Cd7bQryNiCYu9knkl4ZRB4RpYPCZVo7IDK0lx4jV
	 f4UzPUDoJ31lQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9MAA78OYkoA; Thu, 16 Nov 2023 14:46:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97EEF419E9;
	Thu, 16 Nov 2023 14:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97EEF419E9
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BFE621BF363
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Nov 2023 14:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1CF6419E9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Nov 2023 14:46:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1CF6419E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRZVSMThnZ-6 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Nov 2023 14:46:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCE88402F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Nov 2023 14:46:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCE88402F3
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-yg6dT8FlPhCvECEC6khXCA-1; Thu, 16 Nov 2023 09:46:11 -0500
X-MC-Unique: yg6dT8FlPhCvECEC6khXCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34E38185A784;
 Thu, 16 Nov 2023 14:46:10 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 899882166B28;
 Thu, 16 Nov 2023 14:46:08 +0000 (UTC)
Message-ID: <2332ea8b-16d9-402f-8be6-683e52c6758e@redhat.com>
Date: Thu, 16 Nov 2023 15:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-4-ivecera@redhat.com>
 <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
 <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
 <72250942-17af-4f8d-b11f-ba902fbe2b58@intel.com>
 <483acf53-fe96-4ef3-933a-c5fd446042f6@redhat.com>
 <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1700145974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTqorEhdT7DMAGJHmu4VBxw/55IAIeOOpj+g7xYY/4M=;
 b=MfhB9OQmSfdv8/ZV4bO/oPjmRi0Gy4JQZTmm7ISYWzmQFNxinJVRL5YAZmfD4xQNDYWJI8
 G5QlcLwL/r8dLN/3oXazspbRQ/MVyVlerzBfvUcj4yQsxmIv7IoMqXfHOkNDziZRdgRTQT
 6VZj4Gc8RdgFYRPEB4vobVObRkc0DmM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MfhB9OQm
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/5] i40e: Add helpers to
 find VSI and VEB by SEID and use them
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
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ck9uIDE2LiAxMS4gMjMgMTU6MjEsIFdvamNpZWNoIERyZXdlayB3cm90ZToKPj4+IFNvdW5kcyBn
b29kLCBteSBwb2ludCB3YXMgdGhhdCBJIHByZWZlciB0byBoYXZlICJnZXQiIGJlZm9yZSAie3Zl
Ynx2c2l9Igo+PiBPSywgZ290IGl0Li4uIFdpbGwgcmVwb3N0IHYyIHdpdGggdGhpcyBjaGFuZ2Ug
KyAidG9vIG1hbnkgYWxzby4uLiIgaXNzdWUg8J+YiQo+IFRoYW5rcwo+IAo+PiBCdHcuIHdoYXQg
YWJvdXQgdGhlIGxhc3QgcGF0Y2g/Cj4gUmV2aWV3ZWQg8J+ZggoKVGhhbmtzLCBXb2pjaWVjaCEg
QnV0IEkgYWxyZWFkeSBzdWJtaXR0ZWQgdjIgb2YgdGhlIHNlcmllcy4uLmJ1dCB3aXRob3V0IAp5
b3VyICdSZXZpZXdlZC1ieTonIHRhZyBpbiBwYXRjaCA1LiBDb3VsZCB5b3UgcGxlYXNlICJyZXZp
ZXciIHRoZSB2MiBvZiAKcGF0Y2ggNSBhZ2Fpbj8KClRoYW5rcywKSXZhbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxp
bmcgbGlzdApJbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5v
cmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC13aXJlZC1sYW4K
