From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:21:54 +0000
Subject: [Intel-wired-lan] [PATCH S31 08/15] ice: save PCI state in probe
In-Reply-To: <20191009140953.14087-8-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-8-anthony.l.nguyen@intel.com>
Message-ID: <00098d439a284356a2a446b5a56a322c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 08/15] ice: save PCI state in probe
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Save state to correct recovery memory and I/O BARs address after PCI bus
> reset. Without this after reset kernel can't read device registers.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


