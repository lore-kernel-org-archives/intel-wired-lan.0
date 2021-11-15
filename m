From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 15 Nov 2021 13:42:48 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB58121DC2755B9AADA3516E75EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <87r1bqcyto.fsf@nvidia.com>
 <MW5PR11MB5812B0A4E6227C6896AC12B5EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87mtmdcrf2.fsf@nvidia.com>
 <MW5PR11MB5812D4A8419C37FE9C890D3AEA929@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87bl2scnly.fsf@nvidia.com>
 <MW5PR11MB5812034EA5FC331FA5A2D37CEA939@MW5PR11MB5812.namprd11.prod.outlook.com>
 <874k8kca9t.fsf@nvidia.com>
 <MW5PR11MB5812757CFF0ACED1D9CFC5A2EA939@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87y25vbu19.fsf@nvidia.com>
 <MW5PR11MB58121DC2755B9AADA3516E75EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <20211115134248.5d111036@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 15 Nov 2021 10:12:25 +0000 Machnikowski, Maciej wrote:
> > > Netdev owns the PHY, so it needs to enable/disable clock from a given
> > > port/lane - other than that it's EECs task. Technically - those subsystems
> > > are separate.  
> > 
> > So why is the UAPI conflating the two?  
> 
> Because EEC can be a separate external device, but also can be integrated
> inside the netdev. In the second case it makes more sense to just return
> the state from a netdev 

I mentioned that we are in a need of such API to Vadim who, among other
things, works on the OCP Timecard. He indicated interest in developing
the separate netlink interface for "DPLLs" (the timecard is just an
atomic clock + GPS, no netdev to hang from). Let's wait for Vadim's work
to materialize and build on top of that.
