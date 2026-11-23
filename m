Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AD606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qJYq0oje;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VngbxMfB;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JT94ltwm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A302880DAC;
	Mon, 23 Nov 2026 07:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uszMUyAMGi86; Mon, 23 Nov 2026 07:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D363F80D9F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795417645;
	b=hXnOvHPCI1VSjASJpjNpJ5RSoMg3mj8UgdwoECp8uSvcWJ8wfQeq7cK67UXpKfA0m1nm
	 TVdIvDaUseBe/d/UagFGMUC3FjzW+Gwn0eo3oc6ok+HmsOriydufFuqUifQ3tEgu1gw8p
	 brZDrhvK3ThQ5gtKxmxVVmHDAPZ8t8n9uBMGsYxWJCRu73mpvj/ppJ74EIr4PpFX7TFMz
	 AfpKla2xGvU5aZu0d2Q3m8nMY8a9cjhvxZLaW1uKXjJptHyCgeNV1twtnmD2S9lDB/D84
	 vX9o13zy1JFduyQvK/+0rLbPIhRh7B3/e0AcsWHo1wK1yK1QTpHW6GdMI3bGLlAOMVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795417645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=EFJTaQPMTAwo1+MgBf0hxi0E1uz9F/uDOMDS10Sbark=;
	b=HUeZBbkJvEBKdrTq9ihBYiggTBRNnZMZWsA4p9eHk/8WN+l5MIdI2ljEA5SrbzT5PxRv
	 yk+x2nVAvrHV4av31tx1/TPoG1oCXZvYyAlbgEsCp8QewnJogZcxGkAm81EbbflbTY/Zm
	 FE1FfbT6kXcpCWwRTc8ILQZnwNrbTjBgq7UIrLH2whd1qfBLw6SAqBKwmxP2qgBCB3anH
	 6gcy5V1bCutZmIOAkrQXruOierElWdWcDJcboOS+KFE57B9biDukb5wmvrSnbbFXY0n1Y
	 rE6iDhALMShx/pXiNKVtKVTBrt7nhWuggle2tzSE147JlCdnwjL3kvmIgAlWU/HENeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795417645;
	bh=EFJTaQPMTAwo1+MgBf0hxi0E1uz9F/uDOMDS10Sbark=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qJYq0ojeUguOa2kEZKll8+CKYQBqqT+87byJAXhRbtIcklNw7DzxTV4tLTVokMwH/
	 MPtmdPowfDBvSMewzU/UkdLGjrNg1znbodXJG4LNEFwLdoQPD4ouZQJQvAVVSIP63c
	 f1UtK0lglW2zZqNWiRBYV54E2/lD3WB3muO9OPAwrxaJ8f0LZ4kiTF7zmma01W0Jdu
	 AmoV4BDOwV3QO/uerFcuGODLh+lwTpI/aLEkijWh1LR1BvgJtc3k59gyDfUYJ4sSKA
	 zvpLqBrJXPpn9GcaAE1rRVB3yEHDHCrekGolovhJKmXtOfXXjYlP03uCMeJGXtnJ4i
	 6pk40XBhZfGbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D363F80D9F;
	Mon, 23 Nov 2026 07:07:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC613310
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1B496068D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rdRKx1QYPUz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 07:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0B096065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=ayush1x.singh@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VngbxMfB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=JT94ltwm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0B096065A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 07:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795417644; x=1826953644;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=LPtzwde2U8EtcUjwEELo1ZmzGYkOha/2w5xKYMW9dOY=;
 b=VngbxMfBSHLApuu9XEMUvHk127cT1WX4EFYoY4ISFlPr2HwXEl+z+DiC
 +uz2UZQJoE2gxaHKUC132WyjaEeGE+L+AqqQCHgmwUURThnhN9s/QwkMp
 SEdwUOy0cDgMON1PfByk176UQgE/LCM9eZOAzZlpEs9vb7GJE4wsO7IDm
 geLJ1GVv7IE3+R3eRzoli/KeQph3vMvJSibp8B0yVAvQ1MQZS1t/PE+2M
 lYIlJMPEdNL0BADXQDKSqFZ3n/kCdY1idcKVHmILYpX7ROVErTsRK1egL
 pM5m3UOB1gYKmjo/ZLu2zExD5uqulw7sloVAFux/QBUTVD4zKMmNThFJz w==;
X-CSE-ConnectionGUID: IthFTSRUSLSgLnMBkz/2Hg==
X-CSE-MsgGUID: v5hSDVoPT7K3RqRLQVyYTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4303295"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4303295"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:07:20 -0800
X-CSE-ConnectionGUID: aeLhd28GS3qKAgNGB+thYA==
X-CSE-MsgGUID: ZTsgQaIEQWG471BSWS2/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11113341"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:07:20 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:07:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:07:19 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:07:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFJTaQPMTAwo1+MgBf0hxi0E1uz9F/uDOMDS10Sbark=;
 b=JT94ltwmhkkGpfNbliLWtdLZBvyOCxlNCeXOZV1+jjbb44dDvXQKtKC+elQjeCIB5VcWBJyfeCQ/rsOULII524YOocW9Kh8yegxVxjh+CCpu75qDUKF8kAVYTdn1kU5ASuGAgntHnjvsuKDhoXoZTeW+tIB2J50cjOXtGnP+CSM=
Received: from BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14)
 by DS6PR11MB700629.namprd11.prod.outlook.com (2603:10b6:8:469::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 07:07:16 +0000
Received: from BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4]) by BY5PR11MB3976.namprd11.prod.outlook.com
 ([fe80::c23a:c952:eb75:d4d4%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:07:16 +0000
From: "Singh, Ayush1X" <ayush1x.singh@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH iwl-next v3 5/5] ixgbe: Implement PCI reset handler
Thread-Topic: [PATCH iwl-next v3 5/5] ixgbe: Implement PCI reset handler
Thread-Index: AQHdVXpa9Y3CYh56KkKf0raUv+oW27c7h5NA
Date: Mon, 23 Nov 2026 07:07:16 +0000
Message-ID: <BY5PR11MB39768DAB1949A7FEE809284EA5452@BY5PR11MB3976.namprd11.prod.outlook.com>
References: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
 <20261006094534.418657-6-sergey.temerkhanov@intel.com>
In-Reply-To: <20261006094534.418657-6-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3976:EE_|DS6PR11MB700629:EE_
x-ms-office365-filtering-correlation-id: baa553a0-4d8b-4acd-0c25-08df49306855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261021121427099003|261009223027099003|261102123227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: GdmfuV1ym8oO5LZYm79rvMOU9jf3TpvhfMbaXowD7VaS+JNnCe88A6ZqNb9ZO06ciizUJPTUAM0rA753l4F1zE/hkFDOMflunhsP53uYTpic13Khb92qqcTeeLypc8nrnQOlj2cfHRjqEq44WxY637cNYP41RkJCAWT0jdN/j6Z4qWQrus+DDIwsRgP8q0qFn7d6vlG1Q64HRhW0rnClhIGGeghDeS9ltWjH4z41KhywEHiSKpyV39FptyZKlDA7EMjm0pfW/jsg5akgMaGVihn1ZdccGJGt23VAIBb3x+9UywQxfXfwQS7Kpb5SKEXU/WLR/3UMa5hpQYPKXpnrg31kbhXsCaOQSsqEq5fxlqgP6PMZ1/yLYvwlp/3dCg792DxCkm5iouTQoTOmjQqNYsK1gW7NBZKtfvc1Ejj8uCqcUwrEjwaj92Kq72hnIo+h7Vev12UaiTfCFtJQCfbNl+VEuSQjn5I/5z+LBrQnFCpeIIP3FXjl1XfA7XnBpxw7WcAxxyRROMGqHQBf/AYIQJzwGZBE6nchX3UvNDscLX7DPsf8mowhLTTRkjqC+48NAZDk1LZ6lFXmcQ3zboJKRmYuxBB/2XMvsM3x0AL/itlNWyxAeI7BQuERcw+2YynBGE2rr5qfs6R/yyHRmsEI8mhFTh2edOTFQ7mg/ZZTNOS1SpJXkR09vszW2b6SAl9b/IRI80/j/hMKjBo+KKfuwBekCVY8PuzApgDnwlwBbJs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3976.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261102123227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6Cv4jnRQQkmkRket/CXTPoxlkKZZkaH9Xx0zoO9b+WvObUEFvlK1rFgiGeS?=
 =?us-ascii?Q?JFRnxf/olKfOE9EYwFnjn2OHij4v77ETHY2GW30/u7iCKJuLdRW2SDSGbAZz?=
 =?us-ascii?Q?bxyIbHerwJPBnHu8izNZf8eSLiVrFk6/cyllbFPgEwx+pyBz85lERNdMtjex?=
 =?us-ascii?Q?O096JBy5EMbLCbGmZrTkWdLBJ+0qehYG2Pgzw2gRdPrdONa+JGFQThvxgJLI?=
 =?us-ascii?Q?RcMJ3Cdv+BecWTLw9dq3BWqQ+1+csP+riN9GNmOlCJ8M8nCtSt6f93dWUMZn?=
 =?us-ascii?Q?IXR1faVBj8e8/2Sx//j/96noY3anj5aCzZL7IMK1P4MRPKTSQrF+ElA2X35R?=
 =?us-ascii?Q?iiZ9cIGbpMQPQ7wUnd6FUp66+0DavioP8j4nNSKZYhtUdvg8UHTIEk7DwNR3?=
 =?us-ascii?Q?7yIS6uMLfWoC4yZHHTT5vvhPrLZzlmF4phN0bj0hJr49ePyUzyjOgYI0M2Hi?=
 =?us-ascii?Q?ec7LnyBJAJCqai7DeX029Nb+DTyZFBT+rQSkHoYb6PEw5Q4EEYkT+qfmJfRh?=
 =?us-ascii?Q?v5yq8/nDaVwEnTpl/BgL5woMtdTP02Ya9s/4QMqGC2D0Bzr1blHHsgLv9CIS?=
 =?us-ascii?Q?ynTJg+vRIZQrEB5qjc+tzHFKsJq3AHTIbcdnw2PBIjbaLJq3605zt3El2U18?=
 =?us-ascii?Q?jyNgzJJQiK4pK5nOhizzeQYlHsJauXY6FaE980LAk9a5dCJIoocpZkNuJV0h?=
 =?us-ascii?Q?Kh585HTH04bRXOhRXwK2hRY9Az3o/qvtYBfoEHeF6i2iKAKNUNJsM9fE2K3G?=
 =?us-ascii?Q?VY+s+faPOqh/bnpFMU4I9s2OoY/wTTpV5/2/xUlrvEe3aW7UMbTdKGyHYjGu?=
 =?us-ascii?Q?RAweldxeYUHkCG7wawbgzUe1osqF+73m2/jRC7Io1DVFUNpGsZhBZFlXkgdE?=
 =?us-ascii?Q?BtHNnX3FvT5+Oy/8EUZlMV00tc0Y1ZoPqsBFW4sbLG92rddvv99Vd60KLtt6?=
 =?us-ascii?Q?O3eBmArBjnuSqQgPQLhBQjqHRALJHrvYKFNwAKhiCdSEBf2OJVCJVXRFks5T?=
 =?us-ascii?Q?wbCmdSpSRkwy5yxn/vj93NDFLL01HE0L8mMSOH64OefXQgEa37QTbHfx62ui?=
 =?us-ascii?Q?XdAPrE809Yj+5DKxioalvltcSBimL9Q6z+fPAe0OTwXIj68sMInXjqCJwY5T?=
 =?us-ascii?Q?crczj0cUcVmMQlUMFXziiGMqGQLr6M6cklLlsXDo3svVbSveXfWI1yrk9mdw?=
 =?us-ascii?Q?6/VTwDRlb95n/GP2sw3NE08+2Od9naWGW6tO+Wuj0mApCCWBPnNJQD9A6bg+?=
 =?us-ascii?Q?ZU9pOMlwRJ85a96y3tboqWoZMp7sfaF0ynYvETuVcvWhZ4/y1jScHer5j8ZC?=
 =?us-ascii?Q?YJ2oZvYMp13NMAk6UMpf/QiF/XlziM6rOBgdog/4kALqxGjFt7yHS4GgIesF?=
 =?us-ascii?Q?N4RXMRiNqIAfVCrW9oinWmy/iVDizsoBeN4UF6eBVHH57KyfH+JDzka3+zpy?=
 =?us-ascii?Q?IQ0CDpMzkWnh69H66VMocn2mua37WP12h4cq3NXaZA03BeYwOZMNrLt5QGM+?=
 =?us-ascii?Q?lGb3KMGgn2CSirBdKCEv+jv3LY8zL7eCmTVMZP7PCI/Z0zMKY/tRbbD2uEfW?=
 =?us-ascii?Q?tR/m8pCeajAMo1AjavTh/tI7zYsiD1taTld/xtnmT3EDo0d2gIt3QTm+hXBc?=
 =?us-ascii?Q?uhNR+WNJUOo7ptLhH9SAHyTijPXa9xYxgBrq0F3o7lqE76WuIqx1MNa9IGsF?=
 =?us-ascii?Q?71s2abdVCn6sKDpTfTa3YrcK1xTgolbNhdZodLqL3dj6PgPOph9ruCJkUvOo?=
 =?us-ascii?Q?Yts3XJvi9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QlodoltKINCNe8rK7itfNpTgC30OMZfAhZzm8rwuNsFwwkp33trncFZR+QhMiTseyjeC8f/jK8lXXP7YNCwQtj8iWCUwzJmb2/Tbrkp4WvZ1sw0ZFApf54PX4g+PaMpB+i2qvdA/v1n3k/Wj5ixEeF0zGq8Lph87dpyJqzqDJ/JtYDMa03TCPj+5q/llh4toAK1kizeRq7+78Hk7fpi1ViiFT0KX0VphjzOqxRQirzeCNkElY+6bNOZC6fY+mlsmQ+ZJNAmk3Huw8XeKM1oABgVP+mmYseCuio7rDji6iy3onX4F/7+I2sDqSagtk0GcuI2gwthrf2XdLlAdGG9rOQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa553a0-4d8b-4acd-0c25-08df49306855
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:07:16.7225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3ROdkmL2kQZq4Qqanvoj/YgdoPu5emLpi7oMoBqDNA/HLQncCarJ7iHIeBp9c1HOAWeKnoJZtvmubtSmU44Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB700629
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>=20
> Sent: 06 October 2026 15:16
> To: intel-wired-lan@lists.osuosl.org
> Subject: [PATCH iwl-next v3 5/5] ixgbe: Implement PCI reset handler
>
> Implement PCI device reset handler to allow the network device to get re-=
initialized and function after a PCI-level reset.
>
> This is necessary for the adapter to avoid TX queue timeouts occurring af=
ter the PCI reset is performed via sysfs during its operation.
>
> The reset codepath may trigger a number of dependencies in the reset of t=
he driver, so that it is necessary to check if the netdev is present and ru=
nning there.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 111 ++++++++++++++++++
> 2 files changed, 112 insertions(+)

Tested-by: Singh, Ayush1X < ayush1x.singh@intel.com > (A Contingent worker =
at Intel)
