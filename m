From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 12 Feb 2020 14:47:34 -0800
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Complete to commit Add
 support for TSO
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B971F357D@ORSMSX103.amr.corp.intel.com>
References: <20200205123115.44103-1-sasha.neftin@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B971F357D@ORSMSX103.amr.corp.intel.com>
Message-ID: <CAKgT0UfvFZBPEYf1-b+WU48RKk1_sp8xzJtKe6rAXAk8_bCZ9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 12, 2020 at 2:39 PM Brown, Aaron F <aaron.f.brown@intel.com> wrote:
>
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Sasha Neftin
> > Sent: Wednesday, February 5, 2020 4:31 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Complete to commit Add
> > support for TSO
> >
> > commit f38b782dccab ("igc: Add support for TSO")
> > Add option to setting transmit command (TUCMD) of the context
> > descriptor based on skb_shinfo gso_type and SKB_GSO_UDP_L4 flag.
> >
> > Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_defines.h | 1 +
> >  drivers/net/ethernet/intel/igc/igc_main.c    | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> Aside from possibly including the responses to Jesse's questions on this...
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

I'm not sure the patch makes any sense. Does the driver support UDP
GSO? I don't see the feature flag (NETIF_F_GSO_UDP_L4) anywhere that
enables it.

If it doesn't enable it then it doesn't make much sense to update the
code to add this one bit until it does since you can't actually test
it as the stack will not ask you to segment UDP frames.
