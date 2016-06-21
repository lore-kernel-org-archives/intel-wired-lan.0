From: Edward Cree <ecree@solarflare.com>
Date: Tue, 21 Jun 2016 19:23:52 +0100
Subject: [Intel-wired-lan] [net-next PATCH v3 00/17] Future-proof tunnel
	offload handlers
In-Reply-To: <234d6a2f-6971-7029-0645-f98e51236c4f@redhat.com>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160617.202641.1821023739498595024.davem@davemloft.net>
 <CALx6S34Y3Qq6nMHuMcC2LC5duLBO3KVN3+A+0qmPrNvFfY7gJg@mail.gmail.com>
 <20160621.042211.945844554759834352.davem@davemloft.net>
 <CAKgT0Ucze-+PYdvoHhDSLuaTLrn+Ene+CnfJaKO7AEHGHBsKzg@mail.gmail.com>
 <18b4d172-2cf5-8246-9cac-ce92adf65bc8@solarflare.com>
 <234d6a2f-6971-7029-0645-f98e51236c4f@redhat.com>
Message-ID: <090c2556-b9df-1cee-196c-78b5555aefc7@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 21/06/16 18:40, Hannes Frederic Sowa wrote:
> On 21.06.2016 10:27, Edward Cree wrote:
>> At a given physical point in the network, a given UDP flow either is or is
>> not carrying encapsulated traffic, and if it tries to be both then things
>> are certain to break, just as much as if two different applications try to
>> use the same UDP flow for two different application protocols.
> I think the example Tom was hinting at initially is like that:
>
> A net namespace acts as a router and has a vxlan endpoint active. The
> vxlan endpoint enables vxlan offloading on all net_devices in the same
> namespace. Because we only identify the tunnel endpoint by UDP port
> number, traffic which should actually just be forwarded and should never
> be processed locally suddenly can become processed by the offloading hw
> units. Because UDP ports only form a contract between the end points and
> not with the router in between it would be illegal to treat those not
> locally designated packets as vxlan by the router.
Oh indeed, what we currently do is broken.  We would have to identify, for
each interface, which (if any) UDP flows on that interface correspond to
our vxlan endpoints, rather than (as now) saying that any UDP port that
matches any endpoint must be vxlan on all interfaces.
But as long as a vxlan endpoint is a device built on top of another device,
it can just ask that device to enable offloads for the corresponding flow;
and if that device is also a software device, it might modify the flow spec
before passing on the request to _its_ underlying device, or it might just
drop the request because it doesn't support it.
The problem is, AIUI the device is currently only used for transmitting;
anything received on any device that makes it through the IP stack to the
vxlan UDP socket is treated as vxlan.  And determining which interfaces'
traffic will get delivered locally and which will get routed is not
necessarily trivial.  Perhaps vxlan devices need to only receive traffic
that came through their underlying device?  Then the mapping to offload
becomes much simpler.

-Ed
> Also multicast traffic is always scoped, so the flow has to include the
> ifindex at least to allow differentiation between different scopes.
