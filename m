From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Wed, 20 Jan 2021 10:17:46 +0000
Subject: [Intel-wired-lan] [PATCH net v4 1/2] i40e: Revert "i40e: don't
 report link up for a VF who hasn't enabled queues"
In-Reply-To: <a1480517830b533099bf5ce90e09a9fd5c00504e.camel@intel.com>
References: <20210118193454.275037-1-arkadiusz.kubalewski@intel.com>
 <20210118193454.275037-2-arkadiusz.kubalewski@intel.com>
 <a1480517830b533099bf5ce90e09a9fd5c00504e.camel@intel.com>
Message-ID: <DM6PR11MB2876AD6ADFBAB24F8BA8D631E5A29@DM6PR11MB2876.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Good day Anthony

This is the first time we push a revert commit. /*we thought that CL should be enough, and provided standard revert commit message from GIT*/
Can you link us to example of good revert commit message?

Thank you
Alex
ND ITP Linux 40G base driver TL 



-----Original Message-----
From: Nguyen, Anthony L <anthony.l.nguyen@intel.com> 
Sent: Wednesday, January 20, 2021 2:30 AM
To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; intel-wired-lan at lists.osuosl.org
Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net v4 1/2] i40e: Revert "i40e: don't report link up for a VF who hasn't enabled queues"

On Mon, 2021-01-18 at 19:34 +0000, Arkadiusz Kubalewski wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This reverts commit 2ad1274fa35ace5c6360762ba48d33b63da2396c

Can you provide more info on why we are reverting? Some of the information from the cover letter would probably be useful here.

> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 
