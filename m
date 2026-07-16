Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3026DC4450A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Jul 2026 13:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F34656087B;
	Thu, 16 Jul 2026 13:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id an19ZutJQmFx; Thu, 16 Jul 2026 13:06:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D8E560872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784207217;
	bh=pcTW8sQ6j9On6lcf2o11a4b48mCnmaW52jmx1BEXJtk=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yO9yO4igCVrPVr9XTAhNcw+lARUy9/lkKU10l/wiMvAY1BKA2kTXqQ4cz5gexU9Cc
	 aGldm5NAQr5c7DoiIM6gXbrYJP0zZK4aqW7zweK83EwjuHKOvGW3n7QtbA3d2rJecz
	 yk9BPZ+UKtS5lXZDvh4A2HyHl83so5Q3R5mTwAIOlOxHPgADc971micVubC++kDJfd
	 9iguVcH6pjWkD5lBZOch5QpCUSSjI0LCwMwGcUhOgM5muAgEDRQP3MdK/voZLOn+ef
	 WkhG6OEnldlQ1AptTnjICGqRmfARXHN/dYU8jpmj/QS+4hhskmPZWTaXXwC39Tvewy
	 X29fRGkf4Q0gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D8E560872;
	Thu, 16 Jul 2026 13:06:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B051426
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C65940568
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlxNRE0B3xGe for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Jul 2026 13:06:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6E67E40557
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E67E40557
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E67E40557
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Jul 2026 13:06:55 +0000 (UTC)
X-CSE-ConnectionGUID: 8jRbGYT5RWWNrG6NR1U9FQ==
X-CSE-MsgGUID: q2gAHGkKRBiUFWRu7B1b+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84720121"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="84720121"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 06:06:54 -0700
X-CSE-ConnectionGUID: 0dx1Rs+BT8G7ZAg5TOt+TA==
X-CSE-MsgGUID: gdJGfs7oRl6uBMDutUmT3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="250135406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 06:06:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:06:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 06:06:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/sY/7n5V1X+yInckrAsb+Jeltx+WB0H4OoYCIeR0q9CH72I+3W8dRRCyAWRmHjMaDd6C4+R7qy0HCMXI7AVVehTyD4IrnDK7QRi2Eex8FqEMTUVAgL7t2LK8teN3tV0lDtZsaU6QyIpv8vYvXVk76Cwaovns2Xfbz+zLqmpsdn/hdYl+CsRH7JyXmBR/4TWDieHcDibHdh/XcbhURY8jaTKWTj9jEFKF20hyP4SdfIXvxSPsZuMCKw/PiYYNfKDrSbaFvEh1wyqh+Fnobo7JsAoAlVDCIzGhB3Iya5+idq/Nqb3zI+5QcZaXJZJrPXzSh4kUEInbENocvmM4QXnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcTW8sQ6j9On6lcf2o11a4b48mCnmaW52jmx1BEXJtk=;
 b=uexD4Zx9R2QepZViE2bci+ehykXrf75xj8CxZVjLdVef4FnV+J2mUzoG65HhTw4ZnCs2QLj51kWrtNoABinCQRyJ1c0AzeLqNrFQtC13aOGWPNl5iqybszfc6RFCwcIEZomT4TfvHpbEnXiQ5NPpDPDA/OVsQeOEz65QGgxv/ckfMkPL4QB6hN2iwnZgsg1suUn77O9fpV+oaCn09cYSlyR5JAPs9VWpujtoFaNRv6baY18PGFDKHqqu2ZSOQfiBXYcJ6ET/P0Yn0DEF5bp4mqneyI83bOPZYbPrUayxAm5C26uEzaJsUgan4VztmlrPOoqvIE6x+s4Kgnl5crAHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:06:25 +0000
Received: from PH7PR11MB6858.namprd11.prod.outlook.com
 ([fe80::b606:2c8e:e783:d585]) by PH7PR11MB6858.namprd11.prod.outlook.com
 ([fe80::b606:2c8e:e783:d585%7]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 13:06:25 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Thread-Topic: [PATCH iwl-next v1 1/2] ixgbe: Refactor device operations to
 check whether netdev is available
Thread-Index: AQHdFSN8v+7tmDOhnUWHajUnbYAl5rZwHP7A
Date: Thu, 16 Jul 2026 13:06:25 +0000
Message-ID: <PH7PR11MB68589A68491D44E04E0C9CA280C72@PH7PR11MB6858.namprd11.prod.outlook.com>
References: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
 <20260716130254.309674-2-horms@kernel.org>
In-Reply-To: <20260716130254.309674-2-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6858:EE_|CH0PR11MB5218:EE_
x-ms-office365-filtering-correlation-id: 4e5aa382-9712-47ee-cb64-08dee33b0ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Ng3z43PS1tkOZrH34jMLGRU9oF1mJu5g/KPUeL7tOdb67BPlCMWFOrrk3H87ynpKxzjpvA2eWtxsgG47aSlJH0n9bBXr4O8kenWXjDJnPBcr5rhGb0qa/VV77Dlkrb+bGJRbrrPxO892U6md/CXB1VcVxqmNX4qShg42B6pDr7cgngSWRIKiDdgCRgLXdxFyNmTEHAceTcZayuLjwvABJl2J6gnt+XGoY9/Hh83yUobi+CSKgZsEjdc0HNBydAvJtjKwHMm3g9LDChBdQ8nuPS2mmANqx2gwOm7CbvURx2tjNc4iBinqXCKZexfamo+Ng6FDhhKuVDqhrwzT7auAZVkiWPabpa92OVcjLwyq5Mau4igYFCGpY/tIsxNSA3ifumrloQ8WZ9YlRCxOprBfjIi5LnDW0NZVKUoYXqfE23WVxbt96yQIqtKR9qrNoGcwpoZcmw68hKyjQTeZakauBQXLc+fpKrSfTtysrVNbouCr69/NhUPB8SkZoICRL6g8iFBoY2HmWhOY6d6i9PgWPvxMRQ3ASNZdnDYF+AriExFNkw6WAH3Qd3gtwyTiI4PRxpNN30sM3506yYn87Jkxy0cos8bwowGUkPLpnI3U1C2Ofw+Y4Hya8KJl4VprvBp2L1oOK1hzwVhLfS+vrdtzMkKuWPeyjhC9+caTpoPFVJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6858.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sBCLHeIfFwV9kexmk45D/Q9qTj3KJ2EbEjEkS6UViKwy50yI6GGvaRposFQ?=
 =?us-ascii?Q?5jHPE8YL/EqFnF6/l2T5PRtSZyVQ6tG1jLtNvtOdL2j7alQOkkGwxmVBRbpY?=
 =?us-ascii?Q?xVYKpvtQ5jaMQOY9RbyOfF+CZK5XHKxKgxqNpAoG3TzlwbI0ISEgWxh+TMo+?=
 =?us-ascii?Q?j4/RLdrU8Ypuvy1Ai8alGKzVPEjjDre9jbl2+9nnXr6BW4hXD7tvx6HbV/qb?=
 =?us-ascii?Q?EKW/vpT8BBks1NSfn0Ib7Sp7wjkXEe4JyN7Cg4/wk912P7AAHBjFNW6cw5JS?=
 =?us-ascii?Q?eq2ebRp0Lbj6RGKlI9qFeIquQ3TiMqSasuDSqzIVexcQynVRPn/sWqfhY4Aq?=
 =?us-ascii?Q?C+Mi2o+8atclkd+/hH/eiKnDLuGsh0xllol0a9B1sbBMGE8+vz7zDzqOOshk?=
 =?us-ascii?Q?j0E2C8LqfN9nDLCidWmQfdV+2LZnxtlKIDlz3lfDFFvVAeN+V5qeLpWZuPIM?=
 =?us-ascii?Q?BXLrFoLvLosAkU50t0v14+c//Jt1jf+CP2iESACGiMh6h4lZD8AB/uFSs3tI?=
 =?us-ascii?Q?ag1Bhe+KZEKTZ9h5zMe9Q+sDaaLBIx8Use7n/546bZiCVSSgrEUXSrqhss3E?=
 =?us-ascii?Q?S9vekkmyiTxCvb4x+KVzwT9MUuRfj2NYIcjlMPWDraXcu6leavK7Xy+PIuhq?=
 =?us-ascii?Q?z0QYW66+c7gQ0THHorIM8nweSw61ZJZ8QKkb7GAk7Rq7gfItZMimRMuhyquu?=
 =?us-ascii?Q?2nfx6gDHceEJaq9Jd5QfrLG1qkXeznzn2ROwfvXz/Z2FeXm9vEn+Wuw5Rqxm?=
 =?us-ascii?Q?VjTSAB9Gp6IGNnP10C5p2MYnGlDo+lZ52Dllr6chj6gI64SUMKK2S+fM5iwf?=
 =?us-ascii?Q?etmm0hC1EBAddZMSlr3CYKA0cYSKDxUyL+SVipMK8gh/3Se3OsmFyL0eiJt5?=
 =?us-ascii?Q?0irdfnsj/R/J5cT5656o1sep5MyxetJBr0h5JvHRH1IUbgohNYx054mocu4U?=
 =?us-ascii?Q?yIhOmDeA72tSdDDmOSE1Lt5bDvZk6r4B91OEu39RBkJSKe5ayoeJ8MncKvpo?=
 =?us-ascii?Q?xj7u6/Bhwv50pcGsxR5BuORsrnqHT4CG4PpHAQsJWbXZyJ3Psc+D/ZvXOuid?=
 =?us-ascii?Q?EsnGQ61ilTfdtdbLCrFC0VLDgavc5TR+yxgIAVomCB+r2APAtMZqt9o5pD9Y?=
 =?us-ascii?Q?prAHM5TRLqWWSHzrvrg+MVlr6WKrfq8P1Tf3qkmgq1MnlKUI7bnqfL4eSi8Q?=
 =?us-ascii?Q?6Ap8C+Kxq/gqYy+VLiWxq31pyhPIuyfCOb5aZlvjatPKLDmcXIDVG8rdJyml?=
 =?us-ascii?Q?mKNvl7UcoJjWw6UBOgfOdA/ofKjZf2IDJWX/Of1l6QZ41zVIwQ/GLK/aX7KY?=
 =?us-ascii?Q?FPG8tbTDk5zFItkGXOuEMm4KDa+pqhufqK1kwzRgFtRM+T7V/t+sB91zk04y?=
 =?us-ascii?Q?4yAbV28aiHM8LRivjve6sB0yPvihed5RKckHbFuev6gqLIdp5URGHhNTjlLg?=
 =?us-ascii?Q?lOlHyt3pVQg4blU9Hkan93s0QjaGTU/C7Lr+o34Ib/zRVLH1hlAGg1tcSoVx?=
 =?us-ascii?Q?ZKIsp7q+sqdxQm4kfJyhMTCP5g0U2eVYbWjZKLfXDF/80JptWrNB3XQXlWlL?=
 =?us-ascii?Q?bfQOXZveeJ8ARtgjTw3BSa+vi0ozhtPbeadLy04R8ZzxEmv1aCougQXc5F4R?=
 =?us-ascii?Q?xPxNbD/7Xvfl9bL/u786zFfyv+XytGr8xBYf1cJBq2xKAp8nkKWmWwDlCFcm?=
 =?us-ascii?Q?1QAfwEQhh+PHH/uKRSbPlqjrpA3hrmMoa3XQtIDo8l+bJXsKVp/nUvHRLUx4?=
 =?us-ascii?Q?sBWtt9H8nGr+SWAExyEMOBUmFbUBNKk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kcURVxwGZj+uL5+0le/MITxTcPz1cB9RNkqjGbaqDu+jphr8pgXJBjhhcNnSiAhxIbEdAsgZSJvSuneyVOhFlYQoTQ+20LtLEU+d9UKm7OJJARvDYTpNpskh7SnuE2BxJ9ENX8+hUtK6A7YuQM8mcqlVQCkFiVODUG6KuLu9Ybs7SYOtRfmuVPn4uoxf6VdzKmPhhRn2DBVHhOrdKwCnhADYsGhL64rXH918FnMt2qimjfWTYpuSrufPp0DaeFlhrh5+KIt/yO5WgRJ95padMxn6dbqdnti5kE8xk7tT+CC6+iDB16mmm51v8k22ckvBMWa4B7glGdOL7VZ5cv379w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6858.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5aa382-9712-47ee-cb64-08dee33b0ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 13:06:25.6467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1seQzPj/P2C1zNwGzbQAE42IrZzJW/0+TfLa79mnnv8n26jlFrvpGqgu/dWFtOcl8RzibbFg8PZIAo+qx8NaSz1z75Q0lHJjq+lGgUk9gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784207215; x=1815743215;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DA+Rh7iZcMdLlFSlv3HNseWii5uhXEp1aLyAD68EQuo=;
 b=ZJnm9E9kGoIIZpkH6N54DkGuwQNFSFBTd/WD2EzKDjEZPFl01DAuNlHm
 tt67zne4zpxJB6Wx+hzZ1UXaCqDetVxfWl25U1TtmPd4lu8DQI3TF9q/z
 pYaStQdbRH1mBQtxDh1JkVFEWqNGGkv9s8ItkUmt4+NYtBJ4Bi0cTeZZf
 2c7LCWNoBZZGcwn4r8EXU/vXVAMECu0O9h1005Eka5Dni56EtDIHTxrrc
 ztj2AL1NsbM5bfrOwxL21oOwt242JJxDiaqA9/9M8Wjf7Wlw+Jf7iPTFd
 4WYYw5yUgfLfO6BAQSOTxh25alLvYGN7QC17rts/kDEkLk488uTJsJS0L
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZJnm9E9k
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] ixgbe: Refactor
 device operations to check whether netdev is available
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, July 16, 2026 3:03 PM
> To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
> Cc: Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Subject: Re: [PATCH iwl-next v1 1/2] ixgbe: Refactor device operations to
> check whether netdev is available
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> https://netdev-ai.bots.linux.dev/sashiko/
> ---
> ixgbe: Refactor device operations to check whether netdev is available
>=20
> This commit refactors several ixgbe driver operations to check whether th=
e
> netdev they operate on is enabled by introducing an ixgbe_netif_running()
> helper and adding netif_device_present() guards across the ethtool, DCB,
> FCoE and XDP code paths.
>=20
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 8873a8cc4a18..12361ed58a0f 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>=20
> [ ... ]
>=20
> > @@ -10954,8 +10958,10 @@ static int ixgbe_xdp_setup(struct net_device
> *dev, struct bpf_prog *prog)
> >  			synchronize_rcu();
> >  		err =3D ixgbe_setup_tc(dev, adapter->hw_tcs);
> >
> > -		if (err)
> > +		if (err) {
> > +			xchg(&adapter->xdp_prog, old_prog);
> >  			return -EINVAL;
> > +		}
> >  		if (!prog)
> >  			xdp_features_clear_redirect_target(dev);
> >  	} else {
>=20
> [Medium]
> The xchg(&adapter->xdp_prog, old_prog) rollback on the ixgbe_setup_tc()
> error path looks like a semantic fix rather than a refactor.
>=20
> Before this patch the error path left adapter->xdp_prog pointing at prog:
>=20
>     old_prog =3D xchg(&adapter->xdp_prog, prog);
>     ...
>     err =3D ixgbe_setup_tc(dev, adapter->hw_tcs);
>     if (err)
>         return -EINVAL;
>=20
> while the ndo_bpf caller dev_xdp_install() drops its reference on prog wh=
en
> the driver returns an error:
>=20
>     if (err) {
>         if (prog)
>             bpf_prog_put(prog);
>         return err;
>     }
>=20
> Can this leave adapter->xdp_prog as a dangling pointer to a freed bpf_pro=
g on
> the pre-patch code, which is what the new xchg() restores?
>=20
> The commit message describes only a refactor and does not mention this
> change.
>=20
> Should the xdp_prog rollback be split into its own patch with a Fixes:
> tag pointing at the commit that introduced the missing rollback, per
> Documentation/process/submitting-patches.rst which asks for one logical
> change per patch?
>=20
> The new behavior also skips the subsequent if (old_prog)
> bpf_prog_put(old_prog) in the failure path, which is a separate semantic
> worth calling out in the commit log.

This part is going to a separate patch in v2

Regards,
Sergey
