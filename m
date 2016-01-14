From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:46:14 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the
 ethtool	interface fo Rx filter
In-Reply-To: <DM2PR0401MB0990C5C5A689DC9B0F1E0973ECCC0@DM2PR0401MB0990.namprd04.prod.outlook.com>
References: <1451456399-13353-1-git-send-email-gangfeng.huang@ni.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E4D36B@ORSMSX101.amr.corp.intel.com>,
 <DM2PR0401MB09907A74230900BB8820D802ECCA0@DM2PR0401MB0990.namprd04.prod.outlook.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E4DC10@ORSMSX101.amr.corp.intel.com>,
 <DM2PR0401MB0990C5C5A689DC9B0F1E0973ECCC0@DM2PR0401MB0990.namprd04.prod.outlook.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F1FF@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Gangfeng Huang [gangfeng.huang at ni.com]
> Sent: Wednesday, January 13, 2016 6:40 PM
> To: Brown, Aaron F; intel-wired-lan at lists.osuosl.org
> Cc: Ruhao Gao
> Subject: RE: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool   interface fo Rx filter
> 
> Hi Brown,
> 
> 1. According to datasheet, only i210/i211/350 support Rx queue assignment. In my patch, other adapters will return the error -ENOTSUPP;

Thanks for looking that up.  I had pulled down the datasheets to check if something like that was the case but got sidetracked with some other work.

So the patch is returning -ENOTSUPP, but when I run ethtool on the unsupported parts or non existent queues I get  "rmgr: Cannot insert RX class rule: Unknown error 524", do you know how we would go about making that error message a little more meaningful?

> 
> 2. For I211, it only have 2 HW queues(queue 0 and queue 1), you cannot assign the packets to queue 2.
> 
> I211:
> ethtool -N eth1 flow-type ether proto 0x88F8 action 1

Ok, that works, for both this and the VLAN example rule from your other patch.  Again, do you know if we can get the error that comes out of ethtool to be a little more meaningful?  

Thanks,
Aaron
