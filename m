From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Oct 2019 00:56:50 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for S0ix
In-Reply-To: <20190916065240.41486-1-sasha.neftin@intel.com>
References: <20190916065240.41486-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714C814@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Sasha Neftin
> Sent: Sunday, September 15, 2019 11:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for S0ix
> 
> Implement flow for S0ix support. Modern SoCs support S0ix low power
> states during idle periods, which are sub-states of ACPI S0 that increase
> power saving while supporting an instant-on experience for providing
> lower latency that ACPI S0. The S0ix states shut off parts of the SoC
> when they are not in use, while still maintaning optimal performance.
> This patch add support for S0ix started from an Ice Lake platform.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 186
> +++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/e1000e/regs.h   |   4 +
>  2 files changed, 190 insertions(+)

I do not yet have access to an Ice lake platform but this does not seem to harm any of my regression systems, so...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
