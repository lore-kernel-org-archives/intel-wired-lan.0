Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B3606A32D
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hKjd9UTx;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jk/4FcMT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D05E54094D;
	Sat,  7 Nov 2026 03:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYDUBdSAnnpP; Sat,  7 Nov 2026 03:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 007F74094E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794022595;
	b=Jn2WZ1h8WsbPKvqN67dDSXmeYK1KNOkP1H2Ivcygn9IomV8Q5qDHLgLMz0WbdxQbXtb+
	 Y1jupeu6fhfCVzfBmAhCf7Xnq9eXtW6aL8Kv/ivsQNoYybsjJNqlzKFce/bCLH1yZt2e1
	 tmm+qMLmBj+2MQ2dZHO11LcFIzYfsg40ymMBmQRUyLc/yL+k09A2AR55nVtFO+8J1Btw4
	 8isBvIIKPtsPsHtSNlpnKqWZBBbTEJ37JuUvdp8mirPJq9JcrndxETFo700eSRzctEK3P
	 q+Tz6aOJoHfj5KJGwoIuABVx3myirnteIyHRuPfz/YDIoh8z1h2pGbyU559/SAMxupg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794022595;
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
	bh=9SjUFDXnPe7K9NWeKUdm5GpATHxA9FrSgdWrKK17HmY=;
	b=DOYSgvSMthOgLjTkVBmOpNwerrXlGe6Bn7qum5VG7+8/oqnqiaeqE0dM3+Efz1LyOEYY
	 10DDcW3JSeaLvoDBg6aey0jBICjwIjLWPFvnzzx2G/l2fjZvRWGbwNSbl3gKUErZWV/eI
	 DpMwjge2Inw0QPoayrolKVW/OeUEI3PQa88fOMTwVWwwj6dk862kvBxut8V+yzMv5/Sd9
	 Eo5zKJuabAeLdhgPJjwm2A4DZFYfUsTncMdtmMzdQfVeGpMOkft8OwGXe2GX+vwf5T9Um
	 ooB5ZbjovRc52+zaB82wT19aYyFdkMS3RrmlaZ/iy3G+OO4y9s7tplcfrYuV+rkpn7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jk/4FcMT";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794022595;
	bh=9SjUFDXnPe7K9NWeKUdm5GpATHxA9FrSgdWrKK17HmY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hKjd9UTxE+yc3+PUeEOsZxQRimpDKhgu5ntr5lgQHEluF6nc2lHMDk1GeJQ2rzUNo
	 9b/p4Q/QmKJUqe5QrTepBuD3gY9LD2lx15ScQCIk7yhAX2DSYGDctJPq3s0Dhswx02
	 T64G19lLu0+Y8ZWv0iFZ5TGZbc+OxzzNFoNzuFjnyLNCm3r/xozjCMXS0NMkjuqQvd
	 K6ufaKGez6kXFKevXCtDLBTBCkkhzbVE0Bf7S0El5fme/xgVMbR5TTKL19x2Ho+pJ9
	 4PW/5BMYGjeMhi+VrqnF0vNsNJdgUNTTc8E6SvBKHBIZ6loAM3ic2wXGQ9DqjjR3jx
	 qFAMLN6cMp2qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 007F74094E;
	Sat,  7 Nov 2026 03:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 515AC34D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FA3D40944
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cP9iMTIQW5fE for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 03:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75D8940723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jk/4FcMT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75D8940723
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 03:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794022593; x=1825558593;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kRXBikLu0K8Hxg9x9Ag1ybyvLmQl31b+RBWav2jTHtw=;
 b=jk/4FcMTRL29l6qSCJ0iUeD60HqrcYy45OdKjuHEsvDSDzpUzUZz21wT
 0Iw793b3ocDluLw9bKdIL0bRyF/3yARhxR9X5VAWJQuuIrv+uDxOJT2EE
 QhRzsxhPMcglGgC/CjMQhXM0RWqF0mgRzNg3dT9IjpOzjYElgnxn/LXyo
 D8hWIHlE/EUfWLxKISI9BCkrAWLwftoUPE04s2DK1FXZYwTbhtD6ZmBho
 3PYnNqKnQTeqP8ze0auMiQoCnp63E9jOsRRCSYTU8WA++zT7HtfTU+YFB
 aFA16KNAWZ8dryn4RN1Ef3BL4gF+q1rIgH+nixPpXMvHc856yxi9oXyvf g==;
X-CSE-ConnectionGUID: hrRbe7HPSXWaexmMrQka2A==
X-CSE-MsgGUID: dWoDH2WZR8+kVQwN13DJHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2828629"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2828629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:36:32 -0800
X-CSE-ConnectionGUID: CR7nuuyFTaqFMoUnb5adcA==
X-CSE-MsgGUID: imLFEgsmRnyYQDYLjCmQrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7777017"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 19:36:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:36:32 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 19:36:32 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:36:31 -0800
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sat, 7 Nov
 2026 03:36:23 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 03:36:22 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-next v2 4/4] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS
 constant
Thread-Topic: [PATCH iwl-next v2 4/4] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS
 constant
Thread-Index: AQHdVaDtF51xXmhuDEOWsw11/ve/q7ciJviA
Date: Sat, 7 Nov 2026 03:36:22 +0000
Message-ID: <LV1PR11MB8790D9890FA370367DEC3A7E90752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
 <20261006144018.2885932-5-aleksandr.loktionov@intel.com>
In-Reply-To: <20261006144018.2885932-5-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM3PPF5217261E0:EE_
x-ms-office365-filtering-correlation-id: a24b2c7e-a817-4ed4-b438-08df3c804b47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261021123027099003|261022075727099003|11063799006|4143699003|56012099006|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261022105027099003|10067099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rqbaD9otdEhtV4CHTHLIBm2Wvtmy86Q05OQCHqZMl0zx9xE/vAxHgwrWW9Jj9RVS0szaEbH2S9iH+4xS+hMZGHqKLL705HufJ56mMRewWnLw/PXPaCPUr7Pb3xW8m5i2Q8vjzVPQaWbixHT1gxyn9ar+3fPv343lxLKt9nve22oLtOJ1RnsGfaMr5XnuFvc/wi0CGapJmadDxVvacF4E+p4vorxyNdXwr0SO8FOlWQMitFjJmC2qyjudwQ2JBXqxBIAyQu7M5dx5sB/6zT+pmbDivis+XT79PvRr5WY60++AKbq2kqxyA23E1ZRbiwsfDJEbqvUNeoP99NZ0HFfvZKK+d6tOQYTGW+o8s9nEEfP9sbngccVr+FD9fSkJdyBaMBLSEbenbnSRzyCzg27wOTs+3JBTx2vekaaS69+0Em2PYVtDR9X/zgC/lPWnQ36cJ30WcNwS8DLbPnb0QoGbhAGwLBFnCOiLxnp7F9NDHpQcGuoNkzv2n2/9FxWdVUYXm/b6Yxn7DLrng+Ajz7JTnjV1lrwMMuxBDMifOuVE0FE239iTic8fZMbOYCf420NYBOh6qLhQOHs8t4CUUAX+ZS+c6R8l6G5X3rErruHHvhTuHDHMrcP5xYDMFNqthmYICiPaS9kWtu1UmeThqB4oqIaeJz7+GISvP+YKqupC+jIE+2oiRb9897knUKbKoSQXp1vDv7/e/T+RNWsvHkccSryIK1TCyz/RJxG74GffW9c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261021123027099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hZZeGfqpuLwo3H9+6fpsMudiDzCEwcW6d+okDce3WuobpXemaeU3DZ7DQ2do?=
 =?us-ascii?Q?XOsQtL1BoQWbE30qEqB0o3W+TXgLa1J8u5L3xZMt18CA2CuXeoEhCUw9ydZY?=
 =?us-ascii?Q?t8a/QMepJX+WTSXGz0eJ4PhSUMq5kGTVH9UBONy+dghIC0ln7BaPMLtLmcxv?=
 =?us-ascii?Q?rgmRG8oW+79oqsJ3YKKWZaXvn44drRRaFBRnk8dfMc/LnX7cA3SEcNZR9o1G?=
 =?us-ascii?Q?/MJ4/I/TUZwTWBItHLGW9XDOXNw6eTOVS0jBqtViQi1ZIBiKIkkCM+SRizuf?=
 =?us-ascii?Q?02JLrNRLVunQAVeocnoaGguVy7hElwXV5ZQcvP6Eaoz4KVD0nFoQ/dBtsMCd?=
 =?us-ascii?Q?2KmR0Wr8TFu990bFEfR5WBPqLGHdBDVwCgSEOJDsey8eb8fdqmideqMDyuJG?=
 =?us-ascii?Q?uBl0x3b1DEW45i0YMbjciMdE8Yzf/znNHUKMx+OxGrIspVMB9DBbru5A3K4Z?=
 =?us-ascii?Q?5ytpQGjO2rqmzFJkKsDqtbnnLmIjLU2lHWiLxD5NU9wWo8AwReyviQmeVtde?=
 =?us-ascii?Q?LgJhqQtkzRL+wBoFglQIyt39EBKrGlMRAN77JOu0qedpfQziuJBhYcWyNQ9S?=
 =?us-ascii?Q?GbssUFuC9uSrKTctztEheFN7rRR+o1CucXorLS5seBUfPo0kFYDXTvCS+8+6?=
 =?us-ascii?Q?c/YybqBLYA6x1XZSJ/PmsxbgsDjejqdn2LUutswFPh3CJMtOe0CMRXnKqxnY?=
 =?us-ascii?Q?3TAVXH4hQPgHQyzijaiHZJc1WwhYzf4thDwFwrBJAHBo7wgm4hCShG27E3Xg?=
 =?us-ascii?Q?N7pwO7nyjphCKuL5J53LpjEKNDie5gN6ckoxmjNUq9D/ABS6jHp6H4nTlzRP?=
 =?us-ascii?Q?nZcmc87bvAxF06rFTTiigOIebzNushKYfsfd6hLZ3YU59Rdd93HBGRqBrYdA?=
 =?us-ascii?Q?hYlTq0c2t6FtWyNUG/W7KADarB1+MhySubUuNaSXKdYbSs5rqDQnmFZS7tUU?=
 =?us-ascii?Q?Y20BZ3Gdd1vHqFUpmVrOIqnrgw1Da2bAXSjg3iTJ2exf6BAQvJjuSMyC2xvb?=
 =?us-ascii?Q?qUobFA0nlWUp9RSwsPbVf2Y3F2HTFca/fnHQf+XaCJy21W5ehlbp7SQ6Ph9q?=
 =?us-ascii?Q?dvLEAZWzzl4wFa7CT/HYYCaBn3UKkGvHxftW15vdla+oOPD5JuYrP72si3E/?=
 =?us-ascii?Q?jn1C3R91o6/SbzliyY7OvIBgpXbuuH01OgbHhbgzIio1aDSONpN3Ix54WzU9?=
 =?us-ascii?Q?YyKI5vs3vGH6NHkHKKXj/6ZRnSUMLIaO6dYFbW09OOhk9T4Cd8C7ekqSlUBG?=
 =?us-ascii?Q?cDs2F5jHXn+fe8FKachM9duc9B5dm4vrymA0cL3+DhRUR7xFkTZ0ZK5gURAf?=
 =?us-ascii?Q?Zs/qlY0Z0elqKvUuPterzUtYcKqw+gILWA9wan4W7EWoC4fdap8Gw5wBGmt2?=
 =?us-ascii?Q?DHUJxHdg+fFNDA6qCWjMGRGmPlaFa4qGeaCKewOvsuqDftvM9JeQcbV44TmQ?=
 =?us-ascii?Q?VNZdpz5aOsfjD+PnLJgFze2SOw/KYE/H0gsBuim6jDcwB9yRZtPj7Nv4nk0k?=
 =?us-ascii?Q?zWqMuhhJ3rao0oby80we+0pu0PLq+fP/wwy3oj3T5IOssIzozKyBzJwaoWsC?=
 =?us-ascii?Q?huMfMu0N8FrvDzNfzv1VKvDK21VtfbewUZA0tqQJSVfHCvepGKmHZ2FiKyCQ?=
 =?us-ascii?Q?EHkbgJ1mG845engaYMIILdFoIOUkONLkZ8bEpxjI4M9zkAe4wXlDqYnin/x8?=
 =?us-ascii?Q?gKH/ZzAcqZHNSKmzqhLBqOzJKCWQOP9MEgSAkbdO6Q3a6y3sa9Ig+JmU63P5?=
 =?us-ascii?Q?RQXQ8UdOLg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BV3+JLjxUDWxcNnFbFqEbUSXFfD7fdcHxHiyht/k46fU6C7V3Y3KQXR0ikW5eXHhDiMpnFW4drg/p273Qnh0SAKkyLo2ZzrJlyRleCJIfbBJEMkiFCzpjh78A39nJP9gtKqtz8Eakyv3CkgI6a9ClfHwkmBj7Y1GdT5io9SU9afvyWHLn9yYDo484+xEyoE1ITS0vXsiSCDty8oO5mpXcFhyzRDEKPJkBZuX0qqoANGySWi+r8S7HVUNiwWA+y73yYxxwb3BSS1iBX866ecLhnQueKVvfNms1fT7q8cVFmwaYeocETfineBYUEE4D0W2i2GnXKfZS3eLLCC9DxESdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24b2c7e-a817-4ed4-b438-08df3c804b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:36:22.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hdhpvNP/MtAS6q6M5hLV8baZn2duepaY9H6Ca8Qfvy5gvgqXXZRAL8gtBRruWWF/crFaasy7PgEBxkH7nJq/q4gUInKf0W/JzJmvjpJJag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
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
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>=20
> Sent: Tuesday, October 6, 2026 7:40 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-next v2 4/4] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS=
 constant
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7) =
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
> This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.
>=20
> Add IXGBE_ITR_ADAPTIVE_MASK_USECS =3D IXGBE_ITR_ADAPTIVE_LATENCY - 1 =3D =
0x7F to name this mask explicitly and replace the open-coded AND-NOT operat=
ion with the cleaner AND form.  The two expressions are arithmetically iden=
tical; the change improves readability.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
