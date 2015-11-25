From: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed, 25 Nov 2015 11:18:32 +0800
Subject: [Intel-wired-lan] [RFC PATCH V2 0/3] IXGBE/VFIO: Add live
 migration support for SRIOV NIC
In-Reply-To: <5654722D.4010409@gmail.com>
References: <1448372298-28386-1-git-send-email-tianyu.lan@intel.com>
 <5654722D.4010409@gmail.com>
Message-ID: <56552888.90108@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015?11?24? 22:20, Alexander Duyck wrote:
> I'm still not a fan of this approach.  I really feel like this is
> something that should be resolved by extending the existing PCI hot-plug
> rather than trying to instrument this per driver.  Then you will get the
> goodness for multiple drivers and multiple OSes instead of just one.  An
> added advantage to dealing with this in the PCI hot-plug environment
> would be that you could then still do a hot-plug even if the guest
> didn't load a driver for the VF since you would be working with the PCI
> slot instead of the device itself.
> 
> - Alex

Hi Alex:
	What's you mentioned seems the bonding driver solution.
Paper "Live Migration with Pass-through Device for Linux VM" describes
it. It does VF hotplug during migration. In order to maintain Network
connection when VF is out, it takes advantage of Linux bonding driver to
switch between VF NIC and emulated NIC. But the side affects, that
requires VM to do additional configure and the performance during
switching two NIC is not good.

-- 
Best regards
Tianyu Lan
