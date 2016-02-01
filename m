From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Mon, 1 Feb 2016 17:54:56 +0000
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
 sending TX pause frames?
In-Reply-To: <56AF744B.1000403@windriver.com>
References: <56AA60A1.7060408@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
 <56AF744B.1000403@windriver.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664691E71472@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey Chris,

Like I mentioned earlier the only issue I was aware of anything close to this was root caused to switch capability.  If you are seeing the same behavior across multiple switch that pretty much rules that out.  Since you don't see anything in the system log we may need to get a register dump (with something like ethregs) both before the failure occurs and while in the error state.  This is assuming once the system enters the error state it remains indefinitely.   Couple other things I'm wondering:

- Is traffic being received/transmit while in the error state and if so how much?
- does a reset correct the problem or do you have to do something more aggressive (i.e. reload the driver, cycle power)?
- Anything else that might have been occurring around the time the system enters the error state.

Thanks,
-Don Skidmore <donald.c.skidmore@intel.com>


> -----Original Message-----
> From: Chris Friesen [mailto:chris.friesen at windriver.com]
> Sent: Monday, February 01, 2016 7:06 AM
> To: Skidmore, Donald C; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
> sending TX pause frames?
> 
> On 01/28/2016 01:13 PM, Skidmore, Donald C wrote:
> > Hey Chris,
> >
> > I've seen issues that seemed similar to this caused by a switches not
> > playing well with the NIC.  Are you going through a switch and if so
> > could you see if you can recreate back to back with a different switch?
> 
> Got some more information on this from one of our guys.  Here's what he
> says:
> 
> 
> "This has been seen at least 3 times recently... on 3 different switches (1 of
> which is a Cisco Nexus 5K).  I would be willing to believe that our Quanta
> switches did something suspect, but not the Cisco.   I also find it hard to
> believe that something the switch could do would cause the device to send
> out pause frames.  As far as I understand it is only supposed to do that in
> response to running out of rx buffers while receiving packets.  It is then
> supposed to send XON frames once more rx buffers are available.
> 
> I checked the switch ports connected to both systems that were affected
> today.
> Neither of them have flow control enabled which means this was the Intel
> device doing something suspect all on its own."
> 
> 
> 
> I'll see about trying the out-of-tree driver, but without a straightforward way
> to reproduce it'll be hard to tell if it fixes things.
> 
> Chris
