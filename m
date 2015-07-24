From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 24 Jul 2015 07:15:15 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix EEE in Sx implementation
In-Reply-To: <1436190480-20941-1-git-send-email-raanan.avargil@intel.com>
References: <1436190480-20941-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AC50D6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Raanan Avargil
> Sent: Monday, July 06, 2015 6:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: Fix EEE in Sx implementation
> 
> This patch implements the EEE in Sx code so that it only applies to parts
> that support EEE in Sx (as opposed to all parts that support EEE).
> It also uses the existing eee_advert and eee_lp_abiliity to set just the
> bits
> (100/1000) that should be set.
> 
> Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 26
> ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
