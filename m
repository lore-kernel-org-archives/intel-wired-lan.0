From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 14:58:01 +0000
Subject: [Intel-wired-lan] [PATCH v2 03/13] ixgbevf: make use of BIT()
 macro to avoid shift of signed values
In-Reply-To: <1460607752.2960.51.camel@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
 <1460588914-20143-4-git-send-email-jacob.e.keller@intel.com>
 <1460607752.2960.51.camel@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857A713E5@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Wednesday, April 13, 2016 9:23 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH v2 03/13] ixgbevf: make use of BIT()
> macro to avoid shift of signed values
> 
> On Wed, 2016-04-13 at 16:08 -0700, Jacob Keller wrote:
> > Also cleanup a case where we're bit shifting a value into place, and
> > use
> > an unsigned constant. Make use of the unsigned postfix in places
> > where
> > BIT() macro is not appropriate.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/ixgbevf/defines.h????? | 22 +++++++++++
> > -----------
> > ?drivers/net/ethernet/intel/ixgbevf/ethtool.c????? |? 3 ++-
> > ?drivers/net/ethernet/intel/ixgbevf/ixgbevf.h????? |? 8 ++++----
> > ?drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 18 +++++++++--
> > -------
> > ?4 files changed, 26 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h
> > b/drivers/net/ethernet/intel/ixgbevf/defines.h
> > index 58434584b16d..74901f7ef391 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/defines.h
> > +++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
> > @@ -74,7 +74,7 @@ typedef u32 ixgbe_link_speed;
> > ?#define IXGBE_RXDCTL_RLPML_EN??0x00008000
> >
> > ?/* DCA Control */
> > -#define IXGBE_DCA_TXCTRL_TX_WB_RO_EN (1 << 11) /* Tx Desc
> writeback
> > RO bit */
> > +#define IXGBE_DCA_TXCTRL_TX_WB_RO_EN BIT(11) /* Tx Desc
> writeback RO
> > bit */
> >
> > ?/* PSRTYPE bit definitions */
> > ?#define IXGBE_PSRTYPE_TCPHDR???0x00000010
> > @@ -296,16 +296,16 @@ struct ixgbe_adv_tx_context_desc {
> > ?#define IXGBE_TXDCTL_SWFLSH????????????0x04000000 /* Tx Desc. wr-bk
> > flushing */
> > ?#define IXGBE_TXDCTL_WTHRESH_SHIFT?????16???????? /* shift to
> > WTHRESH bits */
> >
> > -#define IXGBE_DCA_RXCTRL_DESC_DCA_EN???(1 << 5)? /* Rx Desc enable
> > */
> > -#define IXGBE_DCA_RXCTRL_HEAD_DCA_EN???(1 << 6)? /* Rx Desc header
> > ena */
> > -#define IXGBE_DCA_RXCTRL_DATA_DCA_EN???(1 << 7)? /* Rx Desc
> payload
> > ena */
> > -#define IXGBE_DCA_RXCTRL_DESC_RRO_EN???(1 << 9)? /* Rx rd Desc
> Relax
> > Order */
> > -#define IXGBE_DCA_RXCTRL_DATA_WRO_EN???(1 << 13) /* Rx wr data
> Relax
> > Order */
> > -#define IXGBE_DCA_RXCTRL_HEAD_WRO_EN???(1 << 15) /* Rx wr header
> RO
> > */
> > +#define IXGBE_DCA_RXCTRL_DESC_DCA_EN???BIT(5)? /* Rx Desc enable
> */
> > +#define IXGBE_DCA_RXCTRL_HEAD_DCA_EN???BIT(6)? /* Rx Desc header
> ena
> > */
> > +#define IXGBE_DCA_RXCTRL_DATA_DCA_EN???BIT(7)? /* Rx Desc payload
> > ena */
> > +#define IXGBE_DCA_RXCTRL_DESC_RRO_EN???BIT(9)? /* Rx rd Desc Relax
> > Order */
> > +#define IXGBE_DCA_RXCTRL_DATA_WRO_EN???BIT(13) /* Rx wr data
> Relax
> > Order */
> > +#define IXGBE_DCA_RXCTRL_HEAD_WRO_EN???BIT(15) /* Rx wr header
> RO */
> >
> > -#define IXGBE_DCA_TXCTRL_DESC_DCA_EN???(1 << 5)? /* DCA Tx Desc
> > enable */
> > -#define IXGBE_DCA_TXCTRL_DESC_RRO_EN???(1 << 9)? /* Tx rd Desc
> Relax
> > Order */
> > -#define IXGBE_DCA_TXCTRL_DESC_WRO_EN???(1 << 11) /* Tx Desc
> > writeback RO bit */
> > -#define IXGBE_DCA_TXCTRL_DATA_RRO_EN???(1 << 13) /* Tx rd data
> Relax
> > Order */
> > +#define IXGBE_DCA_TXCTRL_DESC_DCA_EN???BIT(5)? /* DCA Tx Desc
> enable
> > */
> > +#define IXGBE_DCA_TXCTRL_DESC_RRO_EN???BIT(9)? /* Tx rd Desc Relax
> > Order */
> > +#define IXGBE_DCA_TXCTRL_DESC_WRO_EN???BIT(11) /* Tx Desc
> writeback
> > RO bit */
> > +#define IXGBE_DCA_TXCTRL_DATA_RRO_EN???BIT(13) /* Tx rd data Relax
> > Order */
> >
> > ?#endif /* _IXGBEVF_DEFINES_H_ */
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> > b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> > index 64d5c6e9343e..4cadf80e5b87 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> > +++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> > @@ -166,7 +166,8 @@ static void ixgbevf_get_regs(struct net_device
> > *netdev,
> >
> > ????????memset(p, 0, regs_len);
> >
> > -???????regs->version = (1 << 24) | hw->revision_id << 16 | hw-
> > >device_id;
> > +???????/* generate a number suitable for ethtool's register version
> > */
> > +???????regs->version = (1u << 24) | (hw->revision_id << 16) | hw-
> > >device_id
> 
> I guessing you did not bother compile testing because it is pretty
> obvious your missing a ';' in the line above. ?I have added the missing
> semi-colon so that validation can move forward.

Oops :( thanks Jeff.
