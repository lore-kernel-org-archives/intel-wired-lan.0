Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28641C98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 21:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD4B06082B;
	Tue, 22 Sep 2026 21:39:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyvz0GzTGs4F; Tue, 22 Sep 2026 21:39:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C65CA6081C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790113140;
	b=R2Pb0AvT5LKnR1wWMqy2UvakuC3ebZJdL+b0fBwIDM6a9KJgv71BdSsezvNusqbgtzMA
	 ni9DVoBYMEBz9gbbUCby6oOe6QVGpu2clCLb84xC7jH7TfxHdincgeF29qe3DxMEpyYC0
	 sAiY9v1A2TiCIcsQLheYMpu7KB06bUQv+Hij5OeQ6w0kuQPCXQmRKeUFwJFtJv65LMR4e
	 Gsh4f/1ec+JxTCKM//+nNqswAxx+v1OQbjJOXrwUwQq0MqEvVWg6NOtHY6xiATvGuO21O
	 SKxMonN+y2RIN3cK2rCmcnBUtd3cIpzvG8IrC8Bf2HUMvQFhVqbnyUr7UDZVZt5lzmA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790113140;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qCEaA/fysfW2OoRoG6WSM+BaEZqG1vGfsGk8/kfs5qM=;
	b=jgJq538XG5H7ZgoNOfutgqO+nrMM6iVIfTPnf8jx7UAP1MGGJbMilQkoCGFBDLgdjEbX
	 fEcT9jBrO3UYAPTsAodXgRfHjDpTrlvHAohJRL4ZlJlLH0MrXHseF4bUEtmH8HKLBOiKf
	 ow7dhXkh6JulDVyxNcIurkiRrfB4mRqfb55vsINr3i5tUx3cDIfP7BseHhkmOLONKnIjT
	 EPo31R+9AotKZXzpfogFm++ECjeP1iuBbi5+a2UgdVXHzpjGvkricexDUsda/C1aQ5DMQ
	 CV5YqxAvsmkH4tNW1hqTWAbTgPBa2I0tNBdxgSTaev6NAqU7ncOgX5yC24UGqz2SfOQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790113140;
	bh=qCEaA/fysfW2OoRoG6WSM+BaEZqG1vGfsGk8/kfs5qM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cN5w9m47JSpPk5gFuP5kok2jQvlisaJ3Q2EnOYomq5kW53UwMbVaQ5llIxFU92/i8
	 vzcB7zHdkhJm5FeWig8aAX5pP+ugBkdMjFG1ZuV6ku8BYaPQ34uHC3xA/xiVdUBafR
	 VHJQ1AlL2FHcUqCOCqLw2fHBk2AWYV+I5H85ND6z0xkmguEwsoiDnDUiVjd2xkGXlk
	 mmBY4rHKzo6wb2CzCQ5szqXkDjR6c14ML6Vn+Iz+GEj3m5LD+Po9fBFSyM2wOE87Wy
	 c0XUPZfPAMBKX/Vk8ZNt2N3+jYqwxvX17igLGd2a8/jreY1vDhTjIDupt4Bzo42D/v
	 k1iv07rh2yIrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C65CA6081C;
	Tue, 22 Sep 2026 21:39:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E99F3A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 21:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 405FD40304
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 21:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NebpKr7KfGoS for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 21:38:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EE999402F5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790113138;
 b=Aunu5dE7iGqW432XIXhm8kblyijqhbarT7F1LfXclqjaImqT6ChcVw18+dCO+289Q4zq
 EMNFnsoEQYnREz1OzaSO4gXmMSEM92n0dIO4wEls2YlChd5znb03KDixrMFCLyxd/HFoI
 xg02kDtacTQ+iFwFN1tm2JDcb3E9tiSpA/GKCEkcf1YDAtg9jvdaODMKK2JDZf35jfIJ8
 7gu1DwIIHEosSsUnx/TyqxUXQURqiAG+DJsQPm+PsqEKLJIw4FTWAXRJbx8zLs6RQHaB6
 KWBXHp7TauDhaI40+vHMVCWxssviagjRv4kyd5dv1ntQ+DxD3VAZVuW0AumHtzvhMvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790113138;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=qCEaA/fysfW2OoRoG6WSM+BaEZqG1vGfsGk8/kfs5qM=;
 b=sx1ZwEbRwyNZHDqLjZxRax/Ri7vDfQ03hhaWsu1jFMwO5cZu49daHuGCRAkCti8p5iM2
 bp2G/EbZYazQu5iMv1EUuCo5J1nZo57f5BkvkCDV9pSOojo3GrNZ9GfkeIMGUREOlPeft
 TYlytAQl5MzfEdtVbmh2sB3tapgX+pO8NQXer/cj07ODCvfwAqvbd8/YvQCmV6ZedWtep
 F8UaEEjZH1VSxOosWG/JRUQB+DWyyqbx4uH/N2tFpKFsESfa6fFA34jxAzfTqxibb+a6S
 IPnxHl2yklNf1ngPOtxIGxJ3vOyB+B3SNQ0C6c0QBkYvUyh9vACbqS9uKa40xIZLICQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K59+LILi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K59+LILi
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE999402F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790113138; x=1821649138;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+iS052aHhrAYp89I7CiyghuKskeNgPiHiYgI3fAX1Xg=;
 b=K59+LILiPvptQu9r2iw3i/pe7XvMMmzXvkoOk3GRDqJXXWobalZdUD8a
 3I1x3XhMI+m1JmtXnX4WLsTLhVVx4k9907eo9cfTz+nr5yAbzb0GWYAiq
 zl7oY0voQ9V2PJoCkWEjA+B6n+Xzx/jvavgNJdY0Wqekz+RArcvvHnDZt
 p3zCcv6bDzNrt+zud7/iuVUwGJ714vA6xH4JmmJUd4RjSd6vbr4X+s00y
 mh3iV4uZDel5t3vXQ4BwN7orZkB0qoUqcONxgHVXNqQk9/DxzIPQx1opD
 uyzLaCJ7hQ+Rg8r+fnn0EKo9tFg0MuwQ0sKhk5mx2Rkmvk7lkdgrOwJAr w==;
X-CSE-ConnectionGUID: JCGGn/ERTemFY1c7SCF1+Q==
X-CSE-MsgGUID: YYVSeH8xSJe6GlAlGRW4jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89891370"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="89891370"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 14:38:57 -0700
X-CSE-ConnectionGUID: wIvI952TQdKhrmlO6gvGSg==
X-CSE-MsgGUID: p6vHmn6aTpauUMKFNamZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="269818620"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 14:38:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:38:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 14:38:55 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:38:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUqmLC+oLW0csxnkDQffMKsgSCaMT0IuS1eBSVGiJEh5fH1wj4JxRUiFlFB9zz3FzliphDjguGPI09w1GFmq4DK1+G54AAoP2CdKX5Z6cw5+VEkQzID8tSgaiKU0UzrfVxiKm/PV8pNedvGQFfpEmlC1Fevf7ekKlLvOEghjVSQwoYblu1lhS+UuImOjIM5ilYOj67jMuVD0W1mOS0Q6cNXxV8oHxI0i4E/oBDX+Tj3wYPYsZhFq8B/ZSAp0to7sScIrV5Du/dLhb2omvY9/LaEN1EmLSfF0yv4xYuBwY3RuCRbuUs6MkVMG3cNm9pBYp/eSEu8vulQQMiPyWAG9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCEaA/fysfW2OoRoG6WSM+BaEZqG1vGfsGk8/kfs5qM=;
 b=vCDvQFPCEs755AJAwC9pAlY2OLBgKr8Fz7BaifzRN3kAkZrpm8ac0frpP7mVR2W4q0S3XLFz0YRK2sBOcVgO7lArApdI0DLs7er7B/I08ZlR4KX/Mrzd961vrCop/WZU+b0Sel0dhUpxob0gze929/4NBEc+EknI2JQDB8J8R2zYJr9tU/uu4sMxxGVJ/VDdrEn1ppNg1av5fGnkrE0OzqRSnYKVSockq6jLj2uK1Di5x3Gjs8+84qVs3AWndr8gILdsHtfnZodDc1TPuu5BuGO8DolsoXYMZKsmu7bK1/+nhS227J1ybTI6+OTDMJ+GsNxLEE86Lp1AeWBddoUVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 21:38:47 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:38:47 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next] ice: describe generic DPLL pins from firmware
 pin classification
Thread-Topic: [PATCH iwl-next] ice: describe generic DPLL pins from firmware
 pin classification
Thread-Index: AQHdRtdY6o3zB8IqeEalqcTB9YUQ2rbbJ4hg
Date: Tue, 22 Sep 2026 21:38:47 +0000
Message-ID: <MW4PR11MB698415929AEA7000B3654AD99B832@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20260917190339.3239476-1-poros@redhat.com>
In-Reply-To: <20260917190339.3239476-1-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: ec021e71-8920-440c-b010-08df18f1e268
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|1800799024|376014|38070700021|6133799003|10067099003|5023799004|11063799006|3023799007|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: LmKHXjq7MWhUe1qqmno/coT4u0agJOkz/m1kz+69Kk6ZkL7C/3y7fuN/CxxECv9K0ElGCYvtYxpV6yAxsLHZiI4zkS5b1kZjnQhtT1ShdTy+H6IR58kbk03Cn87yjjJKi4evsg3Alfmy42p5qm5amJ3zKHUMugk9Mv/iB42JZ/0SterltezDuNqLRFHjtvqHZDQdHtbxpL6Djpq70FrsDdSIHW2THlmLt+EfNfNLqNaRDXh8RyEmTLPozRmcf0n+R5MWsjQo+k5t6DfLnYVFH70ErX1zzCzhbr6d3bLThYY70kXB5rdbmUcBIsN8/pIgy2SQB9vN8AKTSahgUca2bIdAKHBCs9bUGVgrcAr2JgPnN3WRt0r1ghj1YrMD8URNPyml1XVN9pEbGznF8X+LaFnDx3dS0rbwmXq2nq59UMdpgynpEUkFusS+LEL8ZUJonx0z2MGToqE+duJF9eMoVglA0wekVRTOMayFGOYn6+gs5FFzG1mhZvAfgoT+e5jd2s87YNxfE4ZI3JJiLd1iDbkgBFYeVbabGydR23tWfH+XlwuClh3ODKtkCm9qoNi9IRzypWllxYwSIeC5QLr47rCHWHbysr6zHbGWMyarpeupLfNVXC5zEzC5EjREzmKK//mD3HjvhIfWK7aMuQ+hydL6y15YmlXDM+yhlB9MpZMZhVzLD0VU1Eq+deNuM2HzQxLGl7DYykN5BQ4ZwiER9z8y5ZkLxUDlCIhFMjAZjCU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2UL77pgWMTjNUtSx03+YWT8AuD2O3bafOjjEOQZ5FRMjMx06QUbLdibieNR9?=
 =?us-ascii?Q?zypABY6OIS29Jzg6yBpQC0p/70HTDYhaYU69JxPbrZpSYt79UoYf1in5E+zc?=
 =?us-ascii?Q?0nlBJvgQxUVQEd5X8F3zqftSx//2EXO5e46Q1YKeLMnGm1e0+s/Px+g3+426?=
 =?us-ascii?Q?uPBvdj5/6h+L/92fUkfkAhhAhYUYJZZaB2hRy9C09hKH7tqrx0QZud81Dqu3?=
 =?us-ascii?Q?x6sxhad6VoA8vUVX7cL9fu2KdSs9wPjVo2PRd17Vs1pjU0KSdTDrT5xQjCaH?=
 =?us-ascii?Q?PNu0Z2E+807HkAo7EA4d8ZAmaVz6SqJWe5nXNA0KNkxW6NSOhTVYy5HZVOjH?=
 =?us-ascii?Q?LdxC9JwZrq/xHOc4VfLCm4/WY+SuR2bHt3cejT5spepfi5h9Lvl68qmKEbIb?=
 =?us-ascii?Q?ASL2oYlCegqpwIsz10rd+4R+PzScxg2+kozAepIwq+0Azrn8uhoqjVzEwpgy?=
 =?us-ascii?Q?BEo3Oqx2lXUI43P8OPKuu0/1CxP1f7xWQmM6jx0prKhXsgnhkpuOLDAS1fgB?=
 =?us-ascii?Q?1MZ3n/hMwDPgkjPH03/W0Sf6sdD+lVscZ7oIvvo3xmMVK10tMF5TpCql49pZ?=
 =?us-ascii?Q?Gl5Uqmxd+ObyFMbOPmtpDWde5LtzB7p41xZf4OJ+pR/eJtevBk1N58FKiQAF?=
 =?us-ascii?Q?A6/sjQH6Ejx72b58aGHOncoF12Hgp5F5jth4s2396aWIrJBNZVjooOMzSGsv?=
 =?us-ascii?Q?nl2MknO6O82cE0kb/2LhpLS1GuQuh7tJtjgkrqMhkXN85rUHjDG3KA6HprEP?=
 =?us-ascii?Q?jtw1rEID5FE2rq7rTGEMi4a+w5YF1K2gVJgFpAoJmDFB77sQIs8pJB02sxRP?=
 =?us-ascii?Q?dzIxVL7w2ye03I++sqHNGQhpVSpnm5BAsnH0ICpEhVv418uVI3rqaSm4F4qo?=
 =?us-ascii?Q?lwkRqSSTnsvCfqbNO+NEz93Tsj/A8PCNjCXMHtEk5eZoVduK70X54BW9/ZVv?=
 =?us-ascii?Q?n8mxkzCOpl49qstFqeEud8oBQqrEtAAa+oc8B3zVYO5Y70L+yUn90X2PNYKs?=
 =?us-ascii?Q?BoAARdFyfeoTfp351UibWtyPHdc42fubBjDUz6r90I4kG4z0v72uXCFyP+KT?=
 =?us-ascii?Q?HsZw04sytCtWfOySOaRbJWGuCIvnSnNT5ari2kU9Io04lqxLvjYyq0U/yCI9?=
 =?us-ascii?Q?POcPxSbgLShltlTqM8ClS5JK8IORV6jtkf7wnKn4iyZ5MTWRiCbGVGxD0Dpe?=
 =?us-ascii?Q?dV5A/PzMZrxKP83OuYmlTVZQ8agQkmpyOwg4OMnBk3gLxm1AXxdfG9U/ltQT?=
 =?us-ascii?Q?5wi3AUtVphTLUnRD6nIIg7BQik8yiq4CvC6MIBwhAgymabJ2I55a6C0YwDGx?=
 =?us-ascii?Q?BWQSweTu40UmG/Wmic2ItEwgd/iRQolVm7Ro1o+eYyOcwW8kZY4CKjgmwFGJ?=
 =?us-ascii?Q?t/pgMi9fADXfQU+RVWY7ILuZ6aQPxZfEaquBoGqScnKyIaafO9a1JirvVbS7?=
 =?us-ascii?Q?/WGv2d1+LhpQmHi8LLeMfjxclgMt+BXyoKoXQo94KRMqcBiKILs/j4UgjZnZ?=
 =?us-ascii?Q?Cy5LEaWOSUiVzQ2dzZYsxq62yh1XzWRm10Fblg3+esMgthL+HeXzOsKwKjm7?=
 =?us-ascii?Q?nPAFaNuegzGKCvntJ6BSJ1EYt9RXPJn9Yaj/lAneniGg9+d4CrxWyU0KckjD?=
 =?us-ascii?Q?odfsIbSbjZJBpk5zqx7fhzlE1LUs9ie1t6lLVBKnHQvYcFcOunXA55l89igE?=
 =?us-ascii?Q?Ckg4IyLfn/ZrppBj5yqe+6INln7MQpDy95QJASKvlpeiJ09PnvwOaseIhj5K?=
 =?us-ascii?Q?ccz+Nl7+URm6JfmzZhaB8jtGr88g/Tk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FSAthB1eRV8sysWZBu3D+mbkGzgSyYzIzkbbg0WU5oYc8SDNOYdFcnzlasKalQKtKl5VYigjoU9llwHYssFDEoF669CLvtTQiAM/kV9qj0jgu1CwFY469nsrXxM62MwMOD8dnsxk2QhIXdLdHv+Ont1DxS2uJjfZNAw67jvH0BiDgneagPtuiOBMO5S/u0ku9tbdqzBdY37S10wucAIuneLL35mWC80WRz68fuG1PPDtK5bvxqXStlb54cuhOV/uYaLYPuvfSKDatAZABde/qtS+Gm3vz2VYYmILVJtm5XmubFyCp0vSxGA19XY7dGIg6FwGOf+eBNCg6erDfOTrQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec021e71-8920-440c-b010-08df18f1e268
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 21:38:47.4457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mC4QqqvjOLJpb1JOtEjwPXEti46AZACGD6IpD4pPP7vpEt0ZHzxrYaTb3DUVuTrF7wpz3PVDK0rZV+KAth6A0g8o+tUv6uBiLWi8Fu9cMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
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

>From: Petr Oros <poros@redhat.com>
>Sent: Thursday, September 17, 2026 9:04 PM
>
>When the number of CGU pins reported by firmware does not match the
>static pin table for the device, the driver falls back to the generic
>pins added by commit 6e58c33106220c ("ice: fix crash on probe for DPLL
>enabled E810 LOM"), named "0" to "15". The same labels are used for
>inputs and outputs, so a PIN_ID_GET lookup by board label fails with
>"multiple matches" for any index present on both sides and userspace
>such as synce4l cannot address the pin at all. The pin type is guessed
>from the current frequency and no supported frequency list is exposed.
>
>Firmware already classifies every input pin. Get CGU Input Config
>(0x0C63) returns a type field marking GPS, PHY recovered clock and
>external inputs, and a capability field with the supported 1PPS and
>10 MHz frequencies. The driver discards both, ice_dpll_pin_state_update()
>passes NULL for them.
>
>Use them in the generic path. Inputs become GNSS-<n>, RCLK-<n>, EXT-<n>,
>or IN-<n> when firmware reports no kind, with the matching dpll pin type
>and frequency list. An external input flagged as accepting any frequency
>advertises the standard 1PPS and 10 MHz pair. Outputs become OUT-<n>.
>Labels are unique across both directions and the 16 pin limit, which
>existed only because of the static label table, is gone. Labels that
>happened to be unique before, indexes above the smaller of the two pin
>counts, change as well.
>
>On an E810-C timing board firmware reports the C827 recovered clock
>inputs as PHY, the SMA inputs as external with 1PPS and 10 MHz, and the
>GNSS input as GPS with 1PPS, matching the static table for that board.
>A vendor board with 8 inputs and 15 outputs, which takes the generic
>path today, gets addressable and correctly typed pins instead of
>ambiguous numbers. The DPLL registration on such boards is fixed by
>"ice: DPLL init fixes for E810 timing boards" on iwl-net, this patch
>is independent of it.
>
>Signed-off-by: Petr Oros <poros@redhat.com>


Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>---
> drivers/net/ethernet/intel/ice/ice_dpll.c   | 72 +++++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_dpll.h   |  2 +
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 +++++++++
> drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
> 4 files changed, 95 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index 81bb32d2b23012..6e3e8fa94a3823 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -4284,10 +4284,60 @@ static void ice_dpll_phase_range_set(struct
>dpll_pin_phase_adjust_range *range,
> 	range->max =3D phase_adj;
> }
>
>+/**
>+ * ice_dpll_init_info_pin_generic_input - describe a generic input pin
>+ * @pf: board private structure
>+ * @pin: pin to describe
>+ *
>+ * Derive the pin type, board label and supported frequencies from the
>pin
>+ * classification reported by firmware.
>+ *
>+ * Return:
>+ * * 0 - success
>+ * * negative - AQ failure
>+ */
>+static int
>+ice_dpll_init_info_pin_generic_input(struct ice_pf *pf, struct
>ice_dpll_pin *pin)
>+{
>+	u8 type, caps, num;
>+	const char *kind;
>+	int ret;
>+
>+	ret =3D ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, &type,
>&caps,
>+				       NULL, NULL, NULL);
>+	if (ret)
>+		return ret;
>+
>+	if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_GPS) {
>+		pin->prop.type =3D DPLL_PIN_TYPE_GNSS;
>+		kind =3D "GNSS";
>+	} else if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_PHY) {
>+		pin->prop.type =3D DPLL_PIN_TYPE_MUX;
>+		kind =3D "RCLK";
>+	} else if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_EXTERNAL) {
>+		pin->prop.type =3D DPLL_PIN_TYPE_EXT;
>+		kind =3D "EXT";
>+		if (caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_ANYFREQ)
>+			caps |=3D ICE_AQC_GET_CGU_IN_CFG_FLG1_1PPS_SUPP |
>+				ICE_AQC_GET_CGU_IN_CFG_FLG1_10MHZ_SUPP;
>+	} else {
>+		pin->prop.type =3D pin->freq =3D=3D ICE_DPLL_PIN_GEN_RCLK_FREQ ?
>+				 DPLL_PIN_TYPE_MUX : DPLL_PIN_TYPE_EXT;
>+		kind =3D "IN";
>+	}
>+	snprintf(pin->label, sizeof(pin->label), "%s-%u", kind, pin->idx);
>+	pin->prop.board_label =3D pin->label;
>+	pin->prop.freq_supported =3D
>+		ice_cgu_get_pin_freq_supp_by_caps(caps, &num);
>+	pin->prop.freq_supported_num =3D num;
>+
>+	return 0;
>+}
>+
> /**
>  * ice_dpll_init_info_pins_generic - initializes generic pins info
>  * @pf: board private structure
>- * @input: if input pins initialized
>+ * @input: if we are initializing input pins
>  *
>  * Init information for generic pins, cache them in PF's pins structures.
>  *
>@@ -4298,13 +4348,10 @@ static void ice_dpll_phase_range_set(struct
>dpll_pin_phase_adjust_range *range,
> static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
> {
> 	struct ice_dpll *de =3D &pf->dplls.eec, *dp =3D &pf->dplls.pps;
>-	static const char labels[][sizeof("99")] =3D {
>-		"0", "1", "2", "3", "4", "5", "6", "7", "8",
>-		"9", "10", "11", "12", "13", "14", "15" };
> 	u32 cap =3D DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> 	enum ice_dpll_pin_type pin_type;
>-	int i, pin_num, ret =3D -EINVAL;
> 	struct ice_dpll_pin *pins;
>+	int i, pin_num, ret =3D 0;
> 	u32 phase_adj_max;
>
> 	if (input) {
>@@ -4319,12 +4366,9 @@ static int ice_dpll_init_info_pins_generic(struct
>ice_pf *pf, bool input)
> 		phase_adj_max =3D pf->dplls.output_phase_adj_max;
> 		pin_type =3D ICE_DPLL_PIN_TYPE_OUTPUT;
> 	}
>-	if (pin_num > ARRAY_SIZE(labels))
>-		return ret;
>
> 	for (i =3D 0; i < pin_num; i++) {
> 		pins[i].idx =3D i;
>-		pins[i].prop.board_label =3D labels[i];
> 		ice_dpll_phase_range_set(&pins[i].prop.phase_range,
> 					 phase_adj_max);
> 		pins[i].prop.capabilities =3D cap;
>@@ -4332,12 +4376,16 @@ static int ice_dpll_init_info_pins_generic(struct
>ice_pf *pf, bool input)
> 		ret =3D ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
> 		if (ret)
> 			break;
>-		if (input && pins[i].freq =3D=3D ICE_DPLL_PIN_GEN_RCLK_FREQ)
>-			pins[i].prop.type =3D DPLL_PIN_TYPE_MUX;
>-		else
>+		if (!input) {
>+			snprintf(pins[i].label, sizeof(pins[i].label),
>+				 "OUT-%u", pins[i].idx);
>+			pins[i].prop.board_label =3D pins[i].label;
> 			pins[i].prop.type =3D DPLL_PIN_TYPE_EXT;
>-		if (!input)
> 			continue;
>+		}
>+		ret =3D ice_dpll_init_info_pin_generic_input(pf, &pins[i]);
>+		if (ret)
>+			break;
> 		ret =3D ice_aq_get_cgu_ref_prio(&pf->hw, de->dpll_idx, i,
> 					      &de->input_prio[i]);
> 		if (ret)
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
>b/drivers/net/ethernet/intel/ice/ice_dpll.h
>index 103ba3e490682c..2360d920eb9ed8 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>@@ -6,6 +6,7 @@
>
> #include "ice.h"
>
>+#define ICE_DPLL_PIN_LABEL_LEN		16
> #define ICE_DPLL_RCLK_NUM_MAX	4
> #define ICE_DPLL_TXCLK_NUM_MAX	2
> #define E825_EXT_EREF_PIN_IDX	0
>@@ -83,6 +84,7 @@ struct ice_dpll_pin {
> 	bool active;
> 	bool hidden;
> 	enum ice_e825c_ref_clk tx_ref_src;
>+	char label[ICE_DPLL_PIN_LABEL_LEN];
> };
>
> /** ice_dpll - store info required for DPLL control
>diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>index 3a41c711e751b5..2ee6a720bd8929 100644
>--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>@@ -6059,6 +6059,37 @@ ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8
>pin, bool input, u8 *num)
> 	return t[pin].freq_supp;
> }
>
>+/**
>+ * ice_cgu_get_pin_freq_supp_by_caps - get supported frequencies from pin
>caps
>+ * @caps: input pin capability flags from Get CGU Input Config
>+ * @num: number of returned frequencies
>+ *
>+ * Return: array of supported frequencies, NULL if no fixed frequency is
>+ * advertised.
>+ */
>+struct dpll_pin_frequency *
>+ice_cgu_get_pin_freq_supp_by_caps(u8 caps, u8 *num)
>+{
>+	bool pps =3D caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_1PPS_SUPP;
>+	bool mhz =3D caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_10MHZ_SUPP;
>+
>+	if (pps && mhz) {
>+		*num =3D ARRAY_SIZE(ice_cgu_pin_freq_common);
>+		return ice_cgu_pin_freq_common;
>+	}
>+	if (pps) {
>+		*num =3D ARRAY_SIZE(ice_cgu_pin_freq_1_hz);
>+		return ice_cgu_pin_freq_1_hz;
>+	}
>+	if (mhz) {
>+		*num =3D ARRAY_SIZE(ice_cgu_pin_freq_10_mhz);
>+		return ice_cgu_pin_freq_10_mhz;
>+	}
>+	*num =3D 0;
>+
>+	return NULL;
>+}
>+
> /**
>  * ice_cgu_get_pin_name - get pin's name
>  * @hw: pointer to the hw struct
>diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>index 16b1988e993d2f..c59d9488b52220 100644
>--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>@@ -367,6 +367,8 @@ int ice_cgu_get_num_pins(struct ice_hw *hw, bool
>input);
> enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool
>input);
> struct dpll_pin_frequency *
> ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8
>*num);
>+struct dpll_pin_frequency *
>+ice_cgu_get_pin_freq_supp_by_caps(u8 caps, u8 *num);
> const char *ice_cgu_get_pin_name(struct ice_hw *hw, u8 pin, bool input);
> int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
> 		      enum dpll_lock_status last_dpll_state, u8 *pin,
>--
>2.55.0

