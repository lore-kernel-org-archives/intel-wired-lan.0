From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Oct 2021 19:28:39 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: set X550 MDIO speed before
 talking to PHY
In-Reply-To: <df9504c8-bdfd-9cc0-d002-f1e59f57a79b@lynx.com>
References: <81be24c4-a7e4-0761-abf4-204f4849b6eb@lynx.com>
 <89af2e39-fe5c-c285-7805-8c7a6a5a2e51@molgen.mpg.de>
 <df9504c8-bdfd-9cc0-d002-f1e59f57a79b@lynx.com>
Message-ID: <YX2Ax364TiC7ngjI@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 29, 2021 at 04:06:26PM -0700, Cyril Novikov wrote:
> On 10/28/2021 11:47 PM, Paul Menzel wrote:
> > Dear Cyril,
> > 
> > 
> > On 29.10.21 03:03, Cyril Novikov wrote:
> > > The MDIO bus speed must be initialized before talking to the PHY the
> > > first
> > > time in order to avoid talking to it using a speed that the PHY doesn't
> > > support.
> > > 
> > > This fixes HW initialization error -17 (IXGBE_ERR_PHY_ADDR_INVALID) on
> > > Denverton CPUs (a.k.a. the Atom C3000 family) on ports with a 10Gb
> > > network
> > > plugged in. On those devices, HLREG0[MDCSPD] resets to 1, which combined
> > > with the 10Gb network results in a 24MHz MDIO speed, which is apparently
> > > too fast for the connected PHY. PHY register reads over MDIO bus return
> > > garbage, leading to initialization failure.
> > 
> > Maybe add a Fixes tag?
> 
> This is my first patch submission for Linux kernel.

Welcome to the community.

> What I read about the
> Fixes tag says it identifies a previous commit that had introduced the bug.
> I have no idea which commit introduced this bug. We saw it in 4.19 which
> probably means the bug was always there and is not a regression. It's also
> quite possible the original commit was correct for the hardware existing at
> that time and it only started behaving incorrectly with new hardware, so it
> wasn't actually a bug at the time it was submitted. I also don't have the
> capability or time to bisect this problem.

From how you describe it, i assume the issue is present for any 10G
links? git blame suggests:

e84db7272798e (Mark Rustad         2016-04-01 12:18:30 -0700 3357) static void ixgbe_set_mdio_speed(struct ixgbe_hw *hw)
e84db7272798e (Mark Rustad         2016-04-01 12:18:30 -0700 3358) {
e84db7272798e (Mark Rustad         2016-04-01 12:18:30 -0700 3359)      u32 hlreg0;
e84db7272798e (Mark Rustad         2016-04-01 12:18:30 -0700 3360) 
e84db7272798e (Mark Rustad         2016-04-01 12:18:30 -0700 3361)      switch (hw->device_id) {
e84db7272798e (Mark Rustad         2016-04-01 12:18:30 -0700 3362)      case IXGBE_DEV_ID_X550EM_X_10G_T:
a83c27e79068c (Don Skidmore        2016-08-17 17:34:07 -0400 3363)      case IXGBE_DEV_ID_X550EM_A_SGMII:
a83c27e79068c (Don Skidmore        2016-08-17 17:34:07 -0400 3364)      case IXGBE_DEV_ID_X550EM_A_SGMII_L:
92ed84300718d (Don Skidmore        2016-08-17 20:34:40 -0400 3365)      case IXGBE_DEV_ID_X550EM_A_10G_T:

commit e84db7272798ed8abb2760a3fcd9c6d89abf99a5
Author: Mark Rustad <mark.d.rustad@intel.com>
Date:   Fri Apr 1 12:18:30 2016 -0700

    ixgbe: Introduce function to control MDIO speed
    
    Move code that controls MDIO speed into a new function because
    there will be more MACs that need the control.
    
    Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
    Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
    Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

So the fixes would be

Fixes: e84db7272798 ("ixgbe: Introduce function to control MDIO speed")

> > > Signed-off-by: Cyril Novikov <cnovikov@lynx.com>
> > > ---
> > > ? drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 +++
> > > ? 1 file changed, 3 insertions(+)
> > > 
> > > Reproduced with Linux kernel 4.19 and 5.15-rc7. Can be reproduced using
> > > the following setup:
> > > 
> > > * Use an Atom C3000 family system with at least one X550 LAN on the SoC
> > > * Disable PXE or other BIOS network initialization if possible
> > > ?? (the interface must not be initialized before Linux boots)
> > > * Connect a live 10Gb Ethernet cable to an X550 port
> > > * Power cycle (not reset, doesn't always work) the system and boot Linux
> > > * Observe: ixgbe interfaces w/ 10GbE cables plugged in fail with
> > > error -17
> > 
> > Why not add that to the commit message?
> 
> I wasn't sure if the reproduction scenario belonged to the commit message,
> and have no problem adding it if you believe it does.

> > 
> > Is `ixgbe_set_mdio_speed(hw)` at the end of the function then still needed?
> 
> The code between the two calls issues a global reset to the MAC and
> optionally the link, depending on some flags. That may reset the MDIO speed
> back to the wrong value or, according to the comments in the code, may reset
> the PHY and result in renegotiation and a different link speed. So, the MDIO
> speed setting may require an adjustment. Even if it actually doesn't at the
> moment, doing the second call makes the code robust to future software and
> hardware changes.

This is useful information to put in the commit message.

When writing commit messages, try to also think from the perspective
of the person doing the review. What questions are the reviewers
likely to ask, and can those questions be answered in the commit
message, rather than having them asked on the list?

Another use case of the commit message is when it turns out a change
causes a regression. It happens sometimes, and including information
about how you tested your change can be useful for helping fix the
regression. It allows whoever is fixing the regression to also test
your case, or at least something similar.

So in general, more information in the commit messages is better than
less.

     Andrew
