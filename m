Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A3CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 11:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A9A54058B;
	Mon,  5 Oct 2026 11:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5_hRbZHEbUM; Mon,  5 Oct 2026 11:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 82F9D4059A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791198811;
	b=GmUOTaVdrsDcP//LAFRbco3TWf9ltr3fRQy5jkSHHGl7hFCWes486Q+y6LtZMOF+xSjC
	 MjuAizEE7ndSGHgPa1ABNKcFfCdPn/rH2XPWFdC65LH3HUW4QGEFM6eFXDT5rNAHTtxmp
	 jbDS6tp1fQ81zJG1oQOJWjPUZlX7SJWBSX842hoU1HruqLEXs1Ko8119d39dEUN49rpzr
	 oeXanJ9uOt0TWY1vLYL92ORFNSF+1yXdjANS0jqDvCZiE650f2sZg371swcWzu9HM9wEP
	 2nJjiFx366mppnILBH0T5d2XMwyAzqAJulCzNyyOPDiJxeHh39OBVITSThtIVyVpFqA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791198811;
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
	bh=K4gzkwD1PF4/Sy/+YolTJe/WdbvybbQUJYRDpYRj+jI=;
	b=aA6yagq7f0n9YWHaMOvOEVWzV2e/4brsqO+vO3EkW9Zp+TvMX97x4XSAUvGBEXhv21wA
	 S56raZi8E1PG/DC3MHld1EY1ZkAR5agh7EgJByWArI4bGrU0yCdcpwwf/X9MWMXNgeIhG
	 FB6JfIyZGjFV6vhcAp4ys66fMlLNYFUBV5A8IYz7QH9IiLPHWJa+oS2wEYX1HxC2hdlL8
	 kXnlyPbmJr3eQvhTwEDDwAt0ILfFtdKKk+4Uv7cfMBD0rIjLjsD/mk235MXdScDRvtQTe
	 vx1oZdsZe8wxrCUQ7sPY85xu/mnysZ8mxPP2SCCTIf94OuX0AdaYlByB9tMIEXN5YEQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RzsiwfyL;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791198811;
	bh=K4gzkwD1PF4/Sy/+YolTJe/WdbvybbQUJYRDpYRj+jI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nt0mK9KhVymV6IVIiYq/lydLX3Wa5Bae6vDklL7Wa0ZERD1iL6MpxZJDX7eEtPFeo
	 +DTA7B6e7zASaiNdMVvXrhOzYZtvp+eALHt0ncal+JZgGSe4XhDCD+P4c/Pke9WJbR
	 8C6Pg1S3Yk5DKuWMiN9rd+xAIvjg9md52J/peYzoPEocOAL6yKggpPCa60bGwSh7PQ
	 FwtjxGp28vLYH/xzDOXdWw3Byt7mm1k1bAQrWE3yD1iEoNdTwULgA7Zv2Idw+J7kqZ
	 XH/7Hb+TNfui2ETlIxbvR7O7Xwttn1T41otRYdxVa7t1wnwVn5IvrWZwweaaakvzWX
	 7eA89m4IdTWAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82F9D4059A;
	Mon,  5 Oct 2026 11:13:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B45301A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5C484052D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Y4MzY1OOGWm for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 11:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ECC7740521
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198189;
 b=qHP+FxS9p2SlsZcN+Fd8AGXKEm1xavNpOfuI54+u4ABz1i6qc1IahnxNFx4UKz8sS4bo
 xmVo2Mu0EurmZJND4RzBuQOchHmzcKON8fybMMq08jlVLDJ29O0tYz1CL0KuNn+WdTLuX
 HL77sEWNqlEVEzPLIauTGMk5pGfKRsoG9GAk/LzwIwgC0xYMTPS83fDvXTAxhUvz79zOI
 n9cUYfftaiVkLlbtamVYitEi1as3LKx8mxYNnwhjfAvVwPDJie+0s0nR34tA0rUIrE5ik
 9+23jpgbbYOwmy6KGNdsSr4IyJkoA7y/Zfw6qpmm62zsuriQTRVooCAVATyCQtie5sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198189;
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
 bh=K4gzkwD1PF4/Sy/+YolTJe/WdbvybbQUJYRDpYRj+jI=;
 b=RTew+jI3s38XJsaLaGFKkdUyw2OhP7VhECGrhNOYcilYOM5eMHXACTmv/A+CxRAzYSTi
 G+FOHrNRI8P6xkkILG90JXlIRLgp3pl6+5uraK7iEI+5MSApUmOoQ1r8w3RLkV+sINEAa
 Cs2bq/40qJ1GzAohWg3pUS2EcT5C2BjzKIRuVKsuP/6Q4h+KBznBs/DXOiiNBx2RPXuo9
 thbH561mV/ExeD0v5QMqPPwXtisNgn/uYPPCwmz2hRE7Abb62VCfD5x0QpoRagA3ojR1k
 aNFUfXJxR6E1N7bnBypI9wfn4mKXAC0swknZ+U+zKnkCQH2+m91F+UrsoMoPaGrsrjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RzsiwfyL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RzsiwfyL
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ECC7740521
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198189; x=1822734189;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K4gzkwD1PF4/Sy/+YolTJe/WdbvybbQUJYRDpYRj+jI=;
 b=RzsiwfyLb6E6NvCyYmkxGqECmF7irE/nKRs8GaqVlKX4kg5yWTaDU9iG
 pRFl3ucDaF82wTXZTyZvLsaBGIVX8mJCPM8zmRiEYg5Za+XfSMF7F8d1b
 aLMJPAONfK8E+V2dD8X95E+kykx+OTn2ebwWT02i71xsg5lADjlVKtQ2U
 6kHOLnfkniXQbOIpYOeplQq9Sgq6EAPoLLvPrGs4untiTyn12RfheDy7n
 j3GDSXhSnoZRl+pLfn/mB1gd14NbeWKPNKo6C+24BsBnGuXaV6P0gh5qH
 xs6Dk8pPGYQp97BqpqT4N5UQIogHCyU9yKp+IUh+MeM0J5HegtE5VVREt g==;
X-CSE-ConnectionGUID: Gf42z92pRSOVieuF+tun0w==
X-CSE-MsgGUID: /+h4GI/ATluSYQT7od3Dmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102385249"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="102385249"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:03:01 -0700
X-CSE-ConnectionGUID: p7NAzhhFRdmzxEuaPhmshQ==
X-CSE-MsgGUID: eZeeXO3lSjiYI312LZEDFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="276923424"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:03:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:03:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 04:03:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0Ptk3TUo74Ha2oaqqFvWoxF+uReTnEw9qHClMOUDK7Kr+BiCK9PJp3IWkS160UBeOUpKckaxxAmcw/M7YoljKvC30UtcRHMp9+2gvjUPr1SVxRr5xEo+dxCIPh7qj4QXyIIcbge8bOSboPvyodPuXvuytB5qSBMV/CjGYaFvjw55+vrenefrD2RYTUkssWFmPnC5rMPClSdTpNxGm6AnPbbDwxqkOlrSmFPk0dlhbHMTAmLRs0P5dlmrYnupwXjVMzvaLouv3jz2EFFIq4aGDb15Ev7X7dE9grNV+gDASLtvahgUAK0TdKrHllAviXZMu+eK/r9TK6vJx5aO9E4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4gzkwD1PF4/Sy/+YolTJe/WdbvybbQUJYRDpYRj+jI=;
 b=uXLghUtKrWvgz69sOeOCmu5k3aWaTMzRrZGQnToQNMnqfTHyR6PwwT6e2s6mmHIQ0LJlhaUJOKgce5rpTSfIPUZcXHzthrsdVmExvN7ABeOf0WGXi4m6mixMWhOWDysvdMuYCDvSp0/qbLQcxNez3qA/A4P0jIfjEiipcnmTEPeCSso3wdu+mWIl58FBknHHOv5Gk5TY8g1PYmR0f6mFCHSbYJ/KMsQyuCtzoPe4gdE/pTYjokI1vVStbesfayW9xMrOgZqGQTlnwxX7g3n+BQSV4RKxusiA0WHnLkZyzpAFZfGu4JO/omkmPCa+PhhCb73dKmMfH92Q32O3pSTRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 11:02:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:02:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net v3 01/15] ice: fix removal of PTP timestamp
 tracker during reset
Thread-Topic: [PATCH iwl-net v3 01/15] ice: fix removal of PTP timestamp
 tracker during reset
Thread-Index: AQHdTUnGvbdIZO2bJ069c2Pc8lr9mbbu132Q
Date: Mon, 5 Oct 2026 11:02:53 +0000
Message-ID: <IA3PR11MB898634DDA7343C1285A2E844E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-1-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-1-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 2b7611f7-1bf5-4294-7870-08df22d03491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|5023799004|11063799006|4143699003|3023799007|6133799003|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: lpbz3My+0G2sqe0s6WmLUPO3fG70Q4cnvS51XJSkj3eIy9B9onDpS9FDcY4F929vm9fai0JTacstbqBrFRykDB/1RU5TgVWQMMJWttjFHI3KVzdoAMu2wvh5NZTg5uaLwtVuKRL5QsZcRQxlqS9UGxuZb+GEkQqbo9UwZ5qP/3lACZxHODzm8BESqZgJpyEnF67jEMm1rKORSZ8FbqM4Cb7b3KtQF+EH2icw6RAjzqjmf9OoadTxElc3bW+4j3MDfAKYSSby8VF2D6wEzyzRu9kHYlQVbeypROYEaWb1wylP7QV6Ah6kSJ1ad95fAvTrrs4lngPrUQT0fqU7AU0tGJjVkUD6EMTJDAyaMx5bP7JZqsvfO16FpSPv9o3qmZZhtimDx81YTTSl7EHF6CM+N5ZMqSNuAKV5N7ePhtLd9Gjdu3Iftu583h/jPPHF6gBTVGcLXketk9OxkZ56fNsKVu/PibEFIRlU1iirkR9Y9a6R7eU7GDFn1o9WMBR4VZ5IoMZelRdhJcPTZWHam9amj3T3Mofh4sU7rQLVuN3Faln+vPm5Tg2FucK2K3I1x2J+CPdnpS9+VUuXrKfTtH/zH4+tRWC6hSVRD4pGO7Kvf8qZX9xhMOvWtL+XmFGguiHHjIl7bG6xPVC3oCVsfhGH9r4PZYDDDLrsDTh55XSsVpSN2VkVeXMneWSTFmq8uBN9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(3023799007)(6133799003)(921020)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFUrTkNzTXgvd2FSQ2s5ZVA1Z3Q0RU14THdTeW1HWG9xRnFpRU05NDk3TGo5?=
 =?utf-8?B?bWVBcnJhdnhpcXA5bTVuaTRpak9mZW1GeXNtdXBXWWoyaVlDbjU1V2xnVVk1?=
 =?utf-8?B?WXozMUpOUVMyaVFpNHBGRFZnZmowMTJOWlVid2ZtNTQvYitweHBabXh5VGh5?=
 =?utf-8?B?L0h0UHJSUU5jRWJjU0UzbGhINk1KSm94Q1hIaHZlc2xZbFVmSEh1UXN5NDdL?=
 =?utf-8?B?UU04VXRZOU0xSnVIWUp0TGRialNFQ0RUUTNxSHJialVBK3ZHYkFVNmEzSXNY?=
 =?utf-8?B?bkNJWW1xaDIwbHlBL3ZmZE1kK0RDQVBNY043TElSS1ZzMGdPUDRUTThmUDQy?=
 =?utf-8?B?ME9Cd205S1ZUbnErOWtYWTN3WmpLdVFqazFXd1NzeldyeVpkelBBT1JHZ2Zl?=
 =?utf-8?B?YW9DcjdrRVVPOHRrc2U0TnZBRkFjVzZnaW53T1BHTlp5Q1djMXJLV1BTdmlh?=
 =?utf-8?B?bzJhbTE5NzRZbHQvRFNmZXByOHhZb1dHL0pWaEsydnNDL3RQUnVHLzcxTFlI?=
 =?utf-8?B?MEVuZGRaMlNnemdYZi9xSkM3aUtxc2dXYmVMQ04rM0JhRys0ckluRStVNytv?=
 =?utf-8?B?ZkNza1NrUjl6dkxUdkRGUkN6MkxVSGxGV2hFYVUwNjJSUXM5QXR0M3oxcWhL?=
 =?utf-8?B?WVRBM0Jnb0cwbG1DMFlIQm5ybE1pTjc4MUQvdVkrRE41KzhQUWJYSHMvVVM1?=
 =?utf-8?B?MUx1Q1ZLUGh3OWJMZ01SZk9WckRaR1YzM2IvRnloa0dId2ZWQkRTaXB2RnJ4?=
 =?utf-8?B?RCtKVkY2aThTRUlKd05vd1NqQy9ma1p0U3pYQ3lzeEN2cVpDM0U2ZVhpYlFJ?=
 =?utf-8?B?eXVJZWFzME9JbE5vVi9XRFVBN0lEelB3R050Qmx2RlFON3FsWTNnWk5zUXR1?=
 =?utf-8?B?cEdTeUEyOGI4STAzOXBPS3FuTGVGRWhhNHVpMWRmSU56bjllbGduL2ptZGlJ?=
 =?utf-8?B?UjRVVDFwazBjOUpQKytmeWFZSHd5Ris5bTFibEJKY0R6YkhUcGxlRDRKejc2?=
 =?utf-8?B?cUZDZGE2dmFRTWc2QlorU3Q2bE50RnlMU3lmamYvN0hiR1BFTFJVQkZrSmxi?=
 =?utf-8?B?V2dyWm10eERaRW4vVThsVVZnellPQngrbVFSK0p6TGNwWlAxa3ZxYXkxSVl3?=
 =?utf-8?B?RnJvLzRTVUxGQmlmbmVFVjdXK0NhQkZINUhBcEcyQVJ4eHU2MU92RDhGRkww?=
 =?utf-8?B?eVFyWXp4dlB0TENjWGYvVHNrRGM3dUF5UU9sU3o5R1FKMmYrclNLWEVrM3Z0?=
 =?utf-8?B?M3U4aGNLSE91UmFvU2Ntb1hTYTlnYndYb05wYXg3QmZ3SzA1MlJjQTFBUCtJ?=
 =?utf-8?B?T0VYblE3dHAxNzMxbFVqRlo5U0o2enpua1NmWDJMeUdSZDlDc1V5WWtkN0VV?=
 =?utf-8?B?aEFnblFIYjdDMllubDlncm1pYnRaOWpta2MzOEFuclUwRHZXblRwMGIrTDkx?=
 =?utf-8?B?UDU1aTdOQ0ZJR1E3ODJ0MHV4NWpuamF4cXRJWGtTdmFCYmlqNGZFajA2TWtG?=
 =?utf-8?B?cFEyTzFJeWp0c0Q0VExUR01pb1J1eWx5dk5yd3lOU3A3SDkwdFI0N2xYUXlC?=
 =?utf-8?B?cnNway9yNFVUUlFxWHFJSGJIVFVnWUFiN1BORHJNU2hWWGRrTHhsRk01Z0k3?=
 =?utf-8?B?QVAxN0grTW9nUlFLT2FXNkxHUzJHWG0wRUxTMHBZZm1BaE9aTkFCblQxQ0Jr?=
 =?utf-8?B?Q0dURnYzRlZTMjlBVjFUQ3dDd1VnTUE2TmxTWVpqaUNiWUpUZm9FYUJTZVdr?=
 =?utf-8?B?U0dtT1c2Tnk0NTJHcWxHOHJDaHUrVmdUM2xyOVArVDBwZ3ZmZlQva1NEc1lX?=
 =?utf-8?B?SlI5T2drQlNoS3Fid0FBTDRScFp2Nm5jeW1Dc0ZON21xZGpta3ZteDVZa0pF?=
 =?utf-8?B?bFBiWVltNE1LWCtxTWJGb1dUdmxSYzZFMGdMRWFsaWdidHVia0hlcVBhaG9H?=
 =?utf-8?B?bDJyWWZ4RGlOdkxkVkZKZGJnOGFtTlQ3RVdpZ2k1NE4vMnNWSVNic1UxeWFF?=
 =?utf-8?B?OFZQQVdnUnZuMnhuRnNqZS9aeGZYb2J1bFhFMWJ1S08zVEx6Ym1SN1lvU1Iv?=
 =?utf-8?B?aXk5MUxMMUpINUFyQVdFQi91RUFaVnQ0cnhYNzlBdVFsendlMENlUjFGamJK?=
 =?utf-8?B?YStjQnB1eUlxQlpZL0V0bkw3bWhQWnBuNnJidlE2NXIvUFppcy8vMWcwRElG?=
 =?utf-8?B?TFBGVGUybkNHSitFTnBkaXZWMWhwUmtnNFBFMWF2ZHFUNGVDMmR2SU54K2RS?=
 =?utf-8?B?Z25vYlgxQkxQYTJDTkprUnNaVGN1ek5xcUNCVWloaTR4a0tzZkxYeEJyeUZ1?=
 =?utf-8?B?Mm1jOFhyZTBwcGVRanMxUnVKOExQRkhsNXhkTVhCazY4eTcwSUxlczE2Y3M2?=
 =?utf-8?Q?R1jAOzaqLcIA+CIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uKOGYTb148kWZ2sLIIqcqsZAR2UCCOItwhKEluxRDzVHHIvWroxmj4PHoJaEJASFPC6PCyfY+dREA4Qqhcb+r2gH91G82Gio1ontQHDQoretjezgjBHYDKRvZOiCGZ+SDasGP8/bHqmzFhKXP2DkN6cuV2Ijv1crlZkSc/it0Rim6EAyb1pIdDjBAXr9tAlD/ry8F90GUXgNU003TP/yeDdTc0poEKjF230oFWLBALsrvLfFamUog26/a9y5aatzdJTBcCiFFM5d/FAwCnuFyLo34yUMHAYTj/90CAF/LCPBXZQAavPqDG+yjfqYx1fyjb1JhLeKecT5h9uDO6s/Mg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7611f7-1bf5-4294-7870-08df22d03491
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:02:54.0224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7P3erjhfhjhw/cG7m4gYv8u0kLo78qVgPuyfVeMDjAje2IXe+stfZeLcW+nmP+EKGpt56Lfim/LkSl8hq1CAO4IyhYI45Z00rlQhRMj+iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjYs
IDIwMjYgMTo1NyBBTQ0KPiBUbzogSW50ZWwgV2lyZWQgTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlz
dHMub3N1b3NsLm9yZz47IE1hY2huaWtvd3NraSwNCj4gTWFjaWVqIDxtYWNpZWoubWFjaG5pa293
c2tpQGludGVsLmNvbT47IEtlbGxlciwgSmFjb2IgRQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPjsgS29yYmEsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgTml0a2Es
IEdyemVnb3J6DQo+IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmth
ZGl1c3oNCj4gPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4gQ2M6IEtlbGxlciwg
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXds
LW5ldCB2MyAwMS8xNV0gaWNlOiBmaXggcmVtb3ZhbCBvZiBQVFAgdGltZXN0YW1wDQo+IHRyYWNr
ZXIgZHVyaW5nIHJlc2V0DQo+IA0KPiBDb21taXQgN2EyNWZlNWNkNWZiICgiaWNlOiBzdG9wIGRl
c3Ryb3lpbmcgYW5kIHJlaW5pdGFsaXppbmcgVHgNCj4gdHJhY2tlciBkdXJpbmcgcmVzZXQiKSBp
bnRlbmRlZCB0byBtb2RpZnkgdGhlIFBUUCByZXNldCBmbG93IG9mIHRoZQ0KPiBkcml2ZXIgc28g
dGhhdCBpdCBzdG9wcGVkIGNhbGxpbmcgaWNlX3B0cF9yZXNldF90eF90cmFja2VyKCkgZHVyaW5n
DQo+IHRlYXJkb3duIGFuZCBzdG9wcGVkIGNhbGxpbmcgaWNlX3B0cF9pbml0X3R4XyooKSBkdXJp
bmcgcmVidWlsZC4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoZSBjb21taXQgb25seSByZW1vdmVk
IHRoZSBjYWxscyB0bw0KPiBpY2VfcHRwX2luaXRfdHhfKigpLg0KPiBUaGlzIGZpeGVkIGEgbWVt
b3J5IGxlYWsgaW4gUEYgcmVzZXQuIEhvd2V2ZXIsIG5vdyBhIENPUkUsIEdMT0JBTCwgb3INCj4g
RU1QIHJlc2V0IHdpbGwgbGVhdmUgdGhlIGRldmljZSB1bmFibGUgdG8gaW5pdGlhdGUgVHggdGlt
ZXN0YW1wDQo+IHJlcXVlc3RzIGluZGVmaW5pdGVseS4NCj4gDQo+IEluIHByYWN0aWNlIHRoZSBD
T1JFIGFuZCBHTE9CQUwgcmVzZXRzIHJhcmVseSBoYXBwZW4gaW4gcHJvZHVjdGlvbg0KPiBlbnZp
cm9ubWVudHMsIHdoaWxlIEVNUCByZXNldHMgaGFwcGVuIGFmdGVyIGEgZmlybXdhcmUgdXBkYXRl
IHRoYXQgaXMNCj4gb2Z0ZW4gZm9sbG93ZWQgYnkgYSBwbGF0Zm9ybSByZWJvb3QuIFRoaXMgZXhw
bGFpbnMgd2h5IHRoaXMgaGFzIG5vdA0KPiBiZWVuIGNhdWdodCB1bnRpbCBub3cuIEhvd2V2ZXIs
IGl0IGlzIHRyaXZpYWwgdG8gdmVyaWZ5IGJ5IHRyaWdnZXJpbmcNCj4gdGhlIHJlc2V0IGZyb20g
dXNlcnNwYWNlIHZpYSBldGh0b29sLiBGb3IgaWNlIHRoZSBmb2xsb3dpbmcgY29tbWFuZA0KPiB3
aWxsIHRyaWdnZXIgYSBHTE9CQUwNCj4gcmVzZXQ6DQo+IA0KPiAgICQgZXRodG9vbCAtLXJlc2V0
IGVubzgzMDNucDAgaXJxLXNoYXJlZCBkbWEtc2hhcmVkIGZpbHRlci1zaGFyZWQgXA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb2ZmbG9hZC1zaGFyZWQgcmFtLXNoYXJlZCBtYWMt
c2hhcmVkDQo+IHBoeS1zaGFyZWQNCj4gDQo+IFJlbW92ZSB0aGUgY2FsbCBvZiBpY2VfcHRwX3Jl
bGVhc2VfdHhfdHJhY2tlcigpIGZyb20NCj4gaWNlX3B0cF9wcmVwYXJlX2Zvcl9yZXNldCgpLCB0
byBrZWVwIHRoZSB0cmFja2VyIG1lbW9yeSBpbiBwbGFjZSBzbw0KPiB0aGF0IHRpbWVzdGFtcGlu
ZyBjYW4gcmVzdW1lIGFmdGVyIGEgcmVzZXQuDQo+IA0KPiBEdXJpbmcgcmV2aWV3IG9mIGEgcHJl
dmlvdXMgdmVyc2lvbiBvZiB0aGlzIGNoYW5nZSwgc2FzaGlrbyBwb2ludGVkDQo+IG91dCB0aGF0
IHRoZSB0ZWFyZG93biBmbG93cyBmb3IgaWNlX3B0cF9pbml0KCkgYW5kIGljZV9wdHBfcmVsZWFz
ZSgpDQo+IGNvdWxkIHBvdGVudGlhbGx5IGxlYWsgdGhlIFBUUCB0aW1lc3RhbXAgdHJhY2tlci4N
Cj4gDQo+IEZpeCBpY2VfcHRwX2luaXQoKSBzbyB0aGF0IGl0IGFsbG9jYXRlcyB0aGUgdHJhY2tl
ciBiZWZvcmUgYWRkaW5nIHRoZQ0KPiBwb3J0IHRvIHRoZSBwb3J0IGxpc3QsIGFuZCBwcm9wZXJs
eSBjYWxscyBpY2VfcHRwX3JlbGVhc2VfdHhfdHJhY2tlcigpDQo+IGFzIHBhcnQgb2YgaXRzIGNs
ZWFudXAgb24gZXJyb3IuIEVuc3VyZSB0aGUgcHNfbG9jayBtdXRleCBpc24ndA0KPiBkZXN0cm95
ZWQgdW50aWwgdGhlIFBGIGhhcyBiZWVuIGNsZWFyZWQgZnJvbSB0aGUgcG9ydCBsaXN0Lg0KPiAN
Cj4gRml4IGljZV9wdHBfcmVsZWFzZSgpIHNvIHRoYXQgaXQgaGFuZGxlcyB0aGUgY2xlYW51cCBp
ZiBQVFAgaXMgaW4gdGhlDQo+IGVycm9yIHN0YXRlIGJ5IGNhbmNlbGxpbmcgdGhlIGt3b3JrZXIg
aXRlbXMgYW5kIHJlbGVhc2luZyB0aGUgVHgNCj4gdHJhY2tlciBhcyBhcHByb3ByaWF0ZS4NCj4g
DQo+IFRoaXMgd2FzIGZvdW5kIGJ5IFNhc2hpa28gcmV2aWV3IGR1cmluZyBmZWVkYmFjayBmb3Ig
YW4gdW5yZWxhdGVkDQo+IGNoYW5nZSwgYW5kIGl0ZXJhdGVkIGJhc2VkIG9uIGZ1cnRoZXIgZmVl
ZGJhY2sgZnJvbSBTYXNoaWtvIGFmdGVyIHRoZQ0KPiBpbml0aWFsIGZpeCB0byByZW1vdmUgdGhl
IGNhbGwgdG8gaWNlX3B0cF9yZWxlYXNlX3R4X3RyYWNrZXIoKTsNCj4gDQo+IENsb3NlczogaHR0
cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwODIxLWprLWU4MjVjLW1pbmltaXplZC0N
Cj4gZml4ZXMtdjEtMC05ZDA3MzFlYjQ4NTglNDBpbnRlbC5jb20/cGFydD04DQo+IENsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwOTE2MDExMjEzLjE2MzIyODYtMS0N
Cj4ga3ViYUBrZXJuZWwub3JnLw0KPiBGaXhlczogN2EyNWZlNWNkNWZiICgiaWNlOiBzdG9wIGRl
c3Ryb3lpbmcgYW5kIHJlaW5pdGFsaXppbmcgVHgNCj4gdHJhY2tlciBkdXJpbmcgcmVzZXQiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jIHwgMzEg
KysrKysrKysrKysrKysrKysrKystLS0NCj4gLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYw0KPiBpbmRleCBlYWVjMzZhYjZhZTMuLmZlMjFjZWU0
ZjlkZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9w
dHAuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+
IEBAIC0yOTM5LDggKzI5MzksNiBAQCB2b2lkIGljZV9wdHBfcHJlcGFyZV9mb3JfcmVzZXQoc3Ry
dWN0IGljZV9wZg0KPiAqcGYsIGVudW0gaWNlX3Jlc2V0X3JlcSByZXNldF90eXBlKQ0KPiAgCWlm
IChpY2VfcGZfc3JjX3Rtcl9vd25lZChwZikgJiYgaHctPm1hY190eXBlID09DQo+IElDRV9NQUNf
R0VORVJJQ18zS19FODI1KQ0KPiAgCQlpY2VfcHRwX3ByZXBhcmVfcmVidWlsZF9zZWMocGYsIGZh
bHNlLCByZXNldF90eXBlKTsNCj4gDQo+IC0JaWNlX3B0cF9yZWxlYXNlX3R4X3RyYWNrZXIocGYs
ICZwZi0+cHRwLnBvcnQudHgpOw0KPiAtDQo+ICAJLyogRGlzYWJsZSBwZXJpb2RpYyBvdXRwdXRz
ICovDQo+ICAJaWNlX3B0cF9kaXNhYmxlX2FsbF9wZXJvdXQocGYpOw0KPiANCj4gQEAgLTMzNDcs
MTMgKzMzNDUsMTMgQEAgdm9pZCBpY2VfcHRwX2luaXQoc3RydWN0IGljZV9wZiAqcGYpDQo+ICAJ
CX0NCj4gIAl9DQo+IA0KPiAtCWVyciA9IGljZV9wdHBfc2V0dXBfcGYocGYpOw0KPiAtCWlmIChl
cnIpDQo+IC0JCWdvdG8gZXJyX2V4aXQ7DQo+IC0NCj4gIAllcnIgPSBpY2VfcHRwX2luaXRfcG9y
dChwZiwgJnB0cC0+cG9ydCk7DQo+ICAJaWYgKGVycikNCj4gLQkJZ290byBlcnJfY2xlYW5fcGY7
DQo+ICsJCWdvdG8gZXJyX2Rlc3Ryb3lfcHNfbG9jazsNCj4gKw0KPiArCWVyciA9IGljZV9wdHBf
c2V0dXBfcGYocGYpOw0KPiArCWlmIChlcnIpDQo+ICsJCWdvdG8gZXJyX3JlbGVhc2VfdHhfdHJh
Y2tlcjsNCj4gDQo+ICAJLyogU3RhcnQgdGhlIFBIWSB0aW1lc3RhbXBpbmcgYmxvY2sgKi8NCj4g
IAlpY2VfcHRwX3Jlc2V0X3BoeV90aW1lc3RhbXBpbmcocGYpOw0KPiBAQCAtMzM2NSwxNCArMzM2
MywxNyBAQCB2b2lkIGljZV9wdHBfaW5pdChzdHJ1Y3QgaWNlX3BmICpwZikNCj4gDQo+ICAJZXJy
ID0gaWNlX3B0cF9pbml0X3dvcmsocGYsIHB0cCk7DQo+ICAJaWYgKGVycikNCj4gLQkJZ290byBl
cnJfZXhpdDsNCj4gKwkJZ290byBlcnJfY2xlYW5fcGY7DQo+IA0KPiAgCWRldl9pbmZvKGljZV9w
Zl90b19kZXYocGYpLCAiUFRQIGluaXQgc3VjY2Vzc2Z1bFxuIik7DQo+ICAJcmV0dXJuOw0KPiAN
Cj4gIGVycl9jbGVhbl9wZjoNCj4gLQltdXRleF9kZXN0cm95KCZwdHAtPnBvcnQucHNfbG9jayk7
DQo+ICAJaWNlX3B0cF9jbGVhbnVwX3BmKHBmKTsNCj4gK2Vycl9yZWxlYXNlX3R4X3RyYWNrZXI6
DQo+ICsJaWNlX3B0cF9yZWxlYXNlX3R4X3RyYWNrZXIocGYsICZwZi0+cHRwLnBvcnQudHgpOw0K
PiArZXJyX2Rlc3Ryb3lfcHNfbG9jazoNCj4gKwltdXRleF9kZXN0cm95KCZwdHAtPnBvcnQucHNf
bG9jayk7DQo+ICBlcnJfZXhpdDoNCj4gIAkvKiBJZiB3ZSByZWdpc3RlcmVkIGEgUFRQIGNsb2Nr
LCByZWxlYXNlIGl0ICovDQo+ICAJaWYgKHBmLT5wdHAuY2xvY2spIHsNCj4gQEAgLTMzOTksMTIg
KzM0MDAsMjAgQEAgdm9pZCBpY2VfcHRwX3JlbGVhc2Uoc3RydWN0IGljZV9wZiAqcGYpDQo+ICAJ
CXJldHVybjsNCj4gDQo+ICAJaWYgKHBmLT5wdHAuc3RhdGUgIT0gSUNFX1BUUF9SRUFEWSkgew0K
PiAtCQltdXRleF9kZXN0cm95KCZwZi0+cHRwLnBvcnQucHNfbG9jayk7DQo+IC0JCWljZV9wdHBf
Y2xlYW51cF9wZihwZik7DQo+ICsJCWlmIChwZi0+cHRwLmt3b3JrZXIpIHsNCj4gKwkJCWt0aHJl
YWRfY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZwZi0+cHRwLndvcmspOw0KPiArCQkJaWYgKHBm
LT5ody5tYWNfdHlwZSA9PSBJQ0VfTUFDX0dFTkVSSUMpDQo+ICsJCQkJa3RocmVhZF9jYW5jZWxf
ZGVsYXllZF93b3JrX3N5bmMoJnBmLQ0KPiA+cHRwLnBvcnQub3Zfd29yayk7DQo+ICsJCQlrdGhy
ZWFkX2Rlc3Ryb3lfd29ya2VyKHBmLT5wdHAua3dvcmtlcik7DQo+ICsJCQlwZi0+cHRwLmt3b3Jr
ZXIgPSBOVUxMOw0KPiArCQl9DQo+ICAJCWlmIChwZi0+cHRwLmNsb2NrKSB7DQo+ICAJCQlwdHBf
Y2xvY2tfdW5yZWdpc3RlcihwZi0+cHRwLmNsb2NrKTsNCj4gIAkJCXBmLT5wdHAuY2xvY2sgPSBO
VUxMOw0KPiAgCQl9DQo+ICsJCWljZV9wdHBfY2xlYW51cF9wZihwZik7DQo+ICsJCWljZV9wdHBf
cmVsZWFzZV90eF90cmFja2VyKHBmLCAmcGYtPnB0cC5wb3J0LnR4KTsNCj4gKwkJbXV0ZXhfZGVz
dHJveSgmcGYtPnB0cC5wb3J0LnBzX2xvY2spOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiANCj4g
DQo+IC0tDQo+IDIuNTYuMC5yYzAuMzk1LmdkMWYzNTI0ZTE1ZGMNCg0KUmV2aWV3ZWQtYnk6IEFs
ZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQo=
