From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 15 Nov 2021 10:12:25 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <87y25vbu19.fsf@nvidia.com>
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
Message-ID: <MW5PR11MB58121DC2755B9AADA3516E75EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Petr Machata <petrm@nvidia.com>
> Sent: Wednesday, November 10, 2021 10:06 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: Petr Machata <petrm@nvidia.com>; netdev at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org; richardcochran at gmail.com; abyagowi at fb.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem at davemloft.net;
> kuba at kernel.org; linux-kselftest at vger.kernel.org; idosch at idosch.org;
> mkubecek at suse.cz; saeed at kernel.org; michael.chan at broadcom.com
> Subject: Re: [PATCH v2 net-next 6/6] docs: net: Add description of SyncE
> interfaces
> 
> 
> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
> 
> >> >> Wait, so how do I do failover? Which of the set pins in primary and
> >> >> which is backup? Should the backup be sticky, i.e. do primary and
> backup
> >> >> switch roles after primary goes into holdover? It looks like there are a
> >> >> number of policy decisions that would be best served by a userspace
> >> >> tool.
> >> >
> >> > The clock priority is configured in the SEC/EEC/DPLL. Recovered clock API
> >> > only configures the redirections (aka. Which clocks will be available to
> the
> >> > DPLL as references). In some DPLLs the fallback is automatic as long as
> >> > secondary clock is available when the primary goes away. Userspace
> tool
> >> > can preconfigure that before the failure occurs.
> >>
> >> OK, I see. It looks like this priority list implies which pins need to
> >> be enabled. That makes the netdev interface redundant.
> >
> > Netdev owns the PHY, so it needs to enable/disable clock from a given
> > port/lane - other than that it's EECs task. Technically - those subsystems
> > are separate.
> 
> So why is the UAPI conflating the two?

Because EEC can be a separate external device, but also can be integrated
inside the netdev. In the second case it makes more sense to just return
the state from a netdev 
 
> >> As a user, say I know the signal coming from swp1 is freqency-locked.
> >> How can I instruct the switch ASIC to propagate that signal to the other
> >> ports? Well, I go through swp2..swpN, and issue RTM_SETRCLKSTATE or
> >> whatever, with flags indicating I set up tracking, and pin number...
> >> what exactly? How do I know which pin carries clock recovered from
> swp1?
> >
> > You send the RTM_SETRCLKSTATE to the port that has the best reference
> > clock available.
> > If you want to know which pin carries the clock you simply send the
> > RTM_GETRCLKSTATE and it'll return the list of possible outputs with the
> flags
> > saying which of them are enabled (see the newer revision)
> 
> As a user I would really prefer to have a pin reference reported
> somewhere at the netdev / phy / somewhere. Similarly to how a netdev can
> reference a PHC. But whatever, I won't split hairs over this, this is
> acutally one aspect that is easy to add later.

I believe the best way would be to use sysfs entry for that (and provide a basic
control using it as well). But first we need the UAPI defined.
 
> >> >> > More advanced functionality will be grown organically, as I also have
> >> >> > a limited view of SyncE and am not expert on switches.
> >> >>
> >> >> We are growing it organically _right now_. I am strongly advocating an
> >> >> organic growth in the direction of a first-class DPLL object.
> >> >
> >> > If it helps - I can separate the PHY RCLK control patches and leave EEC
> state
> >> > under review
> >>
> >> Not sure what you mean by that.
> >
> > Commit RTM_GETRCLKSTATE and RTM_SETRCLKSTATE now, wait with
> > RTM_GETEECSTATE  till we clarify further direction of the DPLL subsystem
> 
> It's not just state though. There is another oddity that I am not sure
> is intentional. The proposed UAPI allows me to set up fairly general
> frequency bridging. In a device with a bunch of ports, it would allow me
> to set up, say, swp1 to track RCLK from swp2, then swp3 from swp4, etc.
> But what will be the EEC state in that case?

Yes. GET/SET UAPI is exactly there to configure that bridging. All it does
is to set up the recovered frequency on physical frequency output pins
of the phy/integrated device. In case DPLL is embedded the pins may be 
internal to the device and not exposed externally. It doesn't allow creation
of the tracking maps, as that's usually not a case in SyncE appliances.
In typical ones you recover the clock from a single port and then use that 
clock on all other ports.
The EEC state will depend on the signal quality and the configuration.
When the clock is enabled and is valid the EEC will tune its internal frequency
and report locked/Locked HO Acquired state.

Can remove word STATE from name and change to RTM_{GET,SET}RCLK 
if state is confusing there.

