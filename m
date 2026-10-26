Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B17606A31B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=a+dKgXgk;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IMxm2YfL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D477B60607;
	Mon, 26 Oct 2026 22:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x8aa4_8vVNqu; Mon, 26 Oct 2026 22:09:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1588F605EF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793052556;
	b=Hl4rm1zFxA2zr5VZQMYqVQ56qgODB5MAZ0NBbwjbPATMtUa8U+T8CI1xVaKRh85XBqrG
	 Go1la5MZ84yhxbIimrYMW1lRZV/5Ex27Cjw0FkvhIIBnXrE3PsPVp/UBUeYHa4mgUSKbP
	 hbcOEQ9aGMg82OE3bMoOKobiqS7ysRajNtlWyPtjd2i1/BK5oFbAPYHcqE7Wb9vxssShs
	 T7O2Uf/tv4OK+riTcLFR67ymFGTUVloXTB/ViPFzL3EA6J6RWuBT8gUpS6whYTsWlITSY
	 LQZ2KwTQVFMSs0Ava+1XyF+hNVT9LTr6M6F8lqPGqCGwgre/6CgHblnpDfKsquGJ+LA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=e4X67bT8miClPtLodndyLVmiAu3u7DjYvcPDVCCPD4E=;
	b=G+V+TScfP+E+wXmXj/HHvNy/MYTHazSS5Wp2kSlpoxYTwqvDtGd1oNBBVVi2FoTNKs4D
	 ynB420k6UeGWE2g0u0zbXBepjFqcgdXqMXe/zt8QdhCAWSgKec+41c3zUKZIHkvfmZyDa
	 3vgPeugy2vT1gTHtOOVK2s0QH7ldL8404yy9T5FR2Cdx6p8xMqKN/dpVNtvex/KT5L32V
	 z2TwPtYJ8aJruklG7Xxlq2xRKJZqtuwsLhMfgfn6z54oDWg9kYP6CRkXly/PD1ZQKluR9
	 bxDd2qg6PCNJh0ybIZ61UkBkmhZJ3fPJ09+1+ruJi9hKg/MLA6prV3huSa8awKlTiEg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793052556;
	bh=e4X67bT8miClPtLodndyLVmiAu3u7DjYvcPDVCCPD4E=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a+dKgXgkXLx1MW/a7+CgtIQunmtTUD7UYvyQ+WmKqj9JrS9h5Uk/S5833kO1jZWSL
	 FwxWBxkUdBL+tgGVDLYgnwixs/l+rEpf8Ik4RqSl0vVAipT2wOCz49eQBV0hNPMu4G
	 0+YuDUE8SD+0XnVG8F6eliGshdWTe2sC3eKLBR5YBT6i9Rb++4WaQt8rZgOc62m8r/
	 5hucVJYBnqfC6xkh4MHfGmwRdrXpIYfKa/5LIVrIfLXx9VefsJbKnB/UDVRmY61MX0
	 /BymdY+KLK/51kL+IC9Bl30+bQNgJnUTF+f4e3LrvSgSOKfupnNDQqEl76oPH4+jH3
	 rX3CUJUQt/p7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1588F605EF;
	Mon, 26 Oct 2026 22:09:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3DEE4BC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A2EF40567
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXaUYUjF5kmc for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF2BF40555
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052553;
 b=ETZCdpD3KYnNgTeBXhKdp6dX61+cd/I2P3m5ehAKk6iepPhoHBscNcF1bJqndfT8Y0tx
 kVOBpFulmTxaUMFvaqlz62yB9Hh1qAmRl+UhF6hyUMXOCRioArm1eOUFNUq/lHLd+eHpH
 ogJxeeyggzg+iG27Fz4X+9SKsO3JZw0Tx/hMmvqywm7QFi59ly7b11Br6JSBjeuayxnIL
 7YAxkT5/m1zMOCtQghbLcR+WYHWBcFMtOjNSPBfnTw4ZkEDXYYgJqE+P7XwzUuRjJzS/U
 FX/dFTphh3Yg6ALLWrTrK45OTaKC58THFmJviDcmPxzJcM1yEQaBmE+TpcluNbIUq1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052553;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=e4X67bT8miClPtLodndyLVmiAu3u7DjYvcPDVCCPD4E=;
 b=exOirIHlRrQIrJaBzt3Eg2VZ4I1UHaih8HbvMD/8D0h4lInWFJ77V0xHKfuhCwXsOK5Q
 OVDqsHuCFs8BkfA5i6aSi5CCVwN9aXJK8sADf+X0yFPqHon+UT/juXUovbCvW2iZjiq4h
 m8Iv3LHYzP+PocGAv4ppbaO4nNXr/Diwk2C24Mz3sFY2Nge8R7kJnWpjkrfTQ82GnBroo
 i0eEHRziJ1G+50MHi51I4ga0vraukxAbyi1fpoXK58rGJBCtHrTsPbW/2MArSQXbf9Pwm
 x36699gFmd6dVz//Le7XfCjtc3ShOPmbe9SWuZfbIE3cp2SybuvF4NWLYa6YsPJ/0AA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IMxm2YfL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IMxm2YfL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF2BF40555
 for <intel-wired-lan@osuosl.org>; Mon, 26 Oct 2026 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793052554; x=1824588554;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=gW3ECz0jr3StwLO5R/nAueaseWSqrj/pRvyJ4eo7vBA=;
 b=IMxm2YfLZkQFcgr/epsEPgY5VWLM+Xiy6YzwFshyrkVQ6PX/m6EQgTWy
 K7RWnus7OeRrTXY/ON8eEmxWfAd+62Iwod4Lv3V0XlHoBgEDLJoojSSPE
 8gOBqZ7EB537yuAlZdBIKI+R6Ejo9gkN8pyyg0gEFgd/8HeBEeFIKteA9
 4hZIvRwdNEX19Gb8BY4ZobKTHTQXSzfJ7nKWfqYWig6ea0Lz5B7SoL3c5
 FpFAGl1GiS5l6XbPkAmGP4gswgr3nKiKUlDZg2/AwEDFCCIiJ/QNuw5KV
 V6CKaqoJVt1Sy2oo3+GSacdsO+kNDAcgJxH5kPPW72a0aFk7qgE6obdx0 Q==;
X-CSE-ConnectionGUID: H2MI9RHJTx6yUt3icfvvzA==
X-CSE-MsgGUID: i3nfKkJHTGujx8t4v8Tasw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1749196"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1749196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:09:13 -0700
X-CSE-ConnectionGUID: F46JmloESf6Ulw2DNSHMzA==
X-CSE-MsgGUID: gXsOBgtwQBWtfAwsULnE7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4715530"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:09:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:09:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:09:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hReC4/1fyBCdgSAa5UIt0zC3CCkvLCDH33491Ad+hCjcXHD2dpNDT0cA7Fcrt1oJan9/P32zXDVS4qOycq46t6VkT5Ld9cftFiCbttdTEJZi7uZtLG1ttleRuBRluOwmckeRSG14q7bv+KapeHdT3NFLmtB1xdnPO1jjnPfm7eA2LP91sCzZT5dRzzCH7+FhJnbGEHzIERjkw8aXeNkysMrQSGeyQ31IXAauG44zkta6v1vpizw9UkkRooh0QR2L3V5P0hYha28iTlp6Ap0Peva+gKvDhQrpUx0poTJNcQV/uyW3erNhlJlTlYivhKbLH0u/APLLUkqmxJhOScoWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4X67bT8miClPtLodndyLVmiAu3u7DjYvcPDVCCPD4E=;
 b=LNU96O2aK3TJm/l4tpMlUDATeH9lftA2ALqBVA5dDzMzH+1hzCl8jXOYxbqz1p6NOvOxpgz/LETNTNw0Z4kOUiZHqZAxPR5BfJk3/cLYomyoLoVTWOX5rTqEmjtN0XalpHj5wBd5OcOgyg4y0ZNNumukE88jwtbXkjb1oOi94AEd6Mho1vMStaeVh1EbXMscxq/JqEiDvdbzciFvWIts92VslVMFj2Ksgmvi4vfZUdMht/BGbL7QOXtideGvavniKvggWiFP0Kzm54Pb/0HdmyU+TzZLffDdzuIjmJjTrs+ej6WrRPMLrmUvUN5bTwLUSNCsUN/5jMy7EDAZ6YjXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ2PR11MB8422.namprd11.prod.outlook.com
 (2603:10b6:a03:542::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:09:08 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:09:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Sasha Neftin <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
Subject: RE: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
Thread-Topic: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
Thread-Index: AQHdY9X2uxpWnW0PDE+vJpXNukvr+bcQZX7Q
Date: Mon, 26 Oct 2026 22:09:08 +0000
Message-ID: <CH3PR11MB566895C0974875AD501296C435E5612@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261024163701.134489-1-sashaneftin@gmail.com>
In-Reply-To: <20261024163701.134489-1-sashaneftin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ2PR11MB8422:EE_
x-ms-office365-filtering-correlation-id: b7f9a740-df9d-4bd9-0b33-08df33adc1af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261026140227099003|38070700021|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 7WabDIhvRbkwBoFp5Z/Gu/Iej0Lpt1SsuxHG5jhRZKTk5WGD3XQfCAMdkdYOmWPIyc0+ZfAooylxwtkBJwSLafq67P/wvzCIaUa5Q0CmjOTUgGYJ5JasIh9xY30xInRMWd+pls7EZkap+SI11DO+pvcEmAm4f+Co7rmuoWeTd2kaZWC0pQWcHDQHpVA8EYBDTLhzt4yXlmksysAKgdajEZRcwoytghETDPSKx4TKcQOSoWJ9LRqIsVZYqUsE0rV5ISkRtvjM5IjZvmB8miaMPCpyRM0QtaOrg+HfnNZ/yD7b0dEa8Ehp9d1QxYCOASjkais82f0fhawHmDfEcQ5s8Dsnk34rIY64jQcHai7FKu2pEuHc2Hg24Fui6VB8nMcyPW3KGCpae2jzAaMgTjT8uTvKwtcmZkPNIJSHWOu9TGYt7RN8GAJBpp41QhPp4157VcX1Mzw4zTYSgl5LpvZoLGjf9hvwUv+AXQF6cARVfz+N69zr9gfvIorDAvcw9iFXU1R03GanXPCpf23x7w14G2XE0ZpcnzuBV0fX05qb188wjhv3/C8bCSHB686rKmU+6NRcJgnU/IF5Fp9/CsiCO3H7yGKiE72b7L1AZawf+S4opKeNmZeGvMS6NBZp2Hn46fACuvoSVnJlFRiBXybs9ugShOb4837A8vi5LybJsuUI9V5rkzUTBBfEPe4swCwVHhBH0I51K7yodzTi+K5tUKucvv05UjMW67KhvO/lNwk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(38070700021)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgxgKHcIDQKgKa+RduBAJkjcVlCeoy8N+bsvLg/59Nys8PIkxSrm7Q1uOLoS?=
 =?us-ascii?Q?PHDW/FItV/wB7u2NRiWsvqxtp3mh8kvjHiIjk1s71gxM0C6B8kZnC2CzbVKQ?=
 =?us-ascii?Q?ZhQPo+DBTpG6ICcqyFccpW+P99FvupHZ6Rfww8orc9ufXVv4yj7jX8Iy+L8h?=
 =?us-ascii?Q?xpvh42ZyCRRPff5EekmLRFuyCueXbNG7srOcZqU+iwAcP6FGxL5BBj4TXJ0J?=
 =?us-ascii?Q?PbjKBY+/rcnu+KzJu4fY5MYcB0yhm7HERboVYQFcZ63/3FriWUr3AJPXifJ1?=
 =?us-ascii?Q?39Fso7ZvLRthZbNpYH/2eFc3gmbIy47pqfipsLWWG2CeUMzFFoacqd8C3+o8?=
 =?us-ascii?Q?c0Tuu1vdj8hnGK5Ly72fbCtnLyY9YEZLr8gtYpjVA1gKhe6UKdltejdqJgmG?=
 =?us-ascii?Q?48jwaS+UmYh1+Cf22VE5lppYCRtcj+jdd2g/5x+Ey8Bono8zkfyyvOMinNfg?=
 =?us-ascii?Q?oaaeCNNTX50k/ueEMQlsvJLUhf83MPahV9McCXRtWiF+3SfXg1peULyyQDLp?=
 =?us-ascii?Q?S9X62O3o7vsxweDNRY3SbfU9Gb/ggCFh4hrwqDEaMQHfttesHaK4SF468W4l?=
 =?us-ascii?Q?TGYqpNZh1AMA02xxLOZd0m2jMNaG5ClKqfFYWB/eyCOqx5vbrc35bZslAtAd?=
 =?us-ascii?Q?SPH7yXVofsy0DHRkvb/VHblfI+eht2d/dE/wXwoq1MxwXQkd1EkqsqShh6cA?=
 =?us-ascii?Q?KqgNmX5VR++FzoFMNN3kxunv7ekqTFpN7pfCP7yf7ALyKSmKMrS7G0A2l3I/?=
 =?us-ascii?Q?WirpDPumJS5Tao85NPU/A90MCxmutYhgW/f2Le00WfLBS/94oNykq7Kf/jh5?=
 =?us-ascii?Q?aYKYKpyGB8cK5qmiOaSpLkSaAy2doxaIQaWzolha2x+gBUhWR/1drfIP8j7Q?=
 =?us-ascii?Q?NqJJK4GM5jlMn+mukMNCmQoCoyIgtZlOVqHJjk0GCI9RoxMg/xJK9klvef1Y?=
 =?us-ascii?Q?pghNprZxAD8/kDe4j7N2r9JBKlIlV1qRNFpFIotINh+Xh8rGH4tUNetndaY0?=
 =?us-ascii?Q?AVzxpS3r/fnbq+ow4s5SZuon4xbEqIngdDLPrHoiu+odaIgRcrq3suycx8Eu?=
 =?us-ascii?Q?/wL3OtCfqIHLxXsZgDhTTRRANmb08pVOciXHaZ0fIgyyASRqxcobbBpewEfn?=
 =?us-ascii?Q?OBytD3Tc//APkGw+3GDrwnNAGZURLe1EeXgIaIIlZ5G0Fbnk45OJM/JIkoJd?=
 =?us-ascii?Q?BWmom7igeeIj1dfbWFbTHkXvZXS9nVbt6t4+rCsNFH9SBNYOKe+9/I+iZfUM?=
 =?us-ascii?Q?6QhkLuzObvcFx32qF2YWLrXz+tuSuqT1vLVdpbOBlE1UfRQUDTlWCYJ9QMmw?=
 =?us-ascii?Q?IgLz/Pbqkc4OcKbzxP8J6rgfFViCZO1/bAaax3Z38Se2mfy5ZySL9J0Q5ZGC?=
 =?us-ascii?Q?C/pR+RTpjCsdpmvHToEsUmXpucHnw7iN+yoSD9HHgT8xWFs2DQYe7nilaiE/?=
 =?us-ascii?Q?Wf7lCITocXUlMVEn9AjfQz2GtIem9Qm4XDXGqiBwUVNblA9kwYKHEvrh/iLh?=
 =?us-ascii?Q?taUrH4/SEpGlExEdI6l2G7flbjdccTjyQBR6u9K0A8wS26RNNIzHLtjZghC7?=
 =?us-ascii?Q?V6dTUFDQywD1BQzCyl6+zFerAUq1wvNaRj9cmfMf0H4gLefEHYn/A4v983J0?=
 =?us-ascii?Q?k5f1OhtPg0gZf/JhLlLVgdJEG2kFsQPfSubxrg6ItYCLWSbGbXUn0sN6q73a?=
 =?us-ascii?Q?VXw/JluzDDSp7HdJBmVkivrNf1Azn123b308jEi5qswoVOmCjX2xAuzQorir?=
 =?us-ascii?Q?cP9I+ScA4SIOywYckzsK3pktl9CJ9o4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KipwiH7C8nfpHEuhm9Xrd4wf72yr4HjE/WgJEiVPQTlD2zu9RU+foqzEtkntSJ2nEv8i0Y6fAB7nRlSw45iIfhUanUPVHuRDtFuBBiplCekZDxP4GeR71u/RBIy6kmquUJGHSaB5VcT/PnNejhXpL8ea9UQM6detCSby0M/4BMK8pI9Jx1S1MLG9rT/GO8nwg8n+5qFwUdVeOQPY2jce7W4drdqNIIuVRAxHRg7pTT0w4/MG2PtOT9J7DGR6ue7DEVXyYzrKppfJ2LBIiZLM/exRVF6CQIrppiucBHrDXRY2E621lIIwFTNeGD7yqU80So+cfEOHqdSyEO6quQf3FA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f9a740-df9d-4bd9-0b33-08df33adc1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:09:08.1498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzvgM/Uiha3L2SfwMT74WpPIx2U58IcMWq0+l6IzT+w7bDryLAg5Obp1s7shVUMOVlmJykW5aGBFuEG0srrVRtfpPG5Rpzvd3n80qQmfjYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Sasha Neftin <sashaneftin@gmail.com>
> Sent: Saturday, October 24, 2026 6:37 PM
> To: intel-wired-lan@osuosl.org
> Subject: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
>=20
> igc_update_nvm_checksum() has no callers in the tree. The i225 NVM
> operations use their own implementation, igc_update_nvm_checksum_i225(),
> which is what nvm->ops.update points to in igc_init_nvm_params_i225().
>=20
> Remove the dead generic function and its prototype from igc_nvm.h.
> While at it, add the include guard name as a comment to the closing
> #endif in igc_nvm.h.
>=20
> No functional change.
>=20
> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_i225.c |  4 +--
> drivers/net/ethernet/intel/igc/igc_nvm.c  | 31 -----------------------
> drivers/net/ethernet/intel/igc/igc_nvm.h  |  3 +--
>  3 files changed, 3 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c
> b/drivers/net/ethernet/intel/igc/igc_i225.c
> index 5226d10cc95b..0971debca3a4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_i225.c
> +++ b/drivers/net/ethernet/intel/igc/igc_i225.c
> @@ -220,7 +220,7 @@ static s32 igc_read_nvm_srrd_i225(struct igc_hw *hw,
> u16 offset, u16 words,
>   *
>   * Writes data to Shadow Ram at offset using EEWR register.
>   *
> - * If igc_update_nvm_checksum is not called after this function , the
> + * If igc_update_nvm_checksum_i225 is not called after this function ,
> + the
>   * Shadow Ram will most likely contain an invalid checksum.
>   */
>  static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
> @@ -275,7 +275,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16
> offset, u16 words,
>   *
>   * Writes data to Shadow RAM at offset using EEWR register.
>   *
> - * If igc_update_nvm_checksum is not called after this function , the
> + * If igc_update_nvm_checksum_i225 is not called after this function ,
> + the
>   * data will not be committed to FLASH and also Shadow RAM will most
> likely
>   * contain an invalid checksum.
>   *
> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c
> b/drivers/net/ethernet/intel/igc/igc_nvm.c
> index a47b8d39238c..b69889bfeb42 100644
> --- a/drivers/net/ethernet/intel/igc/igc_nvm.c
> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
> @@ -132,34 +132,3 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
>  out:
>  	return ret_val;
>  }
> -
> -/**
> - * igc_update_nvm_checksum - Update EEPROM checksum
> - * @hw: pointer to the HW structure
> - *
> - * Updates the EEPROM checksum by reading/adding each word of the
> EEPROM
> - * up to the checksum.  Then calculates the EEPROM checksum and writes
> the
> - * value to the EEPROM.
> - */
> -s32 igc_update_nvm_checksum(struct igc_hw *hw) -{
> -	u16 checksum =3D 0;
> -	u16 i, nvm_data;
> -	s32  ret_val;
> -
> -	for (i =3D 0; i < NVM_CHECKSUM_REG; i++) {
> -		ret_val =3D hw->nvm.ops.read(hw, i, 1, &nvm_data);
> -		if (ret_val) {
> -			hw_dbg("NVM Read Error while updating
> checksum.\n");
> -			goto out;
> -		}
> -		checksum +=3D nvm_data;
> -	}
> -	checksum =3D NVM_SUM - checksum;
> -	ret_val =3D hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
> -	if (ret_val)
> -		hw_dbg("NVM Write Error while updating checksum.\n");
> -
> -out:
> -	return ret_val;
> -}
> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.h
> b/drivers/net/ethernet/intel/igc/igc_nvm.h
> index ab78d0c64547..d5f1f1a449eb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_nvm.h
> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.h
> @@ -7,6 +7,5 @@
>  s32 igc_read_mac_addr(struct igc_hw *hw);
>  s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16
> *data);
>  s32 igc_validate_nvm_checksum(struct igc_hw *hw);
> -s32 igc_update_nvm_checksum(struct igc_hw *hw);
>=20
> -#endif
> +#endif /* _IGC_NVM_H_ */
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
