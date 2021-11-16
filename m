From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 16 Nov 2021 11:30:41 -0800
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/6] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20211116154111.GF6326@breakpoint.cc>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-3-maciej.machnikowski@intel.com>
 <YY0+PmNU4MSGfgqA@hog> <20211111162252.GJ16363@breakpoint.cc>
 <MW5PR11MB58124A70268058505368A5C8EA999@MW5PR11MB5812.namprd11.prod.outlook.com>
 <20211116154111.GF6326@breakpoint.cc>
Message-ID: <20211116113041.17fd8ff2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 16 Nov 2021 16:41:11 +0100 Florian Westphal wrote:
> > and the concept of that functionality
> > is - any packet network can implement it - SONET, GPON or even wireless.  
> 
> Ethtool ops expose a wide range of low-level functions not related to
> ethernet, e.g. eeprom dump, interrupt coalescing settings of and so on
> and so forth.
> 
> But hey, if net maintainers are ok with rtnetlink...

I agree, this has been brought up by 5 people or so already.
