From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 11 Sep 2020 11:41:58 -0700
Subject: [Intel-wired-lan] [PATCH net-next] i40e: allow VMDQs to be used
 with AF_XDP zero-copy
In-Reply-To: <b28b4e93-50c2-6183-90ea-8d33902e8f21@intel.com>
References: <1599826106-19020-1-git-send-email-magnus.karlsson@gmail.com>
 <20200911120519.GA9758@ranger.igk.intel.com>
 <CAJ8uoz3ctVoANjiO_nQ38YA-JoB0nQH1B4W01AZFw3iCyCC_+w@mail.gmail.com>
 <20200911131027.GA2052@ranger.igk.intel.com>
 <b28b4e93-50c2-6183-90ea-8d33902e8f21@intel.com>
Message-ID: <CAKgT0UcXLi5fK3UiOpfPKu6FxJh1tH4r+_ZjCNsH=cEqHztOOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 11, 2020 at 11:05 AM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
>
>
> On 9/11/2020 6:10 AM, Maciej Fijalkowski wrote:
> > On Fri, Sep 11, 2020 at 02:29:50PM +0200, Magnus Karlsson wrote:
> >> On Fri, Sep 11, 2020 at 2:11 PM Maciej Fijalkowski
> >> <maciej.fijalkowski@intel.com> wrote:
> >>>
> >>> On Fri, Sep 11, 2020 at 02:08:26PM +0200, Magnus Karlsson wrote:
> >>>> From: Magnus Karlsson <magnus.karlsson@intel.com>
> >>>>
> >>>> Allow VMDQs to be used with AF_XDP sockets in zero-copy mode. For some
> >>>> reason, we only allowed main VSIs to be used with zero-copy, but
> >>>> there is now reason to not allow VMDQs also.
> >>>
> >>> You meant 'to allow' I suppose. And what reason? :)
> >>
> >> Yes, sorry. Should be "not to allow". I was too trigger happy ;-).
> >>
> >> I have gotten requests from users that they want to use VMDQs in
> >> conjunction with containers. Basically small slices of the i40e
> >> portioned out as netdevs. Do you see any problems with using a VMDQ
> >> iwth zero-copy?
>
> Today VMDQ VSIs are used when a macvlan interface is created on top of a
> i40e PF with l2-fwd-offload on. But i don't think we can create an
> AF_XDP zerocopy socket on top of a macvlan netdev as it doesn't support
> ndo_bpf or ndo_xdp_xxx apis or expose hw queues directly.
>
> We need to expose VMDQ VSI as a native netdev that can expose its own
> queues and support ndo_ ops in order to enable AF_XDP zerocopy on a
> VMDQ. We talked about this approach at the recent netdev conference to
> expose VMDQ VSI as a subdevice with its own netdev.
>
> https://netdevconf.info/0x14/session.html?talk-hardware-acceleration-of-container-networking-interfaces

I still hold the opinion that macvlan is still the best way to go
about addressing most of these needs. The problem with doing isolation
as separate netdevs is the fact that east/west traffic starts to
essentially swamp the PCIe bus on the device as you have to deal with
broadcast/multicast replication and east/west traffic. Leaving that
replication and east/west traffic up to software to handle while
allowing the unicast traffic to be directed is the best way to go in
my opinion.

The problem with just spawning netdevs is that each vendor can do it
differently and what you get varies in functionality. If anything we
would need to come up with a standardized interface to define what
features can be used and exposed. That was one of the motivations
behind using macvlan. So if anything it seems like it might make more
sense to look at extending the macvlan interface to enable offloading
additional features to the lower level device.

With that said I am not certain VMDq is even the right kind of
interface to use for containers. I would be more interested in
something like what we did in fm10k for macvlan offload where we used
resource tags to identify traffic that belonged to a given interface
and just dedicated that to it rather than queues and interrupts. The
problem with dedicating queues and interrupts is that those are a
limited resource so scaling will become an issue when you get to any
decent count of containers.

- Alex
