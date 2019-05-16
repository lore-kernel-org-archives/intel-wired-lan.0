From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 16 May 2019 15:02:18 -0700
Subject: [Intel-wired-lan] [PATCH] igb: add parameter to ignore nvm
 checksum validation
In-Reply-To: <76B41175-0CEE-466C-91BF-89A1CA857061@cisco.com>
References: <1557357269-9498-1-git-send-email-nkela@cisco.com>
 <9be117dc6e818ab83376cd8e0f79dbfaaf193aa9.camel@intel.com>
 <76B41175-0CEE-466C-91BF-89A1CA857061@cisco.com>
Message-ID: <4469196a-0705-5459-8aca-3f08e9889d61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/16/19 12:55 PM, Nikunj Kela (nkela) wrote:
> 
> 
> On 5/16/19, 12:35 PM, "Jeff Kirsher" <jeffrey.t.kirsher@intel.com> wrote:
> 
>     On Wed, 2019-05-08 at 23:14 +0000, Nikunj Kela wrote:
>    >> Some of the broken NICs don't have EEPROM programmed correctly. It
>    >> results
>    >> in probe to fail. This change adds a module parameter that can be
>    >> used to
>    >> ignore nvm checksum validation.
>    >> 
>    >> Cc: xe-linux-external at cisco.com
>    >> Signed-off-by: Nikunj Kela <nkela@cisco.com>
>    >> ---
>    >>  drivers/net/ethernet/intel/igb/igb_main.c | 28
>    >> ++++++++++++++++++++++------
>    >>  1 file changed, 22 insertions(+), 6 deletions(-)
>     
>     >NAK for two reasons.  First, module parameters are not desirable
>     >because their individual to one driver and a global solution should be
>     >found so that all networking device drivers can use the solution.  This
>     >will keep the interface to change/setup/modify networking drivers
>     >consistent for all drivers.
> 
>     
>     >Second and more importantly, if your NIC is broken, fix it.  Do not try
>     >and create a software workaround so that you can continue to use a
>     >broken NIC.  There are methods/tools available to properly reprogram
>     >the EEPROM on a NIC, which is the right solution for your issue.
> 
> I am proposing this as a debug parameter. Obviously, we need to fix EEPROM but this helps us continuing the development while manufacturing fixes NIC.

Then why even bother with sending this upstream?
-- 
Florian
