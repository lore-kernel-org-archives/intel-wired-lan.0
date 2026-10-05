Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255FDCA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 10:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE80E40651;
	Mon,  5 Oct 2026 10:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxE0049rAWMu; Mon,  5 Oct 2026 10:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4584540648
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791196128;
	b=HF0edkbe2FbTMm8kyjLS1CJJCRsjMBe1h+TCU6LDtTRAjngxagv9g52EG37gQRarGcdO
	 aW/Gthh593AvsduIIwVLbD8qN4IcHWpEw3LZoUXpyZZtE56Dk2nM2kq4TBp17IeVK8YLj
	 hv+JNfqS95BlpvTXDWqyAVQla18BBZ6Pm73rsP70RgWMbeJa3tTRsAMkHCMe0tkp5Z9yU
	 9lNf5dQpfBzWi/5nFHWIryd+0doDdcU/Ye/jVPHuv0dtNBJTKoiZRarMw8Wygsax3ju7+
	 YjIRjn7epCzuGIFF4/kl/AdkRLVULptNSN1VffEZSYGUp2qS+masPbDwP6zATW/c1hg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791196128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DbtJCDswZaLqbAdnYBGQUijanMXQ+vHGX1bm7a/fcKk=;
	b=UgX9j9L8ScAsIwMw8sG0fwqngEZaLEtLljhekLnVYMbdUiuqPeQQK36M6Oy9oKVfa117
	 Dv9j3XMoRQinnoO2QSl6em9e+2uUF1+XDtjLYR7XeI9bC/atr7ZC3rgm7GdxiMyKWKJ44
	 FLgLxUK4gY40nh93UOvglJynOsE/9Pll8nlUBo45n/s17gjH5qwytz9Z94jChb6bK2A98
	 ambyHBFE/C0wknbVUl8xkvH/TsS/xPZWAMtp/nUHxJH/o1ueD5YxUia02pfnQPOZKm246
	 pQrpWIwTHKwOtm3yHY+3ywT4rP8y4zYxBqbJHcjFDLSFkY1lgJlkh8Vh1AhSjwx5FKQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="c/KO2IjM";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791196128;
	bh=DbtJCDswZaLqbAdnYBGQUijanMXQ+vHGX1bm7a/fcKk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQdr0AVdKt5BueyESbSqf6yTXHLgphB4h2onzgG7ocy0oy0qYH07yvKV02AzLkMXR
	 tjhJBF8KsuTyP+Kz+iSYrxh+0J6fRtYxIcBpli2cQESQdLVOG8Uy/1opPLUissXCXe
	 FQgsS2BRqtO2J86vU8p94FoTVP+XZWGU86ujQn3N8OHDMHraPg62C+iYPGmFU0s/Q9
	 oa5p6r6P6viFG2n2bT+Fum+8FhlA3FGO5wEwetq+BTZBmhuMh6rdJa477ZolTFdq/M
	 fughAa3yunwcGPrmADQz1ypKSWzZYEicKLvrUR/4IPGhU9umf99xhCDm3kWppWO5Tz
	 LForaRzGxJS3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4584540648;
	Mon,  5 Oct 2026 10:28:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B679338
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D80040637
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OeN-JYgmPpLh for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 10:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5B3A40552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791196052;
 b=j08kkw77+g8Tn9xKMhsYKLuQxWbLvw60UhzBiBtwESV96ILMNnkpJVfnXI2LnSGP0L6M
 8dBvlQMByNOtmua5zameoU/UEarbkAYJ689f+BuzAMjaBQ6JOiVkG7mIt7HduM1bfoR1U
 sj9WD8a+rtPOrvAoExpDIDY09wgomImZjJNjEJ7UcJgwdc7Vftr6QGjEgTdVVOSKYsW47
 jfaqrShjnEyPxytISTpuULf3kxE3SITIU53FZEtD7JdQfxD3lMJw2itrAGrcvH9uVmOMU
 c0F05KGdweD96UdWSGw205bPfHo9K+dj7Ovk9Ku6HMGKTSqGueRy/JnRej/I2xBvcZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791196052;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=DbtJCDswZaLqbAdnYBGQUijanMXQ+vHGX1bm7a/fcKk=;
 b=ApD9bc68JaWX+gWjWWaxp4MfuncKUbc+Da3HF1chOv5KoghviVeBPxrV6Z+08FwaauHT
 2QA4onmyLJmIsc1fM5ExZQUFkD0fHMf2oZQOYlT7Lx+/GhN2RppYHM2J2+e6ZRgQTgtb9
 iCabuBB0I49CO0lZgqvoBlaNQnUuQyz3Wv+YLXfSX7ErszpfrsJiZwkeexUdWQNVmtlYE
 JMGYMY2qi5NvpGzmfnp0iT20yDpYErMz+o9D5Az4j7a62gIbKdH3B9loP8ycAQavtu6Ms
 p6MIcdz1l/zYK/45En/NpSKuQG+z+Bh2OM8PFkrZYrl80ymQATNAKqsHP8W79MgTHnw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="c/KO2IjM"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=c/KO2IjM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5B3A40552
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791196053; x=1822732053;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GBp9KT3ypseZWLIhVrWozvaA9s71CtU+clF/SDgecZo=;
 b=c/KO2IjMPP7kest2qBW/DZGkiCNY5zQl6f5+D0kozYB6IIOelX0DbVlH
 KHcE/hgsF6oyiEW5bLT6Z6mFCI9jkglRwD9t5UM/NMG4CqjaU04l6Vb2X
 3VIuYt2FILuv9B+lR7B89HQWVC4HxJOI/WuadZ3NuES5IHSM9XdcqjLnt
 eYTAGEszO46mmO3x1Gtbacbv78TwnMjucaKoKDWH4bJv5l6PI9l4e/9Vm
 gev7OQ1xlDFYuiHsJZkcOqp+95VJcQBy+smvyFTAkUtrgc9UE8DtcE5zB
 fe3a5kQcBhRj1Pa4vyU/KiltJqgE9vj/VbbOo7FdrmUmbcVEDsdKnHhUP A==;
X-CSE-ConnectionGUID: /09nsmP+QfelfRBnHGeWDg==
X-CSE-MsgGUID: lV5HtUjhQGS04rQLkmrWgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102024610"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="102024610"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:27:31 -0700
X-CSE-ConnectionGUID: IS8DZrCISaOonKxZsR5BgA==
X-CSE-MsgGUID: kicRHkQQRr+Uql9o4KBdoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="280527006"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 03:27:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:27:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iN4sohL9XepLDGkOuEjxX8bI4ksod7SrKb5+D7fxGnyXKOj1lycFhQDIaUOyx21qQ7nFmtnsLctPk4AskI91Mvwa1TP4dtuKpWw3iGNqpZ3rhujvrPbz3H2O5jFUfSNrgI6g0kzOtDLFn2XZvk/L0Ibu3oGmao8ebFGH6ZDZDDilLLUJCCI0gLcxhHKoW1wzy9n5mcFyYto8I6OGVfrQ6zwrj0SUCmjUCoQeq3mT5mfLh8cf9/WWii0qmdC4bRvuWGK1jJyX3GnOUh5yDNmRPCed1ilxntQN97NazzuPP1qsL9uGxMFVTuahZiVS0V71XgajUdDhpynInj3+N2FcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbtJCDswZaLqbAdnYBGQUijanMXQ+vHGX1bm7a/fcKk=;
 b=TnfCCG87QcN9U6Lq7L+p1x23OWdoSXpvJaGu3An+eRkLgFSsZ/+E9rfqkpxYxsTdsXG/hm7UnKeKlzPuqIkMJaOyTs4zghX5yrNY6d/RYW+sRtYfie2z7nvCTmEBeVqZUjOJJvsmJME/mrDKExUTTXGHJeyy39cCX3ezzRkhexN1y9vIDeyZhZ3N2/DiM1RBlAvF/jOZapggp3PDWALuTvoWqWlK4DIl/mobxkKOx8O3cgr07ccp3nXuXTS+1CAt7ltiTdfMbB7E2hn8gAQcNuWkkvrdfgviAWMfoie+186QKePboB3hzUpc7AFWpw3K4FJ2vqvjlkf0C0vWBJo3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:27:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:27:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>, Anirudh Venkataramanan
 <anirudh.venkataramanan@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Preethi Banala <preethi.banala@intel.com>, Kiran Patil
 <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
 complete
Thread-Topic: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
 complete
Thread-Index: AQHdUm9P8m4mm1Cw1ES9VCZNMLz1zLbuw08w
Date: Mon, 5 Oct 2026 10:27:21 +0000
Message-ID: <IA3PR11MB898634CAA7D482FD59CA546DE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-9-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-9-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: b93a6de0-914f-44a3-fe3b-08df22cb3d44
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: RGKuNuIo1G91riGf2a1LsplSHI9Tr6XJ8j/P+9GFzezfnCHVpYpGZB5DAip1u/XmCFTGM0SpjmF1X4HYsDby/Tp0zGdtvcbdbnJuJmPH7g9/0ujS9aaieScgwoDoQBtbpbM90ghgxajjbngbBbKHtxgAJC7qi0PzQcJ3XN0z6U12BcACAGVsoj591dU83ad3UZYlHgDmOCu41bUAqbdYqQXoI/YAIWb6JarbWRBm2t2u3GPvC3gaZZBEkcnXSWI9sYxjdL/Fyi1X1Ys3EaoNheSqNMb30aBXc5HKlRbGSmOodbopl4HnalITAfM2yqDUDEMj+K23zM5oCMsW9Ihmj6RvlYjU7Sv0Gb5K5p8OUbkPw6iYE5HMRoIySkRmbAIYxJgH38iwio3icWN2CiGW/ym2hBlgp+T3D9NLf5g4TZmXE71uiqzLNvtWPngid7mAAQ7Qzgs9CYQLUhek82E9v+wU/rEf1CVkt70ZAtsCEgZ/6CqAHLSsSpq8bMhqMT0GkbmKJtUMi+1enDcbVoOhcx7iMtizRItwrswjaD5hahld4rLji7hbh0laEK3QJO2HFGtbUSTVrQHXc4XQb4JpUXHCIE1TtbFElijOGVk+lWn/ECEv/uDOXqu1j7b3MDem7JIz6ikpxj6Fummo0mdh9vppiusUvl1erWw0yS39PtHQ0n3IzimUv32W+ymyBBUTtCyV+dB68IXr6bWZ7KOy0rfWfZyeUrQz7jfeIAq1SkQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ldh9dBGLPEsdKwGtCFKJsSufo2gyY8Gqrrk6HZVu/3MoWY9qLWFsAHph6WxG?=
 =?us-ascii?Q?IEqSM9q/s3XCUOsrZvPeYi7IpT1U4nc3SEVr6laugVuFC/ziz3B9cpx4Gqs/?=
 =?us-ascii?Q?kk27/vY+y8vEUyXxXyK02WmuQw2+KckvbH/vYOxaJnbc6VAmDZSzOqOrVJGB?=
 =?us-ascii?Q?V4K4U0QrDZyOLwuedx1mv+6/7SyCZN7kXZP4EaeJnBOe8tRX0+yjgNtOeJvX?=
 =?us-ascii?Q?jqMAj1W5mZ8ue+kOvKQMnYvD1rVFJtjjnvsqEFjvRMia1HQXU9uQ50+qW2GM?=
 =?us-ascii?Q?7bXI0tInW1BEoWTSTxZD+4HgTE7mtm/PRnt5hbMIsYsktdg08JSUErZpgPoO?=
 =?us-ascii?Q?m5Rjqoxp5zhf6cHpS2pBbUS2Tf02BxDzp8spvw8/3z0tvTKR0H9PDFJDcOcE?=
 =?us-ascii?Q?MztrfLozDWVRrY3DSbuMe/8CWlMY+xJuWlCGb2PWKHtdfUmTG2v8LcOna1JQ?=
 =?us-ascii?Q?afryNnNGoei/iLo4mJGmKfeT78aQGkXKKaTlvT5Ig/LdLPWS5HlZXrbHlGDs?=
 =?us-ascii?Q?s2qLyZADmsxwiJEC/NCj9U/LgH7rrzvDaqVA0kFzVh8lmg5lCwchrfXz2YoH?=
 =?us-ascii?Q?0uRnqrFFP7S82aumnljxO2zSKgC+Rbac4grmaRkVW2LREyGR+dyFEwk1/amJ?=
 =?us-ascii?Q?8QCSbH73BE2si6rMLqkEgZ6OuOKWjCJKaOD1+mkgHllEOU6t58XmOIoVpM2j?=
 =?us-ascii?Q?yd1dZ498HjnFKEvIX2LdGD7pI0x6WCJ8TjOd8qWB7BeDrDuS6RvnSfOaHIUh?=
 =?us-ascii?Q?iGq1P6ENTyyHdXec63mNFukM451Z2XfvLNQgQe9kx38J3k4d2mFOJQzHl1kP?=
 =?us-ascii?Q?g4URxUHFKZijoJO3Kq8KqLCGrEg9gT9PgqN8p3vWOXscBxBy3GYA0td7FrcB?=
 =?us-ascii?Q?iP3QuMj4KwcUBnxveoOdqIjDOpy1uao0BHKl+N3lJV32jwlA7yya2llSxvtS?=
 =?us-ascii?Q?NITJ2KnGWo3xMlA62ejZBYcNFnxyMb1/jEKePRWyT2b029/vYRsHhiNNiM8W?=
 =?us-ascii?Q?sii7Bpsk4f/7/PG6Y/IMrMCfx8hamfgSeVB+d/B0+DdP+CNLqxjeqzDu4cqb?=
 =?us-ascii?Q?JRCKKb9KFbIwQzg3Y54/qJd3SkIu0G5/ZR+OezZ6dt3GeMCXtMr0gApyn7Rk?=
 =?us-ascii?Q?YqBnPcw33ncGsStIMIRQCag3Znbd90PhHXjOE15etEQPOkzwJYH4lduhlNxm?=
 =?us-ascii?Q?HEdHucBszd4Km3uKYoRCCR/+/3EN8SPjashqNA9WlsbTC8XfouMGaOF/ruUx?=
 =?us-ascii?Q?nMZlvZnOU0BEkeGDCa5Y3hUaBQ8ZapV1Fv/cEj2rKEcOq/vj81IO4l8UFnGA?=
 =?us-ascii?Q?F3Pq76MVpcQvyRkEMiHWT/BPgnwfMDwmL3PDtwPu9+HCT3y/5jiP/wo9swhO?=
 =?us-ascii?Q?zO77LxdltMbwGssECyGMh/4fWu+BuJGBF6gH48vrRMvqCqcpJjgg39kzH9mx?=
 =?us-ascii?Q?9xUwkR9YcCabWJ0pRKxwS02iNyPssqaCtJkFrxb87hDqiDdv/js605wkYDVY?=
 =?us-ascii?Q?+IE62lq/7QWAxF0yFKSNoRpXqJg9sMDj2X54LfGZ3bkHuwLU6A54gPFov5Pe?=
 =?us-ascii?Q?Q0FjDAp/KwmdLITwrf2n9e1LxXBeZ4qDw8QdHmN9TiGbTGGR2KaC8fAojMjJ?=
 =?us-ascii?Q?7DIYC2TFMiYTIAj68J0YtfC70By7A9zNmY83SoK9xMAH4Zynjx5wc7l36cru?=
 =?us-ascii?Q?S1bjbPvgsZ7OxYxgD6Rwd1nqeqfMVjjiaP2peoaoTVakI5p9liPwvovF2fYT?=
 =?us-ascii?Q?Rw/nQakZLXJQcuCrfkVYNy4FRK3Z7cM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4Cnk+B3Uy2tziYZJmULXARRJEPxww0gpOHu/IS1lGMzEXtvXOjwzV2QlWNmg57d9fjPo+qhrZO72VhWh3439lZbxN1B3UaZbYgLZFCqZzWrCG+q8UcDWkX8mpf0pTCMejIj3DeYKJp2Km9lJ9oKTRa43QGKV5ocUcxIE5gEm4HE+G9UhqiIl0fejpOoQVO1yKuihPbopCovV8DjBnpDtwn3Z0mMvXneiN2g5cyedc/dsiBukNXoWtCvb4T9g0uOpr5CMx+xaXi+it2B8WvQ+/t6FXmqfHjFZsvL4YUifxTOaZr3cM4zMkpo43b0Yl+YseRVUYtCctZTxqVYD4eUkVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a6de0-914f-44a3-fe3b-08df22cb3d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:27:21.1142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQv6y1/MIp7oC0SFhVaRxUDAAacYy/8NgzQCeACT8rxNt8q4pY+OxLI1GDofk/MJN/35adfsg9yvPRRWPNCj2ZdmU8k2uIjdHEhCXKmUWfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com
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



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 2, 2026 3:08 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman
> <henry.w.tieman@intel.com>; Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Preethi Banala <preethi.banala@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Dan Nowlin
> <dan.nowlin@intel.com>; Stephen Hemminger
> <stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
> complete
>=20
> ice_pf_reset() polls PFGEN_CTRL.PFSWR for up to
> ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT iterations, but
> the timeout check after the loop still compares the counter with
> ICE_PF_RESET_WAIT_COUNT alone. When the reset never completes the loop
> ends with cnt =3D=3D 5300, the check does not match and the function
> returns success with PFSWR still set. A reset that completes just when
> the counter reaches ICE_PF_RESET_WAIT_COUNT is reported as a failure
> instead.
>=20
> Check the PFSWR bit read last instead of the loop counter, the same
> way i40e_pf_reset() does after its poll loop.
>=20
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e610..0ffd6b5b81239e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
>  		mdelay(1);
>  	}
>=20
> -	if (cnt =3D=3D ICE_PF_RESET_WAIT_COUNT) {
> +	if (reg & PFGEN_CTRL_PFSWR_M) {
>  		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to
> complete.\n");
>  		return -EIO;
>  	}
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

