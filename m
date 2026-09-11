Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CFFC88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 21:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 488276061A;
	Fri, 11 Sep 2026 21:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PecDHFwJzziT; Fri, 11 Sep 2026 21:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 64B486060A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789160417;
	b=EhxazX2a5Iq8OYVpb29P7bVh3DlunT8k7avnC1pJmpQCsLvHAsCZAPnXcfl0EO7gBca4
	 zY9OYUB+hOyiYjNu0Y9u+efLOEzAwiWelWy3L7FCpTOpsmXUBv+uX56aP45MMkOviZkjn
	 V/UUfA7R0iU7npC68vGn8Cdeh7w8CKhVW087yxr3tVghe+c0VMC8prWBpe4JxfjxvCsz/
	 s3JggHhWXHAc8UYXxVsbEFyyMEeB7h+REYDDC9S/7uvQNwpyBYA9Y+YSGuRQntcY8tUwN
	 hX1Mjcv/bBmKq5HZGg3fQO2Ye5BR2N1wsIgEqURfHHLTr3T/+BtFcRRu1Z7VvqJzEjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160417;
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
	bh=kcBCzC1gSCAHNQUBlY5MlcgI/dlYqN/yZars44cRTY8=;
	b=Pgiv+Z0i8pXrUitm7Aho2AVehcVRlXh2jdgVCKaSerJf5A2B8rhDAdMLDcYJdKLMGqY/
	 OoNq/qMxQt2rZ7pLcYh/LaiakN9bUp5nYOdRxndhFM1BcF+t5qMuAI9xXmASvI9zDnPHj
	 kQnjpRLue1LDp875Qa/c/Fm0J3NInY+u8IvAuo9KScVHcha5/rfZtK3306uXRkJBd/AgP
	 6hi0rE8bWyH/CEzotUn5Qap+IJpgPgZ05dvtXxtMW6dmj2yvC/4ZlcEYDjGRIAfJmSdPb
	 7lfLNZUjdN8keUucI2WuvruC4q79X3z6OBSWyGW3k/Xk7AjyGsfXF6ZQYYrKb1VVukw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789160417;
	bh=kcBCzC1gSCAHNQUBlY5MlcgI/dlYqN/yZars44cRTY8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZ1PsM+fX+isR8mzQw+tTrQGPrvjJ2LQ961XOjMlAn6blPSBokGHybyxEfG0VvQE+
	 hTOyo7awwRH0ax3xAKSNXBfUq6bubG3h0XSgRnFSZd6aKQQjZxC+81btYwy97LGa+/
	 EdRoePigLoqngdsdFYIX+J3pmdy9vYUOBHXgHvE/jtRUs1MFQch4YRBmSrBrwGffiv
	 /qgsnR3edZvRPUm+BU+T08FwBMHtJoivJlyMzaRae6A7LSBkvVD+1si/bFIVtIbBm0
	 2jDrudv/ghBNHyviNr1ThhbUaixzAbRrSHZZyrxjOUaJ5xpEYGCHSP49BN4jiOpFjM
	 hpTiN88p7yTDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64B486060A;
	Fri, 11 Sep 2026 21:00:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A5EA49D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BDAC40611
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYYQK9q239FE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 21:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E5E5D405BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.4
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160415;
 b=lyhXMX2suWr8B1OQanqhX77nEvIdW7LhaG4Ceil52JVXf5nEHk9Kp/4WsGCp4+0qBTAe
 qda0nq4V9uNfVHXtqgosUBoEnUXmFLi/sn9RsWVUNEGb6zQqX88RxsNWeaKEQybSZsGUf
 yjhE/9bAKY8ISWieJni0QJaiFhHortmr5fwxqdx8hlBWpT0oWPffMoeoer6srDcMDSSxf
 qByrAiQXwN4A+lsEG7nyn5OVlKhVF+u3m9z05MdWRvf7SDyRkzKc38Wk9o48lxnPey1jP
 k/sUxCfD39WFqRR+x9ElLgPoWYq5mZ0F4T84PNbtcCZmwxN+CXiTAce7+v4X1n4dfAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160415;
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
 bh=kcBCzC1gSCAHNQUBlY5MlcgI/dlYqN/yZars44cRTY8=;
 b=cA7rmg2IiwTSiaTuQgKKp1+HZ1/ujchsKKRV7m2nto/uiEBVRgAN/a+fujijMq5nyV8v
 ht0+pnT6l9THjSBkR0aGcQAeT5/43U3P5FH6LcBGSTYTZzQzkj0t0o4ZQLvdD57SBHjDm
 7jkige3LsB+hLRlCyDjMIzJLzaOFomRRS4Jmd4lUW3MFfHCGBhFyIzVEUbbzgFe/4GZTH
 zhmP/YPr2T9nrE/8sC5l7Cy390VChwwRfcrcFLCpo1IRz0zbfyMMW0EFcPL6JBIFP17cz
 dilr9BJeyTecN37EuVgdshSNWwsf4hZo2jQ+7WMkBB330KVnIcgUyU/8SnTBPZ/9qAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RKCYCf0T; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.4
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RKCYCf0T
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5E5D405BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789160415; x=1820696415;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=un36KDzLrvrPMyvoqFi5hR78XihV4TLABIe90s8Y3G8=;
 b=RKCYCf0TtDxolx2/CnZ6iNVRxeAAS8cabExI4Gy79iJxXphxUPcH0JTu
 vM5b4foeDodil0ZYJfueHNWjYqibkgMiKDAzhn00Q/6ehqvRoQdCdhn2O
 5evfVZZ0LbRhH+ABd3Cd0VxsCvP9297zWJsU+ffmI1GhcakAR1ES4Jg19
 45GIc4+xtOU0gSXpDpaDxcS+b5X8ZdtPXCUPwmXUUdVaUk/oAb83xwv5A
 5XDALz+Fmj81C6CDA6o8sJ0ppsA2Z+s+xq5qScPPSlZRgdtL9Bn8O3lQq
 /s2JdDGOwmYo4D91acQKBpdjqlhBCyGb1MwhniWIjRvmCksJejXRlLLQ1 w==;
X-CSE-ConnectionGUID: qUhn8bqFTXC8dWFXWGODzQ==
X-CSE-MsgGUID: DzsH9JIIR2uHugY4lK6RcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="139276"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="139276"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:00:01 -0700
X-CSE-ConnectionGUID: jdbD4sB6SraKDE3kY7knYw==
X-CSE-MsgGUID: UBh8/P4dSbu4jIel7QDGIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="275776428"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:00:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:00:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 14:00:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzWZTHnQ/pp38mMUqAxW1dgLTR5jdhQtbBUdieVm9CCbJJoaqYWv2bHx2oOLKZhhur02hmws8tD28UDHA8RZYnHJ1oCFryB7P2WMWafFSNt+XlSHHPX4MLcBLLCVoP8jdcbBm/b0s450GXTBijy9T5oL681xzMqey/ADp9OY0jJsEtftwexl4hyjJNMVjv2opXkOqYwsJ2sjuMxZeei/3VkTdwUITVmKFuyFsl8bzZrbVBVmc5RDJcy0W79/FzwC4i59UVtmn3jTItUtd3Hci7bXQ7HHkItYy/wWsY4IV4OuHXl2i13bye0Dc6TxabX17QyOG8aksmclE4Jvulpw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcBCzC1gSCAHNQUBlY5MlcgI/dlYqN/yZars44cRTY8=;
 b=rqaGJrB05luVm8Y3AFli8OmmcekJcCoNGgP5un1sM3HTCQqGcXdLlZ0/F8AhYqBimXalG4ZZhSCivDusMhgQ8zQDFcwFAdKxfS51mCNRiwWD2WsuBPuqTi6Dk/cm6T0rzBR+M3nPqb5PP/VEu3akxsAFl/RJUcik6uyMpVJMte2y2w7s4L4A4TPrM8+9KbvbDxrzHAvy/e3h24guHXAsul5GSOyfVcu77hJ0zMJ5VUhQ/e7jtMPS5knwf7tLREhx4qhJgw2T94UFFbw2SJq8u65rHHj9JhqpON5Hfi0pL6sPZe56F9fCjYgrtlkqiw8OkqIAl4X+8LoPMVAyb8Neww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 20:59:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:59:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
Thread-Topic: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
Thread-Index: AQHdP6S9OtUIOkBngU2xLCAeq2zA87bJ4aTA
Date: Fri, 11 Sep 2026 20:59:58 +0000
Message-ID: <IA3PR11MB8986CB5E593515DABDB76727E5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <20260907095446.27290-2-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-2-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 6c3ea570-eae6-4fd4-8c29-08df1047a393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: OFHvxpHMh9aMNn6hemgys5WOUAzaO69pu7/kHIJ8M/UPfHAG1xrDzW/9tb67Oeco+npRW/W/DK8sTeuAoP7rxJXXmkskDJEfFPvnm0Xp1izHIbYxqAxP5sM+r+FLESgsQW3Xk2d5m4UkIecjNg01jNmXBniRlG4/rX/Wpzw3PUF+4gi/fsLRVMY4wPEvzZqflhY9ak73KogHKmCzZ7pGVVWukWVuUdO5LWYootJXoNE6th99a0j6ppxJD2SaHcNfE7NRLLi+6WYcndcjs2FRN6f/x5lvjwCYwr8/rNXMyaxqnRz3MJ181VoZsnSeXx0P2wfiu2URwjN1BJ+P1ONuti5zjsz/S6UA7VRRlpJkWNr7K7NhCu0+ybdkCT1L/4hF7JM+aGLKgaN0w5Wqr+IsNyvfqlpDk5BUDdBM6KIWOrp4JUL1+V3ONl756cCoYnu742ocQZm8Ki4Isrk4Uq+pQ8SEJqN3Lb+cGxezSK6lK8W8pvdwW0ue8r1ZXliQqq7xpgeoWN3NIEO/H6EY1h8Z9gux0rrbgtmD/9diUgLr9uT4Vd2+wPtYMISRfFtQwyR6FL3MXWLU+1C5tGbfj3FrA0Xnozv528A98tS94DFraeOrMzEjjgM/odIr8TfCKJGx/D88DNG0A3DZMgbB0/hP2fau3kkhFFVnJlik06kRP8OzAVFzqhmxtdxuCGhQwwz/Z++UXr6zieK4HTlxaaUQ3H1NKDbyVlXbZzML1IKwswI16PzYBmmu26MhIsqYQrgr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ySSkPkpmV+UDymFAskwAbZFNtwL4b0vvzg4PFau+ysPchtaBea46gsn1kqtc?=
 =?us-ascii?Q?+DbpJF0Mlswog6jNQ5wFQt5IHge4I1aRg9u1ryVhOkfOjHbQxU06UB5ZSLkO?=
 =?us-ascii?Q?N3Fa7YL4eO5JmhKctp07JP3O3Xw89G3OreViLkLt1dto4vf4H4ww7zxWuIJs?=
 =?us-ascii?Q?D1t0zX9O3XJgPXfP7ZKVYhrGNkMYo+JhAwihZ17yM/C1VC8aLWa6v0JzeN5q?=
 =?us-ascii?Q?YdXsAcWjT9LaRV9tgPowZwMQFSthRaqLzaNWkOad9YK2/tgJ+i7pn/pOJknI?=
 =?us-ascii?Q?nqLsGzU+YE6gOcQcoLTjjbAm0T7zpQ6sd3eGwayHfUZlgVBGcEURPH6UYsS2?=
 =?us-ascii?Q?t0Ftolkn+OGmbgcNSivhlujQs2XKgQcy7iBNuivi31qkWCv4rgq1n2s2il4F?=
 =?us-ascii?Q?bkdKKm1ECejpyFwYCf70se82fWEgFMXzNs7mMxhmQLYvk7Twd+6DAv7AlwbF?=
 =?us-ascii?Q?OTHS3gEDAVqPNEhv8SGAMe6N2P01SdkLQ6Yod0seSk2khfrVWUKmEbqb/M6v?=
 =?us-ascii?Q?1aSmz6TC368xFXuhEA8oj9QEJxfhu5yyawsZwxgzzaukjzqj8YLB5zp5F0UJ?=
 =?us-ascii?Q?nGEaLHlg54uk0HZS2ZpM5QB/bKLjyWOJeFxLuw/vN2YVKNCN/jXw9pCulZIF?=
 =?us-ascii?Q?wlq2qwwPSLU3aVDHPSeWoLXfx7PSDryxi1I+8JdBC+5Ktr4qfXQE+Y9P8HcQ?=
 =?us-ascii?Q?ljCU4ZcnYvU0zHEEzf0s1Ji/0Tn67iAeMo+pSYo7dyeyDuEl+Ww1oLiwy0Dc?=
 =?us-ascii?Q?GNkXT2mNQj4GP/WLWsX3tW75tOOuorBq7RZbmxzr6KCVuhAwGhWcOLPBxRU+?=
 =?us-ascii?Q?WEOvVvelZLmkrGnONJc3OcpV9/SsTqIv4ozKS7+5fKY0k83CpI98qmhL7TZu?=
 =?us-ascii?Q?NRwL59SzGhXf1sWiPtQTTl+cODYLF5+3Ry6+MPrAZURLJ+omsnTxAS/PIuJs?=
 =?us-ascii?Q?idHlEDHz28WQtNr+GSqW++8gzUEFCb9ashjziP08v3B5uWWsdVzg0bZ5GVDg?=
 =?us-ascii?Q?IsUcjcsuy8tOvkvpuKvRgP9lo5/AiXcdRBercj1rdxTDMFbtEHgvsZZGqP3V?=
 =?us-ascii?Q?jX/kXynpwHqDsZYJB/4dOwW6MBADhBmHv/6v9GxJvjssk52NbdpjL2Bw+avm?=
 =?us-ascii?Q?qClX1zZnfiRuwA7KBHNj35ejkSC0YXCNRf9rY0q0HhxI5blIL19LGj2uR6/5?=
 =?us-ascii?Q?NBWt1LphODsnDT5Q2OhpkFDb+44SLaKids397QRI/f2jSxc3fG+j8JEbH1zk?=
 =?us-ascii?Q?cBsXSBV3fQLjOrHFrYTZHmiOPh99lFr/yDVYX8Jnfl8GpaEX9NZxLP3nV1H0?=
 =?us-ascii?Q?JM0cEkR/qVl7SN4cq7pZQ7s87SqOQ6FyYFPxib6ubrdi+lyz1oG89dyV+yuU?=
 =?us-ascii?Q?dy2u9JDcNWGCXZnMXZ0bLth0+E6bGdEgbf6BkBE0GfgctMnr6lDalHELpVjG?=
 =?us-ascii?Q?VY/Xpk2o7m6hvwaF/qsfWhZ8ypN8ilF9xzbpsvDVRJC3CFObXpEHnECH0zvZ?=
 =?us-ascii?Q?3TGUvzxofDsnknkmjo4p45rhFK0x98s5Uesb9CBgyRk6DDlQ4oyNHmN7oBkt?=
 =?us-ascii?Q?5F03SkxN1F7Mml08iUcVYHvc6IJ104H6zWJyvV4D04z2CytDX2S3MQ/jhLsb?=
 =?us-ascii?Q?cOt6UR2ig23BtJpAeafjy1enqROgu/itFsMzPgIyMk4h/SbFD0v6nGGitxaH?=
 =?us-ascii?Q?NBbLDLw0Vqh1twTa28SQHd2rPOIyUPJQhVyIIvxbkNPXFHPHTvcmzfXsD80O?=
 =?us-ascii?Q?wmbNK3wRyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PzKG359IUBXNVc3VxNojnBoLQ+OZgzwibfCBas8SvtqXkeyH2FL8RnJgyyh+rgs/PdCwym5WZojLARGBCaiC7qBGCmVoS10Ofz+qSdRoHA0pe4bR8WgDL2v4PwN7SVomOJmLJ5Fw1WaGIP0cvxUfEwAMJ0gdE11et72c6mEf77r3Sjc2GtTmLNUoQEjlvPwScwZF93zER24VPyHVa97hlsXm3Osj9DFfuhoTLhSpIYg1CrRGRojCK8IUIPTzFF6neSgyN9W8khG7H2hFrRDuBfv0xKQyGdHexbIigTldbEJwMZM8WRlnrigZzvWthzFluCK2OuMMCPvZZOPyLtXzBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3ea570-eae6-4fd4-8c29-08df1047a393
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:59:58.2093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECcjrum+n3wFnqF7FkaEDtEbBmf4CekQhDckjBXNOMJFtOnTiS9pXnuTjv2Tcfzw/OLLV5gcsxOEOtjwuJkBg6wLER+wfpkccaz3JqFSK8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655
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
> From: Hemanth Selam <hemanth.selam@gmail.com>
> Sent: Monday, September 7, 2026 11:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Randy
> Dunlap <rdunlap@infradead.org>; intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: [PATCH iwl-next v2 1/4] i40e: fix typos in comments
>=20
> Fix typos in comments, found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt. Only touches comments, no
> code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>=20
> Notes:
>     v2: designate the patch to iwl-next and use a subject prefix
> naming the
>     component, as maintainer-netdev.rst asks; v1 went out with a bare
>     [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff
> unchanged.
>=20
>     v1: https://lore.kernel.org/all/20260907064528.6602-1-
> hemanth.selam@gmail.com/
>=20
>  drivers/net/ethernet/intel/i40e/i40e_common.c  | 2 +-
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c
> b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 8dadfef2c09f..026b35e5a000 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -676,7 +676,7 @@ int i40e_pf_reset(struct i40e_hw *hw)
>  	grst_del =3D FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
>  			     rd32(hw, I40E_GLGEN_RSTCTL));
>=20
> -	/* It can take upto 15 secs for GRST steady state.
> +	/* It can take up to 15 secs for GRST steady state.
>  	 * Bump it to 16 secs max to be safe.
>  	 */
>  	grst_del =3D grst_del * 20;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc74..ef9d1e78c16a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2614,7 +2614,7 @@ static u64 i40e_eeprom_test(struct net_device
> *netdev, u64 *data)
>  	netif_info(pf, hw, netdev, "eeprom test\n");
>  	*data =3D i40e_diag_eeprom_test(&pf->hw);
>=20
> -	/* forcebly clear the NVM Update state machine */
> +	/* forcibly clear the NVM Update state machine */
>  	pf->hw.nvmupd_state =3D I40E_NVMUPD_STATE_INIT;
>=20
>  	return *data;

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

