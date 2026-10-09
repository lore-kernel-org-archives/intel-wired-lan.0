Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C66BCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 16:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D715140923;
	Fri,  9 Oct 2026 16:25:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CU3MnCYCFXd1; Fri,  9 Oct 2026 16:25:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8D694092B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791563126;
	b=XhD+UXbO3Fc2aGbNQILlcLJi5VJEAu1nF/fjr0YW98Cb9zjjvUzY71CzN1GdBoHj4eFS
	 dUwLxOBjyQ6pBK95UnymqpTfMkJYGCtPIuL8oU1czzKAQtPZNyxO5rKszadSHVhhOyfeK
	 16JhaHkLUAijQJh1ffJmSjBBtX1GSgZhtOvDqne4+dnUxrTWMiMVxZeycqDfQZHeJhFts
	 e2hQRrLzw1gl6dfn0YvagcRSNd5EhGGu54LwiDIxZj308jBQEWQ+RoFpfcj/EPzCwq5HH
	 0/S347GeXPGLrBJfHoov39oYG3drmi0akBbYIAZjVKgslvoJH/ksfsshgj97S/7pKKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791563126;
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
	bh=OxeHBbHi7wlmWr1dtOyaprBspOtZ8t/hrhyQ9LN7/eQ=;
	b=d/ljNUlJ0uHuXbr2dTHsGVvOrySyhLpuN3MI5TYbZjRSzToQhKxjY0xMFzAp+ks0b3bU
	 KYLKi8BsDcxiLNKZZRk38eNNeTFRWLhDg1BQ3Ohkm3GH+MH1D+yKoagiAf7jIcKOvAx5Z
	 PMQsc2hZi9rLg2U1h3GVsH5Kxnb49hltrcvg97l9XSqhVor0FTb84rZcuGLy9lYJo1nXM
	 7rihZzx4mUT3LK9JnAytKpT1v42EuVkAdzNTfs1Y0s9ZPFK/JfvfR2KWsaBmgMvBX0t56
	 XA0TJ8OxtSwqLKMHEsHW6EsSWyGV7HNWgMYsrP+eqAcXkDwXjPZ2bBQ2czc8goxeZEQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791563126;
	bh=OxeHBbHi7wlmWr1dtOyaprBspOtZ8t/hrhyQ9LN7/eQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wFjiTJY6bZJ8DqlyDuy5qenX/J6cDYHIa3HP8yCtW3Be/uuqZxYmxaJmp+RKLxEzU
	 rtrPdzQpBhjML1lCDcbym0Cxh6wHnWpMfwOp5pi1Ipn2rSRM4arqqSDkNGMkjvVoXm
	 bBvL+X9Y9TnJXgCPSw2XQrMVzuDX1qhU5w2w0uc3OuyePuaqYXbbv18N5CIYNTst/c
	 ncLG53NBGUMl7t2S9SpXGTrVBLdtgKUC9eF/NI9gAfwZj2jOgjjy2FaXEiLGj60LRH
	 gFzT6s4NKLXr6cptgQXtRQb6YTNJ+GNKpKPL2v4zEthHCIA8G4ol7IH3b9gBKUUYFF
	 XpizdrmqnVR2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8D694092B;
	Fri,  9 Oct 2026 16:25:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6D321D2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D352813FE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2n5EjFssB-C for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 16:25:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82F6181328
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791563124;
 b=MNfMYOolSYzIJhOXgbY2XAuEWadFydPKSp/Sot4xJz47KMwRMQqDEvWsrG8p+hLEBeLP
 0FBFjcoswEQ3amxYkJ+cwczTznp0Ai2ULThMdsUtko0qW3J0LEK9ZWq+n3li1o9u/KT4u
 bzmGXkdlIuitsyJmoPU4eRfM70PFPNmSbd6P46e+Bb5SJaESU/Ex4hbyETITCQtDHIgdh
 jRUeJDAd7fgLbTKf5wzUA46y8rSB10NdxlzXlFn96HEDQ/gRzIV5xieppQPr/YkSs0ngn
 0OB//CKwBtDE49ls1NkndZtL0SA1mgKHcY0aLvO3X6s1RRxYbHTKQ2vOpmcxTke1kLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791563124;
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
 bh=OxeHBbHi7wlmWr1dtOyaprBspOtZ8t/hrhyQ9LN7/eQ=;
 b=Xx1r0RWw6Hm3onBW8vRMf5GSYFi3Ux/tzFd9Y0RbRItKDR9Mbrvf2wpVCnmMIp8EXzKI
 tB2005rWh7WSwb3u4or1hxIPTEwX3oi+QF1ihi0FPYnbL0qwDfCnQyrQwvD5GgBoElkAY
 BRLLuwStQh80pVWegpTN35D4ae1g3cIyMQcp7iygcQEBrHbleoJxHh9kcg/3VgElT8ibZ
 q7FXRQjPQAlgENbVldCyHZXjSIOyYhN3OMw6KEKUposO+3+3GTVIG9grOV7I586h8F12i
 jpKiF35nGUvykfLMmapMiekhm98gg9d6EhvcZzZKKKHND7zBfRNsYkCSLk59AHbWOvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BOnjK8WS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BOnjK8WS
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82F6181328
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791563125; x=1823099125;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OxeHBbHi7wlmWr1dtOyaprBspOtZ8t/hrhyQ9LN7/eQ=;
 b=BOnjK8WSXLCpF00iZXKvbV3OS2VsSlMSP1W3Wc4EhgspGNkOc9/Qu4t0
 Pgt/0G5FzO8pZ9lhoNn8Bua9UGTLjQJPXyi9ggFvglnxP1IPx1rGhwxYY
 5sQGBC/kbzGGo7dK1aTNCMRKRJ9bum2eZruQ1PDeOVky7HLmED/JOQBaV
 iUau5qbEUygeT/tOdCX3WjA8t0voJj0lpiQXXrqhrzEiSAe/iyBIZIqHu
 HO5PqvD054P0JlY3MomgKkoqYxV+a0TZfccwvM1YFvy6aV7lt7zPEYizm
 QsnjnlFD5du9ZYnyPJcYYWBGJeHfF4rjumpXwzhZBuDYrttsY5Kf7ICzQ g==;
X-CSE-ConnectionGUID: Ty7yU+F9Tcmtq9e7HetYlg==
X-CSE-MsgGUID: LpUT06E9SySKD9Bka/eX7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="253199"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="253199"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:25:13 -0700
X-CSE-ConnectionGUID: 0Zl0kfJ1SN64M8ZXl+y5oQ==
X-CSE-MsgGUID: 4Bjso8LnREORj+wCsERfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="369629"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 09:25:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:24:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:24:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBwesMijWy7nuQW03twXN4eXwgnHS1Ke1+cpg3oljvW5LIQeiQ/j0SXDM1DJqmuWvtzVkWeLi2C+cp8+G8ohCnaCzMkIeZBCiJEgbKNO5quEDISKnamQLaj53nMm2jXHPvluQaWOOT4N05N5Le7+VfuenOX07vO94I/QJx7u23j00988/QALL41PrDg57f6Nsbai8TOZnfPSEIEKzVcssVkST531AnK1nT7XITHpSyTmqFC4wC/r3RPmMj3D0nBJ0QtaBqJqglKKVtKPMP6Erf6OQiRvkh4vAs++u0DxdQoYvXMlruOchXWovqvUyF+3XI5covonZfwuqdMQLdypXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxeHBbHi7wlmWr1dtOyaprBspOtZ8t/hrhyQ9LN7/eQ=;
 b=YqKfhqwC3SZbDlFw9xJoX0nwQeF70J/KPDmI50MZQ7AOmktDbJEQxaJgXVG/sadfH7YGWtYTD9gjD3JRWMI+oz2P3kg7aep4MJeghgqvUKqqP4+LMHMufvrX9MGv7nex51lXxCNS9++9gSDK0YtsJToiEUQlV55+G/kYTK96puzwHYY4MiNuYu5ECHp9I8/vLJTSzqwl9rMabQTXPh3Bluaw9UA3z8beLHUU6RZM+qaqr1PY7f5NoDC6VN1FM9SLWf73eEiawuC+b8FWdZvpCgMjK43Y9fQtiAbYUotniHdQRSyUkHfr5EL0ul0p4bmvhj9d3IzcE3M7X9OUjborkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 16:24:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:24:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-next v2] ixgbe: remove ixgbe_ping_all_vfs() from link
 state change handlers
Thread-Topic: [PATCH iwl-next v2] ixgbe: remove ixgbe_ping_all_vfs() from link
 state change handlers
Thread-Index: AQHdR3KGHQGrX9Y/TkWuFAE0rkZckbb0B+iAgAF93ZA=
Date: Fri, 9 Oct 2026 16:24:50 +0000
Message-ID: <IA3PR11MB8986053456B057CF1F826B18E5922@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260918133327.4170034-1-aleksandr.loktionov@intel.com>
 <ccb5c33d-8898-48a0-ae2e-16a2481828f6@intel.com>
In-Reply-To: <ccb5c33d-8898-48a0-ae2e-16a2481828f6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4846:EE_
x-ms-office365-filtering-correlation-id: 504124d8-afd0-418f-5a3e-08df2621d7bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|3023799007|10067099003;
x-microsoft-antispam-message-info: g15OZUB4LJqcX+cTBCt/66M6EL0aDhJ6bhw0ymiUlyREZqY7/Ha2Sse/67xdhkYxpy/j8WkDS0T6AXvFY3ihNbEClFa66txNfF3aTDnGEUYLRwRfhGXm69et2dE0snimNB7IeceAKPg51fuju5krXcf35KpX5r7LfXUj7p/bkC1PFaeQFZ7mPCHQoOT0jNCYGMQJI4ceU1pn34ShQ1NPYTl1KR2e5GWkGh8Y1dmlumFIshCUU9ntgdzJNgYmxZn+QC+m9K5RrSPyqRTg9jstHJMsBjBrZzde8J1wQI9z3ODVxTc8BTqdOkyruIXAGdIlfMTViLLgxm/wjWFbWA3l3VAVcwpWODusQewsVpGuuZqIAoEsPxrL674wcMGh1bbSGz8IkOL5WLzrZR418tCjJKZTkmgk7keLmv2YE+W71ues4G+Ad7Lb2NKTa/dZPU6tylaLtWm/rSr+H8bi8z9kfr8TEFZMOpcLpvULxIWN8z8wka3kbZwjptikcKNp+F8cOwj53WYHql6k2tbocdDV3DwEfMM1a3wEIU3MSRS2gE3uuuxuZgHRpSj30DHVmm4tWhQT5biZugh7sq161Fv6n5OlF1gePEs5mkVJUqMexz+qcERegkGxV3EceDqXkPNzTyhUbHxxJJvitYmh7QxZltqR+dMMWiBsu3YbL2BhTWydYKPrTCEfc9koIsi9PckYuI6zZUMm27o6r/x/2KOZ0SUlN+3Yt1TlUJqJLp5WJPU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTQwUFg1elRZT040UUZhYjhubExZSVNYSmZ6b0VCRWdWSUVnRWxLNmFtR0o3?=
 =?utf-8?B?ekJUTkFPWGFnMU9UL3dyVXo2OHhESGJFTlIycVRMTVRCY2c0RS9HWU10bUtU?=
 =?utf-8?B?YkErODFzck9wVFFMdWp4QlRmQ3k0WTVPS01sMFFBemJ1elQxVHR5TTJqUURo?=
 =?utf-8?B?YVdpanBCY0liL2wxcjEyZTVQSER0cnJHOGpHQ3lxcjJXUFB6bkRkdEM4NkxJ?=
 =?utf-8?B?eFVNSnpzUndnQ0RJWmt5ZmI5NitNRC9TcndORGJXaEgvUkFSdDdZbStRZmJH?=
 =?utf-8?B?a0tHaFdaN3UvN3dPdmNYcVZhU3c4Z0NNYW9ZMFY4MW01bFUyMGFZU0JvVndX?=
 =?utf-8?B?YTRHZnl1OGY4THdJTWhDN2NNN3NCYWlhRkhFTUJhRGFmT1F5dXBMKy96eXdG?=
 =?utf-8?B?c1Ewam53U1A0Q0JEOHdRNGpyRklVZlJpalRETC9uUzEwNlM3S3NMNmxVOElY?=
 =?utf-8?B?QjNYeG16eU82ODJMNlFFeEpOemxlRVgxMDFId000UHlqV1NYemhyTXl1a3Bo?=
 =?utf-8?B?djVWWE4rVHQzSUNyR2ZpeFpOTE5XVTlkZk5yeHZVWHpPelQyTGQvVjBiS0Fs?=
 =?utf-8?B?dEJ2cGpJaUY3OU93M2lwZ0hXTFYwQzFSRVpPN1p4c3VNckI2L1F2VWNVaVZ6?=
 =?utf-8?B?OTJJMFkrZVJkeVo0RzhUSkVpOHI0eTlqVUFLbVBUL2Y4bjVVeHBMVnBTWk90?=
 =?utf-8?B?dWsyYjk1b01sWmhhdGZvbzBYRVNYREZhdnVpZTUyWmtRSFR1ZW5sUzVjTmZ0?=
 =?utf-8?B?c2NOTVVwUlJ3ZHplb05mOFUwUFRCTFkvODZkaWVYK1FsWHJ5Mi9hM2lJTDc1?=
 =?utf-8?B?dU5ncnJvMjdwZWtlM2tNeW00TVY3ckErWW5XSW5oemFNN1JLV2FTV2lOM2pU?=
 =?utf-8?B?b0J4NkcrQ21pbEVtdkJxL2VQV3BuMDdQNWhWZ2lTbkd6Znl4TmFhR0x1R1gy?=
 =?utf-8?B?L3BSMDFVMC9TdEJnTU9PQ0M4cFgxT3NuVW90cE5yV1dnRWlLT0dDSll6Wkdh?=
 =?utf-8?B?cTlOYUtsN1lpZmphZ1ROdzlYSkgyNHJMaSt2S1orYTVZNy9ORUxzd2FEMUtp?=
 =?utf-8?B?dTlPcTRYRDlmS2xSa0xPbks3TGgzcTRyT1hVS2xhZmdSTno3MnJzemNPVll0?=
 =?utf-8?B?d0FzYjdCMll5L1Z3OXltblFqVGI3eitHQ0VXUkZqek5pUDM1dXV0SDJzNndW?=
 =?utf-8?B?U2tnUytmL0h0Nk1ZQjZPNDVIOFh6dnBVS1pnUXVpWWVJNFNDbHU5Um5ZUEZi?=
 =?utf-8?B?RXVkR08zQXFWb3VKSlNJMGpvR3FKamkrcGgvQzF5UFJvdXJONzFrbUxOc1Jr?=
 =?utf-8?B?SE1wTDJVWm8vbU5Qa05ZWUwyaGRabnMvQXF0emoxOUlyUW92OFhVS1M0Rk1Y?=
 =?utf-8?B?R1Q5UmdNRE11cEFZUitqRFRWTlFkTVdmWnhCRVZLVGlYclRsZHovbGp6SThJ?=
 =?utf-8?B?eGIyZmxEYnlYUld2bzRvVitHM0FvYTRNR3FpUitBUzNJUlBRSVVGcjRxZlQy?=
 =?utf-8?B?V0VDMHlCa0phejFHYU10VlNia1RqUjBiNGQ4enhTb2NyQXB6c3BlM00rSFQ2?=
 =?utf-8?B?M21DRzA4YW1lN0Y1VVJHQ0lHVDE0T0JoNFBDRTlHeEpjSXcvUGdWVjl0QnlT?=
 =?utf-8?B?Mk1pUG9NdXZlYXhDWDRPaU91eTlrVjcvRzRKK25sWnIvWDlETk9YeXc3QzBl?=
 =?utf-8?B?bEVOV1lEbXFreUNFUVVBbGZESnM2azEvWWgvbGs5NGRVWHREc21URjIyeDlT?=
 =?utf-8?B?eFJYZnI2WC9aZ0FYT3BqbDJxYVJVRU9JOGx1YVhDSXIyeGpZVjdWWVN2QzNJ?=
 =?utf-8?B?cksrZ2J5SFY0czdrRDNRUksxRDZaUC9uZmsxdE1qNEhDc2dEbVFhNzJoQ2E1?=
 =?utf-8?B?c0tKR21zWmhqdXVFc01FR241SXl0dS82WG5oZWVnUjhBSFlqY1JmMXhha1du?=
 =?utf-8?B?aklDcDJHUUVoRTkwU0Nxa3lKUG1Ua1hjUWdXckpsZmdQUjFFL0FNV0lTbEVr?=
 =?utf-8?B?RkZGUlpSMGNXd1JpZWMrWlZBbVg5dEh4S3NGVGpjN2UzYURPbU53bllDT0cz?=
 =?utf-8?B?ZitNK3RINVl1ZnlrVS9vbDFmcFJVTHVJalZJSE5LVlh6U0E4cmRGSENzLzRw?=
 =?utf-8?B?enNMVG1PZms4YVRJMllLVlN5NG1EZ0JSd293WjIvMmhqZUtjcGhZNkdjZ1k5?=
 =?utf-8?B?bWREdTc5aml4SS9INEg4elBGYnY2TEc4bGFIUXhVdnJLbG8vQVJkTlF5NWRi?=
 =?utf-8?B?Qko2ZUVWRVprQ1Bkd0d6ZHBXS0N0N1JFdkQ1aG1wMFh0Rlhib2FMSFFVT0xz?=
 =?utf-8?B?OStLQ2hPcDN2Z3UxWGxVQ2lVRG84Y1M2WkRObkNkaXZKd2o5cDJjMWhxZWgz?=
 =?utf-8?Q?u/Azxtj1IjG7O2tg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iMv+Jx+trtKCahsMH+GuGThsG8GMeG8+6aCjPibjFVxPbui2+mZ5g79kp2Ty+emJpJB5rVGLCxFj0ggCyQS/kyvPVnbZRR0IIhMEdrr+x0Tuu2KNiGftk53+fjDm0irn9CIunQs/NXkldsILVsr2qVb6X6JC2d9P+cexsOG6hY67joyGaL2fmg7g14udWShyRKnjXElC//Hj+VF+jUIMT2Um7otsnQJJLw3ZJuAGRSxIIK39BVMcc9DDI/+qiuxD0puT0OfshFFP2xNlti1/ulQ0F484mqPuMFXvpf6iNgoblbIGlb4ZuUpmDE3eTg3aHvf/nRLGVNEy5+JUWafDqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504124d8-afd0-418f-5a3e-08df2621d7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:24:50.4633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7qKAfVV9ngrW55KAK1vgNeiZxKyKikM4rg/Qp/3/yFlnzmdWOsMwbogwT9K5yxREUk8v9ooSDdEcZ3L6Ht1Rt6qtreU5SlTs29bl8VFloU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmd1eWVuLCBBbnRob255
IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciA4LCAyMDI2IDc6MzUgUE0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIu
bG9rdGlvbm92QGludGVsLmNvbT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9y
Zw0KPiBDYzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIGl3bC1uZXh0IHYyXSBpeGdiZTogcmVtb3ZlIGl4Z2JlX3BpbmdfYWxsX3ZmcygpDQo+
IGZyb20gbGluayBzdGF0ZSBjaGFuZ2UgaGFuZGxlcnMNCj4gDQo+IA0KPiANCj4gT24gOS8xOC8y
MDI2IDY6MzMgQU0sIEFsZWtzYW5kciBMb2t0aW9ub3Ygd3JvdGU6DQo+ID4gV2hlbiBtdWx0aXBs
ZSBWRnMgYXJlIGJyb3VnaHQgdXAgc2ltdWx0YW5lb3VzbHksIGEgVkYgY2FuIHJlY2VpdmUgYQ0K
PiA+IENUUyAoQ2xlYXIgVG8gU2VuZCkgbWFpbGJveCBtZXNzYWdlIGluc3RlYWQgb2YgdGhlIGV4
cGVjdGVkIFJFU0VUIHwNCj4gPiAoTilBQ0sgcmVzcG9uc2UsIGJlY2F1c2UgdGhlIHdhdGNoZG9n
IGZpcmVzIGEgZ3JhdHVpdG91cyBwaW5nIHJpZ2h0DQo+IGFzDQo+ID4gdGhlIFZGIG1haWxib3gg
dHJhbnNhY3Rpb24gaXMgaW4gcHJvZ3Jlc3MuDQo+ID4NCj4gPiBSZW1vdmUgdGhlIGl4Z2JlX3Bp
bmdfYWxsX3ZmcygpIGNhbGwgZnJvbSBib3RoDQo+ID4gaXhnYmVfd2F0Y2hkb2dfbGlua19pc191
cCgpIGFuZCBpeGdiZV93YXRjaGRvZ19saW5rX2lzX2Rvd24oKS4gIEJvdGgNCj4gPiBwYXRocyBj
b250YWluIGFuIGlkZW50aWNhbCBjYWxsIHdpdGggdGhlIHNhbWUgcmFjZSB3aW5kb3cgZHVyaW5n
IFZGDQo+ID4gaW5pdGlhbGl6YXRpb246IGxpbmstc3RhdGUgY2hhbmdlcyAodXAgb3IgZG93bikg
Y2FuIGFycml2ZSB3aGlsZSBWRnMNCj4gPiBhcmUgbWlkLWluaXRpYWxpemF0aW9uLCBhbmQgdGhl
IGdyYXR1aXRvdXMgcGluZyBmcm9tIGVpdGhlcg0KPiBkaXJlY3Rpb24NCj4gPiBjb2xsaWRlcyB3
aXRoIHRoZSBWRiBtYWlsYm94IHN0YXRlIG1hY2hpbmUgZm9yIHRoZSBzYW1lIHJlYXNvbi4NCj4g
Pg0KPiA+IExpbmstc3RhdGUgY2hhbmdlcyBhcmUgYWxyZWFkeSBjb21tdW5pY2F0ZWQgdG8gVkZz
IHRocm91Z2ggdGhlDQo+IG5vcm1hbA0KPiA+IG1haWxib3ggcHJvdG9jb2w7IHRoZXNlIGV4dHJh
IHBpbmdzIGFyZSByZWR1bmRhbnQgb24gYm90aCBwYXRocy4NCj4gPg0KPiA+IFRoaXMgcmVtb3Zl
cyB0aGUgbGFzdCB0d28gY2FsbGVycyBvZiBpeGdiZV9waW5nX2FsbF92ZnMoKSwgc28gcmVtb3Zl
DQo+ID4gdGhlIG5vdy11bnVzZWQgZnVuY3Rpb24gYW5kIGl0cyBkZWNsYXJhdGlvbiBhcyB3ZWxs
Lg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBTZWJhc3RpYW4gQmFzaWVyc2tpIDxzZWJhc3RpYW54
LmJhc2llcnNraUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRyIExva3Rp
b25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFNp
bW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiB2MSAtPiB2Mjogbm8g
Y29kZSBjaGFuZ2VzLCByZXNlbmRpbmcgdG8gcGljayB1cCBSZXZpZXdlZC1ieQ0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfbWFpbi5jICB8ICA2
IC0tLS0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfc3Jp
b3YuYyB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9peGdiZS9peGdiZV9zcmlvdi5oIHwgIDEgLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9peGdiZS9peGdiZV9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2l4Z2JlL2l4Z2JlX21haW4uYw0KPiA+IGluZGV4IGY5MTg1NjQuLjM2NWFjZjggMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfbWFpbi5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfbWFpbi5jDQo+
ID4gQEAgLTgxODEsOSArODE4MSw2IEBAIHN0YXRpYyB2b2lkIGl4Z2JlX3dhdGNoZG9nX2xpbmtf
aXNfdXAoc3RydWN0DQo+ID4gaXhnYmVfYWRhcHRlciAqYWRhcHRlcikNCj4gPg0KPiA+ICAgCS8q
IHVwZGF0ZSB0aGUgZGVmYXVsdCB1c2VyIHByaW9yaXR5IGZvciBWRnMgKi8NCj4gPiAgIAlpeGdi
ZV91cGRhdGVfZGVmYXVsdF91cChhZGFwdGVyKTsNCj4gPiAtDQo+ID4gLQkvKiBwaW5nIGFsbCB0
aGUgYWN0aXZlIHZmcyB0byBsZXQgdGhlbSBrbm93IGxpbmsgaGFzIGNoYW5nZWQgKi8NCj4gPiAt
CWl4Z2JlX3BpbmdfYWxsX3ZmcyhhZGFwdGVyKTsNCj4gDQo+ICBGcm9tIFNhc2hpa286DQo+IA0K
PiBEb2VzIHJlbW92aW5nIHRoaXMgUEYtdG8tVkYgbWFpbGJveCB3cml0ZSBwcmV2ZW50IHRoZSBQ
RiBmcm9tIHNlbmRpbmcNCj4gdGhlIENUUyBtZXNzYWdlIHJlcXVpcmVkIGZvciB0aGUgVkYgdG8g
dHJhbnNpdGlvbiBpdHMgaW50ZXJuYWwgbGluaw0KPiBzdGF0ZSBmcm9tIGRvd24gdG8gdXA/DQo+
IA0KPiBUaGUgaXhnYmV2ZiBkcml2ZXIgYXBwZWFycyB0byByZWx5IG9uIHRoaXMgQ1RTIG1lc3Nh
Z2UgdG8gY29ycmVjdGx5DQo+IGNsZWFyIG1hYy0+Z2V0X2xpbmtfc3RhdHVzIGFuZCB0cmFuc2l0
aW9uIHRvIHVwOg0KPiANCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi92Zi5j
Oml4Z2JldmZfY2hlY2tfbWFjX2xpbmtfdmYoKSB7DQo+ICAgICAgLi4uDQo+ICAgICAgaWYgKCEo
aW5fbXNnICYgSVhHQkVfVlRfTVNHVFlQRV9DVFMpKSB7DQo+ICAgICAgICAgIC8qIG1zZyBpcyBu
b3QgQ1RTIGFuZCBpcyBOQUNLIHdlIG11c3QgaGF2ZSBsb3N0IENUUyBzdGF0dXMgKi8NCj4gICAg
ICAgICAgaWYgKGluX21zZyAmIElYR0JFX1ZUX01TR1RZUEVfRkFJTFVSRSkNCj4gICAgICAgICAg
ICAgIHJldF92YWwgPSAtMTsNCj4gICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgfQ0KPiAgICAg
IC4uLg0KPiAgICAgIG1hYy0+Z2V0X2xpbmtfc3RhdHVzID0gZmFsc2U7DQo+IG91dDoNCj4gICAg
ICAqbGlua191cCA9ICFtYWMtPmdldF9saW5rX3N0YXR1czsNCj4gfQ0KPiANCj4gV2l0aG91dCB0
aGlzIHBpbmcsIHdpbGwgdGhlIFZGIHBlcnNpc3RlbnRseSBmYWlsIHRoZSBtYWlsYm94IHJlYWQg
YW5kDQo+IGZvcmNlIHRoZSBsaW5rIHN0YXRlIGRvd24/DQo+IA0KPiA+ICAgfQ0KPiA+DQo+ID4g
ICAvKioNCj4gPiBAQCAtODIxNCw5ICs4MjExLDYgQEAgc3RhdGljIHZvaWQgaXhnYmVfd2F0Y2hk
b2dfbGlua19pc19kb3duKHN0cnVjdA0KPiA+IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0ZXIpDQo+ID4N
Cj4gPiAgIAllX2luZm8oZHJ2LCAiTklDIExpbmsgaXMgRG93blxuIik7DQo+ID4gICAJbmV0aWZf
Y2Fycmllcl9vZmYobmV0ZGV2KTsNCj4gPiAtDQo+ID4gLQkvKiBwaW5nIGFsbCB0aGUgYWN0aXZl
IHZmcyB0byBsZXQgdGhlbSBrbm93IGxpbmsgaGFzIGNoYW5nZWQgKi8NCj4gPiAtCWl4Z2JlX3Bp
bmdfYWxsX3ZmcyhhZGFwdGVyKTsNCj4gDQo+IERvZXMgcmVtb3ZpbmcgdGhpcyBwaW5nIHNldmVy
IHRoZSBtZWNoYW5pc20gdGhhdCB0cmlnZ2VycyB0aGUgVkYncw0KPiBtYWlsYm94IGludGVycnVw
dCBvbiBwaHlzaWNhbCBsaW5rIGRyb3BzPw0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgaXhnYmV2
ZiBkcml2ZXIgdXNlcyBtYWMtPmdldF9saW5rX3N0YXR1cyB0bw0KPiBkZXRlcm1pbmUgaWYgaXQg
c2hvdWxkIHBvbGwgdGhlIHBoeXNpY2FsIGxpbmsuIE9uY2UgdXAsIGl0IHNldHMgdGhpcw0KPiB0
byBmYWxzZSBhbmQgcmVsaWVzIG9uIGEgbWFpbGJveCBpbnRlcnJ1cHQgKGl4Z2JldmZfbXNpeF9v
dGhlcigpKSB0bw0KPiBzZXQgaXQgYmFjayB0byAxIG9uIHN0YXRlIGNoYW5nZXMuDQo+IA0KPiBX
aWxsIFNSLUlPViBWRnMgcmVtYWluIHN0dWNrIGluIHRoZSB1cCBzdGF0ZSBhbmQgcGVybWFuZW50
bHkgcmVwb3J0DQo+IGluY29ycmVjdCBsaW5rIHN0YXRlcyBpZiB0aGV5IGFyZSBub3Qgbm90aWZp
ZWQgb2YgbGluayBkcm9wcyB2aWEgdGhpcw0KPiBtYWlsYm94IHdyaXRlPw0KPiANCj4gPiAgIH0N
Cj4gPg0KPiA+ICAgc3RhdGljIGJvb2wgaXhnYmVfcmluZ190eF9wZW5kaW5nKHN0cnVjdCBpeGdi
ZV9hZGFwdGVyICphZGFwdGVyKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9peGdiZS9peGdiZV9zcmlvdi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9peGdiZS9peGdiZV9zcmlvdi5jDQo+ID4gaW5kZXggNDMxZDc3ZC4uZGE2NDFlOSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9zcmlv
di5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfc3Jp
b3YuYw0KPiA+IEBAIC0xNTE1LDIwICsxNTE1LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGl4Z2Jl
X3BpbmdfdmYoc3RydWN0DQo+IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0ZXIsIGludCB2ZikNCj4gPiAg
IAlpeGdiZV93cml0ZV9tYngoaHcsICZwaW5nLCAxLCB2Zik7DQo+ID4gICB9DQo+ID4NCj4gPiAt
dm9pZCBpeGdiZV9waW5nX2FsbF92ZnMoc3RydWN0IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0ZXIpIC17
DQo+ID4gLQlzdHJ1Y3QgaXhnYmVfaHcgKmh3ID0gJmFkYXB0ZXItPmh3Ow0KPiA+IC0JdTMyIHBp
bmc7DQo+ID4gLQlpbnQgaTsNCj4gPiAtDQo+ID4gLQlmb3IgKGkgPSAwIDsgaSA8IGFkYXB0ZXIt
Pm51bV92ZnM7IGkrKykgew0KPiA+IC0JCXBpbmcgPSBJWEdCRV9QRl9DT05UUk9MX01TRzsNCj4g
PiAtCQlpZiAoYWRhcHRlci0+dmZpbmZvW2ldLmNsZWFyX3RvX3NlbmQpDQo+ID4gLQkJCXBpbmcg
fD0gSVhHQkVfVlRfTVNHVFlQRV9DVFM7DQo+ID4gLQkJaXhnYmVfd3JpdGVfbWJ4KGh3LCAmcGlu
ZywgMSwgaSk7DQo+ID4gLQl9DQo+ID4gLX0NCj4gDQo+IElzIHRoaXMgZnVuY3Rpb24gYWN0dWFs
bHkgZXNzZW50aWFsIGZvciBub3RpZnlpbmcgVkZzIG9mIGFzeW5jaHJvbm91cw0KPiBsaW5rIHN0
YXRlIGNoYW5nZXM/DQo+IA0KPiBTaW5jZSBWRnMgZG8gbm90IGhhdmUgYWNjZXNzIHRvIHBoeXNp
Y2FsIFBIWSBpbnRlcnJ1cHRzLCBpdCBzZWVtcyB0aGV5DQo+IG1pZ2h0IGRlcGVuZCBvbiB0aGlz
IFBGLWluaXRpYXRlZCBwaW5nIHRvIGxlYXJuIGFib3V0IHN0YXRlDQo+IHRyYW5zaXRpb25zLg0K
PiANCj4gPiAgIC8qKg0KPiA+ICAgICogaXhnYmVfc2V0X2FsbF92ZnMgLSB1cGRhdGUgdmZzIHF1
ZXVlcw0KPiA+ICAgICogQGFkYXB0ZXI6IFBvaW50ZXIgdG8gYWRhcHRlciBzdHJ1Y3QgZGlmZiAt
LWdpdA0KPiA+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfc3Jpb3Yu
aA0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfc3Jpb3YuaA0K
PiA+IGluZGV4IGJjNGNhYjkuLmY3NTViZmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfc3Jpb3YuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3NyaW92LmgNCj4gPiBAQCAtMTgsNyArMTgsNiBA
QCB2b2lkIGl4Z2JlX3Jlc3RvcmVfdmZfbXVsdGljYXN0cyhzdHJ1Y3QNCj4gaXhnYmVfYWRhcHRl
ciAqYWRhcHRlcik7DQo+ID4gICBib29sIGl4Z2JlX2NoZWNrX21kZF9ldmVudChzdHJ1Y3QgaXhn
YmVfYWRhcHRlciAqYWRhcHRlcik7DQo+ID4gICB2b2lkIGl4Z2JlX21zZ190YXNrKHN0cnVjdCBp
eGdiZV9hZGFwdGVyICphZGFwdGVyKTsNCj4gPiAgIGludCBpeGdiZV92Zl9jb25maWd1cmF0aW9u
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCB1bnNpZ25lZCBpbnQNCj4gPiBldmVudF9tYXNrKTsgLXZv
aWQgaXhnYmVfcGluZ19hbGxfdmZzKHN0cnVjdCBpeGdiZV9hZGFwdGVyDQo+ICphZGFwdGVyKTsN
Cj4gPiAgIHZvaWQgaXhnYmVfc2V0X2FsbF92ZnMoc3RydWN0IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0
ZXIpOw0KPiA+ICAgaW50IGl4Z2JlX25kb19zZXRfdmZfbWFjKHN0cnVjdCBuZXRfZGV2aWNlICpu
ZXRkZXYsIGludCBxdWV1ZSwgdTgNCj4gKm1hYyk7DQo+ID4gICBpbnQgaXhnYmVfbmRvX3NldF92
Zl92bGFuKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsIGludCBxdWV1ZSwNCj4gdTE2DQo+ID4g
dmxhbiwNCg0KR29vZCBkYXksIFRvbnkNCg0KR29vZCBjYXRjaCEgSSBkdWcgdGhyb3VnaCBpeGdi
ZXZmJ3MgbGluay1jaGVjayBwYXRoIGFuZCB0aGUgY29uY2VybiBob2xkcyB1cC4NCg0KaXhnYmV2
Zl9jaGVja19tYWNfbGlua192ZigpIG9ubHkgcmUtcmVhZHMgdGhlIFZGTElOS1MgcmVnaXN0ZXIg
b3IgbG9va3MNCmZvciBhIG5ldyBDVFMgbWVzc2FnZSB3aGlsZSBtYWMtPmdldF9saW5rX3N0YXR1
cyBpcyB0cnVlLiBPbmNlIGEgVkYNCmxhdGNoZXMgZ2V0X2xpbmtfc3RhdHVzID0gZmFsc2UgKCJs
aW5rIGlzIHVwLCBubyBuZWVkIHRvIHJlY2hlY2siKSwgdGhlDQpvbmx5IHRoaW5ncyB0aGF0IGZs
aXAgaXQgYmFjayB0byB0cnVlIGFyZSBhIG1haWxib3ggcmVzZXQsIGEgbWFpbGJveA0KdGltZW91
dCwgb3IgdGhlICJvdGhlciIgTVNJLVggSVJRIC0gd2hpY2ggZmlyZXMgb25seSB3aGVuIHRoZSBQ
RiB3cml0ZXMNCnNvbWV0aGluZyBuZXcgdG8gdGhhdCBWRidzIG1haWxib3guIE9uY2UgYSBWRiBm
aW5pc2hlcyBpdHMgQVBJL3F1ZXVlDQpuZWdvdGlhdGlvbiBhbmQgZ29lcyBxdWlldCwgbm90aGlu
ZyBlbHNlIHdyaXRlcyB0byBpdHMgbWFpbGJveCwgc28NCnRoZXJlJ3Mgbm8gZGVsaXZlcnkgcGF0
aCBsZWZ0IGZvciBlaXRoZXIgZGlyZWN0aW9uIG9uY2UgYm90aCBwaW5ncw0KYXJlIGdvbmU6DQoN
CiAtIHdhdGNoZG9nX2xpbmtfaXNfdXAoKTogd2l0aG91dCB0aGUgcGluZydzIENUUywgYSBWRiBz
dGlsbCB3YWl0aW5nIG9uDQogICBnZXRfbGlua19zdGF0dXMgd2lsbCBrZWVwIHNlZWluZyBhbiB1
cCBWRkxJTktTIHJlZ2lzdGVyIGJ1dCBuZXZlcg0KICAgcmVjZWl2ZSB0aGUgQ1RTIGl0IG5lZWRz
IHRvIGFjdHVhbGx5IGNsZWFyIHRoZSBmbGFnLg0KIC0gd2F0Y2hkb2dfbGlua19pc19kb3duKCk6
IHdpdGhvdXQgdGhlIHBpbmcsIGEgVkYgdGhhdCBhbHJlYWR5IGxhdGNoZWQNCiAgIGdldF9saW5r
X3N0YXR1cyA9IGZhbHNlIGhhcyBubyB0cmlnZ2VyIHRvIGV2ZXIgcmUtcmVhZCB0aGUgcmVnaXN0
ZXIsDQogICBzbyBpdCBjYW4gZ2V0IHN0dWNrIHJlcG9ydGluZyBsaW5rIHVwIGFmdGVyIHRoZSBw
aHlzaWNhbCBsaW5rIGRyb3BzLg0KDQpUaGUgQ1RTLWNvbGxpc2lvbiByYWNlIGR1cmluZyBzaW11
bHRhbmVvdXMgVkYgYnJpbmctdXAgdGhhdCBtb3RpdmF0ZWQNCnRoaXMgcGF0Y2ggaXMgcmVhbCwg
YnV0IHJlbW92aW5nIHRoZSBwaW5nIG91dHJpZ2h0IHRyYWRlcyBpdCBmb3IgYQ0Kd29yc2UsIHNp
bGVudCBvbmUuDQoNCkRyb3BwaW5nIHRoaXMgcGF0Y2ggcmF0aGVyIHRoYW4gY2FycnkgdGhlDQpS
ZXZpZXdlZC1ieSBmb3J3YXJkIG9udG8gYSBkaWZmIHdpdGggdGhpcyBnYXAuIElmIEkgY29tZSBi
YWNrIHRvIHRoZQ0KdW5kZXJseWluZyByYWNlLCBpdCdsbCBuZWVkIHRvIG5hcnJvdyB0aGUgd2lu
ZG93IGluc3RlYWQgKGUuZy4gb25seQ0Kc3VwcHJlc3MgdGhlIHBpbmcgd2hpbGUgYSBWRiByZXNl
dCBpcyBhY3R1YWxseSBpbiBmbGlnaHQpLCBub3QgcmVtb3ZlDQpub3RpZmljYXRpb24gZW50aXJl
bHkuDQoNClRoYW5rcywNCkFsZXgNCg0K
