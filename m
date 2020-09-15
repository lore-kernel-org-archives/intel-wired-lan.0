From: Saeed Mahameed <saeed@kernel.org>
Date: Tue, 15 Sep 2020 13:03:03 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 00/10] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200915140326.GG3485708@lunn.ch>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <a28498acdf87f11e81d3282d63f18dbe1a3d5329.camel@kernel.org>
 <20200915140326.GG3485708@lunn.ch>
Message-ID: <734f0c4595a18ab136263b6e5c97e7f48a93abe1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-09-15 at 16:03 +0200, Andrew Lunn wrote:
> On Mon, Sep 14, 2020 at 09:24:28PM -0700, Saeed Mahameed wrote:
> > On Mon, 2020-09-14 at 18:44 -0700, Jesse Brandeburg wrote:
> > > After applying the patches below, the drivers/net/ethernet
> > > directory can be built as modules with W=1 with no warnings (so
> > > far on x64_64 arch only!).
> > > As Jakub pointed out, there is much more work to do to clean up
> > > C=1, but that will be another series of changes.
> > > 
> > > This series removes 1,283 warnings and hopefully allows the
> > > ethernet directory to move forward from here without more
> > > warnings being added. There is only one objtool warning now.
> > > 
> > > Some of these patches are already sent to Intel Wired Lan, but
> > > the rest of the series titled drivers/net/ethernet affects other
> > > drivers. The changes are all pretty straightforward.
> > > 
> > > As part of testing this series I realized that I have ~1,500 more
> > > kdoc warnings to fix due to being in other arch or not compiled
> > > with my x86_64 .config. Feel free to run
> > > $ 'git ls-files *.[ch] | grep drivers/net/ethernet | xargs
> > > scripts/kernel-doc -none'
> > > to see the remaining issues.
> > > 
> > 
> > Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> > 
> > Hi Jesse, 
> > What was the criteria to select which drivers to enable in your
> > .config
> > ?
> > 
> > I think we need some automation here and have a well known .config
> > that
> > enables as many drivers as we can for static + compilation testing,
> > otherwise we are going to need to repeat this patch every 2-3
> > months.
> 
> Hi Saeed
> 
> I would prefer we just enable W=1 by default for everything under
> driver/net. Maybe there is something we can set in
> driver/net/Makefile?
> 


Yes we can have our own gcc options in the Makfile regardless of what
you put in W command line argument.

Example:

KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
KBUILD_CFLAGS += -Wmissing-declarations
KBUILD_CFLAGS += -Wmissing-format-attribute
KBUILD_CFLAGS += -Wmissing-prototypes
KBUILD_CFLAGS += -Wold-style-definition
KBUILD_CFLAGS += -Wmissing-include-dirs



