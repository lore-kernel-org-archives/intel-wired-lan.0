From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 18 Jul 2015 01:47:59 +0000
Subject: [Intel-wired-lan] [PATCH] igb: use ARRAY_SIZE to replace
 calculating sizeof(a)/sizeof(a[0])
In-Reply-To: <20150630221655.24543.21613.stgit@htfujina-fc.jf.intel.com>
References: <20150630221655.24543.21613.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81A906F3@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Tuesday, June 30, 2015 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: use ARRAY_SIZE to replace
> calculating sizeof(a)/sizeof(a[0])
> 
> Use the ARRAY_SIZE macro rather than calculating sizeof(a)/sizeof(a[0]).
> Also directly replace the code rather than using an unnecessary define.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> Reported-by: Maninder Singh <maninder1.s@samsung.com>
> Reported-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_phy.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

This is throwing a checkpatch over 80 character warning:
-----------------------------------
WARNING: line over 80 characters
#79: FILE: drivers/net/ethernet/intel/igb/e1000_phy.c:1860:
+               if ((cur_agc_index >= ARRAY_SIZE(e1000_igp_2_cable_length_table)) ||
-----------------------------------
But I don't really see how to shorten it so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
