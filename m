Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECB4C5CFEB
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7277811B6;
	Wed, 12 Aug 2026 10:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYu2SjgDhR2H; Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B89C480F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786530729;
	bh=0K84AqlI+ZaS96ConHBNFTzdY5SuiA5qXWk1QEapRkE=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJAbQsvqp1SoCLGZm7cMAGBZ1xgARLOOTxOdCiksgFnMpQCKOUhBm0YSZTKPh1C8I
	 49vnYrnKhjx+Xt4tVY0rh6mw9R84VI+V1VGxNc7rpwc3MBnWsQiV+x9Q7sdJz58096
	 3hNOccvVERKZ4u7HAbH9aDoSJf3c4AeI0/0ZvyqRMualM38jUOG7t1zHXzJMdcEOkG
	 KzhzFyQKldWu/AOqyqZh15E8CsuyWxua5H227vNZIDAqWTTonwNoGGMT8mfEtaCFGW
	 kvnFnzPcO2pSAjCzG06cYwegaWyB8xsfHQJh9jrIXSGfa9Xi7yaxwbbeqRnU6JzOBW
	 DgtwAoBcuezJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B89C480F0D;
	Wed, 12 Aug 2026 10:32:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24DBB1F45
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09955404DC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZuPJXHBWh7pb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 10:32:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sx.rinitha@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0B72E40467
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B72E40467
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B72E40467
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 10:32:05 +0000 (UTC)
X-CSE-ConnectionGUID: qdyhJ8+ZS0u/suNC5vFvyA==
X-CSE-MsgGUID: GpAcDGXmTIC5jQZYcxF+Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87201752"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="87201752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:04 -0700
X-CSE-ConnectionGUID: Ua0C+u5mTamJz1suDLl7kw==
X-CSE-MsgGUID: 6GxieZ1qSXesFcRxX285qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="301853868"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 03:32:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 03:32:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 03:32:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEFOKaHQX725cYuIXJ+bRgRndqAHQ+hT/U0qh2lbcEU6tc8gsR33gqbdx+Vt5KEYs6XqZT9eIt/z0JFeZWHWD2obupxnhG7go3EoVWJwvESWjGi9OjUJzI9Vtwjq9iSu8PrtJwCS94Q94iK4+WXK6qKe9csVT034XFIPBwo1b7l2FUHfGXZsvTz0S+aZGUeaQGwf2m5FPnp67xx1JpkAMMrSU6b6SPdmJ8LWPsBa3VLuJY8rp/bCqQ/M8TbIYsXkuWATw6EOQErDjo5kw6UGCWHhni8PEMIAQDvvuil4Rjek8CAP/5aPdlcPV11269qyqOILanf8n2WepAa+H2mqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K84AqlI+ZaS96ConHBNFTzdY5SuiA5qXWk1QEapRkE=;
 b=Xc+35K6XY+ozxogX12BbfXlrNPYrD7II4qNjWxfcS07400glw7jAlV6l2Ufds8qo5W5ehGizsuM4LH/VlCMljgr3qw8HgnGVWdTznupkG1m5xwKyLOAyvsp5PSH2Zo/Qniv/Mmog2ylXy38lCv6+JOzT7rpRcUWfzCDjLx3/NKHoaNRfaNpoTEMv6uPwbmjvuaqdWuucLjYR2WT/CdQSpxsGmvbyzlD0Hp/WnQqUgUO2hf/YT+K4WC2lTdSRTJud+dre7vWHhUE81utitbCpJYzJ+Q0uPJBkhPoHLLqvxNwccWUqRcuZSzDgHTZsIcvOcaABvAcZsqVfjJRhSWnFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6247.namprd11.prod.outlook.com (2603:10b6:8:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 10:31:55 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 10:31:55 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 2/6] ixgbe: E610: prevent
 from disabling LSE
Thread-Index: AQHdCgYrRoomzGQc0UidvEsd/X4F4baac0tQ
Date: Wed, 12 Aug 2026 10:31:55 +0000
Message-ID: <IA1PR11MB624196352759B1D9A8A189488BDC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
 <20260702091553.57112-3-jedrzej.jagielski@intel.com>
In-Reply-To: <20260702091553.57112-3-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6247:EE_
x-ms-office365-filtering-correlation-id: 32863129-352e-42d9-583e-08def85cee84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: XyA/okpZTfw9PRuk9/Du7RbVoCCaALZ4NB0lLWAtsjegDVIK33qZl53SW1FVHyfclTQxLmjP20Od4vJQuuM3U/98A0l797aQ+BMRx/e1DUgFkxhK0ubCcNttIhwpE6nmo5wzLzjpidW0oHAeoOnkwD/U43+qPBHP/lXvWbew9vsHek53s9e5cp8n4L5ab9hcuWJFvXbXLowxJNzdtcvz/fAoYulgPAdB92A/twX4zRdu1LweHp7uhgysjR0GUrQkTKKf9D0h1BtIzDkgdEyntF+FB0vaEGIzrXvfXfo2nGexXzWSdozqNwVbE3k7rT/sCF3WHiU5tSw3w1DrROiavm+5aF10Z931SSNr8K77DjJ5g6odEmQIbapd1/tOh+RJFFQ6XzpxoKgaV0dY5OUU9600kSIFxcfgc/n2sxOgITifec2xfwjkZO7v94g9E1k3H0/dnBC4xGLE2h22PReWum7x02sMMmjTET9VEFdQorAXJ8Bh62mz6h+RD/wGnA/R9PFCWpetpG1DujHfG+OK/4oXUQkaKr5dfzW7FuIWMPEuo5Htega5pOPSpOTF7S8D+hp5hVZ7LKE74IDWG1fGMfTuihPTQC5IN+9plwcPbiZMtSGIEK41JMhb9P3uITfPyipGCZJAot2kOXLgZBoSmoDHgDanqReMdYZKIzagSihcyFnu9MiVdPeSvr0lUVxnhB9nsx8PV50cki5I0uyDXD+uvB8DWYLZiKK+FUwdamI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wRXB0/0iSAG3IFje5kBKOS4cDmxULBRssQc+yEg1DO6Ksxd0iy5YlZTRCia0?=
 =?us-ascii?Q?Cm8iyy7I50Rv621klfO1utqyDP/8hjkYWndsxpegNOsXBKwFMT55I1j39KCo?=
 =?us-ascii?Q?crCWPwuNH6i2Di13+DWAdSH2pOZHhT9D0TU2VXyKaJaOJsndQQqjTR/+63uw?=
 =?us-ascii?Q?BKDrS24y0gnRiBc6wvcLh0oJ8DHknFEkMBhVjKbPmAJgb1WmPBdlwMGyuETx?=
 =?us-ascii?Q?XGnBkkJlJv8oZs5wzEx9QtUbhu0aYiyMq+Usn6gsO/2Q5x65YMV1HveZ0ppR?=
 =?us-ascii?Q?mzxGJV/GST+bNIBh5cBFzJ3PJKejtKd0z6lHF8t+xXbi8yZMHv7nHWDyKX6f?=
 =?us-ascii?Q?5Dp7+q3gk5Ow0eUIxLcOGhe3Q50QLvd4K+hFg5ysrsl8mT+nJdmsx2SGcF8P?=
 =?us-ascii?Q?K6brYPDjU/teXu9rEB0kfOa6XDpfRtTIuFlxogf0TXGK31vDOgZI5S09g+RO?=
 =?us-ascii?Q?NFOz2gUPWTdsX/ifq65tRGB6hzIHJ8PSHvCnEBqBqM0SduDysefAvWARiNFQ?=
 =?us-ascii?Q?SRR7Ud41bvx99pPR7DwomdMUDMIqzlosdTXE+AH0GQ5zG1XuJ6s5R2IoOsbF?=
 =?us-ascii?Q?6QOlAyRff/bR+yaT4Da5MhG/4qXNImrWDsr8Ky71Q1qmz0dRx2w4t0omR604?=
 =?us-ascii?Q?xapTb65wjnwid/5Tgof9JcGRo/a9/vqc4KvUNDwUgL6imTh/MA3I8qcYxncV?=
 =?us-ascii?Q?VjDPdJ6kV2wr1R74E2e2JFGZuXQHGcI4RsTHxy0RdE+JPcD3r974m14YfY35?=
 =?us-ascii?Q?s2qt5qAXmKHFER5bRQlrrThOf5xZN4rSylaICTxoobMrEMAEXybo5LSS0oJ5?=
 =?us-ascii?Q?StiDFIDXnSE6wk/qaGKAaHRd1/PuMiKTwi9v2cmavUeNwa9xmRY3HGumkyT+?=
 =?us-ascii?Q?+kx+ZL9XldP4CwRrCFGvE7UIrPUYueicaLVkNCR4/NE2gonV6eJsO1ZaPhZY?=
 =?us-ascii?Q?eQ1xb0A/l+ELz7bPfg1oOdqMWVpmn4OxruxpRYtYbRi6N3Dt/BroIQWYHr9L?=
 =?us-ascii?Q?CHeIKmKWkZnyYvWDbhXsLkpir/NsB7ODlQw9YZeYksUYO5l+DdMmMxcGjn7O?=
 =?us-ascii?Q?s0eG/q3AiA8JkzDMHD1XoHYexO2VljFkKBQyM6PmAYYieM/+RDGtFJ+lZcfY?=
 =?us-ascii?Q?4u+Ero+5MdOB0pIPcPgZzR4i/whs1vYBB4EATrRRb7Di0Dweo74prHcbcA8n?=
 =?us-ascii?Q?b+OWfMry89Qq0C+UMos5LgAqMZqh1X/l1OFkCv1DzuLi0sd6cOlnrxrt/mq2?=
 =?us-ascii?Q?u5Ffh77yIRaWe35z6WsH/ZEh6mS00gJ6K/k+lBsqNKLaBcf23M+IcXScBM8V?=
 =?us-ascii?Q?EfcjNoa5JyqcjeGnfTWx6vQpnhfGRkzE0udL1X72mSyGpktX45hr92mMRaVJ?=
 =?us-ascii?Q?QwfdccZBZeLPGQDNe8QQShNF/MLsNt5Osoi4Wx6LAQp5eELL1qa8ZC8WCeaj?=
 =?us-ascii?Q?0hCTzhgNaEnkIBNI8u40N3rrqyfIsWC5y2mIe5E2NcKblput8nAiJ6szMra3?=
 =?us-ascii?Q?a0HdRH8L1B2dq+6zWM3iYt0upRp3yXvSiWaJ2nUyg6pmggvCELyTQ+cKr7aK?=
 =?us-ascii?Q?xk7x0i4ZIRThRVUvErEnJmO4R+asa0OQDeqkFb/3Z4c20G/YOgMyiORxGXsn?=
 =?us-ascii?Q?IdXaz9ili+tKIHr598SKouz41Lv2N9UlX+504OT9VSnyT5dNrK0pRexQkm24?=
 =?us-ascii?Q?aVfqO5KCgWrW2Sc1bT4Oy+r1Z+BhPbnAnTWxWKyCmpAPqi6S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gnk+br/kqYxig+bnRbbnGBXyH3p1IerXgHmelmG+PUow2CAXUnJQsCJS3Ihde5IeaIiqIDE9m8Xcxyz+FuRQdLm2QsjZvZ9/83xwtLlxqt1+FBxLhFfh52/HQ5mW7kAXkXNMeMnvyOCiKa/1lUQmdQgbdBVlOn9nA9BKTbviUfQarY0GHNMHQCGwtmluqP9YkBJuus26NAscrUoZcjTCJ+9jQ+lNsMcxn+Qco3PB1hmWiSdDTR1tSMJVaiiWLwgYEeY5j159pH1m7Hb6VXTi9m6IVjHqOX7JmcsqCkAmYniKEJtUaQUtWp3uOW6nymcj+6NwL+K3lFX+fmgbq05eeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32863129-352e-42d9-583e-08def85cee84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 10:31:55.5051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0C9UoYBnEOOfRBnZ0IVxp8INuthKO3pyLKi4oqejR/BzpVtX54PDMW+xCmqlRlk3jnuP3D36r24MKpWVTm+lBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6247
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786530726; x=1818066726;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0K84AqlI+ZaS96ConHBNFTzdY5SuiA5qXWk1QEapRkE=;
 b=JcELLZXDq3d7bXnT9OHKvUSJ09o6XQIEgBsr46+L3wCSeCwrDH2cBCy9
 mU95Eh9EveUssyJOHQH9y1nNI4y7F4CK/+wSVlLtypYGkJNgytBNRdAjm
 0cI86c3aUGJzy3RXIKeyeEvpCeYEodZHT9GkwPM4lFFXJik6g2KruHyrV
 cnlJuk4L/OpXhng5o9JsKOqf4DeQbQYRkWkFbWdqyYHSU1dOabk9oSa5/
 WU35dpjckroiGmSks3B8oQIzo/qp1kDMTo+kW/Cbr0fcacwSgarQX4r2y
 HJ5E+02x4dzUxH0IEFGKCkjgyT2uwToCsKYYCehvd/u+CoMOW2qo10nCN
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JcELLZXD
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 2/6] ixgbe: E610: prevent
 from disabling LSE
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 02 July 2026 14:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/6] ixgbe: E610: prevent f=
rom disabling LSE
>
> LSE is not allowed to be switched off while the ixgbe driver is running.
> Some of the ixgbe_aci_get_link_info() callers called it with @ena_lse equ=
al to false what was causing issues.
>
> There was a known issue when FW after being called by Redfish MGMT reques=
t to disable an interface wasn't able to notify the driver about link statu=
s change due to disabled LSE reception on the driver side. As a result driv=
er exposed incorrect link status.
>
> There's no any requirement forcing to disable LSE either during configuri=
ng FC, either during setting PHY params.
>
> Force calling ixgbe_aci_get_link_info() with @ena_lse =3D=3D true.
>
> Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
