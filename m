From: Chen Yu <yu.c.chen@intel.com>
Date: Thu, 10 Feb 2022 19:56:53 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Print PHY register address
 when MDI read/write fails
In-Reply-To: <c496b425-7e8a-a0d9-b27a-990b54743a01@molgen.mpg.de>
References: <20220209234302.50833-1-yu.c.chen@intel.com>
 <c496b425-7e8a-a0d9-b27a-990b54743a01@molgen.mpg.de>
Message-ID: <20220210115653.GA53223@chenyu-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Paul, thanks for the review,
On Wed, Feb 09, 2022 at 05:54:25PM +0100, Paul Menzel wrote:
> Dear Chen,
> 
> 
> First, your system time is incorrect, and the message date from the future.
> 
I did not realize this after the system been re-installed recently,
thanks for reminding me.
> 
> Am 10.02.22 um 00:43 schrieb Chen Yu:
> > There is occasional suspend error from e1000e which blocks the
> > system from further suspending:
> 
> Please add a blank line here.
>
Ok.
> Also, please document the specific board/configuration in question.
> 
Ok.
> > [   20.078957] PM: pci_pm_suspend(): e1000e_pm_suspend+0x0/0x780 [e1000e] returns -2
> > [   20.078970] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -2
> > [   20.078974] e1000e 0000:00:1f.6: PM: pci_pm_suspend+0x0/0x170 returned -2 after 371012 usecs
> > [   20.078978] e1000e 0000:00:1f.6: PM: failed to suspend async: error -2
> 
> Please add a blank line her.e
> 
Ok.
> > According to the code flow, this might be caused by broken MDI read/write to PHY registers.
> > However currently the code does not tell us which register is broken. Thus enhance the debug
> > information to print the offender PHY register for easier debugging.
> 
> Please reflow for 75 characters per line, and maybe even paste the new
> messages, if you have a system, where you can reproduce that on.
> 
Ok, will do.

Thanks,
Chenyu
> > Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> > index 0f0efee5fc8e..fd07c3679bb1 100644
> > --- a/drivers/net/ethernet/intel/e1000e/phy.c
> > +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> > @@ -146,11 +146,11 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
> >   			break;
> >   	}
> >   	if (!(mdic & E1000_MDIC_READY)) {
> > -		e_dbg("MDI Read did not complete\n");
> > +		e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (mdic & E1000_MDIC_ERROR) {
> > -		e_dbg("MDI Error\n");
> > +		e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
> > @@ -210,11 +210,11 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
> >   			break;
> >   	}
> >   	if (!(mdic & E1000_MDIC_READY)) {
> > -		e_dbg("MDI Write did not complete\n");
> > +		e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (mdic & E1000_MDIC_ERROR) {
> > -		e_dbg("MDI Error\n");
> > +		e_dbg("MDI Write PHY Red Address %d Error\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
> 
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
