From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 19:46:24 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/4] e1000e: Remove unreachable code
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E25FCE@ORSMSX101.amr.corp.intel.com>
References: <1447113021-1611-1-git-send-email-bpoirier@suse.com>,
 <1447113021-1611-2-git-send-email-bpoirier@suse.com>,
 <309B89C4C689E141A5FF6A0C5FB2118B81E25FCE@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E2744C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [netdev-owner at vger.kernel.org] on behalf of Benjamin Poirier [bpoirier at suse.com]
> Sent: Monday, November 09, 2015 3:50 PM
> To: Kirsher, Jeffrey T
> Cc: Alexander Duyck; Frank Steiner; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH v3 1/4] e1000e: Remove unreachable code
>
> msi-x interrupts are not shared so there's no need to check if the
> interrupt was really from this adapter.
>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
>  1 file changed, 6 deletions(-)
>

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
