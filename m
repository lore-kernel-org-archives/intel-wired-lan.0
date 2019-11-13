From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Wed, 13 Nov 2019 10:51:04 +0000
Subject: [Intel-wired-lan] [e1000-patches] [PATCH] igb: read flash with
 iomem=strict
In-Reply-To: <20191112114249.00002280@intel.com>
References: <0EF347314CF65544BA015993979A29CDB4ED9024@IRSMSX102.ger.corp.intel.com>
 <498edf36e634b9590fd7f58fa7febde226bb3e6e.camel@intel.com>
 <20191112114249.00002280@intel.com>
Message-ID: <0EF347314CF65544BA015993979A29CDB4EDF0D2@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Jesse Brandeburg <jesse.brandeburg@intel.com> 
Sent: Tuesday, November 12, 2019 8:45 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org; Ludkiewicz, Adam <adam.ludkiewicz@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>
Subject: Re: [Intel-wired-lan] [e1000-patches] [PATCH] igb: read flash with iomem=strict

On Tue, 12 Nov 2019 11:05:38 -0800 Jeff wrote:
> On Tue, 2019-11-12 at 13:03 +0000, Loktionov, Aleksandr wrote:
> > When Secure Boot is enabled access to the /dev/mem is forbidden for 
> > user- space applications and clients are reporting inability to use 
> > tools in Secure Boot Mode. The way to perform NVM update is to use igb driver.
> > Currently 1G Linux Base Driver has API which allows only EEPROM access.
> > There is a need to extend IOCTL API to allow NVM and registers access.
> > These defines are necessary for NVM access functions.
> > 
> > Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> > ---
> 
> This patch only adds defines and macros which are not being used in 
> the driver currently.  It appears you are missing the code to actually 
> use these defines.  Your missing the changes that Adam made to 
> igb_ethtool.c, which are currently being reviewed internally.
> 
> Since this is an incomplete patch, I will drop it from the queue and 
> will await a v2 of the patch that has the complete changes needed in the driver.

Not only that, but this is the same code that was just rejected for the ice driver. I think we should NOT be trying to push this upstream, knowing that it will likely be rejected.

But it's almost the same code tat was already accepted and upstreamed for ixbge.

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

