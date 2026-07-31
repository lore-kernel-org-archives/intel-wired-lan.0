Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87564C55167
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 09:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4398B40F2D;
	Fri, 31 Jul 2026 09:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjDri8ZiR2cV; Fri, 31 Jul 2026 09:14:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE41840F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785489261;
	bh=bAWlBzkdq2TKwLtUWMokDS42/BFYQzpXJYjFS2UVwL0=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mlpg2a5B1QQqrFGD5dsuUt1yAFqVxjDOAAmwLTllzmebK5PAui4RN+tbT6/klDaQ9
	 ghyPMLsGo3tYx8HydXsF5DudWSo6iVujQxaj8CQRZ81/yXdSqLxH0mGkrmkK5jEjbl
	 BajOqBZSgUIGsf6+FLmkmGbU/ZPX2UbDWcCsnwwQOwP4bFhheM9/lBtlX5oSo6ttU+
	 +TlU9G0JFuDF9nxcZunG+K2ncw9el+0uSvIzF5XfGJClFhKnw0uHupzZ60pxO6M23F
	 QyuzUWtc2j6K0pamORu9CAduUmd7s7I544Vf6cIMevvhob1BXgz9LVMIoHqJrmhK42
	 yMUetsoJs2bbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE41840F28;
	Fri, 31 Jul 2026 09:14:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCAC52CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 09:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE50F40180
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 09:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsBEyD1iOy-Q for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 09:14:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C4C5F40149
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4C5F40149
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4C5F40149
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 09:14:19 +0000 (UTC)
X-CSE-ConnectionGUID: lCgWaUlUQ+m5Sm5sf7BLIQ==
X-CSE-MsgGUID: 9qrOatFAQ/iK5zMPLQ2tVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96701362"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="96701362"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 02:14:19 -0700
X-CSE-ConnectionGUID: 8K49HdDhRt6vBXwR5Fh7Pw==
X-CSE-MsgGUID: Nmzvj5zwRiaxJ1kJtsMu4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="261141130"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 02:14:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 02:14:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 02:14:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 02:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyPF4YoHCH0eEbwBui5tqjSUAnb7+dbtor8UKCA8DudZ/1DHdhMj4Oyo8mNrF1VO38/Z6JwM1vUZhlfDe00Q2oYXu7+ZUEect9lbCRIsXZVDoGYBWZhfEMtwxlPHlhf5QrxW7qWbgzIl0yKPs55x2O+Plvwhd7HDGX/gzd1Wt68IqI5MWqMGh+D2D7TqfB5Q7RzUD8BRsO0/63zNrrGuDydNPGPXMlDzMl5XvVd9mkiJp94mUJiz7Cau9fRvdA7Sx5TJBxyl7zKYouDIUZeGrecEu/tYQfPfFXgyHKEunxsA567O/wd9XB/0eSgoE8/2zcfZ0CpiieGtXYw9esuf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAWlBzkdq2TKwLtUWMokDS42/BFYQzpXJYjFS2UVwL0=;
 b=HsoNl/ew8WuyFvRtgVSWyfXAy9pdJg5BkunjhI6XLSCpDzg6kicIGgpWIdJm88l/1NuaRjwMDsYTXoTzf/E5Evn9Hnpy58QP+DrGs9uQoe6mKjLdZaxS/JRuhLJhQSlrp4zzK5E1x4pPaV+ytaKxq0+bSGcT8ELvRg+9eJ2CMk67DF3w7vc4bw4VCyoq+RMNtM2wea5MjrsRPXs9QKUBkbL3kjxkdxJj/UNIyo+dShOcQJE6CPzaBmzTzsIZ4pepm/nwqfGNCmFzdha0An6N99Q/K22njPUG/H+0HE0ec8p5nApD5rcm8XKC+i9ptI/6rHx31qQzl09mJEGWycbwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 09:14:13 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 09:14:13 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "David
 S. Miller" <davem@davemloft.net>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ice: fix stats array
 overflow via proper realloc
Thread-Index: AQHdDZurOD1PBoE/Tk6Umc3NKd7+5LZrhcMAgBv43mA=
Date: Fri, 31 Jul 2026 09:14:13 +0000
Message-ID: <IA3PR11MB89850D895D80A4B77D4C81598FC82@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
 <20260706224346.22546-2-przemyslaw.kitszel@intel.com>
 <20260713140416.GG1364329@horms.kernel.org>
In-Reply-To: <20260713140416.GG1364329@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DS7PR11MB6064:EE_
x-ms-office365-filtering-correlation-id: 7a66c6c6-c53b-4a97-8000-08deeee4168f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9NJHOXe3pdKQ6kQMgvYFnUU8j7J3Z5yAfhOCLx5FFJ85ipn7HSRDG/3MvWyTghhh2dg9rw02rpj/u680gk5kZjj/N5F/9MRuU6ETNQPJQl5knwfhiK9vQdDW2B9S4zQhotMJbd4wheGyWURyTaG5LYQN42VQ0RSZ436X+ex/tQ0XYI/sKoM3hKVvPKD9zo4oN99WkYddrb95Ouo4njATbgmDL7KEEVJrgdQUYDRcLfS2dlbCzwTIWbkr5ZFEPzaZCp1mnBKO8PgXPmmUSPI+YQUpAieuScmnDQkq/JzxnZX5qDdEppPWvmPUmL3DrxfrafxcqzpJEGIYswGLj49XizARlt/siI8EXymm5ZEsfMH9nLzG4lyz7NgXqUu5adcHSt2BeRFTRHCbcigdAab4MIAx279fWoI+lGiFIT0VsV5OygEA4KPoqdrs1kQfAlbcfZhjeADIoWRAmcSScnqz2TDF4bqyLJ0HLV/w3RvE1kvLrdUociASnEEPHbqYx2F3EUuXt6BtMFC4cx49Ayr87UpyWMSR/qGKETP6lT+8/5NIvUHjl0j/KsaDHJprNxSNXnnHG0W7So+pv71q63bRhBQKBj09MZC1GRFw4DdAw0V7z2+CJN8eLcX68InP+bg4CyWS5JgbOtKh2D45KHn1nDGjJ3gz7YuwixhpqDaZ3F+O6r+KxgYTi830YOgW41oynLJAd3mJoOYqSK4M6dXwd5E+tYPQM6qfqdP9/9tlwzY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?80WVVNBlKRD3FheUExbCL0cCkHzGMOC+d46zBQ8OvIur9GgeGQaOmBGyRWxn?=
 =?us-ascii?Q?uPBsjBbRB5tTktVR9gNagUJiPYY7MaRM6a7Rz5Ulqb2iByQTMxjuIGUT1td/?=
 =?us-ascii?Q?RJXUcl/A9P5OcYR+LyyjKgGXgxZns04tN05/ubrlxSK6A15Z9ywlAZyaBvcL?=
 =?us-ascii?Q?g5NJm2YGhPAKSISZjPP5J7BUWTzZUtFFAOLrmEdV4x2QLpSuW5QkPX2E88SL?=
 =?us-ascii?Q?+Kr9JzApbln1qleASAERX5sayqGIzqLcOsJX651QiHQxl7OSDYbFiS+IKzId?=
 =?us-ascii?Q?ZRyS92vIhlqpj4pXdXcRHa7glKAGIXC4M8VKZhwudqU36ZPcskpS8vHdFWuN?=
 =?us-ascii?Q?UHu2l5T4GxAYsRAQg5e3lyQtI46kmP6fBBy0epxxxY7AJSJjfrzFTjKTqNDb?=
 =?us-ascii?Q?KZX4uCwotnZs/BI6d+KahfYPDW67SPKaJ/tGIdkcVOGplPNyUVv337NdUDAG?=
 =?us-ascii?Q?mmxLtK9roKxEOZRI+oo6MCzkTW0rjdhymSv7xEyAdQ3YTl5/6rrLQX1+0JFQ?=
 =?us-ascii?Q?gc4NNWiDJ/c2oWbvXOeRyZuFoBeLykF56uL4++ZWuX1JBAygHs3nKOAgazwF?=
 =?us-ascii?Q?LuKlsiudIniySly4SoZLk0LWPjuMqDqKdNrUvE8O1jDcZTmRNRvSqbGuFTn6?=
 =?us-ascii?Q?4JL5IGbc3XmHK4TmrOpYYxnsnPBR6yd4ENLDw6G1hjUKwyms4CrnS85+TyIa?=
 =?us-ascii?Q?IXwnC0bePl7bidPot+sLZPbv8LKiqzkVqEhA/vmFLLRuL1WbmTuapNuxofcV?=
 =?us-ascii?Q?+v+WWgN6z47/vUKwy6rs31aAo/Z8trGd5KAEOvFVIPS0uJO8skvZM/Er9gnf?=
 =?us-ascii?Q?JKnJtVwqtxYFvHzsEOf81YmNDmwK86fG8tIgOwFkR6AGXA65P6i2TWzPqFf3?=
 =?us-ascii?Q?9QZxmqSTh0JoquyvbWz2Yr4YZdP8QHjpIexQzkF54x3DxquudLqLNuGDtibV?=
 =?us-ascii?Q?8Fe4wdy/hhCOsBRQEx7nFZ8qieF3YbpyiJtgUCHBq++yCcy6RFcLpMP4O/ES?=
 =?us-ascii?Q?oIjnbz15GdWTUB0O/qRy7wnRjCD4qMUujtTT8GMOF2Q6VRiyxJS9APatp25s?=
 =?us-ascii?Q?7WoyuK1rekt9w7yxQAB9qe9maMHqwUPtqpeFXbDzo/8XDTZWrQzKAHv/z8br?=
 =?us-ascii?Q?tv9mrnfB04gBNWrJ8hv3/o4c+jn1ixAg/sx+TjLczlOL0rA4NzhdR7yxFWhP?=
 =?us-ascii?Q?GlPk6gpzmCZTu0XO9B8yArs5zwq6l/K6i/2IcJ99xcm4EZWq6qladegR2+rU?=
 =?us-ascii?Q?Al3MrnRTFHf3h42omdCh+vCwGThGdX4hM/w94gT7/qivta0LPKH/az7VHOwO?=
 =?us-ascii?Q?nCY3J+BAkqMlNKryA2T2vYlstTnaN2pRmULsUugShQ/bM5rxi84qPPt6czJI?=
 =?us-ascii?Q?dRCG8Jk4wM3sFsgFZ7V4cE9FAXMSfu1XxuKltJ32tFP3eApqXSs8WZezBSd4?=
 =?us-ascii?Q?4k8qUr+TEec4N1osTeA9/sAjRdhhP+GXQhCeUU7TIcyZuOtxjdQH3TNZ47uV?=
 =?us-ascii?Q?2MuT1m4zSr9FG+TjyylvJZ3c+IpGcY8SfK6nIRkLDrIxDv6tckMnNbPngqIL?=
 =?us-ascii?Q?7c9XcdusCjCAEQTs2A9vc7IL15olXOy++iMdGXANkEdDhEpNBO0ZpJXPv8TL?=
 =?us-ascii?Q?GNVXfbaIZ7q7PbnGxfP/4yPHVcglB2MLw5WgT+owIOww/z/xe+q01j8tg3G0?=
 =?us-ascii?Q?/wy30a2DPbnLhY1/orwSk4P0GkPP2sbm3LkMEKgCdGPIE3GKu1b3OTPypvfT?=
 =?us-ascii?Q?gVhiXdrYQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QDpwt27/rofrG0qhH4G8mU6JL1a5w27otkckS4xZiExCXODcMfJ86XpcZRWElJodWJCSOJAXODY+VjMAgbGhgvoXHVjwOPipcaOpf95PaFDZUd+oLyCYKQr8IwQ5F1D6lhg+zS74n6dsiaerGbJ9djddvPtiDeXjH47KkPcfsU3vl5zEh2VUWc+PLiuSKNy2KJ58p3OcgFLf8e1NT80eRE6pT/tbZZlzfrXQo7ooIaYVLDcAeq0JZLTwETu4+bzTdUyYufEYWvAweqsIP5ok5Rr2ywZzECLPbRQjqIYSgckr0qZwwvbgqd5W3rj6knenwAOADH4+tE9Jgo+vqeJW4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a66c6c6-c53b-4a97-8000-08deeee4168f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 09:14:13.1041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAKLPKKrAUERdSkAhRtYmONnbAoqAF8qUdRHVZfS6qMP0dwzecEu9TEq94GCRCcVgwv2XrAy4uAfaV6YZ1Qllps5Is5smyIMVBfxU2A+mpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785489260; x=1817025260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bAWlBzkdq2TKwLtUWMokDS42/BFYQzpXJYjFS2UVwL0=;
 b=NynWh/GVR6iKZTp7PJbWWqsmbxU5DlPFj7Ig8+y1EsO0yq1xqNzUD0Dx
 Gxq9UKftvPvvSlb4g5VFZQdoOu7VrahpmQ0Qw88JjMK4o5YvYAnitXqeB
 femXNXsFD1qaPoswuPwqjCA3AF7tzMNIXXOfzBpsP8Qt/bUeFhcurZ4+C
 j2j1IkZptPa936Cepti6tA6VP9epr2xqTSkZbwiWWNYljCcsv8sAmXdEh
 AnJq/1VEW4FbTZDTNKgnSVAcNzRTiuA0R3ZmfSrQufnpaa/DVqpWXB9Dd
 oR4bODpdBqBjE5+dGHvfpUgIDk5E753icovO3u2pFv07/itlcu67Yzuoj
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NynWh/GV
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ice: fix stats array
 overflow via proper realloc
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Monday, July 13, 2026 4:04 PM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>; Paolo Abeni
> <pabeni@redhat.com>; netdev@vger.kernel.org; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Eri=
c
> Dumazet <edumazet@google.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>; intel-wir=
ed-
> lan@lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ice: fix stats arra=
y overflow
> via proper realloc
>=20
> On Tue, Jul 07, 2026 at 12:43:31AM +0200, Przemek Kitszel wrote:
> > Integrate ice_vsi_alloc_stat_arrays() with realloc variant.
> >
> > Instead of keeping two functions for stat arrays allocation, change
> > the
> > ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
> > entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
> > ice_vsi_realloc_stat_arrays().
> >
> > Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as
> > they were in the replaced ice_vsi_alloc_stat_arrays().
> >
> > This is a fix for stats array overflow that occurs when VF is given
> > more queues (an operation that will be more frequent, and by bigger
> > increase, when we will merge my "XLVF" series).
> >
> > Splat for increasing number of queues thanks to Michal Schmidt:
> > KASAN detects the bug:
>=20
> ...
>=20
> > Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
> > ice_vf_reconfig_vsi()")
> > Closes: https://redhat.atlassian.net/browse/RHEL-164321
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> > This is an alternative to the fix [1] by Michal Schmidt, which were
> > blocked due to AI feedback. My fix was already developed before
> > Michal's, just not public back then. We have agreed to go on with my ve=
rsion.
> >
> > [1]
> > https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguy
> > en@intel.com
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> ...

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

