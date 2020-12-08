From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 8 Dec 2020 10:18:49 -0800
Subject: [Intel-wired-lan] [PATCH v3 1/7] e1000e: fix S0ix flow to allow
 S0i3.2 subset entry
In-Reply-To: <354075ae-f605-eb01-4cf9-a66e4eb7b192@dell.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
 <20201204200920.133780-2-mario.limonciello@dell.com>
 <354075ae-f605-eb01-4cf9-a66e4eb7b192@dell.com>
Message-ID: <20201208101849.5a17b469@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Dec 2020 11:24:17 -0600 Mario Limonciello wrote:
> On 12/4/20 2:09 PM, Mario Limonciello wrote:
> > From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> >
> > Changed a configuration in the flows to align with
> > architecture requirements to achieve S0i3.2 substate.
> >
> > Also fixed a typo in the previous commit 632fbd5eb5b0
> > ("e1000e: fix S0ix flows for cable connected case").
> >
> > Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)  
> 
> I realize that the series is still under discussion, but I intentionally 
> moved this
> patch to the front of the series so it can be pulled in even if the 
> others are still
> discussed.
> 
> @David Miller:
> This particular patch is more important than the rest.? It actually 
> fixes issues
> on the non-ME i219V as well.? Can this one be queued up and we can keep
> discussing the rest?

Not sure Dave will notice this discussion, best if you repost this patch
separately. If it's a fix that should be backported to stable make sure
you add a Fixes tag.
