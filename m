Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1020BC5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D23A34056A;
	Wed, 12 Aug 2026 10:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id demqH5-m7EJx; Wed, 12 Aug 2026 10:32:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C9BC405B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786530736;
	bh=oiIdLZGc9N02MqAYNKh8WkuSG9alQiyhBQLP/8sWGyU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DU+76+7Qap6XLutyd0frpg/DhXm12KdbzRAumIdg+CgthwvFmKfV0Ha7KmNG17n4M
	 537fO3cCowt6HTuMRlwZwzsQOkpFBxTlojbAMx0zwsXaziLhoruduUo+aSj7bmzjta
	 2Y5aizFKwSsniOOR4PhsMpJ3cDv+uPdVLgTnzAV2NAZCyplxCvshSClIK4t0c11WqM
	 1H6JQ0Dud9ZK50Lv7szsE8rTmQuDzErXSl8DY+5jSAL8xNzDA2tVWMpzG+znKIIISN
	 14V9xbWAsAOIrFIIM+ZUQ+cJEEyxMOWaOkfoXFFTmAYmpnCFC33hbnmm9CAFpgrhBv
	 h1whP45c61itA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C9BC405B1;
	Wed, 12 Aug 2026 10:32:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C01EE361
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2113608CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qIVcmOrakGSj for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 10:32:13 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 84A27608D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84A27608D8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84A27608D8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:13 +0000 (UTC)
X-CSE-ConnectionGUID: Qsi+A6hQQiik51KGIOLIkA==
X-CSE-MsgGUID: cXsNR6LLQRSCcH1azzifUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87201773"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="87201773"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:13 -0700
X-CSE-ConnectionGUID: 0GSpPtZoSiOVgNXeJVv9+Q==
X-CSE-MsgGUID: /ntvkVneSoe09/G952hIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="301853875"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:32:12 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1EeLWVnVeDsA13C2fTPrDFHG4KJCNnjcaM13dX8ffaBbgESrjru8TtHx/mEJ76we7fC231SD7tgHj4F3vP30wpWZ8z/CBm1WZe1CzI3agXI76izlzJZrSnSZwtlr0yGarfO8pRhQiQA2+2iyVNJNmUrpUIVvDQCfv1uKiRSTzlTb39svIZq6eY6+F3ijCOAHOpNMdC/shiq854kW65vgyJIQIPe4Uvv5YHfZBYKrLOwnwzTbLTtnnB/31LqF10JhSx9slZa7tMrYSBFAfKl+ko7CEa+OIJE1MG7yjIj4XPVCl9q+Vl4q377IitTN9pZphqTqHssvbJDEfWCPKJIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiIdLZGc9N02MqAYNKh8WkuSG9alQiyhBQLP/8sWGyU=;
 b=G2bkHar4xFAnLPWWdQrNcH4xq/m3R3ycNGWViB+Kw4n3Hx5LtS8S9jqPeLO6/phrCe0uZZacwq4fQyEoXjTThH9gh78Y+hiBq3cpau85a81BaIIJJnHe2y0f+/bkGBDXlAoTy2VxPZXWO9uR+cePh+/T4FJ5vlTSdkPkqQkqJ2ksBnt4up6tE02dDNr1Ug5SuTuTAMVvBrqeY9zmEY/fZHPbKBshjSP6fQlp0mUckfpKM6uOgQL7cdoBqZNXEuXY0+XDXqOKtDWjXd2N3+RFd0IBPF8WXnsPVgV6JpKLIEh0RfNyrDKZQhJ5bnHVwWpGZi8iXYdcRSq0yFjv4ded2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:32:09 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 10:32:09 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC
 address runtime refresh
Thread-Index: AQHdCgYsixjIjzo1N0GyGjmHa8Zvm7aadWGw
Date: Wed, 12 Aug 2026 10:32:08 +0000
Message-ID: <IA1PR11MB624198C6EAF2691A67C67B178BDC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
 <20260702091553.57112-6-jedrzej.jagielski@intel.com>
In-Reply-To: <20260702091553.57112-6-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6247:EE_
x-ms-office365-filtering-correlation-id: 30a01508-caad-490d-c8c2-08def85cf689
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ZkxX3pRqAo9Hs0NTLKlxHfzharbR8pwF7i4YIzaoKGKLQMtovRA5keueSj8pM90KItqmciNWFPDxRRjLjygmjQtDcT3A7o3/L7vRjrgzXdugjQ0EhCDBDUJ5eZh0onRbEZnXB7Kp3uZGuvzsrINyyNzlUu+c8bBwQIfaj/xpXp90Cv4LEmAfS0hky7BROngkQyRMHfnlmr+cjGGnMiUW4907k9/JbO3va6dpUFAKIfCn1hjHYlovsy7PMjiqNt2yRfnxeLj7ope56Rg2oens9wnINbj5dzHQElGSGG5GypV9HTq0mTS9dyAGTC83lphieq6usMBEh5hnoriJEYTOmAe4dqxP6q0KRwqyk9MXDQEM4X/uo+U1gBn5C7MyZptnSQbS9kqAajscI18sYoQ5Wzw/ZUV9jjWpph5leQc7AMOkEue7L6SAo35w1Wx5ZJTkAQq72Hca5BnGWAt6lsmws3y9+HVrcD0sYXHbqJjeLnz62O/eQWMCj/KN/vdb0HjpGSs4EF6I70Y/bdSlUmVuS1ecujtbGhF9pqzYd25Mtl/FKk+g7JrW6Mnc4ilINcvnl/HkK2YdYbnMAxDs6Ah99fR91wjVNci1QKRbzlS9NMQ0hHuzirBK5tFsKMDwvAGugsvshevQGH4XuJ/PO+we0I/0+7XpK1V2WB0wQn3xIX1vpJWkZxnQ6kfDy4P1AqKnFwILywIzi/2Ak9CeadfP/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bAq7u631xvear3heWHPz3G1XU5KtR8zTNxrKG/LVcREmiuOlsOZ40xYwvBFR?=
 =?us-ascii?Q?qFc8ybv8TD/34Wq+Zb07iFDLhtpNBoYCZ0hIFX98v3Q/G2xB74ghZqHCur8E?=
 =?us-ascii?Q?b1RDh5fQAbjICUuiYFQnDloZjKhQTqK/FLTwxDJ3zEVZKEGJlVr8vPRUMFD1?=
 =?us-ascii?Q?ETyZxXQnhnD0KOxMwwAA0SuVSato/3LVO7zx+bSpoyIF696T+RvXuSjSnM+5?=
 =?us-ascii?Q?GmIzQ1djlRWH0rg2QyIRcHGVNrVu8Ro5Hi7l9nnTIXof7dOKTdW4yqc2DnpQ?=
 =?us-ascii?Q?2QR/QEglJqARWNhJkHZMpyA0dxihAOuxDSNn1dN58UR2DUykRty28zLojGWU?=
 =?us-ascii?Q?Nyi5TFqpjvsc+03VLcHEtQ8c0YLFD7woYvxFvEuMsqfl+KStzxNHBkprxoGp?=
 =?us-ascii?Q?SFHhISK3v/+RDMvkIyXRPM/bV4ZuJ+QSOcKEBleX2vkcSKGR7BI22l4VINLS?=
 =?us-ascii?Q?8+QJG2MnyiN0hllELeHz4THjDyZSfriUKGuocsHRxrKAacGwif42ncSVCMFf?=
 =?us-ascii?Q?yjlcqyZHp7JQ7OgGa6w0sfSyYQXQiU0TufYOEFISktaqO65jMuNJj/rMRWQc?=
 =?us-ascii?Q?YQTH7cpoU+P9+khlfByVw26unaxm3lp9+R1F62fpf+F1C8nFQodJ2YBIMUh7?=
 =?us-ascii?Q?P6+bqiGgQi4rm6FFqOW8/HKmJ64Y3lxfQ7oNgMCIry07aRpFL3spOosgMIfY?=
 =?us-ascii?Q?PsBHB6qyNpCCOi/09I9VBT6L+DtVcW+SAgA2FGWJhKN9WOu+yHw9yckJ8tZy?=
 =?us-ascii?Q?OFV04gWy7emc1DoNZOqt6gKvkNVfMw/4GOEa/hwaBqBVfzkMER7KsTGVMgsS?=
 =?us-ascii?Q?u3iAE7/bWexV4FN7Lt9fNUb0BtEyb0p6+uwfqUu+1IglinHYEfRWd6PrUoD7?=
 =?us-ascii?Q?NqyHQcqHqynGh9GqfVZEzzpDq/YESePW0KaBii4Fe4+PRi8jlbbVlxkvPTKs?=
 =?us-ascii?Q?Mvsm36taPIBZ/qSTfmq10V/s+tpSdb3xp33vqU6NIA9Q7n9ENcJhR72eV2bt?=
 =?us-ascii?Q?JvQ64Dg/10QasA6SbWWrLOVwKo47oKC4pMrDyF1BBCQzorCjuZZTAmUFgmwY?=
 =?us-ascii?Q?+0ub+ahGT+YBjAle6JL2J9AVnSWOb0jaSqzM668vdKcuPS1yCIdInBZm+8NF?=
 =?us-ascii?Q?gxQ7gypWCq5FdXkudNbXj97tp0nFSc/skLsNguRHDj6QGdkmRKm3A1sKQYNG?=
 =?us-ascii?Q?00v7YyK5cygktpB41RVNGSgLslnB5TUAk2ofikl9ScAKauOd3JFkYBzOGpOk?=
 =?us-ascii?Q?JGrXSpaWIES+eo72rMH4S/8YUuOf0Z7Y3z8cCOR6LCJTN1r8fUQ/S9XB/Cy6?=
 =?us-ascii?Q?gLDtxyQLyYiwXpuDwh7uErhPuYQq5/TeeuI3uI+JiChDQsMSZwWT+lAWtpf6?=
 =?us-ascii?Q?noO6jw/YC3VA22OZ1T5rwQf8mc4dwneM5hLZRIX5lcFvATDFu6UOjgx/X0aE?=
 =?us-ascii?Q?RvoDXu8I20+gsskXk+8jAhBOO7jBijasl3ChoVZagl4fuhkyB+iG8METckFi?=
 =?us-ascii?Q?RuBO3rkL+Ges+w8Rx4OzwpA5qrydfRcy/6mXndJxjmMT6rKxaWKxnRpqZ/DM?=
 =?us-ascii?Q?CpVdDdIsRtXVosJAn1t935ktN6ZWGfj/85+tQm5wwBom1OjzEYvCuL1XJgED?=
 =?us-ascii?Q?y7VDIICY5B7sYWFc6MHavcPtZZ46Fo1y672kdcQHprIMSzzYWdtJxIFmXFi0?=
 =?us-ascii?Q?GUdk3/lx3inWrDp7Tnpkkjkc/J8JUHQ1NMsHnYS/vGBSxCUj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QCm0Ulw/K1dWFwAWSpr4LMyebRvG0Viz2F7Gb1+Kgi/HhADL4mHqYZAhL8yHktqAoXgCAPvi+DqgwuWxD3Zs/tyGWoqqDmPY/l2RoERY+C3epDBZpzYPn51ROo4qJmpyJikjtfGEn46gIK84rtOq4h6ObFgY9fO+E/HvINxXoBqa5lVq5HTf0Qs0C7UahS8t1yFzd8ezr+erRIMdXQiPM1SJusDYcggTksIPWpAEzRaphzbDvmvDjs7NP1W7/xoP6FruGpyR/GUQT0kxOtu/e753dUR0SaAjHR7Z1eUMmaPJsrZ+aMiAZtf0D+fHmKMWI/iLpDuTPJh6cDSHL0kGxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a01508-caad-490d-c8c2-08def85cf689
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:32:08.9871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoaJTTgZXf1EPcqqK+4qSx9gX14HicN9lWt/+8uWZKFu9B4ke8I4pumIe3Xp7cD6ZUoTPtInfLFr4tIIO/LKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786530733; x=1818066733;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/f5wjtOeU0QaqOac5E/pne/bHsw6JQs4re3ZjLSO5cg=;
 b=GtX0se54vQ56k80CYI574U1b24GA3z0bElR9O6heuG/P+ocwbpv/d4tB
 xSMQvU4d2ukhR/xt+MzDDFiFfpKzFTJ2Se4nWRTeHUQi/RWrBtX6VCaBx
 ibZSq8MCGaDQN3p7ylB/Gjfani3vsvJb9kf2HM3+Di5c2lIptdKiNRfWI
 PJVXOU1K1FGrwN5f5GunnkTP0p37AwincM5aQ1mKohh2ZpSGcU0D+PulS
 m/oeIVuUq9BTdciyEt2IaEbM1VwxAYpkG3DUzVi0Q9v3RNKlpQsWkvYvh
 VfB603qMYrBdp/KD0tcw9M477NUgAOdq+jnoRBVRtm2pHgWEtyXyL2vqF
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GtX0se54
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC
 address runtime refresh
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 02 July 2026 14:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC a=
ddress runtime refresh
>
> Whenever MGMT requests MAC addr change and FW does it, driver does not ge=
t aligned to that change. Current - legacy approach doesn't handle such sce=
nario.
>
> Poll RAR0 (Receive Address Register) each service task cycle and update d=
river and netdev structs once new MAC addr is detected. It may happen that =
FW updates MAC address stored in RAR0 during runtime so SW shall fetch the =
new address.
>
> Refresh addr also during reset path to ensure the address survives RAR0 c=
learing during init_hw().
>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
