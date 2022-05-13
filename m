From: Jeff Daly <jeffd@silicom-usa.com>
Date: Fri, 13 May 2022 20:38:37 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: correct SDP0 check of
 SFP cage for X550
In-Reply-To: <fd59c0e8-7f84-a09a-f673-339919b4a056@intel.com>
References: <20220420205130.23616-1-jeffd@silicom-usa.com>
 <20220425131758.4749-1-jeffd@silicom-usa.com>
 <fd59c0e8-7f84-a09a-f673-339919b4a056@intel.com>
Message-ID: <VI1PR0402MB3517DE4A2EFD5E3B0A377E0DEACA9@VI1PR0402MB3517.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> Sent: Thursday, May 12, 2022 1:09 PM
> To: Jeff Daly <jeffd@silicom-usa.com>; intel-wired-lan at osuosl.org; Skajewski,
> PiotrX <piotrx.skajewski@intel.com>
> Cc: Stephen Douthit <stephend@silicom-usa.com>; Jesse Brandeburg
> <jesse.brandeburg@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Jeff
> Kirsher <jeffrey.t.kirsher@intel.com>; Don Skidmore
> <donald.c.skidmore@intel.com>; moderated list:INTEL ETHERNET DRIVERS
> <intel-wired-lan@lists.osuosl.org>; open list:NETWORKING DRIVERS
> <netdev@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2 1/1] ixgbe: correct SDP0 check of SFP cage for X550
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments.
> 
> 
> On 4/25/2022 6:17 AM, Jeff Daly wrote:
> > SDP0 for X550 NICs is active low to indicate the presence of an SFP in
> > the cage (MOD_ABS#).  Invert the results of the logical AND to set
> > sfp_cage_full variable correctly.
> 
> Hi Jeff,
> 
> Adding our developer and adding his response here:
> 
> "
> Our analysis (using 0x15c4) showed that every time the cage is empty SDP
> indicates 0 and when cage is full it indicates 1. No matter what transceiver we
> used, from those we have. The same happens even we don't use the device
> which fall into crosstalk fix e.g 0x15c2.
> 
> When proposed patch was applied, the devices are no longer able to negotiate
> speed. So basically this patch should not be accepted.
> 
> NACK
> 
> BR,
> Piotr
> "

Here's the issue:  the pin definition of SDP MOD_ABS is that the signal will be a '1'
from the cage when the module is absent.  it's up to the platform to invert the signal
if it's intended to be used as an interrupt input since the SDPx interrupt detection
is only rising edge.  you can see this implementation on pg 107 of Intel document
331520-05 (rev 3.4) as figure 3-11.  while the document is for the 82599, it clearly 
shows that SDP2 (as in the code below) is used for MOD_ABS indication, vs in the
X550 platform implementation where it appears to (always?) be SDP0.  But, since
it's a platform-supplied inverter that turns the MOD_ABS signal from an active high
to active low (and therefore is read by the code as a and active high 'MODULE PRESENT'
signal), there should be an option to change the polarity of the signal to indicate
presence or absence.  I submitted a different patch for the TX_DISABLE configuration
for platforms that don't use SDP3 for TX_DISABLE and it was nack'd because there
were no more module params allowed (which is ideally what this patch would also be).

So, it doesn't appear to be specifically required for the platform to implement the 
signal with an inverter, shouldn't there be a configuration option that makes this
opposite polarity depending on the platform?

> 
> > Fixes: aac9e053f104 ("ixgbe: cleanup crosstalk fix")
> > Suggested-by: Stephen Douthit <stephend@silicom-usa.com>
> > Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> > index 4c26c4b92f07..13482d4e24e2 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> > @@ -3299,17 +3299,17 @@ s32 ixgbe_check_mac_link_generic(struct
> ixgbe_hw *hw, ixgbe_link_speed *speed,
> >        * the SFP+ cage is full.
> >        */
> >       if (ixgbe_need_crosstalk_fix(hw)) {
> > -             u32 sfp_cage_full;
> > +             bool sfp_cage_full;
> >
> >               switch (hw->mac.type) {
> >               case ixgbe_mac_82599EB:
> > -                     sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
> > -                                     IXGBE_ESDP_SDP2;
> > +                     sfp_cage_full = !!(IXGBE_READ_REG(hw, IXGBE_ESDP) &
> > +                                        IXGBE_ESDP_SDP2);
> >                       break;
> >               case ixgbe_mac_X550EM_x:
> >               case ixgbe_mac_x550em_a:
> > -                     sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
> > -                                     IXGBE_ESDP_SDP0;
> > +                     sfp_cage_full = !(IXGBE_READ_REG(hw, IXGBE_ESDP) &
> > +                                       IXGBE_ESDP_SDP0);
> >                       break;
> >               default:
> >                       /* sanity check - No SFP+ devices here */
