Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DAD606A323
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=h74VTFbG;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hcj+lhs8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AB/KUo6I
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6EAB605E9;
	Tue, 24 Nov 2026 20:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aenDHB5zXyQo; Tue, 24 Nov 2026 20:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF3C26065C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795553101;
	b=NXppLgy+sRHuMEJAQaVgDyStYoGJHhDqwNQ2+5PnZIZFYghyO7hqR3IoWoEBTh9pm1Ml
	 9q8CnPQEIBKVhhBrEHO7UW1qa9/uM7Hb8zA0jhR4qr1fSTxaXrBau53IVwH438DVl6x+V
	 AOj0h8oPKDUPZ53pi4U7WoIauC6DFsQOCAchaLWOcACNMhS84LB5tibcO2Zxt0YcJ7B7K
	 JjTzujQvbXL2DGIUHhp1LzTEQOc4J3ca6uzbbScFUlBNyheBJH83+KPn0Ec1mExeoFpaF
	 XZfBzDHWJl9ouNM2kVmAvG9AZq7cXhhpnpFkmno5ODbuvYPcqAZ9CVO/d8o2BPqucMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795553101;
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
	bh=NfERhjMpFge7mvw7ek+26X3JdGCR4xJex0ijidPu2/I=;
	b=FqhWiJ1hv+RqhPWKpdHJybBmTPb+VG2GmVUFqBjcvKfMqNgLXH5fbSIRfFQMSmX3rSZK
	 /GxB5WwlFmZl7RjWX6j+r0HCPMzh3BrEGBSe04Igtq9eQC1siUqin1xB7CPg1dXz4EKlh
	 hWbaARRB8460eMIeX86hqvVFNA91VtXEQSzwRfyYu8X+fsdhPJ78hguH25pSpu+ME66Gu
	 9X96NulGiQHR53mczBH2IqlWvZ/C5yCn0/5eeu0zTHkJ/gk79ZUgdZALJiKQv/ByZNjDu
	 UPtHLfxf376F7UF6QI3ysPsYFtPLUc086Fz9rIcEe4KdYZEe0tV8xvtkShVMorTet8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hcj+lhs8;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="AB/KUo6I";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795553101;
	bh=NfERhjMpFge7mvw7ek+26X3JdGCR4xJex0ijidPu2/I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h74VTFbGXq3DyEfoya0l0oIkmXpk0XPLku0d1LmEOQ+UpM/fW5D6wbmM02attBK8V
	 0uA6+7YS0DKULf2uBc9mbWuzyeLSB1v0nJ3CNe1Rj2YJjjCn0J5UDmUHMmWGhNOyK6
	 LATEzy8sLVYYpOAeHV87OVVjC1CW2SpeYgXA3s9rfpXfU9u7AGGcsTjmWVxrFHFY84
	 KfrF5bXsqQ5HmzTr0WinW0BwQEldVDZnv8pactO5uZCEdJ0DQapozXHyyclzHzZVrR
	 7m1TVy/UYH6+WUyeG4nUh2Uywh8w8hHR2qLMy4K0A3x2L3nSSlBe0JUE73sSf4DqEM
	 ZwW7egwnycGGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF3C26065C;
	Tue, 24 Nov 2026 20:45:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 637AE2DF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 20:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5575A6065C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 20:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjlLl_ZKGnaN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 20:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7672605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Hcj+lhs8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=AB/KUo6I
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7672605E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795553099; x=1827089099;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NfERhjMpFge7mvw7ek+26X3JdGCR4xJex0ijidPu2/I=;
 b=Hcj+lhs8ucESU+9NI9oyo1aPw/5TfA+qluvPC014OoOuYAI1RPIIyDAh
 faeghFZBGHL6ygoF+Usccu1nNuCO710a78jR+RtuRKkOGrllAvb0AuKi+
 O4HuRBdq0HiiDj7nMZcaSJQWlDUyINxo/RuSFza0tYDaj+6PLga9vIfpr
 u/Dj+hkPuuyD8d2gKqzyDbzP/gv7vQVUNlAVYcKg4eBhXZvFBuNkt7gvO
 Pt/1pp0rspsFf4DiSSbG5SHNw42RA7X+WTM4yrMrmcJe9ldkbOYMlQLLQ
 2/SxkpdkDea+vFOKoOEKYrKHFu7DjAVHb0w3Kw9mkXsrSBfGcZDCn6QX9 Q==;
X-CSE-ConnectionGUID: yop0jqIHTY625GphXlJd1Q==
X-CSE-MsgGUID: fwnDf+nOSb2PwvU8M6Uz7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4429966"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4429966"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:44:57 -0800
X-CSE-ConnectionGUID: wCXMqitwTVSqF70JwGpEGQ==
X-CSE-MsgGUID: k9D4e02ARGyyqHJ4ILqpjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11956177"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:44:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:44:56 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:44:56 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:44:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfERhjMpFge7mvw7ek+26X3JdGCR4xJex0ijidPu2/I=;
 b=AB/KUo6I7JBRODO3bxcaJZivNf0TFqJl+g/f2+HBRRwSNyBtp/go59dSpS2YxiCeznunhMHx+f31ALHCcd1NqJ0ex6CaP1wpFEyvHwNyCu7ZnJq8Rdy2zksALOtLgSg2zSTU2+aALNRoSVhQ6X4K4tczWiR/kVJF2iJcgHm6+hI=
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by DM3PPF96964A2A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 20:44:52 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 20:44:52 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Ilichev, Konstantin"
 <konstantin.ilichev@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
Thread-Topic: [PATCH iwl-net] ice: fix stale cached PHC time after a time step
Thread-Index: AQHdeUXMTGRnc/RRzkGWfzbY+P5dTLc7d10AgACRCwCAAVU5gIAAWQQg
Date: Tue, 24 Nov 2026 20:44:51 +0000
Message-ID: <SJ2PR11MB84518EE974FCB8F726D50C49D6442@SJ2PR11MB8451.namprd11.prod.outlook.com>
References: <20261112102301.342584-2-przemyslaw.korba@intel.com>
 <6fa3928e-90f2-42d3-86c6-ddc5492b51ea@intel.com>
 <PH0PR11MB4904B8854B7457816C72D4A894452@PH0PR11MB4904.namprd11.prod.outlook.com>
 <7864ad35-402b-4ae8-b470-ac6e9a81ac8e@intel.com>
 <PH0PR11MB4904948106E5E7E11F79B44394442@PH0PR11MB4904.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB4904948106E5E7E11F79B44394442@PH0PR11MB4904.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8451:EE_|DM3PPF96964A2A1:EE_
x-ms-office365-filtering-correlation-id: 97fc74e4-a1f4-48b3-c484-08df4a6bca08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|261009223027099003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: QMtEJqvGrMGeq/gg2C+Ytw7gKIzNJbkCTZe5exyCQs+6ghfsjvFhGwKEVK6o6ZIvtvvu9gILhkEn59emLq8m+H+idbZQ9rpwGvhCxtjETpkNu5ZhYQOEne2ThI6EeZq9NwRe97w0Mir6lixK8Z1rT9ffyDBABIQhFx0RcYBgkDALZTG0JX+ez2M/TaHrQ2oMzLqY1hqdK6HAiHQY/IsHdZlD6zfDr6mr/CU9be2hWGriHCRJFBWfii2ebocIlbbRn57wpJDFIu+1ttvbP/vv37D/q/9+oPcB8RuKg6IFsZWf1+Q1FUYRgZXwu9bE80iR2TTzSGlphcdFf5XO+uF4BWJlrJp3FBRgfrlAZ/kOGJKmnG9/OeLboVx8phQuBmyEJ6C5X3/WkV/atn8QwjVIQTRXd0xOk3QpFxFfXQhHrMkqHAb/pZVpm3K9CtYzGH4j7VF0i+BrDZPb0IBD8OamrdLQRVXvOEtNXyZw2ZaH8XdwHvbNiC72QRiD0u6nTgmSe/tlht/G6jASgc6yTGIARDhwTpSm6sB0QClZt+ceLcHS16q+Lnb7cDGy+tPgLrUUSGPstwn9Lk9lybbj8sx8rQ+3FiHKMgGs1b69TWN+KWujAfJE5qBzvq/MlBjXpCWKdv9tonPFRJEhczvHGyh1ihANSNEGLxsAXaunf4vjCl+RAURDAJ3P9idAF6gHoBVLbMXZu645LyRdQUVqraHIuWVrVUYzINq1UO4MhZSsT7o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261009223027099003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RSWUdGUTRNT1pSOTJBMDZpNXlndHpVZlZYOGVsS2p6WlZidlhZK1pudDFJ?=
 =?utf-8?B?b0FTRmRkcm5UQ29SWjEvVm5FR0NjQ2ZFa3RMN2RnbWI5VGdzSHRJQnEzY1FE?=
 =?utf-8?B?TlViRWt1bHJRc1BTOVc4NUE4RndFbHRNNG92cHZXcmQ2ZGtjakU0a2lxUUNJ?=
 =?utf-8?B?S0ZGZ29OVTZBQ1ByRGI4UTNZbm42NWZFVlljVDZiQ3phVk1GRDdBZGFkZTFF?=
 =?utf-8?B?MGdhUEtKZlJpcUozSkFVRzBZZzhpdTRhZnNKdlRuNHk3QmhKajh5VTYwQk0w?=
 =?utf-8?B?bldESFV4WURJTFhVZDdCTGFVcUlWODFvWTJsREluaEdhbWVhdWJpMmhsdmNs?=
 =?utf-8?B?dlVmUlNXV0E2b2lldFpyM3FqT1hZWUd6RGFscHRWZG1wbVpoSmV6alpaQmRx?=
 =?utf-8?B?dGpxZm9sVHl5WnB5UUpHdkNwbnR6SE5WMFV4MWJnbDdVSkxRYWEzQzZYL0tL?=
 =?utf-8?B?KzdkaWdpNnJrZ0xUU0I4M2ZSNlNQamVucVJTKzRBNVB3TEY5YmFjdUR5NG44?=
 =?utf-8?B?RHo5VFY4aWxnZEdpeVJWK0JVRWRRUnljSlV0RnVIWXZCVFBwWDdGWm16MUls?=
 =?utf-8?B?RHdKU3duYi9MT3M4VUd0NW9aUWdpMWlXL3JQSTZDQ0Q1R3RQUjJpTFg4Yi94?=
 =?utf-8?B?ZURlK2xBWEQ4MWtESkd5MTVsWW9vSVBNN2NhT0VBQy90a21HcHVya1BNZE1F?=
 =?utf-8?B?TWgrRThIV0hOQTNSZlZIRldtK0ZGOTl1c1dCZFZtUFp1Z1FwOHRySFUwbzBD?=
 =?utf-8?B?dlI4VlVTbEJHYm9rZ0Z3L0JheDZvL2RNYjEwTVcxM2d2YUxPY1draGhpQVRI?=
 =?utf-8?B?cHRzRmFybXMvQUJ1NUVWNTNKNURYNFJwTGVrMkJMaDlQM1Vrb2xSZlhsckR4?=
 =?utf-8?B?bXhJcnR4SnVyT2tkMm9BVHJSOWJFMTUxazhaeG5HdlVLQ2NkUmg1U294TXB4?=
 =?utf-8?B?akl1UHhUMStUOXBmemorNlFqZWhJdXBwWm1KU2NQZzBNSW1SWlpzY0p0Y1dS?=
 =?utf-8?B?dG5BT1Y1cXJnczFXVkRIU09SMFJxOVBrWEpaTnQ1dnFJVG41NGR6Zzlhc0xa?=
 =?utf-8?B?QmJDZ3dIS3RYV1YzakZBbVdiRlVXZmlnUWowZ2s5a2VWVWViQlZqSVNQTHY5?=
 =?utf-8?B?ckxQVUdXdFNlaWRYRnFITlFHK3dQSDBaLzNhMjZGYm0wdFFXNkcwSkhIZ3VP?=
 =?utf-8?B?cGlmUEtOMUFoSGxyNUJIblBiZzBOZUYydDZPbGxUZTdTNUNiNUk3SlNvdGJG?=
 =?utf-8?B?aVhrWHFoNDdMM1IzdExVU21wd2FveVdQK3VRLzZ3cElob2lMUzkyMjA2R2Yy?=
 =?utf-8?B?bjErUWN2bFhYVVZhdk5JNXpHNWtqUTdiY0Z6N2QwaGxZbU1BK0xjZlZ2OGxQ?=
 =?utf-8?B?M1JNRmdheG1SdUkzRW50TFgvQ0ZvQkwwM2VVUG9QM3NTSE5rYXdKSFUyMlJX?=
 =?utf-8?B?bUlxa3kwdlBtcUViWnNDeVJUeHQ5WU9NTnU5c3J4aGpZRVZVRjJwODhHMXI4?=
 =?utf-8?B?dG5tQXN1Z0F6NC9lQ2k0c1RFSVlITFpDa0lYT0E2MVgwQzJqWU96RW5rZENZ?=
 =?utf-8?B?RUl2S2FrS21XNTVNV3VscEVDaFpUWWNCdzd4REZldFp5WEJDenhyQzRFNzNI?=
 =?utf-8?B?SkJuQVZJT1NpeHYrcWdHN1JXWi83eHFpVXVzU21yeGVQcmJoY2V5K1ZadC94?=
 =?utf-8?B?eThBUUpER3JTa0dCTVNxaStHYVFxZFJGUmlHdDkwb2N5eC91cHM5Zk1ud0VT?=
 =?utf-8?B?WEJ5bWo1WnBBTzdYLzZ1UU12RjJSemN1RFVFdzJCdCtKYTFJcWtFb0s2OU9w?=
 =?utf-8?B?VEZSZm9qWFNobVlrbzUzQ2xvMThFbVBGUVFPcGVFVzNpNWhTdHhOeVU3Nk5a?=
 =?utf-8?B?Q0NuR1ZObVdET0huRHpzY05HTHJIMG5KY095UzRhUWN1L255dCtPeDRDM1Rx?=
 =?utf-8?B?QXVPelhRYWtiOFZwakpnSEtRa2VYb0o5ZXhEeC8xS2Y5TGZNUkhiV2kyemho?=
 =?utf-8?B?QXFqeFMxMExpOTBiWUIvY3dQUFUxcW03U2YyTDRsM0NueHE5NkJMbnJvNzJW?=
 =?utf-8?B?N2V5LzlvaFFNSENiVElScnFoQ2F6dUlicXovM1FwZy9HNkY5TWNDRnNEWHdr?=
 =?utf-8?B?c1N3T2pBVEtib2grUTVqamxMeWZHV1lsbXdzL1dmR0ZPdWluR3U1NHBvZHh4?=
 =?utf-8?B?ejJaMkIvM3U5NStDWVJSSkR3dzFPSG5JRmtQU0tMZWxRT2J2Z0JnRXpwUFpQ?=
 =?utf-8?B?MTQwU1F1clJpbVdrcm15WFIxN0tvczVvLzJrMHBvVGc2NGkraEF6U0ZyVi82?=
 =?utf-8?B?OTJHMzBOOVkyampDMnpvbjVKRG9DblpNL09BYWZ6M0JGRDJBUnFqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A3hsIbx/tP1kRN5HdTfLYE4O1LEVm65RwfERe6zVJ7xYzK+QgUJQFsy2s2TzvwGi0b39XBnA3Y21sMI9zIt2lf7GHUSe/v/Ty6vJTfJdz5sBmZ9OkIoKOuZGB6pzy+uAxdPSSoh6g+Jh1hSKVJWU8KwYVPzooyvzEBp7TCbXgmFKEpOMRvxU0++q/01rV/n+hbSlVop/mOTDFTUwms52YnVlTkol56vxrOlT359XtkUTo8VxZSHKz+RX9/g/Q0mMFQj6g3JlpJaiGnaSZ162xtCQVhoqy8YfWWKZS7J+wcSWZW9QlANw5uNKUwIq0BQddIugibReIH3hF2V53fHL8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fc74e4-a1f4-48b3-c484-08df4a6bca08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 20:44:52.0400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8wRt7LpwCIcXYNvcMHzcs0ibCaHTtEAuVWReOrZli7sPr12p+5ewvbh2EUWhJdahwU2AxHjGJIF+Zh0iqFWkDArwK8KwllRFtttcb59DLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF96964A2A1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29yYmEsIFByemVteXNs
YXcgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJl
ciAyNCwgMjAyNiA3OjI2IEFNDQo+IFRvOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT4NCj4gQ2M6IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueQ0KPiBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeg0KPiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lA
aW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IElsaWNoZXYsDQo+
IEtvbnN0YW50aW4gPGtvbnN0YW50aW4uaWxpY2hldkBpbnRlbC5jb20+OyBPbGVjaCwgTWlsZW5h
DQo+IDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6
ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCBpd2wtbmV0
XSBpY2U6IGZpeCBzdGFsZSBjYWNoZWQgUEhDIHRpbWUgYWZ0ZXIgYSB0aW1lIHN0ZXANCj4gDQo+
IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBLZWxs
ZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gPiBTZW50OiBNb25kYXks
IE5vdmVtYmVyIDIzLCAyMDI2IDg6MDUgUE0NCj4gPiBUbzogS29yYmEsIFByemVteXNsYXcgPHBy
emVteXNsYXcua29yYmFAaW50ZWwuY29tPg0KPiA+IENjOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8
YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBOZ3V5ZW4sDQo+IEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmthZGl1c3oNCj4gPiA8YXJr
YWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmc7IElsaWNoZXYsDQo+IEtvbnN0YW50aW4gPGtvbnN0YW50aW4uaWxpY2hldkBpbnRlbC5j
b20+OyBPbGVjaCwgTWlsZW5hDQo+ID4gPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+OyBLaXRzemVs
LCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggaXdsLW5ldF0gaWNlOiBmaXggc3RhbGUgY2FjaGVkIFBIQyB0aW1lIGFm
dGVyIGEgdGltZSBzdGVwDQo+ID4NCj4gPiBPbiAxMS8yMy8yMDI2IDI6MjUgQU0sIEtvcmJhLCBQ
cnplbXlzbGF3IHdyb3RlOg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4gRnJvbTogS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtl
bGxlckBpbnRlbC5jb20+DQo+ID4gPj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDIxLCAyMDI2
IDEyOjIxIEFNDQo+ID4gPj4gVG86IEtvcmJhLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtvcmJh
QGludGVsLmNvbT4NCj4gPiA+PiBDYzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5s
b2t0aW9ub3ZAaW50ZWwuY29tPjsgTmd1eWVuLA0KPiBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5
ZW5AaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6DQo+ID4gPj4gPGFya2FkaXVzei5r
dWJhbGV3c2tpQGludGVsLmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0K
PiBJbGljaGV2LCBLb25zdGFudGluIDxrb25zdGFudGluLmlsaWNoZXZAaW50ZWwuY29tPjsgT2xl
Y2gsIE1pbGVuYQ0KPiA+ID4+IDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6
ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIGl3bC1uZXRdIGljZTogZml4IHN0YWxlIGNhY2hlZCBQSEMgdGltZSBhZnRl
ciBhIHRpbWUgc3RlcA0KPiA+ID4+DQo+ID4gPj4gUHJ6ZW15c2xhdyBLb3JiYSBzYWlkOj4gaWNl
X3B0cF91cGRhdGVfY2FjaGVkX3BoY3RpbWUoKSByZWFkcyB0aGUNCj4gUEhDDQo+ID4gPj4gYW5k
IHRoZW4gc3RvcmVzIHRoZSB2YWx1ZQ0KPiA+ID4+PiBpbiB0aGUgY2FjaGVkIHRpbWUgdGhhdCBp
cyB1c2VkIHRvIGV4dGVuZCBUeCBhbmQgUnggdGltZXN0YW1wcy4gSXQgaXMNCj4gPiA+Pj4gY2Fs
bGVkIGJvdGggZnJvbSB0aGUgcGVyaW9kaWMgd29yayBhbmQsIGFmdGVyIHRoZSBQSEMgdGltZSBp
cyBjaGFuZ2VkLA0KPiA+ID4+PiBmcm9tIHRoZSBzZXR0aW1lL2FkanRpbWUgcGF0aHMuDQo+ID4g
Pj4+DQo+ID4gPj4+IE5vdGhpbmcgb3JkZXJzIHRoZXNlIHJlZnJlc2hlcy4gVGhlIHBlcmlvZGlj
IHdvcmsgY2FuIHJlYWQgdGhlIFBIQyBqdXN0DQo+ID4gPj4+IGJlZm9yZSBzb2Z0d2FyZSBjaGFu
Z2VzIGl0cyB0aW1lLCBiZSBkZWxheWVkLCBhbmQgdGhlbiBzdG9yZSBpdHMgcmVhZGluZw0KPiA+
ID4+PiBhZnRlciB0aGUgcmVmcmVzaCB0aGF0IGZvbGxvd3MgdGhlIGNoYW5nZS4gVGhlIGNhY2hl
IHRoZW4gaG9sZHMgdGhlIG9sZA0KPiA+ID4+PiB0aW1lIHVudGlsIHRoZSBuZXh0IHBlcmlvZGlj
IHVwZGF0ZSwgdXAgdG8gNTAwIG1zIGxhdGVyLiBUaW1lc3RhbXBzDQo+ID4gPj4+IGV4dGVuZGVk
IGluIHRoYXQgd2luZG93IGtlZXAgdGhlIGNvcnJlY3QgbG93IDMyIGJpdHMgYnV0IHRha2UgdGhl
IHVwcGVyDQo+ID4gPj4+IGJpdHMgZnJvbSB0aGUgb2xkIHRpbWUsIHNvIHRoZXkgYXJlIG9mZiBi
eSBhIG11bHRpcGxlIG9mIDJeMzIgbnMuIFR3bw0KPiA+ID4+PiBjb25jdXJyZW50IHRpbWUgY2hh
bmdlcyBjYW4gcmFjZSBpbiB0aGUgc2FtZSB3YXkuDQo+ID4gPj4+DQo+ID4gPj4+IEZvciBhIGZv
bGxvd2VyIHRoYXQgc3RlcHMgYSBsYXJnZSBpbml0aWFsIG9mZnNldCB0aGlzIG1ha2VzIHB0cDRs
IHNlZQ0KPiA+ID4+PiB0aGUgb2Zmc2V0IHJlbWFpbiB1bmNoYW5nZWQgYWZ0ZXIgdGhlIHN0ZXAs
IGZvbGxvd2VkIGJ5IGEgY2xvY2tjaGVjaw0KPiA+ID4+PiBmYWlsdXJlIGFuZCBhIHNlY29uZCBV
TkNBTElCUkFURUQgdHJhbnNpdGlvbjoNCj4gPiA+Pj4NCj4gPiA+Pj4gICBwb3J0IDE6IFVOQ0FM
SUJSQVRFRCB0byBTTEFWRSBvbiBNQVNURVJfQ0xPQ0tfU0VMRUNURUQNCj4gPiA+Pj4gICBjbG9j
a2NoZWNrOiBjbG9jayBqdW1wZWQgZm9yd2FyZCBvciBydW5uaW5nIGZhc3RlciB0aGFuIGV4cGVj
dGVkIQ0KPiA+ID4+PiAgIHBvcnQgMTogU0xBVkUgdG8gVU5DQUxJQlJBVEVEIG9uIFNZTkNIUk9O
SVpBVElPTl9GQVVMVA0KPiA+ID4+PiAgIHBvcnQgMTogVU5DQUxJQlJBVEVEIHRvIFNMQVZFIG9u
IE1BU1RFUl9DTE9DS19TRUxFQ1RFRA0KPiA+ID4+Pg0KPiA+ID4+PiBJbiB0aGUgZmFpbGluZyBj
YXNlIHRoZSBvZmZzZXQgYWZ0ZXIgdGhlIHN0ZXAgd2FzIGV4YWN0bHkgNTg2NyAqIDJeMzIgbnMN
Cj4gPiA+Pj4gcGx1cyBub2lzZSwgaS5lLiBvbmx5IHRoZSBsb3cgMzIgYml0cyBvZiB0aGUgdGlt
ZSB3ZXJlIHJpZ2h0Lg0KPiA+ID4+Pg0KPiA+ID4+PiBIb2xkIGEgc3BpbmxvY2sgYWNyb3NzIGJv
dGggdGhlIFBIQyByZWFkIGFuZCB0aGUgc3RvcmUgb2YgdGhlIGNhY2hlZA0KPiA+ID4+PiB0aW1l
LiBXaGljaGV2ZXIgcmVmcmVzaCByZWFkcyB0aGUgUEhDIGxhc3QgdGhlbiBhbHNvIHN0b3JlcyBs
YXN0LCBzbyBhbg0KPiA+ID4+PiBvbGRlciByZWFkaW5nIGNhbiBuZXZlciBvdmVyd3JpdGUgYSBu
ZXdlciBvbmUuIFRoZSBsb2NrIGlzIG9ubHkgaGVsZCBmb3INCj4gPiA+Pj4gdGhlIHJlZ2lzdGVy
IHJlYWQgYW5kIGlzIHRha2VuIGJlZm9yZSB0aGUgR0xUU1lOX1RJTUUgbG9jayB0aGF0DQo+ID4g
Pj4+IGljZV9wdHBfcmVhZF9zcmNfY2xrX3JlZygpIHRha2VzLCB3aGljaCBpcyBuZXZlciBoZWxk
IHdoaWxlIHRha2luZyBpdC4NCj4gPiA+Pj4NCj4gPiA+Pj4gU3RlcHMgdG8gcmVwcm9kdWNlOg0K
PiA+ID4+PiAxLiBDcmVhdGUgUWluUSAoODAyLjFhZCBvdXRlciwgODAyLjFRIGlubmVyKSBWTEFO
cyBvbiB0d28gZGlyZWN0bHkNCj4gPiA+Pj4gICAgY29ubmVjdGVkIEU4MTAgcG9ydHMuDQo+ID4g
Pj4+IDIuIFJ1biBhIFBUUCBsZWFkZXIgb24gb25lIHNpZGUgYW5kIHB0cDRsIC1zIG9uIHRoZSBv
dGhlciwgd2l0aCB0aGUNCj4gPiA+Pj4gICAgZm9sbG93ZXIgUEhDIGFib3V0IDcgaG91cnMgYmVo
aW5kIHRoZSBsZWFkZXIsIGFuZCBydW4gaXBlcmYzIG9uIHRoZQ0KPiA+ID4+PiAgICBWTEFOLg0K
PiA+ID4+PiAzLiBSZXN0YXJ0IHRoZSBmb2xsb3dlciByZXBlYXRlZGx5Lg0KPiA+ID4+Pg0KPiA+
ID4+PiBUaGlzIGlzIG5vdCByZWxpYWJseSByZXByb2R1Y2libGUsIGFzIGl0IGRlcGVuZHMgb24g
dGhlIHBlcmlvZGljIHdvcmsNCj4gPiA+Pj4gb3ZlcmxhcHBpbmcgdGhlIHN0ZXAuIFdpdGggYSAy
MDAgbXMgZGVsYXkgYWRkZWQgYmV0d2VlbiB0aGUgUEhDIHJlYWQNCj4gYW5kDQo+ID4gPj4+IHRo
ZSBzdG9yZSwgMyBvZiAyMCBydW5zIHNob3cgdGhlIHNlY29uZCBVTkNBTElCUkFURUQgdHJhbnNp
dGlvbiBhbmQNCj4gPiA+Pj4gU1lOQ0hST05JWkFUSU9OX0ZBVUxUIHdpdGhvdXQgdGhpcyBjaGFu
Z2UuDQo+ID4gPj4+DQo+ID4gPj4+IFdpdGggYSByYW5kb20gZGVsYXkgb2YgdXAgdG8gMTAwIG1z
IGFkZGVkIGF0IHRoZSBzYW1lIHBsYWNlLCBhbmQgNA0KPiA+ID4+PiBwYXJhbGxlbCAicGhjX2N0
bCBhZGogMSIgbG9vcHMgcnVubmluZyBmb3IgMjAgc2Vjb25kcywgdGhlIHN0b3JlZCB2YWx1ZQ0K
PiA+ID4+PiB3ZW50IGJhY2t3YXJkcyA1NzkgdGltZXMgaW4gMTUwOSBzdG9yZXMgd2l0aG91dCB0
aGlzIGNoYW5nZSwgYW5kIDANCj4gPiA+Pj4gdGltZXMgaW4gMzk5IHN0b3JlcyB3aXRoIGl0Lg0K
PiA+ID4+Pg0KPiA+ID4+PiBUZXN0ZWQgb24gRTgxMC1DLg0KPiA+ID4+Pg0KPiA+ID4+PiBGaXhl
czogNzdhNzgxMTU1YTY1ICgiaWNlOiBlbmFibGUgcmVjZWl2ZSBoYXJkd2FyZSB0aW1lc3RhbXBp
bmciKQ0KPiA+ID4+PiBSZXZpZXdlZC1ieTogTWlsZW5hIE9sZWNoIDxtaWxlbmEub2xlY2hAaW50
ZWwuY29tPg0KPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBQcnplbXlzbGF3IEtvcmJhIDxwcnplbXlz
bGF3LmtvcmJhQGludGVsLmNvbT4NCj4gPiA+Pj4gLS0tDQo+ID4gPj4+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuYyB8IDEgKw0KPiA+ID4+PiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmggfCA0ICsrKysNCj4gPiA+Pj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgICAgIHwgOSArKysrKysrKysN
Cj4gPiA+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4+Pg0KPiA+
ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFw
dGVyLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuYw0K
PiA+ID4+PiBpbmRleCAyMDdlNGZlOTdiZTcuLjk4NzQzODBiNjQyZCAxMDA2NDQNCj4gPiA+Pj4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmMNCj4gPiA+
Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9hZGFwdGVyLmMNCj4g
PiA+Pj4gQEAgLTkxLDYgKzkxLDcgQEAgc3RhdGljIHN0cnVjdCBpY2VfYWRhcHRlciAqaWNlX2Fk
YXB0ZXJfbmV3KHN0cnVjdA0KPiBwY2lfZGV2ICpwZGV2KQ0KPiA+ID4+PiAgCXRpbWVjb3VudGVy
X2luaXQoJmFkYXB0ZXItPnBoYy50YywgJmFkYXB0ZXItPnBoYy5jYywgMCk7DQo+ID4gPj4+DQo+
ID4gPj4+ICAJc2VxbG9ja19pbml0KCZhZGFwdGVyLT5waGMudGNfbG9jayk7DQo+ID4gPj4+ICsJ
c3Bpbl9sb2NrX2luaXQoJmFkYXB0ZXItPnBoYy5jYWNoZV9sb2NrKTsNCj4gPiA+Pj4NCj4gPiA+
Pg0KPiA+ID4+IEkgdGhpbmsgdjQgb2YgbXkgdGltZWNvdW50ZXIgc2VyaWVzIGZpeGVzIHRoaXMg
YmVjYXVzZSBlYWNoIHVwZGF0ZSBpcw0KPiA+ID4+IHByb3RlY3RlZCBieSB0aGUgcGhjLT5sb2Nr
Lg0KPiA+ID4+DQo+ID4gPj4gVGhlIHBlcmlvZGljIHVwZGF0ZSB0YWtlcyB0aGF0IGxvY2sgaW4g
aWNlX3B0cF91cGRhdGVfY2FjaGVkX3BoY3RpbWUsDQo+ID4gPj4gYW5kIHJlYWRlcnMgZ2V0IGEg
Y29uc2lzdGVudCB2aWV3IGJlY2F1c2Ugb2YgdGhlIHdyaXRlX3NlcWNvdW50X2xhdGNoLg0KPiA+
ID4+DQo+ID4gPj4gVGhlIHVwZGF0ZXMgdG8gdGhlIGNhY2hlZCB0aW1lIG9ubHkgZXZlciBoYXBw
ZW4gdW5kZXIgdGhlIHBoYy0+bG9jaw0KPiA+ID4+IG11dGV4IGFuZCB0aGUgcmVhZCBmb3IgdGhl
IHRpbWUgdG8gc2F2ZSBhbHNvIGhhcHBlbnMgdW5kZXIgbG9jay4gVGh1cywgSQ0KPiA+ID4+IHRo
aW5rIHRoaXMgcGF0Y2ggc2hvdWxkIG5vdCBiZSBuZWVkZWQgd2l0aCB0aGF0IHRpbWVjb3VudGVy
IHNlcmllcy4NCj4gPiA+Pg0KPiA+ID4+IERvIHlvdSBhZ3JlZT8NCj4gPiA+Pg0KPiA+ID4NCj4g
PiA+IFllYWgsIEkgYWdyZWUuIG9uZSBjYXZlYXQgdGhvdWdoIC0geW91ciBzZXJpZXMgdGFyZ2V0
cyBpd2wtbmV4dCwgSSB0aGluayB3ZSdkDQo+IG5lZWQgdGhpcw0KPiA+ID4gc3RhbGUgY2FjaGVk
IFBIQyB0aW1lIGZpeCBiYWNrcG9ydGVkLCBubz8NCj4gPiA+DQo+ID4NCj4gPiBGYWlyLiBUaGUg
cHJvYmxlbSBpcyB0aGF0IG90aGVyIGZpeGVzIHdlIGhhdmUgZm9yIFBUUCBsYW5kZWQgb24gbmV4
dCBhcw0KPiA+IHdlbGwsIGFuZCB0aGUgbWFpbiB0YXJnZXQgY3VzdG9tZXIgSSBoYXZlIGlzIGdv
aW5nIHRvIHRha2UgdGhlIHRyZWUgdGhhdA0KPiA+IGhhcyBhbGwgdGhlIGZpeGVzLiBUaW1lY291
bnRlciBpcyBhIGJpdCB0b28gYmlnIHRvIGJhY2twb3J0Lg0KPiA+DQo+ID4gSSdtIG9rIHdpdGgg
YmFja3BvcnRpbmcgdGhpcyBmaXgsIGJ1dCBpdCB3aWxsIHByb2JhYmx5IGNhdXNlDQo+ID4gY29t
cGxpY2F0aW9uIG9uIG1lcmdpbmcgYmVjYXVzZSB3ZSdsbCB3YW50IHRvIGRyb3AgdGhlIHVubmVj
ZXNzYXJ5IGV4dHJhDQo+ID4gbG9jayBvbmNlIHdlIGhhdmUgdGhlIHRpbWVjb3VudGVyIGZpeCA6
XA0KPiA+DQo+IA0KPiBZZWFoLCBJJ2Qgc3VnZ2VzdCBsZXQncyB3YWl0IGZvciB5b3VyIHRpbWVj
b3VudGVyIGFuZCBsb2NrIHNlcmllcyB0byBtZXJnZSBhbmQNCj4gbm90IHB1bGwgdGhpcyBwYXRj
aCBpbg0KPiBmb3Igbm93LCB0aGVuIHdlIGNhbiB0aGluayBhYm91dCBiYWNrcG9ydC4gSG93IGFi
b3V0IHRoYXQ/DQo+IA0KDQpTb3VuZHMgZ29vZC4NCg==
