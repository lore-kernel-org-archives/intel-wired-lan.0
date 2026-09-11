Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3117C88E50
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 15:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75E6C40619;
	Fri, 11 Sep 2026 15:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDE63N7DopNX; Fri, 11 Sep 2026 15:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C1B184066C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789140216;
	b=TMeeQMfloM/Pu14HJYALZsaNJBk1za16tNn5ohJ0zaH7TkQZe9vsG0m5t/PUuTCenByw
	 DdZ+StFvCWHaWoNzIc/9LOHuDxoXnY66oLbW6UFFulEjeCGwXx08s3fcChi7x/hQZix2E
	 8VK2pUtKLxrjBcXqisuOxmQCl2/bihxj6pThfbANgrqKkQ0mcGxnF6LR1nPczhvucn2A2
	 jX1mpGvi5OSH41DNjSf5VPFpqiRKgeNb17Z/xh2QPUWjTBO/YUx+aB2QpfxFJtSFhbYZk
	 aNzLsCRyaB3w9P24xEQZGMf1wwYDAuVYBfaRcHLZWi9YFSGICzUUsXpP7a5oygkD7tA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789140216;
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
	bh=QHirNAdkJq4i3HbURY0PoORwTb9vhKJh8EcyLAIVKX8=;
	b=Rgc19GcNWN4lDTLtV9mg8V2fD04/ZG62wwcAozg2vmEU0U3Ale7+WrwCuWYhqZstER7v
	 TWjK+29M60JONBgp6wH3Vripst6lo9TGjLbmau/ficn244GYRW3TN9akLctVNDnj4eODg
	 fWVnPhQt4YcQmNbbQAZz5J+JlI3vW1cOB5kUx31ZWYE7PVhoPJPCjyjrS5Zfm8X+Z4xUH
	 A35og6iMQ2SbbONOPVOTMHHz/0KARy+jc57qZ+wjoERF1X7Xpes6OwSgiAhqQB6AL5H0c
	 PCb4tas9XouEWwkvWsANZfbajzwC5rENtZi8DomkWiW9fQhSGqY61Rq/XKEm0i68dzw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789140216;
	bh=QHirNAdkJq4i3HbURY0PoORwTb9vhKJh8EcyLAIVKX8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XRth+lRL7k/GhqkbtWbcwGkVlCc0HoyodOwhQ/FbWbk/eRKZ844VAcI1W5Io7MKx9
	 hibgLrhC65RjRN9f/8sCr5fctqGi3xphN4R+fVtzAiFbav0gKsbwtqjTNzfnSucq0j
	 Uw0RoQsuDvA7Ct99TqdJi2+4ZsK1NJMbTqkgqd7pXGq5gADJ+zvdJFWtLs8z4Woqxp
	 nLCns+jxJjeUjsNzsqFyHd0P0bnlZdOdllT9cYZBfbdFYo1qqiHPhSeGAbGRuv/E1p
	 YaYvkl9sPfjx+Gg3PE4gAW2T7QmI8HmYPOygWAPj5w/dCOLLR+KjvZuuHB0nK1c5hl
	 PN2zA6QYtjNyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1B184066C;
	Fri, 11 Sep 2026 15:23:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FC482E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 15:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55C33400B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 15:23:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cPt2rWH1yu0L for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 15:23:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6BF2C4006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789140214;
 b=FdFV47vJ0s9FQfdkwnv+/XXprmxnryIRSJ1w1R8CWWrBSEsHjtopg0ijL43jwcUNgaLl
 dcfjGLxiPg4/CHBr+pLOzVzJYH1S3Q9Y0P7a9sf/nPpSUrnxHzno5RfUmavc6G6fJUcD/
 EUhYBHyBms31WIJoU44GP6K8mWIyqZcI9Pkgr/bkP1vGGj2HNpr70crTGmwRNanUw/WuT
 oKn/cbEzioDEurvtFOSYbEnuixqOrSY8af+OPr5sM6iDo0qgmGnufOaLGJDQlLInP788b
 mNVfQM5upXrPnY0FcUZZLw97OjzOYmwu0MaoqjTcMcXKucdX0rqn2U65KVCzQ458sew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789140214;
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
 bh=QHirNAdkJq4i3HbURY0PoORwTb9vhKJh8EcyLAIVKX8=;
 b=BqaX5NvPn3WUA4bthNrcgP0YS53bggxtYITlQyrbgwXJVOTrOWtMzXYN/ti/CUhooOfj
 ejeuqvqBm95CQ/DqWJ/hi7yl7tdL88mVN8DwYx6UntcllOl7BwKICAq9Tr3+yCA9hbvMm
 yUk64VsQ0X2sqVKNy6VZaFkj/S9dpsJYJfpNYQPPi+a7P0BJzyX8liu1l4c+XIbbc02VQ
 bnwOgyPIHUzLZRx653ievAaMZ3KED9aJJsTQjpP2UHy3hsY3r3dzuwY4KeAQDW/NTrKD8
 0xA8ybNqpKxuU0Be4BP2axOXlbBH00Z6TW25PfaTNW5i5PoceyvpWMe06QagUWpOIug==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MYNXImkD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MYNXImkD
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BF2C4006B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789140214; x=1820676214;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WMw+2V+pydeMfdcCvRoDSXKsJYqhvg538uF081wBRBg=;
 b=MYNXImkD2OUuyG7n49H4o7ELp1j+PinhqkO/T/Uu6c1w69H2P5u4XZ8C
 hy2kSM+QtbtzUBZ5exG+oandgLZtvHgPQQr91mjpkWbLQzOmmkgA/12Zt
 e/QPHBm8ZNKDplr80usk+inVWSt5EjnemW62bCsgG5qZ/0z5Syw/B8w7s
 Duu+ZxjxbMMVTa2oBI28LPw+86cesl+HOAU2ZRssoldDRUWPJkxWrgx0i
 OiklSwGYV0Dgx6lMizxl0MBNR6qGR0rC3OD/UwwhXQtdBFaOsZB5ty7fT
 oFDH/FdKC0E9qO2FskwXc/+nmsGUdwt+MYb8PxD/4LfZz2cTdus6eZBpv A==;
X-CSE-ConnectionGUID: CWlBVlhZRCy7a/swxbOlfA==
X-CSE-MsgGUID: HV58EmvDR9iT8nYMhwcn/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="99933477"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99933477"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:23:33 -0700
X-CSE-ConnectionGUID: i3+4q9h0SY6TyeA51p1lvA==
X-CSE-MsgGUID: 30yw+GL1Q6m6QpmBBcZUOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="267652967"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 08:23:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:23:32 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ait7hBh3d7ywZS3U1hZbdSLA9DYpftXjSVBHRs+B9LPiJa1PCXdbH12G7ME13ztzKHvvyxyR5GmEx617Kg97K/5R//sisvBNejOVOr1eUPp2FqkRZajhXVLPyyZQ+J/WlzFiHV+BLJDQ5u+I5Z7SgimjigXdm/mwLv+p+j47DW09bOKMC78UpdVTyUSP8l8E3pVSsgG7kboCtk0V89SNJDN+q4gsq07IXh1h33L+npzWq0nCgaUbWE0rihmbpTm2wdq2HJGrp6KuDIB6ZJ4Ib5uUf2+02NmWcyZV09oaf900BSCO5DkCsjkHB1WGY0YGyjKykHIaHWuV5JbKIQFfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHirNAdkJq4i3HbURY0PoORwTb9vhKJh8EcyLAIVKX8=;
 b=v4yMNGzLs5El9mBh6X/T6fkoUdRntK+vOEXo2/WikBYmuhgCOi/yQmQv9322s830p8ipZ+UFgjYUHgDgCj+lDgWnEm16Ek3wWh2pg7S50/Eqx6r/AFs3Az5ig1QDqPCdlvo5vgDZdGrWSFQBXJLgBN4rgQIekR2IdJT+WLQF5O+yMEPrM5QxaPp1zmavxGUxsszwDybzIeDtuZ3I4XC2uBOHiCC8UgdQjZAxlCYWagnc07VuzVhKPJZaLktymVeKSX/fzlq2C0upK9FUYUd2K5vKdAoc9NBzAYl0uxxFV8rcOzrPxC/EQxu0Ov4oPMlwVFR7PkuevpfeSyfCJyXi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:23:27 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:23:27 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, 
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink
 parameter for Flow Director ATR sample rate
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink
 parameter for Flow Director ATR sample rate
Thread-Index: AQHdGqxy282qHmY2M0qHkV98W02/dLbJatjw
Date: Fri, 11 Sep 2026 15:23:27 +0000
Message-ID: <IA1PR11MB624197D95FEA25F481C3C79A8BBE2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260723140510.184819-1-mheib@redhat.com>
 <20260723140510.184819-3-mheib@redhat.com>
In-Reply-To: <20260723140510.184819-3-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: 94a8770c-f991-4c45-942b-08df1018a0f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|56012099006|4143699003|6133799003|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: eNZsKGVUYyTc3WzMJy+Z/N6aBot6hKhDrR8TXEfuUllqD8LiBFzxT0ZN2JMG0eUYxd/TLGmaXi9EhryIHzSHAGXPhljioP67KsCbUc+x+t/4iJIL2z1MFLB2xZ86jr2628FGU9s4s2xowKrEScQips/EFk9/yET8AbUAeN7rSEd8iKI+p01BveTm21W4DoZRegQsrhaSIRnI9tAfbnXgehBC+0AZX/ABsb8JyP4RdnlEw7CAdSMvFGHfunC3fasrYKyN4hgNlHnc42dyQEIQg9IowPH1CFs01FfJorKivladmyYVr791xwMHIalqZibZFZXjXPExpPj6upCxwfYErESnd9EwAH9TGxuuUWijyCV1tPkTKBsPCw8jBAYzq8z7Ai0gV8lrWWrYe7o9hkDEcWQedqNYkqIUVx+nW5r6mrEsfzAQzzS1QdovPNihr5Jas0LbRiCT4TcFRLpOHvVDpmhNbQii2OcsHznLu+6z/MzfMGSppK0XF7hzdFKs3U2bxr+DUTh5tgoHypfdH/LB2lr51mAdbMF9wxeJb00ebNUnUpSNESENlMneQEF1pyR0Fy7mP4ilibd3PDQ3uZMbO2PvN3o6JAqFSGgGfr9nKZR2F4gS5KtbnGc8bRjwX0ZJPjNU7DZplc3ABNPfN+rj++wC/Aws69ARZDatseMYrP038rsbRsFlk2khOej954+k9JgLWUOSfVNwhatuvvy9DsNu9t6cgpW9EsR2H/TzFxo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aNNWJm8m1neR0fjymvkJlcoMq24sHjoMy4FRbatEQkqF+KY4xvxDryrOu603?=
 =?us-ascii?Q?hAiga+8ZsAhpuPd+e0erlYGUDDW1FbDixBU3yVOcbVKmwPSX8E6mIWbMzlqU?=
 =?us-ascii?Q?sRKLkPEpwPThFcO5eUIg/NvE3s2XadjJZf/03yCo7d8/Nbv0GJx2toAekzD7?=
 =?us-ascii?Q?fRnDw0YDixl7dWjRrB6J0VeTp7m2gne6H1qc4/RAhEVwc1GmqqJNrRdBdEP1?=
 =?us-ascii?Q?jcKil7NKwFic77BmD85KoxFcfZPgGfWfb8xPxaiiE+SLxnh5Tjec6+XqyKyC?=
 =?us-ascii?Q?bkHP34928lyYrBIkxnA5VTe6EdxcFTpN0LeJFRzzn1kCrxoltI0qv320a3MU?=
 =?us-ascii?Q?wFQ9Evxp8TyS8YmMLn1g7k5CBl5ovPT9rx3w+FPfH1cY/e3HNXGneNmTxGGh?=
 =?us-ascii?Q?E2OnR1xhpfYPJUKwGxVteg14fd4iexptFd5mHVGTIe6jZ7RW6HF+uswdAsYy?=
 =?us-ascii?Q?RCCk+BZ+Wjud96on3SpW3TiiNsrtOkBueYZPYMLlpoJsUiuDOSCRWnwhQFPr?=
 =?us-ascii?Q?y0TaQ9nmZ40DdqZzIFQtx3kkVQEN6SgcykVhVF1Jbek6Ju8ZR7QS1tMpWoBu?=
 =?us-ascii?Q?jOL/LvTwltUjuZC1zV8vh2PdpMOk9/XIx+h6qEzGYMvfTbrg1tC/51uozeYH?=
 =?us-ascii?Q?PdmnsHz3ScdWwQrAYETVTs8pOEcfb3IC1TvuK7clg6gm/8Wh6CgGCcPiA9JD?=
 =?us-ascii?Q?IuhimyV4sy56jtcqQESDlZuo5Z465KI4QNKp8YITGYsnrbZS5+Omt3JRdMBO?=
 =?us-ascii?Q?ili23y5Yl8XJSuceDCvV561Ezix9F8CuatJgd2A4zetOoqDh3mByU2pCWIAj?=
 =?us-ascii?Q?9cRPb3wAjXTWJkvUaSUJseVjHazGGUyBV7okGvRXrRMYaXmhJ6J6Rif6hzr9?=
 =?us-ascii?Q?bgm3xMYS2jMmAO5z0CPdnMS9Z+NnmRJBGmjGBgLFwgLL+EbgDW5997qfoTmU?=
 =?us-ascii?Q?Rs5AngUfRMHJ+9+tPfht69XaxWafQsHX1HkRt0s94oeTuEBGUHwBAfAN5W5s?=
 =?us-ascii?Q?8tpd3Pxj+Z61N7HSgU9fsIP4NNXKV+AZr2RpyTU02/M3NXYe64CUSLuxfrgt?=
 =?us-ascii?Q?Gkbx2ukk7kHWycb0lYQmGEbHkmA84HlZRsUnLIsS4Rl4ie7D9c3tP6p3Xnar?=
 =?us-ascii?Q?aE8jwr/gwhcQaptOMfFXH0U617C+CgKDcfuY0uYd0Y1GKSf1dWv0s0ZJi35q?=
 =?us-ascii?Q?vEdr5SdBYa/r+crceL8DZL4BDxeDpWBECKD6u+zym+CqWvkhWW1IL7wt5eW3?=
 =?us-ascii?Q?KVB6/tC08xN3FX3Jo8FaEG/MhBl5N3HhP0AqUgpRZV2UKB3ajLXx5uUOn7It?=
 =?us-ascii?Q?MeQ3qSsd5tYlMgAWDM5qiTHieHLf/ZUhipgs+JzxKeELlUESj4tu+rpbMA6u?=
 =?us-ascii?Q?8XQtENnJZSX5R9nmTGTgAISmZEi9xyyew4tCEmx1zXzjF/Fl3b+T0gbQ66ef?=
 =?us-ascii?Q?yiuXW/09HYPKfm7uprni5WNJg0CTOUW0jFJ/macppFyZsD5AEKjuny+p+H5n?=
 =?us-ascii?Q?3ytnUtq2lgq8u1aZq6RzwZwGZhyMLh+FEspfLQ2pqnkQpZDs9lcf19sfZFFR?=
 =?us-ascii?Q?VJsv4rFoqaXBvzROdrQ9C2GCFbCfhw0SvbD5ZNnODY3JfMul9OxlTZMycMcn?=
 =?us-ascii?Q?pk/ihUqsL0KfUtBRtltjgQgLrmJHX8X9Ap3v8wBcNwtz2RyW8hQ8uElwn228?=
 =?us-ascii?Q?j1UWqtXx/GB0qG16L4g+quYIjmw64uKWS0JtW93itZAjePhe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OQ4SOsDA3WXAhx+aQB/QUoA+NsQbebEcPJ+TVgZF1mXxehZdk+HaVYujZY8wC+k2aCO9zqTNjGKaGWu5UlBnZKZ36oMdNOh6vjWX28OmSc/6nM7JFM7SdqHjuVdiFqnlyYwf4cq4Ld/XfNIM6yIz9i7CI1HznX8R9Exv+z9ndPQm5DDARqtsUhP7qgh+hPplVlbBxcG5MppaFBr+V3FbzKHx9AoiQ3/IBaxDiigdYl1zv86hs1OmBYbHiEBVMOyuodpZwGncARIrEaD+zmwXjQTuRRYWVk6Ce0k3ORvJX6DSRvG2XgMVEEED6U0Z5xOEaZVIH7kLvggd//ZtqlsWxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a8770c-f991-4c45-942b-08df1018a0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 15:23:27.5210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jI/kkXncfqWMzVnxj/cw/DZalDjWVIB4bmtfk6xph4QfF2+lu6czIxFbb48WsY8fqFnGnV6F69g0jpQsoG5FRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: 23 July 2026 19:34
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org; pabeni@redhat.com; corbet@lwn.net; Nguyen, =
Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>; andrew+netdev@lunn.ch; horms@kernel.org; Mohammad Heib <mh=
eib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/3] i40e: add devlink para=
meter for Flow Director ATR sample rate
>
> From: Mohammad Heib <mheib@redhat.com>
>
> The i40e driver uses Flow Director ATR to periodically update flow steeri=
ng information for active TCP flows. The update frequency is currently cont=
rolled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at driver build time.
>
> On systems with a large number of queues and high-rate TCP workloads, the=
 default sampling interval can result in frequent Flow Director reprogrammi=
ng for long-lived flows.
>
> The amount of TCP packet reordering observed on some systems is sensitive=
 to the ATR sampling interval. Increasing the interval reduces Flow Directo=
r programming activity and can significantly reduce the associated reorderi=
ng.
>
> Since the optimal sampling interval depends on the workload and system co=
nfiguration, a single fixed value is not suitable for all deployments.
>
> Add a devlink parameter to allow administrators to tune the ATR sample ra=
te at runtime without rebuilding the driver or disabling ATR functionality =
entirely.
>
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
> Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
> .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
> 2 files changed, 56 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
