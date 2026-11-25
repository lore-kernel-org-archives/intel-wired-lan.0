Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D4606A33F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jbnps4wE;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ITFiVXYB;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FHhC0rHV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B06C4066D;
	Wed, 25 Nov 2026 15:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9LTY3TBHEbS; Wed, 25 Nov 2026 15:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24F3340588
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795621617;
	b=Vmb7ZFUA2AbSvovRKSSjrsU5pAcsFr/Dlu4wIzVfesLml6lp4n5EG0wG+dikaPbwTupA
	 IIQQhK0m/iLakjL6l3x2Mj0nAi5dfMcLdpX3wBLhwX36MGCEzN9mXj0ggmCYSqvkMk8Hp
	 QqMOu5xDRrrCeoMLTg5tfXct4WCZxhgj9Bmn1o5jT+Bqft3jwLW2um5ujYjkXC89i3Dn+
	 jsR309LL02TEnDm3rUJ1E3SahTI+ToFL+cZttdrlpZxpPoIHWX6GUBqtm8qwzeat3tm/Z
	 nVh9uiGBz6sEiEqJIJwW6r8MuCl3djU+Ad1hei5ipIEAdVfmK8wREcTVICKcvZtHuLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795621617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=8vCYfMWlvFTNAUb+SZ2vWdULVVn+u24NW7w05lV9hxk=;
	b=qikJp8sfkzr2owuOCV+3IdwwQ2xcp23+FOAGHDsxzdEcinO0BF12clTQZG9Rye3C02we
	 i8nwp0g4bp7kyU8WKsekNtvwAcOttsTYcJp7ECq6QYZzN3H3SVlJPkH8C2XhATNSQiOgQ
	 hGDdq+A/5gaw1ALMv2mV8frrwGFuEz3/64+u2JwXdFVYAtvWTlf8BTItC3YE5uE5YWoYa
	 NzjfGxlBsWYC5i540cWeNZzppMfJf2gp+hN4uA2A+rZh+VW65yCMCLBlkj+QcTswEq45K
	 zjvrjb1kSB+50M9Ou+32XrEvNZwHJpQv6Ar7PrWMhDQ2xx1A9d1BKoQjTXsTT+MN+WA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795621617;
	bh=8vCYfMWlvFTNAUb+SZ2vWdULVVn+u24NW7w05lV9hxk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jbnps4wEMNB83omiDOVey2G1WnljZXiQ4PdlNzZdmerdegQAKcArUg2rSQDq4wsvw
	 hUssfzU3COWergcHscYL5oK6b+E0HhkATaHw35IVeS7mDDK/xkuM7Px+Qtms3fDtaF
	 NinyPklnTJ2feTGUy7eZ94c9Sv0TkTtmmMkmI8H3/7CaobyUSrFsYOw5fZaRHoT/tI
	 mTvJol0IJ3E49BPTILjfOaxARG0lWrt/5LAtaTpvWT0tqB/8Z6WDP9tyh230ym6ESI
	 qHcXDbT08i0o7CauXiAoSpQB8ISSlL4gnItn4IPkaIjkOcccC7qmBtZ3f0B12VdMdO
	 AXqOWSj2YE6Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24F3340588;
	Wed, 25 Nov 2026 15:46:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB6F532D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1F14607BE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XdXNw-OqcyvN for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 15:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7852605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ITFiVXYB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=FHhC0rHV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7852605ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795621615; x=1827157615;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8vCYfMWlvFTNAUb+SZ2vWdULVVn+u24NW7w05lV9hxk=;
 b=ITFiVXYBqM4DESR4VRMHhJMkmxNbHFaUTzmTUYc234sslJDKJRjGy7WO
 0UHBxRRJ8ZQTnZktKQxaVc5/6auRNj9G/ORQCq4g/CF3BpMjRjVVMtBgV
 CfsKhDO1EY4n8K61juNvKfyLT1K9urU6Rwn85eA486UjIxsAOmicBn615
 rm8m0xcPzgWnenKkpMr/2xVTHonoWRzAOrBNCeLjoA83TZjwkqfxf+RSP
 pIzdukvEF8kyjDkYzxFNRwd0DS2zCPUp9y6KkqUT45XAGCvGrLykJjEX3
 ek5g5lnQdfR1ck+8fNNkfp0bIFR1B4AIpNbZ6vnDuKkM8smtcifojwBOk g==;
X-CSE-ConnectionGUID: c1Fh/GUHT2awBsJV/HKu1A==
X-CSE-MsgGUID: Iy0VJcmEQPayp/MCnRQaaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4517840"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4517840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:46:53 -0800
X-CSE-ConnectionGUID: jpHziW+5Th2INNfVpE1xcQ==
X-CSE-MsgGUID: DR4ARMSOT12EXjZke+ozeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12224385"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:46:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 07:46:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 07:46:51 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 07:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vCYfMWlvFTNAUb+SZ2vWdULVVn+u24NW7w05lV9hxk=;
 b=FHhC0rHV+zshCq4Y0AO4gIiUWf+L6fvBJ/fbHkVW/A50XxuhX3GW4lwmjqdyCSsyFUrq0wuyAh4lU/OgvnzGsExSqZcCkOhrZQP6DRLOJ43jjub5tONVG2D3FEmjUkj3OVoZLYbGbkA9lDAPLVWQ+LQ91ltAGtYNZY+Y4ggNmZ0=
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by SA3PR11MB891970.namprd11.prod.outlook.com (2603:10b6:806:531::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 15:46:45 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:46:45 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Min Li <min.li@microchip.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, "Oros, Petr" <poros@redhat.com>
Subject: RE: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Thread-Topic: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Thread-Index: AQHdcftsjeqnHCNYXUaGas67mVSOY7cxj0QAgAJv8oCAAKvVAIAAtCaAgACZlICAAKevgIAIYlhQ
Date: Wed, 25 Nov 2026 15:46:45 +0000
Message-ID: <MW4PR11MB69844BEEFB89426E23F98B859B432@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
 <20261119133851.3f25074c@kernel.org>
 <bdfa88fe-13bb-4050-b750-962586b1d846@redhat.com>
In-Reply-To: <bdfa88fe-13bb-4050-b750-962586b1d846@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|SA3PR11MB891970:EE_
x-ms-office365-filtering-correlation-id: 34705c59-c3c4-4c14-9c44-08df4b0b4f48
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|261026121527099003|10067099003|22082099003|18002099003|3023799007|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|261022075727099003|56012099006|4143699003|38070700021|11063799006|5023799004;
x-microsoft-antispam-message-info: F8rW6GJQrhEVH2ZA/EYXx1wxQZy5D/EYP9I3jSptrdo8ngGIVLG5+9d3qO4c3HFD+xPvhpsNFxLunkveiy5qqOrrkXbg3JzlGzFf24EGoJQdWB6rlY4WXlAOp3n4KY9V3NyeSNu1uwMI6633NfuyLzzrDCt0bPt1vXOsB0NF5dae99elN2qGcx3efQd+UCKnAmh9XxG0/Mmt1CWsiGADlsofh7bH57SQgZ/YufS2M8e/6eZpRQSvhI8RqfI2VY3tiZedhvrQGQgyOBCq0Z8LrLPitR0mrgU1wv1WnnH5LaLAGik5Zo+ZJkoGMIzzP8+qX0eShV+3RAzsIJt0nPmpUChaFEw6b/UJsbs9sA+IqHlE7sr+qo1OE8FWXF9loxe57f05wJ5Vp+XcHZt7x+zGgutKdWuNWQ5sLPgEQWlNUfu4y8OWDREpQwI+w1JF13XgemmWE+FXNpRwNsfeIliwfn8didjvyU1qT/p7bTe8GYp3GbqXVbpckDg/i4vErAu8YuSfkITzPlToVkSm7yeRNR8+RjEyDByn7tiDXUMfm+anrrJdJCEzre3/etYgWBzDJzyflSz5OP3IUfI/sUO/j/nf3gc1bnl5E22uNkPlBz/rhxwkJ0KT35S2JZbVMMkq4auEOKS1vZhu47uPpZIZda1cYcp0u0Zokbg4zh5/D+ZSSmx9lp6J6ErreDz98JC/TC/1OqaYNMcWHCrHa9OeDENKsJqXhFzIeDGkQrlrla4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(4143699003)(38070700021)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmkrNjIwRmdxMkl6QlZNWStaTmNZdHIzUGxXeW9rcisrWDdiQTlLbU9LWHho?=
 =?utf-8?B?S3lNdkNlVHlkaFo2QjUzQVJZNmwyaVRhQ3FQMm0rMVY1MHZudXIyQnI2WE4y?=
 =?utf-8?B?SFBBTlI3OUJ6YXBnMmhTSXQ3NVUxdTY1YzVBYUt2emdkS2hDMUV3Z1Rwc3Jo?=
 =?utf-8?B?K090T0VHQkJkQWhkdlhXbDU1RFhCWnJXSHU0VS9PL0Nic0JEenArNEpHbG0r?=
 =?utf-8?B?c1VJeUlqZnlJWkJlWHhRTUI4NEo5bU10dW1GTTZkK2tKbHVQbmdBeTR0alh2?=
 =?utf-8?B?NzBjdnZuMUYxeENKQUY5a3JuMGNwV2IzSlN6cHI4a2RHRGoyVVJhZzR5TWda?=
 =?utf-8?B?SVBFRmtUcXEzeW1FaGc2a0c3QmZ4bkV3VUZ2aXFQQnlid3RKZlQ4TzFQZXFC?=
 =?utf-8?B?N1YzQzJSVlFsS1RXaFJYQ3lhekw4eDVjY2xsU0YxYzN1ZDRGcTltR2JTSTg0?=
 =?utf-8?B?SnJmUU9FWklwdER0V0svaUpyT0hhVUYvNjVySWRBb3lEVkl4MVlvK1RrOW1Q?=
 =?utf-8?B?dWpHaSt2L2hSdlJWWHppa2Y4TGRXWHpkL1FHazdwdnJUZnNBT0lwQW5na2Fq?=
 =?utf-8?B?WVc0QzJjNmZpZWFoQ2NwdzlNMnNMdzQwZkVyN2J2OEZ4NW10NkZ2Vk9tb3Ux?=
 =?utf-8?B?aGdCbGV5MTVmZFdkUXdXZ0FVcjQ2VzEzaTc5UktZM1p4dDFiNlFDTlNzVlVm?=
 =?utf-8?B?V0l4amF1ZFJPUEdzTWpyb1diTXFzZndhcGVRdjVJVmU0ODFocEN2ZlRNQXAv?=
 =?utf-8?B?K0FDTXltWWtXdWlUL25HeEl2TVBLTS9XMmVGZSt1MWpuY25DK2lIWVQ1M1B3?=
 =?utf-8?B?QUxJay9IY3NDYWtEamk0NUdSRXlXUmxmQXBOSmdZcWpPaGg3QXNZaHM1cURz?=
 =?utf-8?B?TXp4TkZpZm1vblhSUUN0dkIwS0pHS1dWYzJ2emJjOGYyd3NqaklrdFUyeDgv?=
 =?utf-8?B?TWpnUDBSQVRUOVhPSFh0RFNuUDB1Zmh1QkJSUGtVcXh3b0lNV0FrM3l5emkr?=
 =?utf-8?B?U1ZtM29mNlhPdnpGSlZHbkNvWjk3elBtT2J3R0tTeWNnOUhsc2J1U3RSdFZG?=
 =?utf-8?B?bFZRcFh0aFFEZ0grUENNUFhpQVRhMFBWbDBZNFVzZUFTSWk0anQrRi90TVhO?=
 =?utf-8?B?SFFxNVZLZ0QzbVlMTVFQT1dVTG9LcERqZXdHOW45dDJ0L0pDWlRseUUxdFZq?=
 =?utf-8?B?ZC83em42eDViSjRrZWc3cU1TYkYzRlhBaXluTmRKczVvOEwwWmtNRWRLMVFw?=
 =?utf-8?B?dnVqRFczNHhIL2dJSUJHbk9hOXp6MWdxZUhWWW9TbEZSRTc0VGpPdUtTU2hr?=
 =?utf-8?B?M2JmVWhLeENIL0RRSDZET3pkTmhWd1FhMUI2Q2RRYVFOT0ljSFBmeE00M2xF?=
 =?utf-8?B?TWl4ajBCd1pxRGhuNVp2b1VMUkdrMFBocWFSU2M0MUZoRVdIMjFYT2Myc3pO?=
 =?utf-8?B?UzJ2SW44SzB0WjZ3Y2swTC9lSTdrQndvRHd1SVhpTkkyd1pGQWc4bjE5N3dY?=
 =?utf-8?B?MEtFcmVCOVpxOTRXZG42Q1Y0TXRzQzRSQUppOG1NczgxejhKOHd3SlFjUXZN?=
 =?utf-8?B?REIraWxRY2xNU0U1SExhM2RmVG5DNkc3eFVsVVltQkk5K2Fhc0R2VG5xd3ZC?=
 =?utf-8?B?R3BTV3lKaHBFaEJIendXOEl5eGd4YWRZcGdIZ3FuRFVLZUdPVVVYQnRrU0Y5?=
 =?utf-8?B?cE44UmdiQmlNb0U1cEhaVEZnY05iUXVhbjZDZTNGaHR2NkVqU2E2bDhLaEpC?=
 =?utf-8?B?Z3BoMFdnQXAzelBIemc2RE94dTFVaUxTdWxxeG5RS2JScG9zbnRsanE0ZnFq?=
 =?utf-8?B?M3Q3TUpSQWYwdGt3Nm10eGJkdkJqbExsZXIwQzluRmx4N0pHVmlrOW1mbFBY?=
 =?utf-8?B?S0NPQnJicitqUXpEMk9ycVoyVFVYU1VSdUVkbEViK1c1SnVkUDRPMURtTVhv?=
 =?utf-8?B?QWYvOWVGVFZ5MEZ6WC9ZcmF1WTY4NnFsQjg3NFk1SWNvT20yT2pKblNsUWZt?=
 =?utf-8?B?VTMrTEtBajdzditQelhVa3NwVVlPUEUvWXJaU3c0bEdKaE5wOCs2a043QlVK?=
 =?utf-8?B?b1VGVlVIMlAwUmpvVkJPdzdHdE0wWVlISHlZeFpaQjJpdHNYQjVwUW9KbDZH?=
 =?utf-8?B?VU1aQ3VCUE5SN2tyeXErdkRhRnRlSmVjR2FWazNWazN6a1puU1RPUEQvSTMz?=
 =?utf-8?B?V0pUWkJTS2hmRmdFeTJaQ1J5MTFTdG4xV0VPc0RPWCtHeEMrYVcvVko0MExk?=
 =?utf-8?B?K1dhUkRibTg4VEF1Rk54V2pNYittQ1hITGFXVGpKbFlQT0ZQZ3REZHpQUHZq?=
 =?utf-8?B?SXRYeFZKZ004YVRUbUlSWGJjb1QwaE54U2tpVVVISlZ4VVVNSUZZWjRDeDZ4?=
 =?utf-8?Q?00YRtb7XVSjZ+TsU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E7EZN/zZL23oe3QD9t2XcEplU13kmPhPAv+0lRWw9CHMNuE55rz4fRdq+9RKbSK4HK6AjC3JhEiD7ZfthwIno1ulM8a2goIaEp2cnvigAZMNVVQ4QVY60NbnpmEnLI3obFKZRGff37CYqY6bMzrj2QnrsrrVyONokFYMC5GP0cXCUJYCGf6NGTYK5oyOh5OO9CkB2TEOu9RqgV83aDl/N6kueMOHfUIVIMuRDNVm5WUOrjWjPURtZDWjp9kIo6G2rVNUb96SdPZhXuEOsfbguRNdneJ16b6YpGqx/tCmcSN+qb7IIfNZl6DSmn4UZqi+r7o8a2+ZWKMimbzsPhPO2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34705c59-c3c4-4c14-9c44-08df4b0b4f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 15:46:45.6668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAch2IqCx/o3YJ7qfpULvkiK0sBRPR4d1kk06IC6rpraFcljhEsw6wwrKmcgTExiMzqZ8rNhVKwQXzyas6J4Bueyrwasrurtv4yGz8kSQjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB891970
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogRnJpZGF5LCBO
b3ZlbWJlciAyMCwgMjAyNiA4OjM5IEFNDQo+DQo+T24gMTEvMTkvMjYgMjI6MzgsIEpha3ViIEtp
Y2luc2tpIHdyb3RlOg0KPj4gV2VsbCwgSSdtIG5vdCBjb252aW5jZWQuIFRoZSByZWxhdGlvbnMg
YmV0d2VlbiBvYmplY3RzIGluIERQTEwgYXJlDQo+PiBhbHJlYWR5IHF1aXRlIGhhcmQgdG8gZm9s
bG93LCBhbmQgb2JqZWN0cyBmcm9tIG9uZSBkcml2ZXIgcm91dGluZWx5DQo+PiAicGx1ZyIgaW50
byBvYmplY3RzIGZyb20gYW5vdGhlci4gVGhlIGV4cGxhbmF0aW9uIG9mIHRoZSBsb2NraW5nIHJ1
bGVzDQo+PiBpbiBwYXRjaCA5IGRvZXMgbm90IGxvb2sgY2xlYW4gb3IgY2xlYXIuIFRoZSBkcml2
ZXIgZmFjaW5nIEFQSSBuZWVkcw0KPj4gdG8gYmUgbXVjaCBtb3JlICJkdW1teS1wcm9vZiIuDQo+
DQo+RmFpciBlbm91Z2guIFRoZSBjb21wbGljYXRlZCBwYXJ0IG9mIHRoZSBydWxlcyBjb21lcyBl
eGFjdGx5IGZyb20NCj50aGF0OiBhIHBpbiByZWdpc3RlcmVkIGJ5IGFub3RoZXIgZHJpdmVyLCBs
aWtlIHRoZSB6bDMwNzN4IHBpbnMgdGhhdCBpY2UNCj5yZWdpc3RlcnMgd2l0aCBpdHMgVFhDIERQ
TEwgb3IgdXNlcyBhcyBwYXJlbnRzIG9mIGl0cyBSQ0xLIHBpbnMuDQo+QSBtZXNzYWdlIGFib3V0
IHN1Y2ggYSBwaW4gcnVucyBjYWxsYmFja3Mgb2YgYm90aCBkcml2ZXJzLiBJIGhhdmUNCj5wcm90
b3R5cGVzIG9mIHRoZSBmaXJzdCBmb3VyIHdheXMgYmVsb3cgdG8gbG9jayB0aGlzLCBlYWNoIHdp
dGggS1VuaXQNCj50ZXN0cywgYW5kIHdvdWxkIGxpa2UgeW91ciBvcGluaW9uIGJlZm9yZSBnb2lu
ZyBmdXJ0aGVyLg0KPg0KPkluIGFsbCBvZiB0aGVtIGEgZG9tYWluIGlzIHRoZSBzZXQgb2Ygb2Jq
ZWN0cyBjcmVhdGVkIHdpdGggdGhlIHNhbWUgbW9kdWxlDQo+YW5kIGNsb2NrX2lkLCBkcGxsX2xv
Y2sgYmVjb21lcyBhbiByd3NlbSBmb3IgdGhlIHRvcG9sb2d5IGFuZCBsaWZldGltZSwNCj5hbmQg
YSBtdXRleCBwZXIgZG9tYWluIHNlcmlhbGl6ZXMgdGhlIGNhbGxiYWNrcy4NCj4NCj5BKSBQaW4n
cyBkb21haW4gKHRoaXMgc2VyaWVzKQ0KPg0KPiAgICBDYWxsYmFja3Mgb2YgYSBwaW4gcnVuIHVu
ZGVyIHRoZSBkb21haW4gb2YgdGhlIHBpbiwgd2hpY2hldmVyDQo+ICAgIGRyaXZlciByZWdpc3Rl
cmVkIHRoZW0uDQo+DQo+ICAgIFByb3M6DQo+ICAgICogb25lIGRvbWFpbiBsb2NrIGF0IGEgdGlt
ZSwgc28gbm8gbG9jayBvcmRlcg0KPiAgICAqIGEgcmVxdWVzdCBvciBhIG1lc3NhZ2UgYWJvdXQg
YSBwaW4gaXMgYXRvbWljDQo+ICAgIENvbnM6DQo+ICAgICogdGhlIGNhbGxiYWNrcyBvZiBhIGZv
cmVpZ24gcGluIGFyZSBzZXJpYWxpemVkIHdpdGggdGhlIGRyaXZlcg0KPiAgICAgIHRoYXQgY3Jl
YXRlZCB0aGUgcGluLCBub3Qgd2l0aCB0aGUgb3RoZXIgY2FsbGJhY2tzIG9mIHRoZSBkcml2ZXIN
Cj4gICAgICB0aGF0IHJlZ2lzdGVyZWQgaXQsIHNvIHRoYXQgZHJpdmVyIGhhcyB0byBwcm90ZWN0
IHRoZSBzaGFyZWQNCj4gICAgICBzdGF0ZSBpdHNlbGYsIGFuZCBsb2NrZGVwIGNhbm5vdCBjaGVj
ayBpdA0KPiAgICAqIHJlc3RyaWN0aW9ucyBmb3IgbWVhc3VyZWRfZnJlcV9nZXQsIHJlZmVyZW5j
ZSBzeW5jIHBhaXJzIGFuZCB0aGUNCj4gICAgICBwcml2YXRlIGRhdGEgb2YgYSBwYXJlbnQgcGlu
LCB3aGljaCBwYXRjaCA5IGhhcyB0byBleHBsYWluDQo+DQo+QikgUmVnaXN0cmFudCdzIGRvbWFp
biwgZGVmZXJyZWQgbm90aWZpY2F0aW9ucw0KPg0KPiAgICBFYWNoIGNhbGxiYWNrIHJ1bnMgdW5k
ZXIgdGhlIGRvbWFpbiBvZiB0aGUgZHJpdmVyIHRoYXQgcmVnaXN0ZXJlZA0KPiAgICBpdC4gQSBt
ZXNzYWdlIGFib3V0IGEgcGluIHRha2VzIHRoZSBkb21haW4gbG9ja3Mgb25lIGFmdGVyIGFub3Ro
ZXIsDQo+ICAgIGFuZCBub3RpZmljYXRpb25zIGZyb20gY2FsbGJhY2tzIGFyZSBxdWV1ZWQgYW5k
IHNlbnQgb25jZSB0aGUNCj4gICAgZG9tYWluIGxvY2sgaXMgZHJvcHBlZC4NCj4NCj4gICAgUHJv
czoNCj4gICAgKiBjYWxsYmFja3MgcmVnaXN0ZXJlZCBieSBvbmUgZHJpdmVyIGluc3RhbmNlIGFy
ZSBhbHdheXMNCj4gICAgICBzZXJpYWxpemVkIHdpdGggZWFjaCBvdGhlcg0KPiAgICAqIG9uZSBk
b21haW4gbG9jayBhdCBhIHRpbWUsIHNvIG5vIGxvY2sgb3JkZXINCj4gICAgQ29uczoNCj4gICAg
KiBhIHJlcXVlc3Qgb3IgYSBtZXNzYWdlIGFib3V0IGEgcGluIHJlZ2lzdGVyZWQgYWNyb3NzIGRv
bWFpbnMgaXMNCj4gICAgICBub3QgYXRvbWljDQo+ICAgICogdGhlIG1vc3QgY29tcGxleCBjb3Jl
OiBhIG5vdGlmaWNhdGlvbiBxdWV1ZSBwZXIgZG9tYWluLCBhIGxvY2sNCj4gICAgICBwZXIgb2Jq
ZWN0IHRvIGtlZXAgaXRzIG1lc3NhZ2VzIGluIG9yZGVyLCBhbmQgcGluIHNldHRlcnMgc3BsaXQN
Cj4gICAgICBpbnRvIHZhbGlkYXRpb24gYW5kIGFwcGx5IHBhcnRzDQo+DQo+QykgUmVnaXN0cmFu
dCdzIGRvbWFpbiBuZXN0ZWQgdW5kZXIgdGhlIHBpbidzIGRvbWFpbg0KPg0KPiAgICBQcm9zOg0K
PiAgICAqIGNhbGxiYWNrcyByZWdpc3RlcmVkIGJ5IG9uZSBkcml2ZXIgaW5zdGFuY2UgYXJlIHNl
cmlhbGl6ZWQgd2l0aA0KPiAgICAgIGVhY2ggb3RoZXIgYW5kIHdpdGggdGhlIGRyaXZlciB0aGF0
IGNyZWF0ZWQgdGhlIHBpbg0KPiAgICAqIGEgcmVxdWVzdCBvciBhIG1lc3NhZ2UgYWJvdXQgYSBw
aW4gaXMgYXRvbWljDQo+ICAgIENvbnM6DQo+ICAgICogdGhlIGxvY2sgb3JkZXIgY29tZXMgZnJv
bSB0aGUgdG9wb2xvZ3ksIHNvIGEgcGluIG9mIEEgcmVnaXN0ZXJlZA0KPiAgICAgIHdpdGggYSBE
UExMIG9mIEIgdG9nZXRoZXIgd2l0aCBhIHBpbiBvZiBCIHJlZ2lzdGVyZWQgd2l0aCBhIERQTEwN
Cj4gICAgICBvZiBBIGRlYWRsb2NrcywgYW5kIGxvY2tkZXAgc2VlcyBpdCBvbmx5IHdpdGggYSBs
b2NrZGVwIGNsYXNzIHBlcg0KPiAgICAgIGRvbWFpbg0KPiAgICAqIGEgc3R1Y2sgZm9yZWlnbiBy
ZWdpc3RyYW50IHN0b3BzIHRoZSBkb21haW4gb2YgdGhlIHBpbg0KPg0KPkQpIE1lcmdlZCBkb21h
aW5zICh5b3VyIHN1Z2dlc3Rpb24pDQo+DQo+ICAgIFJlZ2lzdGVyaW5nIGEgcGluIHdpdGggYSBE
UExMIG9yIGEgcGFyZW50IHBpbiBvZiBhbm90aGVyIGRvbWFpbg0KPiAgICBtZXJnZXMgYm90aCBk
b21haW5zLiBUaGV5IGFyZSBub3Qgc3BsaXQgYWdhaW4uDQo+DQo+ICAgIFByb3M6DQo+ICAgICog
dGhlIHJ1bGVzIGZvciBkcml2ZXJzIHN0YXkgYXMgdGhleSBhcmUgd2l0aCB0aGUgZ2xvYmFsIGxv
Y2sNCj4gICAgICB0b2RheSwgYW5kIGxvY2tkZXAgY2hlY2tzIHRoZW07IHRoZSBvbmx5IG5ldyBv
bmUgaXMgdGhhdCBzdGF0ZQ0KPiAgICAgIHNoYXJlZCBiZXR3ZWVuIGNoaXBzIG5vdCBjb25uZWN0
ZWQgYnkgYSBwaW4gbmVlZHMgYSBkcml2ZXIgbG9jaw0KPiAgICAqIGEgcmVxdWVzdCBvciBhIG1l
c3NhZ2UgaXMgYXRvbWljDQo+ICAgIENvbnM6DQo+ICAgICogb25seSBoYXJkd2FyZSBub3QgY29u
bmVjdGVkIGJ5IHBpbnMgcnVucyBpbiBwYXJhbGxlbDsgb24gdGhlDQo+ICAgICAgR05SLUQgc3lz
dGVtIHRoZSB6bDMwNzN4IGFuZCBhbGwgaWNlIFBGcyBlbmQgdXAgaW4gb25lIGRvbWFpbg0KPiAg
ICAqIGEgY2FsbGJhY2sgdGhhdCB3YWl0cyBmb3IgdGhlIGhhcmR3YXJlLCBsaWtlIHRoZSBwbGFu
bmVkIHJlc3luYw0KPiAgICAgIGZvciB1cCB0byAxIHMsIG9yIGZvciBmaXJtd2FyZSBzdGlsbCBz
dGFsbHMgYWxsIERQTEwgZGV2aWNlcyBpbg0KPiAgICAgIHRoZSBtZXJnZWQgZG9tYWluDQo+DQo+
RSkgR2xvYmFsIGRwbGxfbG9jaywgc2xvdyBjYWxsYmFja3MgYXN5bmNocm9ub3VzDQo+DQo+ICAg
IFByb3M6DQo+ICAgICogbm8gY2hhbmdlIGluIHRoZSBjb3JlDQo+ICAgIENvbnM6DQo+ICAgICog
dGhlIHJlc3luYyBwcm9ibGVtcyBmcm9tIG15IHByZXZpb3VzIG1haWwsIGFuZCBhIGNhbGxiYWNr
IHRoYXQNCj4gICAgICB3YWl0cyBmb3IgZmlybXdhcmUgc3RpbGwgc3RhbGxzIGFsbCBEUExMIGRl
dmljZXMgaW4gdGhlIHN5c3RlbQ0KPg0KPkkgd3JvdGUgYmVmb3JlIHRoYXQgc3RyZXRjaGluZyB0
aGUgZG9tYWlucyB3b3VsZCBub3QgaW1wcm92ZSBhbnl0aGluZyBvbg0KPnRoYXQgc3lzdGVtLiBU
aGF0IGhvbGRzIGZvciB0aGUgVG9EIHN0YWxsIEkgbWVhc3VyZWQsIGJ1dCB0aGUgemwzMDczeCBk
b2VzDQo+bm90IG5lZWQgdG8gaG9sZCBpdHMgY2hhbm5lbCBsb2NrIGFjcm9zcyB0aGUgZWRnZSB3
YWl0cy4gV2l0aG91dCB0aGF0LCB0aGUNCj5yZW1haW5pbmcgd2FpdHMgYXJlIHRoZSBwbGFubmVk
IHJlc3luYyBhbmQgb3V0cHV0IHN0YXRlIGNhbGxiYWNrcywgYW5kDQo+d2l0aCBEIHRoZXkgc3Rh
bGwgb25seSB0aGUgZGV2aWNlcyB3aXJlZCB0byB0aGF0IGNoaXAsIHdoaWNoIGRlcGVuZCBvbiBp
dA0KPmFueXdheS4NCj4NCj5TbyBJIGxlYW4gdG93YXJkcyBELCBhcyBpdCBnaXZlcyBkcml2ZXJz
IG5vdGhpbmcgbmV3IHRvIGdldCByaWdodC4NCj5Xb3VsZCB0aGF0IGFkZHJlc3MgeW91ciBjb25j
ZXJuLCBvciBkbyB5b3Ugc2VlIGEgYmV0dGVyIHdheT8NCj4NCj5JdCB3b3VsZCBiZSBnb29kIHRv
IGhlYXIgZnJvbSB0aGUgb3RoZXIgRFBMTCBtYWludGFpbmVycyBhcyB3ZWxsLg0KPkppcmksIFZh
ZGltLCBBcmthZGl1c3osIHdoYXQgZG8geW91IHRoaW5rPw0KPg0KPlRoYW5rcywNCj5JdmFuDQoN
CkFGQUlVLA0KR2xvYmFsIGxvY2sgaXMgbm90IGEgcHJvYmxlbSBoZXJlLCB0aGUgZHBsbCBzdWJz
eXN0ZW0gc2hhbGwgbm90IHdhaXQNCmZvciB0aGUgY2FsbGJhY2sgcmV0dXJuIHRoYXQgbG9uZywg
YXMgbWVudGlvbmVkLCBpdCBoYXMgaW1wYWN0IGZvcg0KZGlmZmVyZW50IGRldmljZXMsIHNvIG5v
IG9uZSBzaGFsbCBzZWxmaXNobHkgdGFrZSBpdCBmb3IgdGhhdCBsb25nLg0KDQpUaGFuayB5b3Uh
DQpBcmthZGl1c3ouDQo=
