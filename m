From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 27 May 2016 01:30:58 +0000
Subject: [Intel-wired-lan] [RFC PATCH net] e1000e: keep vlan interfaces
 functional after rxvlan off
In-Reply-To: <1463607599.2713.70.camel@intel.com>
References: <1463511831-13684-1-git-send-email-jarod@redhat.com>
 <1463607599.2713.70.camel@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F104AC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, May 18, 2016 2:40 PM
> To: Jarod Wilson <jarod@redhat.com>; linux-kernel at vger.kernel.org;
> Avargil, Raanan <raanan.avargil@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [RFC PATCH net] e1000e: keep vlan interfaces
> functional after rxvlan off
> 
> On Tue, 2016-05-17 at 15:03 -0400, Jarod Wilson wrote:
> > I've got a bug report about an e1000e interface, where a vlan interface
> > is
> > set up on top of it:
> >
> > $ ip link add link ens1f0 name ens1f0.99 type vlan id 99
> > $ ip link set ens1f0 up
> > $ ip link set ens1f0.99 up
> > $ ip addr add 192.168.99.92 dev ens1f0.99
> >
> > At this point, I can ping another host on vlan 99, ip 192.168.99.91.
> > However, if I do the following:
> >
> > $ ethtool -K ens1f0 rxvlan off
> >
> > Then no traffic passes on ens1f0.99. It comes back if I toggle rxvlan on
> > again. I'm not sure if this is actually intended behavior, or if there's
> > a
> > lack of software vlan stripping fallback, or what, but things continue to
> > work if I simply don't call e1000e_vlan_strip_disable() if there are
> > active vlans (plagiarizing a function from the e1000 driver here) on the
> > interface.
> >
> > Also slipped a related-ish fix to the kerneldoc text for
> > e1000e_vlan_strip_disable here...
> >
> > CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > CC: intel-wired-lan at lists.osuosl.org
> > CC: netdev at vger.kernel.org
> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > ---
> > ?drivers/net/ethernet/intel/e1000e/netdev.c | 15 +++++++++++++--
> > ?1 file changed, 13 insertions(+), 2 deletions(-)
> 
> Raanan, please review this patch. ?Even though it is an RFC I will be
> adding it to my queue for testing.
> http://patchwork.ozlabs.org/patch/623238/

Yup, without this patch disabling rxvlan offload does indeed break vlan connectivity and with the patch I can disable and re-enable rxvlan offloads as much as I care to.  It also makes it through my regression tests without problems.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

This is from functional - does it work - testing perspective so review is probably still in order.
