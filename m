From: Sven Auhagen <sven.auhagen@voleatech.de>
Date: Mon, 19 Oct 2020 07:43:10 +0200
Subject: [Intel-wired-lan] [PATCH v2 0/6] igb: xdp patches followup
In-Reply-To: <20201018133951.GB34104@ranger.igk.intel.com>
References: <20201017071238.95190-1-sven.auhagen@voleatech.de>
 <20201018133951.GB34104@ranger.igk.intel.com>
Message-ID: <20201019054310.uwy4whq2eizvdolz@SvensMacBookAir-2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Oct 18, 2020 at 03:39:51PM +0200, Maciej Fijalkowski wrote:
> On Sat, Oct 17, 2020 at 09:12:32AM +0200, sven.auhagen at voleatech.de wrote:
> > From: Sven Auhagen <sven.auhagen@voleatech.de>
> > 
> > This patch series addresses some of the comments that came back
> > after the igb XDP patch was accepted.
> > Most of it is code cleanup.
> > The last patch contains a fix for a tx queue timeout
> > that can occur when using xdp.
> > 
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Sorry for not getting back at v1 discussion, I took some time off.
> 
> For the series:
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Couple nits:
> - you don't need SOB line within cover letter, I suppose
> - next time please specify the tree in the subject that you're targetting
>   this set to land; is it net or net-next? net-next is currently closed so
>   you probably would have to come back with this once it will be open
>   again
> - SOB line should be at the end of tags within commit message of patch;
>   I'm saying 'should' because I'm not sure if it's hard requirement.

Thank you, I will fix that and send a v3.

Best
Sven

> 
> > 
> > Change from v1:
> >     * Drop patch 5 as the igb_rx_frame_truesize won't match
> >     * Fix typo in comment
> >     * Add Suggested-by and Reviewed-by tags
> >     * Add how to avoid transmit queue timeout in xdp path
> >       is fixed in the commit message
> > 
> > Sven Auhagen (6):
> >   igb: XDP xmit back fix error code
> >   igb: take vlan double header into account
> >   igb: XDP extack message on error
> >   igb: skb add metasize for xdp
> >   igb: use xdp_do_flush
> >   igb: avoid transmit queue timeout in xdp path
> > 
> >  drivers/net/ethernet/intel/igb/igb.h      |  5 ++++
> >  drivers/net/ethernet/intel/igb/igb_main.c | 32 +++++++++++++++--------
> >  2 files changed, 26 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
