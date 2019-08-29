From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Date: Thu, 29 Aug 2019 13:49:39 +0000
Subject: [Intel-wired-lan] [next PATCH S9 1/7] i40e: Allow updating OROM
 when a NIC is in recovery mode
In-Reply-To: <92972e00895820ebefa9c2b1b582db0adaf801db.camel@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <92972e00895820ebefa9c2b1b582db0adaf801db.camel@intel.com>
Message-ID: <D4D6338F2E4CB34CB91C5312C72AAC810F0C9A@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
> From: Kirsher, Jeffrey T 
> Sent: Tuesday, August 27, 2019 8:58 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH S9 1/7] i40e: Allow updating OROM when a NIC is in recovery mode
>
> On Mon, 2019-08-26 at 11:16 -0700, Alice Michael wrote:
> > From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > 
> > Allow OROM update with nvmupdate tool when a NIC is in recovery mode.
> > Implemented by not exiting a recovery mode after firmware EMP reset 
> > and before actual OROM update.
> > Previously it was not possible to do the OROM update with nvmupdate 
> > tool.
>
> Should we be referencing our nvmupdate tool?  Is there a plan to integrate this functionality into the existing ethtool interface to update EEPROM's?

Right, we should not reference it and there is no integration plan. I'll change it.

> > 
> > Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index a71369546c23..ed8e62cb5417 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -14559,8 +14559,8 @@ static bool i40e_check_recovery_mode(struct 
> > i40e_pf *pf)
> >  
> >  		return true;
> >  	}
> > -	if (test_and_clear_bit(__I40E_RECOVERY_MODE, pf->state))
> > -		dev_info(&pf->pdev->dev, "Reinitializing in normal mode
> > with full functionality.\n");
> > +	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
> > +		dev_info(&pf->pdev->dev, "Please do POR to initialize
> > adapter in normal mode with full functionality.\n");
>
> POR?  What does that stand for?  Is there is a reason we are using a cryptic acronym in what is supposed to be a useful debug message to the end-user?
>
> FYI, common definitions for POR are "Plan of Record" or "Provided on Request", but neither of those make much sense in this debug message.

I'll also fix this message.

> >  
> >  	return false;
> >  }

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.
