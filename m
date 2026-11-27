Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C3606A32C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bO73SMk6;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tm/sAtGL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F25DE812A4;
	Fri, 27 Nov 2026 16:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H57JItwNOJKe; Fri, 27 Nov 2026 16:01:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10D72812A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795795307;
	b=gtpAwY59ltpR6ZtwAT8iyrdYO3Gftm5yke2Kw5R41/HvYbFpLaeGphILujJCBEwv3JSn
	 I63cXNPkoDgwPLKpusn5ttcumjtmIkwn9Ce2YvK7z22L+wKJMBIIugRtpZ+UgU3z5qjUb
	 gR6sZ6NmbK8dEym1Y97LrBmZOQ+XtwIf6R8/xdKBK0VR8Uj3iZpmTdswEG6lVj9U65Cau
	 3Z+Zws+oQIBxeVbwTXvJKclvvyTNPcP80YC55bLEp9YnZ6SgoOFWl9X8vL01kSaL1biyT
	 zuCR+Vq1vzjg9EWJc4J1pI4KZ0ayd/n9hP3liu7IpDFUk+s6hyejIGT41VTgJxun2IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795795307;
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
	bh=OLe4okM9N46rTMbyYsKX/LFNv7Fqw0qOjjXCUoY9ry4=;
	b=k0EG14bewPINptIah/ZYvAV9MAyL4XuIC85wcpMI+0g80fOKpny6F3uHGIlwY7V0xQhg
	 t4NYqylqrifjE/eGf/yTKqjdmirQCOyJAg1ciPqTbqifdQkwre8eHmS0IhUA3VPiglJIg
	 ejg6h+A1lSCXHDB3qsu1NP/5Qu9KRjCsUEPkjN5BaU9q4uW1Gk9QbpmBWXD7stGhuFazE
	 6oWrYqHI1yX5N7kVDhSxjpwASr22NPK3bluNyfUQ5AMz2gdSyQGOtos0yrY8Au6TL4vz8
	 /bAfyBwjI6wUYaFtXYV6Bkvs4vMISKYtD+id8gIYFa4lGRc0NA2VUa1M4KL7HK140Bw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795795307;
	bh=OLe4okM9N46rTMbyYsKX/LFNv7Fqw0qOjjXCUoY9ry4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bO73SMk6L9MdDOEDXUB8lfz6MSo2KBAXj5j73yxR6sTTRNFE0SXZxIFY1PazgbpMt
	 eVBzdlbx9J/gfM/+Gs/RNDNGVCqeC/EQ1jWmYPYq+lKm2L1aL02ssikgzEdf0n+sDj
	 uqn077I7LIg82SvelBBuHVwJ+tkS+FtZ6w0ccMUR1cTyvHB36u9oiD72Dz06CGs8uy
	 BJWu8V37txSw6JuvJr+seeJIAL2dycGZq0zuuI7aKXKRoPruGqm+3V1pVtWcQtG+Ij
	 zpQKuEc0xVSNP9B/aUx8zBkDZb6EhlnKIhQnryUrDJPEm9Q//tf1dPayT2uYwxgIkK
	 I50zOlt9DQFVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10D72812A1;
	Fri, 27 Nov 2026 16:01:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5F8126D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7D0A60D74
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0Ew1lPCxCSU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 16:01:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFE5360690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=milena.olech@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Tm/sAtGL
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFE5360690
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795795305; x=1827331305;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LTHOBNSr6ftKqZ8RVXOf2MyE8MtE8lrPb4HoJkyDjtc=;
 b=Tm/sAtGLTkmv05pJwZxtQgdUlBS1Zr7yKkrvnldg2I1uOryVVZqEAk+a
 Yal1V2+SXwEMz2NTgYQasyP0ZTtZ17KxGb0Vj3s3j4cpVMKHhrRnKToao
 xjK67w3WwkZgWei5ukTPfpumxpWN/QE4i8fAosVavjIWei8p7PM5kMyT7
 6YYVPCnSB0HIVQz6TxZr38jm4UcXAyL5VaM5f/dXJSR+XNT9J7+4wgYLY
 V6Gdt4IPOUPpDaHgdSvt0mYnOvBZUS2P969UoQ2YzI50pdT8QNFmrOfm0
 DJbqdLG7laaicr3qY6e0fqhFFu7TQeXU7l7bo1pU6oxflsMPAKTaW8lkG A==;
X-CSE-ConnectionGUID: EUVQPS69THSjKy6miYOTtg==
X-CSE-MsgGUID: 10/OLPyDRlW/xp/Uy2Codw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4616927"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4616927"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:01:42 -0800
X-CSE-ConnectionGUID: Rpg0bYtVQE27EFZJkTYXqQ==
X-CSE-MsgGUID: S9mflYf5S5KoJ+do43fThg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12715769"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:01:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 08:01:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 08:01:41 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 08:01:41 -0800
Received: from PH0SPRMB0197.namprd11.prod.outlook.com (2603:10b6:510:43a::22)
 by DS6PR11MB787091.namprd11.prod.outlook.com (2603:10b6:8:4c5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 16:01:38 +0000
Received: from PH0SPRMB0197.namprd11.prod.outlook.com
 ([fe80::167:c419:e42e:59e0]) by PH0SPRMB0197.namprd11.prod.outlook.com
 ([fe80::167:c419:e42e:59e0%5]) with mapi id 15.21.0639.012; Fri, 27 Nov 2026
 16:01:38 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Cyriel Ladriere <cyriel.ladriere@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kurt@linutronix.de"
 <kurt@linutronix.de>, "hawk@kernel.org" <hawk@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH iwl-net] igb: only pull the Rx timestamp header from the
 first buffer of a frame
Thread-Topic: [PATCH iwl-net] igb: only pull the Rx timestamp header from the
 first buffer of a frame
Thread-Index: AQHdfnNA32kHuRkD1EqnUSZbOll9R7dCE5DQ
Date: Fri, 27 Nov 2026 16:01:38 +0000
Message-ID: <PH0SPRMB0197F1DA6FD83F4F3980090C8E412@PH0SPRMB0197.namprd11.prod.outlook.com>
References: <20261127132804.975014-2-cyriel.ladriere@gmail.com>
In-Reply-To: <20261127132804.975014-2-cyriel.ladriere@gmail.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0SPRMB0197:EE_|DS6PR11MB787091:EE_
x-ms-office365-filtering-correlation-id: aa6d48f6-3c48-4c54-28fa-08df4c9fb80c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261021135927099003|261021121427099003|261026140227099003|38070700021|56012099006|260925021311599003|260925022911599003|260925021911599003|11063799006|10067099003|18002099003|22082099003|261009223027099003;
x-microsoft-antispam-message-info: TlaBjw81iFfDSa5dS8ntPSsuL6ElDD7QtJSetv4arXzMF//Vx42EFnDjMaOyc0/tDoevV5Rj1dLfz9qMHMRUaRhWesFdtFTQGPDjSqRRKY8a67/aGjGX2V6vBOzSRMcWIxc0+fTMpa9JGMXj3RfkRPBXADchknqRbwousemLD6izJecOeu7u7PAf3WtpTMCL/2o7BPCm+Tf610eUC3vSgU8DfMsdNIZG2vI1JwBh3aZ6Vz/gHOjpnCZ0sGIomKbnjQ92NUDEI6OsQ2uUu0Ao6jzHY70aohcRZDZEmzQqwJjtJNhIjkaEuoajTK3IuBkNFGgxiFd3v7kkKQdJ6iVfJhHmrqgu+jZMHqw1lm1A7K5EB4ODOEe1e+ju+u/3NZSOhglRu2hAKf4n9DKxGSDqjrN+NpysMiNUWPG14u3paDGmeWdTXs8fSakejPl8Mv58gZCd7PpZy2jxjdSH+RtjAHSSLMpbfmqZHTSLuLGT8JwijbiVM1prrBTzkW+spJzAc6+8hE1NjwEF4Q4ZDSKWMrgZGBmT2omm+2evPLlA0PXEro3EeDZ4kxqvzlGLclZiJoSffxJNEpAslLO1S1Nzo6aPEyg2Bl0CsRCV6naEKlwLJFz4klil60sqMBxhJ4uADSpVrE745/nM41T+Ehm+ye/f5TWUJdtN1W3lD7tqRQFt6Rkqbk2WOg0j30vMhMGiczMNmj/WOYWW75D78fy0D3H5W3bVXneQzRyHXbeQFpg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0SPRMB0197.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021135927099003)(261021121427099003)(261026140227099003)(38070700021)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PeBeVbPbZPydc4Q0QZzAkR3FOC2lugtW0WIQddZm/gjuhV16Q7GfQrGJdLa1?=
 =?us-ascii?Q?ikqr3NWd/fer3YPtYIsf3mMtPguK28gw/9zLtKWQO4EKAjpLKbD7Wch46Pzu?=
 =?us-ascii?Q?vVwxm+g5ZF1SWAbx0Ueis+vB0l8WgcX3hoTfR02kUgIFAJurmn1nJWJVyXkm?=
 =?us-ascii?Q?0SkPVjIXNXJAeCDowNUsbrEMM+lTrsNJrp3ybwdapDzmifHIOu09llnCGjiO?=
 =?us-ascii?Q?k36F5qsb2Vv4Is1JhNaTfTQmPNnuzJhEAS57GKZ5UXDYKE12XHlKziiwTuKr?=
 =?us-ascii?Q?A5WPFfEHPg5Gz7OjEb0VOqaiDrfwaTdaYDdgolYYwf9+V9t4sQY1RMteate+?=
 =?us-ascii?Q?pe7in30t3GbLugyvPaZpajF+yzzAuat5H9m7Zp5KoUbnTB8lOV2xbuSOUM+E?=
 =?us-ascii?Q?0+YiJekuLysPIINSOcJwlRdmHyLq868y3JVBczZoNryXaBLB4YJlpORnXypJ?=
 =?us-ascii?Q?PLm56E0nFi8bLTpRRMFjPF7cadPpDgl5KMXiwMlB9HpVwQyuD6EilV5gnNR0?=
 =?us-ascii?Q?7mcQaQzfWpGrOpRXS2U4vEvH8rpva96U3YnZgcMChmXWbUQI63vrcOGC3kW7?=
 =?us-ascii?Q?btO0JuT4HccDrVkkONqLErWek39lpA/ovAN/dsCBaH1zxyfdXyBVxAjVW/RX?=
 =?us-ascii?Q?yKSYcSLyW6MicEeLIyRu3L+GbvQ8AtopMvl/NYSB72yPCA5taRFjMmy9DKsG?=
 =?us-ascii?Q?w50ktbrCvbrcVjsmUFlf5yAIciDOMiGFswRittfF5jk2uOkosoI6rt43tNcu?=
 =?us-ascii?Q?tNv3AroqZ0cH3vQFxNNXovSwsbAWTgq/U8ihNLATLfiF5XJOAyhWL0V/dHlX?=
 =?us-ascii?Q?1fxStKaAA823n3zD1rNY86kqTCLiCbzzMNUMHiG+5OHo43eWuDeqUM6ZMJ3y?=
 =?us-ascii?Q?dToLLMZt2THcWtvz4+guUU4N/mzsvgmv7/d1sVFSGbQzHWe6AoVM0Ll2XUTY?=
 =?us-ascii?Q?DV4/YhOjzZe7jM8mYG5NFO1I98GKRf5NtH91W5Rv+yGg3/EKCJdDP8PUULAT?=
 =?us-ascii?Q?miQXclN2EY02CCcq7dfOaHLEAkUiaqOewUUhGG8Z95397mcQf/7bV/h3PnOL?=
 =?us-ascii?Q?+qd2Nvg7Vx3jFnMMmQQOH0/qk4JfiOYgYxzglrbi55To3OrouHetfOdF/OKx?=
 =?us-ascii?Q?AyvtzfRZ4uXFwSwl116JGhtkxCFyyeWaksoPSodYI0pAAj61e0Vc1xn4WElN?=
 =?us-ascii?Q?9delBsOJtc0Jph+tBKVy90mxtCgFku04oWRWAjM2YNhyB+zxNPVmWFD+cjGZ?=
 =?us-ascii?Q?Cvip2AqST6NrOvj5n7f106E5jmvUKBMXOFG9KGoX0JIsGwoRADRNzcvs7bf8?=
 =?us-ascii?Q?79BBT+lH4TPboUoTiz8adRcbGekdhd8Fpqxuxuq759vhkShpQ1oJZVOT9OcM?=
 =?us-ascii?Q?AQHcGy550gwPu5YdC+5CO5swL7lSEbKl4IZZcL2JLCLfD0HwJdQ7ytdQMG35?=
 =?us-ascii?Q?XRIdyx/rRcvm+ZZlsoL+hDyQ1BWqXUAy15zEkGOJyPINRsiM6zDF7swEoxsr?=
 =?us-ascii?Q?r3QbERARwOHBzvifavPAZSHW2cL0jtjt7ii8dHD0/TuyEpn28RvbJrLMbXKf?=
 =?us-ascii?Q?s/gde7SqNu2wShhKoHSSVlN9wxuPBCLTXGkVp1znD+DxUQ9iVNc2g0uT5bum?=
 =?us-ascii?Q?Tr/JUWIjef7j2TclE7tPYYSbZ3dhpf+OOOIWiRAK4Lm28ZPKDxl8/PBq4Yue?=
 =?us-ascii?Q?YHzbU6ilz5jy0JuTZBNcMpmVUrY3b1NGbgDexrRvkIQGwosGDYqmVFaqVk9U?=
 =?us-ascii?Q?fxJes3VEvw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YQD88eZ0VMEpjom88RFRKeYz0Y4XyGLB7SU3xvOCKB/TH1qgtt4cLPpDfpUEs630w2bNqilt2DVxGK+9V08C+3QYzgueLolc9i7CNQovekEWE6wxz9UJaDF+1mPf0hox0YlTk2mACg9/NhcDGMG8OwP9YN/F2PbV15Pf9JitYDnA9ouOtWWzGibbtrOdSfarf6p0528CYfiNzgkJl9GPSYN5+9VH0e41l+jH6CVTArqtj8MeK4IfqEAkvK321rIkA9ar1mbtgLeUwHi6q1dFbZB8kzRqnjwzAhwDjT+4aSMdcjRsZpBFZMYdkGgGiGlTK3jiRkeVZ6jQALK3mwSsDQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0SPRMB0197.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6d48f6-3c48-4c54-28fa-08df4c9fb80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 16:01:38.0625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuAZCaM3NdGLzCJxwITiu90/NW3t4b7dNzWLhgClR5bx56mvicOda7ifhhEjWVlxnkS4AKMUc5ISyYN/8SBFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB787091
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 2:28 PM, Cyriel Ladriere wrote:

>When Rx hardware timestamping is enabled on 82580 and later parts, the
>NIC timestamps every received packet in-band: it writes a 16 byte
>timestamp header in front of the frame and sets E1000_RXDADV_STAT_TSIP
>in the Rx descriptor.
>
>Since commit 5379260852b0 ("igb: Fix XDP with PTP enabled"),
>igb_clean_rx_irq() checks TSIP and calls igb_ptp_rx_pktstamp() for every
>Rx buffer, including the continuation buffers of a frame that spans
>several descriptors (jumbo frames, e.g. MTU 9000 with 3072 byte
>buffers). igb_ptp_rx_pktstamp() is meant for the first buffer only; its
>only validity check is that the first 8 bytes are zero. When a
>continuation buffer happens to start with 8 zero bytes, 16 bytes of
>packet data are treated as a timestamp header and removed from the
>frame. ip_rcv_core() then drops the packet because skb->len is smaller
>than the IP total length (IpExtInTruncatedPkts).
>
>The drop depends on the payload, so retransmissions of the same data are
>dropped as well. We hit this with GigE Vision cameras streaming 9000 byte
>UDP packets to an I210 with ptp4l running: about one 4K frame in 700 lost
>one packet; every original and every resend counted in
>IpExtInTruncatedPkts, and a capture on the interface showed those
>packets exactly 16 bytes short (8994 instead of 9010 bytes). With Rx
>hardware timestamping disabled, or with packets small enough to fit one
>Rx buffer, no packet was lost.
>
>Only pull the timestamp header while no skb has been started for the
>frame, i.e. from its first buffer, as before the commit above.
>
>Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
>Signed-off-by: Cyriel Ladriere <cyriel.ladriere@gmail.com>
>---
> drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ether=
net/intel/igb/igb_main.c
>index 131df3e09ba1..24be1f37cc6a 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -9068,8 +9068,12 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_=
vector, const int budget)
> 		rx_buffer =3D igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
> 		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
>=20
>-		/* pull rx packet timestamp if available and valid */
>-		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
>+		/* pull rx packet timestamp if available and valid; the
>+		 * timestamp header is only present in the first buffer of a
>+		 * frame, a continuation buffer (skb already started) holds
>+		 * packet data that must not be stripped
>+		 */
>+		if (!skb && igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> 			int ts_hdr_len;
>=20
> 			ts_hdr_len =3D igb_ptp_rx_pktstamp(rx_ring->q_vector,
>--=20
>2.53.0
>

Reviewed-by: Milena Olech <milena.olech@intel.com>
