From: Florian Westphal <fw@strlen.de>
Date: Tue, 16 Nov 2021 16:41:11 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/6] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <MW5PR11MB58124A70268058505368A5C8EA999@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-3-maciej.machnikowski@intel.com>
 <YY0+PmNU4MSGfgqA@hog> <20211111162252.GJ16363@breakpoint.cc>
 <MW5PR11MB58124A70268058505368A5C8EA999@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <20211116154111.GF6326@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Machnikowski, Maciej <maciej.machnikowski@intel.com> wrote:
> > More importantly, why is this added to rtnetlink (routing sockets)?
> > It appears to be unrelated?
> > 
> > Looks like this should be in ethtool (it has netlink api nowadays) or
> > devlink.
> 
> We identified it as a generic place in previous RFCs.

Doesn't answer my question.  EECSTATE doesn't appear to be related to
anything else thats currently exposed via rtnetlink from a conceptional
point of view.

> Ethtool calls are not
> available in non-ethernet packet networks

Thats news to me.  ethtool ops are linked via netdevice struct.

> and the concept of that functionality
> is - any packet network can implement it - SONET, GPON or even wireless.

Ethtool ops expose a wide range of low-level functions not related to
ethernet, e.g. eeprom dump, interrupt coalescing settings of and so on
and so forth.

But hey, if net maintainers are ok with rtnetlink...

I just feel putting synce interaction in rtnetlink is arbitrary
and bad precendence.
