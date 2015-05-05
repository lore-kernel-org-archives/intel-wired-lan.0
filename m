From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 5 May 2015 17:25:56 +0000
Subject: [Intel-wired-lan] [PATCH v1 net-next 2/2] igb: support
	SIOCSMIIREG
In-Reply-To: <1429302240-654-2-git-send-email-jtoppins@cumulusnetworks.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1429302240-654-2-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DBE9D2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jonathan Toppins
> Sent: Friday, April 17, 2015 1:24 PM
> To: Kirsher, Jeffrey T
> Cc: Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald
> C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; gospo at cumulusnetworks.com;
> shm at cumulusnetworks.com; Alan Liebthal
> Subject: [PATCH v1 net-next 2/2] igb: support SIOCSMIIREG
> 
> From: Alan Liebthal <alanl@cumulusnetworks.com>
> 
> Support setting the MII register via SIOCSMIIREG.
> 
> Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

