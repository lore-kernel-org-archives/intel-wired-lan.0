Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081C0CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDD9940DBA;
	Fri,  2 Oct 2026 13:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6ljUzYbzPMG; Fri,  2 Oct 2026 13:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D270940DA5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790946786;
	b=lcayOwfRzH+cBGINnVkBEGelDAeDOsOg+BY1n0KKcmIPA0bYr3l6Qa5pVWaZXACowozX
	 mXj92lqV6jJ+gQgT8Ou0vSNNtxotTE9uhcNp02boqxBL+Az2K/gknbm/RbwIjgUQxfelF
	 pHWihkluU0cW5iVUBIyceqlf1waHayqJyV+r8qCFQhZmHGMnB0yri+HToNTThzj/F/DSE
	 iaWOU4KfFergxr8qQZkJqaqV1QciV3LVvmJigEgrMGqHPwVeBXtNEXCm7c+hdrDaQYwa1
	 UXcScXrPQ247HP1cZPDuh6qmO6wHrS86Iz+6IXafd6Ao9uqYX6lx6aMT89bZY9sj9CQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946786;
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
	bh=/IF1+UGc/Q/BchNBeAETacRXTU9Ln8WJl2+dPU0Pf9U=;
	b=C+E4xFsH/9itIgAVBdoTC5ch02IVbd4/AsY1SOLWt+nbKhbxiwv/KrigeftWX35sV26W
	 A3dH8+wvBHapXi1a0jlM7aaYfCEMGf+xRmkHtBTR0vrWuEC9eGS3/V7WAdyCXpYBLN2vA
	 UQc4+7YZg7dt32/6LWEpXoybDdrWM38jEQ5y2GK1W4h7QRb9ruonWnksZ1MAWMTER6LeU
	 6ioMRJmTHRS/9JdRzstZ3EUCCNdgVlVQ7v+i36Kgx9K/4IAR/B09kjHDYa4hhMOcrjPMx
	 l7LjEFHsy7iJ3NIEPZXF82pKDOxRpfloKRulPSMfu6SH/DBE+yT8paIgxitD6HmKk8Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946786;
	bh=/IF1+UGc/Q/BchNBeAETacRXTU9Ln8WJl2+dPU0Pf9U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hUnXHAsV0TYPzJmL5yRdTz6hbiH0CVASe0yn6rOG7RHAeQu+NBvmdgdKvXuKR1mM6
	 4Xqz5q7KnthzJYesnVMogvZlvPX87yEbjoFULoWgUQ7B3fc9xpooZopKABIf7EmBZt
	 KDn9SBND/2E2mwbb2zq1eudFvyBH8E+km7aBIvUP3oubNWBD6wn7wpIoyy6fAo8Ey0
	 HBy+qaNCs7AUDZ9N97WvoIGLhMPFUbpotObCAAuTWlkOlhwGtIn0RKWBBXLSGmB50c
	 VuO4uGIQwcaSfUjPSGCBTvLfoKcI9FzOthp+e5vdgmcdBNoD0mN9l5eLl8E7Ge1Fbf
	 iw+Sqr/zFdIHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D270940DA5;
	Fri,  2 Oct 2026 13:13:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1DAF34D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2CF160BC7
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWnxggU_QKTB for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD00560C0B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946784;
 b=MDDPWFKalKJYuKr9ctldmMiK+2Z+qzsNrPYGhv1ifpAFU9llMOiw3kQmqS55DnZxI7jv
 rwnej62MTnB1Ru24Otvb4GG4Md8W75QYYqL9P7MXmWiwwMM3JVWMlBbznGrTcoRnUZs2I
 FgPPKEK0K1uit1zWiLnP5qZVWXRiu7xE1CSoJejuwnnCRvloRNYyQ0R7QaG0gTQvbkahS
 V97pFxY8RNrVTJacOr9u8hQmgXFbqNub4UvEpMZIuMikK9Fr2QjBoubsZoIICK2xv0Mw2
 0a/KfFoNUgEOjLptSXfORt+7VlAwNUf1yLmPp13oRh9IvKlGphohoY2FJiujvumLz0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946784;
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
 bh=/IF1+UGc/Q/BchNBeAETacRXTU9Ln8WJl2+dPU0Pf9U=;
 b=s9nG0u6wZXCgpf86VWXAE7/j4mwRkin7fuUvx9MNLDGDwAfib9DNrHwdh5EF6QxtYWqb
 7IwPIVec2CHeiKOyZCSoVCF1smdUYeSW5/4JaAD6r5TbSzTC5RgAY8EmF7O8cKOde0v3b
 y4OuC0gFsIDsXYBqHRbzsKhtGufcIiOHygUNMbk/u5UacZS65PbVM9/6PSuAypch1gueh
 g4nHROmPgBvUtOr3i1TMKGR1XU/ObcXhjbLiRpO+nXHnzKDvkXjsOctqpPayNq1yNP/NQ
 EXNjGEozVx6f2wOie7z2tvHtNuklJrESa3rssoFbVuCSgknqyMQnSdJDyrQo4RQ2NOw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EZoQHdxj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EZoQHdxj
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD00560C0B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790946784; x=1822482784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xipAtwqvj4q66zTEA7UGDJ7zl8FkgJUokTpnMsrl+d4=;
 b=EZoQHdxjrI+s/4VivLa//WAagQxbUztG/FP2tCoCaoKG85BHNY+QGCkD
 OpJIBxJpgeti+uHCu2SR5g+vIwvD5JaMi/oSf5FIKJyepfR9zLufhUPx7
 UQ3wKOu1yNcMNpHhhzGfGAPxTSwBtcEGYzfez5GPSubc3st2QYPy6CAcV
 gUFxJr1BYvyDKRNw2+k9MjtC+OWus0G3/MGdpc/uvWyZBrmKH7RM1ERFX
 u+o1E/x/msvRBD5c9wjfKWyNpsQ7/XoPSyohQnAwvhKLoftZPU96EVJ7R
 HGQn87U7Q1uxd/UnUKd0+9M+W9rrYEW1LZM2SNl2iXXJtu4ZOI+jYe5EM g==;
X-CSE-ConnectionGUID: mGJdFCXKToWApPRmqDYXIQ==
X-CSE-MsgGUID: jW+AJcq/SVScoIXQR0Ejlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="91574291"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="91574291"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 06:12:35 -0700
X-CSE-ConnectionGUID: TWAIn5J8Smeq3lnTKWZ+yw==
X-CSE-MsgGUID: 3UcH9HFpQdqRqO+tST6KzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="314238857"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 06:12:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 06:12:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 06:12:28 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 06:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VawUJEefMwIzXBWqWrzZwDGWrBlATHh10D4bbM9kMmjN6WPKeyECuF6sq3EdNZ1/a5CRfKW/fd5OFpUuv7motgKw6tFZGfVRiZpLYxJafUjiEq8q/Mli24QPQ+npnM4xVbvKsMREP6yGgYrWVCx1rxw3mAf8hWUgxBL9bpj/e8968z/DT+UlG/2T4KzWPWw6Lre6ZbKaqxMnMBNel93UQ+MQzwipwQnLxPEfiit8LlKzxQ4EMMVz/QOpXfzYsEliNvq71sO2OI6FEeU/6c6xvbi+ZFNnGRdtVYHfevTHJPcTf4W/a/DpOFILFL3AOqawmqTfkY7LuN5kYb6pmgmIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IF1+UGc/Q/BchNBeAETacRXTU9Ln8WJl2+dPU0Pf9U=;
 b=Ppzv2zMJuGYijYBokKxu/Sk/K2FIbEUf+WGXWjvX5ph8A7q3ohMz2aDgvg0DJX16KQp5wqnzodYHir4ceVRmocugI1Z/kGiATVcFOf7Mnq8gRVOzD0x1IWJKuaDsAVtnI4Q1Js7Q1vt/RKp2k8/s1EGlz+siP/KX2mZ13keAOJc0syzmtYSn5ul9sYFjRo0QuIdysqHXSVfcELp6b0Wei3RFkBwSackVscgxbuZPNzV49F4p1B/355iLHbqJRJU0IO9ibO6ntcpB5VIbQRFUf57VJqzdhLojZdP/mETDr7yJcd2I5jdlcs2gQ7atqsjG4JEcHME5MaI1puKDtgP/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PR11MB308671.namprd11.prod.outlook.com (2603:10b6:8:50c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:12:19 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 13:12:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
 <henry.w.tieman@intel.com>, Anirudh Venkataramanan
 <anirudh.venkataramanan@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Preethi Banala <preethi.banala@intel.com>, Kiran Patil
 <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
Thread-Topic: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
Thread-Index: AQHdUm9XxD0/wVz90k+yKBYPeLw9ALbqOj/A
Date: Fri, 2 Oct 2026 13:12:19 +0000
Message-ID: <IA3PR11MB8986B5CC249ABEA251FE9A5EE5892@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-11-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-11-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PR11MB308671:EE_
x-ms-office365-filtering-correlation-id: 9a7abd77-9b23-4441-7855-08df2086c9db
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006|21046099003;
x-microsoft-antispam-message-info: Eo7hKTkFnNgE7tCN0fnr/rwso3ipmDL3G1SMJNcuwuFDWc4ozAXl/Es0+1p2ZEYOrAJE9mBf0yfL8zVrYAaoPmoaUT5fYnLsoGfedXErX+KQz8l97Z+Jhq6F+KaUHBMkVD94Yg7q9KghGCjAFJMFkpSa0uQHtnJwRGpWWYlZpFuHn5q93R2zkJfKGPqjbraeK/JmL7nrvZsfLV0eZ4q83lY1Afzzhdb9/UT5fjJUu76z3fOba+2tAdctepUmmH89gIikSXWNwpPo2A0Gi6DddXrC54c+20qjbw0usBlGTd1oNEvIW3rtZf62lWIsscSF+/CRYU5PX+ZA6X+M9YqXi7AsF/YP/y5nHcR6AlF4dEiXgenjVSC4/+6pUiLOhAQvveIInO4dV56qz9qPpylpADkETn+Oe6pfreR9VMM4L+PITumw/HgDA/UIDZo2vPBF3dfAT3b5wLbVvGSnrzZctNXLQZGPPJof6GvBlALJmqhCljyQ1X2Ix6e5j4/aUQurU4KyYHdQNyu3TjAiamaBydA9uY9UOdZfRMbyMgQJOA4IqE+LP2X9/3L+ZE0zneM7+mH40vzj5dLuBT4n7c+LfEbQ+lCyt5gTg9xRINRgGvrGVr33zTmolnX4jitNpdlBMxQexJ+2rc7CEl247PXOBPwFiKkCyXI/qodwREegHvLcWoikRz6bQcIGRi+VflJ9rkUJtrhu+WBeFKToHxdtKcM9u88rVqPk5i+8w1B/9Lo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(21046099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHLd1+FHqSIrR9dQ8zsYxjsdyWCxB+SQjkSjfZ2/NwUmsLP5VkFqeIMgG0x6?=
 =?us-ascii?Q?gsNBMgf5emJQzfQgiDoz+eM7EHLI7oEGhKM0lVbePfPFlwg+D9+eP0FBgT76?=
 =?us-ascii?Q?a3lGrZx9rl3saCBVSZvrNbdmTAeGHkLfmehUp/J9sMyQj9Qd+Uar/zUNthgg?=
 =?us-ascii?Q?ukTF7PTmUh5ATa9rlt96vukqIts1T3XWr2BAoAJEO0fpRYUA7QeuIqiLoeaT?=
 =?us-ascii?Q?V1dSMjcMNdmRoFsa5MjGpwaMChfp6m3pU558Bnv7/xauFUoBzrIoVR5zaL2z?=
 =?us-ascii?Q?1nbt1blZ+HhJcMLz2mhmgxzRv/p2o7duuVCbXk+8T3kqMy5llY22BOv1g1Y/?=
 =?us-ascii?Q?gU1g4FYi+dn7uBKozH6P8As2ZGIG7Oa2erG30+9f+iFZJHIBfcPOEoZpSnPy?=
 =?us-ascii?Q?fYKy1Ax8yYxvq+sACBZJjKHq+f0xBT/qoqZxM9meDUQmsVBWH+YnwL30Q4Fu?=
 =?us-ascii?Q?F4+6REvRth1bqP59ov2gmyjOl405bp7wn3DnQXvjhOF7yZyiLePbbcS3fMAP?=
 =?us-ascii?Q?cu2LDA3ev/abwB/boB10T3XKXHufs47zGP1xjAkcaChoc8v+1f7Gj8KVqnlN?=
 =?us-ascii?Q?ri5IJ8x5zXQGmayow+71T05fAT3pOjv5JShA8jQHrYWr+ccTQc1km4ktsG0o?=
 =?us-ascii?Q?VN5zh0rUsvNRHCqsA4CQMX4pQpFAmk5jthQB9RyxkIb/0feB5u+CR2O8BwJT?=
 =?us-ascii?Q?zCgVYHB6kqTimbXHKweEpSljBsH4e4mGQ4o6dT3M6+lJLdOYsHQbiU3amHpm?=
 =?us-ascii?Q?CT/B7Mze1+Esa+HSng5taujS1KivXChWG1wjg/tkjdSO+OpxxQ9sP/imY4Pd?=
 =?us-ascii?Q?HrRyIGOpUtNg6NvaRoZk49pclB43DK5HH5bvCtoZlc91ns4INL8pFGGEFf7p?=
 =?us-ascii?Q?rOEiNoEmXSF6xrRqwzry0SAz8QXQqSQlKg2neT49aq1unrp5w9FWquUF2s68?=
 =?us-ascii?Q?ogpV8ouVV3e2OfRMgzPF38l89vvevIOVX4C6xBbxMLtL4zTzhn0E48Vdf3b6?=
 =?us-ascii?Q?OIeo1R3qjCDP9rZDWISBmNCsZpWwWrqGDP/PQim5JoygpbMSWBopeHMCgk8t?=
 =?us-ascii?Q?xiE7ivRXsXc0HLznrSffKV1G9D/vjOWAGBPOlYQayVDkK5ZsLTKTeMJD0I8N?=
 =?us-ascii?Q?WL2GP45O+W/OhrrpqbrEJJTyz2MX2/V54fIf+Dkg6DByNXA9UDoJ7UwBsSfa?=
 =?us-ascii?Q?EM4uDmM6ICf3bCgYTkrAlPLVsx1vpOITsU+DrtCelpvy4hKMyF/cw/MuJRw0?=
 =?us-ascii?Q?kPrpHlM3D3R/4mzBGMShjr39w4XsW65vU9yhx5hHO10Qku0ji+beNkqwbM/j?=
 =?us-ascii?Q?XDfzQDshti8ik5QfMw/h3V2dO6tCIZplekfZDkaH59u3D4Qa0bsDFcBqEeGr?=
 =?us-ascii?Q?ew27neuSX85lNB/D9ZiBETp7aWuOb8cJY3yvgUoA6b9EzLQon3SHIUXMu0Ot?=
 =?us-ascii?Q?pGxLEC7auiYbDsZyii+BVOawttId+5v+p1Am99BDtENeQMIBtiDIYcwd7BM7?=
 =?us-ascii?Q?jIMjiJkVJr0EWyrfcni3rOogv5Wg0xqIQxk/vO8db+g26mkuV3m25X/U8RuR?=
 =?us-ascii?Q?5ChW5qNiHU9mwmDpD19u+cFxVnfw93uCyhaheGV3Yh/YZBOVG5o5ul26aOhO?=
 =?us-ascii?Q?o/HtFqJq+l4nUyxGmOYCQTsGUY3CGkPPlk50FduQGFs2HdauVSqsFCQ+1O+w?=
 =?us-ascii?Q?0XZt1aAEsi9dLbEle8VzcjMkE0t0AQQCdiy0xVxM3bFRICtXvvrrgGq7UYG1?=
 =?us-ascii?Q?4RYEE+tW7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HaeNlNBovHa75X6Fp+EC1AoL+XLGM2MN5MeCRolK+NsH5yzkjXRO3cq1KDT3Hbu5BhkCCf6RhtaxGl3s6NtIBV7xlJnQ6yx06m9M+Homj8J+OSTM5AiUiFBGHo2/SBSTKQGw9eTxManUrhaV1619LxzkV6P96MTX1U/1h1rFrVWKNJ3FLCsAkaKdMExIhdX3Vx+pgMNzq6V8OF+PNLE0BTkmEN0ozzCdwxzwJn/H+YlTLdfUBjhxeWxXYPz4ZNT+t7X/LAQhYMtLuyaiUO7x896e87bzThoDX4Q69BbaqdYXmOZvhs+h+LfsJUD07f83ZI8KL0+TxpZa4OmHw3yn8w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7abd77-9b23-4441-7855-08df2086c9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 13:12:19.3705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAtcaL2Jc1xBKPUVjR5+KSLroNbmZS9yArl4pilUfgDRGod2GtLItHLAQCCe58/220I5vKaNpkZGEUaTB8htj06bq0UisAX1F1xTq+0pkNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB308671
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
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 2, 2026 3:08 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman
> <henry.w.tieman@intel.com>; Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Preethi Banala <preethi.banala@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Dan Nowlin
> <dan.nowlin@intel.com>; Stephen Hemminger
> <stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
>=20
> tx_restart, tx_busy, rx_buf_failed and rx_page_failed in struct
> ice_vsi are u32, but ice_update_vsi_ring_stats() fills them with sums
> of the 64-bit per ring counters. The values are truncated and the
> ethtool statistics exported from them wrap at 2^32 while the ring
> counters keep counting.
>=20
> Make them u64 like tx_linearize next to them.
>=20
> i40e fixed the same truncation in commit 3b8428b84539 ("i40e: fix
> unsigned stat widths").
>=20
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 6c596e5a315175..a985b81efbe2d6 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -344,10 +344,10 @@ struct ice_vsi {
>  	u64 tx_linearize;
>  	DECLARE_BITMAP(state, ICE_VSI_STATE_NBITS);
>  	unsigned int current_netdev_flags;
> -	u32 tx_restart;
> -	u32 tx_busy;
> -	u32 rx_buf_failed;
> -	u32 rx_page_failed;
> +	u64 tx_restart;
> +	u64 tx_busy;
> +	u64 rx_buf_failed;
> +	u64 rx_page_failed;
>  	u16 num_q_vectors;
>  	/* tell if only dynamic irq allocation is allowed */
>  	bool irq_dyn_alloc;
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


