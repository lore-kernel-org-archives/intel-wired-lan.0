From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Apr 2018 02:18:11 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 03/10] igb: Enable the
 hardware traffic class feature bit for igb models
In-Reply-To: <20180410174959.18757-4-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-4-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83A18E@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue PATCH v7 03/10] igb: Enable the
> hardware traffic class feature bit for igb models
> 
> This will allow functionality depending on the hardware being traffic
> class aware to work. In particular the tc-flower offloading checks
> verifies that this bit is set.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested by: Aaron Brown <aaron.f.brown@intel.com>
