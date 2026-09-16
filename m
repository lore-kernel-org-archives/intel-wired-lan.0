Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BBAC88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 06:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C848080C1C;
	Wed, 16 Sep 2026 06:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2xPdKL8pROM; Wed, 16 Sep 2026 06:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F61480C1E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789538638;
	b=dmrQsJd8gEdQMBXNggrrCe0y/D9QLn0c5DmT2FNAqW05NE2LZw1poe7CpoceqLJBHFcg
	 55n6r8MGdnsZZeOY83fn3lBfjBqbQI2lsopVqADjUiwRn8f4IR5TYUStNPk4cg22RSRRU
	 QRET/gKNP+dcIq/up9iHsK3YKneGfKutD6/qZlKXsqq87oJsuHCnzphTIDZgGO6DHeJ0G
	 dlUJWZnVtXOqcC2uq7PEd4U0P6JH9tLN6tTjAGIRmzjp1WH6YweE3rdjcR4/EWp9EnlM/
	 jLu6sssT+Q3TBlCYBEj1MGTJzUL6WNWDx/EC6cRnd3ukuibe3VzuIb2p/CRYroslVkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789538638;
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
	bh=agIf9bBAnuhwqU2l7HczdkGv+Ttnoi3DnzUMpLf2X/U=;
	b=oRxYiW/0e+vdQyOX7d2Owom0Azxa7cIai+9yI8ixiaqH2OMUlCw11FGeWhbF5tmlQ4el
	 AoYAhcX98nzpg22freH9kO33bYE7wxsdEUhikvvzn0WiwKHltfhJ5aRM/9UXHnLWuI1nl
	 1M9sv9xgqiPKNxxbPhRBOWXsToObTcZeA5G6GscKri6sS3H8PuLVLqPOmk40fX1Oeq69S
	 rlTLJty9j9Dw3u3me9fk9I8ncHnS/AhJVZ4akboZil0E+V+j+9Ux5qqTTCGZGpyLOL1mf
	 oE5Cniox1y1iF03C7MMGXfQ/xx5pm2yKpE4+SpX6uWB11wLNSsoitkasYA71OFhlURw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789538638;
	bh=agIf9bBAnuhwqU2l7HczdkGv+Ttnoi3DnzUMpLf2X/U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1K6MD2awmw8T3AvcxPh3phXddW8zC3WYL0UVNJa2Bb4svYhWKARHcQu/kYe5XT/Jt
	 09ES2DGgxqBdsorDDgZcG7LkjpKJgAH37lwfOKJj4zu7e2R8uuRSzwt0sLMClvkzyJ
	 h/fWe1B9pC0arppTnG39D3kK6Kvzx5KVKgpWO0pUyJVjN4R6gtdgD83DTZUBDU0v5q
	 Y+jq0TAUKm7st3wk3qYi/r09q1uqXpeyKMjNDYxQHX/XZ9l2vDAy+tmbWKrc2y2ksK
	 6IDC+t+ifQWYh6yhTD6BFJcdd+YEbG4pPJUPJ9O5LHdscGhZQLmUF8WpiQWEPT367Z
	 3z77p+v6G+djQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F61480C1E;
	Wed, 16 Sep 2026 06:03:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5BEA23F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D74AF4009C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSUM9MgUvHuV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 06:03:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EC8D840076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789538636;
 b=H/WuLYjvIrYhPjAOtuE92n59kpiLJaLLBIsp2N0BQoDf6tSEVtLTBTfyLmK0r2YUXTKj
 CFDRngYQT0+x4koBIMjoWICv7ShknDVKts6pgPSi39UfdDaw845tXEE/uMFEbEJsbGugR
 4Cf0a5Yxxr8U4cnGTlHdyBmbl6yoXc3qGG4sh0P9vpjVVgCrXNDV3e0b/iL5ERNSYSd9R
 NPUVvTw3ru5KXeKUeOt3ZilQFqlIYvMWdJNbIzed8CEKKSzeaNcQ1CHRXNzb3S94FpmYo
 k1UWSJ/CvIQbpllLO0Xtrya6gRWWJDDtxXODSg2b4pI7iGhVF6YIYyf6Es7MwwF1mGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789538636;
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
 bh=agIf9bBAnuhwqU2l7HczdkGv+Ttnoi3DnzUMpLf2X/U=;
 b=nZdH8sxEFaLRz1AuUnVaIY+Bk/rtqhH9sTb4N1dPDupEeYWDhJS+kxK7MLRXmrfDwcL+
 2t5fdbPGGNVQvi4yArWkzpUCIweFqFu2fZGvQlp3pAehmCv3ZovuVTgT7cZdfMr+wxGY1
 Ge3M+HMx4jGCcBDL+dq2+kuDBZ1lcHNKwu96JpBIV3EW8We2xbbKivEPMHIgq1mFPex9e
 O8XnBR6TznZQUVO9R8jSQkNUYOv99kzENrxGVWkMSSavCxsAoi0SFRrbmLZv0s7NQtNns
 Gbnc1TvCWcN+1TUCo9C9mprwDgvi3MFm4b2eL5d7ww7ZlKV9f7C1snrxJXByklrmINA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N3If8PBb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N3If8PBb
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC8D840076
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789538636; x=1821074636;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5eG5jjCFjS9w3+f3CqdScFuu3ZTkyPbVc054evw15aM=;
 b=N3If8PBbOBXMaGpcH8O7yc1mgn41lRHwSegdhz5JbPDEdJMZLW/p5G49
 VZcyslVKL/tNf8IdwJi3GmpZMCBFTsm1IHwGF9hO7//31zQKc905Uq38L
 MW9SuxJsWU7nRQBUdP7vYESHNRH1Nn1QvA3E2nrc0jOhnYTzi3BLLV0Hz
 WB4/8TADPsBYYO9zNLPLWjjdRyOI4TVvNCD4CXLl6LZps/sXFkzcIp0NZ
 qmvotyz70W2oLzOpA0DVRj4ouI2d1xV1KwnaXhzSwx9USuxvzweNffCqU
 sJ20WmTMkX2WS6seshN0dUeva8KmZC8Y4Mjo0fRN2hfX7PW7fWlhO/el4 A==;
X-CSE-ConnectionGUID: owZam61rToazCyaleha5vA==
X-CSE-MsgGUID: ebBGFfPFSxq4z4Wa2WUgVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112678179"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112678179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 23:03:55 -0700
X-CSE-ConnectionGUID: 27u8AwB2SC6QFQRAIPy5ZA==
X-CSE-MsgGUID: aCvzWEj/S3yRw3C5UQXpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="311507438"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 23:03:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:03:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:03:54 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl4nO/cyoZsZt5nF/PrkVLqM8uST0fMnCDeT0+JGmWX5zqmnpV2zX43l0omZj0w01K2rI/BND7P4ZfhVl2c/0LwoSixgMmOZtKivQUf0OXAvISiwe9NyoeSvQRsMniUz6SD6L/xA1zmAThSthNJWAf2JgqHLJ+/VwLZDxtzS1rz03VHzjNyKI7nrMPCsD894lxXeSY4FLZ23YyYkaCJuTSdOFvgZdCWHSZeBwUKlJD6o04cV7kH5sd6KADbc365pLoj51DFTrFYm40U6FBCJhuODuQ+AgJAEbvsltECIBJskUmf27Uk1flHTJjx7Zv1PpdJrs5NGuplyfyyuzwDHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agIf9bBAnuhwqU2l7HczdkGv+Ttnoi3DnzUMpLf2X/U=;
 b=LwmLb+GO4pz1OsP/IgtXDSaZznb4S6vl2sYtXv9pvgdis+03ysl8/+s2kUiQ1+zZVv10pruVV7Uu6WANXPz2q+NbJ9XkEz5lDlTQlIj8v5e+oDs+KQzZfeeyCLSo/NxEAnBq9FdqK7qo8BEI5luD+J1YwLY2n/Cf5wXwOcpZ4axD9TxlW4boF0tcsFSHLQObu9MUaj4J+NF5r3i0xqwyEO6hhtzDJye3yHXhgW3YYm3EWGjEdIJ6ZuegcOwjNYNFRXRaqClN5lSg2Bbh5/oWvXWU84XTUWqHSf1MDoWOYN06Wf4M4U6/jXPQ9zLEYDtCQ40t7cTwaCPd/ddD6qb/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:03:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:03:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile count
 returned by the firmware
Thread-Index: AQHdRQrRfvaJSY0aiEeOb2fulu+PKrbQt/Qw
Date: Wed, 16 Sep 2026 06:03:45 +0000
Message-ID: <IA3PR11MB898605544C71BB998C0FA35DE5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915120354.610499-1-xiaolinkui@126.com>
In-Reply-To: <20260915120354.610499-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 33853584-7114-45b4-8025-08df13b8445a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|921020|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: qN04DiMF70TjfG/j5+GtAvzdoOZW/uxAyx1QhT+NUCUzoOv6Mdh5pjOf3ME7Q/cfFFnSn7UnqWNmG0deapFFOUNtz+rK/XWIAeZl4A/W0NFgKCXdcMu5cWFXMWOwA14a+WPP5dgzvUZaQrGfOZ4ITLk5VNHKOsxVrdZiAhabIcM4KcTE60KlUcdeOBUj89pgmtim+9oMwoLMUur2gtJHYFCOX7vvoO+3oKdv0ts7y3QzO0GKAn7nhlf7uwM1/whfGZVF/VCdYDsCP20RCf8ixV3K1AbWCIrfHneJStCVPDudThuUKvsi5iICHY0JJ3a+rHAwJS3tdYwRRncBw6/R2KMdfVYfwFmuvQinciofEJqtr2sRcIK8UcecwkmTyxX5uqOz0QF7Rpvb2AT+70MvyRFZdKKjJ9CDLvHEjo9g3ANryy1Kr7ICEmaTSeMIuzAwh1nDWzPr/LqEwmfB/kRTaxTC2MGc8AapxsxCx6nn92kr4jfHLAXyPlpdIvymw1ZqkQFY9xC3V6J60xJal2R6LhhYdmu0XygLdNnvzoE1wBrbFHPOZq1nxikVxG95OfXyIg92MTWl6dnFzu0c4CcY+W2Y0k9xEjBMPkcJwsELXwuifAfOBuToIarQVLwLQrJoXpwEc2cohhqgNvJlPfg2MnhVu0dvZ2ei8DwoA2Ponh9C3/mrGylZZ5Pw/GtUlE8mNKTmBDRXLl/5m5dfQh2qmbSMR+oqrd5D7WuBOSmafxZ51Af7GWjuqyLvp7Czw6R/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(921020)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QiK5Cd2QsxPoDRG3IhZB2t/WYYfRdMOvpTJw6CAPGnkDOimG7RcepTUT+V8/?=
 =?us-ascii?Q?n5rKVVtVWW0OXSTaicIC42zEtYgyaatOuufvsuQ3IQTwVLLgiFCQRiguRqXZ?=
 =?us-ascii?Q?zLNJZ40NFbAVAnBviRFTCMqgq8VS+BbS7CYCjktSTd8xKJQiqn7dnrFwCrGl?=
 =?us-ascii?Q?Nvu6g6nrGWN1z3jSivy6kPcCUpaIgZOZAJhdLEM5ALhZDw6HXzX9wYva5o3R?=
 =?us-ascii?Q?mKi6on/ucEubin+HRwLolXl5eTuMsjWfY6kWhpSZqxb/t3WNSWp4LjsmSl2p?=
 =?us-ascii?Q?DqjGFbZMqSsjXemYFo1SOXK0Wz4XHvRYiZyhr/e797sWX1rfTV8Y9mo7U43W?=
 =?us-ascii?Q?mFnFs8lQzcd93OUy+P/45IcXKx3CYHEqUO8dULVKwMlOXMmw2qDb7DWjhFIi?=
 =?us-ascii?Q?9S+DuqwTcEje+thdkaO97ExEz3FanWVLPwW2vP2+rhvMP5yqhk7tLJ5GghUD?=
 =?us-ascii?Q?UYwFwBMNXUPDFB2XCBzACqKSiAjTjvYhc68x1xhDSnHFb09ZZI7Jm4vrDduR?=
 =?us-ascii?Q?A2c5DHxbz/oxr+duaiq6a707F8sAg1AoVBhz+rvFL0f5Tn+Y3JD6dJsbJDvp?=
 =?us-ascii?Q?ot1iNKoxrIp2TJe1eWSZhw0e4IGkywQaTNVyIKGwkmIyaccpYkINUKFuXb4q?=
 =?us-ascii?Q?LXd3NoSJtQRoURPbFu/yctR4CTNd0Yt8RUnAORne5bL2wrEB1wql2B171Pkb?=
 =?us-ascii?Q?qIu6rcg5v0F4B6a1zxKso4BddpQ6bF5Nr+LNkqsK+U8I2IkZIoNX2Tzb0H/w?=
 =?us-ascii?Q?XjTO0ICLD3839nNPHVRdsrZKo/zv38Ds+T3gOjpvroiLO+5UbI9+43gG2fb9?=
 =?us-ascii?Q?jiNxAyu/5ZLTDOxXKTdmsmBpwc33Inzlv9J5/YfCQVCWyI6IFyHZKPN6i0dc?=
 =?us-ascii?Q?A+S1TQ0j3f0gRdtZGgKiDuvy1Tx4j083YGvt+iVnJwGypdxwPYVCQ+79PQ4F?=
 =?us-ascii?Q?JPjVXGC7xWMqIwm8NaCZUbwxcVYPxPYSzdP9H10LYqqLnewUeJ5Mg7QdABPG?=
 =?us-ascii?Q?50bufpH6J5qTy8c+73PFy3eSANmrvjm+/z3reM1kmypfTZ3qOyLRbP95Fahk?=
 =?us-ascii?Q?UuvSBRQzM2hkCPUJsCJVoYwfQr1TCmZUp2MabLmqJB7inM9+OwD6Q1IO16+1?=
 =?us-ascii?Q?MlaSF/Nech427ZDd3RdRYsVQ+QgGORyz68gw00Chc/nisnqj3evqTqTzImnC?=
 =?us-ascii?Q?UK5+/EnhUZE6IHq3rLilFC+Ksdvu6tf6mo+QA9bLypUARJxaR5uEAlH2pB3T?=
 =?us-ascii?Q?TYtW3njMdmGS3Ne+NQaniSD2++xNT9bRMrPpZfW45Yhw+qXkuyYzKgGq1fSB?=
 =?us-ascii?Q?Th4g7WuP3tyUKgAq0VNXvmBXdgPYCyPS7nCRQmoKSdn5QVTyRHCrRMqKFT68?=
 =?us-ascii?Q?O8eGpVahtLJ6FZkhr44xDxLAp8SeYTEI+CV0jnzW1qALYU9Ey2E+saScxA6R?=
 =?us-ascii?Q?GXEb6Kkyq3VcA1FI7zVpUf8xHbACpUY1V7dnWV7Xs0gMH+3RwfMiJITcUtU2?=
 =?us-ascii?Q?YkY1HcJYvKoshdVtTqtyeogcoBMm72sATIJnEJ2xBFzsnVEFaJVV2w4VRy3m?=
 =?us-ascii?Q?MTFPD9ddiFXgO1/pJMbiPuRmpVZDCw4NYRvSdxt/hsNn8vZ6LUMVfVvxqdYU?=
 =?us-ascii?Q?TFLfq9qScHeRBLwJBKbFbDezdKLK/cKlQmipeWaP0eiorUoMy9EdSVLTyvFD?=
 =?us-ascii?Q?k3qTPj/4axVEmdnQzhe3kbbbtQJc2x5FyZw8WUA7uZ5dpndVVkwNBnZOEqvV?=
 =?us-ascii?Q?NlwrZS1tHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C0w6gK+IyuibsGw8j9fenygeeuPFZIYCl5Mj4U+5vkAoOKfBZwO5gKzXWcl91VjFUAnG7WymBIvxkI3cJMzhAE7yz4ppbU6N240UmSxDGqZepye1iGOr2/fT8Qvt+aHLbh31K1u4EMIBLdhEF4cZa5YyNGeU/X6CbE3VhD3Ku8RJVEVbttT20r7VvCx+jqwQ2ZaLeKYVrwx7+Rpka9cbY8LHopALKo01Ei5mA+jNEQPflOk2KUrz11MMRVA7FrIIAp+FIEjxXYmc9WgCbnxvWlNUMRrt9WsGu2jR99psZLKwrA/m8tIgXP1bMm58pfhcK01StYQRvbVcDIGPcFD7Lw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33853584-7114-45b4-8025-08df13b8445a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:03:45.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWPutyxo3nC51ELkVpoy0Sz/JR8pZFPSTI/ITLv4kMF2oAJvMdrrUNY01YXPP8kKLZhQPcYPMudNoX25A+lHx6TbWMrzOHMXWFLl3bJFFBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Tuesday, September 15, 2026 2:04 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net] i40e: limit the DDP profile
> count returned by the firmware
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> i40e_aq_get_ddp_list() writes into a I40E_PROFILE_LIST_SIZE buffer,
> which is sized for I40E_MAX_PROFILE_NUM (16) i40e_profile_info entries
> plus the 4 byte p_count header. i40e_ddp_does_profile_exist() and
> i40e_ddp_does_profile_overlap() then loop over profile_list->p_count
> without bounding it, so a firmware reporting more than 16 profiles
> makes both helpers walk past the end of the on-stack buff[] and
> compare against whatever happens to follow it on the stack.
>=20
> Clamp the count to the number of entries the buffer can actually hold
> and make the loop counter unsigned to match the field type.
>=20
> Fixes: cdc594e00370 ("i40e: Implement DDP support in i40e driver")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index daa9f2c42f70..1d6d8b3835a3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -55,7 +55,7 @@ static int i40e_ddp_does_profile_exist(struct
> i40e_hw *hw,
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
>  	int status;
> -	int i;
> +	u32 i, p_count;
RCT please

>=20
>  	status =3D i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
> 0,
>  				      NULL);
> @@ -63,7 +63,12 @@ static int i40e_ddp_does_profile_exist(struct
> i40e_hw *hw,
>  		return -1;
>=20
>  	profile_list =3D (struct i40e_ddp_profile_list *)buff;
> -	for (i =3D 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count
> reported by
> +	 * the firmware is not guaranteed to fit into the buffer we
> gave it.
> +	 */
> +	p_count =3D min_t(u32, profile_list->p_count,
> I40E_MAX_PROFILE_NUM);
> +
> +	for (i =3D 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_eq(pinfo, &profile_list-
> >p_info[i]))
>  			return 1;
>  	}
> @@ -110,7 +115,7 @@ static int i40e_ddp_does_profile_overlap(struct
> i40e_hw *hw,
>  	struct i40e_ddp_profile_list *profile_list;
>  	u8 buff[I40E_PROFILE_LIST_SIZE];
>  	int status;
> -	int i;
> +	u32 i, p_count;
RCT please

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
>  	status =3D i40e_aq_get_ddp_list(hw, buff, I40E_PROFILE_LIST_SIZE,
> 0,
>  				      NULL);
> @@ -118,7 +123,12 @@ static int i40e_ddp_does_profile_overlap(struct
> i40e_hw *hw,
>  		return -EIO;
>=20
>  	profile_list =3D (struct i40e_ddp_profile_list *)buff;
> -	for (i =3D 0; i < profile_list->p_count; i++) {
> +	/* Never walk past the end of buff[], the profile count
> reported by
> +	 * the firmware is not guaranteed to fit into the buffer we
> gave it.
> +	 */
> +	p_count =3D min_t(u32, profile_list->p_count,
> I40E_MAX_PROFILE_NUM);
> +
> +	for (i =3D 0; i < p_count; i++) {
>  		if (i40e_ddp_profiles_overlap(pinfo,
>  					      &profile_list->p_info[i]))
>  			return 1;
> --
> 2.25.1


