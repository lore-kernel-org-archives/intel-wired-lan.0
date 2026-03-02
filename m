Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0970DE9B344
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 09:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC87083D47;
	Mon,  2 Mar 2026 09:46:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6m863kAd3an9; Mon,  2 Mar 2026 09:45:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA72283D2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772444757;
	bh=96NbYimysmyANlBuTkgdPGvbhyf3TBsfUOhW1jY45zg=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r4o9EM1tTXq68vaZ3utQ67Cp0TBgbSHm4FDaR6w8lr1doQkSUS+g/PLnpij4yrvqs
	 7h/HSAtEQ0vvY1DRUzrBidO5OO/pGRX2mioCwtkfq6b7wSUIQB8zmb9aMDx+G8xVAW
	 eAh+8zZK4VxS/0Nr7C1C8GYlMNA03mRBbj2WlfuyI3DuY5PS2uvUmSDNMjLSn9Dko+
	 GibV+WGDfFqEbAcuO54s++QDQOPN0WsCYl6zVNUGYd3IOE2X8tF4MzuNCc0nN+NNb2
	 LVZN3M4Py+6uXbVwStVvuY6Z8bKv0d5TCr0SQlCUWsRXbJ9q0Ovj8/1DKsmTNWOxwy
	 tpzY1oZvG0G3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA72283D2F;
	Mon,  2 Mar 2026 09:45:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FBBB1EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7203B41935
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8vGC8C6YMyJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 09:45:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 90DA54189A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90DA54189A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90DA54189A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:45:52 +0000 (UTC)
X-CSE-ConnectionGUID: 1nigjbtpTmysnoMxJJw9gQ==
X-CSE-MsgGUID: vbH5v4zvQ8mvSgCC3oRvCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73356614"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73356614"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:45:50 -0800
X-CSE-ConnectionGUID: vmZixAr/TKyfiRIre8sxGA==
X-CSE-MsgGUID: hHqcHWWQQ0GkJC4yFmtGtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="221754274"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:45:50 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:45:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 01:45:49 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMod5eogduxkOVcml8XAsGeVK3y5VcFmO/gAF94+Pt+QkDI0WySMXiIZTFFh7Liqjx/Plat7sr83Z8VeTJrSJW3u/hlRLLNraNDweYZ309v4L8zhG3F4XMr3Af4mCFRCCAYsIz2CmhuM6/tlX1732eb+LQI62YK9N8gBQzbnHBxIw2Ewd8cCjKRsiB80Jn1v/W0K+XOIFogQtF/ox7geRLOVE7jLDrIG25G2dl72PvMBQZzwaVOOt8rWbQrLqby9mkAxR3Q+DutilQkqDOm7+DcuBPIJkejQNK0bdr0sHEsUbjDQleiFGKiI9KCDkMhwDrmltdXszfqPu27jUgtGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96NbYimysmyANlBuTkgdPGvbhyf3TBsfUOhW1jY45zg=;
 b=Yqrriktj39JP2O7wIcjNDGVzsLvRWMNnpn/qqN3qIE94ASz8j6lYZaxphJe48GqnX/d6JERKLt3ff/pZAOspptHJGJa9Ehp5fmJfSZaggY5KavSoyp7oTe9UH0XSkvswG6iGGV2erKA68GoN6L6GAyEfg6V536CJEy5IlCapVXMTmEBt6mZGzRBM3WDoaP0lc+2xZhZtRHPsW0QN9Vwy3/ub1CRl2OwPo79OAvMCUVWVV7SQ5G87qTXe4Vaa0/7ShVqOsp3s3GCsxcYlyXdOPDUPUMB1PNT/u7hx69EyIslMkj2vFX7UC8zMLzeMMxeOR22jYauhNGvXitJ9Lda+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7469.namprd11.prod.outlook.com (2603:10b6:510:286::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 09:45:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 09:45:46 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Thread-Topic: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
Thread-Index: AQHcqiOWEm5wFikWMEKfzZ1MCPCZdbWa/k1w
Date: Mon, 2 Mar 2026 09:45:46 +0000
Message-ID: <IA3PR11MB8986BF4BB6AB02FDB0F84658E57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7469:EE_
x-ms-office365-filtering-correlation-id: 0c871eff-5586-4e18-dae2-08de78407a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 9H98jJkVIh89URFSsf52gaWOiQM8PC+WFRESa+A6aA3g0O4bp3qLxnNEuzkwMCouJHUVjKPGDvN7TPIvGt8LmUjnaTvJ2oesi1Zn7uXWWJx8GEpjuVjaqD1hJVyPPoYvrxHPTKzxk2kqVzKeStW2nSDR9laalfQZz+zrNtZ5VDb3wAq28ftb2O06++5PJ5KJhs52EIrEUwKtpqd3YZlwAhFfoPdRWIWRVgvPESa03n2V1XYOjYKtPIfnbe+q1v+4fLdSbkc/RwFd90aGyuwJwh5Vz64+J9hKqdOMRgw4+CrvMZm/UrcHRy6rv86JCQFgtf9+WNUQQGd/bwxJXx8Kjl8eXEvV2nZwJz+lYYp/9toIDv6vxH+fqY+B4AGvJTiWPD0C7oE2a/sQFKeoaVSwFptcvZLPQjukxE67CT9iU1IwSJ+O0FwZO0z3PZIhs+dIa7Af7ai8aKEL+ReOuANCcIK6BX+ID/HTzr3z21Z4hahkNBsez4PZBX21cFEwuOMYBPtZFlHLHbVfG1Soi7No0Ym/rO1CyssiVn1QndzG0B8KOpFqCVprW6QjkuJWB2KZGZ4tcKE979b5wFfchV5roPwNYcQwrQKGAn+13eCSmrYQcsQEY0MpUvwEiR8SEgB8NlwymP1JKxtfi/8NPVLinhMkKonKzZBhjgIacVCsP/pFkUvyKEZC2z2nerx30lxDBXtCf6xQmzGmj87yMozn5cv0yCKZKwz5esXfKSAz+WA9bMc5yMctuWHJOPOoZWEqAYg0jyM1dP4eOlcgA+Yjpmeo2O4L5s3uKaNI5ycJCcs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y2ziUto/8dBq4ObxCfVNsNaP8ZYc+z6ki9NXKxloEugIU31VkxG2ptEo85v3?=
 =?us-ascii?Q?AN0XblxwPa0iSgkCU6sMSMOvXEX53C22ZJDnuUZfYNWNzirs9hIIBPvZ4u8e?=
 =?us-ascii?Q?mRv3rIT5Y+2opXrhijEnv7s29Zs/5OK0n25lvnGICSRJz9/uw6BVAWVGyMYe?=
 =?us-ascii?Q?FyqspkH2bNK3oVBqT/xcTYy/OjQoACw85u8Gt/5txuPIxGTH/I5/QzQd0saF?=
 =?us-ascii?Q?YBLAS3t1vTz8erbjNk/ulM8bDjLMnwSbNxY86kK23hm6KXzDOLG3t0K5UYQV?=
 =?us-ascii?Q?i/p62d8hSQfuFC+jRqeZBRHlyKmxrXglE3p4k39C+82uiSlvbIkLE5qTTT1I?=
 =?us-ascii?Q?ikBuAdTRKHoWKThmYX3GA7SpbaH98/41FYJwymlZkxRswILMvmlg5+6WOC/e?=
 =?us-ascii?Q?UWUzn/e62vSFEdBJ6L0dp/V721Fp8+ztq6bj8KAEUptsnWPWhfMn+6fwMaEF?=
 =?us-ascii?Q?eLU1wuQSUMtfdQBRaDNpVBmRNHeaiQc+wnhGdUQU3BHuxcPBpI+bf6wp5KXU?=
 =?us-ascii?Q?VaEpWBD+ptzCtIaHZX/dpfb7yDQtCcK5HGY+1xrheETboTCpa3db+vQlepOz?=
 =?us-ascii?Q?ErwhMTOFLzruS750MKARlwAMin7MO587DAeNV3HDMBVtdYHVARXTIe/tcPit?=
 =?us-ascii?Q?qU/tjHMGoIAqUlmJzwYnROfWbrpgDYIkO3kDy7cWSmsyswt//CnsVLMTpRmC?=
 =?us-ascii?Q?SA9NLf0it1zqlAHObRHh+2vt9P5opiuexHiLbVZItuqXpfY6G+hg42yZ59sa?=
 =?us-ascii?Q?r75aTDFD0DeiWPUbsNn9eOER7hY4XMk8MjzgqFUpJoVHEBZmcWN6u8+NgxC9?=
 =?us-ascii?Q?4tDsd46nDFAySBI35fh+YidV8e/VsNllPxpzQFdRey0j8CK1DDpO3SMYBo0z?=
 =?us-ascii?Q?BFUFH5FX9oO9PpchfFV4/o7Ea/q068KQkJWWJYhiEtkJi2EunFzPmz0SV6me?=
 =?us-ascii?Q?2SxaE1zwLly7RM3RDUcOKJMbWez4u8qe+zMnwnrmB2izIE6XdFzyfTntTRKj?=
 =?us-ascii?Q?kgXLl9vAWxGs84m1HJ/P2MnABkW98LSJqsTuh73r4LJGvWigLsToSKf3OWA8?=
 =?us-ascii?Q?FnebEJWHkSxRzNiDOwR371FsAvrcIVIfbvDiXRTCdFG6SpVi4pgDjID1wi5n?=
 =?us-ascii?Q?BxT+EnK7bt/x/6+WGgX6QQwCkHLjfkw4P1uklGYWOgBXcvp+X2++2fVRmYCt?=
 =?us-ascii?Q?UB8XAWCLt+Lml6VxrK3mx1y7FDwI+k+oR42pQA7+ojvTBFwCnem6FMyL/62j?=
 =?us-ascii?Q?ebGDjebf1eUlsRMXecxfZH6isP8lB3VAwcwIMe/YlVl7muKIl9Ez0weK0S5c?=
 =?us-ascii?Q?oSAdeF7PdOnuIs2lBTAXYUTeISm8J74sCkW5MwKWprsUSxAWue5IHp0RSWBV?=
 =?us-ascii?Q?/Ybxs9OnKRx/IQJ0+niA0wHQMc1/k3uXdJTHv0JvCUz7ogkZTZ7/c7SjZtsQ?=
 =?us-ascii?Q?kCHDaZdBzOdx3MSO7+nJ1/2V3QOUyD9ymy1VQndHoVCP4V5YRrgJ2PBFI7B1?=
 =?us-ascii?Q?nWFq8w/viCYOMGgqo8Amc6mfyZU96wJ2iOSMyJaVy9Y608y/tlZ/f7mclvw8?=
 =?us-ascii?Q?XuHEsQVFD20dmFQz3686GFyxZvjOnexflgCak6vtA3GnYiGjeZP13rxGgRmo?=
 =?us-ascii?Q?EKCdlK7VosseMTnXKksIXPVhbJwXR/wdMY2dnpeQNwP6BcufWqFJnwkbSVIC?=
 =?us-ascii?Q?pfS7fk8se1jZSBHPdyRHKM2SkuDvMM+FmpBSpMDLddHgYwmbES6mNsA46CY5?=
 =?us-ascii?Q?g3xu8oQ+Bm3Iwj9dKUnQ461+AvHSRiU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c871eff-5586-4e18-dae2-08de78407a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:45:46.3281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30ifEuq9DzJcNDSoZUWow03B4nJWLbQNsXrD/yJTIEZSUmSejfWXhJjXrfZ6VoZ29CvdxfFxwEGnL1MzDMXA/Aoxn2U5ldhfsrsGhDxIFpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7469
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772444754; x=1803980754;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8gF4az0ZMT70bR8aA5R4e3kQoB4TDhJrp+QhGFkZeh0=;
 b=HQ2eIDR8bmJ2vbV25iPgzAlN0LnCYSoPs7cczfszX0OypdL5WYwsh0dL
 eutjZRigfM1302YtG4bSKEal9xF98wv+asLTmzFFuUckWzFYFXXZV5zRZ
 DVQ/V087/wMlB8O2MIsmBX/6+dpctY8T48W/5OR21sGRP3eC/I4bouF+A
 8DUEAkcySB7s+KVtv6NKB1/gl3TqztVBj4deEa9BwVzb9ZDKKLMU1aKLm
 27wKP3J6G1AXZoFXIzHH8pmy7LBhLDcfikTTFu96r8obxgzyxRcIUmB3w
 KCXwyXOtKBv42muzI3RSoEv4AA3iqLtf0N9cVYvL3No00DS8K0Xx8yq1y
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HQ2eIDR8
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Andy Shevchenko
> Sent: Monday, March 2, 2026 10:03 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
> header
>=20
> When cleaning up another header I have met this build error:
>=20
> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit
> declaration of function 'upper_32_bits' [-Wimplicit-function-
> declaration]
>   105 |         val1 =3D (u32)(upper_32_bits(pa));
> \
>=20
> This is due to missing header, add it to fix the possible issue.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> index 480e3a883cc7..967711405919 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> @@ -4,6 +4,8 @@
>  #ifndef _I40E_HMC_H_
>  #define _I40E_HMC_H_
>=20
> +#include <linux/wordpart.h>
> +
>  #include "i40e_alloc.h"
>  #include "i40e_io.h"
>  #include "i40e_register.h"
> --
> 2.50.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
