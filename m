Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18ACA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5608080FB1;
	Mon, 28 Sep 2026 15:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wr-KFt_M3Nvq; Mon, 28 Sep 2026 15:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 72E4580FB4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790608768;
	b=j2b7UHOUVXNscdSQv3pnpICCuDTCqRho+wiZ5sWQU2IN2tJRja+daShUgWL2Pr2K739q
	 u/jCSJQdKCBcnd+c8A9APmI6JtD7DiRaGw5jssWInSaVXBAMVQtqbsVpzIRyQMT3hkxsq
	 +d033WG1qhYD5epZg9VP9cr96tIoyGKjiUUyYC7BElfbUw7mvdgv5yrKrcNwNsUtJycsX
	 dRXJEbJoKGP0yGgxYW2VxLYuo661CVgGHkpfDKm6SD4Rmz5xSgRwtS5vjtAt0whkEbBdN
	 Bl2lC8pkmpGDVr5GyU6TwDeh3jKh1Tn5ea07hXk4I2/Ll/bmWxPAyJy/k6q+jEptcIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608768;
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
	bh=ELXymgfFuAh3ncXx2/QvqQFmRiV7lHiMggYxgJXAyk8=;
	b=kIK6mdd4QyOPTDD8iQNOS7za89Y9sLLGb3/v4tiRTitXB6nwIpIHIJFHwq/NdntQJ+f1
	 LZGVchY8juYMgBdrQ2XsZ1lGiv0T5noZQws7WzJtOgy3CfUdgYRWntqsgSHB3owBclGuI
	 A3CREd0NzuOkFiGls2UmOGJdUUR8ryLaH/DPgA0muGMknamYtfi3uTvD2ZdEEj0lpKgWA
	 zlBygG7ve3JzoXa6X8Ig4iC3ZdGLnGR/dL5IEL5FE5ekoVnS8K3wotNO9KI5FGilINVGT
	 7k3V4Ma60GR7uehP7GEGuq5O5jdNDXlqswDBOmxldthrylOxL+JjSuAvoIvyOTgzlbQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608768;
	bh=ELXymgfFuAh3ncXx2/QvqQFmRiV7lHiMggYxgJXAyk8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FoOA/Hob0rKklH6nIOq/JS7OWsUEeOb/8PDZ9D6S/QLnkSPV7exbM5Z7+k3MuAinA
	 FM4ax8fEt54FK8M3m4fpv4BCHbq+qcC/xHzglQVQnb0JT+tETuKzhxEYbCSz3cRf5U
	 mZHNgNtP9yyCR4AEyKft+ING9E6zTn2FwZxuFzr19+NMSZOVdMIN+lvFMAjwT3Gs7y
	 viJGQhcbhilvLRzNA99+C9l0vX1ODbb3mkrV5OenoauX6P6vLVGz+9GsFz3gjcZsH2
	 d3oziZs4D4IrKbfnVqDMvgNhJLEyMNsQcMz9xxmjSo3lD6QCK8I4OA5gp2HIQb+N0q
	 QJagXDMDWdhSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72E4580FB4;
	Mon, 28 Sep 2026 15:19:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 159713A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFD0D400D5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PaDpvs-SAjEy for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 15:19:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E8D3F400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608766;
 b=LNO7XTGC0wnJ5n9nRuyhET9ASjM5BmdTcXKsNKiZEeqDJAPyThtUAS9Pw19zV+0UibSZ
 uixwNkiHfzsWzKPKEhM5mALDfj1lLLrc99F+wYLemP3uKjC43d2ZM+NasZaLsaVBmOPFV
 Ti2/T5VZOBM0l/+phWcuUQKC5JTV5AfPdVgeh6NtVvsd/AQzNHtfy2HH0CgcKkQ/Xiojm
 v46E7LqLjLd3xWpJJmS+DrWPN9pbzNoNR/WOXCk8WjeYL2JO7VgS2qjdUuCgM21U1qUJD
 /rReLfYF+Jtqq73uVjS/BpwteHYG0ALa76biCeOZdIfgEKMXiNYXqjz/2LzRATItNNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608766;
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
 bh=ELXymgfFuAh3ncXx2/QvqQFmRiV7lHiMggYxgJXAyk8=;
 b=SMz4Ok//5tHPnnVnjeKZbuAnuH8EIs5SW5K3iBo8RaQGmOQc6V/6OOMCREN1HcWdpTZP
 e5VvrOxI5a95F+9yk4N+vF6DVxvyue0WGQLR6KrQvZK3lF4twYBP/5l2eIpAHAOuJKGQL
 P2y+5paZYAmILBaEiWq47pMF3gW0Q7qP4lYfyX+I2HJ9U3e2woNzr2DtcJvyyOV05K4+b
 TxHr8e94V6cNLv3QDt6xKlSMrhtb4RR4dQwz7ntQUlgfQ+HQmuVO2Se6WPO6V0XcyxStp
 cJ3iY71As6HNrBrsukw54HePVL35JIQ76CgaRPnbdmLE6hFGoiJ1Pvn/K/Bmu2IZuRw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kSe8Pc2o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kSe8Pc2o
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8D3F400CD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790608766; x=1822144766;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7TJCocBcM72w5bk8yliUeeugdyYTh6zHxS40yx6tsLA=;
 b=kSe8Pc2oXVhMF5oiSDSQ4ZxhecjCyeOp00qS5IUsSsZyswOODxK4kUx0
 RjVrHF82S91bL6jbhi29IU6IfVInhGqp/6vVzBydprAUM0AbVS4IqcAVk
 an+IOvW+C2QKvDUdViY3Cgj9nPBWOInDjWqngMRcvEp62Xy7sQdVQzY+q
 4DW0jwV4aCgf9lbJVZVK3jWswAv6IIjU6jjz7QEYJcOS3KKrH41yftMfL
 EnXi3ukqHuaCRz+YZNPGtHyC42iFhFrgzUuxi3utgi0MejSLWJwKQIUK0
 2LUzx97EiYROg+GhnpPBjLCtb5QT1QGMyy37az9OYEnqr4ebYZBq7rdhL A==;
X-CSE-ConnectionGUID: VVXtw3hdS9uU2ZqjDwI7aQ==
X-CSE-MsgGUID: NBtVIBoXQ72nwlLM3zZaEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94024661"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="94024661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:19:20 -0700
X-CSE-ConnectionGUID: 9Cka/5RPQPWn+CfU5yf60w==
X-CSE-MsgGUID: iGpS70j5R2e/OclWgFtVkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="271561479"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:19:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:19:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:19:19 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyDUmy+nl5jP3rwp8qGYfN3I1gwZ0z1w/DmfjxM8CL3nrQ6PMPyLKrAXfkqOeF2PHQ985BMumAbOdeOFawW+t1461l7ENeT3tvBw0NUPct08CsCkJYLHb/BpegLkkzPqGqnsqzho8NNZMdEcWMB2ciVt8yO/otWHyl4t27d+VRsrHqdaNu7H1oRbj0gAL0UAb7kwitge88duGPHKewXDmaE9SH2gkL7y08pn/4EArr20k0YMkM89qYmjEGt/X8ST6ZQFRRh7IZR18TBWODVHHqsy/rk65had/SArqB2HDzceZQzkaxWXOzl9oE7679O2dk63CRFMVQ5rk9yO9eBwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELXymgfFuAh3ncXx2/QvqQFmRiV7lHiMggYxgJXAyk8=;
 b=Z9FkubvmhsZzYAbNj+vgTbYP60Bl4UYwIQ8yTp2elGKk752Tsnfic8G6u+bvLNAf4CtEg6jFG5DUaaKJNwjLHXYI2zZjmUPklL9Kk91M5gAqbdiyNofb5VdYVBuiDextyycQgx64H2UQR3UyjnARCCW8TvrDrbUCqnUDkreZ5K6uMLeKXtLs5X5lZG/MlYLkV09LFsKL6AzEGtvgfF4pEMuJXti01/vPkPdvwSorQK/E9OujNWxu9KF4Pngrjby/byEIRMC2gHAl2YryOJRnRUPAXtVcnhNh/qxFsR4TcMi7z409L6sFX9zZwHT8VVw5Dc55/zOAQ2TDpS1D3EcKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 15:19:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:19:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "Machnikowski, Maciej" <maciej.machnikowski@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Neustadter, Marc" <marc.neustadter@intel.com>,
 "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>, "Olech, Milena"
 <milena.olech@intel.com>
Subject: RE: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
 PTP lock and incval
Thread-Topic: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
 with PTP lock and incval
Thread-Index: AQHdTT4DobN9cR1q4Uuyzc3F4DTf57bkHuUA
Date: Mon, 28 Sep 2026 15:19:14 +0000
Message-ID: <IA3PR11MB8986CA503FAEB80262DEFDFAE58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
In-Reply-To: <20260925222824.270640-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: 0afedd90-8774-4a2e-d4d8-08df1d73db51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: KrOGC3uDLi5oVQpfqvDnnTwmjhMDaS/1iXDJhDrlRt6LKJoo4UNb0THVspkPpJeHum5FiLfS8JbjY3U46InRTs1VPV0G9fnEP0E/UeZk+uLsl+5W/r4FTpK9WrZtVlvguMUFlZmpMzLSPXuKBOfBF+H8UJqK2Xi9ovMH7l1O+4WWEz3GOTrwIRBaPdE6dLpu9qIm7zTB9H6OAq79t1Wz47xQzCAGwOQgn4OOfRCAUpmMVlSBsFKdd/UbV8vuSMtnnSxbqDdUZ3EQ7WxjuX1fanJFGYl7Y4Pt/CUqtcqghpXTvkomUhS3Bj1E4tFNfl//4J0ioMjvoOsHcjoYknZxQe8H3ixnX//xdDFZyvHGT9vlMKFst6S+pvYIcYUPNPPcAVQoEk3S0pW18yeyEsZlMwfnHb7qI/Ln7xV9Dxvd3ud6rKIF2nfA7r6F3AhUm28ebNbmWm+5HftQFXR4O7qWJTYEL2Tm9rtvPEigrMYoNIrckOEhwrg7WF6nmfGuliFRd8b317CZlfEzC9IXZxPWl5NNoGRclTLHNrhSFb5tYl/CdcTU0OWFQNiaeFxJYDsHvY62Dp03uuSwUEp1IA1iOaba3bbqvEhpfx5JvVMACyyMiwm1Rs3ZmCXZ98h9qUhmbLsDtr3qkGraYeznd7SHvbs0GbS6LIgOjQ+to3bdLIpZmP5+YD7jeXwEfpz/uYlJVMLQ7flY5zawsDGgCCF27SODobTjwspFxDJpD3ExDG0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6P/iYuVFm6b2OF2zQYPaNigImDsMj9IpU2qx/We5v1a1Ds0WXcpocXYV4SsU?=
 =?us-ascii?Q?0HlO5UltIOC54ZdaXih+nT4MmSX8TGff6enXcg548KwHU7pZB62EdKoB1w1n?=
 =?us-ascii?Q?HFH1WZS33pA/IkKMSShcGsj11Ho+PdV0U4tECKikKcXhv/gKxs9rGLXcVJ1g?=
 =?us-ascii?Q?/7Q2Ce4Yb/UdAKdvVxTC8nJneVEfxxvPmE/W+Fswm7zHyltR9W27iLqmjcLT?=
 =?us-ascii?Q?jgDCKHrtr6SGHlobi5/NhX6dHTZ0uQqONYDNqiA3iK/kTlou5AEJEyOLWtRY?=
 =?us-ascii?Q?Tc/PGNicGptj/AjmQQfBkxMJaHO33oTmH2YGgSgINwtNa5p+0kJ403UD9Dd1?=
 =?us-ascii?Q?jzLBTTI3aAZFBcirRE0q2kRyEhndCNofABo/IHUzndwkWVBCrs7BZCftVkDp?=
 =?us-ascii?Q?iDnb3/x+DvP8cef4qU6FnHH3lrF2OwoxFxwfCubPrSA29YP8W77ZdHKdO4f2?=
 =?us-ascii?Q?RTM2PVwHINO9oEyeghndn+6zQsVJylSgHIO7LvOJayEADwSOkcxkRwS1Lxak?=
 =?us-ascii?Q?EQucrRhGwIWcx1fkaGJIFyRms7M2LOLqhtsVT6ldAQWWwH1fFNjtRDRK2VOa?=
 =?us-ascii?Q?zzSkjDTcOIcaxlG1M3i49vxPWPy8vGiXEFkJ6SX98IMqk2tXUGYSAJyFRMzC?=
 =?us-ascii?Q?X8sop23u1Kb0lPJdhYu25Sm99c1hawkDQHNUCeIs9MKRW6l7+VuQHWaD9N7j?=
 =?us-ascii?Q?r7WKdJ8f+uPtFsYe/xbJ3gD+2PA0JEwXD4FYWqFj8GEEibnju1C5TqCM00St?=
 =?us-ascii?Q?9IQxRz+s4cJYZ4F+OplRuYKXKI1v/qztRqL+C5W1KY6JSYDZmpaOC4vtin0l?=
 =?us-ascii?Q?+aq8/MV46lYeDJ/Ehr13BS7s0eGcmRKyoeU+9OarQvZSHtDnA/L3fLLIGQwx?=
 =?us-ascii?Q?d6P4M1j5z0oCIDumVyuzsghh+VFQxIr6KsV6iwdZfGr8n4SWgYW3RjE/TE6C?=
 =?us-ascii?Q?HPr/90f8eeUh2XQTTl2wBEHRnfiOY54p1jyfjyYuz7QHqYMpUyf3knBGxY+9?=
 =?us-ascii?Q?YHja2zvbI9UjzN+SXYKQR0O10Q5GkbiP0scIRkKe21pFwRv//EgoLoNE7gPw?=
 =?us-ascii?Q?XDwY68TK803w6pTPUz8UfWBD+P7MxCLCKBhXE3Kt0NZNrngSO6M1xlpdXd/p?=
 =?us-ascii?Q?fiSHi3ViHAZZ459UavWqZf2NBRXL7RFkHxMeL1Xhfig3zUOzozRK02ZpXivE?=
 =?us-ascii?Q?DP+wg2FEHKirIvgTJP0tikfu3kiZtKkrB93KUWirJCqUbYsVmrXYzLFJgldA?=
 =?us-ascii?Q?lOpIU4LBsUteFRm/fD5b01aw6hi1PBHnOHwSK193+h0ZJEufMjq0OcDyE+UU?=
 =?us-ascii?Q?EgHFYFNd19ghNwthnL3xTkvK7cIhONibzyUAsU34VnP8dHAiJhIw35dLbMMr?=
 =?us-ascii?Q?FyAh2FsYwYWEDyRCiNoXnN7FnkrmQJetaVb5Je2nkc+tGvfLTHzZYae3LnZO?=
 =?us-ascii?Q?uy/7TjHzilHdtdzRTwDBmChjVjQRcnYcsjdnF3NBZGW6WTTTrWvywZHoyxM3?=
 =?us-ascii?Q?CBvF4Qgb0L2oWoLFKBF0Ar1Ga2TuFNVYbE035VmLATeXlctVoDlAIfXvpCdO?=
 =?us-ascii?Q?pFMrbCVGPsAAY6ddz9iRs1S27EQRFxYqc4YUtXYf9lyThG00hQve1pdohNnK?=
 =?us-ascii?Q?MeCXN8Aq4nbobW1N5W3uXUYZNAGg5ZTAs034XvMENcZPZsxjxosUE1BLJVU4?=
 =?us-ascii?Q?cJqgZ7IOBlYVddx+jI0GaCKe14mhCwAqJ4kj9zoMFX9noeww5b/5gzej20YX?=
 =?us-ascii?Q?f2K6cjTcLLpB5MLO+gJYrejwYHpWQFg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0J9Twkw9/gp7H5cMzv7QqC/keWpoVbV/K/r6bEVYsp9jypxVqtzZmRA37kQ1QtFe7LNxg5A2R3iMFLmBSiu+ZVcJLNue/8e5HRaBHbgymQL5BcDRERbY8eBwQcIU3tq5Aeel9fy8jGuYKFghXxYau2Rs4lN/PZoqNQExCtkfGKf+XNp5WbVknFxoi4IVOhVnT9debv3tcwgy0qEJtnIYXHxpIF0eymUpKpzaMVyNmWkcpXlzCleg3tV/ejSgihmtzd9Gk31qxF4Kl6pkmLOM7AQLgWNVT+gehP+7G6s8AeDTn4z/y0kMj/fOOiqjCQ5oFun/SFwOATipZT1VYXNWQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afedd90-8774-4a2e-d4d8-08df1d73db51
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:19:14.7461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0kqrL9Kx7JrQaa3vSI4wiexDeV8HpAauhAmTSyFxQcJfiClKxstEwy1Ii5gbOWiCsbQlFYqsjWYu0xy5hnsnNzo0XYBUS7LUUC2Ak911Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
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
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Sent: Saturday, September 26, 2026 12:28 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; davem@davemloft.net;
> edumazet@google.com; Machnikowski, Maciej
> <maciej.machnikowski@intel.com>; Nitka, Grzegorz
> <grzegorz.nitka@intel.com>; Neustadter, Marc
> <marc.neustadter@intel.com>; Temerkhanov, Sergey
> <sergey.temerkhanov@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start
> with PTP lock and incval
>=20
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>=20
> ice_start_phy_timer_eth56g() programmed the PHY increment value and
> performed the PHY-to-PHC phase synchronization in two separate PTP
> semaphore critical sections, and touched the shared source command
> register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
> before acquiring the semaphore at all.
>=20
> Because GLTSYN_CMD is a single global register latched for the source
> timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime
> (small offset, <=3D S32_MAX) or adjfine could clobber the source command
> between the incval-init and the phase-sync steps. In the worst case
> the source timer command written by ice_ptp_adj_clock()
> (ICE_PTP_ADJ_TIME) was overwritten by the unlocked ICE_PTP_NOP from
> ice_start_phy_timer_eth56g(), so the adjustment was applied to the PHY
> ports but not to the PHC. This left the E825 PHY clock permanently
> offset from the PHC, showing up as an intermittent clock drift.
>=20
> Hold the PTP semaphore across the entire start sequence: acquire it
> before the first shared-register access (ice_ptp_src_cmd()), keep it
> held through the incval read, PHY incval init, and the phase
> synchronization, then release it once. Since the hardware semaphore is
> not recursive, split the phase-sync helper into
> ice_sync_phy_timer_eth56g_unlocked(), which assumes the caller already
> holds the lock, and call it directly from
> ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
> longer has any callers.
>=20
> Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with
> PTP lock")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++-----------
> -
>  1 file changed, 21 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 20bd1813650f..d3e4aeb7e496 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2045,7 +2045,7 @@ static int
> ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,  }
>=20
>  /**
> - * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC
> timer
> + * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer
> with
> + PHC timer
>   * @hw: pointer to the HW struct
>   * @port: the PHY port to synchronize
>   *
> @@ -2058,22 +2058,18 @@ static int
> ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>   *
>   * Return:
>   * * %0     - success
> - * * %-EBUSY- failed to acquire PTP semaphore
>   * * %other - PHY read/write failed
> + *
> + * The caller must acquire PTP semaphore lock
>   */
> -static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
> +static int ice_sync_phy_timer_eth56g_unlocked(struct ice_hw *hw, u8
> +port)
>  {
>  	u64 phc_time, phy_time, difference;
>  	int err;
>=20
> -	if (!ice_ptp_lock(hw)) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to acquire PTP
> semaphore\n");
> -		return -EBUSY;
> -	}
> -
>  	err =3D ice_read_phy_and_phc_time_eth56g(hw, port, &phy_time,
> &phc_time);
>  	if (err)
> -		goto err_unlock;
> +		return err;
>=20
>  	/* Calculate the amount required to add to the port time in
> order for
>  	 * it to match the PHC time.
> @@ -2089,11 +2085,11 @@ static int ice_sync_phy_timer_eth56g(struct
> ice_hw *hw, u8 port)
>=20
>  	err =3D ice_ptp_prep_port_adj_eth56g(hw, port, (s64)difference);
>  	if (err)
> -		goto err_unlock;
> +		return err;
>=20
>  	err =3D ice_ptp_one_port_cmd(hw, port, ICE_PTP_ADJ_TIME);
>  	if (err)
> -		goto err_unlock;
> +		return err;
>=20
>  	/* Issue the sync to activate the time adjustment */
>  	ice_ptp_exec_tmr_cmd(hw);
> @@ -2103,15 +2099,13 @@ static int ice_sync_phy_timer_eth56g(struct
> ice_hw *hw, u8 port)
>  	 */
>  	err =3D ice_read_phy_and_phc_time_eth56g(hw, port, &phy_time,
> &phc_time);
>  	if (err)
> -		goto err_unlock;
> +		return err;
>=20
>  	dev_info(ice_hw_to_dev(hw),
>  		 "Port %u PHY time synced to PHC: 0x%016llX,
> 0x%016llX\n",
>  		 port, phy_time, phc_time);
>=20
> -err_unlock:
> -	ice_ptp_unlock(hw);
> -	return err;
> +	return 0;
>  }
>=20
>  /**
> @@ -2174,19 +2168,24 @@ int ice_start_phy_timer_eth56g(struct ice_hw
> *hw, u8 port)
>  	if (err)
>  		return err;
>=20
> +	if (!ice_ptp_lock(hw)) {
> +		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP
> semaphore\n");
> +		return -EBUSY;
> +	}
> +
>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>=20
>  	err =3D ice_phy_cfg_parpcs_eth56g(hw, port);
>  	if (err)
> -		return err;
> +		goto err_ptp_unlock;
>=20
>  	err =3D ice_phy_cfg_ptp_1step_eth56g(hw, port);
>  	if (err)
> -		return err;
> +		goto err_ptp_unlock;
>=20
>  	err =3D ice_phy_cfg_mac_eth56g(hw, port);
>  	if (err)
> -		return err;
> +		goto err_ptp_unlock;
>=20
>  	if (ice_is_primary(hw)) {
>  		lo =3D rd32(hw, GLTSYN_INCVAL_L(tmr_idx)); @@ -2203,11
> +2202,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>  	}
>  	incval =3D (u64)hi << 32 | lo;
>=20
> -	if (!ice_ptp_lock(hw)) {
> -		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP
> semaphore\n");
> -		return -EBUSY;
> -	}
> -
>  	err =3D ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L,
> incval);
>  	if (err)
>  		goto err_ptp_unlock;
> @@ -2218,11 +2212,11 @@ int ice_start_phy_timer_eth56g(struct ice_hw
> *hw, u8 port)
>=20
>  	ice_ptp_exec_tmr_cmd(hw);
>=20
> -	ice_ptp_unlock(hw);
> -
> -	err =3D ice_sync_phy_timer_eth56g(hw, port);
> +	err =3D ice_sync_phy_timer_eth56g_unlocked(hw, port);
>  	if (err)
> -		return err;
> +		goto err_ptp_unlock;
> +
> +	ice_ptp_unlock(hw);
>=20
>  	err =3D ice_write_ptp_reg_eth56g(hw, port,
> PHY_REG_TX_OFFSET_READY, 1);
>  	if (err)
> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

