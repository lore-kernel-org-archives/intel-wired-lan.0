Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238BBC79FA0
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 06:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE648403B1;
	Tue,  8 Sep 2026 06:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGoVlCELjIte; Tue,  8 Sep 2026 06:19:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2D99F403E0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788848382;
	b=B38RqeSOqtASQCUUud8W8eOb5a1les0aFQTnqE34w3qpdW/kuImQgUWdHOI7/ruct54H
	 t1JxFYkHppR5m+mgGjYr44MFHUCq/KWGL4EeYBZ4MUgbi1cLln6+/zRR8VcB3HwN/0C1i
	 e8BWii1e7efBg2+XfO8eZOdeSBzIFmi3VXrFWFs74erW+AvxqTmHCArvROUx+XljnDUmb
	 nLY9S5LTM/wYnOcFb9TziE5GS9KOq5H3hqtzi4I4yTeAHRMcKEtwE9xEr+s3YaytLb7uw
	 dM63soq6vsrNobBn55hnhczbpH5NGvdvxwCBkJyfEHvbWtApiAqXlkwaU25q14u2NKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788848382;
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
	bh=GHza9/weNaTrx/6XVbEYZ+BJ9BqWPWncKhyNsxKJRvA=;
	b=qTtab9iBlCImhlDm9VWJo/Vp82cfGMHXxlVkh9fd1/+VqJJUopQEfJ7Sz05Hoi2sPes2
	 JAUgKU/aqC0RAsrwI29h6vhnpmSg0067IZN7i61eyfhC+u1wZLvKDg88RvHnZrAjIwkoz
	 v7ydBI91kM5sUnYOWIoOoSr6uH2k7L0lutWuzishCI++Q043FKXI/nDNL/IxTwpkwoXxY
	 qu82HO4OtYCyEFrXzBq23vhhw3UgqNmpYJ1SwPlTO+z7QZ+e7h+dhR8BHWUBmlINhen00
	 NIb/mVzRihek9QZdDNEhtqXTfJj8RnL29vmcZ3J82KFlF+m0bhBztMSblAAiF/wlePg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788848382;
	bh=GHza9/weNaTrx/6XVbEYZ+BJ9BqWPWncKhyNsxKJRvA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c2CJls9LE5M6j+17BMUh3wYqCFJF9VszkGNCe9I4x/HKOoJ/C/A5tz6iviX4aaMLm
	 lqqnLuGvPjFgBloMTVXkZVbNY9Oes82Qod4/digXyUihRxgYb6Ykx/BEHvZvy4A4tQ
	 YSbN4iTgCQDC9+2JGsII6HTmbeLL2zZ0S8nvCl7ozib11xg7uImE4graH9df8tFsxX
	 3XXbNybEAivuYANWjY2bXd2QoQJyoaYncIY+BJlE3tzZGfOOluGqxZf7EAES077gID
	 w0uuzE5XSSqB+6fhah/gsfUMwFeA1NirHRYOTcHeSW+erPmn0PY+aozGGnDabca7OQ
	 34ea1nKGp/55Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D99F403E0;
	Tue,  8 Sep 2026 06:19:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CBAFAEB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 214E660650
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a5VIu4M8GtHr for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 06:19:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5DDF560609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788848380;
 b=DQxNzHfqUj54Bih1Q8ckj7qTESp1QC5azVnAgWBG5HmCxjhNPnSMC9gYihB1w1K9I0uK
 EwVeB3utuA72hhkvKv6iunFvIsjKAylpGXL17D+uNS6Ht9rAkxflIO+Ei2w993esqEz62
 6ty+hMYzf3zQHARo2/dsfE/Oes9z5jd9frzcjK5YlOcHuEo18S3Rsub4UpbzsiujZ37B4
 LqgSr8NpToz9fVLi9P6UrumUo3AFLEb5J/wCM6OXU5v12ORGeTTjr3eFNOSYAowwyXAzL
 qO5sfvHWT5OSJD/gzq6y+GiDkHIMBlcieqCoCk8IjSprrwNK58hG1PEc9EFURv9410Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788848380;
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
 bh=GHza9/weNaTrx/6XVbEYZ+BJ9BqWPWncKhyNsxKJRvA=;
 b=JjEgXmVNTQwNALdt754+HDYgX2/Suv5HGNUA1h0WEpAcS/Qs/MruNgYvpx6HNDD3PJAI
 FIxuJwBkVL1zn4+up9tbkVSt0Vulbk57Eba6nI8jUz1EgHbrK9yIop+ZdqJyAhfsDUbne
 R410emUXQLKf0wew0QY5QA+R7/5suS6N/IXYJzietWP5PC5zf/dgcXwnOCGuticgcmMdo
 kF12A+mC0ZzRIuoUKKaq+bqCLQim0nDu2h0eftFXV7H7PVkWsQzt2kRweXo33eTSm7c2X
 /00HFVM/IDgszxp3x7hQTaBZS8XggODkzQgauzgbfj/Uk7UlZrmFvsxSIwwqT2ENaIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Tt8oX6T6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Tt8oX6T6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DDF560609
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788848380; x=1820384380;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lbeS4oDl7RsgOPp5S1bWvv+FYifxnL7Kop6FgUOOkaI=;
 b=Tt8oX6T6LhQNKg1LCmYUhfKDFC/8dUUebZlTk3hkoWKjNfKvNhzBdIIt
 LIesiLqwuU6KvqOur0ICBoHNfPV4vgRzzaWQK6iqSg42mcaUCyehRPsLT
 AsvQMqtVurIEB84crXPxvuEQ4uM+lbnQ0hRHOFHwTQeHE7Y/PtKBt62kS
 nONlCrrVid5OlG8eAnJm2/Vtlhry87y4r8/f5lRff9cQcobTZgKjCuob/
 yt/BK/CT3wQ4lR6gA9wJNra8h2nvMv6OrhMaakY/xWnPyN3omNMGHMuJh
 eOs7fh1XV/oUzXrBoQcJUakMj0IHcOQMUe2NkH9YyuRf6zf8mELtqlKHf w==;
X-CSE-ConnectionGUID: /pVv0V86R2apXd5+RTE/OQ==
X-CSE-MsgGUID: h0cI3ePQQ2+caFevDQSVGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89085640"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89085640"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:39 -0700
X-CSE-ConnectionGUID: uP+jm5hhTUGYPR3xM2sn5Q==
X-CSE-MsgGUID: pRvQtuo0RHeoLReuu32OTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="294375957"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:19:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJWxG5y3ylKfqAQpGmYHnnuJhJf0B3Y+dKjllyTHM16CPmRdhG+gFAHCfupA4QiZjOSnzQ0DR9ys8I2DvS5JnIK4je1+yjFCWsWNjSh6op9jHfF3ag3AF27cc8uikvsf4AQ0xGgrzU3YwD38AGaXYYEkfmdpt1nyepHbG1ckXIg07s0oMxoKaNYmzliXBhbrcv3ba3tz6xyAO5J+adIL7/EhsZC2KqTwwh8mSE7bzGYEOsrYKU35ReXqpbweYg11CmbScSPg3DwuKxjmlRcR1xt3wFoM0SLovs7wqUNzbSQVf6KYGKCD6phfKwvE8jBIUCYnH4rKhHbflkysm+KR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHza9/weNaTrx/6XVbEYZ+BJ9BqWPWncKhyNsxKJRvA=;
 b=GOUeT7lWEBN3hZ659ovPiMj2t33L+FwLlYP5uLWrxo+rO8ht/PPNtYVh4oSxnwvlgFD2G63J5hU0E46308FzcWdldl+LXuPXrtdCyiVDfqvyuBEwP4TRRaICsA41MbYhenCNGhd8A4JQW07LFAGcHBcjHFXmQJqZ8jLsL+4mi9CpMd1vf/h/eYJ6H5S5Jy8IZxlMEaVGTcdDqgZ9viIJ2atOM6lJlsZnNYPTg38EIECL/cLR6S7Dkmd3t1Y0f7GqI8MLDN2OOd3ga0t2jR+616sYubhZpX0NwWYhjHPiVnP3kqU2OYmc3rVqvjLfFHGhzSnxq4CVD1/ba+K8LzU4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:19:35 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:19:35 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 5/7] i40e: fix potential UAF in
 i40e_vsi_setup()'s error path
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 5/7] i40e: fix potential UAF in
 i40e_vsi_setup()'s error path
Thread-Index: AQHdCVeX5h9s5ls7gU6q3ELJoXoeyrbEnIoA
Date: Tue, 8 Sep 2026 06:19:35 +0000
Message-ID: <PH0PR11MB7522DF402D33432CA959F518A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-6-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-6-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: 99506d0c-f248-4ba0-7fce-08df0d712798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: g4LXn8yvIukKFeTq88GCDZjtqs/JEcHvf8oeLspbi239L/jV17J0m25CrG63g8fhY22pp9KkCG+vElZIqvnxK0vzRt8XJcRsBYOyCDng6FVMCTZTzVSdprVbJC4dF8q5EPySHneXE9NtOCOVoE6HF9ET77urc7ZqeA5AV7lZ31PekEWQBGlSWZQDLtahgAabJNCVJ2DkCnaWYTLvGL+xRNTjL5dYIdN4U66s/7n6u1RGXjM6eU7CC/Hzc91cyTI+ZnnU1C2F9wV/f7ShYrqXKZOzEQBiIJHL13v/mBygZPh0Wc00Zfx8Yb+oKGkX/yzy8/XNsW8HlWRc7f13L28Y6KWqcZmLL+pQRZ3ySdBBuhsg6HgcYkhC1ai//4IjD8xTP/HBo1EEPRFULN3GSobe9aQjU4NSx90lZJOiWKq1MbLYjpajiXcYgsqFYawOP6v9azId1bNUgxreMwrC2/VdqrLlj2F7VS61pi9QerTF+7qIhixh3eb86JUHmjeOR1Zirr7n+cp4pvb6+61RTmacx2qxM0ZVzQDwmR6u9DhRh2uKA4W3nrXSSXeg8+LPYbNiOWrzkcByy3wyCHZS5Ccn9QjiGOzsTD67Xz89b760EdAZdOwVcWAa+933rczSGZYpAIGEyqpgT/B1DjDjN45VeM7ZqBMV58E1+6GY+uNgY0FtQSi4hku1P4a14ceON7QkLQD80wEAm8O0FCMMc1ixwcjw5YSjOlvXZiXzlsPGd1o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+d+MmQ901VKNA8/EAqU8POFRmRhTtm7NDD/7FuBUgNHBTUuYtMlkdansARSC?=
 =?us-ascii?Q?7yOJJDc37aqCdqk2nJfgTZIpLSsQQ02dbDRgZi7VSjC44SGinXPmGZkl0BbB?=
 =?us-ascii?Q?IxlNPDMnsnbqT7An6R//gbjY2fHbnKjkhlYNF8Htj2UdlEmpnr2mTRa5JX0Z?=
 =?us-ascii?Q?I1qb38GxNU5BtBFqu7GouL8/0hZ2i11XxEwVhfPPgvtbjPLMVKRVvU8FamPZ?=
 =?us-ascii?Q?BabZQ9hHIWbcdgHTkWmocb1j1E1SugncTZFm44cEIRXZ0MGBwbVZTkKzV0ah?=
 =?us-ascii?Q?/pZVq6+TvkbTKZM40Gx2hLN60eMBGA7E3YQyNdtyEUrjvlzO1u7QIq8eg66q?=
 =?us-ascii?Q?cJSiVU+84XSTn4zrdgecnV0LvxxQHXkL8h0/gsVcI3D9QvO/b483hoOHJwqB?=
 =?us-ascii?Q?XmXCe6tpi/pSFBjALvvYE7wETIaabOu8TksIfFJK7iIuG/rfsDFWaD0OTykp?=
 =?us-ascii?Q?Tek+vGklTEPeiMD4YzWtK/xyyQkhIHdd2hA6ikeLxQvuiN7+vgoxWv2AqExi?=
 =?us-ascii?Q?Esb1MOIONPSJe17HIzxjEAik+5GpmbBNYZNfq0LzU6a5V7HEb0NFZlU676t9?=
 =?us-ascii?Q?mOCCIexaXt3TYKLSjdKOb7/qLJnhNqQaM0hYi83mJpLnd0TpuVG1SQUUU65A?=
 =?us-ascii?Q?tqRVL5iLnhV6414RqehgBxV783mquUJR9buL9c7gSAdV13u3LIZVcMK5W5cu?=
 =?us-ascii?Q?6j5CwzrS+b9ZucJ7J+OuUZC+C+rXXkD6nKfIZkcqehRkXWA1Bh6ZhJriSCVL?=
 =?us-ascii?Q?SXaqEh9DOTJRC72+hHFJpjxCOAxaNYyMQcxVkMpRayVrIdxdtW6YtjhLOqnN?=
 =?us-ascii?Q?WPjvp3XyLQnXYEdK5TdIg3BHYTl+bEp7Egu8z6fmmiko6qZ+17aspbfUjA8G?=
 =?us-ascii?Q?FREnE7uIJfbb6IzSlRSWqt1uHKS4PkgMZi2+x6oc68JWd2aU0gH5CgjsKuI5?=
 =?us-ascii?Q?9gtvJYVqDrCyfnlU/G+/SxVuCoibZw3ft4oi8uEUZ00zxYR2FZDIX0XaUvOA?=
 =?us-ascii?Q?YUmSNoMXjpqeH1uda1xLCrR317W98Zy0C/imVlXfqiuSBCXUyx95gcT4b0rb?=
 =?us-ascii?Q?AlBkiyV5iXSZshS7Svk6w0cRjIKnSVAG0DdbmkdVR7haM93dB8vMkMxpOWxe?=
 =?us-ascii?Q?vEVVHgOhHhcoAp9gffVa0RKPewoCFLzx//7c6GoyZVZVeqGWKxqtD29VF4VI?=
 =?us-ascii?Q?hmeGlN4vclTobOujPdA1ehvlRMBm+233sK3+LYtdQkLmyJa6IE2qgK4iRcal?=
 =?us-ascii?Q?OuySdCJE1BlX5+NUHq8fjB8a64AcDqaIW8kcTbRYNCx1z59N5PkmnkZcewAm?=
 =?us-ascii?Q?caXgeNCHrmSMmXUGZQJ3vz/xhbqzrvzi5R+wrcdoNTyUPssVS0nsjiu24BIR?=
 =?us-ascii?Q?QVahbi48NkFQujN+mISYSfRSUKoHBdxkR3xniIHOFYo93sqX/mxn7LW7OCw2?=
 =?us-ascii?Q?p7zfELRsxnDqKuV4Yrw/kF2lzDqGtF2Z0Bhk9sXhQ+5jQbzHu9SIKoDfRMZI?=
 =?us-ascii?Q?/QLPIfoSBkjUIarRWM5KV5KkpL/43kkS+wQsUohr56OGV3Z3dEeInQBy1RHV?=
 =?us-ascii?Q?IU6Bplk0bgWbtDGqLZ22JFgyzjwaaEOcoy2wF0qvNhP8jaR9iKx/B4OA36B4?=
 =?us-ascii?Q?diy7ORCdgsESGNwcQB+Q1femVRMaPTeDYhdkdv8JCrK/s99WbDaShVrpDjG9?=
 =?us-ascii?Q?ZTRsyPFz0c+3Rf/zC/MTjUf0Ak/R41yBhL/ic3v8x/W0w2YDJTug2jzE8GDp?=
 =?us-ascii?Q?l2XmT222FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YObxAWS0AaC0reWFgiNWLLrbI6Bn3WgUwiS/SKNb56IfDZkqaFka79m7yVD55I+q518pQyPPtTY20PGpLBqUcSxVjRGjqRcQIBUrCc+VuBP4ecgPlxiaaALgVNgC63jm4DSrSB9df/yBgsUjnukuSX1H9rj8JupUtboXg3Ge8UJiiCEqernCoMMncJ1O2XFA8ca8c82mDL1+0EMijW75FD31MSpuOpn0nkAHfmy9sYJ9T+TaunJmq+VZfDeSI1PesWwG1mhz50uCVmCensY9ga2QXxxbwi/lJ8TwY0FTbubCGJrj/hNGinoDcvmnNEl2b6q6ainSaAPKw/6e/66dUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99506d0c-f248-4ba0-7fce-08df0d712798
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:19:35.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lE8c8l+7ik3C4xwuuBVdEYWl/MsJq7/A9CUIBzpiRewn34xqtB9qudOECU1YbCcWgPPJuFaz3XHdhKUz4ym6zJETBzyU1vQxMABTJ2UL20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 net 5/7] i40e: fix potential UAF in =
i40e_vsi_setup()'s error path
>
> Sashiko pointed out an issue where error path in i40e_vsi_reinit_setup()
> released ring memory but then when freeing q_vectors, the rings mapped
> to q_vectors where touched which implies a regular use-after-free bug.
>
> Apparently i40e_vsi_setup() has the same problem, so swap the allocation
> and freeing order and fix the 13 year old bug.
>
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
