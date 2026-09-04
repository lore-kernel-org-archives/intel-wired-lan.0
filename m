Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75963C624DE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 07:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D67940B36;
	Fri,  4 Sep 2026 07:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOjZEO6OO-yf; Fri,  4 Sep 2026 07:00:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA71540B31
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788505243;
	b=K+2OqWeZN4Wq82rcgSjIERLqLqLzFtA1T3UorixJuvsmNke9ObpbykrqmV51lEGze232
	 DIKyObqHE1E6P3zCb5V3f2e5aMXLO7CJ1pWSs3fDCfAgWcrbqKP/EPcPnRZJMql+GzcRb
	 q0F/uKentn9UuA7AblK6K1avVdZmAmeW/u3zYfPsTpQRvolNaZ/7g8nFaNo26goKdMwi2
	 dWWXHJ4vWBEkRMUVuvbRdNLW4qADNvUIo2+jfxIEaAP3oEIV7qsJ25J8hpZs1NyNidtmv
	 3cB4BxOqLuX2g4cBn2GPYJy2LRoynjQSTMu9c/7+UCW6CycDfQvb5ekpJV8iLy8ihjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505243;
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
	bh=+9sIaUmRSTwWq7p308OQBnGwGLb5iXjZLh/a+uBLtR8=;
	b=WeUEuo2PorAGOlxF0+HheDbwE/JrvA4/b/yFG0qMArtYbNlMpKeEf3f1l5Zi4ibXomyL
	 TuirlgCNKd+DPxZtbUtfQmyI0mnbEe6mEZnMcHST42cAzyALJZfl4g3+UhoA5TuuQBu+n
	 WQU8qXQTwFkdzGrCJ5Qzd7H7LOZt8BMuHJPNPqycu6Sf4fsk15hREGrU47DQwe0O301sA
	 qSCBTxxHxYuhGbjKWExHgFyTulsZw6C66hyDZW9HQnYf6zMzyDdMtqij5yMftgSkz+C+o
	 2mMJaiD4LEoDtV/3zanVMLIACn56FJFfGYFf4uWe+U8GVAChYxVXvIsvnRtFa5sat9w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788505243;
	bh=+9sIaUmRSTwWq7p308OQBnGwGLb5iXjZLh/a+uBLtR8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BasEfX9dNIXQeFvoIXZyRyX/ap7Qg5m7/1EjZZXu7n4k36oOXPdZdEF91l+k9gvh+
	 eFPXXVJSG+CSGURrQNRkHB+DmNHCiASxRDSIdQzi3Po94tad6/YVHqXL4IlaTygvys
	 c2gupKlq2obsMBrgQvG+eGdxzsHk0qKZfhZz5jlgZ/6ZU2mzFFKNrDZeIjE0OwzxKM
	 KBO753eXgs9atXa4Ru4XU0JlVaC6/N53iHxid181EPyem5JLRr/8iSMTJ+HuX/TKV5
	 6LW9/q/GC71ONlCm18NAL7tqCt0j7Z0uSQwnSZ7Nn+M2gnrC0LQ+xPdpp79U9njlRP
	 NDCIQGtpZFKHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA71540B31;
	Fri,  4 Sep 2026 07:00:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 536B0B2C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 399C540080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxJIzR1S2rSo for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 07:00:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 54F6A4008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505240;
 b=OkhTX5Q3G6g5GXob4yC2F1APCDPIqPwuGcvSmDC/Zz4CaBTO008/l4C5EXLlCyiHd0DR
 xsyFn5r3JOTfc9osxFhQOGyw5SV0CeibGKp/N/uwS1pijfjaZ0gQUB0Q5h3OkkpaS2xZY
 SDf6ExMDRy5WbTHI76j8Gp21YPO48EbqGq8POvODKB1CJ+/IOYFpVY4f86miOVotJD5GG
 iI6Dz5mm/obsbH5dpGLrOdTk5FyCwj5ysZBbvVRgoneOfhoDIGXnT64fwEWRRFA387Eo0
 7cNY1Rng8Ulk4+w0RC3hs4+Kt8tCQLOKgaeue7CoZUXMJ7lRB6ON5vRmJ4xUtNoHiPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505240;
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
 bh=+9sIaUmRSTwWq7p308OQBnGwGLb5iXjZLh/a+uBLtR8=;
 b=FZbXCorVA/co4yFU0ufxd/JWYNbq1wza4l36USbvVzEHHlJZ02Dxpyh7MFJXYR3ZFlIA
 yMYRu/3twVd2e362n63BUDaXmixEJyurThT8E06Ph0cvAGAARsZEs/0FaATVo4576RTYV
 WQCHZmTM319FLh05XsDRD4yVNwuz7HVgPmZMdA7d7c1jxHmVFYxFIPfEeCeTrsgWe+U7e
 0UDFhFUACBftelEOTbmLZjXsvDG273412vJ+uBsP+LHYHEHKqAayizaMeOZ3VwPk0CcRy
 oMJn7vRwRWZc6B7qJQCW+CNtfk/cTh5qm0zcoaL3d89pirxtqCeeI58kPsJbeVjH4lw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EMZb3c4G; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EMZb3c4G
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54F6A4008A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788505241; x=1820041241;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2UY2Mqo5TVRUdw6Jk2IRhyKsPz94xO356tGDqEP0d+s=;
 b=EMZb3c4GfdJc8rvI3+EBTimweB3QxFt8ZhkmBIdgeogxvz5JRYN9572/
 eOBz4kjujRXChVeByssLKAI80x/4LXC6areUdr3GkJAAzdAaBy4SBm3b7
 TSDALFNBteNPk+MzIU/QdVD2CGVBCUVB5Ct9K+gO6vR+29LHJpat1aIPR
 yb5ZjXS2URI21WuK5m90b9tLb1r+BFMxXWrbJyBVmF6t/6qqaxrIEJ2At
 eX/ShcWJMBKpCADHVhJ0z76heG/j67YvLqFNzmsbvbjUoBs8pLgnWfQf7
 hKf8PcFTUQ9TpOYKU8XbJVs5qO8Kf27SDUTZhnR7Emj2zJXKJUval5ItD A==;
X-CSE-ConnectionGUID: 5wSG0YD2RFCbC4kXyW34YQ==
X-CSE-MsgGUID: Go8vCa1YSRSyExX16kTzrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76556306"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76556306"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:40 -0700
X-CSE-ConnectionGUID: lGTx1ABmRcSjGX4ziCWmqQ==
X-CSE-MsgGUID: MzxP9YMJTCC8N8LA6DGQZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="265614334"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 00:00:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:39 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnTCdTINowvnwGfNUy8jE0VbbrXCJdAHv353Ti1XX9ddLfbO5/hyiixski1n1KCfC9eBqJwLd0vzYMx6NLP7zi+CTytqlJtPz4t6WrgfSAVKhrl/0P2oMaft80LZxCJYWL2x5ri9rF6G2Xq29oZlPej50a6wsow+NFKL78GvdVIBnXxozy31U03HjFfQ57GSRUriNTfq49b/H3KVMvX/bvEKSxuso2VnaGG3+6aplIZxjheELbSx61tg07JISzWPS/TCyTDFqni0qoaYcnQZFyELp7pf0iL8StWgJe4axRE3h/agHMXkmiP15d1QnjDHhA6c1U/j3f7p6vWznl80/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9sIaUmRSTwWq7p308OQBnGwGLb5iXjZLh/a+uBLtR8=;
 b=PzzMwAp8WPjtM472mtXUY1eyaxkyd7M3FQtnjSLEzpNPlOsNIqT0cCSqYaPpwa5U0PFI5uWHBvPsJQzwTVCfh3TeX8sPwx8MRuo2GNvkAiejmxsFFPcjCQ/2FIb3FBf6E7UF9/xJuPmQzgDxzQRMZjTm08/hlbEpBh5K/On6XSm7bqZQ7tdaTSHhYAlVHJnsHnxBuAEAoxlN+j6ydtDQL1hkYrNUyMFUNhEyWfqQbb7a6e59v+XFifWbUOgtE0u2wPu9WpqY6fQDlA1bCl4mC8E7M6xmkiJHW84R4E16j7itcVXCM6bICjfzvGg8YoV9LMRAsJeFnetTFqNaRfnZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:33 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:33 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
 <sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Cao, Chinh T" <chinh.t.cao@intel.com>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 05/12] ice: create flow
 profile
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 05/12] ice: create flow
 profile
Thread-Index: AQHdChZM9TQQZhTEfUqhaCUDN4tdt7a+OjFQ
Date: Fri, 4 Sep 2026 07:00:33 +0000
Message-ID: <IA1PR11MB62416D9144A31DB2E13576888BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-6-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-6-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 270eff53-c9c7-49e5-df3a-08df0a5236c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: yjvx9d8wvszRimU+cgVauOszRcE8q5MIlOpg8vk+DcsNQG1T0KVmf/Zs+lpExkDQifvQjf8v97gRf5fbRdAi6IQwNW7/PJJSHFeZM0FBBHRAqh99CXPyonQ/y3NHl29gNwbgvJ6VfkvVnqHd4cYLAkyiZixE5COgtUJIIX/SxXk2q0bWFh+hAdLT5Scuc7Y2YV0PwNVG7+SR2Q2De5jfpklZvAcOM6BsaTSDU17QWA2PUYaIF6vdB4qIZZzQ+g4Nozcic0a/1qxYkG2Qrlk8WB5BIFerKEFwZiYCCTKac8wyVaqKAFH91Luk8lx9ZFfxxI3ONIs0iUyhxGpj+axtQoeSIugEF4p/ZQ3w2X9LdP8hRMdS4Lq+x+I0rX5rp1G4S3BfFuYeRXhJeRCqelcHUMu4uM7p2GCWaygiQkCPbsg132APnvedJjUqm97UsrisBNY8vLzRSnFHeIuRRROeBYgCCbHN/PL1+l9ksrtl4I1HUuod+r4Ee8M1DCNcXbgUf/XHDVEKEoTFfrMlZFtyiPkUDyVpbht2PWqaLvXWJyBx9bchcLyacW3f/01wU8cZVQdypO1SItmyAXIeAcrM65qC8hW6nOvS/UcliC49QHAPlSdfMlu8mC4Rs7kxAJXxY42ASda7DyYbHTuAeCkmGI74Px8GtXWnXjC12iLkdduAJKzKJYoE0LqAhxuqbJ5TwWOpWe1rfpWHG/e0OxwaorzgU8KfGUzmqrGYMBkspjY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0FzfNye55PbjfUjsrqO604Ys3Od/7yS0m1hHKgDiWU3lKf1cbE6QAp9lUOGL?=
 =?us-ascii?Q?j7DI6qcheUxgbUNRA5vXJIqPXfO0g9so1H3xaoF+n+1izUrNoByBobeAZldU?=
 =?us-ascii?Q?C3gNk9yW17sLXmLgc0l9PabyDqrUy16A1BKhpvrHAlkLO/xv4pSN+Ema6N7T?=
 =?us-ascii?Q?M2Kcm6HUl95qktAKMuk6X55NTTbyVRURMZAc5fvA7rQOBAvZkzuQl+6pD+HS?=
 =?us-ascii?Q?EKZgUc6rQxK5q2NYWtcGZDwrW2s2EW5jDt99+doG3BtCyDB/1MHMYNbvEGpq?=
 =?us-ascii?Q?Gb+E5O5MEY6JFQYM5IUEqDLYkWcgJO5df485R3eJhkaDNyM7o3y+0O1SxD56?=
 =?us-ascii?Q?men/3UD4akuH7ZZq5sj9kh6tglL0/coMQi6MSSC1Bd+TUEU52xV71SSc27oN?=
 =?us-ascii?Q?T+VgnSeIMOQmN7cRAQaVh5esqdrml5ZKNkEx0lO7zgJBxsAqs+L9ou/dxfwC?=
 =?us-ascii?Q?z/uQpYDw+/BPquGjNf0YmTA2UL5ls/GKbAtZ8mvMKVEtXH4/mKCx+qeiWjbe?=
 =?us-ascii?Q?rshdb247ZOZNO0w2mX+7+7d/j7/xR26fVoqszz6QVINSLLNZaj5Lpuy8MCVf?=
 =?us-ascii?Q?Cquc75v7DYCo+SZr31g1VaNy1a+9/TpKPtTxxaIi2t8VwGtaxYLU6D+w3Ank?=
 =?us-ascii?Q?YDoPHMrnKd1YybEyPcTW366KbXjWcyhpzsqW27auYgXjau6JSLNzONDCxrhj?=
 =?us-ascii?Q?bvwVNSsgAw5dnCqVheM9xMIDHA2mvl+zaQNLloGZ48nG/JlmCksRh1hpJQI0?=
 =?us-ascii?Q?NMvaW7zo6DqaGUBwAObgzHom3umgwcJvUqFuksUD0h8jCirn7W2sws3wYGbD?=
 =?us-ascii?Q?5eigZtXwd2IPzXhqiXUvmEiVFEB8ad5gI2rX18dXqEYC/lnEPp3/tBJFEOq2?=
 =?us-ascii?Q?VK3rAtUpna/eI/RvM+I/MF86oCPe4CEHw90nxmDI0xN4e9DpK0KddK8nHLwr?=
 =?us-ascii?Q?TrXKXiSI1XonyCGHOEzGzV2R71n+nHHQSSo53qxsoLeenYKa48SuGyvBs+Wj?=
 =?us-ascii?Q?ULEpUkL2bb5PkgHyqKVkuanW+3d0gkQI+FZCVE5BTm8PSowI1Xuxs1e4oU/y?=
 =?us-ascii?Q?TbGEtLhl1Og6wCKdy/DJQG1rakkVZODzmWIqdrU5QSP0i+kMwbA9OylTkkos?=
 =?us-ascii?Q?UzICA2OhFxwC17BbcKhXxTgVHLMgA72Lec3bbs6/M/mOzi4UZfllZrXIQopb?=
 =?us-ascii?Q?hJG3zhzc+Zqifk1jpwOerRnpTACbEZqktnMXwKKVLa21/uE2l6KvnaAMaMgq?=
 =?us-ascii?Q?RG+zWE3aWIUx0V8svjPDhZvf9cZGZceAVpOta43Ag4qpPHk63bDdIjBtlwMZ?=
 =?us-ascii?Q?I6BXbblhe+zrpFq3jvtdgghSZQxZatvaAqdVbV15ORBHE0oW/E/l7mh862BB?=
 =?us-ascii?Q?+CIuXcg6rhm8R+jguIrF/YtGA/QJLffDmnRf3Y/KjxB/0v6avKchFaMSukDZ?=
 =?us-ascii?Q?BNJfHBORO58iMv1FBtVWEo5cUOiWPkw835QavoyKcryeLwWfKlJxVz4MrAhr?=
 =?us-ascii?Q?BQXISV9IZP+1twev9zdqPn41wetrQPmphVbIOFVmuwtcuTD9sSqMCbGG3OPC?=
 =?us-ascii?Q?pHicOniNo6+ck3mJWVK1r0KLyd2Vp8Y5Bj802glp+e0BPgvVWULQFR7L49u8?=
 =?us-ascii?Q?IjwmRBU76fXpri/9rQbWvTDl89C14vmivdf5r1ORO/g8E1MgicVs9ngXo9GH?=
 =?us-ascii?Q?lTI8B6ee1UmITQJr4yFiJQbB47RPFJk0h+MIffq4wiXU87it?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jvDCtxs6sUHSvC21b/L9b/xwkvEJDyZR8XXEuulMSk01RjKtAJtHbw+6JeBppUfCKj0hzTQFkSW2K0H9g2H2Theaa0WBycOLJhYMDCI3FOl+6PnFEvh9+Shmg8PPZPvbDwdSpXVVS36HR+nwGodPuccEaEUhZU/lMauf97hmMr5HOAmP9v+NivymZUbS1Op+3v4EALXWnMUbLfmtsXrsCjfyoiEeYvN+sRF3MXftgmvoJRaGXaxw7ZQ8k3TiRmzAF5f0TMBHRBVAmQavYi4wtYZ3dYsEqwZBvJSrtoHGqUGpjRjEY1ZPLwjHF6yinZZm7w80kQvCc9ZUYmP6JR+qCw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270eff53-c9c7-49e5-df3a-08df0a5236c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:33.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYYLSYnO+vQN2/TRxiIbWkGv8MntnQsqaoq2Dyx1CDQXPIvO3EPgQ8a1KD1wXeC+hidezwRU2Ns3/6PmvHuFEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Cao, Chinh T <chinh.t.cao@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 05/12] ice: create flow pro=
file
>
> From: Real Valiquette <real.valiquette@intel.com>
>
> Implement the initial steps for creating an ACL filter to support ntuple =
masks. Create a flow profile based on a given mask rule and program it to t=
he hardware. Though the profile is written to hardware, no actions are asso=
ciated with the profile yet.
>
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v5:
> * ice_{add,del}_ntuple_ethtool(): remove dependency on ICE_FLAG_FD_ENA.
>   ACL should not be blocked by fdir being disabled
> * ice_acl_prof_add_ethtool(): don't free and NULL hw_prof on existing
>   seg mismatch. This prevents deallocating an existing hw_prof, also
>   leaking its seg
> v4:
> * ice_acl_prof_add_ethtool(): add missing line
>   (hw_prof->prof_id =3D prof->id;). Without it, all flow entries are adde=
d
>   to profile 0, which wrongly uses old extraction sequence in case flow
>   type is different. To reproduce, add two filters with different input
>   sets and check if they forward to expected queues, e.g.:
>     ethtool -N $PF1 flow-type tcp4 src-port 1234 m 0x000f action 23
>     ethtool -N $PF1 flow-type udp4 src-port 1234 m 0x000f action 24
> * Adjust to using struct ice_acl_hw_prof instead of struct
>   ice_fd_hw_prof
> * ice_acl_prof_add_ethtool(): remove old_seg helper variable - after
>   above change, accessing old segment is straightforward, so it's not
>   needed
> v3:
> * ice_acl_prof_add_ethtool(): add a writeback to hw profile in error
>   path to prevent leaving a pointer to deallocated object
> * ice_deinit_acl(): exit early if hw->acl_prof is already NULL
> * ice_flow_acl_def_entry_frmt(): copy seg->match to variable instead of
>   reading it as unsigned long pointer in order to avoid potential type
>   mismatch
> v2:
> * Add ice_acl_main.h in order to not awkwardly add prototypes to ice.h.
>   This will also help avoid potential dependency issues for future
>   additions to ice_acl_main.c
> * Rename ice_acl_check_input_set() to a more fiting
>   ice_acl_prof_add_ethtool() as it adds a profile
> * Set hw->acl_prof =3D 0 in ice_acl_prof_add_ethtool() to avoid use after
>   free
> * Add ipv4 and port full mask defines in ice_ethtool_ntuple.c
> * Move hw->acl_prof allocation to ice_init_acl(). Previously, it was
>   being deallocated when hw->acl_prof[fltr_type] allocation failed,
>   possibly with already existing other elements. Extend array lifetime
>   to driver's lifetime
> * Change hw->acl_prof[fltr_type] alloc from devm_ to plain
> * Add hw->acl_prof[fltr_type] and hw->acl_prof deallocation in
>   ice_deinit_acl() - previously were only deallocated on failure
> * Tweak alloc/unroll logic in ice_acl_prof_add_ethtool()
> ---
> drivers/net/ethernet/intel/ice/Makefile       |   1 +
> drivers/net/ethernet/intel/ice/ice.h          |   6 +
> drivers/net/ethernet/intel/ice/ice_acl_main.h |   9 +
> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  39 +++
> drivers/net/ethernet/intel/ice/ice_flow.h     |  17 +
> drivers/net/ethernet/intel/ice/ice_acl_main.c | 227 +++++++++++++
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 307 +++++++++++++-----
> .../net/ethernet/intel/ice/ice_flex_pipe.c    |   6 +
> drivers/net/ethernet/intel/ice/ice_flow.c     | 173 ++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c     |  42 ++-
> 10 files changed, 745 insertions(+), 82 deletions(-)  create mode 100644 =
drivers/net/ethernet/intel/ice/ice_acl_main.h
> create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

