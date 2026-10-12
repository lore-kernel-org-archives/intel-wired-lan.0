Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E96FCA9ED0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 09:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D52E480CBC;
	Mon, 12 Oct 2026 09:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xdSHdQU-8OS; Mon, 12 Oct 2026 09:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53D9C80BBC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791795847;
	b=NmMlcu+jD0a6ZCZTQRcvDUW+Hp04jCgjFCsATMyV34s3tWARdvvbcUTzCn2CjT2Nj2an
	 v3Vmssa03+z5CT2VBW2NYrOD/yyqJhIJThvgPdzdzcA4Zv4tgDMqZ+59L/fghSwuQXlEe
	 ndFGB92B37borMsm0SCcjv9kszE2xtgY/08cywnNSqyNRuRkZqS4Es7amAZhuxYaNLv9g
	 gcpHpvuTgG2Ts0/fNNILMCGMONvDFwrTAgZd9XikaRpISHtOokOmsdm81vdQrn+ROex/6
	 NPcZjEGWWU0NNnqXq80J4qH2wgHtefVBXCDIuXV0Xd9GO/aDehE/sFHvD8K8Di4btPQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791795847;
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
	bh=BL57RewRwNhufsIfcolTiOHJJ451wDjbV/sCD5GpM0c=;
	b=FH97oxa9ECSa73hkDY8p0pAxzG41wwmgTpxe/f5AlNA9Qw06yuaTE0qVJwiqoMDpYTf8
	 Xw+hsaTitpZBzc/j3JegXJ+B/T7LI23lyC5478CeyXzDRo7qZc63PlW7DOHTRqiGjqxnz
	 jX/h9NbJb9Cxh4OD9ntfE+tDBh9H1bw32fia8WWKA6kpKloO+vn00DdQFcTeL04bmO+Iy
	 KQrbizXTocwtxXO5VYSmfZ05B53oMkqMBP3/5L283eXb+IkVfPjGRe7FSUVMLednXv47r
	 6kIP+pDXmDSu3HHbQTigaYVUlr7HL1CdujypQD/mhoKYtfZ+Yqs9QAMoKiN9fSbF7fw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791795847;
	bh=BL57RewRwNhufsIfcolTiOHJJ451wDjbV/sCD5GpM0c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UAOK4ZqKh2kRiZjq+d3GmjEuSoYX/RMC/WaLRZy7lbzDnIf2sQLWxnfvoNDF9+1Kj
	 H4Xx7sweT+eNpBnMYvreijTZg4dZ1PHjMHDSj9MwQvZvm3lwGSkTq0um7KRaMciCRB
	 J6erLrvH9nG1QiSjb+VAHXLcIHzKkrNf6Z/KKWm+oYltrP5cwRhcadYSDFi1cr6eII
	 bWQ6KsMIorvF9uOddkuP2Ru/FGorXcxKleRjcYSqxj7fmWZJDQYuACr+8cqipuXS6Q
	 Urg+3mm0DLIz929c3Rz6Jgj9+xdShwwgekJGiJM/pnHCmNjsp1YfwIsAoGFIikwjvy
	 lFjY0v2ccA7GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53D9C80BBC;
	Mon, 12 Oct 2026 09:04:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E816D179
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9E6C40606
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sn40l1y_pJSA for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 09:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02EC7405F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791795845;
 b=AfyOl7CjHt6l6UUs6I4pG5HHreZv/6fKJk7twpPyzSVWZK67GFTwy9L3lkDPs0+lpY0n
 5qhamG3HY70WYF8G71+oRK2Xj1Va3ts9H4XbWFpxJaqu+71XWJneJjzngoO3BfUkPkJRq
 spSrBDBht5guVwfEs/YcOKgsGKlaYpzM2kiusn0CfBxFVcPZRdb3Nz+I57z9B8AuQfMG3
 od+qRCXoUBzblt3eDNAXzN/iuryJ6CHxML5yVBJlLdWDj+6UWWHQYry1yktlQFdUO6M41
 rFSOi+jtWuQWXvx6FhzT39u0iE7cfp7S0J0AgEQ1fVpuheLVkb44lBbTS5yqM4NZsXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791795845;
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
 bh=BL57RewRwNhufsIfcolTiOHJJ451wDjbV/sCD5GpM0c=;
 b=mdw8gg1jyULDtoVn2P6ef7MdUqXWCzsEJ0L2nk8ihajNa9xAr64CLQHv/XScRKHdNQdR
 mptyd2kLO/+ImQHvBf4H3+J4T21K12MosYDfsznL2Kgr5oRZ42ygI5SmlkOyOOTAJIN3l
 oipG5pKaBTG0yeJm/osq5oiDRumPVxQgAD4wmwKCto0E2Q+yUJEgTyE1embymL4oG+l3d
 m+8FZxkhZyVDjPKhA3PThQpejmo1xnv9rw1B3ENvUozHyEy9bVnV0Q5Gmb9dW7y0i7HBe
 6iP+YQSZk0fsmIVuZEQof8LQqtuZ4qsM08w2Dm8I6kaH1/xOOvjZWSARsmQX66RE5kA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lldJu1MW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lldJu1MW
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02EC7405F0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791795845; x=1823331845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1xuSubFPfJHsj6inIbGJ+el4XG2iNKkjWvyxm2PShxA=;
 b=lldJu1MWuuohxndOUBg4/rhrkgLZF/sCxvTplFEkXiRrwjevZs2LW03v
 uyqbkm3/scsT8dAMNvMXbLmXK7MSWgS3ToE7yc0BMMaC+KGHprEFfCl/v
 pR+TrxTdCHvpwcmF5xJnQyWhSmHYSvkogPT5w881rAlTNZeLspSLH5wLJ
 UAHrjHtjNL73cOOCWiNiFofeVzo2LgJU6wBqH0WluEWn6P48khdGT3iYX
 YVUvdtEuSTiavbrWpNkzk0zyEoSOzlXGvTFW3zBdZecqHNxpg7QxvweuX
 b4/Vq5AehHi6s+ymVbjftgFuAqGL3/4YA0YafMdzvE7WQ1ny9X2DnYpYY Q==;
X-CSE-ConnectionGUID: r6t88IILTpShgAiseULaiA==
X-CSE-MsgGUID: ikY0GI21TF2W7jwwzez5GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="386210"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="386210"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 02:04:04 -0700
X-CSE-ConnectionGUID: fiPxTo+gRLCtbTcwTmOO+g==
X-CSE-MsgGUID: Gu2G3/YASHS3532LEqT0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="2682753"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 02:04:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:04:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 02:04:02 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY8xl4YpWj8fqiRPMafQacvNpt54lUyblnzj7NmavVt8r4QixxWLhxzVHsKSe63b0s9HKi65EXuwkE6Ud/8nXClENu137/xp2m8GPs2LSDqsWyd58ClbgXp9Vx051dcdYDDAePlsZbbYjFAAHRKjIEutB9+Gj0MPnQucvTB09PNPZ/TNafbjQZLMQM5VKcDIQXFkeOOkKL6RJ9Iu+U+ChdrOOZehdzQeGuDwtGYlxU0yPQ01nYZK8pOQAA3xP3WjsJgo0RP3LJgPvTENqJ2LlFT/ybnyVss+kNDrwIkAAKH5WZ0eGrx9gmnk7YSp6UgKCDy4IJkkkGA+GrMcK8qrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL57RewRwNhufsIfcolTiOHJJ451wDjbV/sCD5GpM0c=;
 b=TQw1oiCBCiRlLgpd34VO7GdNSpFj2bd7ql6JUZ+OqFUiA9HZWfWTPXMJvyzqM2xUn6sCuOTFHkU5LYbImtvaGKe1NAHFau6ADDOht1wmpuNRUCyp1jhgVbE2NowXX6zrGsM8sGIolkMUqME0E2tnHSzGrEYfYla115E3iGS8YODFG+C+yMjsvGAVZmryInzpBlsqmZohUMa1+YS04WhQ72QfxnjYJap6pVXzxWdq2rbMz+aYXvsznHLCqJ2GdniAUnNpLuH+R5Gnjz9g7Jp7oNaNFB1uQtTpNqYpnnIyLr02GoFm5ZtMdEQUVLgiHCCEpe4ys09mvj/2687faF29Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:04:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:04:00 +0000
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
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
 start fails
Thread-Topic: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
 start fails
Thread-Index: AQHdVyTNW1J8Cz+ULkq3k2M5MzvNVbb5orUw
Date: Mon, 12 Oct 2026 09:04:00 +0000
Message-ID: <IA3PR11MB8986209E6FF5BFDF54A54044E59F2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-4-xiaolinkui@126.com>
In-Reply-To: <20261008125754.3520773-4-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: 7eb6ad6d-5730-4063-0692-08df283fc14a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|921020|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: uwQKXM3jnLFMGyQa78KjD6prqjCByU9UuM0ULcAkIPcRhW5Vj646kMtJQIqF0RVJppX2eTO1T8P/oHnSqpi7oBHvxYMQHwGWCLWCT5kfd9pGNMFiH8BLizo2TLf9q/krUa5D0IlT10ukNOpL+nwiYAH+2ezYRroP/fKnfOlnGgB2mmYyC7bRK8KNXfRYaNk1DwMdWMMWzCnoe4aNMpf4O+EWdO688ATKrJEuu2wQVj1g+67LzMNoQkrrmlPrE2cbyujBBW8iwmMel7KI+unxKIH6nZX//XR5Z6my1X6MN+nkJbn0fE42GQ4OxySwdiqslP8bFn8vUax00A4scljy3+XpJQXZDFoEHPyrVzj4DLmUWFjhlfTA1VWNHAkS5+FkWJ3mnqM9rskN5ILqfKl6M0oTj0FcQtOcB5M+8REigWzKFwdOgKl69B78TxvWVE4jqmjHryHPF9Ocq9F7xq7827T+Pu9yGUL0tlLcqlQV0FoljZW9LKOF+CzWFQBQgyEq54dxI2JyTtzmSQl2pkvEf2Vvk3rMmyXFppb95LzwJSeYNEBMEX48cxsN7xVDey65BwVHMVnRJ9ql3gsL5StvofbiHTDNeXptb3AG9+y3aFLaqGDaLbovk9VDcBRIFgE2nIIzW5qwZ4W5rAKTtiR+FOkXsSfoFtgnRf5R+k1MGAaKj7h6t4II6weQI0Vjoa06mAlpdjV7qHDE5aelssctlhGkuGdtIMQ/6EsZ0pxAURFXFqML41oZuxzRkKFj8bj3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9atQPsydqhuU9N8v+bI76RkPj9wCLhyR/qXTj3WTLWJu4eAbnOeR/3bAw7O8?=
 =?us-ascii?Q?NkVw7ZDduOVaFU8kX8v1eVs1EQo8v9xfJw5kFcg1wDsLJzzXnDnJLqj9wJTx?=
 =?us-ascii?Q?ohHJdRo70zeF9wIOBxOsSumSvzQkVCw3sWgoWe8Fl7S9uu/iST0zjl9GqOTw?=
 =?us-ascii?Q?MS7dKclSOiU/nnxMb4beaBKm/hZgX3VU5aH1MUfqaMPzJWC4/fC2P3pKlIFK?=
 =?us-ascii?Q?b83Ua0EMvggLYVLI97YcWo7tqVjMyEHHLSUgTKOPgF+gDpWPl1TEGIsOOTvH?=
 =?us-ascii?Q?dNvHn19/mslL2zwTZCtdVocdF9uEplwW1N9is21KexDwQ5jO6/icYxKv3CKR?=
 =?us-ascii?Q?klDvtADYVnDEqaSHLBdVz9MRcA4N0sfZzqdhqmzGYdFI3wy51mJsSv542MyX?=
 =?us-ascii?Q?0zlHADhFkVH7MAu/mv/4NcaVBga0U1CY4w8vMe38PVEA7b7Q5f7CCS/HGBmD?=
 =?us-ascii?Q?osGipdEbPZ6W8G/jB+UiOyd89vl0r9Y4L1+l2jmjFW/dMShqGjuElA+bdcVR?=
 =?us-ascii?Q?QSdz0X81yw5gOE4x7b3L/Li+Xlxuo1YTG1UzCd2GgShhhYRDfjtZWu2UO8/2?=
 =?us-ascii?Q?/Cx/1choSpK7PvrrvSxO/8yKMNYJtAervH/mqYWbQBbACGX0fZOUtmRFwXTM?=
 =?us-ascii?Q?vB7pRT2ZS0Qk3wWWFbK/zJsFtATUxjfPVY79UYyWhlBRe2+e6NoRjRYhXrs2?=
 =?us-ascii?Q?oOCZGlfS5utVhGF/0AwMQm5w43C/1dc/NWCjuI0NLKbcFH7hifjUM/KPSyL8?=
 =?us-ascii?Q?ZGqbNj7ZWyBV/NZJRgJObM7TkM9yzdQLB6wQ4szdIT0zq7AyFuTHKkhoN5pb?=
 =?us-ascii?Q?jkbskACYnkDDh8noh+RLW/j/K0fkWDEjXWQa+KMDrjdat7krIDkk2BhrKc59?=
 =?us-ascii?Q?QMF1kZ4KsqawqDP96WZei5MoGmbY+XOUM7grQ0zBONDOuyZxXC0FhyKaGHcX?=
 =?us-ascii?Q?UMBjPIxaVpBw9nP1mrjOaX4y6BHgorF+AmyMrhwmykbacg5jq7WkDa4RhWqB?=
 =?us-ascii?Q?kFKTQJs4JxAOIhejVSaBBOzc59160b20ZMMHOqpBTOHv6RZ98pif6aO4uaRW?=
 =?us-ascii?Q?JUQhcJH98qybvCobqjAyk+DFXzulMYPOod57Ap91/ekemdY4/D5F9mMfbxGf?=
 =?us-ascii?Q?GOIOdLM+NDdihsE9iNn7yvNvHAGtVfbrxuSIOpiWwnDDiMchdNta8uC8NqnL?=
 =?us-ascii?Q?A7TqnT2dFgt+M34nWNyn/TonQmJJi0zssCn3yIDXIyznZpXBt7lClvfye4MM?=
 =?us-ascii?Q?AnMP5lcTr5E/VYWYYEU7Gu3UwJ3jYbYWVUmy0PTqEfqRkE2bRYNQ63Z5LEiV?=
 =?us-ascii?Q?8pnD39juTpOShI03Vqz6VaIIMRP3mUvr40vgN8e0XZPtybW28IZDQeVyBoKS?=
 =?us-ascii?Q?tqfY9A9LeXHmEsGQ4qpmWRzBrMRVfKwmrbhG9cdbgB63ShhLH6jClF/34ryW?=
 =?us-ascii?Q?PBkCaOODskQ1yOCCDXWlZsIKktD+a7AVMdknjyc+tTAcxdJYv75dH7yjgk5J?=
 =?us-ascii?Q?C9Tfl+0zuOzEDLGYMIw7q8Xx8R1xAuQewlNIxYuRDLwUmeZyblZCPmBaPdzH?=
 =?us-ascii?Q?whxd9zGDrdSvKgqo9nmG9sUNVWj1Qa0wUSkPBVXFWw2qvdjGU5HarUekwkdO?=
 =?us-ascii?Q?YTI9vmBpoktzTxEaZn+yafvgB6cSq4R9Ynq5F2rsGNNYJS8nYX7r14c9943M?=
 =?us-ascii?Q?zy955eXV76w/Y10vQiMv9YHgXHY0etPEQBMFCK06VP/4tbGs6dkc+VAltT/J?=
 =?us-ascii?Q?hRp/lRSmVzeSsFCtomY8iqHCm1oZpbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AnsENh817gajb5i9mOTqh2rL8GlNKfSMiqzQmywud0LTvQzCaKtP0QU6BhsRGbXmKN8nHRO5UtRZOO/tJ92fN7k7OlZSjUQ9yEHicQn8DhovE9Do20cTynmWY4faqLU9+QgSiew2bMs3Am5t6Ijb72pwVO+XZQZfCHX33NwEtWuswzVjPoww+YmzdTi7bW5cpmBg7GvC03cbI0+1VScKmyS0WL5mJIoAa5LYf/OR9+4JzFOxy45+ZuFFfOU1tc4aRC7tyiMaGtao6TxzS35kYD/9BlNAlf0spKiNQaDe4GlaRYyMoNtSLy0GrSkkcf8XL/VzXX19hPf9yC21yZD4Qg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb6ad6d-5730-4063-0692-08df283fc14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 09:04:00.0661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBRwENdwCNl/g5PuAp2xVJ3W9PTqK3gnPEskBO13TG1wv8xOTC+v20vcgv0W2etCJn0G9InFo50J3iHcM+xrjZ2XqBM0T6x+yXiHEVHrbL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
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
> Sent: Thursday, October 8, 2026 2:58 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
> start fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_init_vf_vsi_res() reserves vf->num_msix vectors out of
> pf->virt_irq_tracker with ice_virt_get_irqs() as its very first step,
> but neither of the two error paths below it gives them back. A NULL from
> ice_vf_vsi_setup() returns -ENOMEM straight away, and the release_vsi
> label only releases the VSI.
>=20
> ice_start_vfs() leaks the same vectors. Its teardown loop undoes the
> queue mappings and the VF VSI of the VFs it already started, and the
> eswitch attach failure path releases the VSI of the VF it is working on,
> but neither calls ice_virt_free_irqs(). The caller then runs
> ice_free_vf_entries(), which drops the last reference on every VF, so
> nothing further down the error path can release the reservation either.
>=20
> The tracker bitmap is only freed in ice_deinit_virt_irq_tracker(), so
> the leaked vectors stay reserved for the whole lifetime of the driver
> instance. Every failed "echo N > sriov_numvfs" permanently shrinks the
> pool that ice_set_per_vf_res() divides up, and after enough retries
> ice_virt_get_irqs() fails with -ENOENT for good even though the hardware
> vectors are idle. ice_dis_vf_mappings() meanwhile re-points
> GLINT_VECT2FUNC of exactly those vectors back at the PF while the bitmap
> still books them to the VF.
>=20
> Release the vectors on all three paths, the way ice_free_vfs() does for
> a VF that is torn down normally.
>=20
> Found by code inspection of the VF setup and teardown error paths. It
> was not triggered and no stack trace or error message was observed.
> Compile-tested only, not run on hardware.
>=20
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v3:
> - Correct the Fixes: tag. The leak starts at 4d38cb44bd32, which
> replaced the
>   computed first vector index with a reservation from the bitmap and
> left the
>   error paths below it unchanged; a203163274a4 only renamed that helper
> and
>   moved the tracker, so it is not the commit that introduced the leak.
> - Include how the issue was found, that it has not been triggered, and
> that the
>   change is compile tested only, as netdev-bot asked for.
> - Free the IRQs before the VSI is released on the eswitch attach failure
>   path, as Tomasz asked for, and keep the teardown loop in that same
> order.
>   The teardown loop hunk now sits inside vf->cfg_lock instead of next to
>   the detach, so the Reviewed-by tags from Tomasz Lichwala and Aleksandr
>   Loktionov are not carried over.
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 470aec8849b6..444d05a9bcb0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -458,8 +458,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  		return -ENOMEM;
>=20
>  	vsi =3D ice_vf_vsi_setup(vf);
> -	if (!vsi)
> -		return -ENOMEM;
> +	if (!vsi) {
> +		err =3D -ENOMEM;
> +		goto free_irqs;
> +	}
>=20
>  	err =3D ice_vf_init_host_cfg(vf, vsi);
>  	if (err)
> @@ -469,6 +471,8 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>=20
>  release_vsi:
>  	ice_vf_vsi_release(vf);
> +free_irqs:
> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
>  	return err;
>  }
>=20
> @@ -501,6 +505,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>  			if (retval) {
>  				dev_err(ice_pf_to_dev(pf), "Failed to attach
> VF %d to eswitch, error %d",
>  					vf->vf_id, retval);
> +				ice_virt_free_irqs(pf, vf->first_vector_idx,
> +						   vf->num_msix);
>  				ice_vf_vsi_release(vf);
>  				goto teardown;
>  			}
> @@ -537,6 +543,7 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		ice_eswitch_detach_vf(pf, vf);
>=20
>  		mutex_lock(&vf->cfg_lock);
> +		ice_virt_free_irqs(pf, vf->first_vector_idx, vf-
> >num_msix);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
>  		mutex_unlock(&vf->cfg_lock);
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
