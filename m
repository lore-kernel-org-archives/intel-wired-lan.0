Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64446C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 20:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BFC7812DE;
	Fri, 25 Sep 2026 20:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGFrLVaaQ5c2; Fri, 25 Sep 2026 20:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 40321812DF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790368878;
	b=Ow7Pv0NuNGxgR17Ar1qiVNMZ5PcMbMJyPYrjzAcsj55ZKa+aZBwf6AXHXkOzy5PmjvrQ
	 xhD+r8aqZBoOT+ElCaEgfEAOHOEHjMbbOFnPHLZ/jk0+BwI9PBaaNL/oP0grec6BRSbwy
	 J7tpoBWqctcjijj1APfIC5VckgLAwd8A6vPLqAEuzPTnjki4WbHHn3cpDT82eULFDMBS8
	 DrD/btgDkPH8nwWd4Ig/lZ8dSmSJxkb5QlEo5T5Yf94p9LPedAoGySzwwGAsEgQFmEcc+
	 f6NGzJIWkcSLEBMY9R6i8mnA3XTO4X8zLA0uHiYLU+qqFPCkxXg0q9EA0HfiDTESldA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790368878;
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
	bh=o7lm44jbVYdfyMlRN/6Acse0qeoKyIvsDr9VDA+jQZc=;
	b=VZ/GAI3ZzbGbvf0Jux+tjO/xvUbU4tctXG758QTyKEs8eFP7YsjTQUycRdBV9G4IncU6
	 oBrOcpkDjcGx74Wej6inDxsuevDg/6VhA4Qs7lPDNQpFZd3MfDvyjzA4/+20/SJPpsJQ1
	 6GRp3zeEpYDG7Cr9vCP3I02fHow8ex25VYd3sd2KVABCUsQKRhauM4+e+L+cFw/jnZ6LP
	 5jFqWvQDf6zC4fEKuC1aGab5KTrHH57k2sN8L2P+5ZezBln+oWNZCPkO4M6A/c6V/q81p
	 roxUAvCWyJWtzb5UT6sKdj/x6D6lKGEPw01rcGm3DwuOJlkfJLgL5eJlEgc9Mm/ptUA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790368878;
	bh=o7lm44jbVYdfyMlRN/6Acse0qeoKyIvsDr9VDA+jQZc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lznq086Mqr01Cn+djjD5jCz9C2xUx8ZqTJ0Utf3EgHBfYdBSMUgo6xkObod5Ws1uq
	 /MeypVCRThBIIXL6szmWZ8o0lvy6yDC/bAdjWGMidCmuXuaRa6AL9dWBSzc99omEdH
	 J+p3R8aO5ut24QKDDJPlwqJDGZ870aoWIKkEZuOHKzRcRMZYdxitwq7gRNuHcVgpVG
	 MKb7nOz9TAuqpQlxuq+dZRolnvMv90P49kRKnBjrdy6vuk3l8pCT0UMETySRA8rtNd
	 P1uKPM2Jr6bNGM+s1AsIeZYiwefb5Q1PxkUaielIJIpdr9K6uBXymLdMpf98FR2LKo
	 LPxfmbqTtggNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40321812DF;
	Fri, 25 Sep 2026 20:41:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55996353
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 20:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 441B940B1B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 20:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqDWA1iq-LnN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 20:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1BEBF40B18
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790368876;
 b=TvEPeAXbtHfs8tI/mqLjXcDSfyn5+Cl47w/Du7vTmbJm3Add6dac2lYievKfEC34hppt
 8xJNTgAstZAgZ+0JAI7Y7nwvvEzoUChp4xbSGDdsRLijE4yOYZXQqrBjNqE7hruld2pri
 dvXm2weSxmU6RoCweFA96RcEhjdc7JAp+QQmuFDfLuBcTeZbyomTPwjFCEDSyRdN40RfL
 VZSdgoNKXG8MfjcVhf6ap3vm48yCK34RiW5XoqyozTHsHS0Qyr1uyhq+YAcIygz3Bae68
 J7D2G9RCf75iOnck2vz43+qGxs4paQHdo/AY2Qh/uJ5EjyJyFJFgYbaPzZEuWLmHq4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790368876;
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
 bh=o7lm44jbVYdfyMlRN/6Acse0qeoKyIvsDr9VDA+jQZc=;
 b=HI0/A+BoBUE1ysjo1lpMKQRdhMpg6mftjPAamvLThglw80Iy5ucEHuzGttBNbMKlf0j2
 bQ8iNPsrasVYI4YNDHQSfU9mdPqNAG25ZcVKHzve2zFfVV4dqKQgphHR2VAqrNnx7pEvR
 ac5B0ukAtpef3+qNwRha/qB3oPGhIi2QYDtEZS4+siNZdTclkCOcHyIa7E4+K/8ghrYlo
 9nJWhuJwRLyhcc1UwJWt/4p8DAkhi3EbvjfFv47r4pzhq1W1umIvqlEu3f7GgYNEnlkmT
 yqBVoYOP+MDSNPuGem+Orj9WBXWZoClWfHBC5ueQZmKdTQ0gK6xJ4/eklfVYHYd3S9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U1VHKDAG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U1VHKDAG
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BEBF40B18
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790368876; x=1821904876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YBZc2cl5tNG0VO4v6BHx59lrtce5/qw9JNHTgdzfBTs=;
 b=U1VHKDAGic7paV3qYgjTS1cPsDDp5vncIeSKB27u0qggUvRRpPp+JvXC
 QDHNBAaKTH9cU9ZNP1Bh77BKaVvfqm/mQg+t1kWvHo93nI86pNfgzorhp
 WD/lgsWHeKVPIePrzgoGnxgomrekEcwyGTKw1xdJOSHs0qQCeCYDqM/Lb
 PBcip293BM9CIXexjk1eKn4DoJi2+Q1EjLJ1GoR91s96J5S2GDYomhUOE
 /tWsXlr3teX7wZlhYdtQi4PYrQUPfC2gOPl6qfL0ounh/L8KccJZZ7xUx
 mIbs2Tyzmxkq/rBk3XC8x/hVoDGFyBIspPALUZq6U8YMZ37yi7Tnd2id7 w==;
X-CSE-ConnectionGUID: f0BcBXPpRS2hxwHzjQRmLA==
X-CSE-MsgGUID: 4OZO/G9lSSW2jeeyVBL4Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="102525507"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="102525507"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 13:41:14 -0700
X-CSE-ConnectionGUID: m5OhvhxZTs6F/u0ZCYNvfA==
X-CSE-MsgGUID: O/SJ2CkwSNOOHNdexLqFQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="277784904"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 13:41:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 13:41:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 13:41:13 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 13:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBOxQ2xZxTUU6AVcwU4eGFiXXmHNpWUhfCC/714o2ih9H/OYsy/nmYu5Hk7VMPol0hxiW1YyDYnyiIfkC1AFgUd2fWWuE4bb7hHNpE/tYA1tcN0t0kKMNL6chUrggRTeH0PTlXSYzBGvtuTozRwsD+fQ8rKFvjmyYOxEYdYW9mcRlQXK/zI7ZkO9EuaYaHUkbIluDJrwSlrxUMv8godSOzqlKGx96HyTiL72CLpFJdsbvoKxgLLwLWjfEX/IHcYx6og0eqrgZh2TFWN8AnPeue7kjfDvJEuHrjsXxyfBq5SOon80rroBrBBo2HbdiBJSgxsRtPfQKWtnRApLLm58ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7lm44jbVYdfyMlRN/6Acse0qeoKyIvsDr9VDA+jQZc=;
 b=D9Uggp9/vuxU2rRcpQtATis6FnMjR3c7JK9qGy6NUpo1oNND1KBI5a+rdVhxr/SIZfKXcpK0uboVDOeu8SOkDFXaBDcgsK2N9EKyZVZqLQEvjQ08CI4Q+aASCk2t4/4oEXeTPawPOxp0drh4yW/Rt1kTolSSbdCpVVai/GuW0z2Zxp5d+w8wX28c5GbmxCUBh04mle2gMEt9WwZBNu0aSWew9ooNY4XT5WBUZutEOy8kxoJk/pTpbEO4TI8p0NXCZDZxkqL1o/XC+iXpMbMhdFWZ6lIV2G32tN3OtcBylCWN8yYtlR1raoF2an5F7H5WdJEhHoSaY2vLzRPhFippBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 20:41:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:41:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Ruinskiy, Dima"
 <dima.ruinskiy@intel.com>, "Avargil, Raanan" <raanan.avargil@intel.com>,
 "Fine, Gil" <gil.fine@intel.com>, "javier.herrera@afronta.com"
 <javier.herrera@afronta.com>
Subject: RE: [PATCH iwl-net] e1000e: add system to disable K1 list
Thread-Topic: [PATCH iwl-net] e1000e: add system to disable K1 list
Thread-Index: AQHdTSMFdf67GPg66k6VQKftGPQT77bfwezg
Date: Fri, 25 Sep 2026 20:41:05 +0000
Message-ID: <IA3PR11MB8986604AFD6E6AF5F1F7F599E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925192047.3308768-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260925192047.3308768-1-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB8893:EE_
x-ms-office365-filtering-correlation-id: 856586c1-8455-4c0e-644c-08df1b455230
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: V+oM01DGcIorTpdJX1KVvYN0JdlEKlyMFNvEGYt6GJo1jOLdAI0Arsst/9GKKxrgwlsBOOwXUehfd5lzYmtiqqp5P4wwM/mEJzPo54OMjsaUUoxfLnKLF1k9sNd9wMeqiDKdEzUaDEd2TGgeYILXuTd7/0uj++nTc3cAhgm9Vci8EmQLszne2bE1q9b5bX1PPkRXP62sUyOEYwgMA5KpIyhm6hPUKe2xBEwfUuYSKd3pxjOc3G1Wvmzn/0w/iJg11lC49zs4WmX7kSug9b1ykwODg5Fkr+Dn+OGD4aVxzQKRiO2E6RrlZMRdkqQ7K4k5TxsNVuIaSYkbQUJUgAVQ7eTEZUsoPraNRzmKRdcFfYru5El4uOovwaefXpJOul+Ios0hjDuDD5HZqPykjCjXN3FMV3elMXMyU4Efd/Z8lJJlMbX18lSRSgDwYfji7gql5o8KyHw3/FvITU/DSQkyV+ihQ7pMc8s1DgDYWjBK1lFtMxNyaIcgAzqRgqHoknRxjGwCXpK5ahqxWTLCLCJA62v4pnaLTx99/o30LdMzGggAZU6d985qzUgVjMEiXos3cdRJOoGiksVQT6mbGCNlLgqq/hYQgwoKkI8CR6FiYlY2aKMnfiymmz+q6sCmmfvnjM1Us8CLfBathgTs6Cn4S/gWvlabxeGRkJEP4JMHJBZxidjjmnzoFLcELIfUBng9rMZanrmOoYq4ri1rmmazKKjnCSYHwP2oov+JcoWXi5E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f53ka5VXv6ktEQ42pfSHuoYYozR3R7F4IBgycVBsgQh5423tempz9JPu0jCn?=
 =?us-ascii?Q?LzchUG7MVp2mDNfzFiGXzXq+prnL3F/IHa2l7Ue3siLFyqo6CGo2Z/a4/5XG?=
 =?us-ascii?Q?KGjW7Ay0dh9CyW0c19P8P697bgUCVwvV57uHZOqscWzRmPDj82mT4ErpaZ5T?=
 =?us-ascii?Q?JYeUUTiSu8zohn5ANUSphvJYjovk1msFxfTHqqb4tliA48pTwp1zNDPHaEMu?=
 =?us-ascii?Q?dGSB3wRTaSdYMJ1VjNfuVENYkfRwnHMxvgGH+WwzqMtrFH04f0wjl53dFAkm?=
 =?us-ascii?Q?kkupIFEN+nlu9cY/h4mCqnQdq4Y53oQTEgv44SN7HUhz3603/dVQJ4lcm3bv?=
 =?us-ascii?Q?5SKTjfLWVBV2o7DU2jqcJ2RLTBeTlYo9ZH/WN9iVp3SQ7EZ8ZmHkjyWdhpwb?=
 =?us-ascii?Q?IWegK8nZaQrblsDWGN0pavkSwjpIXZtUBxWISrVzFzd3tiZwAXwr3tPHOQj2?=
 =?us-ascii?Q?yb0HTL2msR0lSLRpPIdpx0B6AEcdKotzfSZuKl7LAlfmqKKqerBAMijFnsDJ?=
 =?us-ascii?Q?YboArEFkFBsx8ogguVPj3tLE10t+qrfR5PiX9HQxnYhgRZTeosevS/junHFZ?=
 =?us-ascii?Q?6TnPGrhD5ransy/IqpUTljYFfvuHGUOXjy/DiWVbDwHkDdXTQ4dOUU3KmEgx?=
 =?us-ascii?Q?gTZ0zw1u0ZM+LbUbfKO9JJhsjm57JTTBvJlExVLHDYPXfzjM4GQeMJScOxQZ?=
 =?us-ascii?Q?W9YfHlnpmnCoj5hGw2YY22JqaOSnrgrXOb06fMD0lRNeKbYWqAXc72+7vknC?=
 =?us-ascii?Q?xqdOMAjLN8kvEj2ahiIIa0oxXsidsyrsXEQadAzTUtt9rDNC7ieSL10pWBq9?=
 =?us-ascii?Q?8I+rS8JpliDeYH5lZRwdZuBqH8UYVAtlZp3e/mWabYKZat81MFG+zhUliufi?=
 =?us-ascii?Q?D1LoYL7ARwfC8bBnr5xCPijP1t30SVRcigB//cExy4Ydvr1sHp8EeKTDGVCm?=
 =?us-ascii?Q?Na0d6ZYrYz7YynvKeQHHiiYa3SfG5p49s+EVomsZkKfVxZ2Oi+bYVJzal9uz?=
 =?us-ascii?Q?IdhGwkOLIgUMixiXvcKfMjAjnD3Yyh9Oa3hjcTWC2BmXMAKfV7pw3hjW6LdB?=
 =?us-ascii?Q?KpNfpZB9qIrsnGQX75gfTPHhduV1fUxl0Os7k29aJBNPRjo2w99f6IrYMzyy?=
 =?us-ascii?Q?euAfr4mp7fucXURHXvuZxqksGJgs7yFQ5ivsJvjkIVNOOdevOAMz52svOg4Y?=
 =?us-ascii?Q?LCCjHXorhyJocuDUXygxu6KH4DwgdniqrcByX6hm8OkSdssXQfwdLCN8bHpL?=
 =?us-ascii?Q?oPz2Q8987zQpbFFZRyuSb3RgZ3YLy5EB0uWSHp9keNRuVwylM7tPzCjF7m32?=
 =?us-ascii?Q?2k6b+IbC7MPqn0IUmjhaPpjxoGUcWa30L48TlkO1g9JkN+YzgFZmIcW/WN8W?=
 =?us-ascii?Q?A3xLs9uSKJ+2IVl4877Q9I9kZod4IvPz49O8edeL5stuflz1UXi/gQ8zeXGa?=
 =?us-ascii?Q?Mf3ok9TZ8D5a9tueoRXfhXuYiziIpzracXNf2/jPuBMNWRj2mw4WGl5/4Byo?=
 =?us-ascii?Q?wjs4u5pOYjhyDey3hNLIFPVJogGmSSb02XUJhwXbhMFjJXR5DbpRwKxVDD9e?=
 =?us-ascii?Q?lwRYOMNateG/bYHap6D3X0s2tGMaqv6Ey/qw5MnLKP+yWqnk+2ef1QmmoIqG?=
 =?us-ascii?Q?oIojQ67iw7TEn4ag002I74QGrOv+H6Ozj91kyKGIS3GRBhIM89hHjyUofmxy?=
 =?us-ascii?Q?/F1H1lTBE3lFqN6RotD2eBqLkMpCpIXBNeaTG9XVtGSjOGJ7pD9CDXAh2+46?=
 =?us-ascii?Q?s4dca7V6Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5IOWvENbcFrcsT6ZrQuzMTU5B+2xnDzlBcAgWoR+lf5q3uw7QDoFss7kCD4bVIda61yhYCUiSd3DZXw7V9kEYcprhzwwueuHyCv6aCvl78dEw9k4cS0QynNEOqmnxzcVMSdonliwu8LXeJi2KitmjWJamh2uhBpl3VRnFul27upp7pFUIyy+wr56z+pjQA5f12wBs6oCvNS/Ioik2aq+ZmQqk8TcFulBdmH85iIvCNnWeuOsu5hQmD5sTUOYb3QWHNS4OFPeNOgDmb7HVX86Df4zcPR1dm8QA6Hrt8/V2b7XwJcsgtzEJSpNuMVXHfonXA9vjjSVXgQEDpr91UknqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856586c1-8455-4c0e-644c-08df1b455230
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 20:41:05.5381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4SLA4hr8pfzyDFzNSMZkyYJnXFzWzXW/HkAmA7UqJrobY+J/Y8+kQHMvm84opUA9C4greisD8n9zP0s4vu5wN+4F5xtq5zfMmTzidV3e20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
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
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> Sent: Friday, September 25, 2026 9:21 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Ruinskiy, Dima
> <dima.ruinskiy@intel.com>; Avargil, Raanan <raanan.avargil@intel.com>;
> Fine, Gil <gil.fine@intel.com>; javier.herrera@afronta.com
> Subject: [PATCH iwl-net] e1000e: add system to disable K1 list
>=20
> Javier reports seeing issues related to re-enablement of K1; disabling
> it makes the issues go away. Add the reported system to have K1
> disabled by default.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and
> re-enable K1 on Meteor Lake")
> Reported-by: Javier Herrera <javier.herrera@afronta.com>
> Link: https://lore.kernel.org/intel-wired-
> lan/CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=3DexMjsknXMN5Yh9A@mail.gmail.com
> /
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index a55e459a78c1..9e22fda7ed93 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -67,6 +67,13 @@ static const struct dmi_system_id disable_k1_list[]
> =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 16 Plus
> PB16250"),
>  		},
>  	},
> +	{
> +		.ident =3D "Lenovo ThinkPad P14s Gen 5",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen
> 5"),
> +		},
> +	},
>  	{}
>  };
>=20
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
