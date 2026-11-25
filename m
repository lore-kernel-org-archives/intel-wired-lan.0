Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EB606A335
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=i2AORYC+;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GMFsiyJG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Gpysxf1W
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBD024074C;
	Wed, 25 Nov 2026 16:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbov-hNfkpCj; Wed, 25 Nov 2026 16:15:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C7F8405C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795623317;
	b=Ya/We4Z4ya1L+dyDcoN1dHOj+sTatM5MFT3VMiJiHZA6z86qI0IeKbB9QBqRt2SGdxff
	 eABePSz97xDqq1FXTiFWtiB1a5bik5sl+j4E3Ru/H6EuNeDao5a4KKh6HWQZ3uXJfVGuK
	 ZhJ7jET9x/3l9u191ivMll8qk6Xraf4G1ef+h3dPBaondstBRvvqkiS5kMdNELw5NKXHR
	 cUC8BxkQDJ0Eg5POIv4yHunBg8WcKKt/30QWq+aLDy0GKCz6dDELu94ZUMhxOhtzbyQs4
	 GxGsCzZQAg5FWxrwGOvQ/3XeGSHstsSdKLrMCCj4TEm2PK6MdILV555HvEfLDXp/M9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795623317;
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
	bh=BU1Sfxp+ip9DQenc60mTOW3PxTO2uain054mEDfUP2g=;
	b=cRfrgKXImut3SKtbFWlnATa7OtjQsURvpF0P+ByfhHSxYZJ/sZRdR+AkyCP3ycnFv8Kz
	 FLmO92/8r9SEeghn2XyCVJ9klxxP9aqgpQj0bBTACVzP3re3ix74r2MNVkUq9gVZ8b4CV
	 QHJablV9vgD2IjvTB+62VPs7Hv85z4IW7DmMCUd2AsMGdu45jbtjf8ymn9qsVD2xIQ2NH
	 IxnqeG5RCQO+7bRmpKqxIVMjYZ+IT2u+s1VKUiMrqIwKBONLu8zOU2Hw0hD0oY51/Nd31
	 q98dfm9ZlW3e99w2YSsUkTz8IjDSitCoVPruju04dYIgavAGlxvghLnRhbQKFaZCFXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795623317;
	bh=BU1Sfxp+ip9DQenc60mTOW3PxTO2uain054mEDfUP2g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2AORYC+yNC3ihcOhzNbTQXWO6qE/+sPUTCA75NFt4mYS1K34D7oIENWfvw5md+N2
	 Vgmel4/pd1LRWbbF+2gAkA2uIKORIkTrtClOWfCPRVp4CEICqu54JmRrOnW8TQg2+Z
	 AuNzTvkeA/D69MAhFndIR/wJpBBY9u9kujTmLKlrk3ERdI3c5QAk80fh49QMWDwAbs
	 I0EIGbMbNgZc/qY1sq8R5p1yOkUK/NmjCrb2FahFh9L2ogYho9ICaBTkBW4pTqNwl/
	 33Fs4fGKua5y6oGzHAIEh9a5V70nOdswvYIYWo/96rIp1yrRvXzLRiho9sx1iX0F4O
	 bsz+lXEMZ63pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C7F8405C8;
	Wed, 25 Nov 2026 16:15:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A71331C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C6EE80E0A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_DcAr9cLplW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 16:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4889080E13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GMFsiyJG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Gpysxf1W
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4889080E13
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795623315; x=1827159315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BU1Sfxp+ip9DQenc60mTOW3PxTO2uain054mEDfUP2g=;
 b=GMFsiyJGn9UFVVMiiz8r2pfC98/bUajiu6tuLGzCyR0/ytWQ7nLeSp84
 HiUp3bVh77xfLNSqnyS/9bnHOJ/QiWO46aDqWHdXZYZfkpf0TTBP+x1ge
 kC1cCV+UDWKNQDSrP9POSmRgpvMckfshRLGNvVOgbF42zIBtNzrHa+6Hh
 Q6tajmtWLGkWHH86yghkg24qYOgSGqrXWM2OZrwNiHR7biUerxPxJDM6M
 eUnytVQxQT04WmZTHMXEcshs1PeNK2Se+8nGMZdOc3XuHhqIAQJ3BjhyW
 bfVJ7hPjxapT41SiykNRRwUcxyEeBn+2Mv/yjswEcwX1NjJsKgcOxFKSu w==;
X-CSE-ConnectionGUID: AJ3dh7ZqTXOxq3Q7hhDUHQ==
X-CSE-MsgGUID: Qb9UTZsRSbGFag8j33PTdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4498279"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4498279"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:56:25 -0800
X-CSE-ConnectionGUID: WF+VTTpdRyuWj4p1XRBOJg==
X-CSE-MsgGUID: LvRzqdMAQva/COnpp2BuFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12218893"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 07:56:26 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 07:56:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 07:56:24 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 07:56:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU1Sfxp+ip9DQenc60mTOW3PxTO2uain054mEDfUP2g=;
 b=Gpysxf1WYjcfgHfTMmIdM1wgfmii0MMyLzxknXAz3bzeuoPTBqnT0+1fi72+UCVKMhY4a20yGVfDZ8dJZVAl8GMflSAzBmNR/RTl/BrxiQt4+ZTHnbr7uiWFFvWiYhasSz6mJdNq3Y3dw4dXEQoYFjErf0Di9nFJUYVDpI5tvIA=
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 15:56:21 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 15:56:20 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Min Li
 <min.li@microchip.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Oros,
 Petr" <poros@redhat.com>
Subject: RE: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Thread-Topic: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Thread-Index: AQHdcftsjeqnHCNYXUaGas67mVSOY7cxj0QAgAJv8oCAAKvVAIAAtCaAgACZlICAAKevgIAAzyeAgALf1YCABJ/rAIAAFuZw
Date: Wed, 25 Nov 2026 15:56:20 +0000
Message-ID: <MW4PR11MB69845212A048D72C99D3AE079B432@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <20261116181612.107a4b57@kernel.org>
 <fe1dcdd5-ef75-4231-bf9f-03bf8536c2aa@redhat.com>
 <20261118174424.32e9f130@kernel.org>
 <dd1d61d7-7bef-4a02-8518-e17d2f50369f@redhat.com>
 <20261119133851.3f25074c@kernel.org>
 <bdfa88fe-13bb-4050-b750-962586b1d846@redhat.com>
 <ff8b63b7-b943-444a-bd37-b6fb493b5d9f@linux.dev>
 <awMP9Gj3Xhia0ZeI@FV6GYCPJ69>
 <8dc4f480-a875-4118-b5ee-2c4716ee53bc@redhat.com>
In-Reply-To: <8dc4f480-a875-4118-b5ee-2c4716ee53bc@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|SJ0PR11MB5136:EE_
x-ms-office365-filtering-correlation-id: 7cb49da9-10df-4318-5010-08df4b0ca622
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|56012099006|5023799004|11063799006|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021135927099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 05LvIRNNsur3luca9wrrUjkVB28zvhXVxIt5NLhG8ASSrkOrEJQwo4Xr3lXlpr48D25lBR0OT+hI3gWaPp9Ke0lb3+CCodQkGakoest2Y55eVS19i8irFX1+nI5GlCixNxDFldyaKSER1XwhCKZtmL6Cns5fuzNADkpSd18TYiSzjUx4f33TzxSmO/2pAhel2qzFjvUgkJ7WV2XAGlHaCjw+GG9ef4Qj6f9njOqOgH1TtGFUW/4G98sFQ3VAdkXS2Wk9YnF1p0wCV89mtnnHL+dMYvNvMBTXZWGdX07cWFSv8ekOMhk/jwvIy8gMktF2W4sBG7Gt0fyjCc7wVUI/muoUVk2WBVA/iroV2BBZBPn4sZAW3E0iUnF0LtvTB5S1Y13zU04hIVv1LEzrJOonF4RcRdznlDihQa7ivrDgiXDmNEAOmJdYAOkvJKwSKLNy4H7M4bMUF+SoYxwmjB/9eCn7blCC9u8ih2uIkPdrzzDEIShXJR395Teys1GlQ2dNq4e03bOpIXXn7lW+3Xg4uGImEcD8DIpGxbdC8oxjmN+f+6HeEPAW7GUZK8UbGyMO97M3eunMC8d0+ariX8h86XVf/QiGzehX3pbhAN8Qb/D0HpyOb5eitJ7f4eOoE6cffNErHnVzYd4A1UwXE13UmLoCiznsVkRD9sfutnzPjsZm5/vLmsue+qrcQUEJlpl3O+GbBFeXKELHxyF9PRKGdYkgMu2vWxaVwHIxaVcLExY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW55K1Z1ZlRBZnh6bjd4TDRZL1FrckRaa2w1TVFTUUdkR2hmeWtxbnVhb29v?=
 =?utf-8?B?WDhFMGsyK2RLbXFLOUVhRkVpVHE4ZUs4YW5HNVNHVHh6end2ZUpHL3NpZG9H?=
 =?utf-8?B?TmZYa0gydXhDZTFIYkk1OGo4azZWMVZhc3B3RDBrbkxiS2N5QWRqa0hmSzdr?=
 =?utf-8?B?akduR0orUUVuT1ZJWktOYzIrbUdKMVVHWFFGVWtkZ3A1WGVqL3ljTWdUUG10?=
 =?utf-8?B?OE9tS0hhMXoydFFITUNzRGU2YWFYcUpCakpFNERXTWlpbjQvQkZrRTdISmpr?=
 =?utf-8?B?dFVpMkptTVRJQTBSL2lKeFQ0d2thS2JYZnBwQ04xVlZ0K0NJMjg2bWtyaXpy?=
 =?utf-8?B?b1hpRjJ2UUovQVdsVTYyZDA0dE9NbVdQbTBBeWd4M2xQd2tzVmRUT0dLVEJm?=
 =?utf-8?B?N3NvVzdRVytxMmFZeVZvYW1BcEU2bTNqUE5ieTJ6ZHNkb0pYT21BWDVQRUFr?=
 =?utf-8?B?emMrTytpM2lHdnhTL2d1b3QyNmxWMHNSekl0RHZtVmFEQ3hLRURrLzQyZ004?=
 =?utf-8?B?QndHREVRMmhWbFJVNzdwaHAxSFY4aEtXTzVhNjJmczc4S0ZpbGNwSVlxQ1d4?=
 =?utf-8?B?MGlIYWgyS0IzK1A4bmRGRFRyZGdjUzN3NDRZSnF2U2plcmFkWDZRUTI5U1pu?=
 =?utf-8?B?T1k4Y2JFR0xnb2dERU5XYmpJWXU4SDZQc2NSWWUxc2ZSdVpVc2F0bkt0NHFM?=
 =?utf-8?B?Z1FuajROSU96MWdJeFNQUCtXWHQ3VXJYSml5NWEzbnAveWwzemhJVjFZb3NX?=
 =?utf-8?B?OWJpd3o3cnlueVdkbi9IVzUvU21UMjcxbEdDWnN1ZFdKUk5zditBMDRtS1E1?=
 =?utf-8?B?VmhEOURMQnlLVG5tWDliNlg5TlZJRUNjWFBFanNPRXNzRTdYMmJnUFBZUGtm?=
 =?utf-8?B?NzN3Q0VDK2lNZkpwdlIwK0tTd3lsVVF1eS9sbWxsN0toc2c4RWd0d3NqNksx?=
 =?utf-8?B?cmdVSm52T2llTHJOeWZJdndqMkxRREZnRWhWd2R5SWxWLzFSdXBZandOMzQ5?=
 =?utf-8?B?aWZyNGRXMjIwcU1Ea1JUWEZLY0hkQm1WblRGRmdxeFZ2OHFqZjlaM2F4RGJm?=
 =?utf-8?B?Z2xDNmxWYzFreE5sSEY3eWMxdE1welhDSTZwb1FHamV2UW96WEg2WHhOeDZK?=
 =?utf-8?B?RWZ3elpOcXJpbkd6WmZ1Q0lDVmpSL3E2aEVoSUhsUTFEVVRRbEErMEk5VTgw?=
 =?utf-8?B?dkpBbWREUnQvSUVUL3Uva1dNak1oN2djUW5JYXAzQ3RpNEc2czhoSXVFQzBR?=
 =?utf-8?B?eUVmUVRPVnVadUJCdnJORlc2M0ptaWt6WEsxZ0FDZFhaM2x1UVZWSnladTFF?=
 =?utf-8?B?QytuUWI4d0ZJMzJHbFZEWEJ4aFY1ZGl2VHg3dDRuL2xmaEtOOFdrK0FxNTRy?=
 =?utf-8?B?algzZHdiMW9XVjU1MFhMZEh1SmRHOXdESUV5azBmTjFsb0YzbXo4YU81bEJH?=
 =?utf-8?B?bFFkNjZLN3hMZnFlSHB2ajJqWS9uYWZ3QS9XQ1ZEek45ZHc4cUpVZzBaNnpp?=
 =?utf-8?B?cEQwK013QTNYclNqeTJGUlVhMXFHQW5ySFZVU2lDODVRZVVXSDBVS2pQUjNl?=
 =?utf-8?B?UlovU3NJdE5VSFo1VTlJby9WOEdlQzJDYlZyRTNpcmg4c0RHTWE5L1dheC80?=
 =?utf-8?B?S25tNTZtMll0enh4Q01wU3NRTENQYjYzL1JBQnVUN3l5M1ZJTUdjd2ZqOFNS?=
 =?utf-8?B?MWp3Wi9lSkNNR2hJQkVGRXB1aTh5WWR0QVoxeXFLY29WWThzSjdrV1VhUTBx?=
 =?utf-8?B?c25UNGRTNk0vL3c4Y1ZJZmNOQzVZZTBTNWU2YkpkTGh6aXJyQkNySkRNN2Fq?=
 =?utf-8?B?T0thTmQ5ZVQ2bFF4OXovbzBVcmI2WEkvbExibElnYUlVZTdCei9KdTYxdzVn?=
 =?utf-8?B?enJTd1FrcTB1d25SMnRXRFJwT3dXV3BwUVNRYWloRTByU1dwQm9hTkttRGkz?=
 =?utf-8?B?bFVyYTN2YlJvN3pRWCtya2g4TTRqeUNiZHJsVUJHTVR1N0ZhSmI4Wndadmk3?=
 =?utf-8?B?bU9FVUM3U2FVazVISkVJYy9zd2tIeExhblJ3NGxuOENwT0MwdGlZRUZhWnJt?=
 =?utf-8?B?OXpCS3lpN2NrNjVHRmtNR3VyVHIzQmNhNzJGVHMwUnlqSWJwblJwTjFLYXdh?=
 =?utf-8?B?akhoV0dzZHlMSklOY3JlUktGdzhSTjZ0V0VMd1VFNEt5UnJhMnh3US84dlJ1?=
 =?utf-8?B?U3pZSVZtVXZrZHJJN3VmUnZERjFTMmwrbzRlWCtJdDA3N3dOVXpCZE5yZkc1?=
 =?utf-8?B?M0FpMXRwOW15NkxOZ2tsN3RTL2ZSczE5M0hUUmgxWWJqOS9xQ0VKaTkzOGNR?=
 =?utf-8?B?djdMNWM3cDF0QXZiRnBBd05ZbTl3ZWRiOXhzWmlSdXh0NklTNVdnNDJldkFQ?=
 =?utf-8?Q?qlcfwfk6rOx/EkTE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JQMMvFUBo5okjHgbAuNSpxtd3rqMFEHg+fgNvzBZRpLJC09aQ+ZQL+dFlxt2H+mdXOaonSNEnPw22gAjr9CapyE4sECjSJrFcHar6MY7TadlsqI92wNySxpEorHO1rSKfPgF4RGHCokf1PEglETd9J59E0omaBKREMIeCaeHvjFUFat1tq1k7w7J3uEpEz/e8ZP7i0AjIKlEp0ict4oadhRaXFSEnGtd8r2Nc1ltEwyeFgmtpG8LyM6tQwDLaRZTLNGcAw9asvfsM+aG1WQkx/BhB/6V7ti2XtOP1xxOU3Yeyw3wap0gip/8K7OCm6vrZlbZIYd8n9tSQGVXlMi2xQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb49da9-10df-4318-5010-08df4b0ca622
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 15:56:20.7827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXzNM+82MqWxthw1Gqk1h09DixbzXKqqHkilASR5fy6pcfbbKfAHN4Oq+TAHZABADHL9J3vAHF+JaxlyMPAHtoS+p8SFgDgLS41DUwIcYWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
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

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogV2VkbmVzZGF5
LCBOb3ZlbWJlciAyNSwgMjAyNiAzOjMyIFBNDQo+DQo+T24gMTEvMjIvMjYgMTY6NTQsIEppcmkg
UGlya28gd3JvdGU6DQo+PiBGcmksIE5vdiAyMCwgMjAyNiBhdCAwOTowMDoyN1BNICswMTAwLCB2
YWRpbS5mZWRvcmVua29AbGludXguZGV2IHdyb3RlOg0KPj4+IE9uIDIwLzExLzIwMjYgMDc6Mzks
IEl2YW4gVmVjZXJhIHdyb3RlOg0KPj4+PiBPbiAxMS8xOS8yNiAyMjozOCwgSmFrdWIgS2ljaW5z
a2kgd3JvdGU6DQo+Pj4+PiBXZWxsLCBJJ20gbm90IGNvbnZpbmNlZC4gVGhlIHJlbGF0aW9ucyBi
ZXR3ZWVuIG9iamVjdHMgaW4gRFBMTCBhcmUNCj4+Pj4+IGFscmVhZHkgcXVpdGUgaGFyZCB0byBm
b2xsb3csIGFuZCBvYmplY3RzIGZyb20gb25lIGRyaXZlciByb3V0aW5lbHkNCj4+Pj4+ICJwbHVn
IiBpbnRvIG9iamVjdHMgZnJvbSBhbm90aGVyLiBUaGUgZXhwbGFuYXRpb24gb2YgdGhlIGxvY2tp
bmcNCj4+Pj4+IHJ1bGVzIGluIHBhdGNoIDkgZG9lcyBub3QgbG9vayBjbGVhbiBvciBjbGVhci4g
VGhlIGRyaXZlciBmYWNpbmcNCj4+Pj4+IEFQSSBuZWVkcyB0byBiZSBtdWNoIG1vcmUgImR1bW15
LXByb29mIi4NCj4+Pj4NCj4+Pj4gRmFpciBlbm91Z2guIFRoZSBjb21wbGljYXRlZCBwYXJ0IG9m
IHRoZSBydWxlcyBjb21lcyBleGFjdGx5IGZyb20NCj4+Pj4gdGhhdDogYSBwaW4gcmVnaXN0ZXJl
ZCBieSBhbm90aGVyIGRyaXZlciwgbGlrZSB0aGUgemwzMDczeCBwaW5zIHRoYXQNCj4+Pj4gaWNl
IHJlZ2lzdGVycyB3aXRoIGl0cyBUWEMgRFBMTCBvciB1c2VzIGFzIHBhcmVudHMgb2YgaXRzIFJD
TEsgcGlucy4NCj4+Pj4gQSBtZXNzYWdlIGFib3V0IHN1Y2ggYSBwaW4gcnVucyBjYWxsYmFja3Mg
b2YgYm90aCBkcml2ZXJzLiBJIGhhdmUNCj4+Pj4gcHJvdG90eXBlcyBvZiB0aGUgZmlyc3QgZm91
ciB3YXlzIGJlbG93IHRvIGxvY2sgdGhpcywgZWFjaCB3aXRoDQo+Pj4+IEtVbml0IHRlc3RzLCBh
bmQgd291bGQgbGlrZSB5b3VyIG9waW5pb24gYmVmb3JlIGdvaW5nIGZ1cnRoZXIuDQo+Pj4+DQo+
Pj4+IEluIGFsbCBvZiB0aGVtIGEgZG9tYWluIGlzIHRoZSBzZXQgb2Ygb2JqZWN0cyBjcmVhdGVk
IHdpdGggdGhlIHNhbWUNCj4+Pj4gbW9kdWxlIGFuZCBjbG9ja19pZCwgZHBsbF9sb2NrIGJlY29t
ZXMgYW4gcndzZW0gZm9yIHRoZSB0b3BvbG9neSBhbmQNCj4+Pj4gbGlmZXRpbWUsIGFuZCBhIG11
dGV4IHBlciBkb21haW4gc2VyaWFsaXplcyB0aGUgY2FsbGJhY2tzLg0KPj4+Pg0KPj4+PiBBKSBQ
aW4ncyBkb21haW4gKHRoaXMgc2VyaWVzKQ0KPj4+Pg0KPj4+PiAgIMKgwqAgQ2FsbGJhY2tzIG9m
IGEgcGluIHJ1biB1bmRlciB0aGUgZG9tYWluIG9mIHRoZSBwaW4sIHdoaWNoZXZlcg0KPj4+PiAg
IMKgwqAgZHJpdmVyIHJlZ2lzdGVyZWQgdGhlbS4NCj4+Pj4NCj4+Pj4gICDCoMKgIFByb3M6DQo+
Pj4+ICAgwqDCoCAqIG9uZSBkb21haW4gbG9jayBhdCBhIHRpbWUsIHNvIG5vIGxvY2sgb3JkZXIN
Cj4+Pj4gICDCoMKgICogYSByZXF1ZXN0IG9yIGEgbWVzc2FnZSBhYm91dCBhIHBpbiBpcyBhdG9t
aWMNCj4+Pj4gICDCoMKgIENvbnM6DQo+Pj4+ICAgwqDCoCAqIHRoZSBjYWxsYmFja3Mgb2YgYSBm
b3JlaWduIHBpbiBhcmUgc2VyaWFsaXplZCB3aXRoIHRoZSBkcml2ZXINCj4+Pj4gICDCoMKgwqDC
oCB0aGF0IGNyZWF0ZWQgdGhlIHBpbiwgbm90IHdpdGggdGhlIG90aGVyIGNhbGxiYWNrcyBvZiB0
aGUNCj4+Pj5kcml2ZXINCj4+Pj4gICDCoMKgwqDCoCB0aGF0IHJlZ2lzdGVyZWQgaXQsIHNvIHRo
YXQgZHJpdmVyIGhhcyB0byBwcm90ZWN0IHRoZSBzaGFyZWQNCj4+Pj4gICDCoMKgwqDCoCBzdGF0
ZSBpdHNlbGYsIGFuZCBsb2NrZGVwIGNhbm5vdCBjaGVjayBpdA0KPj4+PiAgIMKgwqAgKiByZXN0
cmljdGlvbnMgZm9yIG1lYXN1cmVkX2ZyZXFfZ2V0LCByZWZlcmVuY2Ugc3luYyBwYWlycyBhbmQN
Cj4+Pj50aGUNCj4+Pj4gICDCoMKgwqDCoCBwcml2YXRlIGRhdGEgb2YgYSBwYXJlbnQgcGluLCB3
aGljaCBwYXRjaCA5IGhhcyB0byBleHBsYWluDQo+Pj4+DQo+Pj4+IEIpIFJlZ2lzdHJhbnQncyBk
b21haW4sIGRlZmVycmVkIG5vdGlmaWNhdGlvbnMNCj4+Pj4NCj4+Pj4gICDCoMKgIEVhY2ggY2Fs
bGJhY2sgcnVucyB1bmRlciB0aGUgZG9tYWluIG9mIHRoZSBkcml2ZXIgdGhhdCByZWdpc3RlcmVk
DQo+Pj4+ICAgwqDCoCBpdC4gQSBtZXNzYWdlIGFib3V0IGEgcGluIHRha2VzIHRoZSBkb21haW4g
bG9ja3Mgb25lIGFmdGVyDQo+Pj4+YW5vdGhlciwNCj4+Pj4gICDCoMKgIGFuZCBub3RpZmljYXRp
b25zIGZyb20gY2FsbGJhY2tzIGFyZSBxdWV1ZWQgYW5kIHNlbnQgb25jZSB0aGUNCj4+Pj4gICDC
oMKgIGRvbWFpbiBsb2NrIGlzIGRyb3BwZWQuDQo+Pj4+DQo+Pj4+ICAgwqDCoCBQcm9zOg0KPj4+
PiAgIMKgwqAgKiBjYWxsYmFja3MgcmVnaXN0ZXJlZCBieSBvbmUgZHJpdmVyIGluc3RhbmNlIGFy
ZSBhbHdheXMNCj4+Pj4gICDCoMKgwqDCoCBzZXJpYWxpemVkIHdpdGggZWFjaCBvdGhlcg0KPj4+
PiAgIMKgwqAgKiBvbmUgZG9tYWluIGxvY2sgYXQgYSB0aW1lLCBzbyBubyBsb2NrIG9yZGVyDQo+
Pj4+ICAgwqDCoCBDb25zOg0KPj4+PiAgIMKgwqAgKiBhIHJlcXVlc3Qgb3IgYSBtZXNzYWdlIGFi
b3V0IGEgcGluIHJlZ2lzdGVyZWQgYWNyb3NzIGRvbWFpbnMgaXMNCj4+Pj4gICDCoMKgwqDCoCBu
b3QgYXRvbWljDQo+Pj4+ICAgwqDCoCAqIHRoZSBtb3N0IGNvbXBsZXggY29yZTogYSBub3RpZmlj
YXRpb24gcXVldWUgcGVyIGRvbWFpbiwgYSBsb2NrDQo+Pj4+ICAgwqDCoMKgwqAgcGVyIG9iamVj
dCB0byBrZWVwIGl0cyBtZXNzYWdlcyBpbiBvcmRlciwgYW5kIHBpbiBzZXR0ZXJzIHNwbGl0DQo+
Pj4+ICAgwqDCoMKgwqAgaW50byB2YWxpZGF0aW9uIGFuZCBhcHBseSBwYXJ0cw0KPj4+Pg0KPj4+
PiBDKSBSZWdpc3RyYW50J3MgZG9tYWluIG5lc3RlZCB1bmRlciB0aGUgcGluJ3MgZG9tYWluDQo+
Pj4+DQo+Pj4+ICAgwqDCoCBQcm9zOg0KPj4+PiAgIMKgwqAgKiBjYWxsYmFja3MgcmVnaXN0ZXJl
ZCBieSBvbmUgZHJpdmVyIGluc3RhbmNlIGFyZSBzZXJpYWxpemVkIHdpdGgNCj4+Pj4gICDCoMKg
wqDCoCBlYWNoIG90aGVyIGFuZCB3aXRoIHRoZSBkcml2ZXIgdGhhdCBjcmVhdGVkIHRoZSBwaW4N
Cj4+Pj4gICDCoMKgICogYSByZXF1ZXN0IG9yIGEgbWVzc2FnZSBhYm91dCBhIHBpbiBpcyBhdG9t
aWMNCj4+Pj4gICDCoMKgIENvbnM6DQo+Pj4+ICAgwqDCoCAqIHRoZSBsb2NrIG9yZGVyIGNvbWVz
IGZyb20gdGhlIHRvcG9sb2d5LCBzbyBhIHBpbiBvZiBBDQo+Pj4+cmVnaXN0ZXJlZA0KPj4+PiAg
IMKgwqDCoMKgIHdpdGggYSBEUExMIG9mIEIgdG9nZXRoZXIgd2l0aCBhIHBpbiBvZiBCIHJlZ2lz
dGVyZWQgd2l0aCBhDQo+Pj4+RFBMTA0KPj4+PiAgIMKgwqDCoMKgIG9mIEEgZGVhZGxvY2tzLCBh
bmQgbG9ja2RlcCBzZWVzIGl0IG9ubHkgd2l0aCBhIGxvY2tkZXAgY2xhc3MNCj4+Pj5wZXINCj4+
Pj4gICDCoMKgwqDCoCBkb21haW4NCj4+Pj4gICDCoMKgICogYSBzdHVjayBmb3JlaWduIHJlZ2lz
dHJhbnQgc3RvcHMgdGhlIGRvbWFpbiBvZiB0aGUgcGluDQo+Pj4+DQo+Pj4+IEQpIE1lcmdlZCBk
b21haW5zICh5b3VyIHN1Z2dlc3Rpb24pDQo+Pj4+DQo+Pj4+ICAgwqDCoCBSZWdpc3RlcmluZyBh
IHBpbiB3aXRoIGEgRFBMTCBvciBhIHBhcmVudCBwaW4gb2YgYW5vdGhlciBkb21haW4NCj4+Pj4g
ICDCoMKgIG1lcmdlcyBib3RoIGRvbWFpbnMuIFRoZXkgYXJlIG5vdCBzcGxpdCBhZ2Fpbi4NCj4+
Pj4NCj4+Pj4gICDCoMKgIFByb3M6DQo+Pj4+ICAgwqDCoCAqIHRoZSBydWxlcyBmb3IgZHJpdmVy
cyBzdGF5IGFzIHRoZXkgYXJlIHdpdGggdGhlIGdsb2JhbCBsb2NrDQo+Pj4+ICAgwqDCoMKgwqAg
dG9kYXksIGFuZCBsb2NrZGVwIGNoZWNrcyB0aGVtOyB0aGUgb25seSBuZXcgb25lIGlzIHRoYXQg
c3RhdGUNCj4+Pj4gICDCoMKgwqDCoCBzaGFyZWQgYmV0d2VlbiBjaGlwcyBub3QgY29ubmVjdGVk
IGJ5IGEgcGluIG5lZWRzIGEgZHJpdmVyIGxvY2sNCj4+Pj4gICDCoMKgICogYSByZXF1ZXN0IG9y
IGEgbWVzc2FnZSBpcyBhdG9taWMNCj4+Pj4gICDCoMKgIENvbnM6DQo+Pj4+ICAgwqDCoCAqIG9u
bHkgaGFyZHdhcmUgbm90IGNvbm5lY3RlZCBieSBwaW5zIHJ1bnMgaW4gcGFyYWxsZWw7IG9uIHRo
ZQ0KPj4+PiAgIMKgwqDCoMKgIEdOUi1EIHN5c3RlbSB0aGUgemwzMDczeCBhbmQgYWxsIGljZSBQ
RnMgZW5kIHVwIGluIG9uZSBkb21haW4NCj4+Pj4gICDCoMKgICogYSBjYWxsYmFjayB0aGF0IHdh
aXRzIGZvciB0aGUgaGFyZHdhcmUsIGxpa2UgdGhlIHBsYW5uZWQgcmVzeW5jDQo+Pj4+ICAgwqDC
oMKgwqAgZm9yIHVwIHRvIDEgcywgb3IgZm9yIGZpcm13YXJlIHN0aWxsIHN0YWxscyBhbGwgRFBM
TCBkZXZpY2VzIGluDQo+Pj4+ICAgwqDCoMKgwqAgdGhlIG1lcmdlZCBkb21haW4NCj4+Pj4NCj4+
Pj4gRSkgR2xvYmFsIGRwbGxfbG9jaywgc2xvdyBjYWxsYmFja3MgYXN5bmNocm9ub3VzDQo+Pj4+
DQo+Pj4+ICAgwqDCoCBQcm9zOg0KPj4+PiAgIMKgwqAgKiBubyBjaGFuZ2UgaW4gdGhlIGNvcmUN
Cj4+Pj4gICDCoMKgIENvbnM6DQo+Pj4+ICAgwqDCoCAqIHRoZSByZXN5bmMgcHJvYmxlbXMgZnJv
bSBteSBwcmV2aW91cyBtYWlsLCBhbmQgYSBjYWxsYmFjayB0aGF0DQo+Pj4+ICAgwqDCoMKgwqAg
d2FpdHMgZm9yIGZpcm13YXJlIHN0aWxsIHN0YWxscyBhbGwgRFBMTCBkZXZpY2VzIGluIHRoZQ0K
Pj4+PiBzeXN0ZW0NCj4+Pj4NCj4+Pj4gSSB3cm90ZSBiZWZvcmUgdGhhdCBzdHJldGNoaW5nIHRo
ZSBkb21haW5zIHdvdWxkIG5vdCBpbXByb3ZlDQo+Pj4+IGFueXRoaW5nIG9uIHRoYXQgc3lzdGVt
LiBUaGF0IGhvbGRzIGZvciB0aGUgVG9EIHN0YWxsIEkgbWVhc3VyZWQsDQo+Pj4+IGJ1dCB0aGUg
emwzMDczeCBkb2VzIG5vdCBuZWVkIHRvIGhvbGQgaXRzIGNoYW5uZWwgbG9jayBhY3Jvc3MgdGhl
DQo+Pj4+IGVkZ2Ugd2FpdHMuIFdpdGhvdXQgdGhhdCwgdGhlIHJlbWFpbmluZyB3YWl0cyBhcmUg
dGhlIHBsYW5uZWQgcmVzeW5jDQo+Pj4+IGFuZCBvdXRwdXQgc3RhdGUgY2FsbGJhY2tzLCBhbmQg
d2l0aCBEIHRoZXkgc3RhbGwgb25seSB0aGUgZGV2aWNlcw0KPj4+PiB3aXJlZCB0byB0aGF0IGNo
aXAsIHdoaWNoIGRlcGVuZCBvbiBpdCBhbnl3YXkuDQo+Pj4+DQo+Pj4+IFNvIEkgbGVhbiB0b3dh
cmRzIEQsIGFzIGl0IGdpdmVzIGRyaXZlcnMgbm90aGluZyBuZXcgdG8gZ2V0IHJpZ2h0Lg0KPj4+
PiBXb3VsZCB0aGF0IGFkZHJlc3MgeW91ciBjb25jZXJuLCBvciBkbyB5b3Ugc2VlIGEgYmV0dGVy
IHdheT8NCj4+Pj4NCj4+Pj4gSXQgd291bGQgYmUgZ29vZCB0byBoZWFyIGZyb20gdGhlIG90aGVy
IERQTEwgbWFpbnRhaW5lcnMgYXMgd2VsbC4NCj4+Pj4gSmlyaSwgVmFkaW0sIEFya2FkaXVzeiwg
d2hhdCBkbyB5b3UgdGhpbms/DQo+Pj4NCj4+PiBJIHRvdGFsbHkgYWdyZWUgd2l0aCBKYWt1Yi4g
Q3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBEUExMIHN1YnN5c3RlbQ0KPj4+IGlzIG92ZXIgY29t
cGxpY2F0ZWQsIGFuZCBhbGwgdGhlc2UgY29tcGxpY2F0aW9ucyBjYW1lIGp1c3QgdG8NCj4+PiBj
b21wbGV0ZWx5IG1vZGVsIHdoYXQgd2FzIGRlc2lnbmVkIGZvciBJbnRlbCBOSUNzLCBiYXNpY2Fs
bHkgaWNlDQo+Pj4gZHJpdmVyLiBCdXQgbm93IHdlIGFyZSBhZ2FpbiBiYWNrIHRvIHRoZSBkaXNj
dXNzaW9uIGhvdyB0byBjb21wbGljYXRlDQo+Pj4gdGhpbmdzIGZ1cnRoZXIganVzdCB0byBmaXQg
d2hhdCB3YXMgaW1wbGVtZW50ZWQgaW4gdGhlIG5ldyBnZW5lcmF0aW9uDQo+Pj5vZiB0aGUgc2Ft
ZSBoYXJkd2FyZS4NCj4+Pg0KPj4+IE1heWJlIGl0J3MgdGltZSB0byBzdGVwIGJhY2sgYW5kIHRo
aW5rIGlmIHdlIHJlYWxseSBuZWVkIGFsbCB0aGlzLCBvcg0KPj4+IGZpbmQgc2ltcGxlciB3YXkg
dG8gZXhwcmVzcy9tb2RlbCB0aGluZ3M/DQo+Pg0KPj4gQWdyZWVkLg0KPg0KPkkgZnVsbHkgYWdy
ZWUgd2l0aCB5b3UgZ3V5cy4uLiBJIGFsc28gZG9uJ3QgbGlrZSB0aGUgd2F5IGhvdyB0aGUgaWNl
DQo+aW1wbGVtZW50ZWQgcGluIHNoYXJpbmcgDQoNCkNvdWxkIHlvdSBlbGFib3JhdGUgb24gdGhh
dD8NCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6DQoNCj5hbmQgdGhpbmtpbmcgbW9yZSBhYm91dCBW
YWRpbSdzICJNYXliZSBpdCdzIHRpbWUNCj50byBzdGVwIGJhY2suLi4iLg0KPkkgaGF2ZSBzdGFy
dGVkIGFuIGVmZm9ydCBob3cgdG8gbW9kZWwgdGhpcyBkaWZmZXJlbnRseSB3aXRob3V0IGFueSBp
bnRlci0NCj5kcml2ZXIgRFBMTCBvYmplY3Qgc2hhcmluZy4NCj4NCj5JIHdpbGwgc2VuZCBhIFJG
QyBwYXRjaC1zZXQgdGhhdCBzaG91bGQgYWRkcmVzcyBob3BlZnVsbHkgYWxsIHBhaW5mdWwNCj5w
b2ludHMuDQo+DQo+VGhhbmtzLA0KPkl2YW4NCg0K
