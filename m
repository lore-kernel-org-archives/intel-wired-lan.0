From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 12 Apr 2022 11:29:48 -0700
Subject: [Intel-wired-lan] [PATCH] ice: wait for EMP reset after
 firmware flash
In-Reply-To: <20220412160856.1027597-1-alexandr.lobakin@intel.com>
References: <20220412102753.670867-1-poros@redhat.com>
 <20220412160856.1027597-1-alexandr.lobakin@intel.com>
Message-ID: <d1d4b35e-2fcd-fa30-4985-5ae58ea6d53f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/12/2022 9:08 AM, Alexander Lobakin wrote:

>> +#define ICE_EMP_RESET_SLEEP 5000
> 
> Ooof, 5 sec is a lot! Is there any way to poll the device readiness?
> Does it really need the whole 5 sec?

The problem with resets is usually you don't want to disturb the 
hardware with PCIe pokes while it's resetting. In this case, this code 
only runs if it was indicated by the update status that the firmware 
could internally reset itself to pick up new updates, avoiding a reboot.

Yes the five seconds is less than ideal, but it was the value we found 
that offered the most stability / likelihood of reset completing. In 
this case the 5 seconds is a tradeoff vs a reboot.

Thank you Ivan for chasing down this bug!


