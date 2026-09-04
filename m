Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44D9C61DD6
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 04:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EBB460886;
	Fri,  4 Sep 2026 04:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOcipMyHqayY; Fri,  4 Sep 2026 04:08:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AB0B260B43
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788494880;
	b=VcWKMhaZX4ypUO+CHwmAgz53rS8haKn9SrDutxb/MJgxVBXrPM+VBHbExHVuGSztdAm9
	 8+KEKS1r7+YKKuhzQXSH+tdk0yrZtHExdyjcPbEelXppRMiYf1kvkPSJ3d/xwe2yT3eJH
	 2BuVlw+Tsq9Z2QZ1mQcEAKf4VwrvPkbrTcteV+/UfimXeIhyv+9FfTkUbWL4QXj5glEjI
	 SlYDaw7l7/4EDvv0SpOOHN6RNX0g06dpaP51I5XanCE1RqtfjGQzf83uMnQT1wiXsR0Qx
	 mjx65fQlkJ/IAbj9zN0O1aGZwnLRo0OXSP+abV4sosLHUDZTWuAiHeRboGmHfJTesdw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788494880;
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
	bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
	b=byfYBtYnboyui8Tgu9SdG90NkavmzxZNlDbHUwdxZ7nUBopDsPSJ93v+2f81NKIqrpDn
	 bA856/pDG7mUN757rN16e5EMBqOMYwmU37/hRjBiPMSLBxqQY+N9G4WSVLW1+gVuTkcba
	 kUXQ6WK4Nh/SxZsbOAE55h/ijwjIzFMjUqN/bb9z3vodJk6u01DxU5/Hd9tJUsfSzcBw9
	 UZYI24TDeP9yySbeeO9uXJ9KdGCgV0/YzvJIvUHP1G5Gmki05NWXl4CF0vmXZeLyRKU9m
	 C2JnVdWEToS9ZmCZz/NMOD0fRJfSSlOFx8qc/5Cn6hEW1Wt9Ou7CNttaLB46/fNVTDA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788494880;
	bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2Lh1mKfpd8HMh08sVkR0/FbWLwOf/JC9JSUys5E8r0AG0XV2FGiU+grOP37CjMbrQ
	 TG7Z9IM8NPEJPDIySa1rB59wWAVW3qvQUn1XBPZGMIAudqKP35hV3zdN/CmMZMejrv
	 GRrHleB6rNoOfB92ZXlyR4sqEywwg5N4ShR1Z9P2sva91VFjmcSDTIwJKnT0ZLNa1c
	 S96S7LfnU0j9BRsivILwK1pxLEuRHNT0YqEKHzg4ZITL8NI4kgkGe4CAUQGS3nvVh9
	 3xzOWQpz6lh/ZPnLscbkFuvWRo+4Dzuu4S+nmmt4QXxilNTkwQsmpKA47QAUiDNkzc
	 jQAOht3dj38Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB0B260B43;
	Fri,  4 Sep 2026 04:08:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3020363
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 04:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A451A40B38
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 04:07:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMdTdv0xxjmQ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 04:07:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0856940B37
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788494878;
 b=MXmT5CP4CL/kOsNtCWdU1hWror61uz+hSn0ITRhlpx0Mu99x+0Rjj30faZNeyCHN5IbE
 Sb3KzzufNIIsnn9nie9mIQCBtUwh4Y0RlrPiTrIl6wj0mBftVkCq2gJH44T4XvRluFh0g
 2Vz487Ufa+HOM1OocYwlUjCGcUWu5RZbEx5O/7YfnCmIM0aSUF8rf43btTNb5drPrZd2t
 8fYGl+jezSrUpsPqtykORpff61sSzt65C0kkJ7uHR7m/CGl4ZDTkfd0ejvyEjAAn6XOTR
 wWwVhnbRHpdBxyqtT26xwLW4Wht2C9VpNoAd1ct1nDBO9eCKM0HiHHFVb5V7+Mlf8tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788494878;
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
 bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
 b=SgmVTHMSbkvuHY1UmdY+PNjuI2rFO6xYpBTL7eNi54VYdzkgj0SdAfPOyJs6+Q8PSyfs
 2nZfiwq9Rf8I4EoEQhgbxHhK4RRivrB168Yzlq7R8yDP8Hm18/nMTLzIAZsGl+m7XoW04
 nUkjFtjjTCdskItzhyamvPDE4K0Tl+kYQ4DKuZB7V5M/DBsO/TWaA7HzQGc+9BdKhcMwi
 sc7KgwXT+kh3LGTkcHK139Oaz3aFe8ah1iX/HDg4JpDftF5LhkBJgJqy3MJtCaa6fCYYb
 KsrXKqkTSJbxhzpk6bifCsqFlCLTMV2+qOvlwO64CNu9RLwANGi6PrgOTu5sFifF1MQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="i/3YO13s"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i/3YO13s
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0856940B37
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 04:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788494878; x=1820030878;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
 b=i/3YO13sbfVy1dXJTrE+cCewJPJYnFsK4CXuXjyfz0FiN870Xe0d2ZvG
 7ZJjPVHJTd2vGoec8GHBpwVpDfKkZKHZ+JALJ0YQc9br2eawzAMjlZE0f
 RNDYouxDtmru0qGZnsYJEJeSV2p0csKU7TGflgnFfjKZo6fEmti7gErVH
 wREuoP1OFUXVzGcObgkZZDRm3CzNAawhrRvxXKors6gRuTwFxENh3iEGW
 1LpGsmjfa87lsmurbvpImuBTEhlipS+JH9VX9JlQIiezU792zx38AoChK
 8yKASxg/eqVSZ2X62Y2T4w+3SZEoQIHoQjYzDmwul7kru+ehts94lluhg A==;
X-CSE-ConnectionGUID: FqD7kYUERT2gMDLvfgiuvA==
X-CSE-MsgGUID: yoG2y+fiSOGZTtMMeWGcsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92810595"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="92810595"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 21:07:57 -0700
X-CSE-ConnectionGUID: IGous+3vStaBOCawgfMxiw==
X-CSE-MsgGUID: OKwUumyYSK66+NeHgI9oZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="267353109"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 21:07:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 21:07:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 21:07:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 21:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnMIHA6nCoCCXRAXxtyJ1btXoL8EZnj9XrV334dnkSRZM+XQvSNFkZeif6Aky8pOBANDQ7Rag7AyPM+7lzxw/5ouwWG6K2Y6K7Q1SrWUIxEAQnVWanvarbjJkn2spWlDapgsHhMLBXTH0hpHOSTvdRbKkUz0m1VBykAueFnt3icgQkh7+9xVe8jif49Y4NjBvjALTEDNWLKd8hbXQ/b0MR3BHEf3juGMMkq4KMYpviEwywRoHnD1Cggl+1KugSozXx/aX5PSpCjX5TtCQ8UcOdwEzplX2RASy7stdfGwkt5cVeXGwaeZ8Hajot4WCSn99UxOMx4mFcLozJki7LtnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
 b=cRxKXHTyODQN8lSoDHy5aYxhD12P+QOqBw2GtFGIuQuPK9R+xZ+mtyZuF6eQPtpbwgCjv/8J+PaAghx+BhnbkhdnYJ7NnNgqp8YosupTOoZplIZEqNToFsJ+92KHDV0VmbQbQXxU7bvBrxataw5Jg8bjxeG74WLOmUwhgWq+66VNq7fAGCyJWKJEDMU6QArLJxKJPYeIvdeGJzjTWuitYUNLx+jWJzOTTac+CBS6DqahmqQ3h6Ssen5eN5323duq4H/kbut3y8LeEaBfDv0cNhio0PRL8JGHFS0voF0R1ju80nS3VoT5ri4+P4T6m6UV/PJD1c7yBv17dhpKpWpQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ5PPF44E8B88DF.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::825) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 04:07:53 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 04:07:53 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: add missing xa_destroy
 for sched_node_ids
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: add missing xa_destroy
 for sched_node_ids
Thread-Index: AQHdDZ/NiHO8ub9xIkC7qDePsCqj+ba+J+dg
Date: Fri, 4 Sep 2026 04:07:52 +0000
Message-ID: <IA1PR11MB6241B517D4B56D94932C3FFF8BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
In-Reply-To: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ5PPF44E8B88DF:EE_
x-ms-office365-filtering-correlation-id: bb1e46fc-93d2-452f-dac5-08df0a3a179a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|6133799003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: hFk3uQ7SVz33u17Wc2KPJxn/kzeyWIDm7Os3YGYWAkZZpy7wx1bf5n3OWxMxhL9ypxI/ilSRVi/F55e6rb8dXxTMskzVCmULbEuZxHTINkc7wPjHa7BrcFW5oyG6YRpLGt3II3NRx0oZ228iaNTU+GXjq2n0Asvfj0sy+bZmg4alWS26DuiQEs2opv/zgngcCyukX6aHHHFUqmtfk0SiavfHzmzQvYWfAa/mGcd3SEMCJnK4wR/KqBKMjCuXIMwN7Zt+RFUIPoEgiU7ekixzuA1djWAMnEzZ81h87BAarEK1dVUEBU71uRQNnNlbgMSyGNUEwl9FdYdepGgBfHibYdUg7Jw03CwgpqQ7Fj0biVdmn7Mf0u4i/mevMzzAKLk4Y7lM2jgYHTRTMW4e4oxO7mN4yyYx1yxL6nKseBH+jtmz9OqZ3FQOyYBnII93azrMlEY7Cv2RnC8sZVUOCdRlicKMoow5tznIqAWTths6AVDuKXxmjRXkQnEVix+xyuT9evjkds2WRBdiwSi9r8ih5nmda631tv2hoBCdChIEN4ONNNrJH7ARKIkct/LSxDA1cj6RpsEsVTdg1p/OTvs7/jxbe972jzTLfAA9Dvi0roxvNqWcTnntAOrHwhwsznoMaPGoFyVEoIEo6vXMRhh5pqxsu4jOD80LIhJrfqmoxs8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUx3Vmw4NzJhTm1senlCc3JLQlFydWE5RzNFVjlma2NSWEh5MEoyQSt0WXRZ?=
 =?utf-8?B?NWdFRjdiSEk5a0JBZ3Mvd3dobm16a2tITlBTMmlLMlpCMld2Y2tJbVduSlM1?=
 =?utf-8?B?czl4T3BvUThQcVhTekNSNVBHNGVka0tTWVA2TExqUmp4cXEwVVV1aGE3dWpw?=
 =?utf-8?B?MHY1dHltTFJQRklIdVlERktFQ1lNNStZNCtGS1RQakJPY1dHeElldVl6cVQ0?=
 =?utf-8?B?L3R3Z2JjRFJtTU1UVjFURFNUTHJ3WjZzRnF6bzExRXlDQTlRMlQ5anhhTm5I?=
 =?utf-8?B?VmlLU3Y5R3VIYzIrajF3TTgycXNzY0FDZlZnL1VqZ0FFQTdWZ0pMRnBVZUlB?=
 =?utf-8?B?S2dQY1NMWEMzSmFKSWxtYm1wWHEza0FVNEpLN3hNWlVINEg1UTA0dlA4WTU4?=
 =?utf-8?B?eVk1Qk5SN01EVFcxdUxLZTRkMjhKbERjVFF2b0pGenk3TTRnL2o2L0c3TXo5?=
 =?utf-8?B?ZXRrNlM1cm1NZzhETERuZmoxaXRKU3JxOEJnSXZvcnF5V1FPN3pzNE9EN25u?=
 =?utf-8?B?YjhHTTZtQ01mZ1hab1V0YWE1SG52b2QyMUZOUEpyaTdZc0VtZlVaSk9WYm5x?=
 =?utf-8?B?SDg5d3U3Mi9SUUw1bW1IeVRTMFlickxmWTZjNE9hNno3Qi9QVGlBY0RyTDhZ?=
 =?utf-8?B?bVFMdUVZZ1FGU0RJT2daN0JhU0ZsaGxLMUF1TkxML0JxOStyc2dkenJJV1NC?=
 =?utf-8?B?K1I1T1p2K3czM2Z5MnB2VW1RTXdCUkFtdXFJd2JCMTYxUy9seENHSXpmNU9I?=
 =?utf-8?B?MTBkUDNsZG51UENVYkJ5NWNFRS9XYmpxVkFRU3FTQ2ZEL0s5U25wRG9wNnhh?=
 =?utf-8?B?Y2I5NENIYWtrdzlWeFUyMzZVZkEvR1FlTWNieURLVm9ZMVZ6NmJxRWdldzFa?=
 =?utf-8?B?eW1lSko5YTVpMWIrWHUwQ2pmdDVpSnVsUVQ1VjFieFRvL2hSLzlBVFVGd1BT?=
 =?utf-8?B?U0tGTDd4SVRucWREbnBwbnkrZ3l3cjVNcHdGeUxUTEJuVXhEd0lHYTN2QWUx?=
 =?utf-8?B?SnhaNVpnY2RubkpvZDN5OUpnRVRScnNVb2hsWDB2OWQrV2ZWQXl3WTU3OHNR?=
 =?utf-8?B?dXJ6eFJITlIxYlFzU3RSWWJ0S1lYSWNocWhOOEYyVzJCYnZZK21jMHVZdTZC?=
 =?utf-8?B?UFJJTDFIRXdFdFlaelRFRzU1dGZXVVA2MWUxd1N0ekROZ041Q3V1cVRJQ2Iz?=
 =?utf-8?B?ZU00aWdsNlQ4dDNseVovQjJDMjA1dy9DeW94eUZyMG9zWGJzRmV0RmgzellQ?=
 =?utf-8?B?RDFGY25QMlF4MkF1TkU3c3A0NFMra3FiUFloaWhpYXpxREdKUys0NE9VbTZB?=
 =?utf-8?B?R1d5cWtUV01FRE1kRDlpTXJjSFhVMmdoNHB4blFGYlBVaFJEWWdkY0dQdVYx?=
 =?utf-8?B?R3FBODJmbE9idnM5aWV4MmN5NFU3ZEVvWWdpL1c1YlZPcXBsNmRlSXZ3dC8x?=
 =?utf-8?B?WnZUdEFLUEZEK1NhMHFQN1BXUEowQS84UElKeTNKK0t0RVUyQ29HeWtlZWxQ?=
 =?utf-8?B?VWE1YkowazA3K21mc0d6S0RPN3hhZ2JBbVBtb3BIMk9FbkQ1Rk1GUHkvbUZn?=
 =?utf-8?B?S1ZKajJIQjJ4U0gvVmhvZDBtVkFsbVhBRmJFdTRSTUM1MW5DWENxdVhycjB6?=
 =?utf-8?B?WTVpTnpON0d4WERYbzZ0WnVpUURWN2NHTE0rNU9tcUcrenNKbmlXemh1aU1i?=
 =?utf-8?B?ei9PZFJrcE1DR3ovenNIVS84R2tMbmMzYzZnQ2hRNmdOb3h4ZllULy9aNlZS?=
 =?utf-8?B?YzFwZkZHeVoxS0pwcXZveWVPMFh1L0xYK2dBb0dlc295V1VNQWNZNGo4N05y?=
 =?utf-8?B?UkFhcE5VemQ2OW5Ea05WaS93RHdNOUUyRk44aCtaOXFGTDFhcE15V0ZMTEpy?=
 =?utf-8?B?QVZlNHZBbUd1Qis3bExiTDFlb0NjcVNMdEZ5UXpacnAyZDVQOVpuMEI3QkRQ?=
 =?utf-8?B?aHVMeWh4Y0hWbFZDRkoyK2s2L1JvSTltbmxFaVFKeFFvSU5oUGtiSkF6VG9Q?=
 =?utf-8?B?Q013SElsUXhSOWFuenppRjRJTWFHR2g3V3JSaldnT1lLN2RWSWVDbUxjL2Zx?=
 =?utf-8?B?MGM1OUNUREdkMlZoZmx3L2l1ZEpOVFZFWkpFenlXcDhlemh5VmpsZ2F3TGlE?=
 =?utf-8?B?bmljVHRkSkg3cGRzOVRsTWlCYkFqNVlIa1EvRHFVQU9Yc2FaZXRJa0xWZUVW?=
 =?utf-8?B?RXZlMlQraW94QjFiSlVjYXNkQkxVTSt2Um9MNUQzMkp5UUZULzlJSW9HUDho?=
 =?utf-8?B?OVhVdFBqWnJYbFV4MWhRelVMTm1qejM1cmdxVWJwR1pwS0UzN1FOVnVVUGpN?=
 =?utf-8?Q?cPo/dJ7PXeRCpL5CUk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0kN6BMGaw3PADqVI2uba/2uEFQ0VHWQ4xkFerYgstWKHNmO/qx0EqXOdZlHNC7tjVzqma+unqAWlZBGmpVDxrZt+TkFn0pSJhGGeBJ1dzOVWchaqD0S2DDQkMQw5HNsmZ5ZxXQlJ7pW6+tQDceBKGw1eYdT460RaiGbesTKfz6b19afA2cgYQRMDYz+8Vrkht8vyXxjJ7qpPszLOWv83WiRVoq6j2U03Sf2tCXe/z/mjZVmEGiLZp7aUlOIqThx3pIKXK2Ym3uSlQkDB0VTr4/5gHDlCS231bGLs0Nvc2+n9WAVm4Y7rYfxFZt66Fz0CNTFTMpB4PF76ANZ6YBGxDQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e46fc-93d2-452f-dac5-08df0a3a179a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 04:07:52.9636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwjuoNBdq2S2sKWp9kJTtDVdyglbCRUlJmlUBKsJmtadr1U3xSTcbNHIwR6yea9qt+QLToAL2VpYHq3KKwH10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDcgSnVseSAyMDI2IDA1OjAxDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5r
ZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXds
LW5ldCB2Ml0gaWNlOiBhZGQgbWlzc2luZyB4YV9kZXN0cm95IGZvciBzY2hlZF9ub2RlX2lkcw0K
Pg0KPiBDb21taXQgMTZkZmE0OTQwNmJjICgiaWNlOiBJbnRyb2R1Y2UgbmV3IHBhcmFtZXRlcnMg
aW4gaWNlX3NjaGVkX25vZGUiKSBhZGRlZCBhIHNjaGVkX25vZGVfaWRzIHhhcnJheSB0byB0aGUg
cG9ydCBpbmZvIHN0cnVjdHVyZSwgYnV0IG5ldmVyIGNhbGxlZCB4YV9kZXN0cm95IG9uIGl0Lg0K
Pg0KPiBTaW5jZSB4YXJyYXlzIGNhbiBhbGxvY2F0ZSBpbnRlcm5hbCBtZW1vcnksIHRoaXMgY2Fu
IHJlc3VsdCBpbiBhIG1lbW9yeSBsZWFrIGV2ZW4gaWYgZXZlcnkgZWxlbWVudCBpbiB0aGUgeGFy
cmF5IGhhcyBiZWVuIHJlbW92ZWQuDQo+DQo+IFRoZSB4YXJyYXkgaXMgY3VycmVudGx5IGVtYmVk
ZGVkIGluIHRoZSBwb3J0X2luZm8gc3RydWN0dXJlLiBUaGlzIGFwcGVhcnMgdG8gaGF2ZSBiZWVu
IGRvbmUgYmVjYXVzZSBpdHMgdXNlIGlzIHdpdGhpbiBmdW5jdGlvbnMgdGhhdCB0YWtlIHRoZSBw
b3J0X2luZm8gYXMgYSBwcmltYXJ5IGFyZ3VtZW50Lg0KPg0KPiBIb3dldmVyLCB0aGlzIGNvbXBs
aWNhdGVzIG1hbmFnaW5nIHRoZSBsaWZlY3ljbGUgb2YgdGhlIGZpZWxkLiBUaGUgcG9ydF9pbmZv
IHN0cnVjdHVyZSBpcyBhbGxvY2F0ZWQgaW4gaWNlX2luaXRfaHcoKSB1c2luZyBkZXZtLCBhbmQg
aXQgaXMgbm90IHJlbGVhc2VkIHVudGlsIHRoZSBkZXZtIGNsZWFudXAgd2hlbiB0aGUgZHJpdmVy
IGlzIHVubG9hZGVkLg0KPg0KPiBUaGUgaWNlX2luaXRfaHcoKSBmdW5jdGlvbiBpcyBjYWxsZWQg
aW4gbWFueSBwbGFjZXMsIGluY2x1ZGluZyBkZXZsaW5rIHJlbG9hZCwgYW5kIHBvc3NpYmx5IGR1
cmluZyBERFAgbG9hZCBhZnRlciB1cGRhdGluZyB0aGUgVHggc2NoZWR1bGVyIGxheW91dC4NCj4N
Cj4gQWRkaW5nIGEgY2FsbCBvZiB4YV9kZXN0cm95IHRvIHRoZSBpY2VfZGVpbml0X2h3KCkgY2F1
c2VzIFNhc2hpa28gdG8gcmFpc2UgbXVsdGlwbGUgY29uY2VybnMgZHVlIHRvIHBvdGVudGlhbCBv
cmRlcmluZyBpc3N1ZXMgYW5kIHBvc3NpYmxlIHdheXMgdGhhdCBwb3J0X2luZm8gY291bGQgYmUg
YSBkYW5nbGluZyByZWZlcmVuY2UuDQo+DQo+IFRvIGhhbmRsZSB0aGlzLCBtb3ZlIHRoZSBzY2hl
ZF9ub2RlX2lkcyBvdXQgb2YgcG9ydF9pbmZvIGFuZCBpbnRvIHRoZSBodyBzdHJ1Y3R1cmUuIEFs
bCB1c2VycyBvZiB0aGUgYXJyYXkgYWxyZWFkeSBoYXZlIGEgcG9pbnRlciB0byBodyBhbnl3YXlz
LCBhbmQgdGhlcmUgaXMgb25seSBvbmUgc2NoZWRfbm9kZV9pZHMgcGVyIGFkYXB0ZXIuIFdoaWxl
IGhlcmUsIHJlbW92ZSB0aGUgb3Zlcmx5IHZlcmJvc2UgY29tbWVudCBleHBsYWluaW5nIHRoZSBu
YXR1cmUgb2YgdGhlIHNjaGVkX25vZGVfaWRzIHhhcnJheS4NCj4NCj4gQWRkIHRoZSBtaXNzaW5n
IHhhX2Rlc3Ryb3kgdG8gdGhlIGNsZWFudXAgcGF0aCBhbmQgdG8gaWNlX2RlaW5pdF9odygpLCBl
bnN1cmluZyB0aGF0IHdlIHByb3Blcmx5IHJlbGVhc2UgdGhlIHhhcnJheSBtZW1vcnkuDQo+DQo+
IFRoaXMgd2FzIGNhdWdodCBieSBTYXNoaWtvIGR1cmluZyBkZXZlbG9wbWVudCBvZiB1bnJlbGF0
ZWQgY29kZS4NCj4NCj4gRml4ZXM6IDE2ZGZhNDk0MDZiYyAoImljZTogSW50cm9kdWNlIG5ldyBw
YXJhbWV0ZXJzIGluIGljZV9zY2hlZF9ub2RlIikNCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2Vs
bGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIE1vdmUgc2NoZWRfbm9kZV9pZHMgb3V0IG9mIHBvcnRfaW50byBpbnRvIGh3Lg0KPiAtIExp
bmsgdG8gdjE6IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDUxNC1qay1maXgtbWlzc2lu
Zy14YS1kZXN0cm95LXYxLTEtZGU0MzdiZjUyMzQ3QGludGVsLmNvbQ0KPiAtLS0NCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV90eXBlLmggICB8IDIgKy0NCj4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uYyB8IDkgKysrKysrLS0tICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3NjaGVkLmMgIHwgNCArKy0tDQo+IDMgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQtYnk6
IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0
IEludGVsKQ0K
