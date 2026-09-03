Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CADC624D6
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 01:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E44880935;
	Thu,  3 Sep 2026 01:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFiJa0Cu9OwM; Thu,  3 Sep 2026 01:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8B52A808AD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788398265;
	b=dvQ1Bo32FfYlJ4FOa4difbbSGlCULVhuFxc8fhmfrAFAqslgs6G4IuBbrdIgbTKLIwFv
	 Z+Z4Ut61AKIbbsiD7kpvUmJaa7oysC3hL4nO7IPM4aRBBbTIRtjCi8PwnE3IDucMzR97I
	 esn6hcq0Y+IuxyKTQmxhi+LV24Qoo9VEWTL6tsSOl0X3wqfCd8JGGj6P0cOrF0tYP0YwI
	 fwsmPiwyYrnylD+J3sSOHPWUM7g3agzWqLi/rEoQid5vnBgXZELrm3WbP4ViQa+PWR93l
	 xcDyeGHNdt0Vf25xFXjf0g6QPl5t8jpk2sLK9bgRB+Xb38jz/0glhdZRSMzghEt3zCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788398265;
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
	bh=osmz9MH2/6atGWrik1m5WewD1nlFoBYp7252qZWF6jE=;
	b=T/XWL3tDsrvBN6fkWIO9E6xV+ze7DqXu/QtDHH+HNsPpUJKquAJ5ryXW7QeZgxGffUux
	 hrmM96HVG16y0k8g3v67d0Ku85HEx2MgfO6retoftHzzzmBVoEVf3c27T1uDl1iHa7OSq
	 WClsAtXs4xcm4dYLo0jxZzx5u2pi7AG0sReWgNbffyT0dDQh5jbBNr7vuO5vbforWHohu
	 i3QHGNHuXRi+FAco4eRd8FNN2ruVkS2xRecQ+bTsr0cq1Oe9KzjNEfdsN18p9TqKglS5L
	 jT525Z1gWHdr0Oa6V14/u9rGQr84ih254UJFNvTZ8eqdxOMxCYfLufIM9K85Izwagfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788398265;
	bh=osmz9MH2/6atGWrik1m5WewD1nlFoBYp7252qZWF6jE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iidrWDcn1I5OvC3m8eWHsOXKtbcOpzkY+njn2q17XdaaPKDUyBtU95b6DWWvcK2k+
	 faOitTVAk2njivXi6k+fklOL6w311VBJDTOh7cySiDv7YO2KdceDRrdMuvCvA4yv0s
	 MyeajAgqv9GnYj38/D2g19pQf8R8HTcmJ7o8i+kTiesKSIGvgmlP9vZEIIbSvLUf2l
	 hxgVgXh1Z8U1pUEcRcA7t2zGlOSsecVuTNlG+FB56JhUod/sJ6jqDwp179mQ2r4NR/
	 EVNkgM2bLiFR18jExh9CLvdyF90Sn0BHlDlzVBbkPamGBRg349cVBjRxjJNmzeRpln
	 GEhMMAfPZkHJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B52A808AD;
	Thu,  3 Sep 2026 01:17:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 176EA34E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 01:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1447540A98
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 01:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LqbUWt8sbo2c for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 01:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 08C2140568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788398263;
 b=sofLJAYLaPgHv8ZEtzOEKdb0fKHdboBx9OycR2Jpv+qCnPdtoYt5x9ftDtOWJUwY3b3C
 prh6xoNRgU1VNgoiUkGzzrREtfp/o81dZf9zyGHAFh1Phul5bh8f+K+aKCgNKIUEy2lPE
 EZ0kw2qW4Qqx0Mybn1Ia+XvfA1yMZXT/Q8V7Phnk76WtZZMRit8sfs9Yuod+nZqB92q6v
 OA5TosHbUtjp7YmfWvo+UaeGGozoGEYfs7gaXxSyVhGTKGWHlsSZwNfDdV+gUCgaSI417
 J8Pdbpoj7udwBIbtVSAWARRo/D2rxGz7igxzXuxnamis4s7/MAH4TcIpTHKgp9FxzLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788398263;
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
 bh=osmz9MH2/6atGWrik1m5WewD1nlFoBYp7252qZWF6jE=;
 b=VhSoBttYnUcYNmOf8kzh/P9kLFSKK0ILb5zpb8FfJObbuwUWqotbV9sDJzjOdbD8RQgK
 P4MTjkACWydlkbLqJ+FrsH3hqt7nHM0lMg4anhGOZUPT2dDMFiXgVEwVL8GP4MvDFAOvE
 Z4fEDhHbiOvEoR2eWfWfUoTWC66GGlEccshuoL01u+PEoWDelQc0R877bBXvLhhUY5dgd
 JKv1pHPMFRsKopYcm2N2HoFJfAp/VKvQISChavz/pxPfyDhZsTRRJBWFWyVOhm/fW+OzK
 aURAEYb0SiQvYCJV1+/GJPFsqn0OzC0j7c2Gh7tTM6YLwrVJyegLnK5siajSRKhkH7Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ADLd+ZE0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ADLd+ZE0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08C2140568
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 01:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788398263; x=1819934263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Wz6jTqSy21woH/YCd0uOb2MfFzVSVnX47qE4UofdqTk=;
 b=ADLd+ZE0u+s6eMm1jHHCPCXCqJAnodvYWPR20Y1lBJyVJgHnB9ECoLME
 GEtuOT4tuAaDeYeIzTSpIaigpUbt7o9JbwUKKie/lUDVH99Kz6VgmLO0U
 gnBwpSJkTTM4Qqg429xIIUKq1GTQnEQbgS/WoxqQwx/TJ4xdkeaPBBnsp
 nMw8tEN+Hsd/bC3W5tbTDUneI6HmTICjxNX7gf3qZQf0J7qWUZR/yY/4N
 cSoXRqO4B4IDG3btPANTRagg2iH+5fZzOyFV+VpTzn4fhU+FjC1L/8wzf
 vWaWLAzLrUXRUDLzRhnGqe1K8vTyXVW08AGFiumBvhIpEDU8pNQCNZbKE g==;
X-CSE-ConnectionGUID: p6LKPOOmQGiZpJL2EfgMyQ==
X-CSE-MsgGUID: 4fidJ0KGQH2Tn69IkYyNgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88793320"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88793320"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 18:17:41 -0700
X-CSE-ConnectionGUID: MaQ68o9ZRPiob/JX6PkKXg==
X-CSE-MsgGUID: pEPzKSRTSb643ZBNqmrkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="294425178"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 18:17:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 18:17:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 18:17:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 18:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2zHP9ZhYasNjj9l9nHtXGtF9vDj/8kSsqJ9d3uk1MOuroloDOBObZ2/DuQBOMF7B6VXCfgCk8iX/nBZcIarjPlSJ9GZyZyqJLjQebdgnMYynNbLaNJ3HmcWaUqsQtwgs3VJBJZQMJyyRhenkXHfXPQdrsXk53PhVhdK03GApxybarpyZgYkg7es+UuKTovLSXKgWmB33aUYNOPlQZ7WDjnlEemH1y+jj7uMmQcOAvEu3c+DMSYOQT/J+273ukI6zLl2/Ix+g3MJ2WnDezFbh1TlrpuPt/mJpQIMl1TuEa2aYyCXExMg/SiH3WgaNGC+XQfT+ydq+MnbgGAMRJCwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osmz9MH2/6atGWrik1m5WewD1nlFoBYp7252qZWF6jE=;
 b=FuU3oL4YLKfgxrTZ/xhArhUkAyhdYMEl9PdGZI/RO1M+qSZARV/jd4DQ9yUxsGgfKK9UH24JEoAudOit9UCxLUvsg1CTaCA3NI1imQD2oz/jCBT/UpYKAc0wxLfevnmstjZL+tkAX9QE5lyk7QR7oNUgAL/imHwUIB79qYWgAe7qXdifOtMoz8rFrdmP/kiZesl1s8d8S9jBVd+AVP8nancTvnTChB+II5MKRi1xp0Wi8CgFBq8Goun4hZL+3WDUw+LCWg48nE7RFGCRvKokFp9cIAQ+btizoWXVciylZZOrtfhJZ1QWPbSYT+6YC7Iu2GA/4vvtsi9v/fg2H2c2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by IA3PR11MB9328.namprd11.prod.outlook.com (2603:10b6:208:579::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:17:32 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 01:17:32 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Simon Horman <horms@kernel.org>, "Tantilov, Emil S"
 <emil.s.tantilov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on
 remove during a reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on
 remove during a reset
Thread-Index: AQHdKbVexRBI0LQwjUad5CHa9QlLt7ab/18AgCAxHDA=
Date: Thu, 3 Sep 2026 01:17:32 +0000
Message-ID: <SJ1PR11MB6297204BCF0232701D48BC9C9BB62@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260811171751.22165-1-emil.s.tantilov@intel.com>
 <20260813134108.GC265046@horms.kernel.org>
In-Reply-To: <20260813134108.GC265046@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|IA3PR11MB9328:EE_
x-ms-office365-filtering-correlation-id: db9246be-40a3-4570-6ad5-08df0959212a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 4pfhvZwXqd7i2IbiuhTJMzB5oo2AgFp8iqNU+cLkPrWcghYZg2OCOcfkn/nAfkVoBPXG5L4ztvnvQ6GHQpNQ+SSuKg9gTfnWwToIyoPWpVdhQCmuc0GDREVYJisNmCIaFPqXzsCVRLZwqLHkp4B3wAZ9KpC+M42WhADc3z1xb7B5KeAGSgSqap+yvFsgFUz6mmCRcI9JqruFJIUMEHW9iBo5gYq3Y0YLz0xfJyBYsiVAdmklhUoIjCotoiQbokH6snWKYbYdic5PG742c5BPECdcQOdIj3KeP14ejQw0GJz/7tWAT1oJBOI375dSDH14S/Mbq+I3/nScJZa/xZ2UiBWMcifZWtKv5uoLV3P+bYRLrxDNpP/WmwW3wVo9JT34SXeEJJTIgzUgo/kOpaeN4PB147C3OwAteb1+HrXNERxcDdvZB7O/9AnXSREQOCoFIArL/fjTpKNB5tE3ugrKsQAq7dWLrXjh5ih2e0X3flKQYchNMnBY4/k/YFSUV6lue6GbBWrVFg12OHzoGDesvTv+Mv5VFiSpJtinVifuKUMjMuF55hYrOcLUXR81Ien8rCl0MyMZI+e2NeX9W2RGX8+IL2OVFngYp4Rwlf3nxPvl7VKjXejnfLdif4OXTSeNsY/knalrtcCDQGudyQFaVz5PBhENdcSZ9EfAAYrWgzIMVuOEpDsFqglxtHJ+aqS/hn2DArI7j4h2Aje2SglE90GAqY4Wzv4o3LKLGtlW7Vo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJXf8UPctsjiiO/Ct94lJ08o16N9Q8Iy9hy1JNX0se3SHrRavAddUKMQ0vvO?=
 =?us-ascii?Q?qih0vsrVz05KshEy6oGcJodheG91VIRr1BXzKamIC/o/ha/BWZBWiOi/ag9O?=
 =?us-ascii?Q?n/deg/vOOWxUag4I4+07xC1NE0FPENXMwxjITcXS6LiBNpxpSdMZaw5w2gox?=
 =?us-ascii?Q?7sKVm0SrVu1QseRTf17mMVfRrxdWbkZvzmCnPIKmBeGadWSF1efIALgVOuqF?=
 =?us-ascii?Q?auZWNONp7cimR3VsmtA84hgsN382wqeoYeccn6H9TMKET+f6FlcC3tbFTz8N?=
 =?us-ascii?Q?BpbqPMQvgiv9F0XW30CSZtOfCF38UP2Hz+GvFSXJzpnRSCp2KywZo3yU3xhJ?=
 =?us-ascii?Q?ufTVzxpnxRoipjMPfWjNhqoq+rnsUE7LeDCVTsq31Kt/qMDUZM01F2Ybls68?=
 =?us-ascii?Q?aWA9DGBSeJeWCp5r3lvFKoAAu4EE/AXP1LzvkDM2fy7qpJe83MVMONkT6ahA?=
 =?us-ascii?Q?8vzLxG1BJpsikaJNVCwRXlAxUTIW1eLO6KBQGa0rhlUXZqLhElCq1EE9R8gQ?=
 =?us-ascii?Q?8GZXId91y+qhlKyAKTFXiAIzcQYrU7AiEHlmwPFYpd03pxit++IFXEWId4pG?=
 =?us-ascii?Q?SKk2TJUuCz3KsVELa68V1AqzMfYxDhOs/WuG/8M+UlZ9gbNl5D6+9PaIDcGf?=
 =?us-ascii?Q?6GfDgLJHlBWJ91t27IOLZFAko2tynHdfKnHydpnbw/Xai6fNDmQhH4WxlY0p?=
 =?us-ascii?Q?e17NVFc42uaS+5cEu0tc+WR6DL3aQHMssz4ToKr75jCwMqqpSvx6nAS5zHjm?=
 =?us-ascii?Q?zVlCAIA0q0X5HzVAGIrLkbIeZJPZht9Z3XdS+14kaAWiTqxOIWikWHfXGtJV?=
 =?us-ascii?Q?JwulQUfGWHXXQLwMJ8cXNGVEHac0VpzuSfi5fSS/3I1rVhDUgLDbfHtSGaKz?=
 =?us-ascii?Q?JuwasTehd2fsF8zFLBu3Ibyzt9uZkmoVfczuSg9g0pBH2v9aDvyX2MZKK07u?=
 =?us-ascii?Q?8YUJ6s0kX7qcqjrEx4XItDfDracMHC1xsRhOnSsGU9pv+EwL4bBZLEBi7wa4?=
 =?us-ascii?Q?w3NlTd+y0taSgCq/tButNw8InQmoKE+qfM2/3EZ8duZqLFgqbQx4bXmtsZYb?=
 =?us-ascii?Q?9rPCBFkvOaIM2RKLo9tmj8uW9OsHqjit/C0wiVmdrphHxG98S+/t29EdEvXe?=
 =?us-ascii?Q?iVeFhfZ0NPCIY+3nhvNPPxMsPhsdJfrwkosAknbBW8H/gGO6cQgOWwa7iGfs?=
 =?us-ascii?Q?I+DNQoqGdTP5Q42TbgbRj8tdXavRpAgPIqDUhSOd4lSRPbpPmjZ4AsUEjZu6?=
 =?us-ascii?Q?fqB4RPXCM3/hJ8lJCTGkaR8lJnXjR4lZOugZyD+V45SnyNt2lfuDSsowskTL?=
 =?us-ascii?Q?v07H0MMrgZeAov+F8n8LxiCwXSavYwSIDdJ2cuDtl7WFguuZLtPQmM7IoFlK?=
 =?us-ascii?Q?0R2n0aqflp5CbCakd2vu+vDfC9f3bdoeLVf1z8uQZtUPINNkjvcuA5BUZG1E?=
 =?us-ascii?Q?/S//9evb9E/mCGWcdE9MZzfTUJM297HErQXaqbjPo48WnewFPUVGE6uToP8f?=
 =?us-ascii?Q?/xacQRakN/oMsLAqhOROpntcpKxh/d1MjbfazthG51Q/cBDQMeoPiFE6w47k?=
 =?us-ascii?Q?RCRUV1ItvmOxLiRprzmws8vjwdxOJ69WEvIpcxW4mnYt1gX41QLPll32Oopk?=
 =?us-ascii?Q?CdOo+rI0bCIohRsajj8v7TdedqAM6nIIUxo6mp+tpoBoXeydk7WavhK2pcil?=
 =?us-ascii?Q?ty4w/SsHpflopNvlwvLI1Mi1SllmkrbhYiTm3vy+reofXt4+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M3nBzk37ks/K3rgzPoGj1Mle5v3VqpYkaTPwUOPtWtYDzknRYiVkUdapeFt7k8mDty50RYN9f4btgsjQYVKOSOH8PPfCNtBDXbDK5a/Qp5CtJAE87jPWDhaYJwW7ifPMjAOYBy63ZcQW/d4eWVMGYbFtSXBGg9SEzfh2PFSFhGbfL5U+y3jjrb49gNgjTgM3GHxnBupL2qq6MTQCLYhTNS0NlUcrIhktFfR7CZxatWyX1YG4nF9sayXBrLsBp0uPDcMcmsczrSIuOxhW9/NRqq82qbVwoN/U4eJJWNRcNI1F8RcqaCE5k939V7cqc1m7bWfhit9/AIks8adbbdjWkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9246be-40a3-4570-6ad5-08df0959212a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:17:32.2532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Og0z/4Uj4mlyADs6IJJCCLpnc7NNNKBXMP7BizEZCKDbc76hBErnrs6YQExVhqIKPFDP4+qoN9WfkmV8jCnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9328
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, August 13, 2026 6:41 AM
> To: Tantilov, Emil S <emil.s.tantilov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Hay, Joshua A <joshua.a.hay@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on=
 remove
> during a reset
>=20
> On Tue, Aug 11, 2026 at 10:17:51AM -0700, Emil Tantilov wrote:
> > Reset and remove can race, leaving NAPI registered and enabled:
> >
> > modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf
> >
> > [145561.805104] WARNING: net/core/dev.c:7699 at
> > __netif_napi_del_locked+0x11a/0x130, CPU#30: rmmod/22393 ...
> > [145561.810238] RIP: 0010:__netif_napi_del_locked+0x11a/0x130
> > ...
> > [145561.817678] Call Trace:
> > [145561.818125]  <TASK>
> > [145561.818653]  free_netdev+0x110/0x2a0 [145561.819109]
> > idpf_vport_dealloc+0x452/0x460 [idpf] [145561.819668]  ?
> > enable_work+0x9f/0x100 [145561.820133]  idpf_deinit_task+0x51/0x70
> > [idpf] [145561.820694]  idpf_vc_core_deinit+0x32/0x170 [idpf]
> > [145561.821193]  idpf_remove+0x40/0x200 [idpf] [145561.821667]
> > pci_device_remove+0x40/0xa0 [145561.822132]
> > device_release_driver_internal+0x1a9/0x210
> > [145561.822691]  driver_detach+0x4b/0x90 [145561.823161]
> > bus_remove_driver+0x70/0x100 [145561.823721]
> > pci_unregister_driver+0x2e/0xb0 [145561.824207]
> > __do_sys_delete_module.constprop.0+0x190/0x2e0
> > [145561.824715]  ? kmem_cache_free+0x312/0x550 [145561.825213]
> > do_syscall_64+0xc8/0x6b0 [145561.825709]  ? clear_bhb_loop+0x30/0x80
> > [145561.826216]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [145561.826602] RIP: 0033:0x7fe628130beb
> >
> > Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of
> > the IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to
> > tear down NAPI in idpf_detach_and_close(), which runs under RTNL lock.
> >
> > Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a
> > reset")
> > Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
