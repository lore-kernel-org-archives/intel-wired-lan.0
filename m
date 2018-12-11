From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 11 Dec 2018 15:19:40 +0300
Subject: [Intel-wired-lan] [bug report] igc: Add code for PHY support
In-Reply-To: <1e317756-e189-1f9a-e2a6-f5b282640d55@intel.com>
References: <20181211094103.GA26611@kadam>
 <1e317756-e189-1f9a-e2a6-f5b282640d55@intel.com>
Message-ID: <20181211121940.GA27088@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 11, 2018 at 01:46:36PM +0200, Neftin, Sasha wrote:
> On 12/11/2018 11:41, Dan Carpenter wrote:
> > Hello Sasha Neftin,
> > 
> > The patch 5586838fe9ce: "igc: Add code for PHY support" from Oct 11,
> > 2018, leads to the following static checker warning:
> > 
> > 	drivers/net/ethernet/intel/igc/igc_phy.c:167 igc_check_downshift()
> > 	info: ignoring unreachable code.
> > 
> > drivers/net/ethernet/intel/igc/igc_phy.c
> >     144  /**
> >     145   * igc_check_downshift - Checks whether a downshift in speed occurred
> >     146   * @hw: pointer to the HW structure
> >     147   *
> >     148   * Success returns 0, Failure returns 1
> >     149   *
> >     150   * A downshift is detected by querying the PHY link health.
> >     151   */
> >     152  s32 igc_check_downshift(struct igc_hw *hw)
> >     153  {
> >     154          struct igc_phy_info *phy = &hw->phy;
> >     155          u16 phy_data, offset, mask;
> >     156          s32 ret_val;
> >     157
> >     158          switch (phy->type) {
> >     159          case igc_phy_i225:
> >     160          default:
> >     161                  /* speed downshift not supported */
> >     162                  phy->speed_downgraded = false;
> >     163                  ret_val = 0;
> >     164                  goto out;
> >                          ^^^^^^^^^
> > We always say it's not supported >
> Thanks Dan. I remember, you already point me on this.

Oops.  Sorry, I have switched devel boxes so maybe that's why it was
marked as a new bug.

regards,
dan carpenter

