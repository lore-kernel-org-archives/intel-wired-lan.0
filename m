From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Thu, 14 Jan 2016 02:40:48 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the
	ethtool	interface fo Rx filter
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E4DC10@ORSMSX101.amr.corp.intel.com>
References: <1451456399-13353-1-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E4D36B@ORSMSX101.amr.corp.intel.com>,
 <DM2PR0401MB09907A74230900BB8820D802ECCA0@DM2PR0401MB0990.namprd04.prod.outlook.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E4DC10@ORSMSX101.amr.corp.intel.com>
Message-ID: <DM2PR0401MB0990C5C5A689DC9B0F1E0973ECCC0@DM2PR0401MB0990.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Brown,

1. According to datasheet, only i210/i211/350 support Rx queue assignment. In my patch, other adapters will return the error -ENOTSUPP;  

2. For I211, it only have 2 HW queues(queue 0 and queue 1), you cannot assign the packets to queue 2. 

I211: 
ethtool -N eth1 flow-type ether proto 0x88F8 action 1

 
-----Original Message-----
From: Brown, Aaron F [mailto:aaron.f.brown at intel.com] 
Sent: 2016?1?13? 11:27
To: Gangfeng Huang <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org
Cc: Ruhao Gao <ruhao.gao@ni.com>
Subject: RE: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool interface fo Rx filter

> From: Gangfeng Huang [gangfeng.huang at ni.com]
> Sent: Tuesday, January 12, 2016 12:32 AM
> To: Brown, Aaron F; intel-wired-lan at lists.osuosl.org
> Cc: Ruhao Gao
> Subject: RE: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool   interface fo Rx filter

> About these patches, I only do the test on I210 because I do not have other adapters in this series,

That's one of the reasons I test it here, can't expect everyone to have access to all the SKUs.  It can be hard enough for me to locate a suitable sampling of each part one of our drivers supports :)

If you have an idea of how to address it go ahead and submit another patch, I have the systems in a dedicated regression rack and the check for this is pretty easy so it should not take me too long to come back with a result.

Thanks,
Aaron
