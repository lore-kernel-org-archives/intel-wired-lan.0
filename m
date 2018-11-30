From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 30 Nov 2018 03:16:47 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v1 1/2] igb: Change
 RXPBSIZE size when setting Qav mode
In-Reply-To: <20181117001924.1525-1-vinicius.gomes@intel.com>
References: <20181117001924.1525-1-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965C9FAF@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> Sent: Friday, November 16, 2018 4:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sanchez-Palencia, Jesus <jesus.sanchez-palencia@intel.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org;
> jesus.s.palencia at gmail.com
> Subject: [next-queue PATCH v1 1/2] igb: Change RXPBSIZE size when setting
> Qav mode
> 
> From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> 
> Section 4.5.9 of the datasheet says that the total size of all packet
> buffers combined (TxPB 0 + 1 + 2 + 3 + RxPB + BMC2OS + OS2BMC) must not
> exceed 60KB. Today we are configuring a total of 62KB, so reduce the
> RxPB from 32KB to 30KB in order to respect that.
> 
> The choice of changing RxPBSIZE here is mainly because it seems more
> correct to give more priority to the transmit packet buffers over the
> receiver ones when running in Qav mode. Also, the BMC2OS and OS2BMC
> sizes are already too short.
> 
> Signed-off-by: Jesus Sanchez-Palencia <jesus.s.palencia@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h | 1 +
>  drivers/net/ethernet/intel/igb/igb_main.c      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

