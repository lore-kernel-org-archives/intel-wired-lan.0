From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Apr 2018 02:20:15 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 06/10] igb: Allow
 filters to be added for the local MAC address
In-Reply-To: <20180410174959.18757-7-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-7-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83A1CE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Vinicius Costa Gomes
> Sent: Tuesday, April 10, 2018 10:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: [Intel-wired-lan] [next-queue PATCH v7 06/10] igb: Allow filters to
> be added for the local MAC address
> 
> Users expect that when adding a steering filter for the local MAC
> address, that all the traffic directed to that address will go to some
> queue.
> 
> Currently, it's not possible to configure entries in the "in use"
> state, which is the normal state of the local MAC address entry (it is
> the default), this patch allows to override the steering configuration
> of "in use" entries, if the filter to be added match the address and
> address type (source or destination) of an existing entry.
> 
> There is a bit of a special handling for entries referring to the
> local MAC address, when they are removed, only the steering
> configuration is reset.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 40 ++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)

Tested by: Aaron Brown <aaron.f.brown@intel.com>
