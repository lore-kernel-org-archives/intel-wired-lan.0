From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 3 Dec 2021 17:32:03 -0800
Subject: [Intel-wired-lan] [RFC PATCH 0/4] r8169: support dash
In-Reply-To: <20211204010829.7796-1-alexandr.lobakin@intel.com>
References: <20211129101315.16372-381-nic_swsd@realtek.com>
 <20211129095947.547a765f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <918d75ea873a453ab2ba588a35d66ab6@realtek.com>
 <20211130190926.7c1d735d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d3a1e1c469844aa697d6d315c9549eda@realtek.com>
 <20211203070410.1b4abc4d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211204010829.7796-1-alexandr.lobakin@intel.com>
Message-ID: <20211203173203.285dc75f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat,  4 Dec 2021 02:08:29 +0100 Alexander Lobakin wrote:
> > Ah, I've only spotted the enable/disable knob in the patch. 
> > If you're exchanging arbitrary binary data with the FW we 
> > can't help you. It's not going to fly upstream.  
> 
> Uhm. I'm not saying sysfs is a proper way to do that, not at all,
> buuut...
> We have a ton of different subsystems providing a communication
> channel between userspace and HW/FW. Chardevices all over the
> tree, highly used rpmsg for remoteproc, uio. 

Not in Ethernet.

> We have register dump in Ethtool,

Read only.

> as well as get/set for EEPROM, I'd count them as well.

EEPROM writes are supposed to update FW images, not send random
messages.

> So it probably isn't a bad idea to provide some standard API for
> network drivers to talk to HW/FW from userspace, like get/set or
> rx/tx (when having enough caps for sure)? It could be Devlink ops
> or Ethtool ops, the latter fits more to me.

I'm not saying it's wrong to merge shim drivers into the kernel and
let the user space talk to device FW. I'm saying it's counter to what
netdev's policy has always been and counter to my personal interests.

What is a standard API for custom, proprietary FW message interface?
We want standards at a functional level. Once you open up a raw FW
write interface there is no policing of what goes thru it.

I CCed Intel since you also have the (infamous) ME, but I never heard
of the need to communicate from the OS to the ME via the netdev
driver... Not sure why things are different for Realtek.
