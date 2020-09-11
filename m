From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 11 Sep 2020 16:28:43 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 05/11] intel-ethernet:
 make W=1 build cleanly
In-Reply-To: <877dt0nr8r.fsf@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-6-jesse.brandeburg@intel.com>
 <877dt0nr8r.fsf@intel.com>
Message-ID: <20200911162843.00002730@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vinicius Costa Gomes wrote:


> > diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> > index 4e7a0810eaeb..2120dacfd55c 100644
> > --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> > +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> > @@ -139,6 +139,7 @@ static void e1000_phy_init_script(struct e1000_hw *hw)
> >  		 * at the end of this routine.
> >  		 */
> >  		ret_val = e1000_read_phy_reg(hw, 0x2F5B, &phy_saved_data);
> > +		e_dbg("Reading PHY register 0x2F5B failed: %d\n", ret_val);
> >
> 
> Adding this debug statement seems unrelated.

Thanks, in the next version I actually addressed this in the commit
message, that this one change was to solve the "you didn't use ret_val"
with a conceivably useful message. I also rejiggered the patches to
have the register read lvalue removals all in their own patch instead
of squashed together with kdoc changes.

> 
> >  		/* Disabled the PHY transmitter */
> >  		e1000_write_phy_reg(hw, 0x2F5B, 0x0003);
> 
> Apart from this,
> 
> Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 

Thanks for the review!
