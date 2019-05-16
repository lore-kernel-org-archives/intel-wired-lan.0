From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 16 May 2019 12:35:27 -0700
Subject: [Intel-wired-lan] [PATCH] igb: add parameter to ignore nvm
 checksum validation
In-Reply-To: <1557357269-9498-1-git-send-email-nkela@cisco.com>
References: <1557357269-9498-1-git-send-email-nkela@cisco.com>
Message-ID: <9be117dc6e818ab83376cd8e0f79dbfaaf193aa9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-05-08 at 23:14 +0000, Nikunj Kela wrote:
> Some of the broken NICs don't have EEPROM programmed correctly. It
> results
> in probe to fail. This change adds a module parameter that can be
> used to
> ignore nvm checksum validation.
> 
> Cc: xe-linux-external at cisco.com
> Signed-off-by: Nikunj Kela <nkela@cisco.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 28
> ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

NAK for two reasons.  First, module parameters are not desirable
because their individual to one driver and a global solution should be
found so that all networking device drivers can use the solution.  This
will keep the interface to change/setup/modify networking drivers
consistent for all drivers.

Second and more importantly, if your NIC is broken, fix it.  Do not try
and create a software workaround so that you can continue to use a
broken NIC.  There are methods/tools available to properly reprogram
the EEPROM on a NIC, which is the right solution for your issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190516/594c375b/attachment.asc>
