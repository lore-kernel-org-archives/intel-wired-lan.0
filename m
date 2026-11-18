Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C69606A32C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hRQQAy+B;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iJHR/lGG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m4a7VUvH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 837CD81135;
	Wed, 18 Nov 2026 18:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zQ9c0ocl_ZJC; Wed, 18 Nov 2026 18:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E18B281137
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028298;
	b=MQwk2OUkMKHnKqsTJ8FLlWDvNG2vluhRuaxhrSAPpePo7UgbN7rM4R704zW8UkF6X1Mf
	 awDsr2DQYOkh1OLiBIEObIxd9SB2ilKwxUnks+LPbsyHzRP0Mcx+au9ZWavW30HC8Grql
	 7h45xwJv/+2oFIT9UgA0M88e7FCO6E4CVeQxy0SvDkozJE9ANUFsVtSYz2vt3+4GkbC+y
	 OCDSWtsmJRavvx/AuO0yeZ5FBJJdu364vLhKXt7n6oKD6OwaAOI9dhUmHg7wCwkeD8yVk
	 tFr6SZ1j3iqt9plTwdIcTCuqbQnzdSv3L+ECeRq/4xeGkZpmR+uT95fC0yOCF1JXHHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
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
	bh=MciwgDaAYV/Eu56bXWN3XpIa34EyNnkMTk+8kzXB/wM=;
	b=YeFN97Cge8jyLkUyvUeOCdWQnR7uvITE9HW0etmlwmgk3EtDxa4IW4Pm6VaNSyKyblyg
	 5aAUckJ8HscbZMzeyIHV0RmozFP6SQaARWkefdXM4Ll4Jwst/6OLwStqvk35nwva+iR9T
	 +2DZ9p3yCNWjpoNKUK6sVklZ8L6QuoTo5OCa+UzIt2QnXg+YdUHOMk2nwqFh29O2ct3R0
	 Ae4auqEhIqOPL2hGtBmpGEZj3NL/h/0frToKH9KIqL2scMg0r8ELjm4B6zveMcu5cnM1E
	 ARlNRPTlqxz5sovxMQ2h19CM4RWx7noNZsHBlhMCLKDBAYcdj1woV1j8GmX9iQWaBcw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795028297;
	bh=MciwgDaAYV/Eu56bXWN3XpIa34EyNnkMTk+8kzXB/wM=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hRQQAy+BaeG5en7Jbt3rPp3UQuNwdARVTyeiWgMpUptdLwcylFa0L7e1EP8RjeCVw
	 gMfCGM3xwY2ogdx9XFqKNXTdwD75bx9e+C+YQBCNcONjvUxvWB2+w41OUK+1heKCxm
	 nIW7aKL+WCNFY4svlFCHFvArlD5lqOYoxMFg6N3i6hs565KiAaoJdXpfQKLRKu2t6o
	 d8EDJ3ViMzvARHmjHvPfyXQ4oYsCGfIxHdflPIw3JQ1CXzXWIEihymagEqxPzv3Rfi
	 Yo/NdlgxwgOnAnDiHN/K5fCXfldn1Qx/mn0eEssudEjPrm5NU5OXbLGXHx/3zLARwq
	 3+kjQLIvijUSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E18B281137;
	Wed, 18 Nov 2026 18:58:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C15513C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 426AB606BA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RgQFI_vAy058 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 18:58:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C707606A3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iJHR/lGG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=m4a7VUvH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C707606A3
 for <intel-wired-lan@osuosl.org>; Wed, 18 Nov 2026 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795028295; x=1826564295;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=pI1sreUFEFSBYwp5Lg5/hw8TQs9t1MG2aYTCKSJfdoo=;
 b=iJHR/lGGMY4wprRkq1bEz4ajUUzZOvoixDHaSzZ8Yn/d9ChLo3E65/KY
 /8sw3ffZkdCVkQ4+EVN1my9OWOkcYS9/Li4yK9B/gGDseyUAoosCQ8ViB
 vy9CAwC7EEGggOd5LDsKwz6uJo6Nm1uHLR7EfrrNqidnGLJL5ZkWqXnIb
 GUY0heSkjX/uf9msn9eT2XLeZh/um+Oa1c0yENU63jwT9pBwALNVi5mIF
 q86AXgl743hPCGbm0EKDUyJHwuypgrz0OQzOVYtxGeCAlbIL/LxTrKdQD
 PbSrtP7rVNbSCE7nCstYy/hJBDn0iVx0May+GnUT2dJvjbcOUmw7MdmJ5 A==;
X-CSE-ConnectionGUID: Aaq1KUyZQJ+nHnDjM+ZTsQ==
X-CSE-MsgGUID: HaUGiBEoT/KNpusLYq2iHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3878626"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3878626"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:58:12 -0800
X-CSE-ConnectionGUID: 2LM1zX92TAycnGDAzwTjAQ==
X-CSE-MsgGUID: IiPg7FmNTRqIRwv8vg7WoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="11958465"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:58:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:58:11 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:58:11 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:58:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MciwgDaAYV/Eu56bXWN3XpIa34EyNnkMTk+8kzXB/wM=;
 b=m4a7VUvHgtFbx6wiHIgAdKsWOfQocIQ+0QWLLmcQoPfYfoqGus5hIDcM8k6j1n/JqcYbsVnMcQsP99GTFSoGc2YfGPl2oKFn6SfEqgAvIxVP71DincEpOXhtgFIursiWzlBAAmLp+BcGlkkunRvq1UZ/je63vkNjONeKYf0KIQM=
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB015790.namprd11.prod.outlook.com (2603:10b6:610:349::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:58:09 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:58:09 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: RE: [PATCH RESEND iwl-net v6 7/7] ice: Release control PF lock before
 RCU wait
Thread-Topic: [PATCH RESEND iwl-net v6 7/7] ice: Release control PF lock
 before RCU wait
Thread-Index: AQHdWvMmLCLGEt+5sEuRzQzApCmSIbc0Z4dg
Date: Wed, 18 Nov 2026 18:58:09 +0000
Message-ID: <LV1PR11MB8790E8647608B2CC52C47E46907A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
 <20261013091235.1423979-8-sergey.temerkhanov@intel.com>
In-Reply-To: <20261013091235.1423979-8-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB015790:EE_
x-ms-office365-filtering-correlation-id: d038c88e-3c23-4975-0310-08df45a5e34f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|10067099003;
x-microsoft-antispam-message-info: CHy0RsADJQRGPBJ6A4dNZcOMqfcu3JUtnnQ5/LteTMC73gtKoRQsfScK3SUVTB8ruIbhHamxJVVXiC8WlBr9i1JlLGnTov2qVAD8seH0dcCmRYoAtpneZHkqTagvPJoARemG4LRDUBKrAO6tlHvOz+GJam0RReBlWGHAFrwvo+ftfvH9Fy4WQ4NTqjKvElH5HPrva/4lT9GZAHm5jRGRMMvC+OJCXkMy5oQRc9lmaY91HjyCtskxa6TvGCdbuDW5rGBNvnbYqDGK+Z2axpy3NMamoNXqEzCsXstUg2DlylLNl2JhAG9OZd5g6IxtiBmX/gn9rtOA/yNMngQCH84KdRU5BlJRBbmmZlHcT5h3vVZusY2bOZdNmvsaW4D74rcoFi9+jk7qIWq4Ra2IT2uA5ikC9HyKjXp4VXYQ+M9N5mhGkvWyi0LmrMbDnSXjarMBO7i5QJQX15NsxEXqqnHJnKmCBZN9Z5Qy81ae0M8tjWV8n6E91GLAc/g9cyIzsteWSOvcBA/eee1O5Q7ks3Ot6h2zCi1YoCwKDQbWTbi/GjHFI0TFroxCfOwxAYJYO7lixyTgbQbcv8Rlt/h/DbWpKLfZ5mt2R3vmlBFGsWYOcZtqh651JbaKx1dETSN23p+87ReGh4nzV+7ook+cAfdq3kdLhQJ/cspwBsQoxLeNYwTNVBHD4xdWgcRwwt9Lw0GVzIxHvVMUGm1qAqWV4FMvZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ivoMqhbVpTlCsWgaCRhQh4b10J9z54KD0MK6bNj4Vq/P6YNteLv+PlSE5r7A?=
 =?us-ascii?Q?IOzQijRXiglCcLoq2nKUHiRMHXlClaetgNDKcI28FWkaqGlNEgV8I4P2SJG8?=
 =?us-ascii?Q?j7P8+A+9RlwAPfRl0FclNEYcnhw8Iw1JXUaBCf8drrduCYscdKUaok4uDM01?=
 =?us-ascii?Q?KhwHrOb2IgNNfPsWrQeZcca493BS9ylL3irLPGqCJEQLu3GykPYsxJ/gcy4C?=
 =?us-ascii?Q?Sgid8/Q/x7LGLNPo4R0ooHqwO6JS8gZgBlh6kco5CPiraxP907vM+oTzhnF/?=
 =?us-ascii?Q?8r714BNRnBEe5oTN/ciEISW/kF4PscH3V5Ox0fZRSZ3E8nRC8PgBsoq2bl8R?=
 =?us-ascii?Q?HaNdoNu9GdWV8mEZxwjV2PgCvP7m17ZhQCONNb1VaP+wfy3zAezzh4QAU7V5?=
 =?us-ascii?Q?M7S7m1MynI3kVjT8yxIpIszQwK2Mm9XzM+il5PchKFUhlnTLX7jf6fpV+9IX?=
 =?us-ascii?Q?xFE9jcyteCc3VuyA+cOy0uwI9IFBwR8uthbt9RlkVa9Y30Mte70P/Hc9pGkw?=
 =?us-ascii?Q?XRonBUiS0R2GKadMAvw3psXdQgt1Sf9Wf3+k2ccdCABpcEXboeGMmwXXfeEi?=
 =?us-ascii?Q?Flnv+nTfpI4piBBLFWufI7zVwTuEW087W7P2PvBegdb9+LRI4Anbcdgme8Ep?=
 =?us-ascii?Q?8oNvNpYOwK4JxBAqsaSTKcHng9BX3kTya37SphwArd/DpDZtgyznJqA5VfcA?=
 =?us-ascii?Q?mzCZhiO9Tqpbh5J/MuxY2J9ucBcN5MNPa0oRlZlbkDa6ZrsXLfMBpXNvlwif?=
 =?us-ascii?Q?F0Gxb4By2X2P4bQYmM3No5lgmzxFCn1q5IfYnD70d56bdYjvw25m+TYA/htp?=
 =?us-ascii?Q?810HJE+T96OwPaDb66QgLZ+c/JItZHXfKNDmIp95Xzcy/wsM4vaYvRLGDkB2?=
 =?us-ascii?Q?wSZtJsurFaHJM/HaPQk+Wrv5DwIPRgbBn5MTZ4u+LczAMd0reqP0FJvy7NER?=
 =?us-ascii?Q?kMI+vkr9bxioPUrrvlS5GNMQLYjrrnitKsNoToFx6fswTeGekSdDoFUgRWEI?=
 =?us-ascii?Q?HCWZHkccoDrd5ZV5tWzQnue+1k5pfg331Zm3ZbGXG1jc7gLkFPtscH4ZXHHD?=
 =?us-ascii?Q?cjKa6+Y33x7RQ4bayEs9u1Hp8PfYx3a9wiHRai0qZ5KrF1y62QM4DOr37Cng?=
 =?us-ascii?Q?HoyHAy7wgNPnAj5a+/BX4I6JDSqTGwQ7vnegD7g0cq6UILeJx84qlLFSPo+h?=
 =?us-ascii?Q?uT730MJPC6hi/HvFEk73761NgtMaWJ6Two5Sz7/5W+AbXYsBi46U+8Yw9Lea?=
 =?us-ascii?Q?I/q+kUtGTSkRfWXzbP9vCJanhyht/0G1xITI/M+6VrcEzR96Z7ZkC6ZWaBCm?=
 =?us-ascii?Q?ZJubvATS4cC/NEiyVMMMaCwwWQDFz0FroH6gKnxme2H+KQDFx3Vo2Ni+rW87?=
 =?us-ascii?Q?JW3sbVsuoWyz+zMUdnMKivoOle/+e/0YSBJgrP1pLldxKdIHG0wBkd2bxSVY?=
 =?us-ascii?Q?TKbFO6sJm19zm2d+wGWW52zJ6R4KZEfDPYk4wEd+ZXh1nC8R49glNpNhd4VQ?=
 =?us-ascii?Q?4RGoruXB+rqV42qnsaBGzgURGZ2xe5M+oJZKsov7PlUikNxyNtYs9ymwkBO6?=
 =?us-ascii?Q?Uxbg5cxNJaR0KU2nTQnoL2Iuy9WBa5+tiIT6ZHwKKgesmv9M1GaXC050dCYi?=
 =?us-ascii?Q?RqJfpxe2PBFOZA4jk9+ZHYHVeaWRS14AF+l6lD/FIshKb7e62fziG7ueYLxU?=
 =?us-ascii?Q?RWHiMxhVBdEjZ70ncLg4qyPcnUwvqtcbD/WK49TysxJCBilio88xFk0o/MP5?=
 =?us-ascii?Q?nHlBItHMHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EQycHDoR64MGEUJna1Uz0sHPEj1OOLz010t/jph2Hhsq22sx/4XsXxWracvupSmtXhBLkqDesl7zg2nnUClOQNpQMmb0oGuRf3HOTntliOSvI+GdRrWbHASP3KcTKWad+tQsGbUwEEorGvFH3q9mWN7fVkUv/SUCx0oRWPylCInUXhynofrzziXV8g/fnNce3wJuf4Km77no+/FTi6hjhPcMBInjMHIou2qL5x5iCKDgfPC8/H+ZEM6IjhtHjryaFNYUSyPeiiDnD+LDCjSs7TYTuI+Rk51mvK910f9rn7vYPQr60XwHklsUYvTtRr9j6fg6JgcM1/cCbVCWUvy91Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d038c88e-3c23-4975-0310-08df45a5e34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:58:09.4339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VB19VHMWLO3ct1iSBvEvymSsKJ3bg1zYrVXJ7NmACeh0U0WQm4hK2xu+nji8b64jNvnb1ELOjT7d1MLxlv5Y/K8Pc5bePDHAuXbp6or8m/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB015790
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
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Tuesday, October 13, 2026 2:13 AM
> To: intel-wired-lan@osuosl.org
> Subject: [PATCH RESEND iwl-net v6 7/7] ice: Release control PF lock befor=
e RCU wait
>=20
> Clear ctrl_pf while holding ctrl_pf_lock for write, but release the rwsem=
 before waiting for pre-existing RCU readers. The published NULL already pr=
events new readers from acquiring the retiring PF, so holding > the writer =
lock through synchronize_rcu() only stalls sleepable users.
>=20
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
=20
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
