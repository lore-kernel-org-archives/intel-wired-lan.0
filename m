Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB262C79FA1
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 09:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 757D940445;
	Tue,  8 Sep 2026 09:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjdS2PcgO4XB; Tue,  8 Sep 2026 09:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 68EB540462
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788858327;
	b=RSCJRqks5mfh+90FbiMueaJrpw0Weez1O2w8XTkVg/brKFER5H7K6on6DDA1bDWf4+9t
	 izCzizwZXnV0FL+QXXFKNsnXpgh9KF/fSiUcoAddJpWzD1jJIF+jKpNIPv+fRU+vVCBML
	 zGSu97/kKOVCxpgjI2QsvMvAR+EwfHzbvRPN9W+f7udjkPgJFIHDrYzrPXXZjbZtUlECH
	 c1fx/n8c1X+xqMCAu6COmlWs9iRskSUs1jKFiTW9Wj0GZInbcXliKKwwJ5T7NNxUKsP14
	 vZw8ePdA5HmBjk2iqDxcvJ1a+qj7VkYCi11efvTIPfDRgy9sqn1GWU9jHfyQBvmFn3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788858327;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Cm9IQ6y1gJpXYzLKvwct9gzrHTdM3mwimGF151zlmm0=;
	b=ctCG3wBzoY1uJaRfufbNnkjYu4x+FAJ5voZnzVfQAxGS9wJZiYcmu5rONv3GX942+eUJ
	 rkgxuQNRPtdN+i7VxYCjtVBcgvUhX4z2il7a5QrogBtdkMJ42VAJnEVurnzWxkSybWLU8
	 xqvAgdwo/0v+jQUhYXM4pS9M4wG3YLvlrkEyOl9sZDwLRN+GWVL0lR3SEuswnTl9gW+gr
	 yLu6USJ6j/2S4YNU6RmGwAIUfn3Tbn5VZ0td1XBfLOREMTpPgekUCAmnyygMiLJ+4iol0
	 alGEQj2lejnk+zr7wP0mtbPiki8XXsI+g4gi5l8yif/mtbdN+keWGD0M2oHxJtyrdgw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4+LmUVW;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788858327;
	bh=Cm9IQ6y1gJpXYzLKvwct9gzrHTdM3mwimGF151zlmm0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6wcQT8oEyr4qgJ11uaCB+wgMATWbqUigkYIa6Beb79YEUlap7TomeZ1YUHxCe6jI
	 giDTuUpBQWG8rTYtqZbTRIPSdCWcAz4DBe60OQ3jYyGho5Btb5HykUSK7p3DbKmdMG
	 cUisMSMBIzcZHRqqlTVUDyYQsNmw706d8hE22pmuB+zpyMj1jnOFDhl4XxBHCPRfLr
	 jc+PpZA+ZCFpIWF9WKFjVPJdUVde4OkLdDgX1x9VhFMQ1sTZanv5ntQO1U58G9/pJl
	 iEBivIWG9qvLO0Gnqkj84BcMBpXv4NxykTX6kiw3YTfseiAZ4HQ1U9ffiBi4hxaBbf
	 OuCGWHWV4gmTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68EB540462;
	Tue,  8 Sep 2026 09:05:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 335759CF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1905840462
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naptX6Xe_dNz for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 09:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BEA8140445
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788858325;
 b=QozX41FJQ/9uczKUpKBcLfQmb3NcVZ2u6nKiPfPx49lr0q/rk5ZndLU2qoRr/qD8KQ9Y
 /0ap7ZWlHhF6A8hAI57iMYoymiz+n+EFR3+3Q8gZP5pGJeaXTjZf+5kUB9UcKVKZluxXx
 /5Sm+OFkgpcPDZblgHfww1/eZ5biIPoijpFB5ujPmkijo+o6xM4Y/qE7SJ5IwMPCvWQF1
 9hf8ZbH/YxdD3mcXJpbBqq19ABW5rVASBwe+3GVp/LgEy/m20tEC5e0CO2DiwQiabncGy
 GLzuqlXpIFpl5ZCBXB7HHlbwcK0JtCZrw6Mo0bEX7DW0gZ6/VI363OofONWtM0XGlyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788858325;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=Cm9IQ6y1gJpXYzLKvwct9gzrHTdM3mwimGF151zlmm0=;
 b=QHjB59/NOTN/uUZSOnfQZZQMNDPfxUaX15tJyArUqec0uo/KrBIWJCMVh9veSp7y+M5w
 vavRfDFy41WbPgbcRIEVd7NaRaw/UldSmA4uv0HL2xi/5WmhRQmIaQqnutT+Ft1sOV3L9
 aIC6OWLMiZ2iEwdkiyfHsbg3YZruCRfIpH7Ugx6X5m4bRa0uMtATLgjWjfPV65Xwc5+7u
 XOWglf+Iaa/LExdiWI9uG7ogSloPtaJ1gY08gf4b47DUhCfSIL5sFfm/xDLBR+18TKdu2
 bdT5KB+uQdj+/0UoMrkgdyE0qXxBfG3F4ucArBB3g9aR4yvDH+Gg2R9/IxWDh4dmQYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J4+LmUVW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J4+LmUVW
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BEA8140445
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788858325; x=1820394325;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o35NJGpdfLbjjsfJAwpBzwETlv0zQhMOVokR5mJeChk=;
 b=J4+LmUVW8N3qeVUVg0tTxghSQg+xFkIxr74cD7u4MJaAljJEMr+C9ISx
 zA1GGXD8jIvFmpFFj7jKx+VgBKuYBGYRy679tEDgzYXEFSS0Z4eyy2Pai
 tr+5Du/3mw9S6isJpK/vDyFXkHyKk3mp6QurQrlB/qZo+LS36ZDyIT3cu
 on0/e5DlpRhpcln8o8zDbfY3TWr7bO+H9QjNTWmp2xjSasAdXk24Sy/eC
 xT9OcJm5R88l8juk4Rz33QqMcKWW9k2jrVbHxvx9BZXO+9CJDmKKUBj2V
 vlHRSoJa4RVSzIn805O8NuYvcsb8NYzuIeOkawEaPoJRCdu5kkqatj6q1 Q==;
X-CSE-ConnectionGUID: 0gSjpdJJRLWdCB03x33TyQ==
X-CSE-MsgGUID: ZswsSHuhS8y1Iowv4myYIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100775817"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="100775817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 02:05:23 -0700
X-CSE-ConnectionGUID: or6UWdhSQRezkeCGaLuR8Q==
X-CSE-MsgGUID: u+MAzqS1Q3CvLeNVQE1v1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="274461534"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 02:05:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:05:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 02:05:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+aJrzi18pAU/3+YgBiSibm4FuX5Yvh4sJ8PrNhX7lle5M7VKDFlmFrbxr0wtJPgihWiPpZgOZEcTG5F3ozr0s5mbzt6l6fOwSg+jnjYY6pIAXddB9h9biY3GwvT/no8HLJJQVPvlpne+2c2rEMITGaZnp9o+QRldqx6+yF89eJjP5IeWqWCzumv1aSz063Euj5j+xUbeQqNhSNaHRL5uXjhORuX1ZDSksiDx89jD+0+CsPokE2P0XhuvC5v4VluF+jQ8O0sjVsM5Chuc6O3tDLfRRro+uUOy6r5XquVwpFSz+ob5ZYbJQFBgbSKlTShDjjH9gr7jlZ6+fl7xtaNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm9IQ6y1gJpXYzLKvwct9gzrHTdM3mwimGF151zlmm0=;
 b=jVcnpsULJwq2RkQDB1wEDmYguR33s/Nt8FwlkUZepeNo063ekUxnUVajdHcltaFT8nahqQ7naSWOaFj3uWC01RAJOuyV3inxEoHlCoM9xnEkZq47Oe8gKeBP0X0OdYDzDe1DybsU1tZFVfLFeoPXD+uHXc9Uyj3ROr7TMxImzwZr6BAIBxrNEOL0XAs3+1Ze+/OMSRRVk9pbxlPR4YwD9DsgOxtL7ioSfP10B3UIS0/VGwpTVnmsRa68wa1B8ur9tCFUYz3eZkz3U78PRw2eQOI9l34YP86q4g3Hsx3PbHXYpuHRPe9LM06INynZAOJWubT4EoPxFk5wTl4Z1htAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 09:05:11 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 09:05:11 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-net v1] iavf: fix VF stats not updating
 due to PTP command preemption
Thread-Topic: [Intel-wired-lan] [iwl-net v1] iavf: fix VF stats not updating
 due to PTP command preemption
Thread-Index: AQHdGrfzFOfC6bp0bUuCz5UmdohTUrbErHow
Date: Tue, 8 Sep 2026 09:05:11 +0000
Message-ID: <IA3PR11MB8985D350839BBD42966603C98FB12@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260723152823.645558-1-tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260723152823.645558-1-tomasz.lichwala@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DS7PR11MB9473:EE_
x-ms-office365-filtering-correlation-id: ec83e4bb-db1b-4963-6113-08df0d8849c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|3023799007|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: 4D1D/A/Xiul2/27zIXP5ipuEkFzL60jVncp9ddtTKCbfEUnpHZopvwqEjZUewwKO3+pn6ren3H/GBzpgO0MhCFrpJnTqIJn5Xwp5CCo+aWlXlZgRxuDqlFYm8JAriDu58XhnSYDuBMTpfzgxDzE6Zec1o6UzbfHKRCp2cXf0L3ODN3pWwrxOI6k/uZWUHUp9TIRVk4T87YigZ2hOmnElT2P+cGo69uXTR0QreZ0ng7rbWZJXgWzEGkEIiz51vUJX9KIgt9DHW5kQAdIzZT8Vtqcr5aEOLlnHwvIuLLWliye/bmNPwZjyBOGyFZpOEa++yZGXzscOUr5V5Wbj+npEFZ3wBWCkI4piNRDhU+ZGUHFHmXaqobcVGSKGdMqdFR5RIHxg/CyHXlQAqI3UPudNTwt8+ri8CxXq/q27t0Hl5POcxJ+i2noieuj4gkzmxXWT7+aARPk6wiODbVudug87j7qgwDOqmZqKOGGriSrTP1T/vH0bmMfuiK6qfCPHmnllGI4NbsMU7RAoN/RCaKp4dlRzh5GYdMqjHN2D00gvOLrLBkTw50Nsu3+GxqwUeMT8anFYSAY+CdLlxtHmaN/YKt9ReTZC9YcM3qP5QtHQMtqDW03cue/pfn+PVkDNxILzYgRnrg02xBotgedfe5USahrG7av4jDeWQ+DtHlwLkBECI+/32NT6jOm6E4kxEHJofi4nRurI5hVjmseGzFqLTq+5TG8AIfnuKXGczz7gq28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NpAnJqzM9FcEq//ZspI906mNX25ty/rWZw6OXV1GoA/epsA6u3Aox6m+hjBy?=
 =?us-ascii?Q?rP0K83bj8S8tZZskQJJVKPRVgF6SIhwEWCTb+azfamrnUofFjH5RFWr0Ayw1?=
 =?us-ascii?Q?i+I2am/HoaO9CadZDX9vyG2fyHJiGN//B9ukFDIigDS2+0dX6HSsSpNPXkOv?=
 =?us-ascii?Q?CzJfv7rfH8pmRn1kTzSUQ+U83yB0sJhZ0L5r0SJZpqrEasGHJzMdcZ3/XTNo?=
 =?us-ascii?Q?24H71meuvqFjH3JAHdDKY0rvsi8UChX0roRZudRz3dgnmdmgyYLh9qUAbL7V?=
 =?us-ascii?Q?aJRC01psA5COqJVNW0I91c2VjnDqvKeNtRV4eoTlvkKgucvILKg+pV8hrAPM?=
 =?us-ascii?Q?8jTATCTDHyZ3ZWB6r2NArQ+5mq8WJ9d1alG1jn2svgxlpqhYkkyDrMRedq38?=
 =?us-ascii?Q?v/dJRjLZuvFHK0GpZAMDG8m08AvEK6sOY6YBz/b2+BOfkGTtcTIulJusudJq?=
 =?us-ascii?Q?WrgL1nK1m7yGSpaiApBAbbwOCmFe8Y2+s2BYKNe9ygo3voMI1iAl+duR0lOR?=
 =?us-ascii?Q?Xm64ntkdFzJ0/EMzPV9obGACcihSX+gG0z+caY+szihDMvBIyjXKOXX3jMQB?=
 =?us-ascii?Q?nGIjR1Je/vYZa91QAAoQLWGKInC9smQtxOsfOdGRh1HHSvi7rwEexDM+Jjxu?=
 =?us-ascii?Q?qD5dTCyyJFZqwmsc1Yf79GSN7+QFjVICWwxTVarcHr0Vn3wIE1rbBeqD+QgH?=
 =?us-ascii?Q?J8ZGjlx7smjDYLaLkpQfsnb5UZV/7UyFrAYMa3YrexCuMW271SMBk6hLN6m7?=
 =?us-ascii?Q?0ODkT6lpAxKn6aSeAMTZjXA0tPmsEXc2UhkL+sQ6Hv28rqk3oZC3uQ0bJL3y?=
 =?us-ascii?Q?hzcwCs1wFJdf/yqSclt8CLNyLbX6mDNAR2LQrBy0o8i52m1hWjwTZqOfMWlM?=
 =?us-ascii?Q?zFE85OXHrdLAWiIsivloYiw6chN7ncyLcx2fxzLbGhJ5q9/YOWpYdMEKKRbA?=
 =?us-ascii?Q?TCTsdH1B6pZVppm5yI8lmwoq8AkAplvzX5x5L8Jyqh29ucy3uO6wvrPyWJuj?=
 =?us-ascii?Q?jvBaSt+a3pHG9G8BP1r+pqXP9vhrqv9D4ZK1HD8qZfbXcOTnxwHGLkNbKSzy?=
 =?us-ascii?Q?UABCtgn4esVB9PrsQ8As5+iQfPdT+F5K4uopkQRxT0xDXq5x8FgO0LPM3ywY?=
 =?us-ascii?Q?8kxh8JmI+WBE3FphzzaNSRivKxLfG0DBYFTXGYlmYM4nbbq2Onn/OaAQnYWx?=
 =?us-ascii?Q?9GiWJ9rFMINieOks18ZpkEeffrrIcM0DS1SWHSUIDmw6od0Qv3rCHIeduglm?=
 =?us-ascii?Q?Ao7JkcX1DQcOAU51yRvHafmkMd8AifthxVVYXbsx/usXLW9FU3tUHimVJ2Up?=
 =?us-ascii?Q?wpqsV6tI30sLmgyCoUt4wDByzCg2r8hROIRZ/GolN8R6T2O1/G+K+rlnTsCI?=
 =?us-ascii?Q?Eep3IRtSlPi7gQS1ag8tQzBWsvWWiV+ti3DuJ9ymcUc7bciCxPmpHNP7d20C?=
 =?us-ascii?Q?wNQ91RvdnFN2b9hN/EjBeYaFW+WRhipAPkHwvK8siMOWbC9ZfsQuHk9lt0QW?=
 =?us-ascii?Q?lcdhJ8X5vFYLhpUzLZChYj6GjQ3zY8T/qKGy9qwNuNUQN5RV+ftuMlk0cgX4?=
 =?us-ascii?Q?SiQ4Ju3oanQnxOzydxKcSvr0ptlYUnV2qrL2C6dsJVixYNLZVS59GSI784Jk?=
 =?us-ascii?Q?Js/DyC9iGu14M7PVf4yo0dEpEPP3L2b/lkCzcsrn1hyuIpeXktqBa5O2n8wH?=
 =?us-ascii?Q?B9vFUJjIFrZEQl2qp6wFdXhhyOyR2/GaX0fSlnv9USifycyCwObrn64s9lZ4?=
 =?us-ascii?Q?SMHm3mjjNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pWCuz0tlGvvUULumgVo7vb5qtQlKH9wnSy/+e5aDQCN915nB6zLG71MyecjxnASYHZh95ogFIswWh/eyBA2zlVe5o5TY6f4LBfqiwGrKcawhawKyB0OOZdO76+N/Cc6Y/muKr5qOqPYC0l2FPflACi/oRVJ2lW3yNT4AzR7Tzvlb/9oKsunG1NmwA9HUxOKG3QQlwbLOInBffXJVwL6o8+9/qDmZPxV8SIXC98IKO3ar2fiXx4sthQUm0EPavYB20dxDWuQBToIu6KdJiTVaOKOGRKFPWHflnrJi6aMRy1SVXHxItG5CH+Td1BfQ9TLgvFD6Rmc5RGONg9QfEoYPKQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec83e4bb-db1b-4963-6113-08df0d8849c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 09:05:11.4121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OScdfYjNI2nZj6NjFyUg76O5U1GQ++jI+tH+Bi4CNpyfMGzHOMRS52D3YmZzRQSCJeeOYKis8wXk2M9Qh0lBvdnNzGUru8uPWPEwUg75oq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tomasz Lichwala
> Sent: Thursday, July 23, 2026 5:28 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>; Loktionov, Aleksan=
dr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [iwl-net v1] iavf: fix VF stats not updating d=
ue to PTP
> command preemption
>=20
> Since the introduction of PTP support in iavf, commit 7c01dbfc8a1c
> ("iavf: periodically cache PHC time"), the periodic PTP clock caching tas=
k always
> provides a pending admin queue command, causing
> iavf_process_aq_command() to always return success and permanently
> preventing the stats fallback path from executing, which results in VF st=
atistics
> remaining at zero despite traffic flowing.
>=20
> Fix this by making the stats request unconditional when the adapter is in=
 the
> running state, rather than relying on it as a fallback when no other admi=
n queue
> commands were processed.
>=20
> Fixes: 7c01dbfc8a1c ("iavf: periodically cache PHC time")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index f5697d9c97fe..a05bd61d7de1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2986,18 +2986,12 @@ static int iavf_watchdog_step(struct iavf_adapter
> *adapter)
>  				iavf_send_api_ver(adapter);
>  			}
>  		} else {
> -			int ret =3D iavf_process_aq_command(adapter);
> -
> -			/* An error will be returned if no commands were
> -			 * processed; use this opportunity to update stats
> -			 * if the error isn't -ENOTSUPP
> -			 */
> -			if (ret && ret !=3D -EOPNOTSUPP &&
> -			    adapter->state =3D=3D __IAVF_RUNNING)
> -				iavf_request_stats(adapter);
> +			iavf_process_aq_command(adapter);
>  		}
> -		if (adapter->state =3D=3D __IAVF_RUNNING)
> +		if (adapter->state =3D=3D __IAVF_RUNNING) {
> +			iavf_request_stats(adapter);
>  			iavf_detect_recover_hung(&adapter->vsi);
> +		}
>  		break;
>  	case __IAVF_REMOVE:
>  	default:
> --
> 2.54.0

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


