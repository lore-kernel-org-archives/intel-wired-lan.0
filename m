From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 10 May 2022 13:28:47 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: correct SDP0 check of
 SFP cage for X550
In-Reply-To: <BL0PR11MB299331AAD0B587D12B965D5899C99@BL0PR11MB2993.namprd11.prod.outlook.com>
References: <BL0PR11MB299331AAD0B587D12B965D5899C99@BL0PR11MB2993.namprd11.prod.outlook.com>
Message-ID: <YnpMbwAFMnYTrc33@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 10, 2022 at 11:21:42AM +0000, Skajewski, PiotrX wrote:
> Hi Jeff,
> 
> Our analysis (using 0x15c4) showed that every time the cage is empty SDP indicates 0 and when cage is full it indicates 1.
> No matter what transceiver we used, from those we have.

Please wrap your sentences to 75 chars per line, people that read mailing
lists will be grateful for that.

> The same happens even we don't use the device which fall into crosstalk fix e.g 0x15c2.
> 
> When proposed patch was applied, the devices are no longer able to negotiate speed.
> so basically this patch should not be accepted.

We don't know what you're referring to. Please respond to the patch
itself rather than carrying only the subject of the patch.

> 
> NACK
> 
> BR,
> Piotr
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
