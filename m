Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603C4CA6016
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 184706084F;
	Thu,  8 Oct 2026 21:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MihU96rTSmNl; Thu,  8 Oct 2026 21:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72F8F6082C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494699;
	b=GWGGQw0SxU6PZR+N2kJpcLbmeCLdpiLO7FpF8tY5uNzE2L7s6oExMempxgE0VGiQE7R7
	 0X4ZTGJg6DbP/Hy7tB1ap3Q/aLcIhXZv5mfqRfrWof9+Nmjgm5usOnUmuEcnhxRE3RwiG
	 bXmN+Y2lBHh77k/C7Z4O0Gt8KE0Tjy+b8hOCpJtVbvZTPlz5JEDR8SG+SRt76kUtrMmN1
	 GOrkAHRCTNJUO3QhhzNKHDZATmuj3c64tZYNRQ6KhuZJLaS+YcGwhJnmoVRP+Wsx4OLuO
	 OYiSZmyjEZZ7+79Kr9PeXYw9w14cyzeVkCTHbc4dx3FcmrL8WzkH2aF/JW5yX2PljYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494699;
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
	bh=68+I+X+0un+DVAR6atAkFZ76Upg/Izsq28ThqZljlhU=;
	b=W3xFtEo+uaMJB4EqLPxwsA+24SosS6fXnwJ6mbJmTggfprSTeJ/2lsSs7P0Be4Y7jOHP
	 8N627jQCfxtgv+JYQWec6oQ5d7I0TVz14T1Vh/KKk9U5HksDT/MlVhDQYs0CRoctwnEh0
	 x5FD0DgH1OPbs6MnR+fDGYFgIiVXXBpzCLtp5npgXqCvuVgP2YPatnXThss7+P7Rr0ZFi
	 ZSJlQkIdPt3RMTZV5Vw03QDoZJlNDJtTe/cH+XhEjNl7iCIbbkbCFscwYv05N5exrHJfk
	 iaI9GumWT9eSvbYUsP1p4+lfxN5z70u7/Ldtxwo7xq8mq/Pu3TLe7IJg/q2N6FFh7qQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494699;
	bh=68+I+X+0un+DVAR6atAkFZ76Upg/Izsq28ThqZljlhU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GMVBBlQYIdrVUCJ6ApO0gg0quVS8SBLMxxcVdSc2Aabwhx9NxthzuSKIeB93uaJHd
	 LZBSDSnXV7+KvwIeEaKJ9X/QgN01SzCL2hsmpnjO4kFCCFaUWH9gDnDLZ/4XRo4KWd
	 /Zu1vNKUYZg3H3SJsiX7wMJJbvlbkIAxc5glC1DqBih0sDTRwWKFmgDMF6nq09gMl9
	 RJgUjxw90ssgErEy1nbtQOfOAEho68jMtINhisce+huz/5zLsb6I4Z8At2MIF99Jbq
	 uUlIedFUx1ZQd00RDse7fgwcr+wDWB2egyyj3HL5N74uKTcG7/YdOslzLsnagJdylT
	 nsadlzVnsP5ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72F8F6082C;
	Thu,  8 Oct 2026 21:24:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF949156
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5AD640098
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddTdPWLBGwMZ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9F13040064
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494696;
 b=TKUOlMpR9gZZ1O17E1YsnnkaEkftNJ20v3VJqHIjhr672xnTAiT63SEfp3bR8h5Q+Hgf
 8oBz+8snwnIXCRwBuYAx/GyqZrWqG0XdtVBZoZjNeNX22qvDBTLX2FFJ09O7AG1uotQbj
 VEfD0Eyk6oEFGi7sRgs2li3oEPCMufNuyIx47UvyCMZDJsLdtjwy1rZl6QKHHXAVOfjRS
 SLtQ+JP3qm1fJ3keBrqDPo74S8A+SE4+pkuYc0cfBfJBz5ysKsV3xXjaratlhNFrqmn7J
 u5DUhptz8LrUXAm5M7iz2TtTM5GbKq6h+Qn2qqgWv6Nl9DaupwihZBCjvGtP0xl602A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494696;
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
 bh=68+I+X+0un+DVAR6atAkFZ76Upg/Izsq28ThqZljlhU=;
 b=L9nCJorSirS7QABxs+DDWkTUBbUTw8f5LDS/uQZX+FhwP22Y4DxwuSBqGILDFL0YYcGN
 R4tpU/TDnKbTHKPadwXh/oR+/xZSX8yD3mgoedIzdE8tOCCMEboyA6Dv9o4X3RhSNMR0q
 yUE15yXs6nb5nPYmU8yHBaY9kBdJSXIqfBO5FNNR28jR36xhjfe87itloU6QRl+4NTHhj
 6CwcIGBf8idLCLjuh+ruWpKKiECvCaSaxxGlkZJaoeHz/IHCFxcsam9n0Ao6jWW1o4yuK
 Au4Z/3Q/IMnYtHA91g+AJHV+El5xvilpOuYrGtqyzAs4gXYaSw8qZcjhWu1o+7P+aZg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ipljDCkm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ipljDCkm
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F13040064
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494697; x=1823030697;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=68+I+X+0un+DVAR6atAkFZ76Upg/Izsq28ThqZljlhU=;
 b=ipljDCkm1styT5hGIMo1XScEK8e6lEsJ4uIDhvvoEB9UAUV+8XUTVD9Z
 QTK4lpuXrdnFlHhNJgAW/ElaAcR3hMfcbSWvC4p7/Ypvms93U7o/ewSK3
 eqsSWuXSpDx2POqTLLB+8zvD5qJpfqozPzbzvyZ3b51tIEYT94mP5Jgsi
 vSGk8L5MY5u16q0YYf5/VGu5XJVu/b4NFKXhOBvCQeFT9gYfCYXnW7Wlx
 E9X0E1rew5FkcUOOn0eMWBa59NcCTawIrbCFDqy0rNh4VLf/qSPKwtIqP
 BVy4rXgqoGSKM1Pd+6ZF38nBx5RB+nFnZY8+1TZNrw7ACiTew1gRz/aul w==;
X-CSE-ConnectionGUID: beBPkDeqSh6AWH440KrN+w==
X-CSE-MsgGUID: RfGLlHiKSGKnKd15birz9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="184881"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="184881"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:24:56 -0700
X-CSE-ConnectionGUID: iShNuKH/QNyK/cdkKEzFDw==
X-CSE-MsgGUID: UXdStc+TQneDsSMt3wszaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="145615"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:24:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:24:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:24:55 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bee6OnJcvSjXy9RsYKqts/XOTYjq9D0qS5Zzu8coFbVVnaTMDlIX+p+utgMSsA+6NWi9AwYJq365o9Zb6RBoMpwnWj77diFHMhfniQR+ikRRG887EmxhSYaVHh0ABzzEeeep6UGSPj9IjDHcSpLILdh7hv21YwqcRQ3zU5Ubtq2dumNTTfCTVdtl1GPb46SAtyxrrxlIzIERp6ui2JIEnQ8yGwVXSm1I1hPHEVPg6Heg30afaLXf+RqGKhqjB95ThRngXZ53C0FULuIGPrLpcP0TIPRAh78G7LRInf83Yln6x0bTCGYlbPXo0ev7AaPjMge58PPlZh+tsmEDIlJWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68+I+X+0un+DVAR6atAkFZ76Upg/Izsq28ThqZljlhU=;
 b=Fb5H2sPx9SDEJMHJ15QTFGHgvRYoQhlqCTKoDQoqI+KbM9qdbdmVtUJPyktGCpW1EE7xwpQJNIQSKPsGKolGEWq3Z7cnqFv1aL8SySJdHsKLGMs8zPjMN0zjJVzs+zCNEgUBEDUW6mf4U8aoTy2qHtpcHud2sp8NJ5ny9VP2tUfguqRKH/JcABGiQh0aT2HGmoxoUJvhDQi5aJlrqID5iWYMQiVbuA4vEBQWVHrEUQLMFmGrCKqI3/8F1OWDTPm6M/0ULWDC+7pRwGpSovVvtxxJ2R3LGWPps+D0W7uJgW6MI4ZSpSWsr6jfPw1rfwxUbUd1osBGaAfLGML8U7dJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:24:51 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:24:51 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>
Subject: RE: [PATCH iwl-next v2 02/10] idpf: fill q_vector interrupt registers
 one by one
Thread-Topic: [PATCH iwl-next v2 02/10] idpf: fill q_vector interrupt
 registers one by one
Thread-Index: AQHdQfHUEdrytFGPUUWKvW41c6WlZ7b0UsUg
Date: Thu, 8 Oct 2026 21:24:51 +0000
Message-ID: <DS0PR11MB6422E6C855C7A7A9F561901C9B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: b1ba6c5f-dc7c-4ed7-abae-08df258296a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: 2K/d+STP0GYzxosYwfC/0r05zXpTE3My6f3EYfGdhOJMEO2NQTb/kdbNn3eTcqMNs/2ONzpG9smpxvpr3dIpW0onD1FkVRC2eLCTAhOfSPnXuQe4c5xtc6pzGRhKyixmtO2RihdC/DsUHhR+BRatpkYBI+BsoJBIU4jQUDjt6V3klO62CfnSA5nKqa8a0uWa5SS0jKezi+Lwd+Nig0gEzpsBsOj7jVzHlU0R8nRNuIbo5p35ZzLyYZKOTRTev5M1YsiElEHECJlH5X0ovcLELRXP4rtPBzQiJd45FJkan7+qNVhDD3gT8j870NYgya/6JZfH6f6nA8yLpzlInN8WNsFs67aTMU6fygui0fVHrMz7SuF2NB698mJGg1GqSAC8kTRd5gvKFthAJ5vy9jbNMqiG9m/ObJWR/6v6FoMf7iqd+n1hnZpJ4S/vwbS2Mryh++smgVCvMfcUpzmQxlqUNiq8Ep73DtFmcK+tYj3AhKZ2RG1MV0+MGjGAAmt5mJV+Tf6oQcBxjNahMioZXqi5c+zuxfRztkwbU5udmq5ScV9TAEdqChNWvzwI2HiuECAE/jp8zJn6VpFaKTh1kSvwSKyWBhJ8zhbz+yeGMAXmsDhfgeRRuqb8CNXxohV7ylgc8ZOtKyp126QtDYOv2VYeABIBIMaxkRbn8sz/udb1bN4cNM5krqA7H/73xOAFdsjprY/R2a1jx5VTc44xP7J63hrSTHm2KysFWR65vBdGfto=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BeKBlRfMTdurUym8qwD9SIYgRFYGYJNHnSg1knSGi9+J2CkERd0cAwsaey72?=
 =?us-ascii?Q?Dlp+4zNdk72EfFo7F/WFrGDs7iPdA6V6Mu2Hcu5PYdlLozCJnyfXaON34v+E?=
 =?us-ascii?Q?+Xs8VZKB8Na9SRirVI+wq7Kuq4vxJpgoyMEbCfp/CMFDEsdYBUTb0K8ma2JV?=
 =?us-ascii?Q?FdqEyiEPVEM58YUKQ6ZxtlXn7zG/Jhe6GeQSTuq5h3QA4ymPRk1RMCpd9ytZ?=
 =?us-ascii?Q?6AYb2sWJXB7Pd+XxQrcG0Tn+XdG7NBxehQLNYxo1cQkXScmArvabJ/Qd8Y0u?=
 =?us-ascii?Q?3WM83AHYSLG3SxcOPMqeBFWIoy/IJFMGij3htK73phttcXiITfm8lgBDvF53?=
 =?us-ascii?Q?KCoQ2xCEF1sUgt7eK+GFG06mcjMX4CPWcd+0fSggM0Q7VGcUhsZ5xcjEMM54?=
 =?us-ascii?Q?tAqsXSfk8qA8e1KV5fljwnss7+sWVXVVT3q+6qpBQMVcDp1siaZhvj/gX1qf?=
 =?us-ascii?Q?yPylrPxKu3m8syAMVvCptUVQc++D0AWaCTDwmhgi2gHzJCnjrvF2f97T8Fq4?=
 =?us-ascii?Q?unhxNBk3IbVtdNRjUgN3ohlnyfqMrA/0Lbzaq/YfEO4Mqpq3VZv/7o8jWz5c?=
 =?us-ascii?Q?5DOmjCLgs5MLzf8fzngeWFB/ZdvcouJMAbZ1Q3+jAUVJPcW2x3QpBsPAZGsx?=
 =?us-ascii?Q?jYyi1YnpB/NIxEaLHZBoQlYxLckqKz6cI0ylkLYG+zL3S8ggN239WCQ1wSp7?=
 =?us-ascii?Q?HfFkp64xacfa6D5pO9gZb6EhkJP4Qbz6J7ICghRrECvtLZbTmutfalnIbBFa?=
 =?us-ascii?Q?ba/8o0PCbidS5OPYzFOsr5Vz+LYEHonz9+3dY3G1vW08IVqaBD5yayXwRnuR?=
 =?us-ascii?Q?+o9dwMbjhHPK4jcjF8b+AVKAglli6I/YkZkNFB/UoNw7qDUM1jxFXu3cHcu6?=
 =?us-ascii?Q?hPHSuaVPgMaqp4Dyx1s/nXnyVt5FkZ9fwwBZdDBvpPMyKw0K9N85yEr94cdV?=
 =?us-ascii?Q?1GN9I9nE+Kgy2ikIaYrq1z6y1lCRnTEdI62Z+JM1CVDYwYjsZFlgeg5aExZH?=
 =?us-ascii?Q?T/T0I4sk9RmHfzvq7lIjetCg720qyhf/YEkZS0WoHws1JVsiMW9zk5HncWgG?=
 =?us-ascii?Q?bqpcOTVlOlVByWc0vl5RidxxVQjL9obO+ASgrDkI2yLjzqY2CNzC80fg+Vya?=
 =?us-ascii?Q?VDz9JKJndZg3O+V9JaCgYqDHYOuDvmIf4u1NPDIF0Fpdl0wQKF/cR0BPBYGQ?=
 =?us-ascii?Q?sybR61KG4urwpqK4X69XoG7ChgRwtfclaYRGAY8bL1jfGgXv+EsyuhiwPP7A?=
 =?us-ascii?Q?UmJKT+83gQmPOKi1GmKvENOpuSyz9FVjt8nV7KSXed/IZ22yhgKqRXH8fjET?=
 =?us-ascii?Q?MNp5U8m/LSiAMa7tqv8PjmOCT24wOkHS1jIHTRNsyTq4wRYq1Cz6aN1A+Wje?=
 =?us-ascii?Q?ZLKx3DeeZVANxlMBSVudAzVnwdTzWVQpvyHqpo+DYVv5zcRXfzFvkxMbqeww?=
 =?us-ascii?Q?ccEZsXZ7P8PtPqFtqr2aXgqbYAocGanwQsQMMioqKyp74IJZ7WYdOVrSFOLX?=
 =?us-ascii?Q?VAzBRfpQaaJFLUgCqquJUQVSV9Em34MEUC2M59m+ieUUD6aFtUFzOZNIQKpz?=
 =?us-ascii?Q?YIW4oW24e8GuhNNANlknky0N2Kj4jvbISkPSmnoAglhbZFRz+N95QnH8TqXC?=
 =?us-ascii?Q?RGP9i13FtUg0O1r2idWrH8Qi1Y/exr+nGMR/O/BrMVckO2h1C6SJSsSsJTAB?=
 =?us-ascii?Q?ezKDqeGkwow2tEadeBKowx6OLK7CDQ9ba2ZwzUP4QB8pVy+p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rQ13b1oGYWlrvz/L62gSaVISb8ku7iLIUnF1C6S0cggbbiMUdlhD2WmP8iIPJPH0D0HLJD3MklEnGRDL1FfHuW24Q34Epouddp2//vElPK2XDl93H5mRJ9kZ1IQZ7OVYrkwQhH8mtyEZYTBI4mavhJie28MPdICho/E/YYZrf12R3vYo2WyhU5Yu3Ufq/vmBpZvLAGfXfDr8xfh9NHEEQO0TTKa19rcP2gLMbxmvtPR5mH6yfgaMBi6+dfHx7bDsae7m4zqKjRubP8xGW+s2BHmNUj3BT+v1mb5FXnpT5/j2vDORvkSgFpMdb2CKnoWdt+RESbdREshydYqqGedlHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ba6c5f-dc7c-4ed7-abae-08df258296a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:24:51.3070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnbL0QJLWJkN35Khw5IVf6y7acR8D002GDzI+Lx1bJZ5BXbeHOideb8/ZZH47NUmA7kyETENEhmZrGr3hq9twg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
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
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>
> Subject: [PATCH iwl-next v2 02/10] idpf: fill q_vector interrupt register=
s one
> by one
>=20
> Most structures pointer used in *_intr_reg_init() are already used in
> idpf_vport_intr_req_irq(). Use it by rewriting *_intr_reg_init() to fill =
one
> q_vector in one call.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
