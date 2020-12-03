From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 3 Dec 2020 17:21:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/3] i40e, ice,
 ixgbe: optimize for XDP_REDIRECT in xsk path
In-Reply-To: <CAJ8uoz04dFruNnDDyvgbPBZBbMqZxHS6xQJ66dnoPLFtWXv0Uw@mail.gmail.com>
References: <20201202150724.31439-1-magnus.karlsson@gmail.com>
 <20201202204041.GA30907@ranger.igk.intel.com>
 <CAJ8uoz04dFruNnDDyvgbPBZBbMqZxHS6xQJ66dnoPLFtWXv0Uw@mail.gmail.com>
Message-ID: <618e35ec5aa31b92990a9224181a9011119fc98c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2020-12-03 at 07:58 +0100, Magnus Karlsson wrote:
> On Wed, Dec 2, 2020 at 9:49 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> > 
> > On Wed, Dec 02, 2020 at 04:07:21PM +0100, Magnus Karlsson wrote:
> > > Optimize run_xdp_zc() for the XDP program verdict being
> > > XDP_REDIRECT
> > > in the zsk zero-copy path. This path is only used when having
> > > AF_XDP
> > > zero-copy on and in that case most packets will be directed to
> > > user
> > > space. This provides around 100k extra packets in throughput on
> > > my
> > > server when running l2fwd in xdpsock.
> > > 
> > > Thanks: Magnus
> > 
> > For series:
> > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > 
> > You only ate 'e' from i40e subject line.
> 
> Sorry, you are right. Tony, would you please be so kind to add this
> missing "e" in the commit message before you send the pull request?
> 
> Thanks: Magnus

I can do that.

Thanks,
Tony

> > > 
> > > Magnus Karlsson (3):
> > >   i40: optimize for XDP_REDIRECT in xsk path
> > >   ixgbe: optimize for XDP_REDIRECT in xsk path
> > >   ice: optimize for XDP_REDIRECT in xsk path
> > > 
> > >  drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 11 +++++++----
> > >  drivers/net/ethernet/intel/ice/ice_xsk.c     | 12 ++++++++----
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 11 +++++++----
> > >  3 files changed, 22 insertions(+), 12 deletions(-)
> > > 
> > > 
> > > base-commit: 6b4f503186b73e3da24c6716c8c7ea903e6b74d4
> > > --
> > > 2.29.0
