From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 19:58:31 +0000
Subject: [Intel-wired-lan] [PATCH 01/12] igc: Remove duplicate code in
 MAC filtering logic
In-Reply-To: <20200318230102.36952-2-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-2-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DD7C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 01/12] igc: Remove duplicate code in MAC
> filtering logic
> 
> This patch does a code refactoring in the MAC address filtering logic to
> get rid of some duplicate code.
> 
> IGC driver has two functions to add MAC address filters that are pretty
> much the same: igc_add_mac_filter() and igc_add_mac_filter_flags(). The
> only difference is that the latter allows the callee to specify the
> 'flags' parameter while the former has it hardcoded as zero. The same
> rationale applies to filter deletion counterparts.
> 
> So this patch refactors igc_add_mac_filter() and igc_del_mac_filter() so
> they handle the 'flags' parameters, removes the _flags() functions, and
> fixes callees accordingly.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 112 +++-------------------
>  1 file changed, 13 insertions(+), 99 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
