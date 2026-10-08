Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A177CA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F6C440757;
	Thu,  8 Oct 2026 21:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1AoNbunMe_c; Thu,  8 Oct 2026 21:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C067E40758
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791494852;
	b=qLRE9WKm4wGcqOied701LSZzVabdytUkzZCy9SwFECU5D32qSTjVF+OGuFhAJxLPR1vO
	 uORu7vnqX2LJyO+v9TnDvKTqbbAToCUXehcF8wruAjtevY2a22daKYAZBnFsL7bSkh4p6
	 +Q6h5wU2v4yLHGhWn5cj+DbiSFFzOuG8KWjDXlid+1YdHhdqnH+DY4LtKUZnUmYHx/oIL
	 AbV+CdYPXJD5NMI4nXU9xRfs/XjD3FHogrElF8tzjj0BMAIV3VOs9Z0yxUFbJZd/Inm7P
	 EbB7kDQZUIiW1uWpUz22Lw+kgRZHFow6zQfrP6qfnyAVxThXUgCczNFU3IqiX7eRlDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791494852;
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
	bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
	b=HJYRuyknPKcaeSb8d1xXYVMeCeTPjrD6p7PJUr7VSf1DFV0iuJUcCBwB7qZn7JPtaF68
	 oi5HUddvPmDp7J8kmX0GhH745mrSURoBFxxCbHUIzP7Bk+bAzCyyrdFP0eLinHl23f7y/
	 4ncOceRRmRsgaOu0EXbuWUf1rSAdN8mhE0QdTjM00yAvX57B0lyKiPGZ+o/4ZOl0Dpdp+
	 YAbjC8XVJIxCQ7yDYptKsxwjbFbFefwHl5VTHAF86mXvewTCsMySUfsWipilW0UqoWPD6
	 XRZOXFVsNxRJKxk+vyqCd5SVoVs2zDYtJexUc+uURdLHkscXCavyO5ZPtVa3dm34DJA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791494852;
	bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9PxtJaht0my0NmflcTftfp6sEnQt2pCHD0l+oS4WDLdI0uRXIxKnY3ax46S0Y63Bb
	 YjAk+bPlhXbZ++/7YXyQAc+cgChImFwUNulLrsOvxpW0yXjZhxDVmWZvpc/u8+K5Jc
	 o8ebGAJiiVEwp7XWB+ybW4lm0WlhdcGNhW26WmiD6xo+OCTvQdyQBxHQwEPqndBRif
	 uKI2WgSiyWTtMR7C25QlA7/M8sOWFftQFdyEkRK5tOVYc0zWSxjeTHLKESx2NmZbkB
	 tDRoMbTIz924jq+cGjFqPm3OLo2q+P8lBY5R+6Mt8AsaqyoQWb8d5OJhU+XT274mlM
	 A1lEHf28PlF7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C067E40758;
	Thu,  8 Oct 2026 21:27:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C79492B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD4A160832
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isOKOSR8CqzF for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C37006082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791494850;
 b=nWZdcj5tl0hWZ1X0lgiTOy8TTb6ZW2Z460JsTNwZuSxGPDERWLh4xn8jzzbgqpeY0xPY
 KxsFLj2tKG1srezqmNtmInh+ZV90+lGQsf0cfyGQX6Po6jHIPqjm6BVXSXkIWc2JOhhqL
 vgbeRJ+SLlnuOFs1lFyboTGLNid9dI8PxNCFI8eciIJ2a8N0AImN/DUhfh3wLaF/TftMJ
 TQB8zaalxmArBgmBpag7XK0WeDTDQSjQrXPO6JwUCIB17Syyb9Ojoz8o8RHS00r+6GZRJ
 AtYxy8uvT1cjvsd8jA6bqoVuDIBGIOiOYS2eh0AuAYX1aXAbsbpW9iSxqVlIAarFzAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791494850;
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
 bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
 b=bC3Qe8wn8n4xZaCO+2GDnBg2VM2+FDsDh3iWUxOcVr5x9vGoulW/6hfGiCrA++9AgBAT
 /rO8Lf31YRZ85MGCtpchmiA0bZ286eO1am1JyxAxJ6wg1Zc59VuRemZ0Z8y5eXbXaTqz5
 vRTCYfORIfRIrl1Z8vvitWruSlxkwfDhND8pGuzbNc+ngt8BpDgG+DRkoWevSJYn7sRTP
 I2boEPyC8wxvoIH0SNAnaMM7mn+2ZFvNqa9MKs52nf+pHVDGyOrcGmwTD1vvy1fElal6K
 XHPhsnbo1bUlfq5IG1Qn3NKX9GSKZdlXOq39d8uXd+OGncNfTwvvbTfQiLctUwrvomQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I7MrXn0b; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I7MrXn0b
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C37006082C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791494851; x=1823030851;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
 b=I7MrXn0b2agPIDardyyDsrWoM01x2Vh3IqcAMDMjZE+xFmQwgsjq6J+k
 ZIrf7Sj3TUANnOQPgVUR05k+aWX5yYk5aOf+bngsSqMU90w6160EjV9lh
 gkigVhEr+WCSVnPA0VBNCsJJqVUvIDyRl5vSGX151M2YtrIZDUhmWS0be
 QXJfgFmG+Ut1+uo9qThRbgiXkdWl6OprkL2liGziuj7uhr6sq6qMR2WB+
 QAf9GPF0yfYoPuE1RAqzP4GKfbWEwW/7u5zsHOqterbWcCjPEweUYSPrv
 0ilDKtHJOJs+nE9S1j6mFafHfBtCup0NbZJvmK5xLe4/f21ys1xiw4ayh w==;
X-CSE-ConnectionGUID: 6M4GH8hIQIeBF1niqon3tA==
X-CSE-MsgGUID: sa0Z+SdWTc6mrCkKHapcrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="185151"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="185151"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:27:30 -0700
X-CSE-ConnectionGUID: TRQTyy09RNaz+qrnu7D+Wg==
X-CSE-MsgGUID: m6QQK5OMSGyT0QBZOFfovQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="146339"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 14:27:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:27:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:27:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPmg+U1LqRj4+pm4a/C6UF3U+8bk9UOpzADLjdHP0jsTXtZhZ5XK5FtB2kOceSdtV8kzk2/DzWc98nXC/sKWgOMdCLjqnyXH6XXQGYJN0YRl01ofi/KWbLHET/fv2Wjrbsup1LdLDM1hs1VyAk0Od8FfCqeMihbpMiLqZ1ID8tQv3Z46ONiZoRH+0cd8zMG8oTDTwCTTftD5nQJp1+9Px0bXBoNSNe6I2bTVLaK4JGphWB0+2522ntW0d5pO0pqZLyc9t0oEhXqaNOFEJFEp+F795+QpGw/ruhnPtdNFOf4AsSTBhc8xhIaND26U2JCnmD9lSG3U05rZpSA6SWuW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
 b=Qm5JanB3uesTlqS2To2oimt0tuEPXegYZM1gPVkTfd4ljOetq/gWh+V0ka7acXI1J8tJeHBQ1iJX9Xh2pWLnHM2GNAFqZ0uQW0R6Rysn0TgTPRDmXPg/vHDHDzk3+wnOaeCCeQiqkeDCzmylJRrHqQa0cfnafzQkovHfD+nIx1ntMcpMV0UK1ZxAVKJInKMaSUlZo70NwYzpMemIvr89w+aR7zAt9pNTK8epovj7jsEcSbktaq6brjzaQyvGgvr1crw7g5dQrtxu1tUdBBPpcVlDyVUNniDDv49/5EULG+XqJYFy/r0E7mLlxBRiFmNBtP8KEeREsK79xrOLwLq52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:27:26 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:27:26 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc vectors
 command to libie
Thread-Topic: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc
 vectors command to libie
Thread-Index: AQHdQfHWkceWDlGcHEObybLOtxAb9bb0U58w
Date: Thu, 8 Oct 2026 21:27:26 +0000
Message-ID: <DS0PR11MB642219AD185407D0B5FDFBBB9B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-8-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-8-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 36ccfc21-c086-4a02-b644-08df2582f2f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ANKtsaM9ZY/FeGtXZvaWjAWF/MTYI0lQxbJD0bQDY/KFtFwLhjppixPBsWzgvujp3M04PhKRqwvnLdBiNhoGscAXG4D2nyRScnTqNtwl6TuBTRKvG9jzZ2AxGROS3b9SIXpjmRyPu8YSy+8FLQjIa1WI7mBotiqPwkHDFfNowTwx1itT9dHYkg8GMpVbQZE8J9Szz5n2AQKByHO8YEAo6cL8zcLWpg4ZCqFbTYpXj6G9IsxJOCyczbKzmRghE6KRlgBGp982bJRYsSYSlPCQmJ1bvgXHf5BAxESUrfgdu3YcO9JG9PwYO6CxNwAzC5S8XlPkOjekVrMShO98eO8YRI8z3QMDCYxCoA9uB0O/OI5gqECkZ82qqI64sD4eGJ3dofJzYekgWt1W+ieIfpG9FiW9APzejjci6KKOC6J7U+KUci5nfC8lhMH9CfJ8Vet1dSfNq42w3ZenwjgzutoeZRlyfLJWq8G5RRK4bTiCcf5B5zrOhmv5B28hh0USdng+zWv9RaV4iFGEzgLNV1flUxejffKNiR9MZtDJt44mdvBVmTA+Ijvvyt/BJl/AbFrLHPmAIKhpjeCnpia1crfjtGWXXJDmpIFbVK7PhRpeAWHq4OIackijflve4FTFbmg6RHhMkH0/CgItzjex2nuz7qpIvhnlOESU/KjU2ocgNNn3TWcOP1XmI4eoinInPMuSQ4CZEi3KtG0BuEcOP87yf6Y7I6f1atnLuA2r2ZDBJvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6422.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYPJd3YgJLxUs3VPPvNm+ApEGJAcSKyyc/Ej/cCRR4qshSZFA7w2P4FIGJaY?=
 =?us-ascii?Q?iHvPHmCBuA9ZhlE7TD/9vf9QsK4SMaGDTjgFa6n+PdMUQc7HvHqPNWrXe0Iz?=
 =?us-ascii?Q?0WcDDgSGxebvoKUA++BhzXoV8Uv/6+EmybXUv3ZJSlLvx7b5n0VRHA+x1SE1?=
 =?us-ascii?Q?+uPBN0jAxUBqk6mA+mwIQ4bFaeWGlw4ee+kFF1dHBcwHYdNgx9hBGUGKYq4m?=
 =?us-ascii?Q?Q0MZ0JGwvDJ7Qhu3twSfRGxPeo3tROqJsqoeXrSVE82QvDoIJaEua07XVrWB?=
 =?us-ascii?Q?z4o+qvZBFrU/M8ye+a71SJuGThEcsVUC3PZcXeCkuCA9juNVGifwzSwLh9Yb?=
 =?us-ascii?Q?q5CLrgR/Mdxty4k40jxSuxhhdtBAjLBBiw3oJsTybc5s1/LGeh1IU+g+yV3c?=
 =?us-ascii?Q?621X0F7hFoxKyKB0a8lhz+1AW20zdYxuP+HtZWyHjXa7Nfve9C9xh6d4FMRu?=
 =?us-ascii?Q?Ule4KwCGhew57k36mpUmmdIULV1t0+lH/j3jPs7+VRcDKsCzAf9Iv8HjfMv5?=
 =?us-ascii?Q?RFtWm7Rv/Ofgmr0fTcBwqESA8VCQURFFVim/TnRC4fwrkUXecSakO7FjBy3L?=
 =?us-ascii?Q?8Xxs2dltqydBHPXlvR0y7BVEOkMPXtAyonua982mm2cJ0YlE+cHPXXmEtiq7?=
 =?us-ascii?Q?+saAn7kcyi8aey4i+hKOR3iZlGe8yzmAnBWZ0NcmhABDCafQq74wIVlElrjj?=
 =?us-ascii?Q?zhc2ESKEoCybPINfU2u+o3308bsUmy1kRSIyfV6I3U/Kc17YceyShbBvA8JI?=
 =?us-ascii?Q?tZPDDDLXsKRR3KFx8vZ5a83eL/QtGFRGQnW9Okwqd8sk4xlu+VAsu6EJ1d8X?=
 =?us-ascii?Q?oOh83UImq+PQ+w7PwAyahYmPMeIwrZ6d+ZA+zc5bVgVBo5bFO/2+RVliEbtN?=
 =?us-ascii?Q?Rn5Lt4h6XXtHKvkNp+w8mn7K4Sh+KG4Oo9jKmPC9S+F1gEUFG1hd4pXp8TAE?=
 =?us-ascii?Q?1LyX9IUFs8IyHFpPOtoxGeYG+K/zQaIhozYRJkn5OczMQ1wvylDBNQ+UfvvW?=
 =?us-ascii?Q?tWwNwAHN/L4ElnvaUQhrFZxnmVZDJKST6lYe5ZSDdD2T2aPX1jsa90AOo3i6?=
 =?us-ascii?Q?DszaR2arNtcj1HIVjXMcYuECZOg8AmplZukdqrgr7BBii71DvZbvyj2YlTZZ?=
 =?us-ascii?Q?afq8sN+WasBlZST/lQ/2Fx71xN6IzrE1dwrW8QWiWOoai8/N1E6z7YGETU63?=
 =?us-ascii?Q?Oz+R8gxeS+xm91unGbM0rL0HuBDvRwnTC2YEq8ztjRM9AeZFgGNev62VxBaI?=
 =?us-ascii?Q?zNCUh1QYibRgxme0y/eEsT1QwltMg8czTRadd3iYD9zeAQc1ouA9Ajr1TRK7?=
 =?us-ascii?Q?sXcMLqBafRCNHczSRLGqXs4V6v+GOSD023Qw+8J4RauOtP+bXySBM0Y/FlD7?=
 =?us-ascii?Q?mvwBuAL+XYKkS8qA/Tr72W3mxHbPyC9/Q7Fq80QzW4JoSeZjoM3K81O7OzLe?=
 =?us-ascii?Q?QeVI2Kiw2UztSROw8BMN1xFL4V1MqBYKC3wSVr/6jlOdVA1lifAvPjL4ApWF?=
 =?us-ascii?Q?3+fITBOAKne63dNFZ/hHNP8gwGsH168mzXoMnID2Zvk/n8EYo7W+pE22pS3r?=
 =?us-ascii?Q?1NSojin74Rd7FkWU0aQVaoT/KM61ZqMfkpukYqVTO8q9JQ0bnvsVwMEHlKkg?=
 =?us-ascii?Q?+Yx86GIK4oAwbA9hu7lj4fXOKtITvLhqzNQc+2Cgyg5ARAXDtTcEBT9Z0/JR?=
 =?us-ascii?Q?8Dlpq4dZs34ac3ahmNEiRAXOAPwCjiBrgcN3TkBufJP7bPwY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gWBDu4r9vDM0xBn6Xoc+F+E8I211XgxXukAtd/rd6ihpCONUnk2MFOdGBOh/2ohiMtl06gYbu4Yq2ukup4FgpqyphVigYXme3lY9mmNCQK8YxjPJsx+5FW/jKdHu19tJeLGevHY7DRm/XIkqRsAtD8Q5eXH3AsCyz1ZvLyBkWOLnW4tR6Djey/zXXVGt5GgcTP6gabOaWlSLrCOHOIvrrWMpPB6C8Dwlxi3f8lK9ZNJubY2EoP5vmCzBJF/nwECVTHJmiyQU2l3HImZlK/QdRHkBkZF9Cj6hk4/jWj0jM3rc6iuV3ryuy6g+Jpy554/wZDrIjuw+ukSI/5Ymy/dn+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccfc21-c086-4a02-b644-08df2582f2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:27:26.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbV0VvgdVPg7Kzb3eAd3m6heNwgM9cm7eFyIYvXWlxU+5nekbRa2m7UfVNEsTWtXtHM2HgtaWoIhlqoXVeDfJA==
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
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc vector=
s
> command to libie
>=20
> No functional changes. Just moving to make it available from other ipu dr=
ivers.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
