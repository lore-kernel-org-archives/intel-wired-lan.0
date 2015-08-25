From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Tue, 25 Aug 2015 21:06:41 +0000
Subject: [Intel-wired-lan] [next-queue v2] fm10k: Correct MTU for
	jumbo	frames
In-Reply-To: <1440535751-12074-1-git-send-email-jacob.e.keller@intel.com>
References: <1440535751-12074-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847BA68095@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, August 25, 2015 1:49 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue v2] fm10k: Correct MTU for jumbo
> frames
> 
> Based on hardware testing, the host interface supports up to 15368 bytes
> as the maximum frame size. To determine the correct MTU, we subtract 8
> for the internal switch tag, 14 for the L2 header, and 4 for the
> appended FCS header, resulting in 15342 bytes of payload for our maximum
> MTU on jumbo frames.
> 
> Signed-off-by: Matthew Vick <matthew.vick@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Bruce Allan <bruce.w.allan@intel.com>
