Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9ECC98321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC32B60D77;
	Fri, 25 Sep 2026 14:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4xzLKG0zmIv; Fri, 25 Sep 2026 14:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B7B9660C2E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790346762;
	b=Xgy9OSPfIUbVaUL/ClR09wdL3K7wQu2mLvpYErlscA30NGP1UhVNoZv+Z1LtZUBFzZt3
	 /rlo+rLJvpV9P24Ttr4BoAWRfDwS52HLXpmjnMiNTYK2o9/FbLsyCldG6SfxViJLpnZhT
	 K5k1BHZ7kaYDOlYq3barOVfqoW7PNPAd6Rv3Gs8q7rH1VAjB9WuGY3VzvGeDa0U/1Dw68
	 AdVdPkAnXtd8J/8EBgf3nAadxsYcOtmvgnBM/GLmz8YV+0OAEJ1uijL1klk/PsMA0vue1
	 uL7O7rGM4JM8DlHeCC771HVEWbSQO0bhxqU0vaszf4OLrS9iKpGVFHvj0toz7sQ5ycA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346762;
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
	bh=5+h/GUUXxyYca3gpFGA6UAifLOHz9yl1tOKfNeTLGPk=;
	b=ehEZHNmb6vk3VqjG3sBJip4Wht0gYnfRR8czkoGoEZq9Sb7F3ITS2WoZH1nDtXVyzQFt
	 0tx06Ku21Pp7SYrksuk2fTHuIWUswrF+1lrSUjAZi27Uq97dHYRdSPDYsL+uwzXGmkuaQ
	 v3PsshGdThEdbSiyZdBeY6Rhcmd5aOoDcTSXItd8Lwq9PAVia5N4H9qylIEVLsySFvFks
	 j3f1t9XG7LcANXIfUx49/6Z+G0X+I+uh67T9aHP1EbZ+azdj4JjjCe+a0ufKdH0sNkMe5
	 /aaxr26GUHdRqsxxQ53U6zXHaDnay1LV4OmAIG9jUReKwucBl2h6G1IB8YAEOTco9Lg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TaWVyqUB;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790346762;
	bh=5+h/GUUXxyYca3gpFGA6UAifLOHz9yl1tOKfNeTLGPk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i8Kb59LMlr0PyZ1RrjCmqZ9xsvgZNxI6JM64BUPQV3ujwxOcoSz8JfCa0JOj/i6Bw
	 PiJtncyrNeeaVLBZbFzPCbaDUgeJgKwT/4bBwRuhYmax4j1cFSFftFnf2HIdWDXzHh
	 ujrY9OKU98Xd/gRdZqqrIKewqjVHu9KMSFfxj8eqef4b3PvMZ4+ff9PcS/3q1LN9uo
	 volv2dfS2Op/5SNYXe6rtQPDL4PSzwCBtRRApyrTdepE1Y01I60aMAJPwK7oq88U3q
	 0Om6XAMiz+940yub+SN7eqy3RiRMgJ60H+XX9ZFDiN2/QObeRGvC1FJvBwZHQgmYUZ
	 +fAS/1StzQIHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7B9660C2E;
	Fri, 25 Sep 2026 14:32:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E7C2F35A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD1636069B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpLoZtBPxMBj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9DC6E6067A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346760;
 b=f58n6BY9es5lLcwF6JLW6JZK07CS33ok1TAl5okp7ruHJHJZpo9ugUr4ho4kNN7gbXAG
 p5p0GEgDmdZeWciHEWKdF8JtzC+NwfNadx+3sJDxwKTwvNyQcdR2I0/Gv78RJqbfdLrpO
 Q/a5eOfrXxEYdX55goc3D3uqm2N3KnUYvc8OWko+gbXgNMC6Rm4bm9Jg+ILxvodJq3SDq
 Jp2UFfPXIHQbvuCeUnZWQLQLt53YGMjQaYJV8Z+SsTMohNJ9BJ2HTD+Yo0I8dMxUc8xSI
 YahWJvEk9BfpNzMSqjaLhLbXrGHjnzmpI5hiPsEdO1ahJ7QUMWYB8TSr0sKhRRd55zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790346760;
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
 bh=5+h/GUUXxyYca3gpFGA6UAifLOHz9yl1tOKfNeTLGPk=;
 b=Ac/zmSQx+vFnkA16MQlxiEdRZwLKoQyFbc6q2qVhCaE7SvCdQbMEg+/91o17Px4qH4YP
 DMleuUL6FMLSefiUN3FskAzJeTmQzx1T+SHQxvtBhXhrjYW8mIxhkqkZTcs+P8HGWF1d7
 7NXovctcKufetsVWZb3n4VMGDvJ2IRdpudNIoIsLVP3zBAkQTUHJh0bE1QpxX/sLI62sf
 7xLHVNkGa4CNGLTKGJ2CYgnb/UJo00RH+on8n01/J6x2HVIGXFQ84W2J3LVIWC4peHWnk
 uHxOShg2ccA7PfkHqUztXTMIgrNxZ92fch0uyP8NLE6YaHsZSt5j2GnsyDCXcEloQwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=TaWVyqUB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TaWVyqUB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DC6E6067A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346760; x=1821882760;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=veUajdcOYmrfebk1TkLFN4Tj7TPKQCphPzDgGPy9OHw=;
 b=TaWVyqUBApI0Ii+dyk9HAY2ueFIU/Fs1dZYBHmslah8kW9p4V1+UskGj
 j/ZPHlqdABL+M/MKWCUWekf4X06xEPrnz1ipW8UOgCZrdoGAiKDYCKPZ3
 GnV+b28g5jz8hB9T7rEzSJpK+lTjrJ/nWL41F5jNHWdxUg4RMxPHK4oEV
 4nnGYJku3SuOpdLIlyOfuiWKecmOaXeaOjgM/huXlF9SI6X0p5pRhyraX
 ImsWPkf4Ze6TTjYcT9mzHrYUunLuWpLi1x7B9EhPF6oaykiTqtdS6ezmc
 Zez0e3ZjNHKoO0lv/anxqg2kRM4n0LU916ccA3dGIfmHR8F46ppjzX/fZ A==;
X-CSE-ConnectionGUID: DA1um4VGQuiyiwv/OuX32Q==
X-CSE-MsgGUID: L4LhFDVyTzeWTdKc6OT+WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93850695"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="93850695"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:32:39 -0700
X-CSE-ConnectionGUID: VqxwHyaVQue+34MghSzKlg==
X-CSE-MsgGUID: +4KBTqBzQZS4Kw6m8eFJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="300624269"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:32:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:32:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:32:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf3Yuv088BeSBk4TqlXp+aiYQ5HMTB6TONYaKlZMPpHc5peBeShHU9Ja9hA5uWV9BwxBT8bOPqRSo8w/17pxRLuFnMqTjALSaYye/RbG4hciB/cVyy9gF9oxzQeu2zPSP+Txhq+97PUAT3uupeSC1XeQ/Jk/+LpWWAklRNwwlqeUCsqwI7bnshoDFkhhsR/Zw+Nrck/+k+5gJ2TBoL4gKRhTfbv43vBL7Q/N9TXPCfw7ka83rN0ZGseoXNqrL6ZHz/0ZK8KhWS0D7IjE40vbqT7Nr75Okl4WxiujQQebZE+ISRGsYRCak6YH3RfoHUpMq8T4aKGNjWEfByQN9UWtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+h/GUUXxyYca3gpFGA6UAifLOHz9yl1tOKfNeTLGPk=;
 b=pAaSqeko8lXEfWSu2uW4+Kpdl587dvvOtUb//8Qea+i5T/bVXmYVSdVIt2jor5pGyaAJS8TbpBDmE+SWudhGf++6ZtXSDMJUj/etp3pMt4fwrOR8AudKUXWZxypqL1QkvgTWE/1vBbmxoTQOUNaXuI6pVmdW6xycpzJBwe8C83uNZuMzXz1KyalxULuVDzZG1UNXbXmzhxX2kv8hN7PmAtAn4Ymgcb/x2xCGu+WEUWhBf7kdEY4HbqCS56JPZON0gh6MOGUlgVFI9f0m1rxgdCIs9icg4m/+uLceIwKyfvgpC8yUL6JwSxzuwBaQAMeI/R7JpWPbcvCX1gPjtLqOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Fri, 25 Sep
 2026 14:32:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:32:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
 <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [PATCH net v5 6/6] ice: size ring stats arrays from the final
 queue count
Thread-Topic: [PATCH net v5 6/6] ice: size ring stats arrays from the final
 queue count
Thread-Index: AQHdTPGVacWaR7a9tk+JOZCR67kqcrbfW3QA
Date: Fri, 25 Sep 2026 14:32:28 +0000
Message-ID: <IA3PR11MB8986EC41B2C45242C83098BCE5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-7-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-7-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6238:EE_
x-ms-office365-filtering-correlation-id: 3f6294cc-2749-4159-dc62-08df1b11d38d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|56012099006|11063799006|10067099003|5023799004|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: y9VHydXf5GZ3dPGddbiJmWg1rNeP31eQf+QJsi2rHTF3iyW5Z9u/qf+p4kp7yyvkcOl2Ipi5xxZSpjeT8RHR3/CwqakpdX6QYObWAPpp33R3W1mPYHYSXiVMBbvUljHpufJKI5+tIFp1cCo+NTO+kaMBe/9whk8vzU3D5RvSM3BKOZV62pgYvDizBf5vXJub++Udh7AVa32bcin14Xslu1pBfNnLUqrLV2bxw1Ovj3H5LWzyuY8pDmJUMtao7Jnl1/nDg2beHcoGaFUn2Mudf5xzHS+HoP536OkKZtXEtX0DFJXpBmLwZr8YT077pVDwFrfcoInSLPtlirvx/P39BR3uERnUSp0XPiTTIfmEltvtoitN5BGEOy5yZAV5ds6NQl0IRXQOw7AHqoBtP5X71gw/vUe6ul5Ogw6cqAXVFz97lHA22r7jSl/rLeeWK0fob+Ozs6P3H3JnZuWO6//zk2YdKNaEBfDgntSmAQyMBfLCl1IFjJXEGEK6SGgC3ASIVXS30/tFQFazRBhixpAK4Po9CG7faFMBEbE5pWNdwoFnbkVP/w5D/VE9rSGilN293ZW+I8UssuMx17fmoi67iKTKPqdVHw4qFqVxUzl7Y93ULw9O9MtbLjZtq11vSD6wK6hIrLsY5K5mYxCKeR444l6YdubM2m4Ym4xqyJBT0Joa+WDB8//TWobeKjViC8kcP2Dy1Njn1C5JNjfqL0TxlwU6jT1ZkBjPF1bkh/7tF+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ia2S4tuWSlyUbW0BkVTeWYEppvtWshPgZcm4lB7ukHq4urASoBYp8nedM2EM?=
 =?us-ascii?Q?Nc8feASboC0cVUEQ592OLdiyeLOBUsaQeIpLSnHdaadi06iwPRJQwpkbPk1/?=
 =?us-ascii?Q?AomA6uccJW7dbgic3f51HcSfBa1NNci26pDIUyP90cKssdzDwjHnxk9bJUyw?=
 =?us-ascii?Q?wpWq6N0eD8RoOAfPKgJWWGBSA/pBc+KX1M2Jpsv1u+f3GovJUD9yrjD8vARf?=
 =?us-ascii?Q?hL2X9/I3TJhFs2Q6/swIWuGKwV4axRAvBBWQbEHxdM4a9WnweZpxe+am4dTA?=
 =?us-ascii?Q?yieHKEfcRUadrZpLqMyqhrYEkaTfXPrK5VE8VXekkwqVHjAciL3obfC+c7gV?=
 =?us-ascii?Q?JKC92KHoyqrYumkFjlkcQ+grXPpJw8MQNsHwzZ2dWyU1qqDS8hcyZ4L1oHyC?=
 =?us-ascii?Q?MG2x8hkgBVgNS98HkkAgw/ZLEHMnn4WAduW1Xsj+YfaoXGnZu3TlVHOJILyb?=
 =?us-ascii?Q?SWyUMm1jgmwvyGZLtAMUsbzQQcet5rg6Y7DRqntbUqoaA31c0TSpIt9oRNuM?=
 =?us-ascii?Q?RiuP+bNj1ZoYXSM0/k/h3zeoicLuRBwjT3hPL+lMfnO6GAJ1i8/RM46Ca9ui?=
 =?us-ascii?Q?treKZmR3ks/1T2XhOxq8w3AVK2eSyqVpadYgjEoPBwTgtpyoyrvyrL6ka1We?=
 =?us-ascii?Q?tupiFglmy6zvFljChEX3YyuOHgvQd955nFZs/VXeQec1pdGWCeDhS2np1Z0H?=
 =?us-ascii?Q?a6iGnrv+o05bBPsGMVXju9NnYhWkMYOUoDqJghkPUSEzVLAe8Dz2PdfZJb5X?=
 =?us-ascii?Q?pnpk7zJA2B5vUbVkoGEwDaxWYZwHuSIx9WWQVevzRbQTmiz8SbiwpiPQqcNH?=
 =?us-ascii?Q?LIEWCxd2r8A6m2vFCEjT8bciuSbbhffFmebTyO1yeKGHCSrwhdbDrL3+CZFg?=
 =?us-ascii?Q?PEPF09DNJDJcE2LTw03ulh5adYJOUXERUEttjTZ0d5BdK5hQZCUzhpCenv56?=
 =?us-ascii?Q?dLtzVLk28foTvFmiaUxDw0jvQ2eOHIXlwPc84UKokGapVuEDrVRCMZc42N1f?=
 =?us-ascii?Q?Oque5jlYVg8lt+Pf0xsRlG5UqNXSPRbqtplMIF8Rtdn6IYwvxYUb2DdNFySD?=
 =?us-ascii?Q?UoXIitvqLDe/kfwv2y6xDB2pVJay6cUWPSTeG5kEt75S6fQtMniSYaXC0rBl?=
 =?us-ascii?Q?R+GsIkIJngd11otPBJZ04zpexp02DxyqhEfJeg7YLRS4OXUGq4MNk/Tnx8b4?=
 =?us-ascii?Q?IOOprzC88+YX8r/CNttCt2TiznCQ5zSj63KCVRo4/BSgkb2+OA+99/3fBTC6?=
 =?us-ascii?Q?O5iUOzH4JwJvujXxU1JfIQppSpwjYBgJpqdAsSuyhFvhDnKEqoQ3yppMjj0+?=
 =?us-ascii?Q?WMLlhKj27KA4nU7kyoOsyDAfSm5f94pLrmNvCu1bcJWPjdlqlisvzXf8vIH2?=
 =?us-ascii?Q?UbIEbnR4iFzz3cmZqxAslKF1maSVEDx/LKYt9pzAnhEnZ4Z7UJPTzw4eYAPi?=
 =?us-ascii?Q?GMjeF36TcnUk3mpg7Nj2ePRFlqsj8Pq4kVg1KrWgcQfmn2pk1pdoUVuLGSlO?=
 =?us-ascii?Q?ZNGe+Lc/bB9l4LcE/rhK4g56JyMbCJP2t8IfD/ry2hYAGVQmZZlVcw2t4XZX?=
 =?us-ascii?Q?mHzD7eqL4zQQK6S63jGT0hMpxgbjM3FHOMZzKEd5XezTqL00Q2r1xcWr9qFx?=
 =?us-ascii?Q?OtgiXWlWwVpIAtXuHnqbAx2q0tjkxZ3rzlnf9mRqFP4tGdOGa11qI54/Zuvi?=
 =?us-ascii?Q?0e0fow4kCp/hFW1t0Pn1UvVuFXtRz8GHvO8ZQNP1t8HtZaDA+OEBOgR5bV/j?=
 =?us-ascii?Q?7BkdZHkX+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qSqL9lP9A3QmEFVdv2KsDS6acDzhwEPx5uDqb5HWr+DBb4sGq5uroC23pb2XWusESeNPrAFd/gut+DbbJWSdhc/m3gmEyShJbumm6mleFh/SbGqs3hEcrZNpWLQJVPmO/EeWtyaH/ti2u1p2K77IBwQQvO3c0WDheMPGNG+z+l2rErRlD+g0eNv3qqczm05qnGi03uaKiDH2T5E1PRHBT38LdEN3XDSr70tOu4DNi/nJrwW9TZqFBPHT7YjjujhveUlNwf9Efe5GicBDIyrQvdHXRSaCYjZ0VowycEJbEzrr/m1kSyr8KBQ6yXMwbWVqeb/NE1qlcxn7aolXsVk0eg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6294cc-2749-4159-dc62-08df1b11d38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:32:28.7184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVkVzcXz0Gy859sx4feBuqRltS8JkCzr47nZh/JJq49a2QUcqaCgUN1godjGszmUStE0njpkZFCcrwUj7tLxQ5wqjHVOy22s5HF6HD5cAT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
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
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, September 25, 2026 3:16 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net v5 6/6] ice: size ring stats arrays from the final
> queue count
>=20
> The ring stats arrays were sized in one place and indexed in another,
> with nothing reconciling the two. ice_vsi_alloc_stat_arrays() gave up
> as soon as a container existed:
>=20
> 	if (pf->vsi_stats[vsi->idx])
> 	/* realloc will happen in rebuild path */
> 		return 0;
>=20
> while ice_vsi_alloc_ring_stats() walks the arrays with
> ice_for_each_alloc_txq() / ice_for_each_alloc_rxq(), that is, up to
> vsi->alloc_txq / vsi->alloc_rxq. Whenever the arrays are shorter than
> the count ice_vsi_set_num_qs() ends up computing, that loop reads and
> stores past the end of the kmalloc'ed pointer arrays.
>=20
> Deferring to "the rebuild path" does not hold. It cannot get the size
> right, and some paths never call it at all.
>=20
> ice_devlink_reinit_down() is one of the latter. It calls
> ice_vsi_decfg() directly, which does not free pf->vsi_stats[], and
> nothing on the way down releases the main VSI's entry either:
> ice_dealloc_vsis() runs only from ice_init()/ice_deinit(), and the
> single entry that ice_unload() does drop is the control VSI's, via
> ice_deinit_fdir(). The main VSI's arrays therefore survive the reload,
> while ice_devlink_reinit_up() runs
> ice_vsi_cfg() and recomputes the count from
> netif_get_num_default_rss_queues(), which follows cpu_online_mask.
> Sizing the arrays with most CPUs offline and then onlining them is
> enough, no VF involved:
>=20
>   for c in /sys/devices/system/cpu/cpu[0-9]*/online; do echo 0 > $c;
> done
>   echo 0000:18:00.0 > /sys/bus/pci/drivers/ice/unbind
>   echo 0000:18:00.0 > /sys/bus/pci/drivers/ice/bind
>   for c in /sys/devices/system/cpu/cpu[0-9]*/online; do echo 1 > $c;
> done
>   devlink dev reload pci/0000:18:00.0 action driver_reinit
>=20
> The unbind/bind is what makes the arrays actually be allocated at the
> small size; a reload alone only reuses them.
>=20
> The read then runs off the end of tx_ring_stats[] and picks up
> whatever follows it in kmalloc-32. Here that was a string,
> 0x74756f5f6c697475 spelling "util_out" in memory order. It is stored
> into ring->ring_stats and faults on the first dereference, in
> ice_setup_tx_ring(), call trace:
>=20
>  RIP: 0010:ice_setup_tx_ring+0x8d/0xe0 [ice]
>   ice_vsi_setup_tx_rings+0x2a/0x80 [ice]
>   ice_vsi_open+0x28/0x170 [ice]
>   ice_open_internal+0xc9/0x160 [ice]
>   __dev_open+0x138/0x2b0
>   __dev_change_flags+0x1d5/0x250
>   netif_change_flags+0x21/0x60
>   do_setlink.constprop.0+0x336/0xcf0
>   rtnl_newlink+0x4a4/0x9b0
>=20
> Even where the rebuild path does run, it sizes the arrays before
> ice_vsi_decfg() returns the queues to the PF pool, and for an
> ICE_VSI_PF VSI with no explicit request it derives the count from that
> shared pool. Nothing serializes it against the recount in
> ice_vsi_set_num_qs(), so a concurrent release, say "echo 0 >
> sriov_numvfs", leaves the final count larger than the arrays that were
> already installed.
>=20
> ice_vsi_alloc_stat_arrays() runs from ice_vsi_cfg_def(), right after
> ice_vsi_alloc_def() called ice_vsi_set_num_qs(), so it is the first
> place where the queue count is final. Make it the only authority: keep
> the existing arrays when they are already long enough, and otherwise
> grow them with ice_vsi_install_stat_arrays(), which carries the
> surviving entries over. The check only forces a grow: while both
> arrays are long enough they are kept, an oversized one being merely
> wasteful.
> Once either is too short the whole container is replaced, and then the
> other one follows the final count too, shrinking if that is what it
> takes.
>=20
> Michal Schmidt hit the same corruption through the VF path, where a
> guest raises its queue count with VIRTCHNL_OP_REQUEST_QUEUES and the
> following VF reset reconfigures the VSI with the larger count while
> the old, shorter arrays are still installed:
>=20
>  BUG: KASAN: slab-out-of-bounds in
> ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>  Workqueue: ice ice_service_task [ice]
>  Call Trace:
>   kasan_report+0xd7/0x120
>   ice_vsi_alloc_ring_stats+0x385/0x4a0 [ice]
>   ice_vsi_cfg_def+0x12e2/0x2060 [ice]
>   ice_vsi_cfg+0xb5/0x3c0 [ice]
>   ice_reset_vf+0x858/0xf80 [ice]
>   ice_vc_request_qs_msg+0x1da/0x290 [ice]
>   ice_vc_process_vf_msg+0xb15/0x1430 [ice]
>   __ice_clean_ctrlq+0x70d/0x9d0 [ice]
>   ice_service_task+0x840/0xf20 [ice]
>   process_one_work+0x690/0xff0
>   worker_thread+0x4d9/0xd20
>   kthread+0x322/0x410
>   ret_from_fork+0x332/0x660
>   ret_from_fork_asm+0x1a/0x30
>=20
>  Allocated by task 2439:
>   kasan_save_stack+0x1c/0x40
>   kasan_save_track+0x10/0x30
>   __kasan_kmalloc+0x96/0xb0
>   __kmalloc_noprof+0x1d8/0x580
>   ice_vsi_cfg_def+0x115c/0x2060 [ice]
>   ice_vsi_cfg+0xb5/0x3c0 [ice]
>   ice_vsi_setup+0x180/0x320 [ice]
>   ice_start_vfs+0x1f3/0x590 [ice]
>   ice_ena_vfs+0x66d/0x798 [ice]
>   ice_sriov_configure.cold+0xe4/0x121 [ice]
>   sriov_numvfs_store+0x279/0x480
>   kernfs_fop_write_iter+0x331/0x4f0
>   vfs_write+0x4c4/0xe40
>   ksys_write+0x10c/0x240
>   do_syscall_64+0xd9/0x650
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
>  The buggy address belongs to the object at ffff88810affea40
>                 which belongs to the cache kmalloc-32 of size 32  The
> buggy address is located 0 bytes to the right of
>                 allocated 32-byte region [ffff88810affea40,
> ffff88810affea60)
>=20
> Fixes: 288ecf491b16 ("ice: Accumulate ring statistics over reset")
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v5:
>  - new patch, replaces the VF-only fix with one that covers every path
>    reaching ice_vsi_alloc_ring_stats() (Clashiko)
>  - the reproducers both postdate the cited tag: devlink reinit arrived
>    with 31c8db2c4fa7 ("ice: implement devlink reinit action"), the VF
>    path with 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
>    ice_vf_reconfig_vsi()"). The sizing itself went wrong in the cited
>    commit, hence the older tag (Clashiko)
>  - drop the follow-up VF resize patch, it could abort a VFLR after the
>    hardware had already reset the VF (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 448d3c7780ad..c393d913d037 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -634,27 +634,29 @@ static int ice_vsi_install_stat_arrays(struct
> ice_vsi *vsi, u16 txq, u16 rxq)
>  /**
>   * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
>   * @vsi: VSI pointer
> + *
> + * Runs after ice_vsi_set_num_qs(), so this is the first point where
> + the queue
> + * count is final. Grow the arrays if an earlier sizing guessed too
> low.
> + *
> + * Return: 0 on success, negative error code otherwise.
>   */
>  static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)  {
> -	struct ice_vsi_stats *vsi_stat;
> +	struct ice_vsi_stats *old_stat;
>  	struct ice_pf *pf =3D vsi->back;
>=20
>  	if (vsi->type =3D=3D ICE_VSI_CHNL)
>  		return 0;
>  	if (!pf->vsi_stats)
>  		return -ENOENT;
>=20
> -	if (pf->vsi_stats[vsi->idx])
> -	/* realloc will happen in rebuild path */
> +	old_stat =3D pf->vsi_stats[vsi->idx];
> +	if (old_stat && old_stat->tx_ring_stats_len >=3D vsi->alloc_txq
> &&
> +	    old_stat->rx_ring_stats_len >=3D vsi->alloc_rxq)
>  		return 0;
>=20
> -	vsi_stat =3D ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi-
> >alloc_rxq);
> -	if (!vsi_stat)
> -		return -ENOMEM;
> -
> -	pf->vsi_stats[vsi->idx] =3D vsi_stat;
> -	return 0;
> +	return ice_vsi_install_stat_arrays(vsi, vsi->alloc_txq,
> +					   vsi->alloc_rxq);
>  }
>=20
>  /**
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
