From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 00:45:17 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add GSO partial support
In-Reply-To: <20200210070415.23679-1-sasha.neftin@intel.com>
References: <20200210070415.23679-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9720142C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Sunday, February 9, 2020 11:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add GSO partial support
> 
> Partial generic segmentation offload is a hybrid between TSO and GSO.
> What is effectively does is take advantage of certain traits of TCP and
> tunnels so that instead of having to rewrite the packet headers for each
> segment only in the inner-most transport header and possible the outer-
> most
> network header need to be updated.
> This allows devices that do not support tunnel offload or tunnels
> offloads with checksum to still make use of segmentation.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
