From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 14 Dec 2020 21:23:02 +0000
Subject: [Intel-wired-lan] [PATCH net] iavf: fix double-release of
 rtnl_lock
In-Reply-To: <20201203094100.516612a1@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201203021806.692194-1-kuba@kernel.org>
 <1867f98e7951f8d044a7dbf16fcf6a93996914f7.camel@intel.com>
 <20201203094100.516612a1@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Message-ID: <CY4PR11MB1576A8474925E179AAE0EA36ABC70@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jakub Kicinski
> Sent: czwartek, 3 grudnia 2020 18:41
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Pawlak, Jakub
> <jakub.pawlak@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix double-release of rtnl_lock
> 
> On Thu, 3 Dec 2020 17:04:14 +0000 Nguyen, Anthony L wrote:
> > On Wed, 2020-12-02 at 18:18 -0800, Jakub Kicinski wrote:
> > > This code does not jump to exit on an error in
> > > iavf_lan_add_device(), so the rtnl_unlock() from the normal path will
> follow.
> > >
> > > Fixes: b66c7bc1cd4d ("iavf: Refactor init state machine")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > >  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >
> > Did you want to apply this or did you want me to take it?
Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

