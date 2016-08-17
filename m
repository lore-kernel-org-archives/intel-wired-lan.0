From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 17 Aug 2016 12:24:44 -0700
Subject: [Intel-wired-lan] [next PATCH 1/5] i40e: Introduce devlink
 interface.
In-Reply-To: <CAKgT0UfXn5=PqxKawx-TX6JTWU+EmzBVH6J91g5TeUJDi+3vsQ@mail.gmail.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UeGtE2UUQWmjciz+zvLsCVPknvoUevmW6GRyDXMNCySSQ@mail.gmail.com>
 <57AB5B5B.3090801@gmail.com>
 <CAKgT0Ud5LYhKeyD7_fbw-SXFFi7hSTe8mCSUdj_=oXQv5m+AeA@mail.gmail.com>
 <57AB756D.1060600@gmail.com> <57B3615B.6020504@intel.com>
 <CAKgT0Udm2H53qYupN3N-p5aD9NSdnVaAr8zq1OgcO6apeR4j9Q@mail.gmail.com>
 <57B38AF1.3080203@intel.com>
 <CAKgT0UfXn5=PqxKawx-TX6JTWU+EmzBVH6J91g5TeUJDi+3vsQ@mail.gmail.com>
Message-ID: <57B4B9FC.4040705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-08-16 05:17 PM, Alexander Duyck wrote:
> On Tue, Aug 16, 2016 at 2:51 PM, Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
>> The idea behind NTUPLE filters on VF representors is to match RX traffic
>> that is destined
>> for the corresponding VF. Basically when adding the flow director filter, we
>> are setting the
>> dest vsi as the VSI of the corresponding VF.
>> Without VF representors, this is currently done by overloading user-def
>> value with VF id.
>>
> 
> Yes, and for now that is preferable to what you are doing since it
> makes no sense.
> 
> I will try to clarify my point.  First, instead of calling these VF
> representors lets call them VF port representor, or VFPR for short
> (trying to avoid VFR because it sounds too much like VRF which is
> completely unrelated).  So the whole point of a VFPR is to present the
> VF as a port on your logical switch.  You should mostly only be
> capable of doing on it what you would do with an actual switch.  So
> for example if I have a switch connected to NIC.  Now most switches
> have certain options for controlling things.  For example I can force
> the switch port onto a given VLAN so that the port is isolated from
> other traffic.  I can control the max frame size allowed to be sent or
> received over the port.  I can block what traffic the port is allowed
> to send by restricting MAC addresses via ACLs, and I can manually
> program the forwarding table via FDB entries.
> 
> The problem is Flow Director also know as NTUPLE or Rx NFC only
> operates on the Rx side of NICs.  In your VFPR the Rx side represents
> packets coming from your VF, not packets going to it.   If you
> transmit on a VFPR the packet should be received only by the VF, if
> you receive from it the packet should only be from the VF.  So really
> any Flow Director rule you add to the VFPR should not impact the VF,
> but instead should impact the VFPR and the PF since the PF will add
> the rule and it should only apply on traffic received on the VFPR from
> the VF.
> 
> At some point in the future we can look at adding flow Tx offloads via
> either TC or SwitchDev.  For now adding NTUPLE is a strong no-go.  The
> VFPR are not the place to do it unless you are just wanting to add
> custom rules to the PF itself that won't impact the VF.
> 
> - Alex
> 

FWIW the features I want from the VFPR (nice acronym :) are the
following,

  - xmit (just send it over the PF queues is fine)
  - recv : ideally the driver does this with descriptor magic but
           the next best thing would be to do this in the driver
	   with a lookup on mac when anti-spoofing is on. Or worst
           case if the driver logic is too ugly I'll hack it in
           userspace :(
  - up/down link state
  - statistics
  - not essential but mtu would also be nice

I think thats it to get my basic stuff working in userspace. Another
nice piece would be the fdb_add offloads so we can get a basic l2 bridge
working and bonus points for including the vlan parts of the fdb_add
msg.

Thanks,
John
