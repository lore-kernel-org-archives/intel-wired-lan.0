From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Feb 2017 09:51:43 -0800
Subject: [Intel-wired-lan] [next-queue v5 PATCH 5/7] i40e: Add TX and RX
 support in switchdev mode
In-Reply-To: <58A491C9.6040409@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-6-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UdEFQpzT5rHmX8LY3pRnFVhy-R+1f8Jnmkhz0HUFqKEig@mail.gmail.com>
 <58A491C9.6040409@intel.com>
Message-ID: <CAKgT0Ud9f9i+kJtAmzar_r8JfWUBoqmRnDCxfSTvokO5CD2vpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 15, 2017 at 9:37 AM, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
> On 2/15/2017 7:59 AM, Alexander Duyck wrote:
>>
>> On Wed, Jan 25, 2017 at 4:54 PM, Sridhar Samudrala
>> <sridhar.samudrala@intel.com> wrote:
>>>
>>> In switchdev mode, broadcast filter is not enabled on VFs. The broadcasts
>>> and unknown frames from VFs are received by the PF and passed to
>>> corresponding VF port representator netdev.
>>> A host based switching entity like a linux bridge or OVS redirects these
>>> frames to the right VFs via VFPR netdevs. Any frames sent via VFPR
>>> netdevs
>>> are sent as directed transmits to the corresponding VFs. To enable
>>> directed
>>> transmit, skb metadata dst is used to pass the VF id and the frame is
>>> requeued to call the PFs transmit routine.
>>>
>>> Small script to demonstrate inter VF pings in switchdev mode.
>>> PF: enp5s0f0, VFs: enp5s2,enp5s2f1 VFPRs:enp5s0f0-vf0, enp5s0f0-vf1
>>>
>>> # rmmod i40e; modprobe i40e
>>> # devlink dev eswitch set pci/0000:05:00.0 mode switchdev
>>> # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
>>> # ip link set enp5s0f0 vf 0 mac 00:11:22:33:44:55
>>> # ip link set enp5s0f0 vf 1 mac 00:11:22:33:44:56
>>> # rmmod i40evf; modprobe i40evf
>>>
>>> /* Create 2 namespaces and move the VFs to the corresponding ns. */
>>> # ip netns add ns0
>>> # ip link set enp5s2 netns ns0
>>> # ip netns exec ns0 ip addr add 192.168.1.10/24 dev enp5s2
>>> # ip netns exec ns0 ip link set enp5s2 up
>>> # ip netns add ns1
>>> # ip link set enp5s2f1 netns ns1
>>> # ip netns exec ns1 ip addr add 192.168.1.11/24 dev enp5s2f1
>>> # ip netns exec ns1 ip link set enp5s2f1 up
>>>
>>> /* bring up pf and vfpr netdevs */
>>> # ip link set enp5s0f0 up
>>> # ip link set enp5s0f0-vf0 up
>>> # ip link set enp5s0f0-vf1 up
>>>
>>> /* Create a linux bridge and add vfpr netdevs to it. */
>>> # ip link add vfpr-br type bridge
>>> # ip link set enp5s0f0-vf0 master vfpr-br
>>> # ip link set enp5s0f0-vf1 master vfpr-br
>>> # ip addr add 192.168.1.1/24 dev vfpr-br
>>> # ip link set vfpr-br up
>>>
>>> # ip netns exec ns0 ping -c3 192.168.1.11
>>> # ip netns exec ns1 ping -c3 192.168.1.10
>>
>> So the test case as called out here isn't really valid is it?  You
>> aren't even really using the switchdev.  All you are doing is having
>> one VF ping the other.
>
> In switchdev mode, when VF pings other VF,  the broadcasts go through the
> host PF.
> In this example, when i ping from enp5s2 in ns0,  the ARP broadcast from
> enp5s2
> takes this path.
>     enp5s2(ns0) -> enp5s0f0 -> enp5s0f0-vf0 -> vfpr-br -> enp5s0f0-vf1 ->
> enp5s0f0 -> enp5s2f1(ns1)
>
> So in switchdev mode, for VF<->VF communications, we need to add all the
> VFPR netdevs to a
> learning bridge with the current state of implementation.  Once we have the
> fdb add/del support,
> we should be able to program the broadcast filters from the host via VFPR
> netdevs.

We may want to look at pre-programming the filters so that we
basically start with the switchdev preconfigured for what we actually
have enabled.  We may want to hold off on submitting this patch set
until we have FDB and possibly TC filter support.  Otherwise all we
are doing is adding statistics which are only somewhat useful.

>>
>> I would be interested in seeing the PF brought up and what the
>> behavior is if the PF attempts to ping one of the VFs.  I think we
>> have a major flaw in the design there as the replies would likely be
>> returned to the port representors instead of being returned to the PF.
>> We probably need to look at moving the port representors all onto a
>> different MAC address and doing a 2 fold test.  One to see if the
>> packet is being routed to the PF (see the tests in eth_type_trans),
>> and if it is not only then do we take the packet and route it to a
>> representor.
>
>
> Sure. I can add an IP address in the same subnet as VFs to PF and can ping
> PF from VF.
> That works fine.  I haven't tried assigning a separate MAC for all VFPR
> netdevs. I think that
> will work too, but need to check if there are any issues with that approach.
>

I'm pretty sure the PF will send the ping, but it will be received on
the VFPR for the VF instead of being received on the PF.  Ideally the
behavior we should see is that if I ping from the VFPR the reply
should be returned to the VFPR, and if I ping from the PF the reply
should be received on the PF.

Also it occurred to me that we should probably be doing broadcast
replication instead of just sending the broadcast to the VFPR only.
We should see the broadcast on the VFPR and the PF.

My main concern with all of this is that I am not sure this is
"production ready".  We need to make sure we can handle sending
traffic across the interfaces and support all of the minimum
requirements to support switchdev and I am not sure we are quite there
yet.  We need to be able to have an interface that is registered on
top of us recognize how we are configured and handle the traffic that
is moving across the ports correctly and in order to do that we really
need to work on coming up with a better test matrix than what we have
currently.

- Alex
