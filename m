Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1921C88E53
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 21:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97EC96060B;
	Fri, 11 Sep 2026 21:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LyvVwgq1uA7P; Fri, 11 Sep 2026 21:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A070160613
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789160499;
	b=IjmXXXyqqE9yQmFfUnyT+IBnNbj6k50PfjqzHmI92k3GTfQUuAM3HweN2/BoQihJG9Wh
	 YfsAEMMeoluXqR9yezUKgtyWqm+jtJ8SIBHVZBUhBdZ6S0y1FV7EtWQeK6puwnZTTmUvN
	 HNiHJItHT/gPY8BDY3poKsMNjdAegY8IO1/2kEXbKvnX65IlhgLJ++874IfYa29DyhIkV
	 JQotaLp9qCn2IZsH8T3ipjRM13NdyIMOgHqE7FOKmBxn7OOJH9sn0bT50THhWPwTIG2to
	 QurRKSFAGmA0Tmxh/jUc9KpMx0DNo7wsCBvSHKU/jvii5/5GNGPsJ0f1MDDMavfX3bg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789160499;
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
	bh=0NgCuMYZ+xLZfX7H5m9w/LZBvyP+YIhxplogNb19JBs=;
	b=DkIhoYbWF6KZKi+VUveH4QGKBLdbY3K2HSQXKP4lCf4M/tNh4JvQ4KtcgOMkmUP7aM/d
	 g1IoXq6No4k67jmMdYotI+qHHMT7c/Lp8uZg1Th4sOeqtwLhph6zfpFQ4UfLbuQFX/OZW
	 teXg3KtfdnFwUpYefCUg+drbjNDI7ewrr1ljso92+0LsrdcL/1kTjyQ5qShJ2TsWkNMiK
	 e5V5NxBMcDqDBkg9zJdGE4+UOanDUdDKmpLXpbhBZJa87Ie61j3eX4LnSW2/tK7V/PVYL
	 HMfYw4quct54YNa9ZZncR+TtlSni3vB5qRjl4ClnMKwMGXaLSlrE9QAyLDZxJVckZWQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789160499;
	bh=0NgCuMYZ+xLZfX7H5m9w/LZBvyP+YIhxplogNb19JBs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwipBO9nX4xmZFSqY49raqY61OsQwYlAkTZkQ95TsdmwWmJnl0odWLPfOPANplhsC
	 +4lu4LubmtLAYlzkuT7MVm+crbTaxWhC3a2Vvr/a9bYnmzGPgcYvP7r/6mHnvUBt2I
	 WtAWIeb2ZNqpcyMGGh8yGPUSh3asC5+nfkNzdHWyLSQ7x7IubdZsDTxCKzFGXgN3hz
	 7N55fVj/ptzJjCFuRFg4H1ts/8yYPLDvp0QItTpPKmrzPAx7nkGFc9UfbXXRtrbNCI
	 ww7dHiqc2E+QqycvomirKUzIakOjXa/1krsRYg/SiT6pTos6Hwx3lasuUjTEODbyry
	 ClCeUPfakOYfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A070160613;
	Fri, 11 Sep 2026 21:01:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3416049D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25B7380F10
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7y04OHC-KcN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 21:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D608580F0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789160497;
 b=VH5OoXJJ77X4N5jqy0r/bIr2nZ/PfmYHCifVxsCBEEjBvnvHRLkhqlbROP2v+EI/kVdJ
 9Rl2fPIyiJz2xhhV0CpV05t/Xcpk/ue6R8atmyxFzdKsprmSNTiGQoR4BUn2UDvAapOPv
 eKSy3QyGkXPWHxncU3VCQ5wtZhNDulOfBWyPPMa5s2b8p1fk3Uui0DKyIto0ih3pEtqlJ
 G3deufNv5pUxJC6rzlrvFNvrrO0GSYYJqVgcyVTCFOgUjOUbBz52+kDa5L5sAke6dYH9O
 vnDmRgfmsB6skKk4DK+6lSvCHLHGUULbCOVW/DuVrO1se1ynw1LKi6FFRF9J4za3lVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789160497;
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
 bh=0NgCuMYZ+xLZfX7H5m9w/LZBvyP+YIhxplogNb19JBs=;
 b=ZuPA2Gv5ZhlURP8khgSoeS2md2PLZESS3Y10Hup+eG2L1yPxgvzgdBOgBe2fRSnYPhPD
 I7P5VG+m4uJiDR+JxHahRlh8/jQgXrYAY3XFxSyrr4eTTZaZ4/qZfvT/PwQ6OH+rxKroq
 kCiRXuzmflkmp0jCCgnrft4U1Lmy9TXX0dJ7kiV7WiQmE2Hokat4iOxkDLw3BzGxfWlLH
 /3iyr/j/WHRLIL2rtE0+sT4yGfeltYH/LdZ1Bkb0EF7vkk97xZ1dGfXGpbydpcmvUtcnN
 BJTbblAp937W6+lFkJZrqmVEiwH5jU+znwFU6JVPY7fL5pWYHOk41dgdQCp5KA0ZCzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="EG6m2r/d"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EG6m2r/d
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D608580F0D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 21:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789160497; x=1820696497;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q2B6BVzyxm2bZsdPk1VolcKW114Euc3dUqESL/QhPMI=;
 b=EG6m2r/dpz/4QCrXnzq0u587fCQX+5kIAq2IuZRWLljUYnaY760er+Vf
 aH4D+GY8CH6+oKsLnLYQ/7tntBHZSUUTNfBHLvgU9IpaU3kZwi96fWpOO
 2DjZiefQEL42O+TQmIx/E+P+Dw7pFBZlszQ/Jtj4XV5JiGVvpWgKz69+w
 5b6514XbHsKry/GgTb/FK9ejU4kEs/DF/Fu07xElhmNfkTqhcqSbSaSTV
 AoIl4ttVJD7Nhg6v8sAOK68q4sO0Bk9/8IeJnHSK0hYYggzEuy78FEqDB
 3Z55X6L1FDjO47U4NtR0iYdhk7WRvHrGltNZIlPATo58r5M+dt6w3cdjm Q==;
X-CSE-ConnectionGUID: pSdeXrcYQ+S6B7WR8/77Fg==
X-CSE-MsgGUID: P4tLDRCcTC6bj1Nv6mjKbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="115165385"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="115165385"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:01:35 -0700
X-CSE-ConnectionGUID: Ll51+1QwR8ufNd47bqiMtQ==
X-CSE-MsgGUID: Hl4j5cgnTN22QKGw0Lewkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="268341864"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 14:01:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:01:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 14:01:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.39)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 14:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ3Ep1+IKQEwTxDbhs7NHBbwFu0QK5XVGgrhlCmvi7bUo3QXlQxHRpMPQ4aJQKGLC+hz/FtKxRcEynjiBQ8/a0m0/V5Nd73IEJqNUtCPr9m/GE4lTQnSmDYrmPu4ViEBIu12rVkLIGB4VW04smddgWqzQIUv6SXAni6CEwZW4gkHiMmNWze0r5piN2yCNuxr1ZQ6JsCOnO25DtlZin8oVKGKqMxgUzF5PBvh70StGWMYX50uDF4mwToPduMkDsfGma6O/sydYskV0rx5nmhwW+6YY5xxmTEIfXeynTBXiWJFZi1hiZ5DbzUc6UJUFxqguVjKrFXagnoQYEsJ6atmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NgCuMYZ+xLZfX7H5m9w/LZBvyP+YIhxplogNb19JBs=;
 b=sEwdoTP8Bal5ZiKCeecv1LsIzVIfeLdvLirHVF5l2KzrIodFe+OzBe1GWI2ntfu7qbhSTZAq53U4Qxr2oRgoIlPmv7bX8TGjLpqXxsl2zTo75CAylhBprN4eUwE1l+K7JQ0UMRQsdksfXPPI+xid0/Twgkdu8wOfBvBcIwAhXilZK5FoHvLYhwELfYlrk8tKXyC3KnOJ2+rb3/Vv0seSBKlKOoyPt6i+nhhh8vsvwy8w0G7h6stJAnqFTbd7x5DSMNmXoC4tsi4rxt9+t8junnJW9rp7dDkaswKKQyonSy3BK8KPXKqR+se9LmUyeBZS9S0qFD6Os1w6F4dCjMjLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 21:01:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 21:01:32 +0000
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
Subject: RE: [PATCH iwl-next v2 2/4] ice: fix typos in comments
Thread-Topic: [PATCH iwl-next v2 2/4] ice: fix typos in comments
Thread-Index: AQHdP6TJXorQoveoIEahO6vEf7NCw7bJ4hDw
Date: Fri, 11 Sep 2026 21:01:31 +0000
Message-ID: <IA3PR11MB898696171273BDD2364FC424E5BE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
 <20260907095446.27290-3-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-3-hemanth.selam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 1fe672af-0761-44c0-6320-08df1047db69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|921020|38070700021|10067099003|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info: o2UL7CfHBw4pE7NRir4sC0/qfwLTScYGkWQlKIVWpOoMwog1rEQ2x1B3DOtgwlRZjcjNZbHInvcHs9v+z8EtQpnnPZMbVHIXMiEO/EWXk9BvLRMbrbSIZIqXAn37Kf77RbI/Gs0OPGZ4SYdtsfG+YOppdTIn62ESFL6m+9jeWaowVGN0+nuspD5NFh/83nUw+NnoxRdpVRfpQCspLO1c8vXh4PiHRzdDGflZ3ra0/pDRirZ8ZpDyRqMvlJcicxMjeq0+1/OaroCxgbE2rqgprO+bvRBS2a48UwooXiLquOeq0OLlLCn0/kJSvkFtjfLHJG8/s6n3CqhBqEI7FawxvXkNTv7N+pipSMmeliGbYi6oYgACa/mY+NA3hx96Fn50ZBm/vPr+TnCwc1nMiU0+0RjNlqRNWmY3Sl3aJp6UuYWPm0hOlp8xFrczPn+7wHcbX4b93vTXL9lwI8rEGXaKdST5EBlxsxfoakdC2rDWYroAlbE7X29sl/+wl4+L3sua4inf/TgDOanUerFmj8oIT0sNIyJk88eajuXeIH+BBjm2Uvspm9VvDUPPBgGxrajLyTA55Z5LzpYESBT/IRyvQ1JDKAcqh+sBc/Uf4qMgF71ecaja1ODZuNfXS/AfGS4tmuRUE0yKOo+eJvlnjYhcm390M3lowOMewxhqVW1miTI009RQlz5Tp4fJXmcr80xm6pi+fQIsKo6qM/EsvdH+KBeMYHNcOnuPrk7Ok3mn0033EnrR59zdYPqgpgNEhivj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ed7X0ic7LfQfN0iecxAr0hJ/3hMlVSC7Ixlyf6wThsRwj4xaxt4FraI4oTBg?=
 =?us-ascii?Q?AtTbHugqlwmEtJmc20Jk+Q6++U+ufRRqW/7Q4p1RbDXsPG4woV/vhLLHVRkI?=
 =?us-ascii?Q?g//fQm2iao07Fj8CuPxLtM16LkQaYF2/U0ZAyHn7Yi0CwKA3/7jG5aubK9bB?=
 =?us-ascii?Q?IZszpI7EWCFPWUmVfj0FOP90bwZT13dDE6G+y600evWz720yncvUCqFD2ZyN?=
 =?us-ascii?Q?C0Itsptr5Fh+LEs1ogr5F30nR99QnOym7k0EG1LkX2RWuazYYSQaPq8PBNJ1?=
 =?us-ascii?Q?sQaf10Y78qX4BqyCvdBVrF8MDoab2SOHUbYocqIj+ions5Gz0Pr7Ki56b/Ef?=
 =?us-ascii?Q?jx7mC+bW3OyUKGZagwvcKvJUQz2VK5wYaIKUBIsxecEbJdlIl2M99lCNuICW?=
 =?us-ascii?Q?uNIUSDRN/496nuJu1Qh+rYmvlNtS5uMq6cq8MIWPASE2OGjYIXbjsf++m4sl?=
 =?us-ascii?Q?lvdiee/iEX5mtA/SSWOLbqkBKv33fpVumC2eQmuoRwBXBWrLdJdh8z07ljhb?=
 =?us-ascii?Q?Tc3i7hb5BprGcxX3OcYdHqcql5KIdHlBQqomrrmM9t9PkT+9vIv5z1hLfjSB?=
 =?us-ascii?Q?i1iwmoD5nZVxbiTS0JQ3mWVF9lU4iPUaSHT4vmkYUgAWBxjg+iyNWVkX/Trg?=
 =?us-ascii?Q?7KmDPiCmmNCaC8AuhCFAR0j1GdyXf8WIaIKsE8VkCtKGwqDgKttcocugONlK?=
 =?us-ascii?Q?TLna/NkHr/sGWm0Gxis8wojJrtPdVRU1q0yoHvqcSYQeETw4ZPi4ejlx8nmf?=
 =?us-ascii?Q?jxePAeOSUD3+ef5XtqbsymUMEWZHbBaPjXgYxEEqMLhBPuACazXLe/NtR74b?=
 =?us-ascii?Q?DXrCBciNb0X057Afj9GDBW7Ewx2Voibm24h+BAo7431knt7hPO3Ae8vKv8B2?=
 =?us-ascii?Q?TIUYQhAL770XUefpOtkjsUwYv6pCqkA3A1CqaTNOfUFVrY4ZscPO0a2YvtBY?=
 =?us-ascii?Q?wEXFxxyZahXrP7si9dtGkoc5UcYG7O9jWDdTdajfqKCxHtt4V4kR26r3bx3v?=
 =?us-ascii?Q?vUUUYWhUCl3N0RzMdUWVAIB1xtQL+pRl9KDlyb9kPmmacyocLJ6v7/J7Dhqi?=
 =?us-ascii?Q?ztylyF3Qw3Oi2itG8q7GMlbilegz+2bfFDy8MNlO3QnAhy/1oYtsSSgaHMMP?=
 =?us-ascii?Q?ZsgoaYBmi8+jlf7Q9dWfqjom0HL7Tbe4ZHGs+A14+e6Kp+fudvg743D17UCz?=
 =?us-ascii?Q?3ddbY1CR2wHOg1ElBBbcKahLkssNs6hhQE/r/6BSD4/fSPLS4zZWesKvjbhm?=
 =?us-ascii?Q?9f8CZsVRRpq4XjNlAibLtjylPgP8Icp/xaargRqkvj9NCyAc4pfMDoYnEFy6?=
 =?us-ascii?Q?DK3yD5cNrHgqeLM54aJ5oQe0vUWi0yAhI8TJLr6SKtAtDxgKd1rlv4vzqwTh?=
 =?us-ascii?Q?3yZhguUERqW8cpJ/aZdAP5zLDzPZ23ryTndpS1pN8pH8DpH1c9nlWwP6M61c?=
 =?us-ascii?Q?JnKEgL0hj1c+4MyGTnwey1+H05Uj9lWwjOI7OPfpxCkZFV/2f9h3rKxy34KR?=
 =?us-ascii?Q?3Ad962h51Wzxuii3UtZH9X9IFcCGM615g1T/cDiUL512jysmcnxXcAy3MpFY?=
 =?us-ascii?Q?yEPN3NTEPXEOcDlOJOcyMf98B1D08z7FuU+vzgJxeEGoJyVIYMQagPxmOrK7?=
 =?us-ascii?Q?v8gyhvXP5Xq2tAPrOhHKyzviL5EP3QQrSLC+veEwXBM3LvnUnkjNX4HSbHfU?=
 =?us-ascii?Q?WXfz/Ns2GEWBZO8TT36E5k+nOIZybNtIznVs7iEGIX2vhA/IRgIjlTnKAZCZ?=
 =?us-ascii?Q?bsTrfSzD/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yvwlPsxjP2jMfjT6OanjNAW0PYWYvQpGrzF/JX+y5uYZCN9T+Jb2liBmprLZuw84mDvepVm1kihYaaHzs3y1mSxDM06AwlxGoN6twntInP0vG7IRlQlRylXRUowU4G75vTeMepWXNsKQz12uMpovqCdyi8BiZKElbCb3Au2Za2gnoQaE0GhcGMf5EuEHtkQ43Dx0qJBbZwCRgEfFhj8t24TCeBzUEuk+RaX3FMoykOOoZYkQWmI3ermtFWG/PwlXc4JPyfz+0rzB9O/Ktk/0dJiLpTIxJQ3AoL3nmWXQbgVSi2Im5PzY45dH5Kb0wuPMrhecoVln0Xdccd7m/ofHWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe672af-0761-44c0-6320-08df1047db69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 21:01:31.9095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w82CoueixWZSsU2QXLhEFF3O1LmMUsLB/WA7M+ckwxi8F2AkxCRJ1IFKRScxKLd3XHDTG8s3J6dELG9KJr1iKtJDk38Q38G0Y6SdOrPBJCg=
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
> Subject: [PATCH iwl-next v2 2/4] ice: fix typos in comments
>=20
> Fix typos in comments, found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt. Only touches comments, no
> code
> changes.
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
>  drivers/net/ethernet/intel/ice/ice.h       | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c  | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c..e5f940d324dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops
> ice_xdp_md_ops;
>   * ice_is_dual - Check if given config is multi-NAC
>   * @hw: pointer to HW structure
>   *
> - * Return: true if the device is running in mutli-NAC (Network
> + * Return: true if the device is running in multi-NAC (Network
>   * Acceleration Complex) configuration variant, false otherwise
>   * (always false for non-E825 devices).
>   */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..fe47ec0ba809 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused
> struct nlattr *tb[],
>   *
>   * Features that need fixing:
>   *	Cannot simultaneously enable CTAG and STAG stripping and/or
> insertion.
> - *	These are mutually exlusive as the VSI context cannot support
> multiple
> + *	These are mutually exclusive as the VSI context cannot support
> multiple
>   *	VLAN ethertypes simultaneously for stripping and/or insertion.
> If this
>   *	is not done, then default to clearing the requested STAG
> offload
>   *	settings.
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..9ef1aa66fa2b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf
> *pf, u16 restricted_id)
>   * is correct etc. Then disable old mapping (MSI-X and queues
> registers), change
>   * MSI-X and queues, rebuild VSI and enable new mapping.
>   *
> - * If it is possible (driver not binded to VF) try to remap also
> other VFs to
> + * If it is possible (driver not bound to VF) try to remap also other
> VFs to
>   * linearize irqs register usage.
>   */
>  int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int
> msix_vec_count)

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
