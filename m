From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 8 Oct 2019 23:17:34 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Add rx checksum support
In-Reply-To: <20191003104305.42463-1-sasha.neftin@intel.com>
References: <20191003104305.42463-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714937B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Sasha Neftin
> Sent: Thursday, October 3, 2019 3:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Add rx checksum support
> 
> Extend the socket buffer field process and add rx checksum functionality
> Minor: fix indentation with tab instead of spaces.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  5 +++-
>  drivers/net/ethernet/intel/igc/igc_main.c    | 43
> ++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
