From: Petr Machata <petrm@nvidia.com>
Date: Wed, 10 Nov 2021 22:05:54 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB5812757CFF0ACED1D9CFC5A2EA939@MW5PR11MB5812.namprd11.prod.outlook.com>
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
Message-ID: <87y25vbu19.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> >> Wait, so how do I do failover? Which of the set pins in primary and
>> >> which is backup? Should the backup be sticky, i.e. do primary and backup
>> >> switch roles after primary goes into holdover? It looks like there are a
>> >> number of policy decisions that would be best served by a userspace
>> >> tool.
>> >
>> > The clock priority is configured in the SEC/EEC/DPLL. Recovered clock API
>> > only configures the redirections (aka. Which clocks will be available to the
>> > DPLL as references). In some DPLLs the fallback is automatic as long as
>> > secondary clock is available when the primary goes away. Userspace tool
>> > can preconfigure that before the failure occurs.
>> 
>> OK, I see. It looks like this priority list implies which pins need to
>> be enabled. That makes the netdev interface redundant.
>
> Netdev owns the PHY, so it needs to enable/disable clock from a given
> port/lane - other than that it's EECs task. Technically - those subsystems
> are separate.

So why is the UAPI conflating the two?

>> As a user, say I know the signal coming from swp1 is freqency-locked.
>> How can I instruct the switch ASIC to propagate that signal to the other
>> ports? Well, I go through swp2..swpN, and issue RTM_SETRCLKSTATE or
>> whatever, with flags indicating I set up tracking, and pin number...
>> what exactly? How do I know which pin carries clock recovered from swp1?
>
> You send the RTM_SETRCLKSTATE to the port that has the best reference
> clock available.
> If you want to know which pin carries the clock you simply send the
> RTM_GETRCLKSTATE and it'll return the list of possible outputs with the flags
> saying which of them are enabled (see the newer revision)

As a user I would really prefer to have a pin reference reported
somewhere at the netdev / phy / somewhere. Similarly to how a netdev can
reference a PHC. But whatever, I won't split hairs over this, this is
acutally one aspect that is easy to add later.

>> >> > More advanced functionality will be grown organically, as I also have
>> >> > a limited view of SyncE and am not expert on switches.
>> >>
>> >> We are growing it organically _right now_. I am strongly advocating an
>> >> organic growth in the direction of a first-class DPLL object.
>> >
>> > If it helps - I can separate the PHY RCLK control patches and leave EEC state
>> > under review
>> 
>> Not sure what you mean by that.
>
> Commit RTM_GETRCLKSTATE and RTM_SETRCLKSTATE now, wait with 
> RTM_GETEECSTATE  till we clarify further direction of the DPLL subsystem

It's not just state though. There is another oddity that I am not sure
is intentional. The proposed UAPI allows me to set up fairly general
frequency bridging. In a device with a bunch of ports, it would allow me
to set up, say, swp1 to track RCLK from swp2, then swp3 from swp4, etc.
But what will be the EEC state in that case?
