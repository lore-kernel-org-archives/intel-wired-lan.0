Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E4606C5C2
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gV0QPztM;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CdwgfQfV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5333C405DE;
	Tue,  3 Nov 2026 10:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0KSR36YTDVN; Tue,  3 Nov 2026 10:39:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5EFB40536
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793702381;
	b=RY1JL1EMwMGnkp+xGmMLYKdao/ZRzTwBwCWPKlrk3tRyI3us3E8xItSmUGZ4jeXWRIoE
	 uCnd0PJ7R+JnCizAeqhycYvA0shnU2Tc7N53xWMUJ0y3OMWK0xsasb3IBirdAVdOOEvVP
	 zl0gf/mM0kzKaC7cJ7ApeDI83xpgCf7KYX13A4vNHtjQVbCOUt8XEnSAnJWuuYKwrNzv1
	 RSbaAIlBbXwjoNE2pXNVJlPtJRMlO6RXsAmc/4gPYPcssboo9B7iFXpL2KGeIOTM3BysK
	 i5aZCuEuItBwuCPM9JsGneUb9MAkzFYVvNDCcWWGaV/FJGapmxk2fyEGXNwRVjBGUjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793702381;
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
	bh=w44HgB3qZ7ctGcLZzFLXNGP1UikK7e2tV75W+AgMDQI=;
	b=gdpPIfQDzaojzG/P18coo2WCMCQcU84atwU/IVEpljLlJiJBDgLiwA7cvQZ8ST3CqooM
	 +pYlbi1UPBogZGyJ6RBs0XV5tAzLzmXS/c6tIkiMP4ouiSqVtKaMBLVnizLjV5CZr70AZ
	 aoIvj75aJaSKhWzBecEAHMmk9herwbR7loPp/7elEuUDCxVLYJIUZA/RSrh2uvbyJrYQB
	 ckBxQO0/JCGbLhldABRcIIF4GANgxYpTaDjnoUNbcQzFeILshE3KTD/nPE9rim+CjLXS3
	 bmbAGNmOwTM8OK6tpvJ0gerIwpq8nxzX/t/7XNkI/3A+oOYqBw/3uakRdvcIDcwCKJQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CdwgfQfV;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793702381;
	bh=w44HgB3qZ7ctGcLZzFLXNGP1UikK7e2tV75W+AgMDQI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gV0QPztMcGbSKoJ/MRPQUezz/cCyQNSyLZxaaSo/sWu0+RyV7lOD4WZQF7/UwUm4x
	 mCj7KD2NsPX/fmm6slMa4Ma4G6WJ/32k4R6xKBsDNEX0swPESNIYh142/JNxJ/teph
	 LWGZxS0Je49Do/xNmtRvw+LUvEhD2IoLXbYIVcna3MIeCXrDdbVG+E6E4trlNt+QIf
	 PWxYxUT13O5lRhcd1Z/Qf/Kk4BgQcL97s2Y5keBFHLDDFAmCyc97hWCOUm3r9k5ApW
	 3xDeFcxiG3I/1dnonRj2OkTNbQlljAUoQOaLXkRD24pjs5IrNURZb08PR9liEBKLJD
	 aVj/b/jATumRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5EFB40536;
	Tue,  3 Nov 2026 10:39:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 749BD435
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 668954056C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2839a3djiRY for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 10:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B00F40535
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702379;
 b=r9qYdq+oFkTVhbMVCJOJUg39sa/jZ9150ev1sLg0tJk9/tUiaxIzSCnrH2VFIjkSF5FO
 0aZNWY7x5h0yesQ6rO0CshXhIA8FJljVA+akhymREF08BWO/l12WUtVMi2HMBazYEHxAo
 Nu9YFPn+M4twbUlqajrpJ7n6X1iNXzTTb/d+xElIYz9QgPHtM1f2ngLss9WwakRdvUT/g
 Uz3cuIYab/ugGS003SVPyyqtLb7ldFQp/FBQEuKqHe4ChGALRCdp5ucxtOl/u9hKwYXuo
 Y0/Vt+Eq2cB+wi8IWaLUwgnHuLy2s8YplfCCSR1K/CuSilYdIf18A/8e/ZBrEdZpMnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702379;
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
 bh=w44HgB3qZ7ctGcLZzFLXNGP1UikK7e2tV75W+AgMDQI=;
 b=a0pj3pICwpFtAWaXPc3OjrdjuZqM4qfIrldKv/P3sn0Hcl1GeQTc14o/smsGTBAQonFt
 iu7I7SoywzwebnVjkJTRWprSXZ9PMUYgKfKgCzbepT7ZyjqsoF+J4VFio2whZkqZfgdFO
 WcPmmM65X0z6e7TWTC9X11g0rbR94C5e5dUyhrB0y/Q3xSDAfxSdJz80262ngBZonusjD
 qybE72Ceh0FWwaeHW5jvaV891AbbCOjv0UgycW6J8rnA7bvMevMh0dNYo1eo6CAh9WeR4
 bPAhIiyurztb9Rn3bahz0dLDYrehmKBg8uBGxjq8fvdZFyvKgJRvHvWEIFoA+9vST/Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CdwgfQfV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CdwgfQfV
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B00F40535
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793702379; x=1825238379;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FuBVY4JM9b04gR7D1PmROdVZdYKPSUqg5QO6zotgvCM=;
 b=CdwgfQfVKDmvc7qwcFJq+OXgQFCJn/ykt1U3zzxycmSmJu0hKOe2Deck
 yZNcVrFsapkHagVsskWq8Z9ljPwCAyfYnfCrUWIJapCVrZ80GWkHh2EPA
 7+teI2jlLi86PBY9dyHScgVaV3BC5nsJm8SJjfyspUnqkk/+ekeGxqOR+
 3sPuhersf1FgFp/g7WFIdh3H/sq1llylZdmQHOnF2UBl0PymivmusE3S4
 dLE+x80mgyDD2eEiksFs/bVINZrXoCISnSUA+SWh4ojFH/9c3co2iY1l1
 iMqieBRXwRK+MzZnT7NzdY+Hn9VKKAPwh7kRtEmknw6rjNGjNiy3di+dh A==;
X-CSE-ConnectionGUID: M41E0jOXSVawA/DXRUmeNA==
X-CSE-MsgGUID: dxMvWfhJTia3xfa5YKK6TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2448849"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2448849"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:39:37 -0800
X-CSE-ConnectionGUID: +KpzFCjFQ1SewopfURtQrw==
X-CSE-MsgGUID: ANtfrL7dRI2SO/a5bZUJFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8234948"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:39:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 02:39:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 02:39:32 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 02:39:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfKhCoxYeB9pgU2aLSZvbawft2g6FNr3r5JgzHFRO0GTtRCw1S8OveBuJIQj3HmJWdMbos0KWvuMlfaYTxvgWRJ8MhzdCs4UVmiYxdhL89hHm6jBhCrmOJvsD+vvQQoE7IwmDLDjNfH+wu4tkhve1nX8rwmv4/wY9z10IL+xl85GxbnlXKVJHebd4h7472d9ZOaFd0TP4by9XdqQvp3ap1GBaRnlxXK33mn2oGUDdkd7zS/zUjJL6LuZh1er8SMF7DA9Se2aAQ5I+6mj5/lIBrC5Eesubg1NfGSPGqJ8dyU14gjox0ucGOblkajthJ9CjlEMPKMrHmc7b54oNgBvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w44HgB3qZ7ctGcLZzFLXNGP1UikK7e2tV75W+AgMDQI=;
 b=rl/q/J+x3H3qD3gY1FmgXhx6+uW1IjZ88VL2TauITdFcEzi6fSFz2ueFJroOaffVsoEEDb+geP1mZHZCSxeIjnwx2JMlz+I/iLox5YgkYkUWAmR4kyyqCGrtBDkxfL8dY70MKSBYTuNqEEumWWxDLyzLLxdYYAO95W52i7c8lsVapGLEEIyQsykDmQ2L3o4Rh7h7VvJef1+/SXtslAskocGS/zOsbzMRdmvp/FODizotFvEKVdFxhJB1lhvAusTN7kStfRyVyLTqHBKc3NIoSCpNLc6PqYPck8xDtNpEEIVZkth97yYtuONBN0sntggIyNKtdWggnC8wUb3IxwYoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 10:39:25 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 10:39:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Karlsson, Magnus" <magnus.karlsson@intel.com>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: Eric Dumazet <edumazet@kernel.org>
Subject: RE: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Thread-Topic: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Thread-Index: AQHdZ4zEU8ZoqOxYg0ivOeo81hofN7ccMA8g
Date: Tue, 3 Nov 2026 10:39:25 +0000
Message-ID: <CH3PR11MB566895A0878674313F8F87DC01E5692@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261029100159.920118-1-magnus.karlsson@intel.com>
 <20261029100159.920118-3-magnus.karlsson@intel.com>
In-Reply-To: <20261029100159.920118-3-magnus.karlsson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 0677c61f-3404-4a87-4b40-08df3996bae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|921020|4143699003|11063799006|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: e/T2Ij9YIAAYAOevMPG79DGF7KBnu6lt5L1KmUY3aveK2pq+vCuISHN34/3zKlYfp2e3IXbwZI6jD4RyWMzegQkvbwceAS/BLiC3+yJn9ibSiyKO0YcO0kQfvAv8N9z4Oun8g2E1jnk4cMbkgS8I9ZIdXB6zJ3NS3VLc/AE5YwUR7o7uHxTmuHlLanJafjYlnQSsfNfux1iMV5QV8NXGYqxvmLofr4M/XVnpo0YAXR/tvE5DmutZkcWQRLo1+mRXcMtxpvHXqVs8lZQ/xlCoiFsBz4HNdzZ8FEKSMjc6f17h8Cmwt3dxoGW7qds50hvcozh1w6DtGhwE2FjlfDK6b8QLc8g5LJUvTBGMS9yaIp2/5KjPFdvZl7s3NFpe2+g4tQwxmVOisgqnl0Fp8/IBZqSl5/C0+gkxhRir+4ZGWx9QxC5k57oqqinMZL0M3fgGee5tSCzikK9h15N/l6RrcbBgMaHFUdptUZ4DNAh3IaQS5/aSKdH+cLHdk/DkxM3dvugzMvDESpZmHBtioM21YpXmsaB0afgLVA1YGJ+pOYWwx7LZAtnYZeRN/kZiX6lbXaKlY42tPcIhOqBHQNaQ3UDtJG5z4UyYeVUOfgrNelCqqolKh67ura/ZV8R5HXqLcDCY97y6T16LAOJNI4J4ir1kEz9OaDpPdRrTFynXH+I5XVy7ZbLZPKHRVa4X5f9GdyPtI88qglgYx9meq9vXJPGP1kEVfClJjxHi60nUDOc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(921020)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YwcU/ijz7fO0kuZssBjlQjMxdw+Pfx6h+rLIeupcvGQRaJmV4CeQkU5znt7C?=
 =?us-ascii?Q?dw9tPGqbn5PG5DOZ1nS3hAvpC3Tavuenr6b6JBX8uLn1sk/mbqvXHQ5J6HaS?=
 =?us-ascii?Q?eGl0vT7x2MVOVWPwGcLJ3DaVLSnJpRQ8XxS4cnDTtstT8xIUcJG3rO4S3D3N?=
 =?us-ascii?Q?5lZuxYoNMB5C6nVDP+CIfGyPsqPrPupijsmkFhmua4KvovMZL9kCDRFziSiv?=
 =?us-ascii?Q?RikJLqORznL+56zGpABPAUJjrohB0m1DoDaSEmQue/c17Pb27yPfvjTBl62m?=
 =?us-ascii?Q?JHYDw1ivWnjbxDyB04hX9Zc/rx8Z4XLPUTRq8eYLEjEnLDhL2+1LS5yWDaf7?=
 =?us-ascii?Q?vLzN5XslFV5gTPaVdXSY1c8CTZGlu8STpMvZrHO3L/Q3iu+GNtI7TwpYkGJt?=
 =?us-ascii?Q?xcmsLr6VxervWwldksmYCTv7PfSvqcqsJzIU991wSHcPAWQ+l/RTzspwO7ox?=
 =?us-ascii?Q?fMViSaAKY097khZGPD1/7iWF7FEaYb5439l3U+ksMVhOZszC1hQv3sxn9CiG?=
 =?us-ascii?Q?O4UoM8Y4esjEapliAvjHo86arOwamuJv3VVSTaTO7VpudbDtU1LchZgxoHyL?=
 =?us-ascii?Q?djJO/QAKlhseSYPqWiniq0VM+on2W5jwrDJFiIn5TBs1e9AW1ppD3MtxZomu?=
 =?us-ascii?Q?COMouMq2Et3W2eH7poTug6D+Hxug9oSU0HIRm1LeAFc/981AfzGoWpXTGbdB?=
 =?us-ascii?Q?KX5PYwC5BE1qdgXAxDHtkocP95Hk7jSQNM7FcLvSFh7wzCSRiyokS08vIHZg?=
 =?us-ascii?Q?mu/FJNO/6Tv49+IzyXmuHHJSU4o6pblSNu7icfZfFx+HwE1GvxFwaiXTYL6y?=
 =?us-ascii?Q?DJkkqXtqRsL6Pr6n9i3Kf3sm3ygoWeXTWJKl+lsEMNJvfZp56f+bvIhy6OCM?=
 =?us-ascii?Q?2Bz81O2rIGE+eBrciP+ZhdBeKxRuCTKPV00UZCi0XtU3zuEuq1oY6e8ATsU4?=
 =?us-ascii?Q?StD5nwWNzJV21bBQnx8xL1FxhbEeyu5pctzz3Qy/F+LximSUI0/ymimpqQpf?=
 =?us-ascii?Q?yyJfmQg4+thPC7M4RmYBwl3DQw+9j1s5YO5EKI7TV17CDhO3HxhnYnxbnmDC?=
 =?us-ascii?Q?A2OjOdtXL9buE6NysFbCghbjZYjrW0oVeTBiWAdWiEPINY79aApP0tI9tN+u?=
 =?us-ascii?Q?TswsxOzgi81FWIIbbGk7DPdVQAGHr+q1fgo+P3wgEarIrNwpdg9eJprdx5jf?=
 =?us-ascii?Q?JzBbfT+D1ii6W0Y9y9a0s85AL+1Bf+hkNP0Atu2NdxzJ0xYkS+qMYBB5bfex?=
 =?us-ascii?Q?/Ycc3fg+CIUqTO+s3KOYdtCQcDUxEp2CfoQZQHg/1DoIcZOBNZT7RHz16oHu?=
 =?us-ascii?Q?a+P+bcQ3wq2mrWUsOozcaWMXVAluRPUr2Mft/3ggY2bJPMy9r1f9cIf6qkG4?=
 =?us-ascii?Q?en90VyV3NJG2BCAil+Nz5E1kZkc3e5L90vtiA3a2fQdmW3ouM039Y6MrLHmI?=
 =?us-ascii?Q?+0aO1McJGai8/H/kLc17gnWfsXZ5c0rC2BZ5dRU+VJRSeOHyaAsIduUbbKkm?=
 =?us-ascii?Q?p8Jv5cpt6VmtsOLaALYcLqnuYgj4QlapTaCpOTu8cy1tE8+IFJnFvNBhQy/t?=
 =?us-ascii?Q?/xtWpcVfnKQR4C1D6mYLI2EIWKeS5NsfCtU6SjityY0D+77XVfkkKGB8OsDz?=
 =?us-ascii?Q?MJ8gyAP6BqFZB5FxERCh6dz7FGWYa/tpdcYkVbgtcU5WyoslRyEs+FsU48EO?=
 =?us-ascii?Q?nNTMc4gnsHcJBeYgVBSG9dTHF6DYQVJhQ9+Frj9WFUf4Kz4wuEgmUncRK3kX?=
 =?us-ascii?Q?+MlCS5quVr8rD0lRI64kjbyEQTd0CTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cM9lU4L4eknDhoszdFKpGTK8Zswsrp+zJJkoFl3yLZILT7T/d8gW3f6DZgWaKaSN96tBtu650u5I5e7fmUPwErDfOizadbgbUyvLEEdVtyZt8pDFtJRTo/rkSuOMM6whenQuUnxoV/uVRUswwoK2gdcscw2isUIFBntP8MYRBEaDI2elz96wJFJBAKFCZvOxjnCXleduE4EVtuNhcFraWON0okflSCi2qIhlVKFyGLZlCV7DQZDXGt34RU6wror0KRl7cBCuWGcTa2aGcvbVtSHnScAJwiS8LWHJaR+8JloMUbj6z+3AQDNQVO2VsxMzLRaEY9d9ZGCAbAqJzSGing==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0677c61f-3404-4a87-4b40-08df3996bae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 10:39:25.2912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ojAd6YymDyz7F0u+Vc7F0z+6tmSfMYySbkQYbwjLY5Mg/fw7z62ylXesF+HIqCJVv6Z6zWiTucDvvvSlXILFo/9gHCF2DgrhJHXhBTiPkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
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



> -----Original Message-----
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> Sent: Thursday, October 29, 2026 11:02 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; intel-wired-
> lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Subject: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
>=20
> That USO works for 64-bit systems is just pure luck. Currently, the
> computation of the UDP segmentation header is performed using sizeof() a
> pointer instead of the sizeof() the UDP header that the pointer points
> to. Since the UDP header happens to be 8 bytes long and a pointer is 8
> bytes long on a 64-bit system, this works on all those systems. But no
> such luck for anyone using a 32-bit system as 8 bytes !=3D 4 bytes. So fi=
x
> this by using sizeof() the UDP header that the pointer points to
> instead.
>=20
> This was found by an LLM while implementing something else that used
> USO.
>=20
> Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 8982cf75466f..2c290d7788d2 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first,
> u8 *hdr_len,
>  		csum_replace_by_diff(&l4.udp->check,
>  				     (__force __wsum)htonl(paylen));
>  		/* compute length of UDP segmentation header */
> -		*hdr_len =3D (u8)sizeof(l4.udp) + l4_offset;
> +		*hdr_len =3D sizeof(*l4.udp) + l4_offset;
>  	} else {
>  		csum_replace_by_diff(&l4.tcp->check,
>  				     (__force __wsum)htonl(paylen));
> --
> 2.38.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
